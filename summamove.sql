-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Gegenereerd op: 17 jun 2024 om 13:22
-- Serverversie: 10.4.27-MariaDB
-- PHP-versie: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `summamove`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `failed_jobs`
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
-- Tabelstructuur voor tabel `jobs`
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
-- Tabelstructuur voor tabel `job_batches`
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
-- Tabelstructuur voor tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2024_06_03_112714_create_oefeningen_table', 1),
(6, '2024_06_06_070932_create_personal_access_tokens_table', 1),
(7, '2024_06_03_112723_create_prestaties_table', 2);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `oefeningen`
--

CREATE TABLE `oefeningen` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `naam` varchar(255) NOT NULL,
  `beschrijvingNL` varchar(255) NOT NULL,
  `beschrijvingEN` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `oefeningen`
--

INSERT INTO `oefeningen` (`id`, `naam`, `beschrijvingNL`, `beschrijvingEN`) VALUES
(1, 'Squat', 'Begin in een plankpositie met je handen op schouderbreedte. Buig je ellebogen om je lichaam naar de grond te brengen en duw jezelf weer omhoog.', 'Start in a plank position with your hands shoulder-width apart. Bend your elbows to lower your body to the ground and push yourself back up.'),
(2, 'Push-up', 'Begin in een plankpositie met je handen op schouderbreedte. Buig je ellebogen om je lichaam naar de grond te brengen en duw jezelf weer omhoog.', 'Start in a plank position with your hands shoulder-width apart. Bend your elbows to lower your body to the ground and push yourself back up.'),
(3, 'Dip', 'Gebruik een stevige rand of stoel. Plaats je handen erachter en je voeten voor je. Buig je ellebogen om je lichaam naar beneden te brengen en duw jezelf weer omhoog.', 'Use a sturdy edge or chair. Place your hands behind you and your feet in front. Bend your elbows to lower your body and push yourself back up.'),
(4, 'Plank', 'Begin in een plankpositie met je ellebogen op de grond en je lichaam in een rechte lijn. Houd deze positie zo lang mogelijk vast.', 'Start in a plank position with your elbows on the ground and your body in a straight line. Hold this position for as long as possible.'),
(5, 'Paardentrap', 'Begin op handen en knieën. Trap een been krachtig naar achteren en omhoog, alsof je een paard nadoet.', 'Start on your hands and knees. Kick one leg powerfully backward and upward, imitating a donkey kick.'),
(6, 'Mountain climber', 'Begin in een plankpositie. Breng afwisselend je knieën naar je borst in een lopende beweging.', 'Start in a plank position. Alternately bring your knees to your chest in a running motion.'),
(7, 'Burpee', 'Begin rechtop, squat naar de grond en plaats je handen op de vloer. Spring je voeten naar achteren in een plankpositie, doe een push-up, spring je voeten terug naar je handen en spring omhoog.', 'Start upright, squat down, and place your hands on the floor. Jump your feet back into a plank position, do a push-up, jump your feet back to your hands, and jump up.'),
(8, 'Lunge', 'Sta rechtop en stap een voet naar voren. Buig beide knieën om je achterste knie naar de grond te brengen, houd je voorste knie boven je enkel. Keer terug naar de startpositie en wissel van been.', 'Stand upright and step one foot forward. Bend both knees to lower your back knee toward the ground, keeping your front knee over your ankle. Return to the start position and switch legs.'),
(9, 'Wall sit', 'Leun met je rug tegen een muur en zak door je knieën alsof je op een onzichtbare stoel zit. Houd deze positie vast.', 'Lean against a wall and lower yourself into a seated position as if sitting on an invisible chair. Hold this position.'),
(10, 'Crunch', 'Ga op je rug liggen met je knieën gebogen. Plaats je handen achter je hoofd en til je schouders van de grond door je buikspieren aan te spannen.', 'Lie on your back with your knees bent. Place your hands behind your head and lift your shoulders off the ground by contracting your abdominal muscles.');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(55, 'App\\Models\\User', 3, 'API Token', 'e210d0887860bdedfd576baa07fd1081016f64c2291dd3bcbdf62f80e40c9a9e', '[\"*\"]', '2024-06-13 07:54:36', NULL, '2024-06-13 07:54:35', '2024-06-13 07:54:36'),
(138, 'App\\Models\\User', 1, 'API Token', 'f94607babd9c4c6fa73f821474a154dfd882cec639e5225df65ad1af235ec041', '[\"*\"]', '2024-06-14 07:51:23', NULL, '2024-06-14 07:51:23', '2024-06-14 07:51:23'),
(139, 'App\\Models\\User', 1, 'API Token', 'b8bf9cc4b0ed7be01d6ce4228784b4fd555b5887ecccc76325da4c6d9e5251da', '[\"*\"]', '2024-06-14 09:04:16', NULL, '2024-06-14 09:04:16', '2024-06-14 09:04:16'),
(140, 'App\\Models\\User', 1, 'API Token', '89569d1dc407adc5000864e12e7df0bdd90171ccaae2388b82db1c6e20862503', '[\"*\"]', '2024-06-14 09:04:37', NULL, '2024-06-14 09:04:37', '2024-06-14 09:04:37'),
(141, 'App\\Models\\User', 1, 'API Token', 'eca733ced1ebbfdf6a09aa60e6d70dcfc4a769a6b85db3fd06c2c8cf66224e80', '[\"*\"]', NULL, NULL, '2024-06-14 09:12:32', '2024-06-14 09:12:32'),
(142, 'App\\Models\\User', 1, 'API Token', '64ad12cf3e9342d27cfa6d14e8b36d3a1a5e81d4389518f5a02e99e7568cc945', '[\"*\"]', '2024-06-14 09:26:37', NULL, '2024-06-14 09:19:45', '2024-06-14 09:26:37'),
(143, 'App\\Models\\User', 1, 'API Token', '7d05a72281a6df159d22bb331c730727b299f42442106c03d5283c2fcc51aa20', '[\"*\"]', '2024-06-14 09:27:07', NULL, '2024-06-14 09:26:44', '2024-06-14 09:27:07');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `prestaties`
--

