-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: tutor_finder
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `tutor`
--

DROP TABLE IF EXISTS `tutor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tutor` (
  `tutor_id` int unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location_postal` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ranking_score` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`tutor_id`),
  UNIQUE KEY `uq_tutor_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutor`
--

LOCK TABLES `tutor` WRITE;
/*!40000 ALTER TABLE `tutor` DISABLE KEYS */;
INSERT INTO `tutor` VALUES (1,'Tutor 1','tutor1@example.com','N5N6Y6',NULL),(2,'Tutor 2','tutor2@example.com','D8C2D8',NULL),(3,'Tutor 3','tutor3@example.com','G6H2R3',NULL),(4,'Tutor 4','tutor4@example.com','O9P4X3',NULL),(5,'Tutor 5','tutor5@example.com','B8S9L7',NULL),(6,'Tutor 6','tutor6@example.com','T3V8F1',NULL),(7,'Tutor 7','tutor7@example.com','J7C7Y6',NULL),(8,'Tutor 8','tutor8@example.com','K5D1A4',NULL),(9,'Tutor 9','tutor9@example.com','J7S1I5',NULL),(10,'Tutor 10','tutor10@example.com','S7A3Q2',NULL),(11,'Tutor 11','tutor11@example.com','K7J3K2',NULL),(12,'Tutor 12','tutor12@example.com','Y5C7H0',NULL),(13,'Tutor 13','tutor13@example.com','Z6Q4S4',NULL),(14,'Tutor 14','tutor14@example.com','Z6F2O2',NULL),(15,'Tutor 15','tutor15@example.com','W6V5G8',NULL),(16,'Tutor 16','tutor16@example.com','Y1K1Y6',NULL),(17,'Tutor 17','tutor17@example.com','K8U5D1',NULL),(18,'Tutor 18','tutor18@example.com','W4L3R8',NULL),(19,'Tutor 19','tutor19@example.com','S8H2G7',NULL),(20,'Tutor 20','tutor20@example.com','S7V4J8',NULL),(21,'Tutor 21','tutor21@example.com','U8W2V1',NULL),(22,'Tutor 22','tutor22@example.com','Z4V4V6',NULL),(23,'Tutor 23','tutor23@example.com','Z6O4P8',NULL),(24,'Tutor 24','tutor24@example.com','G7B6H9',NULL),(25,'Tutor 25','tutor25@example.com','F7F9W4',NULL),(26,'Tutor 26','tutor26@example.com','A6I6S3',NULL),(27,'Tutor 27','tutor27@example.com','W4L6H9',NULL),(28,'Tutor 28','tutor28@example.com','H8H5Z1',NULL),(29,'Tutor 29','tutor29@example.com','P2Y8C8',NULL),(30,'Tutor 30','tutor30@example.com','B9K6J3',NULL),(31,'Tutor 31','tutor31@example.com','R0P7B0',NULL),(32,'Tutor 32','tutor32@example.com','N8X4X7',NULL),(33,'Tutor 33','tutor33@example.com','Y1H2Z3',NULL),(34,'Tutor 34','tutor34@example.com','K0G9E4',NULL),(35,'Tutor 35','tutor35@example.com','R9D9S1',NULL),(36,'Tutor 36','tutor36@example.com','E1H4U6',NULL),(37,'Tutor 37','tutor37@example.com','F4Z8L8',NULL),(38,'Tutor 38','tutor38@example.com','S4I3M2',NULL),(39,'Tutor 39','tutor39@example.com','O3C6R5',NULL),(40,'Tutor 40','tutor40@example.com','Y8T8B9',NULL),(41,'Tutor 41','tutor41@example.com','A1G4E2',NULL),(42,'Tutor 42','tutor42@example.com','Z7R0S3',NULL),(43,'Tutor 43','tutor43@example.com','F8B3H7',NULL),(44,'Tutor 44','tutor44@example.com','K1W8O0',NULL),(45,'Tutor 45','tutor45@example.com','Y3E5Y5',NULL),(46,'Tutor 46','tutor46@example.com','R5M0G8',NULL),(47,'Tutor 47','tutor47@example.com','I9R8Z4',NULL),(48,'Tutor 48','tutor48@example.com','M5Z9N5',NULL),(49,'Tutor 49','tutor49@example.com','S6Y2V1',NULL),(50,'Tutor 50','tutor50@example.com','K6X5A9',NULL),(51,'Tutor 51','tutor51@example.com','E0T8R6',NULL),(52,'Tutor 52','tutor52@example.com','J2L9Z8',NULL),(53,'Tutor 53','tutor53@example.com','N6R3A0',NULL),(54,'Tutor 54','tutor54@example.com','W8K9R8',NULL),(55,'Tutor 55','tutor55@example.com','U5K5A3',NULL),(56,'Tutor 56','tutor56@example.com','P9G8V2',NULL),(57,'Tutor 57','tutor57@example.com','W4O1J6',NULL),(58,'Tutor 58','tutor58@example.com','K5O1Q0',NULL),(59,'Tutor 59','tutor59@example.com','L9L2O7',NULL),(60,'Tutor 60','tutor60@example.com','D1O6G4',NULL),(61,'Tutor 61','tutor61@example.com','Q6X4Z9',NULL),(62,'Tutor 62','tutor62@example.com','W9W8B6',NULL),(63,'Tutor 63','tutor63@example.com','Z3K9V9',NULL),(64,'Tutor 64','tutor64@example.com','Q0I3Z3',NULL),(65,'Tutor 65','tutor65@example.com','L3G8X9',NULL),(66,'Tutor 66','tutor66@example.com','K5B7L5',NULL),(67,'Tutor 67','tutor67@example.com','E3T3A4',NULL),(68,'Tutor 68','tutor68@example.com','V8I8B6',NULL),(69,'Tutor 69','tutor69@example.com','R3R5K9',NULL),(70,'Tutor 70','tutor70@example.com','L1R1N3',NULL),(71,'Tutor 71','tutor71@example.com','I2A3Y6',NULL),(72,'Tutor 72','tutor72@example.com','S2G4A4',NULL),(73,'Tutor 73','tutor73@example.com','P9C7N1',NULL),(74,'Tutor 74','tutor74@example.com','Y6I6L5',NULL),(75,'Tutor 75','tutor75@example.com','T4G5Q0',NULL),(76,'Tutor 76','tutor76@example.com','C5G1Z2',NULL),(77,'Tutor 77','tutor77@example.com','M4G2G2',NULL),(78,'Tutor 78','tutor78@example.com','K0K9M3',NULL),(79,'Tutor 79','tutor79@example.com','Z3E4O3',NULL),(80,'Tutor 80','tutor80@example.com','K1Z0O8',NULL),(81,'Tutor 81','tutor81@example.com','S5R8M8',NULL),(82,'Tutor 82','tutor82@example.com','H1E7H4',NULL),(83,'Tutor 83','tutor83@example.com','J8W3K3',NULL),(84,'Tutor 84','tutor84@example.com','P5S1B9',NULL),(85,'Tutor 85','tutor85@example.com','S1H2W9',NULL),(86,'Tutor 86','tutor86@example.com','U2M1A8',NULL),(87,'Tutor 87','tutor87@example.com','E2I8F3',NULL),(88,'Tutor 88','tutor88@example.com','G5U8Y0',NULL),(89,'Tutor 89','tutor89@example.com','T8Y3B5',NULL),(90,'Tutor 90','tutor90@example.com','K2U4I4',NULL),(91,'Tutor 91','tutor91@example.com','K1D5X6',NULL),(92,'Tutor 92','tutor92@example.com','B9W6N5',NULL),(93,'Tutor 93','tutor93@example.com','O6W3E0',NULL),(94,'Tutor 94','tutor94@example.com','J8P5N4',NULL),(95,'Tutor 95','tutor95@example.com','Z6C9G4',NULL),(96,'Tutor 96','tutor96@example.com','R8L6A3',NULL),(97,'Tutor 97','tutor97@example.com','B2V3F0',NULL),(98,'Tutor 98','tutor98@example.com','Y3M5B1',NULL),(99,'Tutor 99','tutor99@example.com','W4Y2D3',NULL),(100,'Tutor 100','tutor100@example.com','J5O5Z3',NULL);
/*!40000 ALTER TABLE `tutor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-19 20:05:48
