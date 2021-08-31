CREATE DATABASE IF NOT EXISTS `alpha`;
USE `alpha`;

DROP TABLE IF EXISTS `players`;
CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(50) NOT NULL,
  `skin` text DEFAULT NULL,
  `accounts` text NOT NULL,
  `identity` text NOT NULL,
  `inv` text NOT NULL,
  `pos` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `license` (`license`)
);

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `perm_level` int(11) NOT NULL,
  `job` varchar(255) NOT NULL,
  `job_grade` varchar(255) NOT NULL,

  PRIMARY KEY (`id`)
);