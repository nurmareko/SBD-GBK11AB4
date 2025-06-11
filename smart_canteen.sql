-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 11, 2025 at 09:31 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smart_canteen`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer_order`
--

CREATE TABLE `customer_order` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `order_datetime` timestamp NOT NULL DEFAULT current_timestamp(),
  `required_datetime` timestamp NOT NULL DEFAULT current_timestamp(),
  `estimated_duration_minutes` int(11) DEFAULT NULL,
  `completed_datetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `total_price` decimal(12,2) NOT NULL,
  `pickup_location` varchar(100) DEFAULT NULL,
  `is_delivery` tinyint(1) DEFAULT 0,
  `delivery_location` varchar(100) DEFAULT NULL,
  `order_status` enum('pending','preparing','ready','completed','cancelled') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_order`
--

INSERT INTO `customer_order` (`order_id`, `user_id`, `order_datetime`, `required_datetime`, `estimated_duration_minutes`, `completed_datetime`, `total_price`, `pickup_location`, `is_delivery`, `delivery_location`, `order_status`) VALUES
(1, 3, '2025-06-03 00:24:50', '2025-06-10 01:24:50', 57, '2025-06-10 00:50:50', 60000.00, NULL, 0, '', 'completed'),
(2, 1, '2025-06-06 00:24:50', '2025-06-11 01:24:50', 48, '2025-06-11 01:30:50', 49000.00, NULL, 1, 'Room 103', 'completed'),
(3, 5, '2025-05-31 00:24:50', '2025-06-08 01:24:50', 39, '2025-06-10 00:24:50', 30000.00, NULL, 0, '', 'pending'),
(4, 4, '2025-05-29 00:24:50', '2025-06-10 01:24:50', 41, '2025-06-10 00:24:50', 90000.00, NULL, 0, '', 'pending'),
(5, 2, '2025-06-01 00:24:50', '2025-06-09 01:24:50', 27, '2025-06-10 00:24:50', 25000.00, NULL, 1, 'Room 106', 'ready');

-- --------------------------------------------------------

--
-- Table structure for table `merchant`
--

