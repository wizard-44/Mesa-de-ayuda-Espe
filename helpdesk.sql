-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-03-2023 a las 02:18:18
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `helpdesk`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `filtrar_ticket` (IN `tick_titulo` VARCHAR(50), IN `cat_id` INT, IN `prio_id` INT)   BEGIN

IF tick_titulo = '' THEN
SET tick_titulo = NULL;
END IF;

IF cat_id = '' THEN
SET cat_id = NULL;
END IF;

IF prio_id = '' THEN
SET prio_id = NULL;
END IF;

SELECT
tm_ticket.tick_id,
tm_ticket.usu_id,
tm_ticket.cat_id,
tm_ticket.tick_titulo,
tm_ticket.tick_descrip,
tm_ticket.tick_estado,
tm_ticket.fech_crea,
tm_ticket.fech_cierre,
tm_ticket.usu_asig,
tm_ticket.fech_asig,
tm_usuario.usu_nom,
tm_usuario.usu_ape,
tm_categoria.cat_nom,
tm_ticket.prio_id,
tm_prioridad.prio_nom
FROM 
tm_ticket
INNER JOIN tm_categoria on tm_ticket.cat_id = tm_categoria.cat_id
INNER JOIN tm_usuario on tm_ticket.usu_id = tm_usuario.usu_id
INNER JOIN tm_prioridad on tm_ticket.prio_id = tm_prioridad.prio_id
WHERE
tm_ticket.est= 1
AND tm_ticket.tick_titulo like IFNULL(tick_titulo,tm_ticket.tick_titulo)
AND tm_ticket.cat_id = IFNULL(cat_id,tm_ticket.cat_id)
AND tm_ticket.prio_id = IFNULL(prio_id,tm_ticket.prio_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_usuario` ()   BEGIN
	SELECT * FROM tm_usuario where est='1';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_usuario_x_id` (IN `xusu_id` INT)   BEGIN
	SELECT * FROM tm_usuario where usu_id=xusu_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_ticketdetalle_cerrar` (IN `xtick_id` INT, IN `xusu_id` INT)   BEGIN
	INSERT INTO td_ticketdetalle
    (tickd_id, tick_id, usu_id, tickd_descrip, fech_crea, est)
    VALUES
    (NULL, xtick_id, xusu_id, 'El Ticket fue Cerrado...', now(), '1');
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `td_documento`
--

CREATE TABLE `td_documento` (
  `doc_id` int(11) NOT NULL,
  `tick_id` int(11) NOT NULL,
  `doc_nom` varchar(400) COLLATE utf8_spanish_ci NOT NULL,
  `fech_crea` datetime NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `td_documento_detalle`
--

CREATE TABLE `td_documento_detalle` (
  `det_id` int(11) NOT NULL,
  `tickd_id` int(11) NOT NULL,
  `det_nom` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `td_documento_detalle`
--

INSERT INTO `td_documento_detalle` (`det_id`, `tickd_id`, `det_nom`, `est`) VALUES
(1, 26, '1.png', 1),
(2, 26, '2.png', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `td_ticketdetalle`
--

CREATE TABLE `td_ticketdetalle` (
  `tickd_id` int(11) NOT NULL,
  `tick_id` int(11) NOT NULL,
  `usu_id` int(11) NOT NULL,
  `tickd_descrip` mediumtext COLLATE utf8_spanish_ci NOT NULL,
  `fech_crea` datetime NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `td_ticketdetalle`
--

INSERT INTO `td_ticketdetalle` (`tickd_id`, `tick_id`, `usu_id`, `tickd_descrip`, `fech_crea`, `est`) VALUES
(1, 1, 2, 'Te respondo', '2023-02-25 18:03:43', 1),
(2, 1, 1, 'Soy el usuario respondiendo', '2023-02-25 18:04:10', 1),
(3, 1, 2, 'Para resolver tu problema reinicia tu equipo', '2023-02-25 18:04:41', 1),
(4, 1, 1, 'Si con eso se resolvió el problema\r\nGracias...!!!', '2023-02-25 18:05:13', 1),
(5, 1, 2, 'Muchas gracias por su confirmación, por favor cerrar el ticket', '2023-02-25 18:05:54', 1),
(6, 1, 1, 'test', '2023-02-28 10:59:13', 1),
(11, 1, 2, '<p>ok ya te lo reviso</p><p><img src=\"data:image/png;base64,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\" alt=\"\"><br></p>', '2023-02-28 11:34:34', 1),
(12, 13, 1, '<p>exisde</p>', '2023-02-28 12:29:54', 1),
(13, 13, 1, '<p>solo es de prueba</p>', '2023-02-28 12:30:04', 1),
(14, 13, 1, 'Ticket Cerrado...', '2023-02-28 12:30:08', 1),
(15, 14, 1, '<p>ok</p>', '2023-02-28 12:34:45', 1),
(16, 14, 1, '<p>es usad</p>', '2023-02-28 12:34:49', 1),
(17, 14, 1, 'Ticket Cerrado...', '2023-02-28 12:34:54', 1),
(18, 12, 2, 'El Ticket fue Cerrado..., Si tiene otra duda cree un nuevo ticket', '2023-03-02 09:04:25', 1),
(19, 13, 2, 'El Ticket fue Cerrado..., Si tiene otra duda cree un nuevo ticket', '2023-03-02 09:16:22', 1),
(20, 1, 2, 'El Ticket ha sido Re-Abierto...', '2023-03-02 17:07:38', 1),
(21, 14, 1, 'El Ticket fue Cerrado...', '2023-03-02 19:33:46', 1),
(22, 15, 2, '<p>mensajiotpee</p>', '2023-03-02 21:12:38', 1),
(23, 15, 2, '<p>Envio archivito</p>', '2023-03-02 21:12:54', 1),
(24, 1, 1, 'Estoy preguntando algo', '2023-03-04 13:17:58', 1),
(25, 1, 1, '<p>Probando los archivos detalle</p>', '2023-03-04 13:40:19', 1),
(26, 1, 1, '<p>Probando los archivos detalle x3</p>', '2023-03-04 13:42:42', 1),
(27, 1, 2, '<p>hola</p>', '2023-03-04 19:01:27', 1),
(28, 1, 2, '<p>hoal¡¡</p>', '2023-03-04 19:02:19', 1),
(29, 1, 1, '<p>que pasa ??</p>', '2023-03-04 19:02:33', 1),
(30, 1, 2, '<p>que pasa x2???</p>', '2023-03-04 19:14:12', 1),
(31, 1, 1, '<p>okkkk</p>', '2023-03-04 19:14:29', 1),
(32, 42, 2, '\r\n\r\nEl código que necesitas para sumar dos números en C++ es el siguiente:\r\n\r\nint main()\r\n\r\n{\r\n\r\nint num1, num2, suma;\r\n\r\nnum1 = 2;\r\n\r\nnum2 = 4;\r\n\r\nsuma = num1 + num2;\r\n\r\ncout &lt;&lt; \"La suma de \" &lt;&lt; num1 &lt;&lt; \" y \" &lt;&lt; num2 &lt;&lt; \" es: \" &lt;&lt; suma &lt;&lt; endl;\r\n\r\nreturn 0;\r\n\r\n}', '2023-03-04 19:49:17', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_categoria`
--

CREATE TABLE `tm_categoria` (
  `cat_id` int(11) NOT NULL,
  `cat_nom` varchar(150) COLLATE utf8_spanish_ci NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_categoria`
--

INSERT INTO `tm_categoria` (`cat_id`, `cat_nom`, `est`) VALUES
(1, 'Hardware', 1),
(2, 'Software', 1),
(3, 'Incidencia', 1),
(4, 'Petición de Servicio', 1),
(5, 'Otros', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_notificacion`
--

CREATE TABLE `tm_notificacion` (
  `not_id` int(11) NOT NULL,
  `usu_id` int(11) NOT NULL,
  `not_mensaje` varchar(400) COLLATE utf8_spanish_ci NOT NULL,
  `tick_id` int(11) NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_notificacion`
--

INSERT INTO `tm_notificacion` (`not_id`, `usu_id`, `not_mensaje`, `tick_id`, `est`) VALUES
(1, 2, 'probando notificaciones', 1, 1),
(2, 2, 'Otro mensaje de notificación', 10, 1),
(3, 2, 'Se le ha asignado el ticket Nro : ', 14, 1),
(4, 2, 'Se le ha asignado el ticket Nro : ', 15, 1),
(5, 2, 'Se le ha asignado el ticket Nro : ', 16, 1),
(6, 1, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 1, 1),
(7, 1, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 1, 1),
(8, 2, 'Tiene una nueva respuesta del usuario con nro de ticket : ', 1, 1),
(9, 1, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 1, 1),
(10, 2, 'Tiene una nueva respuesta del usuario con nro de ticket : ', 1, 1),
(11, 2, 'Tiene una nueva respuesta de soporte del ticket Nro : ', 42, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_prioridad`
--

CREATE TABLE `tm_prioridad` (
  `prio_id` int(11) NOT NULL,
  `prio_nom` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_prioridad`
--

INSERT INTO `tm_prioridad` (`prio_id`, `prio_nom`, `est`) VALUES
(1, 'Bajo', 1),
(2, 'Medio', 1),
(3, 'Alto', 1),
(4, 'Alta Prioridad', 0),
(5, 'altisimo', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_subcategoria`
--

CREATE TABLE `tm_subcategoria` (
  `cats_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `cats_nom` varchar(150) COLLATE utf8_spanish_ci NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_subcategoria`
--

INSERT INTO `tm_subcategoria` (`cats_id`, `cat_id`, `cats_nom`, `est`) VALUES
(1, 1, 'teclado', 1),
(2, 1, 'Monitor', 1),
(3, 2, 'Web', 1),
(4, 2, 'Movil', 1),
(5, 3, 'Crear correo', 1),
(6, 3, 'Error correo', 1),
(7, 4, 'Petición propia', 1),
(8, 4, 'Peticion grupal', 1),
(9, 3, 'editar', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_ticket`
--

CREATE TABLE `tm_ticket` (
  `tick_id` int(11) NOT NULL,
  `usu_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `cats_id` int(11) NOT NULL,
  `tick_titulo` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `tick_descrip` mediumtext COLLATE utf8_spanish_ci NOT NULL,
  `tick_estado` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fech_crea` datetime DEFAULT NULL,
  `usu_asig` int(11) DEFAULT NULL,
  `fech_asig` datetime DEFAULT NULL,
  `tick_estre` int(11) DEFAULT NULL,
  `tick_coment` varchar(300) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fech_cierre` datetime DEFAULT NULL,
  `prio_id` int(11) DEFAULT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_ticket`
--

INSERT INTO `tm_ticket` (`tick_id`, `usu_id`, `cat_id`, `cats_id`, `tick_titulo`, `tick_descrip`, `tick_estado`, `fech_crea`, `usu_asig`, `fech_asig`, `tick_estre`, `tick_coment`, `fech_cierre`, `prio_id`, `est`) VALUES
(1, 1, 1, 1, 'Test', 'test', 'Abierto', '2023-02-15 15:30:32', 2, '1900-01-04 09:58:05', 5, 'asdewffsdf', NULL, 2, 1),
(10, 1, 3, 2, 'Segundo TIcket', '<p>espero su respuesta</p><p><img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAALcAAAA2CAYAAACFggjiAAAFR0lEQVR4nO3df0jcdRzH8edc7g6b3rZM2VqG+3Fpzbi1DYwZDSUkg0KJhRBikOgfAxeNgqTRD+qPWITgH4p/FEWsRmwwmGOUwlCjlThBl0tbwumUnUv9qsm5Q68/Pl/x7kj73uZ9v/nZ+wEH3vc+97k35+v7uc/3c9+72xAOh8MIoaEkpwsQIlEk3EJbEm6hLQm30JaEW2hLwi20JeEW2pJwC21JuIW2Hoincf0ANN2A/ulElXN/y02D6t1Q63W6Ej1YDnf9ALSNwzfPQE5qIku6f12fgff7IByG4487Xc36t8HquSVPXJRg26F/Gl77GX57welK1j/Lc+7+aQm2HXLTZNq3VuSAUmhLwi20JeEW2pJwC21JuIW2JNxCWxJuoS0Jt9CWhFtoK64Tp9bUOJy9DucMMACPC0qzoWyPYxUB4L8KLbNQ8ixkOVuKuEeOjNz+X8DXAVW3oXdBbeudhape8F0C/4ITVSkBA+puQ8C5EsQasX3kNq5C8U0IJMGZfCjKNG+4A60dcMyAzhHIeszuyoRu7A33Apz2q1GxOTLYAJugqBD676i/ARiCl65B6ZPwera5bRzevQI8Ap/sV5tu9UH9TeiaUztNUTq8fQgyzX5af4B6oMELjdcgyws1e4C/4cKv0GSAH6jMhoOxNc/AhR74dgK6FmFvClTnwItLO99SjTmQNwYfBqH5eciM7UfYzt5pyRi0LAKboWSl//6miL9D0BkCIxTdZDikLgAMQPEgDCZBWTqUuaElAEc6IGg2MULQOQvF3dC3CK6NavuFy1AxCbihZhsM+6FqMvqxzrbDiQl4dBvUpoNnDiq64fRodI2f9sIbE3f5vIiEsHfknoNO4HAquJe2mSNflK1w/rDFPr1wfjNk7VjedOASVBgwCOQtbUyC5kIoWDptdwBOzMM+D5wpNOtZgJI2ODq73FfJAfVK4DF3iJoheK4HWsegPOIxD26Hr/Mt1ixsYW+4kyAD6AxGbDNHviix11ezAIEhqOtWqy6F2yEvWd00H9kuGfZGnI9+a0pNj056I3a0jeBJjuk/CF/8CG0htaJTna1WUeZjDnoPbIujZmELe6cl6VACYCyvkuCFv0rNS4F5exx6f4LiAGSkQ0MBFCVBo2H9/q7YMEeaUjtNUwhqfXAqF4aHoCXOGoUz7A33FqjcCizCW+1gxC75zanRd1WL0VcHZwAX1OZD1hbI2w/vbP3vUjzmcN06skr/AfgSKPdC0U7I3Anlvvh3QOEM25cC8/KhoQ2OTUL+RShPh8IUGLwN9QYMA5VLL/HmNKbpDzXVyJhRqy0tLAcsww0Y0DVqzrtnoGv2Xx44htsL7w3BR37IXIDSh8E/AnWRe9dmKAQ6RsHYrebdfr9aWZE3eP7/7H8Txw3lxXApA/aFoH4MXr4BJwxwu+Crp+Gzp8y22XAqBQLzcLQHjg5BXlb0yFngg9pkqLoCD50DXzvgslbH8UNQnayWEY/0QFMQTnoi2uyAj7dDYBJ2nVf9N85JsNcLy59+3/AdzL2y9gUEp9SBnysF3JtWaDOj2nhW+YBycArmk8Hz4F3WsNp9g2AEwZUK7o3x9x+vlO8h/GriH0d3zp1bYnJviVitWKlNqoU2Fvq56/u6l+foYv2QswKFtiTcQlsSbqEtCbfQloRbaEvCLbQl4RbaknALbUm4hbYshzs3TX3zv0is/mn1XIt7Zznc1bvVT1rIF6MnTv80fNAHVbucrkQPlk+cAvj8d2j+UwKeKLlpKthvyu/hrIm4wi3EeiIHlEJbEm6hLQm30JaEW2hLwi209Q+PhmLfK2L8QwAAAABJRU5ErkJggg==\" alt=\"\"><br></p>', 'Cerrado', '2023-02-28 12:02:54', 9, '2023-03-02 10:19:33', 5, 'comentario del 10', NULL, 1, 1),
(11, 1, 1, 3, 'Tercer ticket', '<p><img src=\"data:image/png;base64,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\" alt=\"\"><br></p>', 'Cerrado', '2023-02-28 12:04:57', 9, '2023-03-02 10:19:43', NULL, NULL, NULL, 3, 1),
(12, 1, 1, 4, 'Cuarto Ticket', '<p><img src=\"data:image/png;base64,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\" alt=\"\"><br></p>', 'Cerrado', '2023-02-28 12:06:17', 9, '2023-03-02 10:20:30', NULL, NULL, NULL, 2, 1),
(13, 1, 4, 5, 'Quinto Ticket', '<p>Prueba 5</p>', 'Cerrado', '2023-02-28 12:29:44', 2, '2023-03-04 18:35:44', NULL, NULL, NULL, 1, 1),
(14, 1, 1, 6, 'Sexto ticket', '<p><img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAK4AAAAyCAYAAADFqODWAAAJFUlEQVR4nO2cf0yU5x3AP/1xcFhPKO8y7xyMowvXC0jv9Jw9Mo2niVcaWUq0PzgbgWEcEkyEZZtH6qhr7YDaTfmDKm1sEd3Apmsx01AhE4guUFPsWaveICmvqStn3An2GILXzv3Bj/LjZJwcunc+n+T+4H2e9/s835fPfd/nfd7AA+T9+BYCgcJ48F5PQCC4E4S4AkUixBUoEiGuQJEIcQWKRIgrUCRCXIEiEeIKFIkQV6BIhLgCRSLEFSgSIa5AkQhxBYpEiCtQJEJcgSIR4goUiRBXoEiEuAJFIsQVKJKHQx4xwkLh0p+yNDKCMIBvfXx6sZKyL67iD/lggvuVEFdcHT//yfMsG5EW4CENixbmU6gN7UiC+5vQijvPyqI5gRoiWBibGNKhBPc3oRVXpUZ1+8aQDiW4vwmpuPbHzTx6m7ZHdDZeDHJFvTXnEBeL3+NicTkl0dM754UN+7lYvJ93LVN0SiikteSvdOVmBDehO8C0rJim4np6yk9yo/wkPa8eomnDWkzBBLG/zsXi9/jQPluzVB4hFbej79rtG/09yP8OJloh2UsMGLV6jNoUMtIXT+ssraTHqNWjnzdFJ5MFa6QGvT6FF4KZUpDEPbOf5vVp2LQSUQCEEyUZsKU4cZWUkzvdQPOHcjLOn7WpKo6Qiit/9iGnBgK1+Onq/At/C0LcOIcFM0C/jwFAH7+WFSGZJfD+r8g4foDNFVs5HKqYk1jNPmsyUQziOvEiD2xdTsTWpej3H+Ajrw/3hRoqZ23s/39CvB32BXI/LFNPPD7AP3p6goizmNJEAzBIW8Mf6F35MqmSBacVWtrGdIteS03uJlK1ElEqH56uBmon7Lnl5texxwDNJ1pQL0nD2t9CRMkgzlVpGBPnUllSBiSQm+PEmWhAOycctd+Hx9PKjoPbqbw8Ic7JFtSmNKySBrXfh/vC26RW1nJpUg4SahVAH72evtGjl9oreLq9YlxP07Kd7HsqBfM8DWrVIL3XL/HRsd/iONUZ+PJEr2a3YxMZ8Tq0c8LB78PdcZQdNbs5fG1krtLk8zxHiZhWvmupf7UQG2fYczaMDOtCes8uZ9HBKX9pd5UQb4d9w9G/u5io6L/+2cghbxBhrFnYJMDfQV3DMaouewEJ2/LMMZ0W8+6WQjJiJaL8X+H2eBmYv44Cg2ZcKLVKg1q1gNSnHNjmhQGDQDhq1dAH4MkNr7FvSTJafzeyR8bdH4Y21s6+3J2jVX40zioHZrzIHi8DKg1GUxb7rIGSaMHlHRya9/ojQ2vbnHyyEnTju+mLqV1vxzrvJrJXxu3pQx1pIGP9LmoSAl+erZlOCpL0qG904/bIyH4NxiQHVRszA58wmuvNaeYbhjoiHLWUgnOVBa0K+CZw6HtFyF9A+K92c5XxD2k9189zNYgYWRYDWsDT8QFlAA3tlCbZ0cesoIRqigBWbiJdGw797RT8Lo/yawAJ7C56h4LYyTHlT17C9k7jcGUsHtf28cEDOK94KWsYKedrqC95mVTJQDbQMtpzENeJHBa9P1QJs/LrqUqS0CcAbUygm8LKCoyF+aRKw2tbyYBtSRb7rp+j6v3t5LV3g/wKpXUynoZqjo/kn19PVdICzFYgQNEtb3gb9SctlJ3qHjoQvY1Pd67DPD+FXKqprEgfXYbErdyL6zkL6v52nJW7g8z3K2r35+Fo7548iXvMLLw50zBxKzdM9SjQF6h3ADLZbJAAL662Y0OHOito9tjJ1iaT6tBRVNMNMUMPPHLn28PSAnQi37gZIKYPuasxwO18mOhwzJaX6VkzFzU3kTuO4g5YYW7S6/3OpANf+6giwC15hGu1PP2bWuIS1rDZasdmWIhZ0qCOTGZz5k56uzZSdE2HOsZO1RubiFLBgPcMVVcGp75E6LCtOsSO58LA34f7QisD/UMt41ZpicV8lG4hCh/Nx/K+u07Tzbe/m7b/QWkhhOKqwg2sfNzG87E/mrQl9v0fbqH60fMc/vwDGq72TfnqN85hx6oCkLBlnuTGyN1veBvYnJjPCrZ/VxX8M72wOnbnFpIRC56uRkpPyOitaWRM4WOwXOo8RlHn8JcwJpPWgi1Y5+ixmiBO2sWeJQa4fo7ahlrcUhrZlgVTRFtD/QYHqZE+3Gdr2XMebClppM8B+sf2s/Lus6sxqgZxt77Eyqa7l+/dYObiPvwYLy5dz9rvaabs9ogmiZyUJHK+vcbHn73F618GeljTsSPBMPrTyBp0HJIFpwVavh7ebZifSRxlt6+m/5UVmKWhJUfprlcoB2ivRl18muwZvabWsbVgL9lXKkivGVPtL3fgGfPNTY/RocZHc8NGftYE0EjZw+9xK0V/m7gW9JGAt5XUygouAZWnvDS98Qts48Z+jWxtOANdB0g9OHYdM1v53l1mJu6DJn69aj1PTtpFmIKHonlykZM35r7KLy9OWD4k5GPTAnxF7e50HOPWdzr2Fh1hc6yE2boGKhppW56MLXYdbUUSdbIXbUwKqfEawBfEhDrw3AAkA+n2BMobOomzbMM80wqkz6fAsAC94TVkSz7uK5dw9c/FHGPAGAn0d1DXBK54H7AAsykTU1M1Z6NXszdGN0VgmV4/MM9AqUWHo70bk30FxjEVN+7ZXZQaNIAXl1dHac7OoQZvK44js5TvXWZGuwqqx5YFJ+0Y4n+wmok1JctuGTrmOYNz0kNJN3kXzjEAaA1r2UYt2TV/xtUP2lgbm5evI31+H81fBiMtwBmcx5uR/Rps6X/k1punkR3JE267d4C8HdufGnBdH4Q5CzDGp5CRlIwxMpwBbzt73smjHGipq6bOO0iUYQuuN09za6cT65TPA9XsOHkOj0pPxsYj3HrzNG3LNaNrXBip4gAS1iV2MkY+Jsvs5XuXeWAm/0pf/8Q2fq+f5rvYifjPU1Zfzek7HXwUHSueWIgWL22fnZnBkiGBpyx6om7IHL5wm/3TmcYGeq80cvzy5B6mxNUYI3y429s4O52Q0Yt5Jl6Crz/nSOedrPNnM9/ZZ0biCgT3CvEXEAJFIsQVKBIhrkCRCHEFikSIK1AkQlyBIhHiChSJEFegSIS4AkUixBUoEiGuQJEIcQWKRIgrUCT/AR/tGKjYZhNHAAAAAElFTkSuQmCC\" alt=\"\"><br></p>', 'Cerrado', '2023-02-28 12:34:36', 2, '2023-03-04 18:47:41', NULL, NULL, '2023-03-02 19:33:46', 3, 1),
(15, 1, 4, 7, 'Otro', '<p>datgertdafsdfasd</p>', 'Abierto', '2023-03-02 09:42:34', 2, '2023-03-04 18:48:02', NULL, NULL, NULL, 2, 1),
(16, 1, 4, 8, 'sawqrwer', '<p>sdafasdfsdf</p>', 'Abierto', '2023-03-02 10:43:23', 2, '2023-03-04 18:53:02', NULL, NULL, NULL, 3, 1),
(38, 1, 3, 6, 'subcategoria', '<p>probando subcategoria</p>', 'Abierto', '2023-03-02 17:46:11', NULL, NULL, NULL, NULL, NULL, 2, 1),
(39, 1, 4, 7, 'valoracion', '<p>asdasdasdas</p>', 'Abierto', '2023-03-02 18:28:03', NULL, NULL, NULL, NULL, NULL, 1, 1),
(40, 1, 1, 1, 'prioridad', '<p>probando prioridad</p>', 'Abierto', '2023-03-02 19:47:47', NULL, NULL, NULL, NULL, NULL, 3, 1),
(41, 2, 2, 4, 'PRUEBA', '<p>trwetrwetgdfgsdfg</p>', 'Abierto', '2023-03-04 18:35:05', NULL, NULL, NULL, NULL, NULL, 3, 1),
(42, 2, 2, 3, 'Ticket', '<p>Necesito crear un código que sume dos números en C++</p>', 'Abierto', '2023-03-04 19:48:33', NULL, NULL, NULL, NULL, NULL, 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_usuario`
--

CREATE TABLE `tm_usuario` (
  `usu_id` int(11) NOT NULL,
  `usu_nom` varchar(150) COLLATE utf8_spanish_ci DEFAULT NULL,
  `usu_ape` varchar(150) COLLATE utf8_spanish_ci DEFAULT NULL,
  `usu_correo` varchar(150) COLLATE utf8_spanish_ci NOT NULL,
  `usu_pass` varchar(150) COLLATE utf8_spanish_ci NOT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `usu_telf` varchar(12) COLLATE utf8_spanish_ci NOT NULL,
  `fech_crea` datetime DEFAULT NULL,
  `fecha_mod` datetime DEFAULT NULL,
  `fecha_elim` datetime DEFAULT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla Mantenedor de Usuario';

--
-- Volcado de datos para la tabla `tm_usuario`
--

INSERT INTO `tm_usuario` (`usu_id`, `usu_nom`, `usu_ape`, `usu_correo`, `usu_pass`, `rol_id`, `usu_telf`, `fech_crea`, `fecha_mod`, `fecha_elim`, `est`) VALUES
(1, 'Adrian', 'Salazarr', 'salazaradrian12@gmail.com', '202cb962ac59075b964b07152d234b70', 1, '', NULL, NULL, NULL, 1),
(2, 'Khriz', 'Llano', 'khriz.llano@gmail.com', '202cb962ac59075b964b07152d234b70', 2, '0999955952', NULL, NULL, NULL, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `td_documento`
--
ALTER TABLE `td_documento`
  ADD PRIMARY KEY (`doc_id`);

--
-- Indices de la tabla `td_documento_detalle`
--
ALTER TABLE `td_documento_detalle`
  ADD PRIMARY KEY (`det_id`);

--
-- Indices de la tabla `td_ticketdetalle`
--
ALTER TABLE `td_ticketdetalle`
  ADD PRIMARY KEY (`tickd_id`);

--
-- Indices de la tabla `tm_categoria`
--
ALTER TABLE `tm_categoria`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indices de la tabla `tm_notificacion`
--
ALTER TABLE `tm_notificacion`
  ADD PRIMARY KEY (`not_id`);

--
-- Indices de la tabla `tm_prioridad`
--
ALTER TABLE `tm_prioridad`
  ADD PRIMARY KEY (`prio_id`);

--
-- Indices de la tabla `tm_subcategoria`
--
ALTER TABLE `tm_subcategoria`
  ADD PRIMARY KEY (`cats_id`);

--
-- Indices de la tabla `tm_ticket`
--
ALTER TABLE `tm_ticket`
  ADD PRIMARY KEY (`tick_id`);

--
-- Indices de la tabla `tm_usuario`
--
ALTER TABLE `tm_usuario`
  ADD PRIMARY KEY (`usu_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `td_documento`
--
ALTER TABLE `td_documento`
  MODIFY `doc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `td_documento_detalle`
--
ALTER TABLE `td_documento_detalle`
  MODIFY `det_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `td_ticketdetalle`
--
ALTER TABLE `td_ticketdetalle`
  MODIFY `tickd_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `tm_categoria`
--
ALTER TABLE `tm_categoria`
  MODIFY `cat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tm_notificacion`
--
ALTER TABLE `tm_notificacion`
  MODIFY `not_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `tm_prioridad`
--
ALTER TABLE `tm_prioridad`
  MODIFY `prio_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tm_subcategoria`
--
ALTER TABLE `tm_subcategoria`
  MODIFY `cats_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tm_ticket`
--
ALTER TABLE `tm_ticket`
  MODIFY `tick_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT de la tabla `tm_usuario`
--
ALTER TABLE `tm_usuario`
  MODIFY `usu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
