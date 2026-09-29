-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 29, 2026 at 08:32 AM
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
-- Database: `biashara_inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_07_08_000001_add_role_to_users_table', 1),
(5, '2026_07_08_000002_create_products_table', 1),
(6, '2026_07_08_000003_create_stock_receipts_table', 1),
(7, '2026_07_08_000004_create_sales_table', 1),
(8, '2026_07_08_000005_create_sale_items_table', 1),
(9, '2026_09_13_082219_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'biashara-frontend', '8bf7ba73abecf954a7639d85102b9df387bd3e1672c3ce04b016696cd2c381a7', '[\"*\"]', NULL, NULL, '2026-09-14 15:15:02', '2026-09-14 15:15:02'),
(2, 'App\\Models\\User', 1, 'biashara-frontend', 'd6466eaa6cd55f109626b08246c865bfaf0fbedf8ae46b5dbfc9484beb316947', '[\"*\"]', NULL, NULL, '2026-09-14 15:17:15', '2026-09-14 15:17:15'),
(3, 'App\\Models\\User', 1, 'biashara-frontend', '1514f03ed46490f5b14ea556d6e744ef3d786c1e4af449f5f5757cc489e7b397', '[\"*\"]', NULL, NULL, '2026-09-14 15:17:19', '2026-09-14 15:17:19'),
(4, 'App\\Models\\User', 1, 'biashara-frontend', '4c3f6a43758a52c6e1c1d7d79ba2577778ff14ae3efa95f1dea2aaeede08dfd4', '[\"*\"]', NULL, NULL, '2026-09-14 15:19:04', '2026-09-14 15:19:04'),
(5, 'App\\Models\\User', 1, 'biashara-frontend', '840f5a41e351333857c8c2d2e4cb1c472bec225e4377fa3eabebbcc4e2464551', '[\"*\"]', NULL, NULL, '2026-09-14 15:25:37', '2026-09-14 15:25:37'),
(6, 'App\\Models\\User', 1, 'biashara-frontend', 'dfb28dcb07e4839c0c144bb9ecaa97cf42923e1c2df39244770b4e51bdf6a0dc', '[\"*\"]', NULL, NULL, '2026-09-14 15:28:04', '2026-09-14 15:28:04'),
(7, 'App\\Models\\User', 1, 'biashara-frontend', 'bbf5b46b24b90c93ca78aa90ea889879e9d4a8fa5d069df974fb552e08214cfa', '[\"*\"]', NULL, NULL, '2026-09-14 15:28:07', '2026-09-14 15:28:07'),
(8, 'App\\Models\\User', 1, 'biashara-frontend', '5a8ca0294b1f583dd955e6e87761f9735dabddbcee0a3bf9d8e56e44979a9d07', '[\"*\"]', NULL, NULL, '2026-09-14 15:51:36', '2026-09-14 15:51:36'),
(9, 'App\\Models\\User', 1, 'biashara-frontend', 'c489f1fef37b6df0c9500d10831b4a42b3a79b87fbf82afaf9c50ec8cb4c3820', '[\"*\"]', NULL, NULL, '2026-09-14 15:51:40', '2026-09-14 15:51:40'),
(10, 'App\\Models\\User', 1, 'biashara-frontend', 'b17b034d686ec4fcb6fb80fcdc3ed70e5bb2d63f95bcb6ef6c0fd5454b8b9e55', '[\"*\"]', NULL, NULL, '2026-09-14 15:55:26', '2026-09-14 15:55:26'),
(11, 'App\\Models\\User', 1, 'biashara-frontend', '932e675a3e221dd49f7f36ba789e95096c0a0747cc951a53ba6ad0d65cfd73bb', '[\"*\"]', NULL, NULL, '2026-09-14 15:55:29', '2026-09-14 15:55:29'),
(12, 'App\\Models\\User', 1, 'biashara-frontend', '00ecd47ba422c8ee709aa0c334735488d29de1bc75bb971b1a2c39491a1c189c', '[\"*\"]', NULL, NULL, '2026-09-14 15:55:32', '2026-09-14 15:55:32'),
(13, 'App\\Models\\User', 1, 'biashara-frontend', 'df2f6cb8a40c46b7d839b032a04241a505b6a568223f3029ffdafa58bd7deb94', '[\"*\"]', NULL, NULL, '2026-09-14 15:57:23', '2026-09-14 15:57:23'),
(14, 'App\\Models\\User', 1, 'biashara-frontend', '800a7580b1c791e8a9d57aed10b51ff92d9e295610fed449423535f73d6838d9', '[\"*\"]', NULL, NULL, '2026-09-14 16:05:44', '2026-09-14 16:05:44'),
(15, 'App\\Models\\User', 1, 'biashara-frontend', '6319b9572f47f93224f2af5b66589690dea18b58f8c50d8aa267fc21cfda07d1', '[\"*\"]', NULL, NULL, '2026-09-14 16:12:20', '2026-09-14 16:12:20'),
(16, 'App\\Models\\User', 1, 'biashara-frontend', '5b91c08dc0a5697ae7e1067c825e628a5117d21db78f5099e309a829959faa4a', '[\"*\"]', NULL, NULL, '2026-09-14 16:16:17', '2026-09-14 16:16:17'),
(19, 'App\\Models\\User', 1, 'biashara-frontend', 'aa684fc6749126c4bd9083a3069f62eb6f91e5921d38d506a9f40450664d735f', '[\"*\"]', '2026-09-14 16:20:44', NULL, '2026-09-14 16:20:28', '2026-09-14 16:20:44'),
(23, 'App\\Models\\User', 2, 'biashara-frontend', 'a266846fbf368af6187b03635f2adba4a6f5b70a38b7750a28afab1cdc6986ee', '[\"*\"]', '2026-09-16 08:49:49', NULL, '2026-09-16 08:49:47', '2026-09-16 08:49:49'),
(29, 'App\\Models\\User', 1, 'biashara-frontend', '3775cfeb3080cf053eb76aa00dfb377bf0c0ea0942e15653b09f889b41fc6267', '[\"*\"]', '2026-09-17 09:31:04', NULL, '2026-09-17 09:30:39', '2026-09-17 09:31:04'),
(30, 'App\\Models\\User', 1, 'biashara-frontend', '3a905e647e4aa3b7f67300ee318751ef40d276607418b1081de50221f6f84be5', '[\"*\"]', '2026-09-18 07:17:49', NULL, '2026-09-18 07:17:34', '2026-09-18 07:17:49'),
(34, 'App\\Models\\User', 2, 'biashara-frontend', '3d753c09cf939a89fe08b4d408b01b0f4bbb2be28add9db46857e56defcb7518', '[\"*\"]', '2026-09-21 03:09:37', NULL, '2026-09-21 03:08:43', '2026-09-21 03:09:37');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `unit_price` int(10) UNSIGNED NOT NULL,
  `reorder_level` int(10) UNSIGNED NOT NULL,
  `quantity_in_stock` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `category`, `unit_price`, `reorder_level`, `quantity_in_stock`, `created_at`, `updated_at`) VALUES
(1, 'Unga wa Ngano 2kg', 'Groceries', 220, 15, 8, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(2, 'Cooking Oil 1L', 'Groceries', 320, 10, 3, '2026-09-13 05:42:14', '2026-09-17 09:30:09'),
(3, 'Sugar 2kg', 'Groceries', 260, 20, 42, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(4, 'Bar Soap (Green)', 'Household', 60, 25, 68, '2026-09-13 05:42:14', '2026-09-21 03:08:03'),
(5, 'Rice (Pishori) 2kg', 'Groceries', 280, 15, 30, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(6, 'Maziwa Fresh 500ml', 'Beverages', 65, 30, 68, '2026-09-13 05:42:14', '2026-09-16 08:16:37'),
(7, 'Exercise Book 200pg', 'Stationery', 55, 20, 50, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(8, 'Toothpaste 100g', 'Household', 130, 15, 3, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(9, 'Blue Band 500g', 'Groceries', 310, 10, 14, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(10, 'Airtime Scratch Card 100', 'Other', 100, 40, 52, '2026-09-13 05:42:14', '2026-09-21 02:55:09');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `total` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `user_id`, `total`, `created_at`, `updated_at`) VALUES
(1, 2, 645, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(2, 3, 320, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(3, 2, 260, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(4, 2, 195, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(5, 3, 780, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(6, 2, 300, '2026-09-16 08:15:52', '2026-09-16 08:15:52'),
(7, 2, 320, '2026-09-17 09:30:09', '2026-09-17 09:30:09'),
(8, 1, 100, '2026-09-21 02:52:50', '2026-09-21 02:52:50');

-- --------------------------------------------------------

--
-- Table structure for table `sale_items`
--

CREATE TABLE `sale_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity_sold` int(10) UNSIGNED NOT NULL,
  `unit_price_at_sale` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_items`
