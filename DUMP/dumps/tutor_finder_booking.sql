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
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `booking_id` int unsigned NOT NULL AUTO_INCREMENT,
  `tutor_id` int unsigned NOT NULL,
  `student_id` int unsigned NOT NULL,
  `course_id` int unsigned NOT NULL,
  `location_id` int unsigned NOT NULL,
  `availability_id` int unsigned DEFAULT NULL,
  `price_dollars` decimal(8,2) NOT NULL,
  PRIMARY KEY (`booking_id`),
  KEY `fk_booking_course` (`course_id`),
  KEY `fk_booking_location` (`location_id`),
  KEY `idx_booking_tutor` (`tutor_id`),
  KEY `idx_booking_student` (`student_id`),
  KEY `idx_booking_availability` (`availability_id`),
  CONSTRAINT `fk_booking_availability` FOREIGN KEY (`availability_id`) REFERENCES `availability` (`availability_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_booking_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_booking_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_booking_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_booking_tutor` FOREIGN KEY (`tutor_id`) REFERENCES `tutor` (`tutor_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (1,68,191,89,14,70,22.00),(2,8,371,70,20,24,32.00),(3,66,17,95,19,106,78.00),(4,10,18,19,12,5,55.00),(5,66,208,83,1,39,78.00),(6,35,250,70,19,43,47.00),(7,33,149,85,16,97,38.00),(8,10,350,29,20,112,55.00),(9,91,393,60,12,83,61.00),(10,46,294,11,11,75,77.00),(11,26,141,13,6,74,41.00),(12,56,41,75,15,65,27.00),(13,92,214,25,16,68,77.00),(14,29,56,59,12,67,49.00),(15,68,331,59,16,8,22.00),(16,26,177,37,8,18,41.00),(17,77,43,97,16,61,69.00);
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_booking_set_price` BEFORE INSERT ON `booking` FOR EACH ROW BEGIN
  DECLARE v_duration_hours DECIMAL(5,2);
  DECLARE v_hourly_rate DECIMAL(6,2);

  -- duration in hours, based on availability
  SELECT
    TIMESTAMPDIFF(MINUTE, a.start_time, a.end_time) / 60.0
  INTO v_duration_hours
  FROM availability a
  WHERE a.availability_id = NEW.availability_id;

  -- pick any hourly rate for this tutor
  SELECT tc.hourly_rate_dollars
  INTO v_hourly_rate
  FROM tutor_course tc
  WHERE tc.tutor_id = NEW.tutor_id
  LIMIT 1;

  IF v_duration_hours IS NULL THEN
    SET v_duration_hours = 1.0;
  END IF;

  IF v_hourly_rate IS NULL THEN
    SET v_hourly_rate = 40.00; -- fallback
  END IF;

  SET NEW.price_dollars = ROUND(v_duration_hours * v_hourly_rate, 2);
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
