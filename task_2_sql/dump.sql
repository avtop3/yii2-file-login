-- phpMyAdmin SQL Dump
-- version 4.0.10.6
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 17, 2016 at 11:13 PM
-- Server version: 5.5.41-log
-- PHP Version: 5.4.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `test_2`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned DEFAULT NULL,
  `name` varchar(500) NOT NULL,
  `l` tinyint(4) NOT NULL DEFAULT '0',
  `r` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=32 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `parent_id`, `name`, `l`, `r`) VALUES
(1, NULL, 'Электроника', 1, 20),
(2, NULL, 'Одежда', 21, 44),
(8, 1, 'Бытовая техника', 2, 5),
(9, 8, 'Климатическая техника', 3, 4),
(14, 1, 'Компютерная техника, комплектующие', 6, 19),
(15, 14, 'Накопители', 7, 12),
(16, 15, 'SSD', 8, 9),
(17, 15, 'HDD', 10, 11),
(18, 14, 'Сетевое оборудование', 13, 18),
(19, 18, 'Роутеры', 14, 15),
(20, 18, 'Сетевые карты', 16, 17),
(21, 2, 'Женская одежда', 22, 29),
(22, 2, 'Мужская одежда', 30, 43),
(23, 22, 'Верхняя одежда', 31, 36),
(24, 23, 'Пуховики', 32, 33),
(25, 23, 'Ветрови', 34, 35),
(26, 22, 'Рубашки', 37, 42),
(27, 26, 'Рубашки с коротким рукавом', 38, 39),
(28, 26, 'Рубашки с длинным рукавом', 40, 41),
(29, 21, 'Брюки', 23, 28),
(30, 29, 'Леггинсы', 24, 25),
(31, 29, 'Прямые брюки', 26, 27);

-- --------------------------------------------------------

--
-- Table structure for table `category-item`
--

CREATE TABLE IF NOT EXISTS `category-item` (
  `category_id` int(11) unsigned NOT NULL,
  `item_id` int(11) unsigned NOT NULL,
  KEY `category_id` (`category_id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category-item`
--

INSERT INTO `category-item` (`category_id`, `item_id`) VALUES
(1, 8),
(17, 6),
(16, 6),
(18, 2),
(18, 9),
(20, 9),
(19, 10),
(24, 1),
(17, 7),
(31, 15),
(31, 14),
(29, 13),
(9, 5),
(8, 4),
(9, 4),
(21, 22),
(22, 18),
(21, 18),
(28, 19),
(28, 20),
(27, 21),
(14, 3),
(21, 17),
(22, 17),
(22, 23);

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE IF NOT EXISTS `item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `price` float unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`id`, `title`, `price`) VALUES
(1, 'tp-link wr841', 800),
(2, 'MicroTick', 1250),
(3, 'Серверная стойка', 2000),
(4, 'Вентилятор Сатурн', 366),
(5, 'Кондиционер', 8499),
(6, 'Kingston Hybrid HDD', 1200),
(7, 'Transcend CV-400', 1150),
(8, 'Intel Core i3 m3110', 3100),
(9, 'PCI TP-Link TF-3239DL 100Mbit', 106),
(10, 'TP-Link UE300', 389),
(11, 'леггинсы серые', 89),
(12, 'леггинсы белые с узором oodji', 299),
(13, 'брюки прямые oodji красные', 300),
(14, 'брюки прямые oodji желтые', 569),
(15, 'брюки белые с поясом Mango', 499),
(16, 'брюки черные костюмные', 566),
(17, 'Футболка с Микимаусом', 299),
(18, 'Футболка с принтом Турция', 259),
(19, 'Рубашка костюмная Carl Brune белая', 989),
(20, 'Рубашка костюмная Carl Brune красная', 989),
(21, 'Рубашка с коротким рукавом и приуженой талией', 1000),
(22, 'Шорты зеленые', 600),
(23, 'Штаны спортивные Adidas', 900);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `FK_category_category` FOREIGN KEY (`parent_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `category-item`
--
ALTER TABLE `category-item`
  ADD CONSTRAINT `FK_category-item_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`),
  ADD CONSTRAINT `FK_category-item_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
