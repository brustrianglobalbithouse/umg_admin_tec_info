-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-09-2023 a las 21:26:13
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
-- Base de datos: `umg_ferreteria`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERT_ADMIN` (IN `em` VARCHAR(40), IN `ps` VARCHAR(255), IN `tel` VARCHAR(12), IN `fec` DATE, IN `ft` MEDIUMBLOB, IN `rl` TINYINT(4))   INSERT INTO usuario_admin (email, password, telefono, fecha_nacimiento, foto, rol, estado) VALUES (em, ps, tel, fec, ft, rl, 0)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERT_CAT` (IN `nm` VARCHAR(60), IN `ds` VARCHAR(255), IN `ic` MEDIUMBLOB)   INSERT INTO categoria (nombre, descripcion, icono) VALUES (nm, ds, ic)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERT_CLIENTE` (IN `nm` VARCHAR(40), IN `em` VARCHAR(40), IN `ps` INT(255), IN `tel` INT(12), IN `fec` DATE)   INSERT INTO cliente (nombre, email, password, telefono, fecha_nacimiento, estado) VALUES (nm, em, ps, tel, fec, 0)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERT_MARCA` (IN `nm` VARCHAR(60), IN `ds` VARCHAR(255), IN `ic` MEDIUMBLOB)   INSERT INTO marca (nombre, descripcion, icono) VALUES (nm, ds, ic)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERT_PRODUCTO` (IN `nb` VARCHAR(255), IN `ds` TEXT, IN `ex` INT, IN `pr` DOUBLE(8,2), IN `mc` INT)   INSERT INTO producto (nombre, descripcion, existencia, precio, descuento, estado, id_marca) VALUES (nb, ds, ex, pr, NULL, 0, mc)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERT_T_ENVIO` (IN `nm` VARCHAR(40), IN `ds` VARCHAR(255), IN `mn` DOUBLE(8,2))   INSERT INTO tipo_envio (nombre, descripcion, monto) VALUES (nm, ds, mn)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERT_T_PAGO` (IN `nm` VARCHAR(40), IN `ds` VARCHAR(255))   INSERT INTO tipo_pago (nombre, descripcion) VALUES (nm, ds)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTE_PRODUCTO` (IN `inicio` DATE, IN `fin` DATE)   SELECT p.nombre AS nombre, p.estado AS estado, SUM(d.cantidad) AS ventas FROM producto p INNER JOIN detalle_pedido d ON p.id_producto = d.id_producto INNER JOIN pedido a ON a.id_pedido = d.id_pedido WHERE a.fecha >= inicio AND a.fecha <= fin AND a.estado = 3 GROUP BY d.id_producto$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `GET_EDAD` (`fecha_nac` DATE) RETURNS INT(11)  RETURN TIMESTAMPDIFF(YEAR, '1998-06-29', CURDATE())$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `icono` mediumblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(12) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `subtotal_carrito` double(8,2) DEFAULT NULL,
  `estado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nombre`, `email`, `password`, `telefono`, `fecha_nacimiento`, `subtotal_carrito`, `estado`) VALUES