CREATE TABLE `merchant` (
  `merchant_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` text NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `store_name` varchar(100) NOT NULL,
  `pickup_location` text NOT NULL,
  `rating_avg` decimal(3,2) DEFAULT 0.00,
  `rating_count` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `merchant`
--

INSERT INTO `merchant` (`merchant_id`, `name`, `email`, `password_hash`, `phone_number`, `store_name`, `pickup_location`, `rating_avg`, `rating_count`) VALUES
(1, 'Syamsudin T', 'syamsudin@email.com', '$2b$12$merchanthash1', '8987654321', 'Rasa Nusantara', 'Gerai 01', 4.58, 354),
(2, 'Rahmat M', 'rahmat@email.com', '$2b$12$merchanthash2', '8987654322', 'Dapur Lezat', 'Gerai 02', 4.74, 376),
(3, 'Siska S', 'siska@email.com', '$2b$12$merchanthash3', '8987654323', 'Santapan Sehat', 'Gerai 03', 4.57, 347),
(4, 'Ihkam A', 'ihkam@email.com', '$2b$12$merchanthash4', '8987654324', 'Warung Selera', 'Gerai 04', 4.72, 171),
(5, 'Kurniawati J', 'kurniawati@email.com', '$2b$12$merchanthash5', '8987654325', 'piyo', 'Gerai 05', 4.92, 247);

-- --------------------------------------------------------

--
-- Table structure for table `order_detail`
--

CREATE TABLE `order_detail` (
  `order_detail_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_detail`
--

INSERT INTO `order_detail` (`order_detail_id`, `order_id`, `product_id`, `unit_price`, `quantity`) VALUES
(1, 5, 2, 10000.00, 3),
(2, 4, 4, 90000.00, 1),
(3, 1, 5, 49000.00, 1),
(4, 3, 1, 40000.00, 1),
(5, 3, 5, 20000.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `method` enum('wallet','ewallet','mixed','debit') NOT NULL,
  `ewallet_amount` decimal(12,2) DEFAULT 0.00,
  `wallet_amount` decimal(12,2) DEFAULT 0.00,
  `debit_amount` decimal(12,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `order_id`, `method`, `ewallet_amount`, `wallet_amount`, `debit_amount`) VALUES
(1, 1, 'wallet', 0.00, 49000.00, 0.00),
(2, 2, 'ewallet', 30000.00, 0.00, 0.00),
(3, 3, 'mixed', 50000.00, 10000.00, 0.00),
(4, 4, 'ewallet', 90000.00, 0.00, 0.00),
(5, 5, 'mixed', 5000.00, 5000.00, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `merchant_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `stock` int(11) DEFAULT 0,
  `last_stock_update` datetime NOT NULL,
  `preparation_time_minutes` int(11) NOT NULL,
  `is_special` tinyint(1) DEFAULT 0,
  `special_available_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `merchant_id`, `name`, `price`, `stock`, `last_stock_update`, `preparation_time_minutes`, `is_special`, `special_available_date`) VALUES
(1, 1, 'Soto medan', 18000.00, 27, '2025-06-20 00:00:00', 20, 0, NULL),
(2, 1, 'Es Teh Manis', 5000.00, 12, '2025-06-20 00:00:00', 5, 0, NULL),
(3, 3, 'Mie Kuah Nusantara', 17000.00, 25, '2025-06-20 00:00:00', 30, 0, NULL),
(4, 3, 'Dimsum mix isi 4', 22000.00, 17, '2025-06-20 00:00:00', 10, 0, NULL),
(5, 5, 'Katsu Curry', 30000.00, 19, '2025-06-20 00:00:00', 15, 1, '2025-06-20');

-- --------------------------------------------------------

--
-- Table structure for table `promo`
--

CREATE TABLE `promo` (
  `promo_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` enum('volume','time') NOT NULL,
  `merchant_id` int(11) DEFAULT NULL,
  `start_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `volume_limit` int(11) DEFAULT NULL,
  `used_count` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `promo`
--

INSERT INTO `promo` (`promo_id`, `name`, `type`, `merchant_id`, `start_time`, `end_time`, `volume_limit`, `used_count`) VALUES
(1, 'Promo 1', 'time', 4, '2025-06-10 20:59:01', '2025-06-17 20:59:01', NULL, 14),
(2, 'Promo 2', 'time', 1, '2025-06-10 20:59:01', '2025-06-17 20:59:01', NULL, 12),
(3, 'Promo 3', 'time', 3, '2025-06-10 20:59:01', '2025-06-17 20:59:01', NULL, 19),
(4, 'Promo 4', 'volume', 3, '2025-06-10 20:59:01', '2025-06-17 20:59:01', 100, 3),
(5, 'Promo 5', 'time', 2, '2025-06-10 20:59:01', '2025-06-17 20:59:01', NULL, 18);

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `rating_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `merchant_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `rating_value` int(11) NOT NULL CHECK (`rating_value` between 1 and 5),
  `review_text` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rating`
--

INSERT INTO `rating` (`rating_id`, `user_id`, `merchant_id`, `order_id`, `rating_value`, `review_text`, `created_at`) VALUES
(1, 1, 2, 4, 5, 'mantab', '2025-06-10 20:59:01'),
(2, 1, 2, 1, 1, '', '2025-06-10 20:59:01'),
(3, 4, 5, 4, 2, '', '2025-06-10 20:59:01'),
(4, 3, 5, 2, 3, 'biasa aja', '2025-06-10 20:59:01'),
(5, 1, 4, 3, 5, 'enak', '2025-06-10 20:59:01');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` text NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `role` enum('student','guest') NOT NULL,
  `is_dorm_resident` tinyint(1) DEFAULT 0,
  `dorm_room` varchar(50) DEFAULT NULL,
  `verified` tinyint(1) DEFAULT 0,
  `wallet_balance` decimal(12,2) DEFAULT 0.00 CHECK (`wallet_balance` <= 2000000),
  `reward_point` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `username`, `email`, `password_hash`, `full_name`, `phone_number`, `role`, `is_dorm_resident`, `dorm_room`, `verified`, `wallet_balance`, `reward_point`) VALUES
(1, 'maikelhulu', 'maikelhulu@student.telu.ac.id', '$2b$12$hashvalue2', 'Maikel Hulu', '8123456782', 'student', 1, 'Asrama Putra 10, Kamar 319', 1, 273714.55, 691),
(2, 'yehezkielenrico', 'yehezkielenrico@student.telu.ac.id', '$2b$12$hashvalue1', 'Yehezkiel enrico', '8123456781', 'student', 0, '', 1, 821177.44, 14),
(3, 'rahmawatidewi', 'rahmawati@yandex.ru', '$2b$12$hashvalue3', 'Rahmawati Dewi', '8123456783', 'guest', 0, '', 1, 962609.24, 346),
(4, 'budisantoso', 'budi@email.com', '$2b$12$hashvalue4', 'Budi Santoso', '8123456784', 'guest', 0, '', 1, 839170.99, 627),
(5, 'indahlestari', 'indah@email.com', '$2b$12$hashvalue5', 'Indah Lestari', '8123456785', 'guest', 0, '', 0, 0.00, 0);

-- --------------------------------------------------------

--
-- Table structure for table `voucher`
--

CREATE TABLE `voucher` (
  `voucher_id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `value` decimal(12,2) NOT NULL,
  `min_transaction` decimal(12,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `merchant_id` int(11) DEFAULT NULL,
  `max_redemption` int(11) NOT NULL,
  `current_redemption` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `voucher`
--

INSERT INTO `voucher` (`voucher_id`, `code`, `value`, `min_transaction`, `start_date`, `end_date`, `merchant_id`, `max_redemption`, `current_redemption`) VALUES
(1, 'DISC10', 11000.00, 30000.00, '2025-06-11', '2025-07-11', 5, 100, 11),
(2, 'DISC20', 25000.00, 100000.00, '2025-06-11', '2025-07-11', 3, 100, 37),
(3, 'DISC30', 30000.00, 150000.00, '2025-06-11', '2025-07-11', 4, 100, 17),
(4, 'DISC40', 5000.00, 30000.00, '2025-06-11', '2025-07-11', 3, 100, 41),
(5, 'DISC50', 20000.00, 90000.00, '2025-06-11', '2025-07-11', 5, 100, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer_order`
--
ALTER TABLE `customer_order`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `merchant`
--
ALTER TABLE `merchant`
  ADD PRIMARY KEY (`merchant_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`order_detail_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `merchant_id` (`merchant_id`);

--
-- Indexes for table `promo`
--
ALTER TABLE `promo`
  ADD PRIMARY KEY (`promo_id`),
  ADD KEY `merchant_id` (`merchant_id`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`rating_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `merchant_id` (`merchant_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `voucher`
--
ALTER TABLE `voucher`
  ADD PRIMARY KEY (`voucher_id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `merchant_id` (`merchant_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer_order`
--
ALTER TABLE `customer_order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `merchant`
--
ALTER TABLE `merchant`
  MODIFY `merchant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `order_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `promo`
--
ALTER TABLE `promo`
  MODIFY `promo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `rating`
--
ALTER TABLE `rating`
  MODIFY `rating_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `voucher`
--
ALTER TABLE `voucher`
  MODIFY `voucher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer_order`
--
ALTER TABLE `customer_order`
  ADD CONSTRAINT `customer_order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `customer_order` (`order_id`),
  ADD CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `customer_order` (`order_id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`merchant_id`);

--
-- Constraints for table `promo`
--
ALTER TABLE `promo`
  ADD CONSTRAINT `promo_ibfk_1` FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`merchant_id`);

--
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `rating_ibfk_2` FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`merchant_id`),
  ADD CONSTRAINT `rating_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `customer_order` (`order_id`);

--
-- Constraints for table `voucher`
--
ALTER TABLE `voucher`
  ADD CONSTRAINT `voucher_ibfk_1` FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`merchant_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
