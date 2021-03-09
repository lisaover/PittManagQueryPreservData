-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema shoes_w06
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema shoes_w06
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `shoes_w06` DEFAULT CHARACTER SET utf8 ;
USE `shoes_w06` ;

-- -----------------------------------------------------
-- Table `shoes_w06`.`shoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shoes_w06`.`shoes` (
  `shoe_id` INT NOT NULL,
  `color` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`shoe_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shoes_w06`.`stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shoes_w06`.`stores` (
  `store_id` INT NOT NULL,
  `store_name` VARCHAR(255) NOT NULL,
  `street_number` VARCHAR(50) NOT NULL,
  `street_name` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `zip` INT NOT NULL,
  PRIMARY KEY (`store_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shoes_w06`.`shoe_in_store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shoes_w06`.`shoe_in_store` (
  `shoe_id` INT NOT NULL,
  `store_id` INT NOT NULL,
  `day` INT NOT NULL,
  `count` INT NULL,
  INDEX `fk_shoe_in_store_shoes_idx` (`shoe_id` ASC) VISIBLE,
  INDEX `fk_shoe_in_store_stores1_idx` (`store_id` ASC) VISIBLE,
  PRIMARY KEY (`shoe_id`, `store_id`, `day`),
  CONSTRAINT `fk_shoe_in_store_shoes`
    FOREIGN KEY (`shoe_id`)
    REFERENCES `shoes_w06`.`shoes` (`shoe_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_shoe_in_store_stores`
    FOREIGN KEY (`store_id`)
    REFERENCES `shoes_w06`.`stores` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shoes_w06`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shoes_w06`.`tags` (
  `tag_id` INT NOT NULL,
  `tag_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`tag_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shoes_w06`.`store_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shoes_w06`.`store_tags` (
  `store_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  INDEX `fk_store_tags_stores1_idx` (`store_id` ASC) VISIBLE,
  INDEX `fk_store_tags_tags1_idx` (`tag_id` ASC) VISIBLE,
  PRIMARY KEY (`store_id`, `tag_id`),
  CONSTRAINT `fk_store_tags_stores`
    FOREIGN KEY (`store_id`)
    REFERENCES `shoes_w06`.`stores` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_store_tags_tags`
    FOREIGN KEY (`tag_id`)
    REFERENCES `shoes_w06`.`tags` (`tag_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
