CREATE DATABASE  IF NOT EXISTS `museo_omero` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `museo_omero`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: museo_omero
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `abbonamenti`
--

DROP TABLE IF EXISTS `abbonamenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abbonamenti` (
  `cliente` int NOT NULL,
  `data_rilascio` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_scadenza` date DEFAULT NULL,
  `costo` decimal(6,2) NOT NULL DEFAULT '0.00',
  `tipologia` enum('mensile','trimestrale','semestrale','annuale') NOT NULL,
  PRIMARY KEY (`cliente`,`data_rilascio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abbonamenti`
--

LOCK TABLES `abbonamenti` WRITE;
/*!40000 ALTER TABLE `abbonamenti` DISABLE KEYS */;
/*!40000 ALTER TABLE `abbonamenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adesioni`
--

DROP TABLE IF EXISTS `adesioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adesioni` (
  `gruppo` int NOT NULL,
  `visitatore` int NOT NULL,
  PRIMARY KEY (`gruppo`,`visitatore`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adesioni`
--

LOCK TABLES `adesioni` WRITE;
/*!40000 ALTER TABLE `adesioni` DISABLE KEYS */;
/*!40000 ALTER TABLE `adesioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articoli`
--

DROP TABLE IF EXISTS `articoli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articoli` (
  `nome` varchar(30) NOT NULL,
  `descrizione` varchar(100) DEFAULT NULL,
  `disponibilita` int NOT NULL DEFAULT '0',
  `prezzo` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`nome`),
  CONSTRAINT `articoli_chk_1` CHECK (((`disponibilita` >= 0) and (`prezzo` >= 0)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articoli`
--

LOCK TABLES `articoli` WRITE;
/*!40000 ALTER TABLE `articoli` DISABLE KEYS */;
/*!40000 ALTER TABLE `articoli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artisti`
--

DROP TABLE IF EXISTS `artisti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artisti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) NOT NULL,
  `cognome` varchar(20) NOT NULL,
  `data_nasc` date NOT NULL,
  `luogo_nasc` varchar(20) NOT NULL,
  `sesso` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`,`cognome`,`data_nasc`,`luogo_nasc`),
  CONSTRAINT `artisti_chk_1` CHECK (((`sesso` = 'M') or (`sesso` = 'F')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artisti`
--

LOCK TABLES `artisti` WRITE;
/*!40000 ALTER TABLE `artisti` DISABLE KEYS */;
/*!40000 ALTER TABLE `artisti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `associazioni`
--

DROP TABLE IF EXISTS `associazioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `associazioni` (
  `gruppo` int NOT NULL,
  `scuola` varchar(25) NOT NULL,
  PRIMARY KEY (`gruppo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `associazioni`
--

LOCK TABLES `associazioni` WRITE;
/*!40000 ALTER TABLE `associazioni` DISABLE KEYS */;
/*!40000 ALTER TABLE `associazioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attivita`
--

DROP TABLE IF EXISTS `attivita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attivita` (
  `evento` int NOT NULL,
  `is_tour_guidato` bit(1) NOT NULL,
  `capienza` int NOT NULL DEFAULT '30',
  PRIMARY KEY (`evento`),
  CONSTRAINT `attivita_chk_1` CHECK ((`capienza` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attivita`
--

LOCK TABLES `attivita` WRITE;
/*!40000 ALTER TABLE `attivita` DISABLE KEYS */;
/*!40000 ALTER TABLE `attivita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autori`
--

DROP TABLE IF EXISTS `autori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autori` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) NOT NULL,
  `cognome` varchar(20) NOT NULL,
  `data_nasc` date DEFAULT NULL,
  `luogo_nasc` varchar(20) DEFAULT NULL,
  `sesso` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `autori_chk_1` CHECK (((`sesso` = 'M') or (`sesso` = _cp850'F')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autori`
--

LOCK TABLES `autori` WRITE;
/*!40000 ALTER TABLE `autori` DISABLE KEYS */;
/*!40000 ALTER TABLE `autori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biglietti`
--

DROP TABLE IF EXISTS `biglietti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biglietti` (
  `Id` varchar(15) NOT NULL,
  `gruppo` int NOT NULL,
  `evento` int DEFAULT NULL,
  `costo` decimal(6,2) NOT NULL,
  `data_stampa` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  CONSTRAINT `biglietti_chk_1` CHECK ((`costo` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biglietti`
--

LOCK TABLES `biglietti` WRITE;
/*!40000 ALTER TABLE `biglietti` DISABLE KEYS */;
/*!40000 ALTER TABLE `biglietti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carrelli`
--

DROP TABLE IF EXISTS `carrelli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrelli` (
  `ordine` int NOT NULL,
  `catalogo` varchar(30) NOT NULL,
  `quantita` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`ordine`,`catalogo`),
  CONSTRAINT `carrelli_chk_1` CHECK ((`quantita` >= 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrelli`
--

LOCK TABLES `carrelli` WRITE;
/*!40000 ALTER TABLE `carrelli` DISABLE KEYS */;
/*!40000 ALTER TABLE `carrelli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cataloghi`
--

DROP TABLE IF EXISTS `cataloghi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cataloghi` (
  `nome` varchar(30) NOT NULL,
  `numero_pag` int DEFAULT '0',
  `rilegatura` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`nome`),
  CONSTRAINT `cataloghi_chk_1` CHECK ((`numero_pag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cataloghi`
--

LOCK TABLES `cataloghi` WRITE;
/*!40000 ALTER TABLE `cataloghi` DISABLE KEYS */;
/*!40000 ALTER TABLE `cataloghi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificati`
--

DROP TABLE IF EXISTS `certificati`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `certificati` (
  `visitatore` int NOT NULL,
  `disabilita` varchar(20) NOT NULL,
  PRIMARY KEY (`visitatore`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificati`
--

LOCK TABLES `certificati` WRITE;
/*!40000 ALTER TABLE `certificati` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificati` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clienti`
--

DROP TABLE IF EXISTS `clienti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clienti` (
  `id` int NOT NULL,
  `nome` varchar(20) NOT NULL,
  `cognome` varchar(20) NOT NULL,
  `tessera` bit(1) NOT NULL DEFAULT b'0',
  `cellulare` varchar(15) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cellulare` (`cellulare`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clienti`
--

LOCK TABLES `clienti` WRITE;
/*!40000 ALTER TABLE `clienti` DISABLE KEYS */;
/*!40000 ALTER TABLE `clienti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `composizioni`
--

DROP TABLE IF EXISTS `composizioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `composizioni` (
  `opera` int NOT NULL,
  `materiale` varchar(25) NOT NULL,
  PRIMARY KEY (`opera`,`materiale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `composizioni`
--

LOCK TABLES `composizioni` WRITE;
/*!40000 ALTER TABLE `composizioni` DISABLE KEYS */;
/*!40000 ALTER TABLE `composizioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contenuti`
--

DROP TABLE IF EXISTS `contenuti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contenuti` (
  `articolo` varchar(30) NOT NULL,
  `scontrino` int NOT NULL,
  `quantita` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`articolo`,`scontrino`),
  CONSTRAINT `contenuti_chk_1` CHECK ((`quantita` >= 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contenuti`
--

LOCK TABLES `contenuti` WRITE;
/*!40000 ALTER TABLE `contenuti` DISABLE KEYS */;
/*!40000 ALTER TABLE `contenuti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `copie`
--

DROP TABLE IF EXISTS `copie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `copie` (
  `id` int NOT NULL,
  `numero` int NOT NULL,
  `is_calco` bit(1) DEFAULT b'1',
  `scala` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `copie`
--

LOCK TABLES `copie` WRITE;
/*!40000 ALTER TABLE `copie` DISABLE KEYS */;
/*!40000 ALTER TABLE `copie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credenziali`
--

DROP TABLE IF EXISTS `credenziali`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credenziali` (
  `Dipendente` int NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`Dipendente`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `username_2` (`username`,`password`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credenziali`
--

LOCK TABLES `credenziali` WRITE;
/*!40000 ALTER TABLE `credenziali` DISABLE KEYS */;
/*!40000 ALTER TABLE `credenziali` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dipendenti`
--

DROP TABLE IF EXISTS `dipendenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dipendenti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) NOT NULL,
  `cognome` varchar(20) NOT NULL,
  `data_nasc` date NOT NULL,
  `luogo_nasc` varchar(20) NOT NULL,
  `sesso` char(1) NOT NULL,
  `email` varchar(25) DEFAULT NULL,
  `cellulare` varchar(15) DEFAULT NULL,
  `curriculum` varchar(50) DEFAULT NULL,
  `data_registrazione` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`,`cognome`,`data_nasc`,`luogo_nasc`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `cellulare` (`cellulare`),
  CONSTRAINT `dipendenti_chk_1` CHECK (((`sesso` = 'M') or (`sesso` = _cp850'F')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dipendenti`
--

LOCK TABLES `dipendenti` WRITE;
/*!40000 ALTER TABLE `dipendenti` DISABLE KEYS */;
/*!40000 ALTER TABLE `dipendenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disabilita`
--

DROP TABLE IF EXISTS `disabilita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disabilita` (
  `nome` varchar(20) NOT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disabilita`
--

LOCK TABLES `disabilita` WRITE;
/*!40000 ALTER TABLE `disabilita` DISABLE KEYS */;
/*!40000 ALTER TABLE `disabilita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donazioni`
--

DROP TABLE IF EXISTS `donazioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donazioni` (
  `opera` int NOT NULL,
  `donatore` int NOT NULL,
  `data_donazione` date DEFAULT NULL,
  `data_presa_in_carico` date NOT NULL,
  `esito` enum('positivo','negativo') DEFAULT NULL,
  PRIMARY KEY (`opera`),
  CONSTRAINT `donazioni_chk_1` CHECK ((`data_donazione` <= `data_presa_in_carico`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donazioni`
--

LOCK TABLES `donazioni` WRITE;
/*!40000 ALTER TABLE `donazioni` DISABLE KEYS */;
/*!40000 ALTER TABLE `donazioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `esposizioni`
--

DROP TABLE IF EXISTS `esposizioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `esposizioni` (
  `mostra` int NOT NULL,
  `opera` int NOT NULL,
  PRIMARY KEY (`mostra`,`opera`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `esposizioni`
--

LOCK TABLES `esposizioni` WRITE;
/*!40000 ALTER TABLE `esposizioni` DISABLE KEYS */;
/*!40000 ALTER TABLE `esposizioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventi`
--

DROP TABLE IF EXISTS `eventi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eventi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data_inizio` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventi`
--

LOCK TABLES `eventi` WRITE;
/*!40000 ALTER TABLE `eventi` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gruppi`
--

DROP TABLE IF EXISTS `gruppi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gruppi` (
  `Id` int NOT NULL,
  `num_partecipanti` int NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `gruppi_chk_1` CHECK ((`num_partecipanti` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gruppi`
--

LOCK TABLES `gruppi` WRITE;
/*!40000 ALTER TABLE `gruppi` DISABLE KEYS */;
/*!40000 ALTER TABLE `gruppi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guide`
--

DROP TABLE IF EXISTS `guide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guide` (
  `dipendente` int NOT NULL,
  `data_inizio` date NOT NULL,
  `qualifica_inglese` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`dipendente`,`data_inizio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guide`
--

LOCK TABLES `guide` WRITE;
/*!40000 ALTER TABLE `guide` DISABLE KEYS */;
/*!40000 ALTER TABLE `guide` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `illustrazioni`
--

DROP TABLE IF EXISTS `illustrazioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `illustrazioni` (
  `attivita` int NOT NULL,
  `guida` int NOT NULL,
  PRIMARY KEY (`attivita`,`guida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `illustrazioni`
--

LOCK TABLES `illustrazioni` WRITE;
/*!40000 ALTER TABLE `illustrazioni` DISABLE KEYS */;
/*!40000 ALTER TABLE `illustrazioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indirizzamenti`
--

DROP TABLE IF EXISTS `indirizzamenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indirizzamenti` (
  `laboratorio` varchar(30) NOT NULL,
  `tipo_clientela` varchar(30) NOT NULL,
  PRIMARY KEY (`laboratorio`,`tipo_clientela`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indirizzamenti`
--

LOCK TABLES `indirizzamenti` WRITE;
/*!40000 ALTER TABLE `indirizzamenti` DISABLE KEYS */;
/*!40000 ALTER TABLE `indirizzamenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `informazioni_visitatori`
--

DROP TABLE IF EXISTS `informazioni_visitatori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `informazioni_visitatori` (
  `visitatore` int NOT NULL,
  `provenienza` varchar(20) DEFAULT NULL,
  `sesso` char(1) DEFAULT NULL,
  `data_nasc` date DEFAULT NULL,
  PRIMARY KEY (`visitatore`),
  CONSTRAINT `informazioni_visitatori_chk_1` CHECK (((`sesso` = 'M') or (`sesso` = _cp850'F')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `informazioni_visitatori`
--

LOCK TABLES `informazioni_visitatori` WRITE;
/*!40000 ALTER TABLE `informazioni_visitatori` DISABLE KEYS */;
/*!40000 ALTER TABLE `informazioni_visitatori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laboratori`
--

DROP TABLE IF EXISTS `laboratori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laboratori` (
  `nome` varchar(30) NOT NULL,
  `tipologia` enum('Design','MuseoAperto') DEFAULT NULL,
  `durata` time DEFAULT NULL,
  `costo_persona` decimal(6,2) NOT NULL DEFAULT '0.00',
  `costo_classe` decimal(6,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`nome`),
  CONSTRAINT `laboratori_chk_1` CHECK ((`costo_persona` >= 0)),
  CONSTRAINT `laboratori_chk_2` CHECK ((`costo_classe` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laboratori`
--

LOCK TABLES `laboratori` WRITE;
/*!40000 ALTER TABLE `laboratori` DISABLE KEYS */;
/*!40000 ALTER TABLE `laboratori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laboratori_reali`
--

DROP TABLE IF EXISTS `laboratori_reali`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laboratori_reali` (
  `attivita` int NOT NULL,
  `laboratorio` varchar(30) NOT NULL,
  `piano` int DEFAULT NULL,
  `stanza` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`attivita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laboratori_reali`
--

LOCK TABLES `laboratori_reali` WRITE;
/*!40000 ALTER TABLE `laboratori_reali` DISABLE KEYS */;
/*!40000 ALTER TABLE `laboratori_reali` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materiali`
--

DROP TABLE IF EXISTS `materiali`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materiali` (
  `nome` varchar(25) NOT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materiali`
--

LOCK TABLES `materiali` WRITE;
/*!40000 ALTER TABLE `materiali` DISABLE KEYS */;
/*!40000 ALTER TABLE `materiali` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modelli_architettonici`
--

DROP TABLE IF EXISTS `modelli_architettonici`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modelli_architettonici` (
  `copia` int NOT NULL,
  `is_smontabile` bit(1) DEFAULT b'0',
  `is_pieno` bit(1) DEFAULT b'0',
  PRIMARY KEY (`copia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modelli_architettonici`
--

LOCK TABLES `modelli_architettonici` WRITE;
/*!40000 ALTER TABLE `modelli_architettonici` DISABLE KEYS */;
/*!40000 ALTER TABLE `modelli_architettonici` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mostre`
--

DROP TABLE IF EXISTS `mostre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mostre` (
  `evento` int NOT NULL,
  `num_opere` int NOT NULL DEFAULT '0',
  `descrizione` varchar(500) DEFAULT NULL,
  `titolo` varchar(30) NOT NULL,
  `tema` varchar(30) DEFAULT NULL,
  `artista` varchar(30) DEFAULT NULL,
  `data_fine` date DEFAULT NULL,
  PRIMARY KEY (`evento`),
  UNIQUE KEY `titolo` (`titolo`),
  CONSTRAINT `mostre_chk_1` CHECK ((`num_opere` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mostre`
--

LOCK TABLES `mostre` WRITE;
/*!40000 ALTER TABLE `mostre` DISABLE KEYS */;
/*!40000 ALTER TABLE `mostre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opere`
--

DROP TABLE IF EXISTS `opere`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opere` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` date DEFAULT NULL,
  `tipologia` enum('Foglio','Quadro','Tela','Bassorilievo','Modello','Statua','Libro') DEFAULT NULL,
  `descrizione` varchar(500) DEFAULT NULL,
  `sala` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opere`
--

LOCK TABLES `opere` WRITE;
/*!40000 ALTER TABLE `opere` DISABLE KEYS */;
/*!40000 ALTER TABLE `opere` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordini`
--

DROP TABLE IF EXISTS `ordini`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordini` (
  `id` int NOT NULL,
  `data` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `costo` decimal(6,2) NOT NULL DEFAULT '0.00',
  `is_spedito` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  CONSTRAINT `ordini_chk_1` CHECK ((`costo` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordini`
--

LOCK TABLES `ordini` WRITE;
/*!40000 ALTER TABLE `ordini` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordini` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `originali`
--

DROP TABLE IF EXISTS `originali`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `originali` (
  `id` int NOT NULL,
  `titolo` varchar(30) NOT NULL,
  `is_interna` bit(1) NOT NULL,
  `città` varchar(20) DEFAULT NULL,
  `altezza` varchar(8) DEFAULT NULL,
  `larghezza` varchar(8) DEFAULT NULL,
  `profondità` varchar(8) DEFAULT NULL,
  `periodo_storico` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `titolo` (`titolo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `originali`
--

LOCK TABLES `originali` WRITE;
/*!40000 ALTER TABLE `originali` DISABLE KEYS */;
/*!40000 ALTER TABLE `originali` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periodi_storici`
--

DROP TABLE IF EXISTS `periodi_storici`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `periodi_storici` (
  `nome` varchar(25) NOT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periodi_storici`
--

LOCK TABLES `periodi_storici` WRITE;
/*!40000 ALTER TABLE `periodi_storici` DISABLE KEYS */;
/*!40000 ALTER TABLE `periodi_storici` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prenotazioni`
--

DROP TABLE IF EXISTS `prenotazioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prenotazioni` (
  `gruppo` int NOT NULL,
  `attivita` int NOT NULL,
  `data_prenotazione` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`gruppo`,`attivita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prenotazioni`
--

LOCK TABLES `prenotazioni` WRITE;
/*!40000 ALTER TABLE `prenotazioni` DISABLE KEYS */;
/*!40000 ALTER TABLE `prenotazioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produzioni`
--

DROP TABLE IF EXISTS `produzioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produzioni` (
  `opera` int NOT NULL,
  `tecnica` varchar(25) NOT NULL,
  PRIMARY KEY (`opera`,`tecnica`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produzioni`
--

LOCK TABLES `produzioni` WRITE;
/*!40000 ALTER TABLE `produzioni` DISABLE KEYS */;
/*!40000 ALTER TABLE `produzioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionari`
--

DROP TABLE IF EXISTS `questionari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionari` (
  `visitatore` int NOT NULL,
  `tipologia_visita` enum('visita guidata','visita libera','partecipazione ad una mostra/laboratorio') DEFAULT NULL,
  `accompagnatori_visita` enum('solo','partner/coniuge','famiglia','amici/parenti/conoscenti','scolaresca','gruppo organizzato') DEFAULT NULL,
  `motivazione_visita` enum('vedere oggetti belli','incontrare persone con interessi simili ai miei','vedere oggetti importanti','imparare cose nuove','trascorrere tempo libero con amici/parenti','approfondire le mie conoscenze','passare un momento personale piacevole') DEFAULT NULL,
  `titolo_studi` enum('Elem.','Lic. Media','Diploma','Laurea/PostLaurea','Nessuno') DEFAULT NULL,
  `numero_visite` int DEFAULT NULL,
  `ritorno` enum('Assolutamente no','Probabilmente No','Probabilmente Si','Assolutamente Si') DEFAULT NULL,
  `valutazione_visita` int DEFAULT NULL,
  `valutazione_esperienza` int DEFAULT NULL,
  `valutazione_struttura` int DEFAULT NULL,
  PRIMARY KEY (`visitatore`),
  CONSTRAINT `questionari_chk_1` CHECK ((`numero_visite` >= 0)),
  CONSTRAINT `questionari_chk_2` CHECK (((`valutazione_visita` >= 0) and (`valutazione_visita` <= 10))),
  CONSTRAINT `questionari_chk_3` CHECK (((`valutazione_esperienza` >= 0) and (`valutazione_esperienza` <= 10))),
  CONSTRAINT `questionari_chk_4` CHECK (((`valutazione_struttura` >= 0) and (`valutazione_struttura` <= 10)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionari`
--

LOCK TABLES `questionari` WRITE;
/*!40000 ALTER TABLE `questionari` DISABLE KEYS */;
/*!40000 ALTER TABLE `questionari` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rappresentanze`
--

DROP TABLE IF EXISTS `rappresentanze`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rappresentanze` (
  `gruppo` int NOT NULL,
  `rappresentante` int NOT NULL,
  PRIMARY KEY (`gruppo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rappresentanze`
--

LOCK TABLES `rappresentanze` WRITE;
/*!40000 ALTER TABLE `rappresentanze` DISABLE KEYS */;
/*!40000 ALTER TABLE `rappresentanze` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `realizzazioni`
--

DROP TABLE IF EXISTS `realizzazioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `realizzazioni` (
  `opera` int NOT NULL,
  `artista` int NOT NULL,
  PRIMARY KEY (`opera`,`artista`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `realizzazioni`
--

LOCK TABLES `realizzazioni` WRITE;
/*!40000 ALTER TABLE `realizzazioni` DISABLE KEYS */;
/*!40000 ALTER TABLE `realizzazioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relatori`
--

DROP TABLE IF EXISTS `relatori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relatori` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) NOT NULL,
  `cognome` varchar(20) NOT NULL,
  `università` varchar(30) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`,`cognome`,`università`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relatori`
--

LOCK TABLES `relatori` WRITE;
/*!40000 ALTER TABLE `relatori` DISABLE KEYS */;
/*!40000 ALTER TABLE `relatori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reparti`
--

DROP TABLE IF EXISTS `reparti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reparti` (
  `nome` varchar(20) NOT NULL,
  `piano` int DEFAULT NULL,
  `stanza` varchar(3) DEFAULT NULL,
  `posti_tot` int DEFAULT NULL,
  `posti_occ` int DEFAULT NULL,
  PRIMARY KEY (`nome`),
  CONSTRAINT `reparti_chk_1` CHECK ((`posti_occ` <= `posti_tot`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reparti`
--

LOCK TABLES `reparti` WRITE;
/*!40000 ALTER TABLE `reparti` DISABLE KEYS */;
/*!40000 ALTER TABLE `reparti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ruoli`
--

DROP TABLE IF EXISTS `ruoli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ruoli` (
  `nome` varchar(25) NOT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ruoli`
--

LOCK TABLES `ruoli` WRITE;
/*!40000 ALTER TABLE `ruoli` DISABLE KEYS */;
/*!40000 ALTER TABLE `ruoli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ruoli_reali`
--

DROP TABLE IF EXISTS `ruoli_reali`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ruoli_reali` (
  `dipendente` int NOT NULL,
  `ruolo` varchar(25) NOT NULL,
  `data_inizio` date NOT NULL,
  `data_fine` date DEFAULT NULL,
  `stipendio` int DEFAULT '0',
  `is_storico` bit(1) NOT NULL DEFAULT b'0',
  `reparto` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`dipendente`,`data_inizio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ruoli_reali`
--

LOCK TABLES `ruoli_reali` WRITE;
/*!40000 ALTER TABLE `ruoli_reali` DISABLE KEYS */;
/*!40000 ALTER TABLE `ruoli_reali` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale`
--

DROP TABLE IF EXISTS `sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale` (
  `nome` varchar(25) NOT NULL,
  `piano` int DEFAULT NULL,
  `stanza` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale`
--

LOCK TABLES `sale` WRITE;
/*!40000 ALTER TABLE `sale` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scontrini`
--

DROP TABLE IF EXISTS `scontrini`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scontrini` (
  `id` int NOT NULL,
  `data` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `costo` decimal(6,2) NOT NULL DEFAULT '0.00',
  `visitatore` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `scontrini_chk_1` CHECK ((`costo` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scontrini`
--

LOCK TABLES `scontrini` WRITE;
/*!40000 ALTER TABLE `scontrini` DISABLE KEYS */;
/*!40000 ALTER TABLE `scontrini` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scritture`
--

DROP TABLE IF EXISTS `scritture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scritture` (
  `autore` int NOT NULL,
  `catalogo` varchar(30) NOT NULL,
  PRIMARY KEY (`autore`,`catalogo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scritture`
--

LOCK TABLES `scritture` WRITE;
/*!40000 ALTER TABLE `scritture` DISABLE KEYS */;
/*!40000 ALTER TABLE `scritture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scuole`
--

DROP TABLE IF EXISTS `scuole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scuole` (
  `nome` varchar(25) NOT NULL,
  `città` varchar(20) DEFAULT NULL,
  `indirizzo` varchar(25) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scuole`
--

LOCK TABLES `scuole` WRITE;
/*!40000 ALTER TABLE `scuole` DISABLE KEYS */;
/*!40000 ALTER TABLE `scuole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tecniche`
--

DROP TABLE IF EXISTS `tecniche`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tecniche` (
  `nome` varchar(25) NOT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tecniche`
--

LOCK TABLES `tecniche` WRITE;
/*!40000 ALTER TABLE `tecniche` DISABLE KEYS */;
/*!40000 ALTER TABLE `tecniche` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipi_clientela`
--

DROP TABLE IF EXISTS `tipi_clientela`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipi_clientela` (
  `nome` varchar(30) NOT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipi_clientela`
--

LOCK TABLES `tipi_clientela` WRITE;
/*!40000 ALTER TABLE `tipi_clientela` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipi_clientela` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tirocinanti`
--

DROP TABLE IF EXISTS `tirocinanti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tirocinanti` (
  `dipendente` int NOT NULL,
  `data_inizio` date NOT NULL,
  PRIMARY KEY (`dipendente`,`data_inizio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tirocinanti`
--

LOCK TABLES `tirocinanti` WRITE;
/*!40000 ALTER TABLE `tirocinanti` DISABLE KEYS */;
/*!40000 ALTER TABLE `tirocinanti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turni`
--

DROP TABLE IF EXISTS `turni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turni` (
  `dipendente` int NOT NULL,
  `data_inizio` date NOT NULL,
  `giorno` enum('lunedi','martedi','mercoledi','giovedi','venerdi','sabato','domenica') NOT NULL,
  `ora_inizio` time DEFAULT NULL,
  `ora_fine` time DEFAULT NULL,
  PRIMARY KEY (`dipendente`,`data_inizio`,`giorno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turni`
--

LOCK TABLES `turni` WRITE;
/*!40000 ALTER TABLE `turni` DISABLE KEYS */;
/*!40000 ALTER TABLE `turni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendite`
--

DROP TABLE IF EXISTS `vendite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendite` (
  `opera` int NOT NULL,
  `venditore` int NOT NULL,
  PRIMARY KEY (`opera`,`venditore`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendite`
--

LOCK TABLES `vendite` WRITE;
/*!40000 ALTER TABLE `vendite` DISABLE KEYS */;
/*!40000 ALTER TABLE `vendite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venditori`
--

DROP TABLE IF EXISTS `venditori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venditori` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) NOT NULL,
  `cognome` varchar(20) NOT NULL,
  `iban` varchar(20) DEFAULT NULL,
  `cellulare` varchar(20) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`,`cognome`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venditori`
--

LOCK TABLES `venditori` WRITE;
/*!40000 ALTER TABLE `venditori` DISABLE KEYS */;
/*!40000 ALTER TABLE `venditori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitatori`
--

DROP TABLE IF EXISTS `visitatori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visitatori` (
  `id` int NOT NULL,
  `tariffa` enum('intero','ridotto','gratuito') NOT NULL DEFAULT 'intero',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitatori`
--

LOCK TABLES `visitatori` WRITE;
/*!40000 ALTER TABLE `visitatori` DISABLE KEYS */;
/*!40000 ALTER TABLE `visitatori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volontari`
--

DROP TABLE IF EXISTS `volontari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `volontari` (
  `dipendente` int NOT NULL,
  `data_inizio` date NOT NULL,
  `associazione` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`dipendente`,`data_inizio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volontari`
--

LOCK TABLES `volontari` WRITE;
/*!40000 ALTER TABLE `volontari` DISABLE KEYS */;
/*!40000 ALTER TABLE `volontari` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-01-02 16:50:12
