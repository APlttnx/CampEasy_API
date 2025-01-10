-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: campeasy_demo
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `campingID` int DEFAULT NULL,
  `userID` int DEFAULT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `creationDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `totalPrice` double DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `campingID` (`campingID`),
  KEY `userID` (`userID`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`campingID`) REFERENCES `campings` (`ID`),
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (50,32,46,'2025-01-10','2025-01-30','2025-01-10 00:05:08',400),(51,35,48,'2025-01-16','2025-01-25','2025-01-10 00:15:53',0),(52,32,48,'2025-01-31','2025-02-03','2025-01-10 00:36:02',60),(53,33,48,'2025-01-10','2025-01-11','2025-01-10 00:36:38',30),(54,37,50,'2025-01-21','2025-01-31','2025-01-10 18:30:04',300),(55,36,50,'2025-01-10','2025-01-12','2025-01-10 18:30:34',120),(56,33,52,'2025-01-28','2025-01-31','2025-01-10 19:48:23',90),(57,35,52,'2025-01-27','2025-01-29','2025-01-10 19:48:34',30),(58,38,52,'2025-01-22','2025-01-31','2025-01-10 19:48:49',225),(59,35,60,'2025-09-01','2025-09-07','2025-01-10 20:14:40',90),(60,35,61,'2025-01-10','2025-01-12','2025-01-10 20:45:42',30),(61,41,61,'2025-01-22','2025-01-24','2025-01-10 20:51:45',0),(62,40,61,'2025-01-22','2025-01-24','2025-01-10 20:51:59',0),(63,40,61,'2025-01-10','2025-01-15','2025-01-10 21:36:39',0),(64,41,61,'2025-01-16','2025-01-20','2025-01-10 21:36:39',0),(65,39,60,'2025-02-01','2025-02-05','2025-01-10 21:36:39',0),(66,52,58,'2025-03-10','2025-03-15','2025-01-10 21:36:39',120),(67,51,57,'2025-03-20','2025-03-25','2025-01-10 21:36:39',100),(68,50,56,'2025-03-26','2025-03-30','2025-01-10 21:36:39',150),(69,49,55,'2025-04-01','2025-04-05','2025-01-10 21:36:39',90),(70,48,54,'2025-04-10','2025-04-15','2025-01-10 21:36:39',80),(71,47,53,'2025-05-01','2025-05-05','2025-01-10 21:36:39',110),(72,46,52,'2025-05-10','2025-05-15','2025-01-10 21:36:39',0),(73,38,51,'2025-06-01','2025-06-05','2025-01-10 21:36:39',140),(74,45,51,'2025-06-06','2025-06-10','2025-01-10 21:36:39',130),(75,56,51,'2025-06-11','2025-06-15','2025-01-10 21:36:39',160),(76,44,50,'2025-06-20','2025-06-25','2025-01-10 21:36:39',110),(77,55,50,'2025-06-26','2025-06-30','2025-01-10 21:36:39',130),(78,36,49,'2025-07-01','2025-07-05','2025-01-10 21:36:39',100),(79,37,49,'2025-07-06','2025-07-10','2025-01-10 21:36:39',90),(80,43,49,'2025-07-11','2025-07-15','2025-01-10 21:36:39',110),(81,54,49,'2025-07-16','2025-07-20','2025-01-10 21:36:39',120),(82,35,48,'2025-08-01','2025-08-05','2025-01-10 21:36:39',0),(83,42,48,'2025-08-06','2025-08-10','2025-01-10 21:36:39',0),(84,53,48,'2025-08-11','2025-08-15','2025-01-10 21:36:39',150),(85,32,46,'2025-09-01','2025-09-05','2025-01-10 21:36:39',0),(86,33,46,'2025-09-06','2025-09-10','2025-01-10 21:36:39',0),(87,40,46,'2025-01-28','2025-01-31','2025-01-10 21:38:05',59.97),(88,52,51,'2025-01-21','2025-01-24','2025-01-10 21:40:08',48),(89,45,51,'2025-01-16','2025-01-19','2025-01-10 21:40:42',0),(90,44,46,'2025-01-10','2025-01-12','2025-01-10 21:43:50',25);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campingfacilities`
--

