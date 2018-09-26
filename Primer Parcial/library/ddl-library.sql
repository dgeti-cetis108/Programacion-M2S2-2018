CREATE DATABASE `library`;
USE `library`;

CREATE TABLE `users` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(20) NOT NULL UNIQUE,
    `password` VARCHAR(200) NOT NULL,
    `firstname` VARCHAR(50) NOT NULL,
    `lastname` VARCHAR(50) NOT NULL,
    `email` VARCHAR(200) NOT NULL UNIQUE
) ENGINE=InnoDB, CHARSET=utf8, COLLATE=utf8_general_ci;

CREATE TABLE `countries` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL UNIQUE,
    `capital` VARCHAR(100) DEFAULT NULL
) ENGINE=InnoDB, CHARSET=utf8, COLLATE=utf8_general_ci;

CREATE TABLE `authors` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `firstname` VARCHAR(50) NOT NULL,
    `lastname` VARCHAR(50) NOT NULL,
    `age` TINYINT UNSIGNED DEFAULT NULL
) ENGINE=InnoDB, CHARSET=utf8, COLLATE=utf8_general_ci;

CREATE TABLE `editorials` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(200) NOT NULL,
    `website` VARCHAR(200) NOT NULL,
    `phone_number` VARCHAR(30) NOT NULL,
    `country_id` INT NOT NULL,
    CONSTRAINT `fk_editorials_countries`
        FOREIGN KEY (`country_id`)
        REFERENCES `countries` (`id`)
            ON UPDATE CASCADE
            ON DELETE RESTRICT
) ENGINE=InnoDB, CHARSET=utf8, COLLATE=utf8_general_ci;

CREATE TABLE `books` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(200) NOT NULL,
    `isbn` VARCHAR(20) DEFAULT NULL,
    `author_id` INT NOT NULL,
    `editorial_id` INT NOT NULL,
    CONSTRAINT `fk_books_authors`
        FOREIGN KEY (`author_id`)
        REFERENCES `authors` (`id`)
            ON UPDATE CASCADE
            ON DELETE RESTRICT,
    CONSTRAINT `fk_books_editorials`
        FOREIGN KEY (`editorial_id`)
        REFERENCES `editorials` (`id`)
            ON UPDATE CASCADE
            ON DELETE RESTRICT
) ENGINE=InnoDB, CHARSET=utf8, COLLATE=utf8_general_ci;