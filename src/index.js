import express from 'express';
import bodyParser from 'body-parser';
import path from 'path';
import { getUsers, exportUsers, importUsers } from './controller.js';

const app = express();
const port = 3000;

// Middleware
app.use(bodyParser.json());

// Rutas
app.get('/api/usuarios', getUsers);
app.get('/api/usuarios/export', exportUsers);
app.post('/api/usuarios/import', importUsers);

// Ruta para la interfaz HTML
app.get('/', (req, res) => {
  res.sendFile(path.join(process.cwd(), 'index.html'));
});

app.listen(port, () => {
  console.log(`Servidor en http://localhost:${port}`);
});
