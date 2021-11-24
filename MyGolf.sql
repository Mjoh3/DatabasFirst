-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Player`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Player` (
  `PersonNumber` INT NOT NULL,
  `Age` INT NULL,
  `Name` VARCHAR(45) NULL COMMENT 'This is the player',
  PRIMARY KEY (`PersonNumber`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Jacket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Jacket` (
  `Size` INT NULL,
  `Initials` VARCHAR(45) NOT NULL,
  `Material` VARCHAR(45) NULL,
  `Player_PersonNumber` INT NOT NULL,
  PRIMARY KEY (`Initials`),
  INDEX `fk_Jacket_Player1_idx` (`Player_PersonNumber` ASC) VISIBLE,
  CONSTRAINT `fk_Jacket_Player1`
    FOREIGN KEY (`Player_PersonNumber`)
    REFERENCES `mydb`.`Player` (`PersonNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Construction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Construction` (
  `SerialNr` INT NOT NULL,
  `Hardness` FLOAT NULL,
  PRIMARY KEY (`SerialNr`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`GolfClub`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`GolfClub` (
  `Nr` INT NOT NULL,
  `Material` VARCHAR(45) NULL,
  `Player_PersonNumber` INT NOT NULL,
  `Construction_SerialNr` INT NOT NULL,
  PRIMARY KEY (`Nr`),
  INDEX `fk_GolfClub_Player1_idx` (`Player_PersonNumber` ASC) VISIBLE,
  INDEX `fk_GolfClub_Construction1_idx` (`Construction_SerialNr` ASC) VISIBLE,
  CONSTRAINT `fk_GolfClub_Player1`
    FOREIGN KEY (`Player_PersonNumber`)
    REFERENCES `mydb`.`Player` (`PersonNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GolfClub_Construction1`
    FOREIGN KEY (`Construction_SerialNr`)
    REFERENCES `mydb`.`Construction` (`SerialNr`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Competition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Competition` (
  `Date` DATE NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rain`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Rain` (
  `Type` VARCHAR(45) NOT NULL,
  `Windspeed` FLOAT NULL,
  PRIMARY KEY (`Type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Player_has_Competition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Player_has_Competition` (
  `Player_PersonNumber` INT NOT NULL,
  `Competition_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Player_PersonNumber`, `Competition_Name`),
  INDEX `fk_Player_has_Competition_Competition1_idx` (`Competition_Name` ASC) VISIBLE,
  INDEX `fk_Player_has_Competition_Player_idx` (`Player_PersonNumber` ASC) VISIBLE,
  CONSTRAINT `fk_Player_has_Competition_Player`
    FOREIGN KEY (`Player_PersonNumber`)
    REFERENCES `mydb`.`Player` (`PersonNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Player_has_Competition_Competition1`
    FOREIGN KEY (`Competition_Name`)
    REFERENCES `mydb`.`Competition` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Competition_has_Rain`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Competition_has_Rain` (
  `Competition_Name` VARCHAR(45) NOT NULL,
  `Rain_Type` VARCHAR(45) NOT NULL,
  `Time` TIMESTAMP NULL,
  PRIMARY KEY (`Competition_Name`, `Rain_Type`),
  INDEX `fk_Competition_has_Rain_Rain1_idx` (`Rain_Type` ASC) VISIBLE,
  INDEX `fk_Competition_has_Rain_Competition1_idx` (`Competition_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Competition_has_Rain_Competition1`
    FOREIGN KEY (`Competition_Name`)
    REFERENCES `mydb`.`Competition` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Competition_has_Rain_Rain1`
    FOREIGN KEY (`Rain_Type`)
    REFERENCES `mydb`.`Rain` (`Type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
