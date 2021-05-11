-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  mar. 11 fév. 2020 à 16:57
-- Version du serveur :  10.4.8-MariaDB
-- Version de PHP :  7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `shop-api`
--

-- --------------------------------------------------------

--
-- Structure de la table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `payment_id` varchar(255) NOT NULL,
  `payment_status` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `payment_id`, `payment_status`, `created_at`) VALUES
(55, 8, 'PAYID-LZBHV7Q8P1185125A344872P', '1', '2020-02-11 10:59:43'),
(56, 8, 'PAYID-LZBHWKY3L513961U5483002D', '1', '2020-02-11 11:00:31'),
(57, 9, 'PAYID-LZBMPJA97034796HV3686729', '1', '2020-02-11 16:26:57');

-- --------------------------------------------------------

--
-- Structure de la table `order_lines`
--

CREATE TABLE `order_lines` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_title` varchar(255) NOT NULL,
  `product_size` varchar(255) NOT NULL,
  `product_count` smallint(6) NOT NULL,
  `product_price` float(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `order_lines`
--

INSERT INTO `order_lines` (`order_id`, `user_id`, `product_id`, `product_title`, `product_size`, `product_count`, `product_price`) VALUES
(55, 8, 2, 'produit 2', 'XS', 1, 12.99),
(56, 8, 1, 'produit 1', 'XXL', 1, 10.00),
(56, 8, 2, 'produit 2', 'XXL', 1, 12.99),
(57, 9, 2, 'produit 2', 'XXL', 1, 12.99),
(57, 9, 3, 'produit 3', 'XXL', 1, 20.99),
(57, 9, 1, 'produit 1', 'XXL', 10, 10.00);

-- --------------------------------------------------------

--
-- Structure de la table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `products`
--

INSERT INTO `products` (`id`, `title`, `description`, `price`) VALUES
(1, 'T-Shirt dgk', '100% coton, ce T-shirt est un must pour l\'été', 9.99),
(2, 'T-Shirt Skull Black', 'Idéal pour vos soirées gothiques', 12.99),
(3, 'T-Shirt Mask', 'Impossible de passer incognito avec ce superbe t-shirt', 20.99),
(4, 'T-Shirt Slunt Blue', 'Un t-shirt super sympa pour toutes les occasions', 16.99),
(5, 'T-Shirt Skull Grey', 'description du produit 5', 18.99),
(6, 'T-Shirt Monkey Grey', 'Parfait pour les défenseurs des droits des animaux', 30.99),
(7, 'T-Shirt Freak Grey', 'Un t-shirt super doux au toucher.', 15.99),
(8, 'T-Shirt Monkey Black', 'Parfait pour les défenseurs des droits des animaux', 25.99),
(9, 'T-Shirt Bunny Grey', 'Vous allez vous sentir pousser des ailes avec ce t-shirt sympa.', 27.99);

-- --------------------------------------------------------

--
-- Structure de la table `product_images`
--

CREATE TABLE `product_images` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `name`, `url`) VALUES
(1, 1, 'produit 1', 'http://localhost/shop-api/assets/uploads/products/produit1.jpg'),
(2, 1, 'produit 1 miniature', 'http://localhost/shop-api/assets/uploads/products/produit1_min.jpg'),
(3, 2, 'produit 2', 'http://localhost/shop-api/assets/uploads/products/produit2.jpg'),
(4, 2, 'produit 2 miniature', 'http://localhost/shop-api/assets/uploads/products/produit2_min.jpg'),
(5, 3, 'produit 3', 'http://localhost/shop-api/assets/uploads/products/produit3.jpg'),
(6, 3, 'produit 3 miniature', 'http://localhost/shop-api/assets/uploads/products/produit3_min.jpg'),
(7, 4, 'produit 4', 'http://localhost/shop-api/assets/uploads/products/produit4.jpg'),
(8, 4, 'produit 4 miniature', 'http://localhost/shop-api/assets/uploads/products/produit4_min.jpg'),
(9, 5, 'produit 5', 'http://localhost/shop-api/assets/uploads/products/produit5.jpg'),
(10, 5, 'produit 5 miniature', 'http://localhost/shop-api/assets/uploads/products/produit5_min.jpg'),
(11, 6, 'produit 6', 'http://localhost/shop-api/assets/uploads/products/produit6.jpg'),
(12, 6, 'produit 6 miniature', 'http://localhost/shop-api/assets/uploads/products/produit6_min.jpg'),
(13, 7, 'produit 7', 'http://localhost/shop-api/assets/uploads/products/produit7.jpg'),
(14, 7, 'produit 7 miniature', 'http://localhost/shop-api/assets/uploads/products/produit7_min.jpg'),
(15, 8, 'produit 8', 'http://localhost/shop-api/assets/uploads/products/produit8.jpg'),
(16, 8, 'produit 8 miniature', 'http://localhost/shop-api/assets/uploads/products/produit8_min.jpg'),
(17, 9, 'produit 9', 'http://localhost/shop-api/assets/uploads/products/produit9.jpg'),
(18, 9, 'produit 9 miniature', 'http://localhost/shop-api/assets/uploads/products/produit9_min.jpg');

-- --------------------------------------------------------

--
-- Structure de la table `product_sizes`
--

CREATE TABLE `product_sizes` (
  `product_id` int(11) NOT NULL,
  `size_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `product_sizes`
