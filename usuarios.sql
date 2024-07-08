-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-07-2024 a las 10:01:52
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `nivel2`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `usuario_id` int(11) NOT NULL,
  `nombre` varchar(150) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `password` varchar(250) DEFAULT NULL,
  `direccion` varchar(250) DEFAULT NULL,
  `apellidos` varchar(150) DEFAULT NULL,
  `dni` varchar(20) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`usuario_id`, `nombre`, `email`, `password`, `direccion`, `apellidos`, `dni`, `edad`, `fecha_creacion`, `telefono`) VALUES
(1, 'Pablo', 'pablo@gmail.com', 'pablo123', 'Avenida S/N', 'Doe', '12345678', 30, '2024-03-01', '123-456-7890'),
(2, 'Esteban', 'esteban@gmail.com', 'esteban123', 'Avenida S/N', 'Smith', '87654321', 25, '2024-03-01', '987-654-3210'),
(3, 'Manuel', 'manuel@gmail.com', 'manuel123', 'Avenida S/N', 'Johnson', '13579246', 35, '2024-03-01', '456-789-0123'),
(4, 'Kiara', 'kiara@gmail.com', 'kiara123', 'Avenida S/N', 'Williams', '24681357', 28, '2024-03-01', '789-012-3456'),
(5, 'Carlos', 'carlos@example.com', 'carlos123', 'Calle Falsa 456', 'Brown', '35715984', 32, '2024-03-01', '012-345-6789'),
(6, 'Lucia', 'lucia@example.com', 'lucia123', 'Avenida Principal 789', 'Jones', '95135748', 27, '2024-03-01', '345-678-9012'),
(7, 'Miguel', 'miguel@example.com', 'miguel123', 'Plaza Central 101', 'Garcia', '15975368', 29, '2024-03-01', '678-901-2345');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usuario_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usuario_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
