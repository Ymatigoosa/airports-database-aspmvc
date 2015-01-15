CREATE DATABASE  IF NOT EXISTS `airport` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `airport`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: airport
-- ------------------------------------------------------
-- Server version	5.6.20

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
-- Table structure for table `airline`
--

DROP TABLE IF EXISTS `airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `airline` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airline`
--

LOCK TABLES `airline` WRITE;
/*!40000 ALTER TABLE `airline` DISABLE KEYS */;
INSERT INTO `airline` VALUES (1,'Volgograd-test-airlines'),(2,'Moskow-test-airlines');
/*!40000 ALTER TABLE `airline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `airline_statistics`
--

DROP TABLE IF EXISTS `airline_statistics`;
/*!50001 DROP VIEW IF EXISTS `airline_statistics`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `airline_statistics` (
  `id` tinyint NOT NULL,
  `airline_name` tinyint NOT NULL,
  `avg_day_sortie_count` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `airport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city` int(11) NOT NULL,
  `airline` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `iairportairline` (`airline`),
  KEY `iairportcity` (`city`),
  CONSTRAINT `fkaiportairline` FOREIGN KEY (`airline`) REFERENCES `airline` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fkaiportcity` FOREIGN KEY (`city`) REFERENCES `city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport`
--

LOCK TABLES `airport` WRITE;
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
INSERT INTO `airport` VALUES (1,1,1),(2,2,2);
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `baggage`
--

DROP TABLE IF EXISTS `baggage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `baggage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` text,
  `owned_by` int(11) NOT NULL,
  `receipt_date` datetime NOT NULL,
  `return_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dsdsdsadsa` (`owned_by`),
  CONSTRAINT `sadsadsdsadsadas` FOREIGN KEY (`owned_by`) REFERENCES `passenger` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `baggage`
--

LOCK TABLES `baggage` WRITE;
/*!40000 ALTER TABLE `baggage` DISABLE KEYS */;
INSERT INTO `baggage` VALUES (1,'bag1',1,'2014-12-18 00:00:00',NULL),(2,'bag2',1,'2014-12-18 00:00:00',NULL);
/*!40000 ALTER TABLE `baggage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brigade`
--

DROP TABLE IF EXISTS `brigade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brigade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brigade`
--

LOCK TABLES `brigade` WRITE;
/*!40000 ALTER TABLE `brigade` DISABLE KEYS */;
INSERT INTO `brigade` VALUES (1,'main pilots'),(2,'sellers brigade'),(3,'secondary pilots');
/*!40000 ALTER TABLE `brigade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `brigade_list`
--

DROP TABLE IF EXISTS `brigade_list`;
/*!50001 DROP VIEW IF EXISTS `brigade_list`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `brigade_list` (
  `brigade` tinyint NOT NULL,
  `brigades` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `country` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `country` (`country`),
  CONSTRAINT `asdgfbvbvcbc` FOREIGN KEY (`country`) REFERENCES `country` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'Volgograd',1),(2,'Moskow',1);
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'Russia');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `delayed_landings`
--

DROP TABLE IF EXISTS `delayed_landings`;
/*!50001 DROP VIEW IF EXISTS `delayed_landings`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `delayed_landings` (
  `id` tinyint NOT NULL,
  `flight` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `delta_time` tinyint NOT NULL,
  `start` tinyint NOT NULL,
  `reason` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `airport` int(11) NOT NULL,
  `head` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `adsadas` (`airport`),
  KEY `asdsadsadasdas` (`head`),
  KEY `dsfdfdsfds` (`type`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`type`) REFERENCES `employee_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dfsdsdsadsadas` FOREIGN KEY (`head`) REFERENCES `employee` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `gfdgdfgdf` FOREIGN KEY (`airport`) REFERENCES `airport` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'main pilot departmen',1,1,1),(2,'main sellers',1,3,4);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `department_view`
--

DROP TABLE IF EXISTS `department_view`;
/*!50001 DROP VIEW IF EXISTS `department_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `department_view` (
  `id` tinyint NOT NULL,
  `departnent_name` tinyint NOT NULL,
  `head_name` tinyint NOT NULL,
  `head_lastname` tinyint NOT NULL,
  `brigades` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `patronymic` varchar(50) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `additional_phone` varchar(20) DEFAULT NULL,
  `comment` text,
  `number_of_flights` int(11) DEFAULT NULL,
  `hours_in_flights` int(11) DEFAULT NULL,
  `hire_date` date NOT NULL,
  `date_of_dismissal` date DEFAULT NULL,
  `city_of_residence` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `last_medical_examination` date NOT NULL,
  `brigade` int(11) NOT NULL,
  `airport` int(11) NOT NULL,
  `salary` int(11) NOT NULL DEFAULT '0',
  `childrencount` int(11) DEFAULT NULL,
  `sex` enum('Male','Female') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dsadsdsadasdas` (`city_of_residence`),
  KEY `gfhgfhfg` (`type`),
  KEY `sddsdas` (`brigade`),
  KEY `asdasdsadsadasd` (`airport`),
  CONSTRAINT `bvcbvcbvcbvcbvcbvcb` FOREIGN KEY (`type`) REFERENCES `employee_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dfdfsdfdsfdsfds` FOREIGN KEY (`brigade`) REFERENCES `brigade` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sdsdsfdfdsfdfdsfdsfds` FOREIGN KEY (`airport`) REFERENCES `airport` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sfdfsdfsdfdsfsd` FOREIGN KEY (`city_of_residence`) REFERENCES `city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'ivanov','ivan','ivanovich','+79371234576',NULL,'10',109,35,'2001-01-01',NULL,1,1,'2014-12-18',1,1,0,NULL,'Male'),(2,'petrov','petr','petrovich','+79371234576',NULL,'10',109,35,'2001-01-01',NULL,1,1,'2014-12-18',1,1,0,NULL,'Male'),(3,'sidor','sidorov','sidorodich','+79554443322',NULL,NULL,NULL,NULL,'2000-01-01',NULL,1,4,'2000-01-01',2,1,15000,0,'Male'),(4,'vova','vovov','vovovich','+79554443322',NULL,NULL,NULL,NULL,'2000-01-01',NULL,1,1,'2000-01-01',3,1,50000,0,'Male');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `employee_list`
--

DROP TABLE IF EXISTS `employee_list`;
/*!50001 DROP VIEW IF EXISTS `employee_list`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `employee_list` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `lastname` tinyint NOT NULL,
  `patronymic` tinyint NOT NULL,
  `phone` tinyint NOT NULL,
  `additional_phone` tinyint NOT NULL,
  `comment` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `brigade` tinyint NOT NULL,
  `airport` tinyint NOT NULL,
  `salary` tinyint NOT NULL,
  `childrencount` tinyint NOT NULL,
  `sex` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `employee_type`
--

DROP TABLE IF EXISTS `employee_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_type`
--

LOCK TABLES `employee_type` WRITE;
/*!40000 ALTER TABLE `employee_type` DISABLE KEYS */;
INSERT INTO `employee_type` VALUES (1,'pilot'),(2,'dispatcher'),(3,'technician'),(4,'cashier'),(5,'security_officer'),(6,'reference_service'),(7,'others');
/*!40000 ALTER TABLE `employee_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flight` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team` int(11) NOT NULL,
  `flight_class` int(11) NOT NULL,
  `plane` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fdsfdsfdsfsdf` (`team`),
  KEY `dasdasdsadsadas` (`flight_class`),
  KEY `dgfgfgfgdfgcvc` (`plane`),
  CONSTRAINT `asdfgdgfgfghf` FOREIGN KEY (`flight_class`) REFERENCES `flight_class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hjhjhjgddasdasdas` FOREIGN KEY (`team`) REFERENCES `brigade` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `jhgjhggfhfd` FOREIGN KEY (`plane`) REFERENCES `plane` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES (12,1,1,1),(13,3,2,2);
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `flight_add_check` BEFORE INSERT ON `flight` FOR EACH ROW begin
declare in_repair int;
declare c1 int;
declare c2 int;

select count(*) 
from plane_repairs_ended 
join plane_repairs  
where 
NEW.plane = plane_repairs.plane 
and (plane_repairs_ended.end_date > NOW()
or plane_repairs_ended.conclusion='cannot repared')
into in_repair;

select count(*)
into c1
from `flight`
where `flight`.`team` = NEW.`team`;

select count(*)
into c2
from `flight`
where `flight`.`plane` = NEW.`plane`;

if in_repair>0 or c1>0 or c2>0 then
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'cannot add flight';
end if;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `flight_class`
--

DROP TABLE IF EXISTS `flight_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flight_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from` int(11) NOT NULL,
  `to` int(11) NOT NULL,
  `periodicity_type` enum('once','on odd days','on the even days','on weekends','Every N Sundy','Every N Monday','Every N Tuesday','Every N Wendesday','Every N Thursday','Every N Friday','Every N Saturday') NOT NULL,
  `period` int(11) NOT NULL DEFAULT '1',
  `time of departure` time NOT NULL,
  `travel time` time NOT NULL,
  `range` int(11) NOT NULL,
  `type` enum('terminal','transit') NOT NULL,
  `common_price` int(11) NOT NULL,
  `premium_price` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `jghhgfsdfs` (`from`),
  KEY `dgbvbcxvc` (`to`),
  CONSTRAINT `dfdfasdsadsadsadsa` FOREIGN KEY (`to`) REFERENCES `airport` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dvsdasdasdsadsa` FOREIGN KEY (`from`) REFERENCES `airport` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight_class`
--

LOCK TABLES `flight_class` WRITE;
/*!40000 ALTER TABLE `flight_class` DISABLE KEYS */;
INSERT INTO `flight_class` VALUES (1,1,2,'on weekends',1,'00:00:10','05:00:01',1000,'terminal',1500,3000),(2,1,2,'on weekends',1,'12:00:00','03:00:00',1000,'terminal',2000,4000);
/*!40000 ALTER TABLE `flight_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `flight_class_stat`
--

DROP TABLE IF EXISTS `flight_class_stat`;
/*!50001 DROP VIEW IF EXISTS `flight_class_stat`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `flight_class_stat` (
  `id` tinyint NOT NULL,
  `plane_id` tinyint NOT NULL,
  `plane_model_name` tinyint NOT NULL,
  `team` tinyint NOT NULL,
  `avg_passenger_capacity` tinyint NOT NULL,
  `avg_bought` tinyint NOT NULL,
  `avg_free` tinyint NOT NULL,
  `avg_sortie_delta_time` tinyint NOT NULL,
  `avg_delta_time` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `flight_info`
--

DROP TABLE IF EXISTS `flight_info`;
/*!50001 DROP VIEW IF EXISTS `flight_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `flight_info` (
  `id` tinyint NOT NULL,
  `plane_id` tinyint NOT NULL,
  `plane_model_name` tinyint NOT NULL,
  `team` tinyint NOT NULL,
  `passenger_capacity` tinyint NOT NULL,
  `bought` tinyint NOT NULL,
  `free` tinyint NOT NULL,
  `sortie_start` tinyint NOT NULL,
  `sortie_delta_time` tinyint NOT NULL,
  `landing_start` tinyint NOT NULL,
  `landing_delta_time` tinyint NOT NULL,
  `flight_class` tinyint NOT NULL,
  `from` tinyint NOT NULL,
  `to` tinyint NOT NULL,
  `periodicity_type` tinyint NOT NULL,
  `time of departure` tinyint NOT NULL,
  `travel time` tinyint NOT NULL,
  `range` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `common_price` tinyint NOT NULL,
  `premium_price` tinyint NOT NULL,
  `airline_name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `flights_by_airline_in_day`
--

DROP TABLE IF EXISTS `flights_by_airline_in_day`;
/*!50001 DROP VIEW IF EXISTS `flights_by_airline_in_day`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `flights_by_airline_in_day` (
  `id` tinyint NOT NULL,
  `airline_name` tinyint NOT NULL,
  `sortie` tinyint NOT NULL,
  `sortie_count` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `landing`
--

DROP TABLE IF EXISTS `landing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `landing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flight` int(11) NOT NULL,
  `state` enum('expected','happend','canceled') NOT NULL,
  `delta_time` time DEFAULT NULL,
  `start` datetime NOT NULL,
  `reason` text,
  PRIMARY KEY (`id`),
  KEY `dfdsfdsfds` (`flight`),
  CONSTRAINT `dsfsdfdsfdsfsd` FOREIGN KEY (`flight`) REFERENCES `flight` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `landing`
--

LOCK TABLES `landing` WRITE;
/*!40000 ALTER TABLE `landing` DISABLE KEYS */;
INSERT INTO `landing` VALUES (5,12,'happend',NULL,'2015-01-17 05:00:11',NULL),(6,13,'happend',NULL,'2015-01-01 01:00:10',NULL);
/*!40000 ALTER TABLE `landing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passenger`
--

DROP TABLE IF EXISTS `passenger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `passenger` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `patronymic` varchar(50) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `additional_phone` varchar(20) DEFAULT NULL,
  `comment` text,
  `city` int(11) NOT NULL,
  `age` tinyint(4) NOT NULL,
  `passport_num` int(11) NOT NULL DEFAULT '123456',
  `internationlal_passport_num` int(11) NOT NULL DEFAULT '123456',
  PRIMARY KEY (`id`),
  KEY `dfdsadsadsa` (`city`),
  CONSTRAINT `cdcsdcsdsds` FOREIGN KEY (`city`) REFERENCES `city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passenger`
--

LOCK TABLES `passenger` WRITE;
/*!40000 ALTER TABLE `passenger` DISABLE KEYS */;
INSERT INTO `passenger` VALUES (1,'ivanov','ivan','ivanovich','+71111111111',NULL,'ttt',1,55,123456,123456);
/*!40000 ALTER TABLE `passenger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `pilots_with_med_examination`
--

DROP TABLE IF EXISTS `pilots_with_med_examination`;
/*!50001 DROP VIEW IF EXISTS `pilots_with_med_examination`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `pilots_with_med_examination` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `lastname` tinyint NOT NULL,
  `patronymic` tinyint NOT NULL,
  `phone` tinyint NOT NULL,
  `additional_phone` tinyint NOT NULL,
  `comment` tinyint NOT NULL,
  `number_of_flights` tinyint NOT NULL,
  `hours_in_flights` tinyint NOT NULL,
  `hire_date` tinyint NOT NULL,
  `date_of_dismissal` tinyint NOT NULL,
  `city_of_residence` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `last_medical_examination` tinyint NOT NULL,
  `brigade` tinyint NOT NULL,
  `airport` tinyint NOT NULL,
  `salary` tinyint NOT NULL,
  `childrencount` tinyint NOT NULL,
  `sex` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `pilots_without_med_examination`
--

DROP TABLE IF EXISTS `pilots_without_med_examination`;
/*!50001 DROP VIEW IF EXISTS `pilots_without_med_examination`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `pilots_without_med_examination` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `lastname` tinyint NOT NULL,
  `patronymic` tinyint NOT NULL,
  `phone` tinyint NOT NULL,
  `additional_phone` tinyint NOT NULL,
  `comment` tinyint NOT NULL,
  `number_of_flights` tinyint NOT NULL,
  `hours_in_flights` tinyint NOT NULL,
  `hire_date` tinyint NOT NULL,
  `date_of_dismissal` tinyint NOT NULL,
  `city_of_residence` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `last_medical_examination` tinyint NOT NULL,
  `brigade` tinyint NOT NULL,
  `airport` tinyint NOT NULL,
  `salary` tinyint NOT NULL,
  `childrencount` tinyint NOT NULL,
  `sex` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `plane`
--

DROP TABLE IF EXISTS `plane`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plane` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `airline` int(11) NOT NULL,
  `model` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dsadsdsa` (`airline`),
  KEY `fgfdgfdgfdgfdgfd` (`model`),
  CONSTRAINT `dfdsfdsfdsfds` FOREIGN KEY (`airline`) REFERENCES `airline` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dsfdsfdfdsfdsfds` FOREIGN KEY (`model`) REFERENCES `plane_model` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plane`
--

LOCK TABLES `plane` WRITE;
/*!40000 ALTER TABLE `plane` DISABLE KEYS */;
INSERT INTO `plane` VALUES (1,1,1),(2,2,1);
/*!40000 ALTER TABLE `plane` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `plane_info`
--

DROP TABLE IF EXISTS `plane_info`;
/*!50001 DROP VIEW IF EXISTS `plane_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `plane_info` (
  `id` tinyint NOT NULL,
  `airline` tinyint NOT NULL,
  `passenger_capacity` tinyint NOT NULL,
  `model` tinyint NOT NULL,
  `last_repair` tinyint NOT NULL,
  `last_repair_conclusion` tinyint NOT NULL,
  `last_inspection` tinyint NOT NULL,
  `last_inspections_conclusion` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `plane_inspections`
--

DROP TABLE IF EXISTS `plane_inspections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plane_inspections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scheduled_date` datetime NOT NULL,
  `responsible` int(11) NOT NULL,
  `comment` text,
  `plane` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dfdfdfdsf` (`responsible`),
  KEY `cxvfdsfds` (`plane`),
  CONSTRAINT `fgdfgfdgfdgfd` FOREIGN KEY (`responsible`) REFERENCES `employee` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `gfdgfdgfgdfgfdgdf` FOREIGN KEY (`plane`) REFERENCES `plane` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plane_inspections`
--

LOCK TABLES `plane_inspections` WRITE;
/*!40000 ALTER TABLE `plane_inspections` DISABLE KEYS */;
/*!40000 ALTER TABLE `plane_inspections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plane_inspections_ended`
--

DROP TABLE IF EXISTS `plane_inspections_ended`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plane_inspections_ended` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inspection` int(11) NOT NULL,
  `end_date` datetime NOT NULL,
  `conclusion` enum('good','bad') NOT NULL,
  `comment` text,
  PRIMARY KEY (`id`),
  KEY `dsfdsfdsfdsfds` (`inspection`),
  CONSTRAINT `dfgfdgfdgfdgf` FOREIGN KEY (`inspection`) REFERENCES `plane_inspections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plane_inspections_ended`
--

LOCK TABLES `plane_inspections_ended` WRITE;
/*!40000 ALTER TABLE `plane_inspections_ended` DISABLE KEYS */;
/*!40000 ALTER TABLE `plane_inspections_ended` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plane_model`
--

DROP TABLE IF EXISTS `plane_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plane_model` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `passenger_capacity` smallint(6) NOT NULL,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plane_model`
--

LOCK TABLES `plane_model` WRITE;
/*!40000 ALTER TABLE `plane_model` DISABLE KEYS */;
INSERT INTO `plane_model` VALUES (1,1000,'super-plane');
/*!40000 ALTER TABLE `plane_model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plane_repairs`
--

DROP TABLE IF EXISTS `plane_repairs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plane_repairs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plane` int(11) NOT NULL,
  `scheduled_date` datetime NOT NULL,
  `responsible` int(11) NOT NULL,
  `comment` text,
  PRIMARY KEY (`id`),
  KEY `rgdgfgf` (`plane`),
  KEY `fdfdfds` (`responsible`),
  CONSTRAINT `dfdfdfdfsdfdsfds` FOREIGN KEY (`responsible`) REFERENCES `employee` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dfdsfsdfdsfdsd` FOREIGN KEY (`plane`) REFERENCES `plane` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plane_repairs`
--

LOCK TABLES `plane_repairs` WRITE;
/*!40000 ALTER TABLE `plane_repairs` DISABLE KEYS */;
/*!40000 ALTER TABLE `plane_repairs` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `delete_flights_before_repair` BEFORE INSERT ON `plane_repairs` FOR EACH ROW delete flight from flight join flight_class where flight_class.plane=NEW.plane */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `plane_repairs_ended`
--

