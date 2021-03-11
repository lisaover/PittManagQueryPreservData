-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema lahman_batting
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lahman_batting
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lahman_batting` DEFAULT CHARACTER SET utf8 ;
USE `lahman_batting` ;

-- -----------------------------------------------------
-- Table `lahman_batting`.`players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lahman_batting`.`players` (
  `playerID` VARCHAR(50) NOT NULL,
  `nameFirst` VARCHAR(50) NOT NULL,
  `nameLast` VARCHAR(50) NOT NULL,
  `nameGiven` VARCHAR(50) NULL,
  `birthDate` DATE NULL,
  `debut` DATE NULL,
  `finalGame` DATE NULL,
  `bats` CHAR(1) NULL,
  `throws` CHAR(1) NULL,
  PRIMARY KEY (`playerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lahman_batting`.`league_teams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lahman_batting`.`league_teams` (
  `lgID` CHAR(2) NOT NULL,
  `teamID` CHAR(3) NOT NULL,
  `team_name` VARCHAR(255) NULL,
  PRIMARY KEY (`lgID`, `teamID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lahman_batting`.`players_on_teams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lahman_batting`.`players_on_teams` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `playerID` VARCHAR(50) NOT NULL,
  `year` INT NOT NULL,
  `teamID` CHAR(3) NOT NULL,
  `lgID` CHAR(2) NOT NULL,
  `G` INT NULL,
  `AB` INT NULL,
  `H` INT NULL,
  `HR` INT NULL,
  INDEX `fk_players_on_teams_players_idx` (`playerID` ASC) VISIBLE,
  INDEX `fk_players_on_teams_league_teams1_idx` (`lgID` ASC, `teamID` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_players_on_teams_players`
    FOREIGN KEY (`playerID`)
    REFERENCES `lahman_batting`.`players` (`playerID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_players_on_teams_league_teams`
    FOREIGN KEY (`lgID` , `teamID`)
    REFERENCES `lahman_batting`.`league_teams` (`lgID` , `teamID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
