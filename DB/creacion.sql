-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema clinica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema clinica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `clinica` DEFAULT CHARACTER SET utf8 ;
USE `clinica` ;

-- -----------------------------------------------------
-- Table `clinica`.`especialidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinica`.`especialidad` (
  `idespecialidad` INT NOT NULL AUTO_INCREMENT,
  `nombreespecialidad` VARCHAR(45) NOT NULL,
  `descriespecialidad` VARCHAR(300) NOT NULL,
  `urlImagen` VARCHAR(500) NULL,
  PRIMARY KEY (`idespecialidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`clinica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinica`.`clinica` (
  `idclinica` INT NOT NULL AUTO_INCREMENT,
  `nombreclinica` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`idclinica`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinica`.`medico` (
  `idmedico` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(90) NOT NULL,
  `idespecialidad` INT NOT NULL,
  `idclinica` INT NOT NULL,
  `urlImagen` VARCHAR(500) NULL,
  PRIMARY KEY (`idmedico`, `idespecialidad`, `idclinica`),
  INDEX `fk_medico_especialidad1_idx` (`idespecialidad` ASC) VISIBLE,
  INDEX `fk_medico_clinica1_idx` (`idclinica` ASC) VISIBLE,
  CONSTRAINT `fk_medico_especialidad1`
    FOREIGN KEY (`idespecialidad`)
    REFERENCES `clinica`.`especialidad` (`idespecialidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_clinica1`
    FOREIGN KEY (`idclinica`)
    REFERENCES `clinica`.`clinica` (`idclinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`tiempos_disponibles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinica`.`tiempos_disponibles` (
  `idtiempos_disponibles` INT NOT NULL,
  `fechadisponible` DATE NOT NULL,
  `horadisponible` TIME NOT NULL,
  PRIMARY KEY (`idtiempos_disponibles`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`medico_tiempos_disponibles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinica`.`medico_tiempos_disponibles` (
  `idmedico` INT NOT NULL,
  `idespecialidad` INT NOT NULL,
  `idclinica` INT NOT NULL,
  `idtiempos_disponibles` INT NOT NULL,
  PRIMARY KEY (`idmedico`, `idespecialidad`, `idclinica`, `idtiempos_disponibles`),
  INDEX `fk_medico_has_tiempos_disponibles_tiempos_disponibles1_idx` (`idtiempos_disponibles` ASC) VISIBLE,
  INDEX `fk_medico_has_tiempos_disponibles_medico1_idx` (`idmedico` ASC, `idespecialidad` ASC, `idclinica` ASC) VISIBLE,
  CONSTRAINT `fk_medico_has_tiempos_disponibles_medico1`
    FOREIGN KEY (`idmedico` , `idespecialidad` , `idclinica`)
    REFERENCES `clinica`.`medico` (`idmedico` , `idespecialidad` , `idclinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_has_tiempos_disponibles_tiempos_disponibles1`
    FOREIGN KEY (`idtiempos_disponibles`)
    REFERENCES `clinica`.`tiempos_disponibles` (`idtiempos_disponibles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`cita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinica`.`cita` (
  `idcita` INT NOT NULL AUTO_INCREMENT,
  `fechaagenda` DATE NOT NULL,
  `horaagenda` TIME NOT NULL,
  `fechahorapago` DATETIME NULL,
  `idmedico` INT NOT NULL,
  `idespecialidad` INT NOT NULL,
  `idclinica` INT NOT NULL,
  `idtiempos_disponibles` INT NOT NULL,
  `cancelado` VARCHAR(45) NULL,
  `precio` DECIMAL(6,2) NULL,
  `idpago` VARCHAR(50) NULL,
  PRIMARY KEY (`idcita`, `idmedico`, `idespecialidad`, `idclinica`, `idtiempos_disponibles`),
  INDEX `fk_cita_medico_has_tiempos_disponibles1_idx` (`idmedico` ASC, `idespecialidad` ASC, `idclinica` ASC, `idtiempos_disponibles` ASC) VISIBLE,
  CONSTRAINT `fk_cita_medico_has_tiempos_disponibles1`
    FOREIGN KEY (`idmedico` , `idespecialidad` , `idclinica` , `idtiempos_disponibles`)
    REFERENCES `clinica`.`medico_tiempos_disponibles` (`idmedico` , `idespecialidad` , `idclinica` , `idtiempos_disponibles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinica`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nombreusuario` VARCHAR(80) NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `telefono` VARCHAR(9) NOT NULL,
  `fechanacimiento` DATE NOT NULL,
  `idcita` INT NOT NULL,
  `urlImagen` VARCHAR(500) NULL,
  PRIMARY KEY (`idusuario`, `idcita`),
  INDEX `fk_usuario_cita1_idx` (`idcita` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_cita1`
    FOREIGN KEY (`idcita`)
    REFERENCES `clinica`.`cita` (`idcita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`medico_favorito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinica`.`medico_favorito` (
  `idmedico` INT NOT NULL,
  `idusuario` INT NOT NULL,
  PRIMARY KEY (`idmedico`, `idusuario`),
  INDEX `fk_medico_has_usuario_usuario1_idx` (`idusuario` ASC) VISIBLE,
  INDEX `fk_medico_has_usuario_medico1_idx` (`idmedico` ASC) VISIBLE,
  CONSTRAINT `fk_medico_has_usuario_medico1`
    FOREIGN KEY (`idmedico`)
    REFERENCES `clinica`.`medico` (`idmedico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_has_usuario_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `clinica`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinica`.`especialidad_favorita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinica`.`especialidad_favorita` (
  `idespecialidad` INT NOT NULL,
  `idusuario` INT NOT NULL,
  PRIMARY KEY (`idespecialidad`, `idusuario`),
  INDEX `fk_especialidad_has_usuario_usuario1_idx` (`idusuario` ASC) VISIBLE,
  INDEX `fk_especialidad_has_usuario_especialidad1_idx` (`idespecialidad` ASC) VISIBLE,
  CONSTRAINT `fk_especialidad_has_usuario_especialidad1`
    FOREIGN KEY (`idespecialidad`)
    REFERENCES `clinica`.`especialidad` (`idespecialidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_especialidad_has_usuario_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `clinica`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