DROP TABLE IF EXISTS `plane_repairs_ended`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plane_repairs_ended` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `end_date` datetime NOT NULL,
  `conclusion` enum('repared','cannot repared') NOT NULL,
  `comment` text,
  `repair` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dfdsfdsfds` (`repair`),
  CONSTRAINT `dfdfdsfdfds` FOREIGN KEY (`repair`) REFERENCES `plane_repairs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plane_repairs_ended`
--

LOCK TABLES `plane_repairs_ended` WRITE;
/*!40000 ALTER TABLE `plane_repairs_ended` DISABLE KEYS */;
/*!40000 ALTER TABLE `plane_repairs_ended` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `planes`
--

DROP TABLE IF EXISTS `planes`;
/*!50001 DROP VIEW IF EXISTS `planes`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `planes` (
  `id` tinyint NOT NULL,
  `airline` tinyint NOT NULL,
  `passenger_capacity` tinyint NOT NULL,
  `model` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `registration`
--

DROP TABLE IF EXISTS `registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xcxcxzcxzcxz` (`ticket`),
  CONSTRAINT `bvcbvcbvcbvc` FOREIGN KEY (`ticket`) REFERENCES `ticket` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration`
--

LOCK TABLES `registration` WRITE;
/*!40000 ALTER TABLE `registration` DISABLE KEYS */;
/*!40000 ALTER TABLE `registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sortie`
--

DROP TABLE IF EXISTS `sortie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sortie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flight` int(11) NOT NULL,
  `state` enum('expected','happend','canceled') NOT NULL,
  `delta_time` time DEFAULT NULL,
  `start` datetime NOT NULL,
  `reason` text,
  PRIMARY KEY (`id`),
  KEY `ddfdsfdsfds` (`flight`),
  CONSTRAINT `ddfdfdsfdsfdsfds` FOREIGN KEY (`flight`) REFERENCES `flight` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sortie`
--

LOCK TABLES `sortie` WRITE;
/*!40000 ALTER TABLE `sortie` DISABLE KEYS */;
INSERT INTO `sortie` VALUES (6,12,'happend',NULL,'2015-01-17 00:00:10',NULL),(7,13,'happend',NULL,'2015-01-01 00:00:10',NULL);
/*!40000 ALTER TABLE `sortie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `sorties_in_month`
--

DROP TABLE IF EXISTS `sorties_in_month`;
/*!50001 DROP VIEW IF EXISTS `sorties_in_month`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `sorties_in_month` (
  `id` tinyint NOT NULL,
  `plane_id` tinyint NOT NULL,
  `plane_model_name` tinyint NOT NULL,
  `team` tinyint NOT NULL,
  `passenger_capacity` tinyint NOT NULL,
  `bought` tinyint NOT NULL,
  `free` tinyint NOT NULL,
  `sortie_start` tinyint NOT NULL,
  `sortie_delta_time` tinyint NOT NULL,
  `landing_start` tinyint NOT NULL,
  `landing_delta_time` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `sorties_with_passengers`
--

DROP TABLE IF EXISTS `sorties_with_passengers`;
/*!50001 DROP VIEW IF EXISTS `sorties_with_passengers`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `sorties_with_passengers` (
  `start` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `lastname` tinyint NOT NULL,
  `place` tinyint NOT NULL,
  `baggages count` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flight` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `place` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dfgfdgfdgfd` (`flight`),
  KEY `fdvcvcxvcxvcx` (`owner`),
  CONSTRAINT `dsadsadsadsa` FOREIGN KEY (`flight`) REFERENCES `sortie` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `gfdgfdgfdgfdgfd` FOREIGN KEY (`owner`) REFERENCES `passenger` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ticket_buying_check` BEFORE INSERT ON `ticket` FOR EACH ROW begin 
	declare `vmax` int;
    declare `vcount` int;
    
	select
    `plane_model`.`passenger_capacity`
    into `vmax`
    from `flight`
    inner join `plane` on `flight`.`plane`=`plane`.`id`
    inner join `plane_model` on `plane`.`model`=`plane_model`.`id`
    where `flight`.`id`=NEW.`flight`;
    
    select
    count(*)
    into `vcount`
    from `ticket`
    where `ticket`.`place`=NEW.`place`;
    
    if NEW.`place` > `vmax` or `vcount` > 0 then
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Сant buy this ticket (is this place is occupied?)';
	end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'airport'
--

--
-- Dumping routines for database 'airport'
--
/*!50003 DROP PROCEDURE IF EXISTS `flight_add` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `flight_add`(
	IN `team_id` INT,
    in `flight_class_id` int,
    in `plane_id` int,
    in `sortie_time` datetime,
    in `landing_time` datetime)
    NO SQL
begin
	START TRANSACTION;
	
    INSERT INTO `flight`
	(`team`,
	`flight_class`,
	`plane`)
	VALUES
	(`team_id`,
	`flight_class_id`,
	`plane_id`);
    
    set @flight_id = LAST_INSERT_ID();
    
    INSERT INTO `sortie`
	(`flight`,
	`state`,
	`delta_time`,
	`start`,
	`reason`)
	VALUES
	( @flight_id,
	'expected',
	NULL,
	`sortie_time`,
	NULL);
    
    INSERT INTO `landing`
	(`flight`,
	`state`,
	`delta_time`,
	`start`,
	`reason`)
	VALUES
	( @flight_id,
	'expected',
	NULL,
	`landing_time`,
	NULL);

    Commit;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `flight_change_plane` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `flight_change_plane`(
	IN `flight_id` INT,
    in `plane_id` int)
    NO SQL
begin
	START TRANSACTION;
    
	UPDATE `flight`
	SET
	`flight`.`plane` = `plane_id`
	WHERE `flight` = `flight_id`;

	Commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `flight_change_team` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `flight_change_team`(
	IN `flight_id` INT,
    in `team_id` int)
    NO SQL
begin
	START TRANSACTION;
    
	UPDATE `flight`
	SET
	`flight`.`team` = `team_id`
	WHERE `flight` = `flight_id`;

	Commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `flight_generate_next` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `flight_generate_next`(
    in `flight_class_id` int,
    in `starting_date` date,
    IN `team_id` INT,
    in `plane_id` int)
    NO SQL
begin
    START TRANSACTION;
    
    CALL `get_next_flight_date`(`flight_class_id`, `starting_date`, @sortie, @landing);
    
    CALL `flight_add`(`team_id`, `flight_class_id`, `plane_id`, @sortie, @landing);

    Commit;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `flight_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `flight_info`(IN `flight_id` INT, OUT `registered` INT, OUT `capacity` INT)
    NO SQL
Begin
select count(registration.id) 
from registration 
join ticket
where ticket.flight = flight_id
into registered;
select plane_model.passenger_capacity
from flight
join flight_class
join plane
join plane_model
where flight.id = flight_id
into capacity;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `flight_landing_do` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `flight_landing_do`(
	IN `flight_id` INT)
    NO SQL
begin
	START TRANSACTION;
    
	UPDATE `sortie`
	SET
	`state` = 'happend'
	WHERE `flight` = `flight_id`;

	UPDATE `landing`
	SET
	`state` = 'happend'
	WHERE `flight` = `flight_id`;
    
    select 
    @teamid:=`team`,
    @flighttime:=`travel time`
    from `flight`
    left join `flight_class` on `flight_class`.`id` = `flight`.`flight_class`
    WHERE `flight`.`id` = `flight_id`;
    
    UPDATE `employee`
	SET
	`number_of_flights` = `number_of_flights`+1,
	`hours_in_flights` = `hours_in_flights`+HOUR(@flighttime)
	WHERE `brigade` = @teamid and `type`=1;


	Commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `flight_landing_move` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `flight_landing_move`(
	IN `flight_id` INT,
    in `delta` time,
    in `reasont` text)
    NO SQL
begin
	START TRANSACTION;
    
	UPDATE `landing`
	SET
	`state` = 'expected',
    `delta_time` = `delta`,
    `reason` = `reasont`
	WHERE `flight` = `flight_id`;

	Commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `flight_sortie_cancele` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `flight_sortie_cancele`(
	IN `flight_id` INT,
    in `reasont` text)
    NO SQL
begin
	START TRANSACTION;
    
	UPDATE `sortie`
	SET
	`state` = 'canceled',
    `reason` = `reasont`
	WHERE `flight` = `flight_id`;

	UPDATE `landing`
	SET
	`state` = 'canceled',
    `reason` = `reasont`
	WHERE `flight` = `flight_id`;

	Commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `flight_sortie_do` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `flight_sortie_do`(
	IN `flight_id` INT)
    NO SQL
begin
	START TRANSACTION;
    
	UPDATE `sortie`
	SET
	`state` = 'happend'
	WHERE `flight` = `flight_id`;

	UPDATE `landing`
	SET
	`state` = 'expected'
	WHERE `flight` = `flight_id`;

	Commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `flight_sortie_move` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `flight_sortie_move`(
	IN `flight_id` INT,
    in `delta` time,
    in `reasont` text)
    NO SQL
begin
	START TRANSACTION;
    
	UPDATE `sortie`
	SET
	`state` = 'expected',
    `delta_time` = `delta`,
    `reason` = `reasont`
	WHERE `flight` = `flight_id`;

	UPDATE `landing`
	SET
	`state` = 'expected'
	WHERE `flight` = `flight_id`;

	Commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_next_flight_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_next_flight_date`(
    in `flight_class_id` int,
    in `starting_date` date,
    out `next_flight_date` datetime,
    out `next_flight_landing` datetime)
    NO SQL
begin
    START TRANSACTION;
    
    set @curdaynum:=DAYOFWEEK(`starting_date`);
    
    select 
		@ptype:=`periodicity_type`, 
        @sortietime:=`time of departure`, 
        @traveltime:=`travel time` 
	from `flight_class` 
    where `id`=`flight_class_id`;
    
    case @ptype
		when 'once' then set @nextdaynum:=@curdaynum;
        when 'on odd days' then set @nextdaynum:=if(@curdaynum%2=0, @curdaynum+2, @curdaynum+1);
        when 'on the even days' then set @nextdaynum:=if(@curdaynum%2=0, @curdaynum+1, @curdaynum+2);
        when 'on weekends' then set @nextdaynum:=if(@curdaynum<>7, 7, 1);
		when 'Every N Sundy' then set @nextdaynum:=1;
		when 'Every N Monday' then set @nextdaynum:=2;
		when 'Every N Tuesday' then set @nextdaynum:=3;
		when 'Every N Wendesday' then set @nextdaynum:=4;
		when 'Every N Thursday' then set @nextdaynum:=5;
		when 'Every N Friday' then set @nextdaynum:=6;
		when 'Every N Saturday' then set @nextdaynum:=7;
   end case;
    
    set `next_flight_date`:=(CURDATE() - INTERVAL DAYOFWEEK(CURDATE()) DAY + INTERVAL (DAYOFWEEK(CURDATE())<=@nextdaynum)*-7 + @nextdaynum + 7 DAY);
	set `next_flight_date`:=ADDTIME(`next_flight_date`, @sortietime);
    set `next_flight_landing`:=ADDTIME(`next_flight_date`, @traveltime);
    Commit;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `plane_inspection_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `plane_inspection_report`(IN `inspection_id` INT, IN `conclusion_val` ENUM('good', 'bad'), IN `comment_val` TEXT)
    NO SQL
begin
	INSERT INTO `plane_inspections_ended`(`end_date`, `conclusion`, `comment`) VALUES (inspection_id,NOW(),conclusion_val,comment_val);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `airline_statistics`
--

/*!50001 DROP TABLE IF EXISTS `airline_statistics`*/;
/*!50001 DROP VIEW IF EXISTS `airline_statistics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `airline_statistics` AS select `flights_by_airline_in_day`.`id` AS `id`,`flights_by_airline_in_day`.`airline_name` AS `airline_name`,avg(`flights_by_airline_in_day`.`sortie_count`) AS `avg_day_sortie_count` from `flights_by_airline_in_day` group by `flights_by_airline_in_day`.`airline_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `brigade_list`
--

/*!50001 DROP TABLE IF EXISTS `brigade_list`*/;
/*!50001 DROP VIEW IF EXISTS `brigade_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `brigade_list` AS select `employee`.`brigade` AS `brigade`,group_concat(concat(`employee`.`name`,' ',`employee`.`lastname`,' (',`employee_type`.`name`,')') separator ';
') AS `brigades` from (`employee` join `employee_type` on((`employee`.`type` = `employee_type`.`id`))) group by `employee`.`brigade` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `delayed_landings`
--

/*!50001 DROP TABLE IF EXISTS `delayed_landings`*/;
/*!50001 DROP VIEW IF EXISTS `delayed_landings`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `delayed_landings` AS select `landing`.`id` AS `id`,`landing`.`flight` AS `flight`,`landing`.`state` AS `state`,`landing`.`delta_time` AS `delta_time`,`landing`.`start` AS `start`,`landing`.`reason` AS `reason` from `landing` where ((`landing`.`delta_time` is not null) and (now() < `landing`.`start`) and ((now() + interval 1 day) > `landing`.`start`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `department_view`
--

/*!50001 DROP TABLE IF EXISTS `department_view`*/;
/*!50001 DROP VIEW IF EXISTS `department_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `department_view` AS select `department`.`id` AS `id`,`department`.`name` AS `departnent_name`,`employee`.`name` AS `head_name`,`employee`.`lastname` AS `head_lastname`,group_concat(distinct `brigade`.`comment` separator ',') AS `brigades` from (((`department` join `employee` on((`department`.`head` = `employee`.`id`))) left join `employee` `ee2` on((`ee2`.`type` = `department`.`type`))) left join `brigade` on((`ee2`.`brigade` = `brigade`.`id`))) group by `department`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `employee_list`
--

/*!50001 DROP TABLE IF EXISTS `employee_list`*/;
/*!50001 DROP VIEW IF EXISTS `employee_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `employee_list` AS select `employee`.`id` AS `id`,`employee`.`name` AS `name`,`employee`.`lastname` AS `lastname`,`employee`.`patronymic` AS `patronymic`,`employee`.`phone` AS `phone`,`employee`.`additional_phone` AS `additional_phone`,`employee`.`comment` AS `comment`,`employee`.`type` AS `type`,`employee`.`brigade` AS `brigade`,`employee`.`airport` AS `airport`,`employee`.`salary` AS `salary`,`employee`.`childrencount` AS `childrencount`,`employee`.`sex` AS `sex` from `employee` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `flight_class_stat`
--

/*!50001 DROP TABLE IF EXISTS `flight_class_stat`*/;
/*!50001 DROP VIEW IF EXISTS `flight_class_stat`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `flight_class_stat` AS select `flight_info`.`flight_class` AS `id`,1 AS `plane_id`,'' AS `plane_model_name`,1 AS `team`,avg(`flight_info`.`passenger_capacity`) AS `avg_passenger_capacity`,avg(`flight_info`.`bought`) AS `avg_bought`,avg(`flight_info`.`free`) AS `avg_free`,avg(if(isnull(`flight_info`.`sortie_delta_time`),0,`flight_info`.`sortie_delta_time`)) AS `avg_sortie_delta_time`,avg(if(isnull(`flight_info`.`landing_delta_time`),0,`flight_info`.`landing_delta_time`)) AS `avg_delta_time` from `flight_info` group by `flight_info`.`flight_class` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `flight_info`
--

/*!50001 DROP TABLE IF EXISTS `flight_info`*/;
/*!50001 DROP VIEW IF EXISTS `flight_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `flight_info` AS select `flight`.`id` AS `id`,`plane`.`id` AS `plane_id`,`plane_model`.`name` AS `plane_model_name`,`flight`.`team` AS `team`,`plane_model`.`passenger_capacity` AS `passenger_capacity`,count(`ticket`.`id`) AS `bought`,(`plane_model`.`passenger_capacity` - count(`ticket`.`id`)) AS `free`,`sortie`.`start` AS `sortie_start`,`sortie`.`delta_time` AS `sortie_delta_time`,`landing`.`start` AS `landing_start`,`landing`.`delta_time` AS `landing_delta_time`,`flight_class`.`id` AS `flight_class`,`city_from`.`name` AS `from`,`city_to`.`name` AS `to`,`flight_class`.`periodicity_type` AS `periodicity_type`,`flight_class`.`time of departure` AS `time of departure`,`flight_class`.`travel time` AS `travel time`,`flight_class`.`range` AS `range`,`flight_class`.`type` AS `type`,`flight_class`.`common_price` AS `common_price`,`flight_class`.`premium_price` AS `premium_price`,`airline`.`name` AS `airline_name` from (((((((((((`flight` left join `sortie` on((`sortie`.`flight` = `flight`.`id`))) left join `landing` on((`landing`.`flight` = `flight`.`id`))) left join `ticket` on((`ticket`.`flight` = `flight`.`id`))) left join `plane` on((`flight`.`plane` = `plane`.`id`))) left join `plane_model` on((`plane`.`model` = `plane_model`.`id`))) left join `flight_class` on((`flight`.`flight_class` = `flight_class`.`id`))) left join `airport` `airport_from` on((`flight_class`.`from` = `airport_from`.`id`))) left join `airport` `airport_to` on((`flight_class`.`to` = `airport_to`.`id`))) left join `city` `city_from` on((`airport_from`.`city` = `city_from`.`id`))) left join `city` `city_to` on((`airport_to`.`city` = `city_to`.`id`))) left join `airline` on((`plane`.`airline` = `airline`.`id`))) group by `flight`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `flights_by_airline_in_day`
--

/*!50001 DROP TABLE IF EXISTS `flights_by_airline_in_day`*/;
/*!50001 DROP VIEW IF EXISTS `flights_by_airline_in_day`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `flights_by_airline_in_day` AS select `flight_info`.`id` AS `id`,`flight_info`.`airline_name` AS `airline_name`,`flight_info`.`sortie_start` AS `sortie`,count(0) AS `sortie_count` from `flight_info` group by `flight_info`.`airline_name`,cast(`flight_info`.`sortie_start` as date) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `pilots_with_med_examination`
--

/*!50001 DROP TABLE IF EXISTS `pilots_with_med_examination`*/;
/*!50001 DROP VIEW IF EXISTS `pilots_with_med_examination`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `pilots_with_med_examination` AS select `employee`.`id` AS `id`,`employee`.`name` AS `name`,`employee`.`lastname` AS `lastname`,`employee`.`patronymic` AS `patronymic`,`employee`.`phone` AS `phone`,`employee`.`additional_phone` AS `additional_phone`,`employee`.`comment` AS `comment`,`employee`.`number_of_flights` AS `number_of_flights`,`employee`.`hours_in_flights` AS `hours_in_flights`,`employee`.`hire_date` AS `hire_date`,`employee`.`date_of_dismissal` AS `date_of_dismissal`,`employee`.`city_of_residence` AS `city_of_residence`,`employee`.`type` AS `type`,`employee`.`last_medical_examination` AS `last_medical_examination`,`employee`.`brigade` AS `brigade`,`employee`.`airport` AS `airport`,`employee`.`salary` AS `salary`,`employee`.`childrencount` AS `childrencount`,`employee`.`sex` AS `sex` from `employee` where ((`employee`.`type` = 1) and (curdate() < (`employee`.`last_medical_examination` + interval 1 year))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `pilots_without_med_examination`
--

/*!50001 DROP TABLE IF EXISTS `pilots_without_med_examination`*/;
/*!50001 DROP VIEW IF EXISTS `pilots_without_med_examination`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `pilots_without_med_examination` AS select `employee`.`id` AS `id`,`employee`.`name` AS `name`,`employee`.`lastname` AS `lastname`,`employee`.`patronymic` AS `patronymic`,`employee`.`phone` AS `phone`,`employee`.`additional_phone` AS `additional_phone`,`employee`.`comment` AS `comment`,`employee`.`number_of_flights` AS `number_of_flights`,`employee`.`hours_in_flights` AS `hours_in_flights`,`employee`.`hire_date` AS `hire_date`,`employee`.`date_of_dismissal` AS `date_of_dismissal`,`employee`.`city_of_residence` AS `city_of_residence`,`employee`.`type` AS `type`,`employee`.`last_medical_examination` AS `last_medical_examination`,`employee`.`brigade` AS `brigade`,`employee`.`airport` AS `airport`,`employee`.`salary` AS `salary`,`employee`.`childrencount` AS `childrencount`,`employee`.`sex` AS `sex` from `employee` where ((`employee`.`type` = 1) and (curdate() > (`employee`.`last_medical_examination` + interval 1 year))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `plane_info`
--

/*!50001 DROP TABLE IF EXISTS `plane_info`*/;
/*!50001 DROP VIEW IF EXISTS `plane_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `plane_info` AS select `plane`.`id` AS `id`,`airline`.`name` AS `airline`,`plane_model`.`passenger_capacity` AS `passenger_capacity`,`plane_model`.`name` AS `model`,`plane_repairs_ended`.`end_date` AS `last_repair`,`plane_repairs_ended`.`conclusion` AS `last_repair_conclusion`,`plane_inspections_ended`.`end_date` AS `last_inspection`,`plane_inspections_ended`.`conclusion` AS `last_inspections_conclusion` from ((((((`plane` join `plane_model`) join `airline`) left join `plane_repairs` on(((`plane_repairs`.`plane` = `plane`.`id`) and `plane_repairs`.`scheduled_date` in (select max(`plane_repairs`.`scheduled_date`) from `plane_repairs` where (`plane_repairs`.`plane` = `plane`.`id`))))) left join `plane_repairs_ended` on((`plane_repairs_ended`.`repair` = `plane_repairs`.`id`))) left join `plane_inspections` on(((`plane_inspections`.`plane` = `plane`.`id`) and `plane_inspections`.`scheduled_date` in (select max(`plane_inspections`.`scheduled_date`) from `plane_inspections` where (`plane_inspections`.`plane` = `plane`.`id`))))) left join `plane_inspections_ended` on((`plane_inspections_ended`.`inspection` = `plane_inspections`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `planes`
--

/*!50001 DROP TABLE IF EXISTS `planes`*/;
/*!50001 DROP VIEW IF EXISTS `planes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `planes` AS select `plane`.`id` AS `id`,`airline`.`name` AS `airline`,`plane_model`.`passenger_capacity` AS `passenger_capacity`,`plane_model`.`name` AS `model` from ((`plane` join `plane_model` on((`plane`.`model` = `plane_model`.`id`))) join `airline` on((`plane`.`airline` = `airline`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sorties_in_month`
--

/*!50001 DROP TABLE IF EXISTS `sorties_in_month`*/;
/*!50001 DROP VIEW IF EXISTS `sorties_in_month`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sorties_in_month` AS select `flight_info`.`id` AS `id`,`flight_info`.`plane_id` AS `plane_id`,`flight_info`.`plane_model_name` AS `plane_model_name`,`flight_info`.`team` AS `team`,`flight_info`.`passenger_capacity` AS `passenger_capacity`,`flight_info`.`bought` AS `bought`,`flight_info`.`free` AS `free`,`flight_info`.`sortie_start` AS `sortie_start`,`flight_info`.`sortie_delta_time` AS `sortie_delta_time`,`flight_info`.`landing_start` AS `landing_start`,`flight_info`.`landing_delta_time` AS `landing_delta_time` from `flight_info` where (if((`flight_info`.`sortie_delta_time` is not null),(`flight_info`.`sortie_start` + `flight_info`.`sortie_delta_time`),`flight_info`.`sortie_start`) < (now() + interval 30 day)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sorties_with_passengers`
--

/*!50001 DROP TABLE IF EXISTS `sorties_with_passengers`*/;
/*!50001 DROP VIEW IF EXISTS `sorties_with_passengers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sorties_with_passengers` AS select `sortie`.`start` AS `start`,`passenger`.`name` AS `name`,`passenger`.`lastname` AS `lastname`,`ticket`.`place` AS `place`,count(`baggage`.`id`) AS `baggages count` from ((((`registration` join `ticket`) join `sortie`) join `passenger`) join `baggage` on((`baggage`.`owned_by` = `passenger`.`id`))) group by `passenger`.`id` order by `sortie`.`start` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-01-15 17:01:32
