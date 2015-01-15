SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

CREATE DATABASE IF NOT EXISTS `airport` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `airport`;

DELIMITER $$
DROP PROCEDURE IF EXISTS `flight_add`$$
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

end$$

DROP PROCEDURE IF EXISTS `flight_change_plane`$$
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
end$$

DROP PROCEDURE IF EXISTS `flight_change_team`$$
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
end$$

DROP PROCEDURE IF EXISTS `flight_generate_next`$$
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

end$$

DROP PROCEDURE IF EXISTS `flight_info`$$
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
end$$

DROP PROCEDURE IF EXISTS `flight_landing_do`$$
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
end$$

DROP PROCEDURE IF EXISTS `flight_landing_move`$$
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
end$$

DROP PROCEDURE IF EXISTS `flight_sortie_cancele`$$
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
end$$

DROP PROCEDURE IF EXISTS `flight_sortie_do`$$
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
end$$

DROP PROCEDURE IF EXISTS `flight_sortie_move`$$
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
end$$

DROP PROCEDURE IF EXISTS `get_next_flight_date`$$
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

end$$

DROP PROCEDURE IF EXISTS `plane_inspection_report`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `plane_inspection_report`(IN `inspection_id` INT, IN `conclusion_val` ENUM('good', 'bad'), IN `comment_val` TEXT)
    NO SQL
begin
	INSERT INTO `plane_inspections_ended`(`end_date`, `conclusion`, `comment`) VALUES (inspection_id,NOW(),conclusion_val,comment_val);
end$$

DELIMITER ;