CREATE TABLE `prestaties` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `gebruikerId` bigint(20) UNSIGNED NOT NULL,
  `oefeningId` bigint(20) UNSIGNED NOT NULL,
  `datum` varchar(255) NOT NULL,
  `aantal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('SAP3FBRgcMy9LQZqDMLPdC1ToNLPgI1x6WJgwFvq', NULL, '127.0.0.1', 'PostmanRuntime/7.37.3', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia2FlOVpiaE1yTUVBSkxnYk02NjVVZUREb1F3REhRc3BOVmNzQUpOMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1717680583),
('wvILgjnaYPYpbxVDonzYerSeKElcKE4JPhhCJosF', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:126.0) Gecko/20100101 Firefox/126.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicUJCcUpoN2VnU2lETmE0NUN3MFhuVWViTEpWQU42MEZjbmh6bTZkZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1717753495);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@admin.nl', NULL, '$2y$12$hR2bU8.4LlQ1PmeXgzjY2e9sbvtIr6/tlYtFxzTTuuShpkNMjL9hq', NULL, '2024-06-06 10:07:59', '2024-06-06 10:07:59'),
(3, 'testUser', 'test@user.nl', NULL, '$2y$12$JKz1Q9ZTB.r8FTNPGSkGuuE55k2tcd0idzDbj0nqJot3UIpxwJsVq', NULL, '2024-06-06 11:15:03', '2024-06-06 11:15:03'),
(4, 'testUser3', 'test3@user.nl', NULL, '$2y$12$e2dkAvTFUmQ7ddNFGdRg7uf8WVrNMikLs/ryTKGWyH20IJqck4E92', NULL, '2024-06-11 10:30:14', '2024-06-11 10:51:50'),
(5, 'testUser4', 'test4@user.nl', NULL, '$2y$12$aeO1Q9utZfqt2aYDQGPY4ubz2VMzEgNBXB1hO0UtkN9Qu7OiW1NSO', NULL, '2024-06-11 10:53:18', '2024-06-11 10:53:18'),
(6, 'testUser5', 'test5@user.nl', NULL, '$2y$12$6r5IsP1NYn1SmxbLooCilu3RXae8xHptArbyFylQoLMYzztHjFWhS', NULL, '2024-06-11 10:56:05', '2024-06-11 10:56:05'),
(7, 'testUser6', 'test6@user.nl', NULL, '$2y$12$IPSiIYoPA9a7K3YKmA5XD.bjZ0W8AfD/JpuzXQERnj6RwbPBQRcpi', NULL, '2024-06-11 10:58:18', '2024-06-11 10:58:18');

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexen voor tabel `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexen voor tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexen voor tabel `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexen voor tabel `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `oefeningen`
--
ALTER TABLE `oefeningen`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexen voor tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexen voor tabel `prestaties`
--
ALTER TABLE `prestaties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `prestaties_gebruikerid_foreign` (`gebruikerId`),
  ADD KEY `prestaties_oefeningid_foreign` (`oefeningId`);

--
-- Indexen voor tabel `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexen voor tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT voor een tabel `oefeningen`
--
ALTER TABLE `oefeningen`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT voor een tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;

--
-- AUTO_INCREMENT voor een tabel `prestaties`
--
ALTER TABLE `prestaties`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT voor een tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `prestaties`
--
ALTER TABLE `prestaties`
  ADD CONSTRAINT `prestaties_gebruikerid_foreign` FOREIGN KEY (`gebruikerId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `prestaties_oefeningid_foreign` FOREIGN KEY (`oefeningId`) REFERENCES `oefeningen` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
