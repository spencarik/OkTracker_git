CREATE DATABASE  IF NOT EXISTS `oktracker` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `oktracker`;
-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: localhost    Database: oktracker
-- ------------------------------------------------------
-- Server version	5.5.28-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary table structure for view `releases`
--

DROP TABLE IF EXISTS `releases`;
/*!50001 DROP VIEW IF EXISTS `releases`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `releases` (
  `status_id` int(11),
  `status_name` varchar(45),
  `status_description` varchar(256),
  `category_id` int(11),
  `category_name` varchar(256),
  `topic_id` int(11),
  `release_title` varchar(256),
  `release_id` int(11),
  `release_description` varchar(256),
  `release_file` blob,
  `user_name` varchar(256),
  `user_id` int(11),
  `size` bigint(20) unsigned,
  `creation_date` datetime
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `last20added`
--

DROP TABLE IF EXISTS `last20added`;
/*!50001 DROP VIEW IF EXISTS `last20added`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `last20added` (
  `status_id` int(11),
  `status_name` varchar(45),
  `status_description` varchar(256),
  `category_id` int(11),
  `category_name` varchar(256),
  `topic_id` int(11),
  `release_title` varchar(256),
  `release_id` int(11),
  `user_name` varchar(256),
  `user_id` int(11),
  `size` bigint(20) unsigned,
  `creation_date` datetime
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `releases`
--

/*!50001 DROP TABLE IF EXISTS `releases`*/;
/*!50001 DROP VIEW IF EXISTS `releases`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`spencer`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `releases` AS select `rst`.`Id` AS `status_id`,`rst`.`Name` AS `status_name`,`rst`.`Description` AS `status_description`,`cat`.`Id` AS `category_id`,`cat`.`Name` AS `category_name`,`t`.`Id` AS `topic_id`,`r`.`Title` AS `release_title`,`r`.`Id` AS `release_id`,`r`.`Description` AS `release_description`,`r`.`TorrentFile` AS `release_file`,`u`.`name` AS `user_name`,`u`.`id` AS `user_id`,`r`.`Size` AS `size`,`r`.`CreationDate` AS `creation_date` from ((((`release` `r` left join `releasestatus` `rst` on((`r`.`ReleaseStatus_Id` = `rst`.`Id`))) left join `my_aspnet_users` `u` on((`r`.`User_Id` = `u`.`id`))) left join `topic` `t` on((`t`.`Release_Id` = `r`.`Id`))) left join `category` `cat` on((`cat`.`Id` = `t`.`Category_Id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `last20added`
--

/*!50001 DROP TABLE IF EXISTS `last20added`*/;
/*!50001 DROP VIEW IF EXISTS `last20added`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`spencer`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `last20added` AS select `releases`.`status_id` AS `status_id`,`releases`.`status_name` AS `status_name`,`releases`.`status_description` AS `status_description`,`releases`.`category_id` AS `category_id`,`releases`.`category_name` AS `category_name`,`releases`.`topic_id` AS `topic_id`,`releases`.`release_title` AS `release_title`,`releases`.`release_id` AS `release_id`,`releases`.`user_name` AS `user_name`,`releases`.`user_id` AS `user_id`,`releases`.`size` AS `size`,`releases`.`creation_date` AS `creation_date` from `releases` order by `releases`.`creation_date` desc limit 20 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping routines for database 'oktracker'
--
/*!50003 DROP FUNCTION IF EXISTS `get_times_downloaded` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`spencer`@`%`*/ /*!50003 FUNCTION `get_times_downloaded`(p_release_id int) RETURNS int(11)
BEGIN	
	RETURN (select count(*) from download_history where release_id = p_release_id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_admin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`spencer`@`localhost`*/ /*!50003 PROCEDURE `add_admin`(fullname varchar(100))
BEGIN
	create user fullname;
	grant all privileges on *.* to fullname;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`spencer`@`localhost`*/ /*!50003 PROCEDURE `add_user`(username varchar(100))
BEGIN
	declare fullname varchar(120);
	set fullname = concat(username,@,'%');
	grant select on `oktracker`.category to fullname;
	/*grant select,insert,update on `oktracker`.`comment` to username@'%';
	grant all privileges on `oktracker`.download_history to username@'%';
	grant all privileges on `oktracker`.`profile` to username@'%';
	grant all privileges on `oktracker`.`release` to username@'%';
	grant select on `oktracker`.releasestatus to username@'%';
	grant select on `oktracker`.`status` to username@'%';
	grant select, insert on `oktracker`.`tag` to username@'%';
	grant all privileges on `oktracker`.`tag_release` to username@'%';
	grant select, insert, update on `oktracker`.`topic` to username@'%';*/
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `comments_for_topic` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`spencer`@`%`*/ /*!50003 PROCEDURE `comments_for_topic`(p_topic_id int)
BEGIN
	select 
		c.text as 'text',
		c.creationdate as 'creationdate',
		c.id as 'comment_id',
		u.`name` as 'user_name',
		u.id as 'user_id'
	from (select * from `comment` where topic_id = p_topic_id) c
		left join my_aspnet_users u on u.id = c.user_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`spencer`@`%`*/ /*!50003 PROCEDURE `delete_user`(p_id int)
BEGIN
	declare username varchar(100);
	select `name` into username from user where id = p_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DynamicReport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`spencer`@`localhost`*/ /*!50003 PROCEDURE `DynamicReport`(
	minSize			int(20),
	maxSize			int(20),
	dateFrom		datetime,
	dateTo			datetime,
	titleParam		varchar(256),
	tag				text,
	nicknameParam	varchar(256)
)
BEGIN
	SELECT 
		size,
		creation_date,
		title,
		torrentUrl,
		description,
		tags,
		nickname
	FROM total_view
	WHERE
		size >= COALESCE(minSize, 0) and
		size <= COALESCE(maxSize, 18446744073709551615) and
		creation_date >= COALESCE(dateFrom, '1000-01-01 00:00:00') and
		creation_date <= COALESCE(dateTo, CURRENT_TIMESTAMP) and
		title LIKE CONCAT('%',COALESCE(titleParam, ''),'%') and
		tags LIKE CONCAT('%',COALESCE(tag,''),'%') and
		nickname LIKE CONCAT('%',COALESCE(nicknameParam,''),'%')
	INTO OUTFILE 'D:/report.csv'
	FIELDS TERMINATED BY ','
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n';

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `edit_user_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`spencer`@`%`*/ /*!50003 PROCEDURE `edit_user_data`(p_id int, p_lastname varchar(100), p_picture blob,
											  p_firstname varchar(100), p_email varchar(100))
BEGIN
	UPDATE `user` SET lastname = p_lastname, firstname = p_firstname, email=p_email, picture = p_picture WHERE id=p_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_users` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`spencer`@`%`*/ /*!50003 PROCEDURE `get_all_users`()
BEGIN
select u.id, u.`name`, u.creationdate, u.firstname, u.lastname, u.email, u.picture, st.`name`, st.description  
from (select * from user) u left join status st on u.status_id = st.id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_release_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`spencer`@`%`*/ /*!50003 PROCEDURE `get_release_info`(p_topic_id int)
BEGIN
	select *, get_times_downloaded(topic_id) as 'Downloaded' from releases where topic_id = p_topic_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`spencer`@`%`*/ /*!50003 PROCEDURE `get_user`(user_id int)
BEGIN

( select u.`name`, u.creationdate, u.firstname, u.lastname, u.email, u.picture, st.`name`, st.description  
from (select * from user where id = user_id) u left join status st on u.status_id = st.id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_user_by_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `get_user_by_name`(p_name varchar(100))
BEGIN
	( select u.id, u.creationdate, u.firstname, u.lastname, u.email, u.picture, st.`name`, st.description  
	from (select * from user where `name` = p_name) u left join status st on u.status_id = st.id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `history_of_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`spencer`@`%`*/ /*!50003 PROCEDURE `history_of_user`(p_user_id int)
BEGIN
	select
		r.status_id as 'status_id',
		r.status_name as 'status_name',
		r.status_description as 'status_description',
		r.category_id as 'category_id',
		r.category_name as 'category_name',
		r.topic_id as 'topic_id',
		r.release_title as 'release_title',
		r.release_id as 'release_id',
		r.release_file as 'release_file',
		r.release_description as 'release_description',
		r.user_name as 'user_name',
		r.user_id as 'user_id',
		r.size as 'size',
		dh.`date` as 'download_date'
	from (select * from download_history where user_id = p_user_id) dh 
			left join releases r on r.release_id = dh.release_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_release` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`spencer`@`%`*/ /*!50003 PROCEDURE `insert_release`(p_user_id int, p_title varchar(256), p_releasestatus_id int, 
													p_description varchar(256), p_image blob, p_file  blob, p_size bigint)
BEGIN
		insert into `release`(user_id, title, releasestatus_id, description, image, torrentfile, `size`, creationdate)
		values (p_user_id, p_title, p_releasestatus_id, p_description, p_image, p_file, p_size, null);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upload_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`spencer`@`%`*/ /*!50003 PROCEDURE `upload_data`()
BEGIN
	SELECT User_Id, CreationDate, Title,ReleaseStatus_Id, Description,Size INTO OUTFILE 'D:/Univer/Sem 8/data.csv'
	  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
	  LINES TERMINATED BY '\n'
	  FROM `release`;
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

-- Dump completed on 2013-05-15  2:47:25
