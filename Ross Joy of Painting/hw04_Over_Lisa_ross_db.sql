-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ross_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ross_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ross_db` ;
USE `ross_db` ;

-- -----------------------------------------------------
-- Table `ross_db`.`artists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ross_db`.`artists` (
  `artist_id` INT NOT NULL,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(30) NOT NULL,
  `relationship` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`artist_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ross_db`.`features`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ross_db`.`features` (
  `feature_id` INT NOT NULL,
  `feature` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`feature_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ross_db`.`episodes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ross_db`.`episodes` (
  `season_id` INT NOT NULL,
  `episode_id` INT NOT NULL,
  `painting_title` VARCHAR(255) NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`season_id`, `episode_id`),
  INDEX `fk_episodes_artists1_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_episodes_artists`
    FOREIGN KEY (`artist_id`)
    REFERENCES `ross_db`.`artists` (`artist_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ross_db`.`features_in_paintings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ross_db`.`features_in_paintings` (
  `season_id` INT NOT NULL,
  `episode_id` INT NOT NULL,
  `feature_id` INT NOT NULL,
  PRIMARY KEY (`season_id`, `episode_id`, `feature_id`),
  INDEX `fk_features_in_paintings_episodes1_idx` (`season_id` ASC, `episode_id` ASC) VISIBLE,
  INDEX `fk_features_in_paintings_features1_idx` (`feature_id` ASC) VISIBLE,
  CONSTRAINT `fk_features_in_paintings_episodes`
    FOREIGN KEY (`season_id` , `episode_id`)
    REFERENCES `ross_db`.`episodes` (`season_id` , `episode_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_features_in_paintings_features`
    FOREIGN KEY (`feature_id`)
    REFERENCES `ross_db`.`features` (`feature_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
