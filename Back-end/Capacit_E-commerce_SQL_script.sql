-- MySQL Script generated by MySQL Workbench
-- Thu May  4 18:30:15 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Capacit
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Capacit
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Capacit` DEFAULT CHARACTER SET utf8 ;
USE `Capacit` ;

-- -----------------------------------------------------
-- Table `Capacit`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Capacit`.`User` ;

CREATE TABLE IF NOT EXISTS `Capacit`.`User` (
  `id_user` VARCHAR(256) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `active` TINYINT NOT NULL DEFAULT 1,
  `role` VARCHAR(45) NOT NULL,
  `create_time` DATETIME NULL,
  `user_git` VARCHAR(128) NULL,
  `user_linkedin` VARCHAR(128) NULL,
  PRIMARY KEY (`id_user`));


-- -----------------------------------------------------
-- Table `Capacit`.`Teacher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Capacit`.`Teacher` ;

CREATE TABLE IF NOT EXISTS `Capacit`.`Teacher` (
  `user_id_user` VARCHAR(256) NOT NULL,
  `dni` VARCHAR(16) NULL,
  PRIMARY KEY (`user_id_user`),
  INDEX `fk_teacher_user1_idx` (`user_id_user` ASC) VISIBLE,
  CONSTRAINT `fk_teacher_user1`
    FOREIGN KEY (`user_id_user`)
    REFERENCES `Capacit`.`User` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Capacit`.`Course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Capacit`.`Course` ;

CREATE TABLE IF NOT EXISTS `Capacit`.`Course` (
  `id_course` VARCHAR(256) NOT NULL,
  `name` VARCHAR(16) NOT NULL,
  `language` VARCHAR(45) NOT NULL,
  `tag_1` VARCHAR(45) NULL,
  `tag_2` VARCHAR(45) NULL,
  `link` VARCHAR(45) NULL,
  `Teacher_user_id_user` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`id_course`, `Teacher_user_id_user`),
  INDEX `fk_Course_Teacher1_idx` (`Teacher_user_id_user` ASC) VISIBLE,
  CONSTRAINT `fk_Course_Teacher1`
    FOREIGN KEY (`Teacher_user_id_user`)
    REFERENCES `Capacit`.`Teacher` (`user_id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Capacit`.`Video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Capacit`.`Video` ;

CREATE TABLE IF NOT EXISTS `Capacit`.`Video` (
  `id_video` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  `blob` LONGBLOB NULL,
  `Course_id_course` VARCHAR(256) NOT NULL,
  `Course_Teacher_user_id_user` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`id_video`, `Course_id_course`, `Course_Teacher_user_id_user`),
  INDEX `fk_Video_Course1_idx` (`Course_id_course` ASC, `Course_Teacher_user_id_user` ASC) VISIBLE,
  CONSTRAINT `fk_Video_Course1`
    FOREIGN KEY (`Course_id_course` , `Course_Teacher_user_id_user`)
    REFERENCES `Capacit`.`Course` (`id_course` , `Teacher_user_id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Capacit`.`Student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Capacit`.`Student` ;

CREATE TABLE IF NOT EXISTS `Capacit`.`Student` (
  `user_id_user` VARCHAR(256) NOT NULL,
  `user_vip` TINYINT NOT NULL,
  PRIMARY KEY (`user_id_user`),
  INDEX `fk_alumne_user1_idx` (`user_id_user` ASC) VISIBLE,
  CONSTRAINT `fk_alumne_user1`
    FOREIGN KEY (`user_id_user`)
    REFERENCES `Capacit`.`User` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Capacit`.`Sale`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Capacit`.`Sale` ;

CREATE TABLE IF NOT EXISTS `Capacit`.`Sale` (
  `id_sale` VARCHAR(256) NOT NULL,
  `state` VARCHAR(30) NULL,
  `discount` FLOAT NULL,
  `value` FLOAT NOT NULL,
  `Student_user_id_user` VARCHAR(256) NOT NULL,
  `Course_id_course` VARCHAR(256) NOT NULL,
  `Course_Teacher_user_id_user` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`id_sale`),
  INDEX `fk_Venta_Student1_idx` (`Student_user_id_user` ASC) VISIBLE,
  INDEX `fk_Sale_Course1_idx` (`Course_id_course` ASC, `Course_Teacher_user_id_user` ASC) VISIBLE,
  CONSTRAINT `fk_Venta_Student1`
    FOREIGN KEY (`Student_user_id_user`)
    REFERENCES `Capacit`.`Student` (`user_id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sale_Course1`
    FOREIGN KEY (`Course_id_course` , `Course_Teacher_user_id_user`)
    REFERENCES `Capacit`.`Course` (`id_course` , `Teacher_user_id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Capacit`.`Payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Capacit`.`Payment` ;

CREATE TABLE IF NOT EXISTS `Capacit`.`Payment` (
  `id_payment` VARCHAR(256) NOT NULL,
  `date` DATETIME NOT NULL,
  `total` FLOAT NOT NULL,
  `Sale_id_sale` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`id_payment`, `Sale_id_sale`),
  INDEX `fk_Payment_Sale1_idx` (`Sale_id_sale` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Sale1`
    FOREIGN KEY (`Sale_id_sale`)
    REFERENCES `Capacit`.`Sale` (`id_sale`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
