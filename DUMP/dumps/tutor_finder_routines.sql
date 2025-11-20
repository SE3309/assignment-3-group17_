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
-- Temporary view structure for view `tutor_course_ratings`
--

DROP TABLE IF EXISTS `tutor_course_ratings`;
/*!50001 DROP VIEW IF EXISTS `tutor_course_ratings`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tutor_course_ratings` AS SELECT 
 1 AS `tutor_id`,
 1 AS `course_id`,
 1 AS `experience_years`,
 1 AS `hourly_rate_dollars`,
 1 AS `rating_avg`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `tutor_ratings_overall`
--

DROP TABLE IF EXISTS `tutor_ratings_overall`;
/*!50001 DROP VIEW IF EXISTS `tutor_ratings_overall`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tutor_ratings_overall` AS SELECT 
 1 AS `tutor_id`,
 1 AS `full_name`,
 1 AS `email`,
 1 AS `location_postal`,
 1 AS `ranking_score`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `tutor_course_ratings`
--

/*!50001 DROP VIEW IF EXISTS `tutor_course_ratings`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tutor_course_ratings` AS select `tc`.`tutor_id` AS `tutor_id`,`tc`.`course_id` AS `course_id`,`tc`.`experience_years` AS `experience_years`,`tc`.`hourly_rate_dollars` AS `hourly_rate_dollars`,avg(`r`.`rating`) AS `rating_avg` from ((`tutor_course` `tc` left join `booking` `b` on((`b`.`tutor_id` = `tc`.`tutor_id`))) left join `review` `r` on((`r`.`booking_id` = `b`.`booking_id`))) group by `tc`.`tutor_id`,`tc`.`course_id`,`tc`.`experience_years`,`tc`.`hourly_rate_dollars` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tutor_ratings_overall`
--

/*!50001 DROP VIEW IF EXISTS `tutor_ratings_overall`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tutor_ratings_overall` AS select `t`.`tutor_id` AS `tutor_id`,`t`.`full_name` AS `full_name`,`t`.`email` AS `email`,`t`.`location_postal` AS `location_postal`,avg(`r`.`rating`) AS `ranking_score` from ((`tutor` `t` left join `booking` `b` on((`b`.`tutor_id` = `t`.`tutor_id`))) left join `review` `r` on((`r`.`booking_id` = `b`.`booking_id`))) group by `t`.`tutor_id`,`t`.`full_name`,`t`.`email`,`t`.`location_postal` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'tutor_finder'
--

--
-- Dumping routines for database 'tutor_finder'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-19 20:05:50