DROP TABLE IF EXISTS `campingfacilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campingfacilities` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `campingID` int DEFAULT NULL,
  `facilityID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `campingID` (`campingID`),
  KEY `facilityID` (`facilityID`),
  CONSTRAINT `campingfacilities_ibfk_1` FOREIGN KEY (`campingID`) REFERENCES `campings` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `campingfacilities_ibfk_2` FOREIGN KEY (`facilityID`) REFERENCES `facilities` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campingfacilities`
--

LOCK TABLES `campingfacilities` WRITE;
/*!40000 ALTER TABLE `campingfacilities` DISABLE KEYS */;
INSERT INTO `campingfacilities` VALUES (44,32,14),(45,32,15),(46,32,16),(47,32,18),(48,32,17),(49,32,19),(50,32,24),(51,33,14),(52,33,20),(53,33,16),(54,33,21),(55,33,28),(59,35,15),(60,35,14),(61,35,16),(62,35,17),(63,35,18),(64,35,19),(65,35,20),(66,35,22),(67,35,23),(68,35,28),(69,35,29),(70,36,14),(71,36,16),(72,36,17),(73,36,18),(74,36,24),(75,36,21),(76,36,20),(77,36,15),(78,36,28),(79,36,29),(80,37,14),(81,37,15),(82,37,22),(83,37,24),(84,37,23),(85,37,20),(86,37,19),(87,37,18),(88,37,17),(89,37,16),(90,38,14),(91,38,19),(92,38,21),(93,38,28),(94,38,29),(95,38,16),(96,39,14),(97,39,15),(98,39,16),(99,39,17),(100,39,18),(101,39,20),(102,39,21),(103,39,24),(104,39,25),(105,39,26),(106,39,27),(107,39,28),(108,39,29),(109,39,30),(110,40,21),(111,40,24),(112,40,25),(113,40,27),(114,40,28),(115,40,29),(116,41,24),(117,41,25),(118,41,27),(119,41,29),(120,41,28),(121,41,21),(122,42,14),(123,42,15),(124,42,24),(125,42,30),(126,43,16),(127,43,17),(128,43,18),(129,43,28),(130,44,14),(131,44,15),(132,44,20),(133,44,21),(134,44,22),(135,44,24),(136,44,25),(137,45,17),(138,45,18),(139,45,21),(140,45,30),(141,46,14),(142,46,15),(143,46,16),(144,46,19),(145,46,26),(146,47,18),(147,47,20),(148,47,21),(149,47,22),(150,47,25),(151,48,14),(152,48,15),(153,48,16),(154,48,19),(155,48,28),(156,48,29),(157,49,20),(158,49,21),(159,49,22),(160,49,23),(161,49,30),(162,50,14),(163,50,15),(164,50,17),(165,50,18),(166,50,26),(167,51,22),(168,51,23),(169,51,24),(170,51,25),(171,51,30),(172,52,19),(173,52,20),(174,52,21),(175,52,22),(176,52,28),(177,53,14),(178,53,15),(179,53,29),(180,53,30),(181,54,16),(182,54,18),(183,54,25),(184,54,26),(185,55,14),(186,55,15),(187,55,16),(188,55,17),(189,55,18),(190,55,19),(191,55,20),(192,56,19),(193,56,20),(194,56,21),(195,56,24),(196,56,30);
/*!40000 ALTER TABLE `campingfacilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campingpictures`
--

DROP TABLE IF EXISTS `campingpictures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campingpictures` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `campingID` int DEFAULT NULL,
  `uploadDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `picture` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `campingID` (`campingID`),
  CONSTRAINT `campingpictures_ibfk_1` FOREIGN KEY (`campingID`) REFERENCES `campings` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campingpictures`
--

LOCK TABLES `campingpictures` WRITE;
/*!40000 ALTER TABLE `campingpictures` DISABLE KEYS */;
INSERT INTO `campingpictures` VALUES (13,36,'2025-01-10 17:11:28','/uploads/camping-1736528181002.jpg'),(14,37,'2025-01-10 17:23:34','/uploads/camping-1736529813148.jpg'),(15,38,'2025-01-10 17:47:52','/uploads/camping-1736531270199.webp'),(16,39,'2025-01-10 19:17:33','/uploads/camping-1736536643236.jpg'),(17,40,'2025-01-10 19:49:21','/uploads/camping-1736538554982.jpg'),(18,41,'2025-01-10 19:50:34','/uploads/camping-1736538632971.jpg');
/*!40000 ALTER TABLE `campingpictures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campings`
--

DROP TABLE IF EXISTS `campings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campings` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `size` int DEFAULT NULL,
  `price` double NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `ownerID` int NOT NULL,
  `creationDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `updateDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ownerID` (`ownerID`),
  CONSTRAINT `campings_ibfk_1` FOREIGN KEY (`ownerID`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campings`
--

LOCK TABLES `campings` WRITE;
/*!40000 ALTER TABLE `campings` DISABLE KEYS */;
INSERT INTO `campings` VALUES (32,'Zonnestrand','Tent',25,20,'Deze campingplek bevindt zich op een rustige locatie, ideaal voor kampeerders die van zon en water houden. Zonnestrand biedt een prachtig uitzicht op het meer en is vooral geschikt voor kleinere tenten. Hier kun je genieten van een ontspannen verblijf met directe toegang tot wandelpaden en picknickzones. De plek is op loopafstand van de sanitaire voorzieningen en beschikt over een elektriciteitsaansluiting. Dankzij de watervoorziening in de buurt en Wi-Fi kun je van zowel natuur als comfort genieten. Perfect voor gezinnen of stellen die op zoek zijn naar een serene vakantie.','Meerweg | 15 | 3620 | Lanaken',46,'2025-01-10 00:01:30','2025-01-10 00:01:30','België'),(33,'Schaduwhoek','Caravan',40,30,'Deze ruime plek is ideaal voor caravans en biedt veel privacy dankzij de omliggende hoge bomen. Gelegen aan de rand van het bos, kun je hier genieten van de rust en het gezang van vogels in de ochtend. Schaduwhoek is gunstig gelegen dicht bij het sanitair en biedt voldoende ruimte om buiten te zitten en te ontspannen. Deze plek is perfect voor gezinnen die op zoek zijn naar een combinatie van comfort en natuur. Barbecuefaciliteiten zijn toegestaan, en er is Wi-Fi beschikbaar om in contact te blijven met de buitenwereld. De plek is bereikbaar met auto of camper en heeft een verharde ondergrond voor stabiliteit.','Bosrand | 7 | 2400 | Mol',46,'2025-01-10 00:02:32','2025-01-10 00:02:32','België'),(35,'Amelie\'s caravanplaats','Caravan',20,15,'Locatie met veel groen in de velden, dicht bij het stad en openbaar vervoer. Zet je neer naast een historische hoeve uit de 17de eeuw.','Klaverbladdreef | 17 | 2610 | Wilrijk',48,'2025-01-10 00:15:45','2025-01-10 00:15:45','België'),(36,'Campingspot in het bos','Caravan',120,60,'Geniet van de rust en natuur in onze volledig uitgeruste caravan, gelegen in een prachtige bosrijke omgeving. De caravan biedt ruimte aan 4 personen en beschikt over een keuken, een kleine zithoek, en een comfortabel tweepersoonsbed. Ideaal voor wandelaars en natuurliefhebbers, met hiking- en mountainbikeroutes direct toegankelijk. Ontdek de charme van de Ardennen en kom helemaal tot rust.','Rue des Forêts | 23 | 6980 | La Roche-en-Ardenne',49,'2025-01-10 18:11:28','2025-01-10 18:11:28','België'),(37,'Tentspot aan het strand','Tent',25,30,'Verblijf op een gezellige en ruime tentplaats op slechts 10 minuten van het strand. Perfect voor gezinnen en avonturiers die willen genieten van de Belgische kust. De plek biedt een prachtig uitzicht en is voorzien van faciliteiten zoals een watervoorziening en elektriciteit. In de buurt vindt u diverse restaurants en winkels. De perfecte mix van natuur en comfort!','Veurnestraat | 190 | 8660 | De Panne',49,'2025-01-10 18:23:34','2025-01-10 18:23:34','België'),(38,'Tentlocatie in Frankrijk','Tent',25,25,'Ontsnap aan de drukte en verblijf op dit rustige terein, gelegen op een boerderij net buiten Lille. Geniet van een landelijke omgeving, met de mogelijkheid om verse lokale producten te proeven. Perfect voor een weekendje weg of een korte vakantie net over de grens.','Rue de la Ferme | 12 | 59200 | Tourcoing',51,'2025-01-10 18:47:52','2025-01-10 18:47:52','Frankrijk'),(39,'Camping Test','Caravan',40,50,'','Nieuwstraat | 1 | 2630 | Aartselaar',60,'2025-01-10 20:17:33','2025-01-10 21:04:33','België'),(40,'Joske\'s Veld #1','Tent',20,19.99,'Welkom bij Joske\'s veld, het beste veld van omstreke. Niemand kan op tegen Joske\'s veld. Go Joske, Go Veld!','Veldstraat | 12 | 3150 | Haacht',61,'2025-01-10 20:49:21','2025-01-10 20:49:21','België'),(41,'Joske\'s Veld #2','Tent',25,19.99,'Welkom bij Joske\'s veld, het beste veld van omstreke. Niemand kan op tegen Joske\'s veld. Go Joske, Go Veld!','Veldstraat | 12 | 3150 | Haacht',61,'2025-01-10 20:50:34','2025-01-10 20:50:34','België'),(42,'Filler Spot 1','Tent',120,15,'Een kleine campingplek, perfect voor een korte vakantie in een rustige omgeving.','Rivierstraat | 22 | 6980 | La Roche-en-Ardenne',48,'2025-01-10 20:58:13','2025-01-10 21:02:14','België'),(43,'Filler Spot 2','Caravan',250,30,'Ruime caravanplaats, gelegen aan de rand van een natuurreservaat.','Bosrandlaan | 9 | 5000 | Namur',49,'2025-01-10 20:58:13','2025-01-10 20:59:47','België'),(44,'Filler Spot 3','Tent',90,12.5,'Kleine, knusse camping in een bosrijke omgeving. Geschikt voor natuurliefhebbers.','Dennendreef | 6 | 6870 | Saint-Hubert',50,'2025-01-10 20:58:13','2025-01-10 20:59:47','België'),(45,'Filler Spot 4','Caravan',300,35,'Grote caravanplaats met toegang tot wandel- en fietspaden in de buurt.','Hoogveldstraat | 5 | 5210 | Halen',51,'2025-01-10 20:58:13','2025-01-10 20:59:47','België'),(46,'Filler Spot 5','Tent',110,18,'Een campingplek aan een beekje, ideaal voor gezinnen die van wateractiviteiten houden.','Beeklaan | 3 | 5540 | Hastière',52,'2025-01-10 20:58:13','2025-01-10 20:59:47','België'),(47,'Filler Spot 6','Caravan',200,25,'Rustige plek aan de grens met Duitsland, met prachtige uitzichten op heuvels.','Grenzenstraat | 2 | 4700 | Eupen',53,'2025-01-10 20:58:13','2025-01-10 20:59:47','België'),(48,'Filler Spot 7','Tent',140,17,'Ruime tentplaats nabij een klein meer. Perfect voor een weekendje weg.','Merenlaan | 11 | 5000 | Namen',54,'2025-01-10 20:58:13','2025-01-10 20:59:47','België'),(49,'Filler Spot 8','Caravan',280,28,'Een campingplek op een zonnige heuvel met toegang tot wandelroutes.','Heuvellaan | 8 | 6225 | Maastricht',55,'2025-01-10 20:58:13','2025-01-10 20:59:47','Nederland'),(50,'Filler Spot 9','Tent',100,20,'Een kleine, rustige campingplaats in de Franse Ardennen.','Rue de la Forêt | 15 | 08110 | Carignan',56,'2025-01-10 20:58:13','2025-01-10 20:59:47','Frankrijk'),(51,'Filler Spot 10','Caravan',320,40,'Grote caravanplek nabij een rivier in Duitsland, met uitzicht op de bergen.','Am Fluss | 12 | 54290 | Trier',57,'2025-01-10 20:58:13','2025-01-10 20:59:47','Duitsland'),(52,'Filler Spot 11','Tent',130,16,'Campingplek midden in de natuur, ideaal voor rustzoekers.','Veldweg | 4 | 3911 | Rheden',58,'2025-01-10 20:58:13','2025-01-10 20:59:47','Nederland'),(53,'Filler Spot 12','Caravan',270,38,'Ruime caravanplaats in een pittoresk dorpje in de Elzas.','Route du Vin | 10 | 67140 | Barr',48,'2025-01-10 20:58:13','2025-01-10 21:00:13','Frankrijk'),(54,'Filler Spot 13','Tent',80,14.5,'Kleine, eenvoudige campingplek in een schaduwrijk gebied.','Schaduwstraat | 7 | 6983 | Houffalize',49,'2025-01-10 20:58:13','2025-01-10 20:59:47','België'),(55,'Filler Spot 14','Caravan',230,32,'Een rustige plek nabij een klein bos. Perfect voor gezinnen.','Bosweg | 9 | 47533 | Kleve',50,'2025-01-10 20:58:13','2025-01-10 20:59:47','Duitsland'),(56,'Filler Spot 15','Tent',120,19,'Ruime tentplek in de buurt van wandelroutes en bossen.','Wandelpad | 10 | 5561 | Mol',51,'2025-01-10 20:58:13','2025-01-10 20:59:47','België');
/*!40000 ALTER TABLE `campings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facilities`
--

DROP TABLE IF EXISTS `facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facilities` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `facilityName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `facilityName` (`facilityName`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facilities`
--

LOCK TABLES `facilities` WRITE;
/*!40000 ALTER TABLE `facilities` DISABLE KEYS */;
INSERT INTO `facilities` VALUES (28,'Barbeque'),(25,'Biking'),(18,'Douche'),(14,'Elektriciteit'),(24,'Hiking'),(29,'Honden toegestaan'),(21,'In de natuur'),(27,'Kampvuur'),(22,'Onder de mensen'),(23,'Openbaar vervoer'),(19,'Overdekte schuilplaats'),(30,'Rivier'),(17,'Vast toilet'),(26,'Vissen'),(20,'Vuilnisophaling'),(15,'Wateraansluiting'),(16,'Wi-Fi');
/*!40000 ALTER TABLE `facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passwords`
--

DROP TABLE IF EXISTS `passwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passwords` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `userID` int DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `userID` (`userID`),
  CONSTRAINT `passwords_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passwords`
--

LOCK TABLES `passwords` WRITE;
/*!40000 ALTER TABLE `passwords` DISABLE KEYS */;
INSERT INTO `passwords` VALUES (12,46,'$2b$10$p/.qO5ZkdaoMOAN4oxU4AubDkJxzgZ0KwbLBLK1PvUUHL83kaMAmi'),(13,48,'$2b$10$chwMeeuxzFVdsu4bSLBA1OdrhHf02zHOzkawHLk8vQFFPaXAN0dC6'),(14,49,'$2b$10$5M6H/YLkwaPA1hklAmDPMeHd667YRzVs6Km/YZHCcgzKYx9kPFAf2'),(15,50,'$2b$10$Y6JtNuRMRXTtqcbHzN37gO0UkBOT48XzF2RCIja2XRjh73n7I1vz2'),(16,51,'$2b$10$q9G9PQA0AwX3aib849gn7emOhqscfWzWfHqbWlGfwZkFjY7LWHuIG'),(17,52,'$2b$10$fuimS.j5wczXK5R.WMKo8uu/Zs0k1hO9NwTf1bYKXvwJcQLMFojcG'),(18,53,'$2b$10$fWAMapFlYJd2yv9KErzFUe3RtK7wYAxKdqHJgwL.HzG.bLV0a0mQG'),(19,54,'$2b$10$Pj3TgyRvKHAlHvrIl4CbKuX8z0O77fOKcOkIJ0dOPCNyHwSD6jzBa'),(20,55,'$2b$10$YwYVco5doJfiRvdkUme.mOGv3zhoKZCEohc2aQHZBBKLY4MM9smSe'),(21,56,'$2b$10$teZsX/Q9uIOGocEQqvT8UOcqh7jDx6pE4gl47MLq2lAR81/ivuCKy'),(22,57,'$2b$10$rLealiQoG.Wv/qQLZYs28ug9q0rZTjRFnPidhiZOcU3SXNMNvePIm'),(23,58,'$2b$10$8INIQs8oQ.lk63rpLiCyqOcLWX1rdFrq4BTJOFz75dvlrVwn6JSEi'),(24,59,'$2b$10$7QzsFRFgfIzU3qWv70ZiOuvBcynV5rN1ST6EzruFx7L/hpgdmsfJG'),(25,60,'$2b$10$0kAT5Dm5Ih.o2QTY65Rx8uyGttOtFwHXF6DD3w.wjRHqDpzOA1PcC'),(26,61,'$2b$10$xvMpBCPiVCaY58190ZA11OfTPRr3OF3GiQjAs1DKymc6w7uKvLnYa');
/*!40000 ALTER TABLE `passwords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `userID` int DEFAULT NULL,
  `campingID` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `postDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `userID` (`userID`),
  KEY `campingID` (`campingID`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`ID`),
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`campingID`) REFERENCES `campings` (`ID`),
  CONSTRAINT `check_rating` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `preferredName` varchar(255) DEFAULT NULL,
  `roleUser` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phoneNumber` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `emergencyTel` varchar(255) DEFAULT NULL,
  `creationDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `updateDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (46,'Arnout','Plettinx','','owner','arnoutplettinx@hotmail.com','0485 53 67 92','Nieuwstraat | 1 | 2630 | Aartselaar','0496 130 161','2025-01-09 23:41:57','2025-01-10 00:06:18','België'),(48,'Amelie','Van Gucht','','owner','amelievangucht@hotmail.be','+322 452 85 93 02','Klaverbladdreef | 21 | 2610 | Wilrijk','','2025-01-10 00:13:50','2025-01-10 00:15:45','België'),(49,'Karen','Heynissen','','owner','karenheynissen@gmail.com','','Klaverbladdreef | 18 | 2610 | Wilrijk','','2025-01-10 17:45:19','2025-01-10 18:11:28','België'),(50,'Sacha','Boeckx','Sach','user','sachaboeckx@gmail.com','','Troef | 8 | 2300 | Turnhout','04 85 53 67 92','2025-01-10 18:29:42','2025-01-10 18:29:42','België'),(51,'Emily','Van der Reysen','','owner','emilyvanderreysen@outlook.be','',' |  | 2620 | Hemiksem','','2025-01-10 18:44:34','2025-01-10 21:39:39','België'),(52,'Jan','Janssens','','user','jan.janssens@example.com','0470 12 34 56','Dorpsstraat | 10 | 1000 | Brussel','0497 89 12 34','2025-01-10 19:46:38','2025-01-10 19:46:38','België'),(53,'Sophie','Desmet','','user','sophie.desmet@outlook.com','0485536792',' |  | 2630 | Aartselaar','','2025-01-10 19:49:47','2025-01-10 19:49:47','België'),(54,'Jonas','Hertoghs','Johnny','user','johnnyhertogh@gmail.be','',' |  |  | ','','2025-01-10 19:50:24','2025-01-10 19:50:24',''),(55,'Lisa','De Ridder','','user','lisaderidder@outlook.be','',' |  |  | ','','2025-01-10 19:50:56','2025-01-10 19:50:56',''),(56,'Mathilde','Bal','','user','mathildebal@gmail.com','',' |  |  | ','','2025-01-10 19:51:37','2025-01-10 19:51:37',''),(57,'Dirk','Geens','','user','dirkgeens@hotmail.com','',' |  |  | ','','2025-01-10 19:52:20','2025-01-10 19:52:20',''),(58,'Martine','Verhoeven','Tine','user','tineverhoeven@outlook.be','',' |  |  | ','','2025-01-10 19:53:08','2025-01-10 19:53:08',''),(59,'Johan','De Wit','','user','johandewit@outlook.com','',' |  |  | ','','2025-01-10 20:07:20','2025-01-10 20:07:20',''),(60,'Andre','Plettinx','','owner','andreplettinx@hotmail.com','','Klaverbladdreef | 22 | 2610 | Wilrijk','','2025-01-10 20:13:36','2025-01-10 20:35:18','België'),(61,'Jos','Pieters','Joske','owner','joskepieters@hotmail.be','+32 912 9492 94','Bakkerstraat | 124 | 3150 | Haacht','','2025-01-10 20:45:02','2025-01-10 20:52:19','België');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-10 21:53:15
