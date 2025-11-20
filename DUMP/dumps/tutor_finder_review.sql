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
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_id` int unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` int unsigned NOT NULL,
  `rating` int NOT NULL,
  `grade_before` int DEFAULT NULL,
  `grade_after` int DEFAULT NULL,
  `total_hours` decimal(4,2) DEFAULT NULL,
  `grade_change` decimal(5,2) DEFAULT NULL,
  `student_feedback` text COLLATE utf8mb4_unicode_ci,
  `tutor_feedback` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`review_id`),
  KEY `fk_review_booking` (`booking_id`),
  CONSTRAINT `fk_review_booking` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,1,3,73,70,1.00,-3.00,'3, False','True'),(2,2,4,100,100,1.00,0.00,'4, True','True'),(3,3,5,99,100,1.00,1.00,'5, True','False'),(4,4,1,54,50,1.00,-4.00,'1, False','True'),(5,5,5,55,51,1.00,-4.00,'5, True','False'),(6,6,1,75,82,1.00,7.00,'1, False','True'),(7,7,2,83,77,1.00,-6.00,'2, False','True'),(8,8,2,61,68,1.00,7.00,'2, False','False'),(9,9,2,57,67,1.00,10.00,'2, False','True'),(10,10,5,74,80,1.00,6.00,'5, True','True'),(11,11,2,55,57,1.00,2.00,'2, False','True'),(12,12,5,52,53,1.00,1.00,'5, True','True'),(13,13,2,60,71,1.00,11.00,'2, False','False'),(14,14,1,51,60,1.00,9.00,'1, False','True'),(15,15,2,58,59,1.00,1.00,'2, False','False'),(16,16,5,53,49,1.00,-4.00,'5, True','False'),(17,17,3,71,77,1.00,6.00,'3, False','False');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_review_set_hours_and_grade` BEFORE INSERT ON `review` FOR EACH ROW BEGIN
  DECLARE v_start DATETIME;
  DECLARE v_end   DATETIME;
  DECLARE v_duration_hours DECIMAL(5,2);

  -- 1) Get the booking slot from availability via booking
  SELECT a.start_time, a.end_time
  INTO v_start, v_end
  FROM booking b
  JOIN availability a ON a.availability_id = b.availability_id
  WHERE b.booking_id = NEW.booking_id;

  -- 2) Compute duration in hours
  IF v_start IS NULL OR v_end IS NULL THEN
    SET v_duration_hours = 1.0;
  ELSE
    SET v_duration_hours =
      TIMESTAMPDIFF(MINUTE, v_start, v_end) / 60.0;
  END IF;

  SET NEW.total_hours = ROUND(v_duration_hours, 2);

  -- 3) grade_change = grade_after - grade_before
  IF NEW.grade_before IS NOT NULL AND NEW.grade_after IS NOT NULL THEN
    SET NEW.grade_change = NEW.grade_after - NEW.grade_before;
  ELSE
    SET NEW.grade_change = NULL;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-19 20:05:49
