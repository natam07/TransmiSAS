-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Transport
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Transport
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Transport` DEFAULT CHARACTER SET utf8 ;
USE `Transport` ;

-- -----------------------------------------------------
-- Table `Transport`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Transport`.`User` (
  `idUser` INT NOT NULL,
  `balance` INT NOT NULL,
  `trip` VARCHAR(45) NOT NULL,
  `schedule` VARCHAR(45) NULL,
  `favoriteRoute` VARCHAR(45) NULL,
  `frequentHour` VARCHAR(45) NULL,
  PRIMARY KEY (`idUser`),
  UNIQUE INDEX `idUser_UNIQUE` (`idUser` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Transport`.`transport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Transport`.`transport` (
  `idtransport` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `routeNumber` VARCHAR(45) NOT NULL,
  `operatingCompany` VARCHAR(45) NOT NULL,
  `User_idUser` INT NOT NULL,
  PRIMARY KEY (`idtransport`),
  INDEX `fk_transport_User1_idx` (`User_idUser` ASC) VISIBLE,
  UNIQUE INDEX `idtransport_UNIQUE` (`idtransport` ASC) VISIBLE,
  CONSTRAINT `fk_transport_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `Transport`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Transport`.`Alert`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Transport`.`Alert` (
  `idAlert` INT NOT NULL,
  `valueRecharge` VARCHAR(45) NULL,
  `Route` VARCHAR(45) NULL,
  `Transaction_idTransaction` INT NOT NULL,
  PRIMARY KEY (`idAlert`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Transport`.`Recharge`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Transport`.`Recharge` (
  `idRecharge` INT NOT NULL,
  `value` VARCHAR(45) NOT NULL,
  `date` VARCHAR(45) NOT NULL,
  `PointSale` VARCHAR(45) NOT NULL,
  `way` VARCHAR(45) NOT NULL,
  `User_idUser` INT NOT NULL,
  `Alert_idAlert` INT NOT NULL,
  PRIMARY KEY (`idRecharge`),
  INDEX `fk_Recharge_User1_idx` (`User_idUser` ASC) VISIBLE,
  INDEX `fk_Recharge_Alert1_idx` (`Alert_idAlert` ASC) VISIBLE,
  CONSTRAINT `fk_Recharge_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `Transport`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recharge_Alert1`
    FOREIGN KEY (`Alert_idAlert`)
    REFERENCES `Transport`.`Alert` (`idAlert`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Transport`.`usage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Transport`.`usage` (
  `idusage` INT NOT NULL,
  `TripTime` VARCHAR(45) NOT NULL,
  `User_idUser` INT NOT NULL,
  `transport_idtransport` INT NOT NULL,
  PRIMARY KEY (`idusage`),
  INDEX `fk_usage_User1_idx` (`User_idUser` ASC) VISIBLE,
  INDEX `fk_usage_transport1_idx` (`transport_idtransport` ASC) VISIBLE,
  CONSTRAINT `fk_usage_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `Transport`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usage_transport1`
    FOREIGN KEY (`transport_idtransport`)
    REFERENCES `Transport`.`transport` (`idtransport`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
