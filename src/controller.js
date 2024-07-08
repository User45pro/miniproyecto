import fs from 'fs';
import path from 'path';
import { parse } from 'csv-parse';
import { pool } from './db.js';
import { stringify } from 'csv-stringify';

export const getUsers = async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM usuarios');
    res.json(rows);
  } catch (err) {
    console.error('Error obteniendo usuarios:', err);
    res.status(500).json({ error: 'Error obteniendo usuarios' });
  }
};

export const exportUsers = async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM usuarios');
    const csvFilePath = path.join(process.cwd(), 'usuarios.csv');
    const csvStream = stringify({ header: true, columns: ['ID', 'Nombres', 'Apellidos', 'Direccion', 'Correo', 'DNI', 'Edad', 'Fecha_Creacion', 'Telefono'] });

    const writeStream = fs.createWriteStream(csvFilePath);
    csvStream.pipe(writeStream);

    rows.forEach(row => {
      csvStream.write({
        ID: row.usuario_id,
        Nombres: row.nombre,
        Apellidos: row.apellidos,
        Direccion: row.direccion,
        Correo: row.email,
        DNI: row.dni,
        Edad: row.edad,
        Fecha_Creacion: row.fecha_creacion,
        Telefono: row.telefono
      });
    });

    csvStream.end();

    writeStream.on('finish', () => {
      res.json({ message: 'Datos exportados a usuarios.csv' });
    });

    writeStream.on('error', err => {
      console.error('Error exportando datos:', err);
      res.status(500).json({ error: 'Error exportando datos' });
    });
  } catch (err) {
    console.error('Error exportando usuarios:', err);
    res.status(500).json({ error: 'Error exportando usuarios' });
  }
};

export const importUsers = async (req, res) => {
  const csvFilePath = path.join(process.cwd(), 'usuarios.csv');

  if (!fs.existsSync(csvFilePath)) {
    return res.status(400).json({ error: 'Archivo usuarios.csv no encontrado' });
  }

  const parser = fs.createReadStream(csvFilePath).pipe(parse({ columns: true }));
  const users = [];

  for await (const row of parser) {
    if (!row.ID || !row.Nombres || !row.Apellidos || !row.Direccion || !row.Correo || !row.DNI || !row.Edad || !row.Fecha_Creacion || !row.Telefono) {
      return res.status(400).json({ error: 'Formato de datos incorrecto' });
    }
    users.push(row);
  }

  for (const user of users) {
    try {
      const [existingUser] = await pool.query('SELECT * FROM usuarios WHERE usuario_id = ? OR email = ?', [user.ID, user.Correo]);

      if (existingUser.length > 0) {
        console.log(`Usuario con ID ${user.ID} o correo ${user.Correo} ya existe. Omitiendo.`);
        continue;
      }

      await pool.query('INSERT INTO usuarios (usuario_id, nombre, apellidos, direccion, email, dni, edad, fecha_creacion, telefono) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', 
      [user.ID, user.Nombres, user.Apellidos, user.Direccion, user.Correo, user.DNI, user.Edad, user.Fecha_Creacion, user.Telefono]);

    } catch (err) {
      console.error(`Error al insertar usuario con ID ${user.ID}:`, err);
    }
  }

  res.json({ message: 'Datos importados desde usuarios.csv' });
};
