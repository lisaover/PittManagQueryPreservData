-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hw04_bob_ross_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hw04_bob_ross_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hw04_bob_ross_db` DEFAULT CHARACTER SET utf8 ;
USE `hw04_bob_ross_db` ;

-- -----------------------------------------------------
-- Table `hw04_bob_ross_db`.`seasons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw04_bob_ross_db`.`seasons` (
  `season_id` INT NOT NULL,
  PRIMARY KEY (`season_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hw04_bob_ross_db`.`artists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw04_bob_ross_db`.`artists` (
  `artist_id` INT NOT NULL,
  `artist_name` VARCHAR(255) NULL,
  PRIMARY KEY (`artist_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hw04_bob_ross_db`.`paintings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw04_bob_ross_db`.`paintings` (
  `painting_id` INT NOT NULL,
  `episode_id` INT NULL,
  `title` VARCHAR(255) NULL,
  `artist_id` INT NOT NULL,
  `season_id` INT NOT NULL,
  PRIMARY KEY (`painting_id`),
  INDEX `fk_paintings_artists_idx` (`artist_id` ASC) VISIBLE,
  INDEX `fk_paintings_seasons1_idx` (`season_id` ASC) VISIBLE,
  CONSTRAINT `fk_paintings_artists`
    FOREIGN KEY (`artist_id`)
    REFERENCES `hw04_bob_ross_db`.`artists` (`artist_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_paintings_seasons`
    FOREIGN KEY (`season_id`)
    REFERENCES `hw04_bob_ross_db`.`seasons` (`season_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hw04_bob_ross_db`.`features`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw04_bob_ross_db`.`features` (
  `feature_id` INT NOT NULL,
  `feature_name` VARCHAR(255) NULL,
  PRIMARY KEY (`feature_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hw04_bob_ross_db`.`features_in_paintings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw04_bob_ross_db`.`features_in_paintings` (
  `features_feature_id` INT NOT NULL,
  `paintings_painting_id` INT NOT NULL,
  INDEX `fk_features_in_paintings_features1_idx` (`features_feature_id` ASC) VISIBLE,
  INDEX `fk_features_in_paintings_paintings1_idx` (`paintings_painting_id` ASC) VISIBLE,
  CONSTRAINT `fk_features_in_paintings_features`
    FOREIGN KEY (`features_feature_id`)
    REFERENCES `hw04_bob_ross_db`.`features` (`feature_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_features_in_paintings_paintings`
    FOREIGN KEY (`paintings_painting_id`)
    REFERENCES `hw04_bob_ross_db`.`paintings` (`painting_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
