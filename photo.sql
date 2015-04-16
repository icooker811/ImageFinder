-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 16 เม.ย. 2015  09:39น.
-- Server version: 5.6.16
-- PHP Version: 5.5.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `photo`
--

-- --------------------------------------------------------

--
-- โครงสร้างตาราง `map`
--

CREATE TABLE IF NOT EXISTS `map` (
  `id` varchar(10) CHARACTER SET utf8 NOT NULL,
  `name` varchar(1000) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- โครงสร้างตาราง `newphoto`
--

CREATE TABLE IF NOT EXISTS `newphoto` (
  `name` varchar(1000) CHARACTER SET utf8 NOT NULL,
  `zone` varchar(3) CHARACTER SET utf8 NOT NULL,
  `map` varchar(10) NOT NULL,
  `r1` double NOT NULL,
  `r2` double NOT NULL,
  `r3` double NOT NULL,
  `r4` double NOT NULL,
  `r5` double NOT NULL,
  `r6` double NOT NULL,
  `r7` double NOT NULL,
  `r8` double NOT NULL,
  `ratio` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- โครงสร้างตาราง `polygon`
--

CREATE TABLE IF NOT EXISTS `polygon` (
  `polygonid` varchar(10) NOT NULL,
  `detail` varchar(1000) CHARACTER SET utf8 DEFAULT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `mapid` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



-- --------------------------------------------------------

--
-- โครงสร้างตาราง `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `username` varchar(20) CHARACTER SET utf8 NOT NULL,
  `password` varchar(20) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- dump ตาราง `user`
--

INSERT INTO `user` (`username`, `password`) VALUES
('admin', 'admin');

-- --------------------------------------------------------

--
-- โครงสร้างตาราง `zone`
--

CREATE TABLE IF NOT EXISTS `zone` (
  `zoneid` varchar(3) CHARACTER SET utf8 NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `mapid` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
