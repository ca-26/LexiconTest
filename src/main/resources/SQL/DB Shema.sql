-- MySQL Script generated by MySQL Workbench
-- Sun Dec 31 23:00:52 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema lexicontest
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lexicontest
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lexicontest` DEFAULT CHARACTER SET utf8 ;
USE `lexicontest` ;

-- -----------------------------------------------------
-- Table `lexicontest`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lexicontest`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `first_name` VARCHAR(100) NULL DEFAULT NULL,
  `last_name` VARCHAR(100) NULL DEFAULT NULL,
  `active` TINYINT(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`, `email`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lexicontest`.`lexicon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lexicontest`.`lexicon` (
  `id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `languages` VARCHAR(7) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idLexicon_UNIQUE` (`id` ASC),
  INDEX `userLogin_idx` (`user_id` ASC),
  CONSTRAINT `userLogin`
    FOREIGN KEY (`user_id`)
    REFERENCES `lexicontest`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lexicontest`.`persistent_logins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lexicontest`.`persistent_logins` (
  `username` VARCHAR(100) NOT NULL,
  `series` VARCHAR(64) NOT NULL,
  `token` VARCHAR(64) NOT NULL,
  `last_used` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`series`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lexicontest`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lexicontest`.`role` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lexicontest`.`scores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lexicontest`.`scores` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `lex_name` VARCHAR(100) NOT NULL,
  `lex_languages` VARCHAR(7) NOT NULL,
  `date_time` DATETIME NOT NULL,
  `duration` INT(11) NOT NULL,
  `score` SMALLINT(2) NOT NULL,
  `nb_words` INT(11) NOT NULL,
  `nb_correct` INT(11) NOT NULL,
  `nb_wrong` INT(11) NOT NULL,
  `nb_skipped` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idResults_UNIQUE` (`id` ASC),
  INDEX `userId_idx` (`user_id` ASC),
  CONSTRAINT `userId`
    FOREIGN KEY (`user_id`)
    REFERENCES `lexicontest`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lexicontest`.`user_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lexicontest`.`user_role` (
  `user_id` INT(11) NOT NULL,
  `role_id` INT(11) NOT NULL,
  INDEX `user_id_idx` (`user_id` ASC),
  INDEX `role_id_idx` (`role_id` ASC),
  CONSTRAINT `role_id`
    FOREIGN KEY (`role_id`)
    REFERENCES `lexicontest`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `lexicontest`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lexicontest`.`words`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lexicontest`.`words` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `lexicon_id` INT(11) NOT NULL,
  `word_1` VARCHAR(255) NOT NULL,
  `word_2` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `idLexicon_idx` (`lexicon_id` ASC),
  CONSTRAINT `idLexicon`
    FOREIGN KEY (`lexicon_id`)
    REFERENCES `lexicontest`.`lexicon` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