DROP TABLE IF EXISTS `airline`;
CREATE TABLE IF NOT EXISTS `airline` (
`id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `airline` (`id`, `name`) VALUES
(1, 'Volgograd-test-airlines'),
(2, 'Moskow-test-airlines');
DROP VIEW IF EXISTS `airline_statistics`;
CREATE TABLE IF NOT EXISTS `airline_statistics` (
`id` int(11)
,`airline_name` varchar(100)
,`avg_day_sortie_count` decimal(24,4)
);
DROP TABLE IF EXISTS `airport`;
CREATE TABLE IF NOT EXISTS `airport` (
`id` int(11) NOT NULL,
  `city` int(11) NOT NULL,
  `airline` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `airport` (`id`, `city`, `airline`) VALUES
(1, 1, 1),
(2, 2, 2);

DROP TABLE IF EXISTS `baggage`;
CREATE TABLE IF NOT EXISTS `baggage` (
`id` int(11) NOT NULL,
  `comment` text,
  `owned_by` int(11) NOT NULL,
  `receipt_date` datetime NOT NULL,
  `return_date` datetime DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `baggage` (`id`, `comment`, `owned_by`, `receipt_date`, `return_date`) VALUES
(1, 'bag1', 1, '2014-12-18 00:00:00', NULL),
(2, 'bag2', 1, '2014-12-18 00:00:00', NULL);

DROP TABLE IF EXISTS `brigade`;
CREATE TABLE IF NOT EXISTS `brigade` (
`id` int(11) NOT NULL,
  `comment` text
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

INSERT INTO `brigade` (`id`, `comment`) VALUES
(1, 'main pilots'),
(2, 'sellers brigade'),
(3, 'secondary pilots');
DROP VIEW IF EXISTS `brigade_list`;
CREATE TABLE IF NOT EXISTS `brigade_list` (
`brigade` int(11)
,`brigades` text
);
DROP TABLE IF EXISTS `city`;
CREATE TABLE IF NOT EXISTS `city` (
`id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `country` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `city` (`id`, `name`, `country`) VALUES
(1, 'Volgograd', 1),
(2, 'Moskow', 1);

DROP TABLE IF EXISTS `country`;
CREATE TABLE IF NOT EXISTS `country` (
`id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

INSERT INTO `country` (`id`, `name`) VALUES
(1, 'Russia');
DROP VIEW IF EXISTS `delayed_landings`;
CREATE TABLE IF NOT EXISTS `delayed_landings` (
`id` int(11)
,`flight` int(11)
,`state` enum('expected','happend','canceled')
,`delta_time` time
,`start` datetime
,`reason` text
);
DROP TABLE IF EXISTS `department`;
CREATE TABLE IF NOT EXISTS `department` (
`id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `airport` int(11) NOT NULL,
  `head` int(11) NOT NULL,
  `type` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `department` (`id`, `name`, `airport`, `head`, `type`) VALUES
(1, 'main pilot departmen', 1, 1, 1),
(2, 'main sellers', 1, 3, 4);
DROP VIEW IF EXISTS `department_view`;
CREATE TABLE IF NOT EXISTS `department_view` (
`id` int(11)
,`departnent_name` varchar(20)
,`head_name` varchar(50)
,`head_lastname` varchar(50)
,`brigades` text
);
DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
`id` int(11) NOT NULL,
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
  `sex` enum('Male','Female') NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

INSERT INTO `employee` (`id`, `name`, `lastname`, `patronymic`, `phone`, `additional_phone`, `comment`, `number_of_flights`, `hours_in_flights`, `hire_date`, `date_of_dismissal`, `city_of_residence`, `type`, `last_medical_examination`, `brigade`, `airport`, `salary`, `childrencount`, `sex`) VALUES
(1, 'ivanov', 'ivan', 'ivanovich', '+79371234576', NULL, '10', 109, 35, '2001-01-01', NULL, 1, 1, '2014-12-18', 1, 1, 0, NULL, 'Male'),
(2, 'petrov', 'petr', 'petrovich', '+79371234576', NULL, '10', 109, 35, '2001-01-01', NULL, 1, 1, '2014-12-18', 1, 1, 0, NULL, 'Male'),
(3, 'sidor', 'sidorov', 'sidorodich', '+79554443322', NULL, NULL, NULL, NULL, '2000-01-01', NULL, 1, 4, '2000-01-01', 2, 1, 15000, 0, 'Male'),
(4, 'vova', 'vovov', 'vovovich', '+79554443322', NULL, NULL, NULL, NULL, '2000-01-01', NULL, 1, 1, '2000-01-01', 3, 1, 50000, 0, 'Male');
DROP VIEW IF EXISTS `employee_list`;
CREATE TABLE IF NOT EXISTS `employee_list` (
`id` int(11)
,`name` varchar(50)
,`lastname` varchar(50)
,`patronymic` varchar(50)
,`phone` varchar(20)
,`additional_phone` varchar(20)
,`comment` text
,`type` int(11)
,`brigade` int(11)
,`airport` int(11)
,`salary` int(11)
,`childrencount` int(11)
,`sex` enum('Male','Female')
);
DROP TABLE IF EXISTS `employee_type`;
CREATE TABLE IF NOT EXISTS `employee_type` (
`id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

INSERT INTO `employee_type` (`id`, `name`) VALUES
(1, 'pilot'),
(2, 'dispatcher'),
(3, 'technician'),
(4, 'cashier'),
(5, 'security_officer'),
(6, 'reference_service'),
(7, 'others');

DROP TABLE IF EXISTS `flight`;
CREATE TABLE IF NOT EXISTS `flight` (
`id` int(11) NOT NULL,
  `team` int(11) NOT NULL,
  `flight_class` int(11) NOT NULL,
  `plane` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

INSERT INTO `flight` (`id`, `team`, `flight_class`, `plane`) VALUES
(12, 1, 1, 1),
(13, 3, 2, 2);
DROP TRIGGER IF EXISTS `flight_add_check`;
DELIMITER //
CREATE TRIGGER `flight_add_check` BEFORE INSERT ON `flight`
 FOR EACH ROW begin
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

END
//
DELIMITER ;

DROP TABLE IF EXISTS `flight_class`;
CREATE TABLE IF NOT EXISTS `flight_class` (
`id` int(11) NOT NULL,
  `from` int(11) NOT NULL,
  `to` int(11) NOT NULL,
  `periodicity_type` enum('once','on odd days','on the even days','on weekends','Every N Sundy','Every N Monday','Every N Tuesday','Every N Wendesday','Every N Thursday','Every N Friday','Every N Saturday') NOT NULL,
  `period` int(11) NOT NULL DEFAULT '1',
  `time of departure` time NOT NULL,
  `travel time` time NOT NULL,
  `range` int(11) NOT NULL,
  `type` enum('terminal','transit') NOT NULL,
  `common_price` int(11) NOT NULL,
  `premium_price` int(11) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `flight_class` (`id`, `from`, `to`, `periodicity_type`, `period`, `time of departure`, `travel time`, `range`, `type`, `common_price`, `premium_price`) VALUES
(1, 1, 2, 'on weekends', 1, '00:00:10', '05:00:01', 1000, 'terminal', 1500, 3000),
(2, 1, 2, 'on weekends', 1, '12:00:00', '03:00:00', 1000, 'terminal', 2000, 4000);
DROP VIEW IF EXISTS `flight_class_stat`;
CREATE TABLE IF NOT EXISTS `flight_class_stat` (
`id` int(11)
,`plane_id` int(1)
,`plane_model_name` char(0)
,`team` int(1)
,`avg_passenger_capacity` decimal(9,4)
,`avg_bought` decimal(24,4)
,`avg_free` decimal(25,4)
,`avg_sortie_delta_time` double
,`avg_delta_time` double
);DROP VIEW IF EXISTS `flight_info`;
CREATE TABLE IF NOT EXISTS `flight_info` (
`id` int(11)
,`plane_id` int(11)
,`plane_model_name` varchar(20)
,`team` int(11)
,`passenger_capacity` smallint(6)
,`bought` bigint(21)
,`free` bigint(22)
,`sortie_start` datetime
,`sortie_delta_time` time
,`landing_start` datetime
,`landing_delta_time` time
,`flight_class` int(11)
,`from` varchar(100)
,`to` varchar(100)
,`periodicity_type` enum('once','on odd days','on the even days','on weekends','Every N Sundy','Every N Monday','Every N Tuesday','Every N Wendesday','Every N Thursday','Every N Friday','Every N Saturday')
,`time of departure` time
,`travel time` time
,`range` int(11)
,`type` enum('terminal','transit')
,`common_price` int(11)
,`premium_price` int(11)
,`airline_name` varchar(100)
);DROP VIEW IF EXISTS `flights_by_airline_in_day`;
CREATE TABLE IF NOT EXISTS `flights_by_airline_in_day` (
`id` int(11)
,`airline_name` varchar(100)
,`sortie` datetime
,`sortie_count` bigint(21)
);
DROP TABLE IF EXISTS `landing`;
CREATE TABLE IF NOT EXISTS `landing` (
`id` int(11) NOT NULL,
  `flight` int(11) NOT NULL,
  `state` enum('expected','happend','canceled') NOT NULL,
  `delta_time` time DEFAULT NULL,
  `start` datetime NOT NULL,
  `reason` text
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

INSERT INTO `landing` (`id`, `flight`, `state`, `delta_time`, `start`, `reason`) VALUES
(5, 12, 'happend', NULL, '2015-01-17 05:00:11', NULL),
(6, 13, 'happend', NULL, '2015-01-01 01:00:10', NULL);

DROP TABLE IF EXISTS `passenger`;
CREATE TABLE IF NOT EXISTS `passenger` (
`id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `patronymic` varchar(50) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `additional_phone` varchar(20) DEFAULT NULL,
  `comment` text,
  `city` int(11) NOT NULL,
  `age` tinyint(4) NOT NULL,
  `passport_num` int(11) NOT NULL DEFAULT '123456',
  `internationlal_passport_num` int(11) NOT NULL DEFAULT '123456'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

INSERT INTO `passenger` (`id`, `name`, `lastname`, `patronymic`, `phone`, `additional_phone`, `comment`, `city`, `age`, `passport_num`, `internationlal_passport_num`) VALUES
(1, 'ivanov', 'ivan', 'ivanovich', '+71111111111', NULL, 'ttt', 1, 55, 123456, 123456);
DROP VIEW IF EXISTS `pilots_with_med_examination`;
CREATE TABLE IF NOT EXISTS `pilots_with_med_examination` (
`id` int(11)
,`name` varchar(50)
,`lastname` varchar(50)
,`patronymic` varchar(50)
,`phone` varchar(20)
,`additional_phone` varchar(20)
,`comment` text
,`number_of_flights` int(11)
,`hours_in_flights` int(11)
,`hire_date` date
,`date_of_dismissal` date
,`city_of_residence` int(11)
,`type` int(11)
,`last_medical_examination` date
,`brigade` int(11)
,`airport` int(11)
,`salary` int(11)
,`childrencount` int(11)
,`sex` enum('Male','Female')
);DROP VIEW IF EXISTS `pilots_without_med_examination`;
CREATE TABLE IF NOT EXISTS `pilots_without_med_examination` (
`id` int(11)
,`name` varchar(50)
,`lastname` varchar(50)
,`patronymic` varchar(50)
,`phone` varchar(20)
,`additional_phone` varchar(20)
,`comment` text
,`number_of_flights` int(11)
,`hours_in_flights` int(11)
,`hire_date` date
,`date_of_dismissal` date
,`city_of_residence` int(11)
,`type` int(11)
,`last_medical_examination` date
,`brigade` int(11)
,`airport` int(11)
,`salary` int(11)
,`childrencount` int(11)
,`sex` enum('Male','Female')
);
DROP TABLE IF EXISTS `plane`;
CREATE TABLE IF NOT EXISTS `plane` (
`id` int(11) NOT NULL,
  `airline` int(11) NOT NULL,
  `model` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `plane` (`id`, `airline`, `model`) VALUES
(1, 1, 1),
(2, 2, 1);
DROP VIEW IF EXISTS `plane_info`;
CREATE TABLE IF NOT EXISTS `plane_info` (
`id` int(11)
,`airline` varchar(100)
,`passenger_capacity` smallint(6)
,`model` varchar(20)
,`last_repair` datetime
,`last_repair_conclusion` enum('repared','cannot repared')
,`last_inspection` datetime
,`last_inspections_conclusion` enum('good','bad')
);
DROP TABLE IF EXISTS `plane_inspections`;
CREATE TABLE IF NOT EXISTS `plane_inspections` (
`id` int(11) NOT NULL,
  `scheduled_date` datetime NOT NULL,
  `responsible` int(11) NOT NULL,
  `comment` text,
  `plane` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `plane_inspections_ended`;
CREATE TABLE IF NOT EXISTS `plane_inspections_ended` (
`id` int(11) NOT NULL,
  `inspection` int(11) NOT NULL,
  `end_date` datetime NOT NULL,
  `conclusion` enum('good','bad') NOT NULL,
  `comment` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `plane_model`;
CREATE TABLE IF NOT EXISTS `plane_model` (
`id` int(11) NOT NULL,
  `passenger_capacity` smallint(6) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

INSERT INTO `plane_model` (`id`, `passenger_capacity`, `name`) VALUES
(1, 1000, 'super-plane');

DROP TABLE IF EXISTS `plane_repairs`;
CREATE TABLE IF NOT EXISTS `plane_repairs` (
`id` int(11) NOT NULL,
  `plane` int(11) NOT NULL,
  `scheduled_date` datetime NOT NULL,
  `responsible` int(11) NOT NULL,
  `comment` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
DROP TRIGGER IF EXISTS `delete_flights_before_repair`;
DELIMITER //
CREATE TRIGGER `delete_flights_before_repair` BEFORE INSERT ON `plane_repairs`
 FOR EACH ROW delete flight from flight join flight_class where flight_class.plane=NEW.plane
//
DELIMITER ;

DROP TABLE IF EXISTS `plane_repairs_ended`;
CREATE TABLE IF NOT EXISTS `plane_repairs_ended` (
`id` int(11) NOT NULL,
  `end_date` datetime NOT NULL,
  `conclusion` enum('repared','cannot repared') NOT NULL,
  `comment` text,
  `repair` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
DROP VIEW IF EXISTS `planes`;
CREATE TABLE IF NOT EXISTS `planes` (
`id` int(11)
,`airline` varchar(100)
,`passenger_capacity` smallint(6)
,`model` varchar(20)
);
DROP TABLE IF EXISTS `registration`;
CREATE TABLE IF NOT EXISTS `registration` (
`id` int(11) NOT NULL,
  `ticket` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `sortie`;
CREATE TABLE IF NOT EXISTS `sortie` (
`id` int(11) NOT NULL,
  `flight` int(11) NOT NULL,
  `state` enum('expected','happend','canceled') NOT NULL,
  `delta_time` time DEFAULT NULL,
  `start` datetime NOT NULL,
  `reason` text
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

INSERT INTO `sortie` (`id`, `flight`, `state`, `delta_time`, `start`, `reason`) VALUES
(6, 12, 'happend', NULL, '2015-01-17 00:00:10', NULL),
(7, 13, 'happend', NULL, '2015-01-01 00:00:10', NULL);
DROP VIEW IF EXISTS `sorties_in_month`;
CREATE TABLE IF NOT EXISTS `sorties_in_month` (
`id` int(11)
,`plane_id` int(11)
,`plane_model_name` varchar(20)
,`team` int(11)
,`passenger_capacity` smallint(6)
,`bought` bigint(21)
,`free` bigint(22)
,`sortie_start` datetime
,`sortie_delta_time` time
,`landing_start` datetime
,`landing_delta_time` time
);DROP VIEW IF EXISTS `sorties_with_passengers`;
CREATE TABLE IF NOT EXISTS `sorties_with_passengers` (
`start` datetime
,`name` varchar(50)
,`lastname` varchar(50)
,`place` int(11)
,`baggages count` bigint(21)
);
DROP TABLE IF EXISTS `ticket`;
CREATE TABLE IF NOT EXISTS `ticket` (
`id` int(11) NOT NULL,
  `flight` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `place` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
DROP TRIGGER IF EXISTS `ticket_buying_check`;
DELIMITER //
CREATE TRIGGER `ticket_buying_check` BEFORE INSERT ON `ticket`
 FOR EACH ROW begin 
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
end
//
DELIMITER ;
DROP TABLE IF EXISTS `airline_statistics`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `airline_statistics` AS select `flights_by_airline_in_day`.`id` AS `id`,`flights_by_airline_in_day`.`airline_name` AS `airline_name`,avg(`flights_by_airline_in_day`.`sortie_count`) AS `avg_day_sortie_count` from `flights_by_airline_in_day` group by `flights_by_airline_in_day`.`airline_name`;
DROP TABLE IF EXISTS `brigade_list`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `brigade_list` AS select `employee`.`brigade` AS `brigade`,group_concat(concat(`employee`.`name`,' ',`employee`.`lastname`,' (',`employee_type`.`name`,')') separator ';
') AS `brigades` from (`employee` join `employee_type` on((`employee`.`type` = `employee_type`.`id`))) group by `employee`.`brigade`;
DROP TABLE IF EXISTS `delayed_landings`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `delayed_landings` AS select `landing`.`id` AS `id`,`landing`.`flight` AS `flight`,`landing`.`state` AS `state`,`landing`.`delta_time` AS `delta_time`,`landing`.`start` AS `start`,`landing`.`reason` AS `reason` from `landing` where ((`landing`.`delta_time` is not null) and (now() < `landing`.`start`) and ((now() + interval 1 day) > `landing`.`start`));
DROP TABLE IF EXISTS `department_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `department_view` AS select `department`.`id` AS `id`,`department`.`name` AS `departnent_name`,`employee`.`name` AS `head_name`,`employee`.`lastname` AS `head_lastname`,group_concat(distinct `brigade`.`comment` separator ',') AS `brigades` from (((`department` join `employee` on((`department`.`head` = `employee`.`id`))) left join `employee` `ee2` on((`ee2`.`type` = `department`.`type`))) left join `brigade` on((`ee2`.`brigade` = `brigade`.`id`))) group by `department`.`id`;
DROP TABLE IF EXISTS `employee_list`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `employee_list` AS select `employee`.`id` AS `id`,`employee`.`name` AS `name`,`employee`.`lastname` AS `lastname`,`employee`.`patronymic` AS `patronymic`,`employee`.`phone` AS `phone`,`employee`.`additional_phone` AS `additional_phone`,`employee`.`comment` AS `comment`,`employee`.`type` AS `type`,`employee`.`brigade` AS `brigade`,`employee`.`airport` AS `airport`,`employee`.`salary` AS `salary`,`employee`.`childrencount` AS `childrencount`,`employee`.`sex` AS `sex` from `employee`;
DROP TABLE IF EXISTS `flight_class_stat`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `flight_class_stat` AS select `flight_info`.`flight_class` AS `id`,1 AS `plane_id`,'' AS `plane_model_name`,1 AS `team`,avg(`flight_info`.`passenger_capacity`) AS `avg_passenger_capacity`,avg(`flight_info`.`bought`) AS `avg_bought`,avg(`flight_info`.`free`) AS `avg_free`,avg(if(isnull(`flight_info`.`sortie_delta_time`),0,`flight_info`.`sortie_delta_time`)) AS `avg_sortie_delta_time`,avg(if(isnull(`flight_info`.`landing_delta_time`),0,`flight_info`.`landing_delta_time`)) AS `avg_delta_time` from `flight_info` group by `flight_info`.`flight_class`;
DROP TABLE IF EXISTS `flight_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `flight_info` AS select `flight`.`id` AS `id`,`plane`.`id` AS `plane_id`,`plane_model`.`name` AS `plane_model_name`,`flight`.`team` AS `team`,`plane_model`.`passenger_capacity` AS `passenger_capacity`,count(`ticket`.`id`) AS `bought`,(`plane_model`.`passenger_capacity` - count(`ticket`.`id`)) AS `free`,`sortie`.`start` AS `sortie_start`,`sortie`.`delta_time` AS `sortie_delta_time`,`landing`.`start` AS `landing_start`,`landing`.`delta_time` AS `landing_delta_time`,`flight_class`.`id` AS `flight_class`,`city_from`.`name` AS `from`,`city_to`.`name` AS `to`,`flight_class`.`periodicity_type` AS `periodicity_type`,`flight_class`.`time of departure` AS `time of departure`,`flight_class`.`travel time` AS `travel time`,`flight_class`.`range` AS `range`,`flight_class`.`type` AS `type`,`flight_class`.`common_price` AS `common_price`,`flight_class`.`premium_price` AS `premium_price`,`airline`.`name` AS `airline_name` from (((((((((((`flight` left join `sortie` on((`sortie`.`flight` = `flight`.`id`))) left join `landing` on((`landing`.`flight` = `flight`.`id`))) left join `ticket` on((`ticket`.`flight` = `flight`.`id`))) left join `plane` on((`flight`.`plane` = `plane`.`id`))) left join `plane_model` on((`plane`.`model` = `plane_model`.`id`))) left join `flight_class` on((`flight`.`flight_class` = `flight_class`.`id`))) left join `airport` `airport_from` on((`flight_class`.`from` = `airport_from`.`id`))) left join `airport` `airport_to` on((`flight_class`.`to` = `airport_to`.`id`))) left join `city` `city_from` on((`airport_from`.`city` = `city_from`.`id`))) left join `city` `city_to` on((`airport_to`.`city` = `city_to`.`id`))) left join `airline` on((`plane`.`airline` = `airline`.`id`))) group by `flight`.`id`;
DROP TABLE IF EXISTS `flights_by_airline_in_day`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `flights_by_airline_in_day` AS select `flight_info`.`id` AS `id`,`flight_info`.`airline_name` AS `airline_name`,`flight_info`.`sortie_start` AS `sortie`,count(0) AS `sortie_count` from `flight_info` group by `flight_info`.`airline_name`,cast(`flight_info`.`sortie_start` as date);
DROP TABLE IF EXISTS `pilots_with_med_examination`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pilots_with_med_examination` AS select `employee`.`id` AS `id`,`employee`.`name` AS `name`,`employee`.`lastname` AS `lastname`,`employee`.`patronymic` AS `patronymic`,`employee`.`phone` AS `phone`,`employee`.`additional_phone` AS `additional_phone`,`employee`.`comment` AS `comment`,`employee`.`number_of_flights` AS `number_of_flights`,`employee`.`hours_in_flights` AS `hours_in_flights`,`employee`.`hire_date` AS `hire_date`,`employee`.`date_of_dismissal` AS `date_of_dismissal`,`employee`.`city_of_residence` AS `city_of_residence`,`employee`.`type` AS `type`,`employee`.`last_medical_examination` AS `last_medical_examination`,`employee`.`brigade` AS `brigade`,`employee`.`airport` AS `airport`,`employee`.`salary` AS `salary`,`employee`.`childrencount` AS `childrencount`,`employee`.`sex` AS `sex` from `employee` where ((`employee`.`type` = 1) and (curdate() < (`employee`.`last_medical_examination` + interval 1 year)));
DROP TABLE IF EXISTS `pilots_without_med_examination`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pilots_without_med_examination` AS select `employee`.`id` AS `id`,`employee`.`name` AS `name`,`employee`.`lastname` AS `lastname`,`employee`.`patronymic` AS `patronymic`,`employee`.`phone` AS `phone`,`employee`.`additional_phone` AS `additional_phone`,`employee`.`comment` AS `comment`,`employee`.`number_of_flights` AS `number_of_flights`,`employee`.`hours_in_flights` AS `hours_in_flights`,`employee`.`hire_date` AS `hire_date`,`employee`.`date_of_dismissal` AS `date_of_dismissal`,`employee`.`city_of_residence` AS `city_of_residence`,`employee`.`type` AS `type`,`employee`.`last_medical_examination` AS `last_medical_examination`,`employee`.`brigade` AS `brigade`,`employee`.`airport` AS `airport`,`employee`.`salary` AS `salary`,`employee`.`childrencount` AS `childrencount`,`employee`.`sex` AS `sex` from `employee` where ((`employee`.`type` = 1) and (curdate() > (`employee`.`last_medical_examination` + interval 1 year)));
DROP TABLE IF EXISTS `plane_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `plane_info` AS select `plane`.`id` AS `id`,`airline`.`name` AS `airline`,`plane_model`.`passenger_capacity` AS `passenger_capacity`,`plane_model`.`name` AS `model`,`plane_repairs_ended`.`end_date` AS `last_repair`,`plane_repairs_ended`.`conclusion` AS `last_repair_conclusion`,`plane_inspections_ended`.`end_date` AS `last_inspection`,`plane_inspections_ended`.`conclusion` AS `last_inspections_conclusion` from ((((((`plane` join `plane_model`) join `airline`) left join `plane_repairs` on(((`plane_repairs`.`plane` = `plane`.`id`) and `plane_repairs`.`scheduled_date` in (select max(`plane_repairs`.`scheduled_date`) from `plane_repairs` where (`plane_repairs`.`plane` = `plane`.`id`))))) left join `plane_repairs_ended` on((`plane_repairs_ended`.`repair` = `plane_repairs`.`id`))) left join `plane_inspections` on(((`plane_inspections`.`plane` = `plane`.`id`) and `plane_inspections`.`scheduled_date` in (select max(`plane_inspections`.`scheduled_date`) from `plane_inspections` where (`plane_inspections`.`plane` = `plane`.`id`))))) left join `plane_inspections_ended` on((`plane_inspections_ended`.`inspection` = `plane_inspections`.`id`)));
DROP TABLE IF EXISTS `planes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `planes` AS select `plane`.`id` AS `id`,`airline`.`name` AS `airline`,`plane_model`.`passenger_capacity` AS `passenger_capacity`,`plane_model`.`name` AS `model` from ((`plane` join `plane_model` on((`plane`.`model` = `plane_model`.`id`))) join `airline` on((`plane`.`airline` = `airline`.`id`)));
DROP TABLE IF EXISTS `sorties_in_month`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sorties_in_month` AS select `flight_info`.`id` AS `id`,`flight_info`.`plane_id` AS `plane_id`,`flight_info`.`plane_model_name` AS `plane_model_name`,`flight_info`.`team` AS `team`,`flight_info`.`passenger_capacity` AS `passenger_capacity`,`flight_info`.`bought` AS `bought`,`flight_info`.`free` AS `free`,`flight_info`.`sortie_start` AS `sortie_start`,`flight_info`.`sortie_delta_time` AS `sortie_delta_time`,`flight_info`.`landing_start` AS `landing_start`,`flight_info`.`landing_delta_time` AS `landing_delta_time` from `flight_info` where (if((`flight_info`.`sortie_delta_time` is not null),(`flight_info`.`sortie_start` + `flight_info`.`sortie_delta_time`),`flight_info`.`sortie_start`) < (now() + interval 30 day));
DROP TABLE IF EXISTS `sorties_with_passengers`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sorties_with_passengers` AS select `sortie`.`start` AS `start`,`passenger`.`name` AS `name`,`passenger`.`lastname` AS `lastname`,`ticket`.`place` AS `place`,count(`baggage`.`id`) AS `baggages count` from ((((`registration` join `ticket`) join `sortie`) join `passenger`) join `baggage` on((`baggage`.`owned_by` = `passenger`.`id`))) group by `passenger`.`id` order by `sortie`.`start`;


ALTER TABLE `airline`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `airport`
 ADD PRIMARY KEY (`id`), ADD KEY `iairportairline` (`airline`), ADD KEY `iairportcity` (`city`);

ALTER TABLE `baggage`
 ADD PRIMARY KEY (`id`), ADD KEY `dsdsdsadsa` (`owned_by`);

ALTER TABLE `brigade`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `city`
 ADD PRIMARY KEY (`id`), ADD KEY `country` (`country`);

ALTER TABLE `country`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `department`
 ADD PRIMARY KEY (`id`), ADD KEY `adsadas` (`airport`), ADD KEY `asdsadsadasdas` (`head`), ADD KEY `dsfdfdsfds` (`type`);

ALTER TABLE `employee`
 ADD PRIMARY KEY (`id`), ADD KEY `dsadsdsadasdas` (`city_of_residence`), ADD KEY `gfhgfhfg` (`type`), ADD KEY `sddsdas` (`brigade`), ADD KEY `asdasdsadsadasd` (`airport`);

ALTER TABLE `employee_type`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `flight`
 ADD PRIMARY KEY (`id`), ADD KEY `fdsfdsfdsfsdf` (`team`), ADD KEY `dasdasdsadsadas` (`flight_class`), ADD KEY `dgfgfgfgdfgcvc` (`plane`);

ALTER TABLE `flight_class`
 ADD PRIMARY KEY (`id`), ADD KEY `jghhgfsdfs` (`from`), ADD KEY `dgbvbcxvc` (`to`);

ALTER TABLE `landing`
 ADD PRIMARY KEY (`id`), ADD KEY `dfdsfdsfds` (`flight`);

ALTER TABLE `passenger`
 ADD PRIMARY KEY (`id`), ADD KEY `dfdsadsadsa` (`city`);

ALTER TABLE `plane`
 ADD PRIMARY KEY (`id`), ADD KEY `dsadsdsa` (`airline`), ADD KEY `fgfdgfdgfdgfdgfd` (`model`);

ALTER TABLE `plane_inspections`
 ADD PRIMARY KEY (`id`), ADD KEY `dfdfdfdsf` (`responsible`), ADD KEY `cxvfdsfds` (`plane`);

ALTER TABLE `plane_inspections_ended`
 ADD PRIMARY KEY (`id`), ADD KEY `dsfdsfdsfdsfds` (`inspection`);

ALTER TABLE `plane_model`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `plane_repairs`
 ADD PRIMARY KEY (`id`), ADD KEY `rgdgfgf` (`plane`), ADD KEY `fdfdfds` (`responsible`);

ALTER TABLE `plane_repairs_ended`
 ADD PRIMARY KEY (`id`), ADD KEY `dfdsfdsfds` (`repair`);

ALTER TABLE `registration`
 ADD PRIMARY KEY (`id`), ADD KEY `xcxcxzcxzcxz` (`ticket`);

ALTER TABLE `sortie`
 ADD PRIMARY KEY (`id`), ADD KEY `ddfdsfdsfds` (`flight`);

ALTER TABLE `ticket`
 ADD PRIMARY KEY (`id`), ADD KEY `dfgfdgfdgfd` (`flight`), ADD KEY `fdvcvcxvcxvcx` (`owner`);


ALTER TABLE `airline`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
ALTER TABLE `airport`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
ALTER TABLE `baggage`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
ALTER TABLE `brigade`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
ALTER TABLE `city`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
ALTER TABLE `country`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
ALTER TABLE `department`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
ALTER TABLE `employee`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
ALTER TABLE `employee_type`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
ALTER TABLE `flight`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
ALTER TABLE `flight_class`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
ALTER TABLE `landing`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
ALTER TABLE `passenger`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
ALTER TABLE `plane`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
ALTER TABLE `plane_inspections`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `plane_inspections_ended`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `plane_model`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
ALTER TABLE `plane_repairs`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `plane_repairs_ended`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `registration`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `sortie`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
ALTER TABLE `ticket`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `airport`
ADD CONSTRAINT `fkaiportairline` FOREIGN KEY (`airline`) REFERENCES `airline` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fkaiportcity` FOREIGN KEY (`city`) REFERENCES `city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `baggage`
ADD CONSTRAINT `sadsadsdsadsadas` FOREIGN KEY (`owned_by`) REFERENCES `passenger` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `city`
ADD CONSTRAINT `asdgfbvbvcbc` FOREIGN KEY (`country`) REFERENCES `country` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `department`
ADD CONSTRAINT `department_ibfk_1` FOREIGN KEY (`type`) REFERENCES `employee_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `dfsdsdsadsadas` FOREIGN KEY (`head`) REFERENCES `employee` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `gfdgdfgdf` FOREIGN KEY (`airport`) REFERENCES `airport` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `employee`
ADD CONSTRAINT `bvcbvcbvcbvcbvcbvcb` FOREIGN KEY (`type`) REFERENCES `employee_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `dfdfsdfdsfdsfds` FOREIGN KEY (`brigade`) REFERENCES `brigade` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `sdsdsfdfdsfdfdsfdsfds` FOREIGN KEY (`airport`) REFERENCES `airport` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `sfdfsdfsdfdsfsd` FOREIGN KEY (`city_of_residence`) REFERENCES `city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `flight`
ADD CONSTRAINT `asdfgdgfgfghf` FOREIGN KEY (`flight_class`) REFERENCES `flight_class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `hjhjhjgddasdasdas` FOREIGN KEY (`team`) REFERENCES `brigade` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `jhgjhggfhfd` FOREIGN KEY (`plane`) REFERENCES `plane` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `flight_class`
ADD CONSTRAINT `dfdfasdsadsadsadsa` FOREIGN KEY (`to`) REFERENCES `airport` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `dvsdasdasdsadsa` FOREIGN KEY (`from`) REFERENCES `airport` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `landing`
ADD CONSTRAINT `dsfsdfdsfdsfsd` FOREIGN KEY (`flight`) REFERENCES `flight` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `passenger`
ADD CONSTRAINT `cdcsdcsdsds` FOREIGN KEY (`city`) REFERENCES `city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `plane`
ADD CONSTRAINT `dfdsfdsfdsfds` FOREIGN KEY (`airline`) REFERENCES `airline` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `dsfdsfdfdsfdsfds` FOREIGN KEY (`model`) REFERENCES `plane_model` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `plane_inspections`
ADD CONSTRAINT `fgdfgfdgfdgfd` FOREIGN KEY (`responsible`) REFERENCES `employee` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `gfdgfdgfgdfgfdgdf` FOREIGN KEY (`plane`) REFERENCES `plane` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `plane_inspections_ended`
ADD CONSTRAINT `dfgfdgfdgfdgf` FOREIGN KEY (`inspection`) REFERENCES `plane_inspections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `plane_repairs`
ADD CONSTRAINT `dfdfdfdfsdfdsfds` FOREIGN KEY (`responsible`) REFERENCES `employee` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `dfdsfsdfdsfdsd` FOREIGN KEY (`plane`) REFERENCES `plane` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `plane_repairs_ended`
ADD CONSTRAINT `dfdfdsfdfds` FOREIGN KEY (`repair`) REFERENCES `plane_repairs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `registration`
ADD CONSTRAINT `bvcbvcbvcbvc` FOREIGN KEY (`ticket`) REFERENCES `ticket` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `sortie`
ADD CONSTRAINT `ddfdfdsfdsfdsfds` FOREIGN KEY (`flight`) REFERENCES `flight` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `ticket`
ADD CONSTRAINT `dsadsadsadsa` FOREIGN KEY (`flight`) REFERENCES `sortie` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `gfdgfdgfdgfdgfd` FOREIGN KEY (`owner`) REFERENCES `passenger` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
