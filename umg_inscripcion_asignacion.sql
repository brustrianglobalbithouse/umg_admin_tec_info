-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-04-2023 a las 22:34:43
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `umg_inscripcion_asignacion`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ia_alumno`
--

CREATE TABLE `ia_alumno` (
  `Id_Alumno` int(11) NOT NULL,
  `Nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Apellido` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Telefono` varchar(12) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Email` varchar(35) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Direccion` varchar(40) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Fecha_Nacimiento` date DEFAULT NULL,
  `Id_Sede` int(11) DEFAULT NULL,
  `Id_Carrera` int(11) DEFAULT NULL,
  `Id_EncaPensum` int(11) DEFAULT NULL,
  `Id_Jornada` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ia_asignacion`
--

CREATE TABLE `ia_asignacion` (
  `Id_Asignacion` int(11) NOT NULL,
  `Fecha` date DEFAULT NULL,
  `Id_Alumno` int(11) DEFAULT NULL,
  `Id_Curso` int(11) DEFAULT NULL,
  `Observaciones` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `Anulado` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ia_carrera`
--

CREATE TABLE `ia_carrera` (
  `Id_Carrera` int(11) NOT NULL,
  `Descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `Id_Facultad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ia_curso`
--

CREATE TABLE `ia_curso` (
  `Id_Curso` int(11) NOT NULL,
  `Descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `Id_Carrera` int(11) DEFAULT NULL,
  `Prerrequisito` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ia_departamento`
--

CREATE TABLE `ia_departamento` (
  `Id_Departamento` int(11) NOT NULL,
  `Descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ia_detallepensum`
--

CREATE TABLE `ia_detallepensum` (
  `Id_DetallePensum` int(11) NOT NULL,
  `Id_EncaPensum` int(11) DEFAULT NULL,
  `Id_Curso` int(11) DEFAULT NULL,
  `Ciclo` varchar(5) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ia_encapensum`
--

CREATE TABLE `ia_encapensum` (
  `Id_EncaPensum` int(11) NOT NULL,
  `Descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `Id_Carrera` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ia_facultad`
--

CREATE TABLE `ia_facultad` (
  `Id_Facultad` int(11) NOT NULL,
  `Descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `Telefono` varchar(12) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Decano` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ia_historialcurso`
--

CREATE TABLE `ia_historialcurso` (
  `Id_HistorialCurso` int(11) NOT NULL,
  `Id_Alumno` int(11) DEFAULT NULL,
  `Id_Curso` int(11) DEFAULT NULL,
  `Nota` int(11) DEFAULT NULL,
  `Fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ia_inscripcion`
--

CREATE TABLE `ia_inscripcion` (
  `Id_Inscripcion` int(11) NOT NULL,
  `Fecha` date DEFAULT NULL,
  `Id_Alumno` int(11) DEFAULT NULL,
  `Boleta_Pago` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ia_jornada`
--

CREATE TABLE `ia_jornada` (
  `Id_Jornada` int(11) NOT NULL,
  `Descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ia_municipio`
--

CREATE TABLE `ia_municipio` (
  `Id_Municipio` int(11) NOT NULL,
  `Descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `Id_Departamento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ia_sede`
--

CREATE TABLE `ia_sede` (
  `Id_Sede` int(11) NOT NULL,
  `Descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `Id_Municipio` int(11) DEFAULT NULL,
  `Direccion` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Telefono` varchar(12) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ia_sedecarrera`
--

CREATE TABLE `ia_sedecarrera` (
  `Id_SedeCarrera` int(11) NOT NULL,
  `Id_Sede` int(11) DEFAULT NULL,
  `Id_Carrera` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ia_alumno`
--
ALTER TABLE `ia_alumno`
  ADD PRIMARY KEY (`Id_Alumno`),
  ADD KEY `fk_sede_en_alumno` (`Id_Sede`),
  ADD KEY `fk_carrera_en_alumno` (`Id_Carrera`),
  ADD KEY `fk_encapensum_en_alumno` (`Id_EncaPensum`),
  ADD KEY `fk_jornada_en_alumno` (`Id_Jornada`);

--
-- Indices de la tabla `ia_asignacion`
--
ALTER TABLE `ia_asignacion`
  ADD PRIMARY KEY (`Id_Asignacion`),
  ADD KEY `fk_alumno_en_asignacion` (`Id_Alumno`),
  ADD KEY `fk_curso_en_asignacion` (`Id_Curso`);

--
-- Indices de la tabla `ia_carrera`
--
ALTER TABLE `ia_carrera`
  ADD PRIMARY KEY (`Id_Carrera`),
  ADD KEY `fk_facultad_en_carrera` (`Id_Facultad`);

--
-- Indices de la tabla `ia_curso`
--
ALTER TABLE `ia_curso`
  ADD PRIMARY KEY (`Id_Curso`),
  ADD KEY `fk_carrera_en_curso` (`Id_Carrera`);

--
-- Indices de la tabla `ia_departamento`
--
ALTER TABLE `ia_departamento`
  ADD PRIMARY KEY (`Id_Departamento`);

--
-- Indices de la tabla `ia_detallepensum`
--
ALTER TABLE `ia_detallepensum`
  ADD PRIMARY KEY (`Id_DetallePensum`),
  ADD KEY `fk_encapensum_en_detallepensum` (`Id_EncaPensum`),
  ADD KEY `fk_curso_en_detallepensum` (`Id_Curso`);

--
-- Indices de la tabla `ia_encapensum`
--
ALTER TABLE `ia_encapensum`
  ADD PRIMARY KEY (`Id_EncaPensum`),
  ADD KEY `fk_carrera_en_encapensum` (`Id_Carrera`);

--
-- Indices de la tabla `ia_facultad`
--
ALTER TABLE `ia_facultad`
  ADD PRIMARY KEY (`Id_Facultad`);

--
-- Indices de la tabla `ia_historialcurso`
--
ALTER TABLE `ia_historialcurso`
  ADD PRIMARY KEY (`Id_HistorialCurso`),
  ADD KEY `fk_alumno_en_historialcurso` (`Id_Alumno`),
  ADD KEY `fk_curso_en_historialcurso` (`Id_Curso`);

--
-- Indices de la tabla `ia_inscripcion`
--
ALTER TABLE `ia_inscripcion`
  ADD PRIMARY KEY (`Id_Inscripcion`),
  ADD KEY `fk_alumno_en_inscripcion` (`Id_Alumno`);

--
-- Indices de la tabla `ia_jornada`
--
ALTER TABLE `ia_jornada`
  ADD PRIMARY KEY (`Id_Jornada`);

--
-- Indices de la tabla `ia_municipio`
--
ALTER TABLE `ia_municipio`
  ADD PRIMARY KEY (`Id_Municipio`),
  ADD KEY `fk_departamento_en_municipio` (`Id_Departamento`);

--
-- Indices de la tabla `ia_sede`
--
ALTER TABLE `ia_sede`
  ADD PRIMARY KEY (`Id_Sede`),
  ADD KEY `fk_municipio_en_sede` (`Id_Municipio`);

--
-- Indices de la tabla `ia_sedecarrera`
--
ALTER TABLE `ia_sedecarrera`
  ADD PRIMARY KEY (`Id_SedeCarrera`),
  ADD KEY `fk_sede_en_sedecarrera` (`Id_Sede`),
  ADD KEY `fk_carrera_en_sedecarrera` (`Id_Carrera`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ia_alumno`
--
ALTER TABLE `ia_alumno`
  ADD CONSTRAINT `fk_carrera_en_alumno` FOREIGN KEY (`Id_Carrera`) REFERENCES `ia_carrera` (`Id_Carrera`),
  ADD CONSTRAINT `fk_encapensum_en_alumno` FOREIGN KEY (`Id_EncaPensum`) REFERENCES `ia_encapensum` (`Id_EncaPensum`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_jornada_en_alumno` FOREIGN KEY (`Id_Jornada`) REFERENCES `ia_jornada` (`Id_Jornada`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sede_en_alumno` FOREIGN KEY (`Id_Sede`) REFERENCES `ia_sede` (`Id_Sede`);

--
-- Filtros para la tabla `ia_asignacion`
--
ALTER TABLE `ia_asignacion`
  ADD CONSTRAINT `fk_alumno_en_asignacion` FOREIGN KEY (`Id_Alumno`) REFERENCES `ia_alumno` (`Id_Alumno`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_curso_en_asignacion` FOREIGN KEY (`Id_Curso`) REFERENCES `ia_curso` (`Id_Curso`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ia_carrera`
--
ALTER TABLE `ia_carrera`
  ADD CONSTRAINT `fk_facultad_en_carrera` FOREIGN KEY (`Id_Facultad`) REFERENCES `ia_facultad` (`Id_Facultad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ia_curso`
--
ALTER TABLE `ia_curso`
  ADD CONSTRAINT `fk_carrera_en_curso` FOREIGN KEY (`Id_Carrera`) REFERENCES `ia_carrera` (`Id_Carrera`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ia_detallepensum`
--
ALTER TABLE `ia_detallepensum`
  ADD CONSTRAINT `fk_curso_en_detallepensum` FOREIGN KEY (`Id_Curso`) REFERENCES `ia_curso` (`Id_Curso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_encapensum_en_detallepensum` FOREIGN KEY (`Id_EncaPensum`) REFERENCES `ia_encapensum` (`Id_EncaPensum`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ia_encapensum`
--
ALTER TABLE `ia_encapensum`
  ADD CONSTRAINT `fk_carrera_en_encapensum` FOREIGN KEY (`Id_Carrera`) REFERENCES `ia_carrera` (`Id_Carrera`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ia_historialcurso`
--
ALTER TABLE `ia_historialcurso`
  ADD CONSTRAINT `fk_alumno_en_historialcurso` FOREIGN KEY (`Id_Alumno`) REFERENCES `ia_alumno` (`Id_Alumno`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_curso_en_historialcurso` FOREIGN KEY (`Id_Curso`) REFERENCES `ia_curso` (`Id_Curso`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ia_inscripcion`
--
ALTER TABLE `ia_inscripcion`
  ADD CONSTRAINT `fk_alumno_en_inscripcion` FOREIGN KEY (`Id_Alumno`) REFERENCES `ia_alumno` (`Id_Alumno`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ia_municipio`
--
ALTER TABLE `ia_municipio`
  ADD CONSTRAINT `fk_departamento_en_municipio` FOREIGN KEY (`Id_Departamento`) REFERENCES `ia_departamento` (`Id_Departamento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ia_sede`
--
ALTER TABLE `ia_sede`
  ADD CONSTRAINT `fk_municipio_en_sede` FOREIGN KEY (`Id_Municipio`) REFERENCES `ia_municipio` (`Id_Municipio`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ia_sedecarrera`
--
ALTER TABLE `ia_sedecarrera`
  ADD CONSTRAINT `fk_carrera_en_sedecarrera` FOREIGN KEY (`Id_Carrera`) REFERENCES `ia_carrera` (`Id_Carrera`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sede_en_sedecarrera` FOREIGN KEY (`Id_Sede`) REFERENCES `ia_sede` (`Id_Sede`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