--

INSERT INTO `sale_items` (`id`, `sale_id`, `product_id`, `quantity_sold`, `unit_price_at_sale`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 220, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(2, 1, 6, 2, 65, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(3, 1, 4, 5, 60, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(4, 2, 2, 1, 320, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(5, 3, 3, 1, 260, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(6, 4, 4, 1, 60, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(7, 4, 6, 2, 65, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(8, 5, 5, 2, 280, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(9, 5, 9, 1, 310, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(10, 6, 10, 3, 100, '2026-09-16 08:15:52', '2026-09-16 08:15:52'),
(11, 7, 2, 1, 320, '2026-09-17 09:30:09', '2026-09-17 09:30:09'),
(12, 8, 10, 1, 100, '2026-09-21 02:52:50', '2026-09-21 02:52:50');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_receipts`
--

CREATE TABLE `stock_receipts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `quantity_received` int(10) UNSIGNED NOT NULL,
  `date_received` date NOT NULL,
  `supplier_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stock_receipts`
--

INSERT INTO `stock_receipts` (`id`, `product_id`, `user_id`, `quantity_received`, `date_received`, `supplier_name`, `created_at`, `updated_at`) VALUES
(1, 3, 1, 40, '2026-06-28', 'Mumias Sugar Distributors', '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(2, 5, 1, 30, '2026-06-30', 'Pishori Wholesalers Ltd', '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(3, 7, 2, 50, '2026-07-01', 'Elite Stationers', '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(4, 1, 1, 20, '2026-07-02', 'Unga Millers Co.', '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(5, 6, 2, 50, '2026-09-16', 'Brookside Distributors Limited', '2026-09-16 08:16:37', '2026-09-16 08:16:37'),
(6, 10, 1, 50, '2026-09-21', 'Telecommunications Limited', '2026-09-21 02:55:09', '2026-09-21 02:55:09'),
(7, 4, 1, 56, '2026-09-21', 'Menengai Distributors', '2026-09-21 03:08:03', '2026-09-21 03:08:03');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `role` enum('Owner','Attendant') NOT NULL DEFAULT 'Attendant',
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `role`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Nick Kiprotich', 'nick.owner', 'Owner', 'nick.owner@biashara.test', NULL, '$2y$12$R2fsqLpvMuHqa14t4s9dUuaPZuWiKwE6TdOXz5DiG9E89/83/rmdu', NULL, '2026-09-13 05:42:13', '2026-09-13 05:42:13'),
(2, 'Faith Wanjiru', 'faith.attendant', 'Attendant', 'faith.attendant@biashara.test', NULL, '$2y$12$RZf6sUrRnAHD4oBbBQqUo.xGbYnE9IG3j70hwAWe/Ui2t8roNUfHG', NULL, '2026-09-13 05:42:14', '2026-09-13 05:42:14'),
(3, 'Brian Otieno', 'brian.attendant', 'Attendant', 'brian.attendant@biashara.test', NULL, '$2y$12$xfTkc8ts8yeR1gh3r5yfru5QbH3dBDdRZEL6FR0fi8VgN5xC437uy', NULL, '2026-09-13 05:42:14', '2026-09-13 05:42:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sales_user_id_foreign` (`user_id`);

--
-- Indexes for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_items_sale_id_foreign` (`sale_id`),
  ADD KEY `sale_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `stock_receipts`
--
ALTER TABLE `stock_receipts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stock_receipts_product_id_foreign` (`product_id`),
  ADD KEY `stock_receipts_user_id_foreign` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `sale_items`
--
ALTER TABLE `sale_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `stock_receipts`
--
ALTER TABLE `stock_receipts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD CONSTRAINT `sale_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sale_items_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `stock_receipts`
--
ALTER TABLE `stock_receipts`
  ADD CONSTRAINT `stock_receipts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stock_receipts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