--

INSERT INTO `product_sizes` (`product_id`, `size_id`) VALUES
(1, 1),
(1, 3),
(1, 5),
(1, 6),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(3, 3),
(3, 6),
(4, 2),
(4, 3),
(4, 5),
(4, 6),
(5, 1),
(5, 2),
(5, 3),
(6, 1),
(6, 2),
(6, 3),
(6, 4),
(6, 5),
(6, 6),
(7, 1),
(7, 2),
(7, 3),
(7, 6),
(8, 1),
(8, 2),
(8, 3),
(8, 4),
(8, 5),
(8, 6),
(9, 1),
(9, 3),
(9, 4),
(9, 6);

-- --------------------------------------------------------

--
-- Structure de la table `sizes`
--

CREATE TABLE `sizes` (
  `id` int(11) NOT NULL,
  `size` char(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `sizes`
--

INSERT INTO `sizes` (`id`, `size`) VALUES
(1, 'XS'),
(2, 'S'),
(3, 'M'),
(4, 'L'),
(5, 'XL'),
(6, 'XXL');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'USER',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `created_at`) VALUES
(8, 'admin', 'admin@gmail.com', '$2y$13$dDayL4ZLl1KiGrXZ/uDwuuWfXojbauBnIr/YCeVaOhyCy0ZvLNOv6', 'ADMIN', '2020-02-07 14:54:49'),
(9, 'nas', 'nas@gmail.com', '$2y$13$0D7rs2ZEmC5mh9tuMSPCROELTZPkIHA0w7Gls1h0a8nY8T.ycQKBG', 'USER', '2020-02-11 14:49:45');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `order_lines`
--
ALTER TABLE `order_lines`
  ADD KEY `order_lines_ibfk_1` (`order_id`),
  ADD KEY `order_lines_ibfk_2` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Index pour la table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_images_ibfk_1` (`product_id`);

--
-- Index pour la table `product_sizes`
--
ALTER TABLE `product_sizes`
  ADD KEY `product_id` (`product_id`),
  ADD KEY `size_id` (`size_id`);

--
-- Index pour la table `sizes`
--
ALTER TABLE `sizes`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT pour la table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pour la table `sizes`
--
ALTER TABLE `sizes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `order_lines`
--
ALTER TABLE `order_lines`
  ADD CONSTRAINT `order_lines_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_lines_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_lines_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `product_sizes`
--
ALTER TABLE `product_sizes`
  ADD CONSTRAINT `product_sizes_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_sizes_ibfk_2` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