(1, 'Cliente 1', 'cliente1@gmail.com', 'asdf', '12345678', '1998-08-16', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_carrito`
--

CREATE TABLE `detalle_carrito` (
  `id_cliente` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_categoria`
--

CREATE TABLE `detalle_categoria` (
  `id_producto` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_movimiento`
--

CREATE TABLE `detalle_movimiento` (
  `id_movimiento` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `detalle_movimiento`
--

INSERT INTO `detalle_movimiento` (`id_movimiento`, `id_producto`, `cantidad`) VALUES
(1, 1, 80);

--
-- Disparadores `detalle_movimiento`
--
DELIMITER $$
CREATE TRIGGER `update_inventario` AFTER INSERT ON `detalle_movimiento` FOR EACH ROW UPDATE producto SET existencia = NEW.cantidad WHERE id_producto = NEW.id_producto
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedido`
--

CREATE TABLE `detalle_pedido` (
  `id_pedido` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(3) NOT NULL,
  `precio` double(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `detalle_pedido`
--

INSERT INTO `detalle_pedido` (`id_pedido`, `id_producto`, `cantidad`, `precio`) VALUES
(1, 1, 5, 10.25),
(1, 2, 10, 123.00);

--
-- Disparadores `detalle_pedido`
--
DELIMITER $$
CREATE TRIGGER `restar_existencia` AFTER INSERT ON `detalle_pedido` FOR EACH ROW UPDATE producto SET existencia = existencia - NEW.cantidad WHERE id_producto = NEW.id_producto
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca`
--

CREATE TABLE `marca` (
  `id_marca` int(11) NOT NULL,
  `nombre` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `icono` mediumblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `marca`
--

INSERT INTO `marca` (`id_marca`, `nombre`, `descripcion`, `icono`) VALUES
(1, 'Corona', 'Marca de pintura', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `meta_producto`
--

CREATE TABLE `meta_producto` (
  `id_meta_producto` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `llave` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodo_pago`
--

CREATE TABLE `metodo_pago` (
  `id_metodo_pago` int(11) NOT NULL,
  `titular` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `num_tarjeta` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_caducidad` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `id_cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimiento`
--

CREATE TABLE `movimiento` (
  `id_movimiento` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `estado` tinyint(2) NOT NULL,
  `id_usuario_admin` int(11) NOT NULL,
  `id_tipo_movimiento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `movimiento`
--

INSERT INTO `movimiento` (`id_movimiento`, `fecha`, `estado`, `id_usuario_admin`, `id_tipo_movimiento`) VALUES
(1, '2023-08-30', 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `id_pedido` int(11) NOT NULL,
  `nit` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `nombre` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(12) COLLATE utf8_spanish_ci NOT NULL,
  `fecha` date NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_ubicacion` int(11) NOT NULL,
  `id_metodo_pago` int(11) DEFAULT NULL,
  `id_tipo_envio` int(11) NOT NULL,
  `id_tipo_pago` int(11) NOT NULL,
  `subtotal` double(8,2) NOT NULL,
  `descuento` double(4,2) DEFAULT NULL,
  `total` double(8,2) NOT NULL,
  `estado` tinyint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`id_pedido`, `nit`, `nombre`, `telefono`, `fecha`, `id_cliente`, `id_ubicacion`, `id_metodo_pago`, `id_tipo_envio`, `id_tipo_pago`, `subtotal`, `descuento`, `total`, `estado`) VALUES
(1, '5987245', 'Bito', '12345678', '2023-09-01', 1, 1, NULL, 1, 1, 50.25, NULL, 50.25, 3);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `pedidos_completados`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `pedidos_completados` (
`id_pedido` int(11)
,`nombre` varchar(40)
,`subtotal` double(8,2)
,`descuento` double(4,2)
,`total` double(8,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `pedidos_pendientes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `pedidos_pendientes` (
`id_pedido` int(11)
,`nombre` varchar(40)
,`telefono` varchar(12)
,`direccion` varchar(255)
,`total` double(8,2)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `existencia` int(11) NOT NULL,
  `alerta_existencia` int(11) NOT NULL DEFAULT 10,
  `precio` double(8,2) NOT NULL,
  `descuento` double(8,2) DEFAULT NULL,
  `estado` tinyint(4) NOT NULL,
  `id_marca` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `existencia`, `alerta_existencia`, `precio`, `descuento`, `estado`, `id_marca`) VALUES
(1, 'Producto 1', 'Este es el producto', 80, 10, 10.25, NULL, 1, NULL),
(2, 'Producto 2', 'Este es el producto 2', 110, 10, 50.99, NULL, 1, NULL),
(5, 'Producto 3', 'Este es el producto 3', 550, 10, 75.25, NULL, 0, 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `productos_encima_de_media`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `productos_encima_de_media` (
`id_producto` int(11)
,`nombre` varchar(255)
,`precio` double(8,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `productos_poca_existencia`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `productos_poca_existencia` (
`id_producto` int(11)
,`nombre` varchar(255)
,`precio` double(8,2)
,`existencia` int(11)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_envio`
--

CREATE TABLE `tipo_envio` (
  `id_tipo_envio` int(11) NOT NULL,
  `nombre` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `monto` double(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipo_envio`
--

INSERT INTO `tipo_envio` (`id_tipo_envio`, `nombre`, `descripcion`, `monto`) VALUES
(1, 'Envío gratis', 'No se cobra envío', 0.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_movimiento`
--

CREATE TABLE `tipo_movimiento` (
  `id_tipo_movimiento` int(11) NOT NULL,
  `nombre` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipo_movimiento`
--

INSERT INTO `tipo_movimiento` (`id_tipo_movimiento`, `nombre`, `descripcion`) VALUES
(1, 'Actualizar inventario', 'Ingreso de nueva mercancía y actualización de existencia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_pago`
--

CREATE TABLE `tipo_pago` (
  `id_tipo_pago` int(11) NOT NULL,
  `nombre` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipo_pago`
--

INSERT INTO `tipo_pago` (`id_tipo_pago`, `nombre`, `descripcion`) VALUES
(1, 'Efectivo', 'Se recibe el dinero al momento de la entrega');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion`
--

CREATE TABLE `ubicacion` (
  `id_ubicacion` int(11) NOT NULL,
  `nombre` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `direccion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `telefono` varchar(12) COLLATE utf8_spanish_ci NOT NULL,
  `nombre_recibe` varchar(40) COLLATE utf8_spanish_ci DEFAULT NULL,
  `id_cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `ubicacion`
--

INSERT INTO `ubicacion` (`id_ubicacion`, `nombre`, `direccion`, `descripcion`, `telefono`, `nombre_recibe`, `id_cliente`) VALUES
(1, 'Casa', '9 calle 23-55 zona 14', 'Casa azul de 3 pisos', '12345678', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_admin`
--

CREATE TABLE `usuario_admin` (
  `id_usuario_admin` int(11) NOT NULL,
  `email` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(12) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `foto` mediumblob DEFAULT NULL,
  `rol` tinyint(4) NOT NULL,
  `estado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario_admin`
--

INSERT INTO `usuario_admin` (`id_usuario_admin`, `email`, `password`, `telefono`, `fecha_nacimiento`, `foto`, `rol`, `estado`) VALUES
(1, 'usuario1@gmail.com', 'asdf', '12345678', '2023-08-09', NULL, 0, 0);

-- --------------------------------------------------------

--
-- Estructura para la vista `pedidos_completados`
--
DROP TABLE IF EXISTS `pedidos_completados`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pedidos_completados`  AS SELECT `pedido`.`id_pedido` AS `id_pedido`, `pedido`.`nombre` AS `nombre`, `pedido`.`subtotal` AS `subtotal`, `pedido`.`descuento` AS `descuento`, `pedido`.`total` AS `total` FROM `pedido` WHERE `pedido`.`estado` = 33  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `pedidos_pendientes`
--
DROP TABLE IF EXISTS `pedidos_pendientes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pedidos_pendientes`  AS SELECT `p`.`id_pedido` AS `id_pedido`, `p`.`nombre` AS `nombre`, `p`.`telefono` AS `telefono`, `u`.`direccion` AS `direccion`, `p`.`total` AS `total` FROM (`pedido` `p` join `ubicacion` `u` on(`p`.`id_ubicacion` = `u`.`id_ubicacion`)) WHERE `p`.`estado` = 33  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `productos_encima_de_media`
--
DROP TABLE IF EXISTS `productos_encima_de_media`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `productos_encima_de_media`  AS SELECT `producto`.`id_producto` AS `id_producto`, `producto`.`nombre` AS `nombre`, `producto`.`precio` AS `precio` FROM `producto` WHERE `producto`.`precio` > (select avg(`producto`.`precio`) from `producto`) AND `producto`.`estado` = 00  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `productos_poca_existencia`
--
DROP TABLE IF EXISTS `productos_poca_existencia`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `productos_poca_existencia`  AS SELECT `producto`.`id_producto` AS `id_producto`, `producto`.`nombre` AS `nombre`, `producto`.`precio` AS `precio`, `producto`.`existencia` AS `existencia` FROM `producto` WHERE `producto`.`existencia` <= `producto`.`alerta_existencia` AND `producto`.`estado` = 00  ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `detalle_carrito`
--
ALTER TABLE `detalle_carrito`
  ADD PRIMARY KEY (`id_cliente`,`id_producto`),
  ADD KEY `fk_producto_en_carrito` (`id_producto`);

--
-- Indices de la tabla `detalle_categoria`
--
ALTER TABLE `detalle_categoria`
  ADD PRIMARY KEY (`id_producto`,`id_categoria`),
  ADD KEY `fk_categoria_en_dproducto` (`id_categoria`);

--
-- Indices de la tabla `detalle_movimiento`
--
ALTER TABLE `detalle_movimiento`
  ADD PRIMARY KEY (`id_movimiento`,`id_producto`),
  ADD KEY `fk_producto_en_dmovimiento` (`id_producto`);

--
-- Indices de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD PRIMARY KEY (`id_pedido`,`id_producto`),
  ADD KEY `fk_producto_en_dpedido` (`id_producto`);

--
-- Indices de la tabla `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`id_marca`);

--
-- Indices de la tabla `meta_producto`
--
ALTER TABLE `meta_producto`
  ADD PRIMARY KEY (`id_meta_producto`),
  ADD KEY `fk_producto_en_mproducto` (`id_producto`);

--
-- Indices de la tabla `metodo_pago`
--
ALTER TABLE `metodo_pago`
  ADD PRIMARY KEY (`id_metodo_pago`),
  ADD KEY `fk_cliente_en_mpago` (`id_cliente`);

--
-- Indices de la tabla `movimiento`
--
ALTER TABLE `movimiento`
  ADD PRIMARY KEY (`id_movimiento`),
  ADD KEY `fk_usuario_admin_en_movimiento` (`id_usuario_admin`),
  ADD KEY `fk_tipo_movimiento_en_movimiento` (`id_tipo_movimiento`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `fk_cliente_en_pedido` (`id_cliente`),
  ADD KEY `fk_ubicacion_en_pedido` (`id_ubicacion`),
  ADD KEY `fk_metodo_pago_en_pedido` (`id_metodo_pago`),
  ADD KEY `fk_tipo_envio_en_pedido` (`id_tipo_envio`),
  ADD KEY `fk_tipo_pago_en_pedido` (`id_tipo_pago`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `fk_marca_en_producto` (`id_marca`);

--
-- Indices de la tabla `tipo_envio`
--
ALTER TABLE `tipo_envio`
  ADD PRIMARY KEY (`id_tipo_envio`);

--
-- Indices de la tabla `tipo_movimiento`
--
ALTER TABLE `tipo_movimiento`
  ADD PRIMARY KEY (`id_tipo_movimiento`);

--
-- Indices de la tabla `tipo_pago`
--
ALTER TABLE `tipo_pago`
  ADD PRIMARY KEY (`id_tipo_pago`);

--
-- Indices de la tabla `ubicacion`
--
ALTER TABLE `ubicacion`
  ADD PRIMARY KEY (`id_ubicacion`),
  ADD KEY `fk_cliente_en_ubicacion` (`id_cliente`);

--
-- Indices de la tabla `usuario_admin`
--
ALTER TABLE `usuario_admin`
  ADD PRIMARY KEY (`id_usuario_admin`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `marca`
--
ALTER TABLE `marca`
  MODIFY `id_marca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `meta_producto`
--
ALTER TABLE `meta_producto`
  MODIFY `id_meta_producto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `metodo_pago`
--
ALTER TABLE `metodo_pago`
  MODIFY `id_metodo_pago` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `movimiento`
--
ALTER TABLE `movimiento`
  MODIFY `id_movimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tipo_envio`
--
ALTER TABLE `tipo_envio`
  MODIFY `id_tipo_envio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tipo_movimiento`
--
ALTER TABLE `tipo_movimiento`
  MODIFY `id_tipo_movimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tipo_pago`
--
ALTER TABLE `tipo_pago`
  MODIFY `id_tipo_pago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `ubicacion`
--
ALTER TABLE `ubicacion`
  MODIFY `id_ubicacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `usuario_admin`
--
ALTER TABLE `usuario_admin`
  MODIFY `id_usuario_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_carrito`
--
ALTER TABLE `detalle_carrito`
  ADD CONSTRAINT `fk_cliente_en_carrito` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_producto_en_carrito` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_categoria`
--
ALTER TABLE `detalle_categoria`
  ADD CONSTRAINT `fk_categoria_en_dproducto` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_producto_en_dproducto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_movimiento`
--
ALTER TABLE `detalle_movimiento`
  ADD CONSTRAINT `fk_movimiento_en_dmovimiento` FOREIGN KEY (`id_movimiento`) REFERENCES `movimiento` (`id_movimiento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_producto_en_dmovimiento` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD CONSTRAINT `fk_pedido_en_dpedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_producto_en_dpedido` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `meta_producto`
--
ALTER TABLE `meta_producto`
  ADD CONSTRAINT `fk_producto_en_mproducto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `metodo_pago`
--
ALTER TABLE `metodo_pago`
  ADD CONSTRAINT `fk_cliente_en_mpago` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `movimiento`
--
ALTER TABLE `movimiento`
  ADD CONSTRAINT `fk_tipo_movimiento_en_movimiento` FOREIGN KEY (`id_tipo_movimiento`) REFERENCES `tipo_movimiento` (`id_tipo_movimiento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_usuario_admin_en_movimiento` FOREIGN KEY (`id_usuario_admin`) REFERENCES `usuario_admin` (`id_usuario_admin`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `fk_cliente_en_pedido` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_metodo_pago_en_pedido` FOREIGN KEY (`id_metodo_pago`) REFERENCES `metodo_pago` (`id_metodo_pago`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tipo_envio_en_pedido` FOREIGN KEY (`id_tipo_envio`) REFERENCES `tipo_envio` (`id_tipo_envio`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tipo_pago_en_pedido` FOREIGN KEY (`id_tipo_pago`) REFERENCES `tipo_pago` (`id_tipo_pago`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ubicacion_en_pedido` FOREIGN KEY (`id_ubicacion`) REFERENCES `ubicacion` (`id_ubicacion`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `fk_marca_en_producto` FOREIGN KEY (`id_marca`) REFERENCES `marca` (`id_marca`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ubicacion`
--
ALTER TABLE `ubicacion`
  ADD CONSTRAINT `fk_cliente_en_ubicacion` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
