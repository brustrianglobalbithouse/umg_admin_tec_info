-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-04-2023 a las 07:09:00
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
-- Base de datos: `umg_punto_venta`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pv_clasificador`
--

CREATE TABLE `pv_clasificador` (
  `Id_Clasificador` int(11) NOT NULL,
  `Descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pv_cliente`
--

CREATE TABLE `pv_cliente` (
  `Id_Cliente` int(11) NOT NULL,
  `Nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Apellido` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Direccion` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Telefono` varchar(12) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Email` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pv_detallefactura`
--

CREATE TABLE `pv_detallefactura` (
  `Id_DetalleFactura` int(11) NOT NULL,
  `Id_EncaFactura` int(11) DEFAULT NULL,
  `Id_Producto` int(11) DEFAULT NULL,
  `Cantidad` mediumint(9) DEFAULT NULL,
  `Precio` float(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pv_detalleformapago`
--

CREATE TABLE `pv_detalleformapago` (
  `Id_DetalleFormaPago` int(11) NOT NULL,
  `Id_EncaFactura` int(11) DEFAULT NULL,
  `Id_FormaPagoEntidad` int(11) DEFAULT NULL,
  `Total` float(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pv_detallemovimiento`
--

CREATE TABLE `pv_detallemovimiento` (
  `Id_DetalleMovimiento` int(11) NOT NULL,
  `Id_EncaMovimiento` int(11) DEFAULT NULL,
  `Id_Producto` int(11) DEFAULT NULL,
  `Cantidad` smallint(6) DEFAULT NULL,
  `Costo` float(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pv_encafactura`
--

CREATE TABLE `pv_encafactura` (
  `Id_EncaFactura` int(11) NOT NULL,
  `Numero` mediumint(9) DEFAULT NULL,
  `Serie` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `Id_Cliente` int(11) DEFAULT NULL,
  `Id_Vendedor` int(11) DEFAULT NULL,
  `Subtotal` float(10,2) DEFAULT NULL,
  `Cargo` float(8,2) DEFAULT NULL,
  `Descuento` float(6,2) DEFAULT NULL,
  `Observaciones` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `Flag_Anulado` tinyint(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pv_encamovimiento`
--

CREATE TABLE `pv_encamovimiento` (
  `Id_EncaMovimiento` int(11) NOT NULL,
  `Numero` mediumint(9) DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `Id_Vendedor` int(11) DEFAULT NULL,
  `Observaciones` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `Id_Transaccion` int(11) DEFAULT NULL,
  `Flag_anulado` tinyint(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pv_entidad`
--

CREATE TABLE `pv_entidad` (
  `Id_Entidad` int(11) NOT NULL,
  `Descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pv_formapago`
--

CREATE TABLE `pv_formapago` (
  `Id_FormaPago` int(11) NOT NULL,
  `Descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `Cargo` float(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pv_formapagoentidad`
--

CREATE TABLE `pv_formapagoentidad` (
  `Id_FormaPagoEntidad` int(11) NOT NULL,
  `Id_FormaPago` int(11) DEFAULT NULL,
  `Id_Entidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pv_marca`
--

CREATE TABLE `pv_marca` (
  `Id_Marca` int(11) NOT NULL,
  `Descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pv_producto`
--

CREATE TABLE `pv_producto` (
  `Id_Producto` int(11) NOT NULL,
  `Descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `Precio` float(8,2) DEFAULT NULL,
  `Existencia` mediumint(9) DEFAULT NULL,
  `Costo` float(8,2) DEFAULT NULL,
  `Fecha_Vencimiento` date DEFAULT NULL,
  `Id_Marca` int(11) DEFAULT NULL,
  `Id_Clasificador` int(11) DEFAULT NULL,
  `Id_Ubicacion` int(11) DEFAULT NULL,
  `Id_Tienda` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pv_tienda`
--

CREATE TABLE `pv_tienda` (
  `Id_Tienda` int(11) NOT NULL,
  `Descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `Direccion` varchar(150) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Telefono` varchar(12) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Nit` varchar(12) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Encargado` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pv_transaccion`
--

CREATE TABLE `pv_transaccion` (
  `Id_Transaccion` int(11) NOT NULL,
  `Descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `Sigla` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Tipo_Transaccion` varchar(150) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pv_ubicacion`
--

CREATE TABLE `pv_ubicacion` (
  `Id_Ubicacion` int(11) NOT NULL,
  `Descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pv_vendedor`
--

CREATE TABLE `pv_vendedor` (
  `Id_Vendedor` int(11) NOT NULL,
  `Nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Apellido` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Direccion` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Telefono` varchar(12) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Fecha_Nacimiento` date DEFAULT NULL,
  `Comision` float(6,2) DEFAULT NULL,
  `Id_Tienda` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pv_clasificador`
--
ALTER TABLE `pv_clasificador`
  ADD PRIMARY KEY (`Id_Clasificador`);

--
-- Indices de la tabla `pv_cliente`
--
ALTER TABLE `pv_cliente`
  ADD PRIMARY KEY (`Id_Cliente`);

--
-- Indices de la tabla `pv_detallefactura`
--
ALTER TABLE `pv_detallefactura`
  ADD PRIMARY KEY (`Id_DetalleFactura`),
  ADD KEY `fk_encafactura_en_detallefactura` (`Id_EncaFactura`),
  ADD KEY `fk_producto_en_detallefactura` (`Id_Producto`);

--
-- Indices de la tabla `pv_detalleformapago`
--
ALTER TABLE `pv_detalleformapago`
  ADD PRIMARY KEY (`Id_DetalleFormaPago`),
  ADD KEY `fk_encafactura_en_detalleformapago` (`Id_EncaFactura`),
  ADD KEY `fk_formapagoentidad_en_detalleformapago` (`Id_FormaPagoEntidad`);

--
-- Indices de la tabla `pv_detallemovimiento`
--
ALTER TABLE `pv_detallemovimiento`
  ADD PRIMARY KEY (`Id_DetalleMovimiento`),
  ADD KEY `fk_encamovimiento_en_detallemovimiento` (`Id_EncaMovimiento`),
  ADD KEY `fk_producto_en_detallemovimiento` (`Id_Producto`);

--
-- Indices de la tabla `pv_encafactura`
--
ALTER TABLE `pv_encafactura`
  ADD PRIMARY KEY (`Id_EncaFactura`),
  ADD KEY `fk_cliente_en_encafactura` (`Id_Cliente`),
  ADD KEY `fk_vendedor_en_encafactura` (`Id_Vendedor`);

--
-- Indices de la tabla `pv_encamovimiento`
--
ALTER TABLE `pv_encamovimiento`
  ADD PRIMARY KEY (`Id_EncaMovimiento`),
  ADD KEY `fk_vendedor_en_encamovimiento` (`Id_Vendedor`),
  ADD KEY `fk_transaccion_en_encamovimiento` (`Id_Transaccion`);

--
-- Indices de la tabla `pv_entidad`
--
ALTER TABLE `pv_entidad`
  ADD PRIMARY KEY (`Id_Entidad`);

--
-- Indices de la tabla `pv_formapago`
--
ALTER TABLE `pv_formapago`
  ADD PRIMARY KEY (`Id_FormaPago`);

--
-- Indices de la tabla `pv_formapagoentidad`
--
ALTER TABLE `pv_formapagoentidad`
  ADD PRIMARY KEY (`Id_FormaPagoEntidad`),
  ADD KEY `fk_formapago_en_formapagoentidad` (`Id_FormaPago`),
  ADD KEY `fk_entidad_en_formapagoentidad` (`Id_Entidad`);

--
-- Indices de la tabla `pv_marca`
--
ALTER TABLE `pv_marca`
  ADD PRIMARY KEY (`Id_Marca`);

--
-- Indices de la tabla `pv_producto`
--
ALTER TABLE `pv_producto`
  ADD PRIMARY KEY (`Id_Producto`),
  ADD KEY `fk_marca_en_producto` (`Id_Marca`),
  ADD KEY `fk_clasificador_en_producto` (`Id_Clasificador`),
  ADD KEY `fk_ubicacion_en_producto` (`Id_Ubicacion`),
  ADD KEY `fk_tienda_en_producto` (`Id_Tienda`);

--
-- Indices de la tabla `pv_tienda`
--
ALTER TABLE `pv_tienda`
  ADD PRIMARY KEY (`Id_Tienda`);

--
-- Indices de la tabla `pv_transaccion`
--
ALTER TABLE `pv_transaccion`
  ADD PRIMARY KEY (`Id_Transaccion`);

--
-- Indices de la tabla `pv_ubicacion`
--
ALTER TABLE `pv_ubicacion`
  ADD PRIMARY KEY (`Id_Ubicacion`);

--
-- Indices de la tabla `pv_vendedor`
--
ALTER TABLE `pv_vendedor`
  ADD PRIMARY KEY (`Id_Vendedor`),
  ADD KEY `fk_tienda_en_vendedor` (`Id_Tienda`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `pv_detallefactura`
--
ALTER TABLE `pv_detallefactura`
  ADD CONSTRAINT `fk_encafactura_en_detallefactura` FOREIGN KEY (`Id_EncaFactura`) REFERENCES `pv_encafactura` (`Id_EncaFactura`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_producto_en_detallefactura` FOREIGN KEY (`Id_Producto`) REFERENCES `pv_producto` (`Id_Producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pv_detalleformapago`
--
ALTER TABLE `pv_detalleformapago`
  ADD CONSTRAINT `fk_encafactura_en_detalleformapago` FOREIGN KEY (`Id_EncaFactura`) REFERENCES `pv_encafactura` (`Id_EncaFactura`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_formapagoentidad_en_detalleformapago` FOREIGN KEY (`Id_FormaPagoEntidad`) REFERENCES `pv_formapagoentidad` (`Id_FormaPagoEntidad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pv_detallemovimiento`
--
ALTER TABLE `pv_detallemovimiento`
  ADD CONSTRAINT `fk_encamovimiento_en_detallemovimiento` FOREIGN KEY (`Id_EncaMovimiento`) REFERENCES `pv_encamovimiento` (`Id_EncaMovimiento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_producto_en_detallemovimiento` FOREIGN KEY (`Id_Producto`) REFERENCES `pv_producto` (`Id_Producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pv_encafactura`
--
ALTER TABLE `pv_encafactura`
  ADD CONSTRAINT `fk_cliente_en_encafactura` FOREIGN KEY (`Id_Cliente`) REFERENCES `pv_cliente` (`Id_Cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_vendedor_en_encafactura` FOREIGN KEY (`Id_Vendedor`) REFERENCES `pv_vendedor` (`Id_Vendedor`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pv_encamovimiento`
--
ALTER TABLE `pv_encamovimiento`
  ADD CONSTRAINT `fk_transaccion_en_encamovimiento` FOREIGN KEY (`Id_Transaccion`) REFERENCES `pv_transaccion` (`Id_Transaccion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_vendedor_en_encamovimiento` FOREIGN KEY (`Id_Vendedor`) REFERENCES `pv_vendedor` (`Id_Vendedor`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pv_formapagoentidad`
--
ALTER TABLE `pv_formapagoentidad`
  ADD CONSTRAINT `fk_entidad_en_formapagoentidad` FOREIGN KEY (`Id_Entidad`) REFERENCES `pv_entidad` (`Id_Entidad`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_formapago_en_formapagoentidad` FOREIGN KEY (`Id_FormaPago`) REFERENCES `pv_formapago` (`Id_FormaPago`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pv_producto`
--
ALTER TABLE `pv_producto`
  ADD CONSTRAINT `fk_clasificador_en_producto` FOREIGN KEY (`Id_Clasificador`) REFERENCES `pv_clasificador` (`Id_Clasificador`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_marca_en_producto` FOREIGN KEY (`Id_Marca`) REFERENCES `pv_marca` (`Id_Marca`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tienda_en_producto` FOREIGN KEY (`Id_Tienda`) REFERENCES `pv_tienda` (`Id_Tienda`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ubicacion_en_producto` FOREIGN KEY (`Id_Ubicacion`) REFERENCES `pv_ubicacion` (`Id_Ubicacion`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pv_vendedor`
--
ALTER TABLE `pv_vendedor`
  ADD CONSTRAINT `fk_tienda_en_vendedor` FOREIGN KEY (`Id_Tienda`) REFERENCES `pv_tienda` (`Id_Tienda`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
