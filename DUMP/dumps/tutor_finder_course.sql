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
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `course_id` int unsigned NOT NULL AUTO_INCREMENT,
  `course_code` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`course_id`),
  UNIQUE KEY `uq_course_code` (`course_code`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'BIO101','Course Title 1'),(2,'CSE102','Course Title 2'),(3,'CSE103','Course Title 3'),(4,'PHY104','Course Title 4'),(5,'ECO105','Course Title 5'),(6,'CSE106','Course Title 6'),(7,'CS107','Course Title 7'),(8,'BIO108','Course Title 8'),(9,'CSE109','Course Title 9'),(10,'CSE110','Course Title 10'),(11,'CS111','Course Title 11'),(12,'SE112','Course Title 12'),(13,'ENG113','Course Title 13'),(14,'CSE114','Course Title 14'),(15,'ECO115','Course Title 15'),(16,'ENG116','Course Title 16'),(17,'HIS117','Course Title 17'),(18,'SE118','Course Title 18'),(19,'MAT119','Course Title 19'),(20,'CSE120','Course Title 20'),(21,'CSE121','Course Title 21'),(22,'MAT122','Course Title 22'),(23,'SE123','Course Title 23'),(24,'BIO124','Course Title 24'),(25,'MAT125','Course Title 25'),(26,'ENG126','Course Title 26'),(27,'PHY127','Course Title 27'),(28,'CS128','Course Title 28'),(29,'CS129','Course Title 29'),(30,'ENG130','Course Title 30'),(31,'ECO131','Course Title 31'),(32,'MAT132','Course Title 32'),(33,'BIO133','Course Title 33'),(34,'PHY134','Course Title 34'),(35,'CS135','Course Title 35'),(36,'CSE136','Course Title 36'),(37,'BIO137','Course Title 37'),(38,'PHY138','Course Title 38'),(39,'SE139','Course Title 39'),(40,'CSE140','Course Title 40'),(41,'ENG141','Course Title 41'),(42,'BIO142','Course Title 42'),(43,'CS143','Course Title 43'),(44,'ENG144','Course Title 44'),(45,'PHY145','Course Title 45'),(46,'ECO146','Course Title 46'),(47,'CS147','Course Title 47'),(48,'ENG148','Course Title 48'),(49,'BIO149','Course Title 49'),(50,'PHY150','Course Title 50'),(51,'CS151','Course Title 51'),(52,'CSE152','Course Title 52'),(53,'PHY153','Course Title 53'),(54,'BIO154','Course Title 54'),(55,'CSE155','Course Title 55'),(56,'CS156','Course Title 56'),(57,'PHY157','Course Title 57'),(58,'SE158','Course Title 58'),(59,'HIS159','Course Title 59'),(60,'MAT160','Course Title 60'),(61,'PHY161','Course Title 61'),(62,'SE162','Course Title 62'),(63,'CS163','Course Title 63'),(64,'ENG164','Course Title 64'),(65,'HIS165','Course Title 65'),(66,'MAT166','Course Title 66'),(67,'ECO167','Course Title 67'),(68,'CSE168','Course Title 68'),(69,'BIO169','Course Title 69'),(70,'ECO170','Course Title 70'),(71,'ENG171','Course Title 71'),(72,'MAT172','Course Title 72'),(73,'ENG173','Course Title 73'),(74,'CSE174','Course Title 74'),(75,'PHY175','Course Title 75'),(76,'CSE176','Course Title 76'),(77,'BIO177','Course Title 77'),(78,'PHY178','Course Title 78'),(79,'MAT179','Course Title 79'),(80,'PHY180','Course Title 80'),(81,'CSE181','Course Title 81'),(82,'CS182','Course Title 82'),(83,'ENG183','Course Title 83'),(84,'PHY184','Course Title 84'),(85,'CSE185','Course Title 85'),(86,'MAT186','Course Title 86'),(87,'ENG187','Course Title 87'),(88,'BIO188','Course Title 88'),(89,'CS189','Course Title 89'),(90,'BIO190','Course Title 90'),(91,'SE191','Course Title 91'),(92,'BIO192','Course Title 92'),(93,'PHY193','Course Title 93'),(94,'MAT194','Course Title 94'),(95,'ENG195','Course Title 95'),(96,'PHY196','Course Title 96'),(97,'CSE197','Course Title 97'),(98,'ECO198','Course Title 98'),(99,'MAT199','Course Title 99'),(100,'CS200','Course Title 100');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-19 20:05:49
