-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 27, 2023 at 12:53 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `property`
--

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

CREATE TABLE `properties` (
  `id` int(11) NOT NULL,
  `real_estate_name` varchar(40) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lon` double DEFAULT NULL,
  `LOCATION` varchar(150) DEFAULT NULL,
  `property_type` enum('house','condominium','land','') DEFAULT NULL,
  `TRANSACTION` enum('FOR SELL ONLY','RENT UP TO 6 MONTHS','FOR RENT AND FOR SELL') DEFAULT NULL,
  `SALE_TERMS` enum('LEASEHOLD','FREEHOLD','','') DEFAULT NULL,
  `SALE_PRICE` double DEFAULT NULL,
  `RENT_PRICE` double DEFAULT NULL,
  `COMMON_CHARGES` double DEFAULT NULL,
  `DECORATION_STYLE` varchar(300) DEFAULT NULL,
  `BEDROOMS` int(11) DEFAULT NULL,
  `BATHROOMS` int(11) DEFAULT NULL,
  `DIRECTION_OF_ROOM` enum('North','East','West','South') DEFAULT NULL,
  `UNIT_SIZE` double DEFAULT NULL COMMENT 'หน่วย ตารางเมตร',
  `LAND_AREA` double DEFAULT NULL COMMENT 'หน่วย ตารางวา',
  `INROOM_FACILITIES` text DEFAULT NULL,
  `PUBLIC_FACILITIES` text DEFAULT NULL,
  `image_01` varchar(200) DEFAULT NULL,
  `image_02` varchar(200) DEFAULT NULL,
  `image_03` varchar(200) DEFAULT NULL,
  `image_04` varchar(200) DEFAULT NULL,
  `image_05` varchar(200) DEFAULT NULL,
  `owner_id` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='resource for w701 course';

--
-- Dumping data for table `properties`
--

INSERT INTO `properties` (`id`, `real_estate_name`, `lat`, `lon`, `LOCATION`, `property_type`, `TRANSACTION`, `SALE_TERMS`, `SALE_PRICE`, `RENT_PRICE`, `COMMON_CHARGES`, `DECORATION_STYLE`, `BEDROOMS`, `BATHROOMS`, `DIRECTION_OF_ROOM`, `UNIT_SIZE`, `LAND_AREA`, `INROOM_FACILITIES`, `PUBLIC_FACILITIES`, `image_01`, `image_02`, `image_03`, `image_04`, `image_05`, `owner_id`, `created_at`) VALUES
(1, 'ที่ดินเปล่า ถมแล้ว', 14.207476, 100.460057, 'บางพลี อยุธยา', 'land', 'FOR RENT AND FOR SELL', 'FREEHOLD', 5000000, 30000, 0, NULL, NULL, NULL, NULL, NULL, 2000, NULL, 'ติดถนน,มีคลองชลประทาน', '01_prop_id/01_img.jpg', '01_prop_id/02_img.jpg', '01_prop_id/03_img.jpg', '01_prop_id/04_img.jpg', '01_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(2, 'ที่นาขั้นบันได', 19.621176, 98.191613, 'บ้านไม้ฮุง แม่ฮ่องสอน', 'land', 'FOR SELL ONLY', 'FREEHOLD', 1000000, NULL, 0, NULL, NULL, NULL, NULL, NULL, 400, NULL, 'ติดแม่น้ำ', '02_prop_id/01_img.jpg', '02_prop_id/02_img.jpg', '02_prop_id/03_img.jpg', '02_prop_id/04_img.jpg', '02_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(3, 'ที่นาสวย ใกล้เมือง', 13.992424, 100.665889, 'รังสิต ปทุมธานี', 'land', 'FOR RENT AND FOR SELL', 'FREEHOLD', 15000000, 50000, 0, NULL, NULL, NULL, NULL, NULL, 1000, NULL, 'ถนน,ไฟฟ้า,ประปา,ดรีมเวิล์ด', '03_prop_id/01_img.jpg', '03_prop_id/02_img.jpg', '03_prop_id/03_img.jpg', '03_prop_id/04_img.jpg', '03_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(4, 'ทุ่งหญ้าเชิงเขา ใกล้เขื่อน', 14.784594, 99.087207, 'ใกล้เขื่อนศรีนครินทร์ กาญจนบุรี', 'land', 'FOR SELL ONLY', 'FREEHOLD', 10000000, NULL, 0, NULL, NULL, NULL, NULL, NULL, 3000, NULL, 'ถนน,ใกล้เขื่อน', '04_prop_id/01_img.jpg', '04_prop_id/02_img.jpg', '04_prop_id/03_img.jpg', '04_prop_id/04_img.jpg', '04_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(5, 'ที่ดินพร้อมคอกม้า (ไม่รวมม้า)', 14.665299, 101.867524, 'ปักธงชัย นครราชสีมา', 'land', 'FOR RENT AND FOR SELL', 'FREEHOLD', 9900000, 40000, 0, NULL, NULL, NULL, NULL, NULL, 1400, NULL, 'ถนน,ไฟฟ้า,ประปา,ใกล้อ่างเก็บน้ำ', '05_prop_id/01_img.jpg', '05_prop_id/02_img.jpg', '05_prop_id/03_img.jpg', '05_prop_id/04_img.jpg', '05_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(6, 'ที่เปล่า เชิงเขาร็อกกี้', 44.281754, -109.502647, 'USA', 'land', 'FOR SELL ONLY', 'LEASEHOLD', 29000000, NULL, 0, NULL, NULL, NULL, NULL, NULL, 500, NULL, 'ไฟฟ้า,ประปา,ถนน,อุทยานแห่งชาติ', '06_prop_id/01_img.jpg', '06_prop_id/02_img.jpg', '06_prop_id/03_img.jpg', '06_prop_id/04_img.jpg', '06_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(7, 'บ้าน 3 ชั้น สไตล์โมเดิร์น', 13.899192, 100.546304, 'ปากเกร็ด นนทบุรี', 'house', 'FOR RENT AND FOR SELL', 'FREEHOLD', 10000000, 80000, 3000, 'MODERN', 4, 4, 'South', 100, 300, ' BALCONIES,CABLE,FULLY FURNISHED,MAID ROOM,BATHTUB,OPEN KITCHEN,CLOSE KITCHEN,AIR CONDITION,WASHER  ', 'SECURITY, POOL, HOSPITAL, DEPARTMENT STORE', '07_prop_id/01_img.jpg', '07_prop_id/02_img.jpg', '07_prop_id/03_img.jpg', '07_prop_id/04_img.jpg', '07_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(8, 'บ้านน้อยกลางป่าใหญ่', 12.88324, 99.641541, 'ต.สองพี่น้อง เพชรบุรี', 'house', 'FOR RENT AND FOR SELL', 'LEASEHOLD', 8900000, 65000, 0, 'NATURE', 3, 2, 'North', 175, 400, 'FULLY FURNISHED,BATHTUB,เครื่องปั่นไฟ ', 'FOREST,RIVER,ใกล้เขื่อนแก่งกระจาน', '08_prop_id/01_img.jpg', '08_prop_id/02_img.jpg', '08_prop_id/03_img.jpg', '08_prop_id/04_img.jpg', '08_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(9, 'บ้าน 2 ชั้น สไตล์วินเทจ', 13.87648, 100.820414, 'หนองจอก กรุงเทพฯ', 'house', 'RENT UP TO 6 MONTHS', 'LEASEHOLD', NULL, 100000, 8500, 'VINTAGE', 5, 4, 'East', 250, 500, ' BALCONIES,CABLE,FULLY FURNISHED,MAID ROOM,SHOWER,OPEN KITCHEN,CLOSE KITCHEN,AIR CONDITION,WASHER,INTERNET  ', ' 24 HOURS SECURITY, POOL, PLAYGROUND, FITNESS CENTER, PET ALLOWED, BIG GARDEN  ', '09_prop_id/01_img.jpg', '09_prop_id/02_img.jpg', '09_prop_id/03_img.jpg', '09_prop_id/04_img.jpg', '09_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(10, 'บ้านเดี่ยว ติดทางด่วน', 13.798831, 100.420658, 'พุทธมณฑลสาย 1 กรุงเทพฯ', 'house', 'RENT UP TO 6 MONTHS', 'LEASEHOLD', NULL, 30000, 0, '', 2, 3, 'North', 100, 200, ' FULLY FURNISHED,SHOWER,KITCHEN,AIR CONDITION,WASHER,INTERNET  ', 'ติดทางด่วน,สำนักงานอัยการ,ร้านอาหาร', '10_prop_id/01_img.jpg', '10_prop_id/02_img.jpg', '10_prop_id/03_img.jpg', '10_prop_id/04_img.jpg', '10_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(11, 'ทาวน์โฮมใหญ่ 3 ชั้น ทำออฟฟิศได้', 13.754566, 100.421752, 'พุทธมณฑลสาย 1 กรุงเทพฯ', 'house', 'FOR SELL ONLY', 'FREEHOLD', 15000000, NULL, 0, 'MODERN', 4, 4, 'South', 350, 200, ' BALCONIES,FULLY FURNISHED,MAID ROOM,SHOWER,KITCHEN,AIR CONDITION,WASHER ', 'โรงเรียน,สนามกอล์ฟ,ร้านทำผม,ถนนใหญ่', '11_prop_id/01_img.jpg', '11_prop_id/02_img.jpg', '11_prop_id/03_img.jpg', '11_prop_id/04_img.jpg', '11_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(12, 'ขายด่วน บ้าน 2 ชั้น หมู่บ้านแมวเหมียว', 13.677197, 100.4678, 'บางมด กรุงเทพฯ', 'house', 'FOR SELL ONLY', 'FREEHOLD', 12000000, NULL, 5000, 'MINIMAL', 3, 3, 'West', 75, 175, ' OVEN,BATHTUB,KITCHEN ', 'ใกล้ถ.พระราม 2,วัด,ปั๊มน้ำมัน,SECURITY, POOL, PLAYGROUND, FITNESS ', '12_prop_id/01_img.jpg', '12_prop_id/02_img.jpg', '12_prop_id/03_img.jpg', '12_prop_id/04_img.jpg', '12_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(13, 'บ้านตากอากาศหรู ริมทะเลสาบ', -43.989438, 170.500761, 'เทคาโป นิวซีแลนด์', 'house', 'FOR RENT AND FOR SELL', 'FREEHOLD', 99000000, 500000, 0, NULL, 6, 6, 'South', 700, 800, 'FULLY FURNISHED,BATHTUB,เครื่องปั่นไฟ ', 'FOREST,RIVER', '13_prop_id/01_img.jpg', '13_prop_id/02_img.jpg', '13_prop_id/03_img.jpg', '13_prop_id/04_img.jpg', '13_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(14, 'คอนโด LOW RISE ห้องใหญ่', 13.721703, 100.503831, 'คลองสาน กรุงเทพฯ', 'condominium', 'RENT UP TO 6 MONTHS', 'FREEHOLD', NULL, 15000, 1500, 'MODERN', 2, 1, 'North', 48, NULL, 'BALCONY,FULLY FURNISHED,KITCHEN,AIR CONDITION,HOT WATER ', 'POOL,FITNESS,BTS KRUNGTHONBURI,ICON SIAM', '14_prop_id/01_img.jpg', '14_prop_id/02_img.jpg', '14_prop_id/03_img.jpg', '14_prop_id/04_img.jpg', '14_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(15, 'คอนโด Loft ชั้น 37', 13.747198, 100.563403, 'อโศก กรุงเทพฯ', 'condominium', 'RENT UP TO 6 MONTHS', 'FREEHOLD', NULL, 65000, 3200, 'MODERN', 2, 2, 'East', 57, NULL, 'FULLY FURNISHED,KITCHEN,AIR CONDITION,HOT WATER,WASHER,WIFI ', 'POOL,FITNESS,SECURITY,MRT', '15_prop_id/01_img.jpg', '15_prop_id/02_img.jpg', '15_prop_id/03_img.jpg', '15_prop_id/04_img.jpg', '15_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(16, 'THE CET ชั้น 18', 13.723811, 100.538346, 'สาทร กรุงเทพฯ', 'condominium', 'FOR RENT AND FOR SELL', 'LEASEHOLD', 39000000, 150000, 8300, 'VINTAGE', 3, 88, 'South', 215, 0, 'FULLY FURNISHED,KITCHEN,AIR CONDITION,HOT WATER,WASHER ', 'POOL,FITNESS,SECURITY,BTS,SUPERMARKET', '16_prop_id/01_img.jpg', '16_prop_id/02_img.jpg', '16_prop_id/03_img.jpg', '16_prop_id/04_img.jpg', '16_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(17, 'คอนโดริมแม่น้ำเจ้าพระยา', 13.683079, 100.508319, 'บางคอแหลม กรุงเทพฯ', 'condominium', 'FOR SELL ONLY', 'FREEHOLD', 47000000, NULL, 3600, 'VINTAGE', 1, 1, 'West', 39, NULL, 'BALCONY,FULLY FURNISHED,KITCHEN,AIR CONDITION,HOT WATER ', 'POOL,FITNESS,SECURITY,BIG C', '17_prop_id/01_img.jpg', '17_prop_id/02_img.jpg', '17_prop_id/03_img.jpg', '17_prop_id/04_img.jpg', '17_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(18, 'THE DOG ชั้น 42', 13.523335, 100.671782, 'บางปู สมุทรปราการ', 'condominium', 'FOR SELL ONLY', 'FREEHOLD', 19000000, NULL, 6000, 'MODERN', 2, 2, 'North', 123, NULL, 'FULLY FURNISHED,KITCHEN,AIR CONDITION,HOT WATER,BATHTUB ', 'POOL,FITNESS,SECURITY,ใกล้สถานตากอากาศบางปู', '18_prop_id/01_img.jpg', '18_prop_id/02_img.jpg', '18_prop_id/03_img.jpg', '18_prop_id/04_img.jpg', '18_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(19, 'คอนโดติดทะเล ห้องวิวเกาะช้าง', 12.195738, 102.356079, 'อ.แหลมงอบ ตราด', 'condominium', 'FOR RENT AND FOR SELL', 'FREEHOLD', 17500000, 85000, 3850, 'MODERN', 2, 2, 'South', 76, NULL, 'BALCONY,FULLY FURNISHED,KITCHEN,AIR CONDITION,HOT WATER ', 'POOL,FITNESS,SECURITY,ใกล้เกาะช้าง', '19_prop_id/01_img.jpg', '19_prop_id/02_img.jpg', '19_prop_id/03_img.jpg', '19_prop_id/04_img.jpg', '19_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(20, 'THE DOG ชั้น 29', 13.523335, 100.671782, 'บางปู สมุทรปราการ', 'condominium', 'FOR RENT AND FOR SELL', 'FREEHOLD', 15000000, 70000, 5550, 'MODERN', 2, 2, 'East', 94, NULL, 'FULLY FURNISHED,KITCHEN,AIR CONDITION,HOT WATER,BATHTUB ', 'POOL,FITNESS,SECURITY,ใกล้สถานตากอากาศบางปู', '20_prop_id/01_img.jpg', '20_prop_id/02_img.jpg', '20_prop_id/03_img.jpg', '20_prop_id/04_img.jpg', '20_prop_id/05_img.jpg', '1', '2023-05-25 08:36:58'),
(21, 'MaeMuu', 14.5233352, 120.671782, 'Bangkapi', 'condominium', 'FOR SELL ONLY', 'FREEHOLD', 25000000, 35000000, 9550, 'Cozy', 33, 33, 'North', 25.14, 90.35, 'No one else', 'Bathtub', '21_prop_id\\craftsman-homes-5070211-hero-e13889c50bec48a386a8b51b25f748c1.jpg', '21_prop_id\\download.jpg', '21_prop_id\\images (1).jpg', '21_prop_id\\images.jpg', '21_prop_id\\SuCasaDesign-Modern-9335be77ca0446c7883c5cf8d974e47c.jpg', '10', '0000-00-00 00:00:00'),
(34, 'The Loard', 13.3254, 100.3256, 'Bangruk', 'condominium', 'FOR SELL ONLY', 'FREEHOLD', 1000000000, 500000, 6000, 'Luxury', 3, 5, 'West', 80, 80, 'No one else', 'Bathtub', '22_prop_id/a75a1531.jpg', '22_prop_id/download (1).jpg', '22_prop_id/images (2).jpg', '22_prop_id/low-angle-view-of-signapore-residential-buildings-2023-01-10-06-35-54-utc-min.jpg', '22_prop_id/Luxury-condo.jpg', '10', '2023-05-26 15:25:15'),
(35, 'Khoakun', 14.2612, 100.2544, 'Phetburira', 'land', 'FOR SELL ONLY', 'FREEHOLD', 200, 10, 20, '', 0, 0, '', 400, 100, '', '', '35_prop_id/images(3).jpg', '35_prop_id/images(4).jpg', '35_prop_id/images(5).jpg', '35_prop_id/Landscape-Photography-steps.jpg', '35_prop_id/Travel-photography_4-3.jpg', '1', '2023-05-26 15:32:27');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `role` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `email`, `password`, `name`, `telephone`, `role`) VALUES
(1, 'admin@gmail.com', 'A6xnQhbz4Vx2HuGl4lXwZ5U2I8iziLRFnhP5eNfIRvQ=', 'admin', '0853654885', 'admin'),
(9, 'uu@umail.com', 'kqajL5ne8yLXDqEWepnGhZq06LvFk7mX7FmU0kSoJHU=', 'qwert', '9871', 'user'),
(10, 'gitong23@gmail.com', 'BzNDhih3UboCpFiMGgh129B0phvZ5qt8SNJE6s0MmeA=', 'Maew', '555566988774', 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
