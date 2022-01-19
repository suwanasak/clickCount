-- phpMyAdmin SQL Dump
-- version 4.6.6
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 07, 2022 at 09:33 AM
-- Server version: 5.7.17-log
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `count_fix`
--

CREATE TABLE `count_fix` (
  `fix_id` int(11) NOT NULL,
  `fix_style` varchar(100) NOT NULL COMMENT 'ชื่อสินค้า',
  `fix_code` varchar(20) NOT NULL COMMENT 'รหัสติดกับกล่องสินค้า',
  `fix_group` varchar(10) NOT NULL COMMENT 'กรุ๊ปที่ตรวจสอบ',
  `fix_qty` int(11) NOT NULL COMMENT 'ยอดรับสินค้าเข้าเข้า',
  `fix_name` varchar(20) NOT NULL COMMENT 'ชื่อผู้รับสินค้า',
  `fix_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `count_fix`
--

INSERT INTO `count_fix` (`fix_id`, `fix_style`, `fix_code`, `fix_group`, `fix_qty`, `fix_name`, `fix_date`) VALUES
(1, 'STYLE_TFRC_100/L', '6501100004', '5', 100, '222222', '2022-01-19 02:31:52'),
(2, 'STYLE_TFRC_100/L', '6501100004', '5', 95, '222222', '2022-01-19 02:31:52'),
(3, 'STYLE_TFRC_100/L', '6501100004', '5', 97, '222222', '2022-01-19 02:31:52'),
(4, 'STYLE_TFRC_100/L', '6501100004', '5', 91, '222222', '2022-01-19 02:31:52'),
(5, 'STYLE_TFRC_100/L', '6501100004', '5', 100, '222222', '2022-01-19 02:31:52');

-- --------------------------------------------------------

--
-- Table structure for table `style_order`
--

CREATE TABLE `style_order` (
  `style_id` int(11) NOT NULL,
  `style_name` varchar(100) NOT NULL,
  `style_code` varchar(20) NOT NULL,
  `style_amount` int(11) NOT NULL,
  `style_size` varchar(20) NOT NULL,
  `style_color` varchar(50) NOT NULL,
  `style_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `style_create` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `style_order`
--

INSERT INTO `style_order` (`style_id`, `style_name`, `style_code`, `style_amount`, `style_size`, `style_color`, `style_date`, `style_create`) VALUES
(1, 'STYLE_TFRC_100/SS', '6501100001', 1000, 'SS', 'ครีม', '2022-01-10 02:11:54', 'เจ้าหน้าที่'),
(2, 'STYLE_TFRC_100/S', '6501100002', 1000, 'S', 'ครีม', '2022-01-10 02:17:37', 'เจ้าหน้าที่'),
(3, 'STYLE_TFRC_100/M', '6501100003', 1000, 'M', 'ครีม', '2022-01-10 02:17:37', 'เจ้าหน้าที่'),
(4, 'STYLE_TFRC_100/L', '6501100004', 1000, 'L', 'ครีม', '2022-01-10 02:17:37', 'เจ้าหน้าที่'),
(5, 'STYLE_TFRC_100/XL', '6501100005', 1000, 'XL', 'ครีม', '2022-01-10 02:17:37', 'เจ้าหน้าที่'),
(6, 'STYLE_TFRC_100/XXL', '6501100006', 1000, 'XXL', 'ครีม', '2022-01-10 02:17:37', 'เจ้าหน้าที่');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `count_fix`
--
ALTER TABLE `count_fix`
  ADD PRIMARY KEY (`fix_id`);

--
-- Indexes for table `style_order`
--
ALTER TABLE `style_order`
  ADD PRIMARY KEY (`style_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `count_fix`
--
ALTER TABLE `count_fix`
  MODIFY `fix_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `style_order`
--
ALTER TABLE `style_order`
  MODIFY `style_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
