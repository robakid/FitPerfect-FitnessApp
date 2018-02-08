-- phpMyAdmin SQL Dump
-- version 4.0.10.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 21, 2015 at 10:42 PM
-- Server version: 5.5.45-cll-lve
-- PHP Version: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `FitPerfectMain`
--

-- --------------------------------------------------------

--
-- Table structure for table `CHALLENGES`
--

CREATE TABLE IF NOT EXISTS `CHALLENGES` (
  `ChallengeID` int(11) NOT NULL AUTO_INCREMENT,
  `Challenge_NAME` varchar(50) NOT NULL,
  `Challenge_Activity_Type` varchar(200) NOT NULL,
  `Challenge_Custom` tinyint(1) DEFAULT NULL,
  `Challenge_Participant_Email_1` varchar(50) DEFAULT NULL,
  `Challenge_Participant_Email_2` varchar(50) DEFAULT NULL,
  `Challenge_Participant_Email_3` varchar(50) DEFAULT NULL,
  `Challenge_Participant_Email_4` varchar(50) DEFAULT NULL,
  `Challenge_Participant_Email_5` varchar(50) DEFAULT NULL,
  `Challenge_WINNER_Email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ChallengeID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=54 ;

--
-- Dumping data for table `CHALLENGES`
--

INSERT INTO `CHALLENGES` (`ChallengeID`, `Challenge_NAME`, `Challenge_Activity_Type`, `Challenge_Custom`, `Challenge_Participant_Email_1`, `Challenge_Participant_Email_2`, `Challenge_Participant_Email_3`, `Challenge_Participant_Email_4`, `Challenge_Participant_Email_5`, `Challenge_WINNER_Email`) VALUES
(8, '1_hour', 'Steps', 0, 'jcg48@cornell.edu', 'sid@sid.com', 'falcons@gmail.com', 'dt@gmail.com', 'null', 'dt@gmail.com'),
(7, 'steps', 'activityTypes', NULL, 'test@cornell.edu', 'jgrays01@nyit.edu', NULL, NULL, NULL, 'test@nyit.edu'),
(6, 'steps', 'activityTypes', NULL, 'jcg48@cornell.edu', 'jgrays01@nyit.edu', NULL, NULL, NULL, 'jgrays01@nyit.edu'),
(40, '1 Hour', 'Steps', 0, 'robakidzeanna@yahoo.com', 'sid@sid.com', 'jcg48@cornell.edu', 'null', 'null', 'null'),
(41, '1 Hour', 'Steps', 0, 'robakidzeanna@yahoo.com', 'sid@sid.com', 'jcg48@cornell.edu', 'null', 'null', 'null'),
(15, 'Community', 'New Challenge', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 'Community', 'Calories Burned to Christmas Challenge', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(39, 'Community', 'Steps til Christmas', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, '1 Hour', 'Steps', 1, 'jgrays01@nyit.edu', 'xyz@gmail.com', 'dt@gmail.com', 'null', 'null', 'jgrays01@nyit.edu'),
(18, '1 Hour', 'Steps', 1, 'jgrays01@nyit.edu', 'dt@gmail.com', 'falcons@gmail.com', 'xyz@gmail.com', 'null', 'dt@gmail.com'),
(19, '1 Hour', 'Steps', 1, 'jgrays01@nyit.edu', 'dt@gmail.com', 'null', 'null', 'null', 'jgrays01@nyit.edu'),
(20, '1 Hour', 'Steps', 1, 'jgrays01@nyit.edu', 'xyz@gmail.com', 'falcons@gmail.com', 'null', 'null', 'jgrays01@nyit.edu'),
(53, '1 Hour', 'Steps', 0, 'robakidzeanna@yahoo.com', 'jcg48@cornell.edu', 'null', 'null', 'null', 'null'),
(51, 'Community', 'New Years Resolution', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(52, '1 Hour', 'Steps', 0, 'robakidzeanna@yahoo.com', 'jcg48@cornell.edu', 'null', 'null', 'null', 'null'),
(50, '1 Hour', 'Steps', 0, 'robakidzeanna@yahoo.com', 'dt@gmail.com', 'jcg48@cornell.edu', 'null', 'null', 'null'),
(48, '1 Hour', 'Steps', 0, 'robakidzeanna@yahoo.com', 'jcg48@cornell.edu', 'dcool@gmail.com', 'null', 'null', 'jcg48@cornell.edu'),
(47, '1 Hour', 'Steps', 0, 'jgrays01@nyit.edu', 'xyz@gmail.com', 'null', 'null', 'null', 'jgrays01@nyit.edu'),
(46, 'Daily', 'Floors Climbed', 0, 'robakidzeanna@yahoo.com', 'sid@sid.com', 'jcg48@cornell.edu', 'null', 'null', 'null'),
(45, '1 Hour', 'Steps', 0, 'robakidzeanna@yahoo.com', 'sid@sid.com', 'jcg48@cornell.edu', 'null', 'null', 'robakidzeanna@yahoo.com');

-- --------------------------------------------------------

--
-- Table structure for table `CommunityChallenge`
--

CREATE TABLE IF NOT EXISTS `CommunityChallenge` (
  `CommChallengeName` varchar(100) NOT NULL DEFAULT '',
  `CommChallengeDescription` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`CommChallengeName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CommunityChallenge`
--

INSERT INTO `CommunityChallenge` (`CommChallengeName`, `CommChallengeDescription`) VALUES
('RUN', 'complete 15 MILES'),
('Steps to Christmas Challenge', 'How many steps can you take before Christmas'),
('Calories Burned to Christmas Challenge', 'How many calories can you burn before Christmas day!'),
('New Challenge', 'Describe Challenge new'),
('New Years Resolution', 'Lets loose weight for next year !! ');

-- --------------------------------------------------------

--
-- Table structure for table `DASHBOARD`
--

CREATE TABLE IF NOT EXISTS `DASHBOARD` (
  `Dashboard_Entry_No` int(11) NOT NULL AUTO_INCREMENT,
  `Email` varchar(50) NOT NULL,
  `Entry_TimeStamp` date DEFAULT NULL,
  `Steps` int(11) DEFAULT NULL,
  `Miles` int(11) DEFAULT NULL,
  `CaloriesBurned` int(11) DEFAULT NULL,
  `FloorsClimbed` int(11) DEFAULT NULL,
  `BMP_Resting` int(11) DEFAULT NULL,
  `ActiveMinutes` int(11) DEFAULT NULL,
  `CalorieIntake` int(11) DEFAULT NULL,
  PRIMARY KEY (`Dashboard_Entry_No`),
  KEY `Email` (`Email`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=26 ;

--
-- Dumping data for table `DASHBOARD`
--

INSERT INTO `DASHBOARD` (`Dashboard_Entry_No`, `Email`, `Entry_TimeStamp`, `Steps`, `Miles`, `CaloriesBurned`, `FloorsClimbed`, `BMP_Resting`, `ActiveMinutes`, `CalorieIntake`) VALUES
(4, 'test@email.com', '2015-12-06', 250, 2, 1500, 5, 80, 34, 1650),
(3, 'dt@gmail.com', '2015-12-04', 250, 2, 1500, 5, 80, 34, 1650),
(5, 'test@gmail.com', '2015-12-07', 12, 12, 12, 12, 12, 12, 12),
(6, 'test@gmail.com', '2015-12-07', 12, 12, 12, 12, 12, 12, 12),
(7, 'test@gmail.com', '2015-12-07', 12, 12, 12, 12, 12, 12, 12),
(8, 'test2@gmail.com', '2015-12-07', 12, 12, 12, 12, 12, 12, 12),
(9, 'jcg48@cornell.edu', '2015-12-07', 250, 2, 1500, 5, 80, 34, 1650),
(10, 'jcg48@cornell.edu', '2015-12-07', 250, 2, 1500, 5, 80, 34, 1650),
(11, 'jgrays01@nyit.edu', '2015-12-09', 9800, 3, 2000, 4, 84, 30, 1200),
(12, 'jgrays01@nyit.edu', '2015-12-09', 10030, 5, 2500, 7, 81, 25, 1250),
(13, 'jgrays01@nyit.edu', '2015-12-09', 10050, 5, 3000, 8, 84, 27, 1275),
(14, 'jgrays01@nyit.edu', '2015-12-09', 200, 2, 1000, 4, 89, 30, 400),
(15, 'jgrays01@nyit.edu', '2015-12-09', 300, 3, 400, 6, 67, 30, 600),
(16, 'jgrays01@nyit.edu', '2015-12-10', 200, 1, 590, 3, 90, 12, 300),
(17, 'jgrays01@nyit.edu', '2015-12-11', 300, 1, 400, 6, 96, 8, 245),
(18, 'test2@gmail.com', '2015-12-12', 12, 12, 12, 12, 12, 12, 12),
(19, 'jgrays01@nyit.edu', '2015-12-12', 12000, 11, 3500, 4, 84, 65, 1560),
(20, 'jgrays01@nyit.edu', '2015-12-12', 12000, 11, 3500, 4, 84, 65, 1560),
(21, 'robakidzeanna@yahoo.com', '2015-12-13', 12, 13, 14, 15, 16, 17, 18),
(22, 'jgrays01@nyit.edu', '2015-12-13', 6000, 3, 2000, 4, 84, 20, 500),
(23, 'jgrays01@nyit.edu', '2015-12-15', 10000, 5, 3000, 4, 84, 34, 1600),
(24, 'arobakid@nyit.edu', '2015-12-16', 200, 4, 340, 20, 68, 40, 28),
(25, 'jgrays01@nyit.edu', '2015-12-16', 2000, 1, 1000, 3, 84, 23, 300);

-- --------------------------------------------------------

--
-- Table structure for table `DEVICE`
--

CREATE TABLE IF NOT EXISTS `DEVICE` (
  `DeviceID` int(11) NOT NULL AUTO_INCREMENT,
  `Device_Type` varchar(50) DEFAULT NULL,
  `Email` varchar(50) NOT NULL,
  PRIMARY KEY (`DeviceID`),
  KEY `Email` (`Email`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Table structure for table `FRIENDS`
--

CREATE TABLE IF NOT EXISTS `FRIENDS` (
  `FriendshipID` int(11) NOT NULL AUTO_INCREMENT,
  `userEmail` varchar(320) NOT NULL,
  `friendEmail` varchar(320) NOT NULL,
  PRIMARY KEY (`FriendshipID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=86 ;

--
-- Dumping data for table `FRIENDS`
--

INSERT INTO `FRIENDS` (`FriendshipID`, `userEmail`, `friendEmail`) VALUES
(1, 'abc@gmail.com', 'xyz@gmail.com'),
(2, 'abc@gmail.com', 'xyz@gmail.com'),
(3, 'abc@gmail.com', '123@gmail.com'),
(4, 'abc@gmail.com', 'xyz@gmail.com'),
(5, 'jgrays01@nyit.edu', 'xyz@gmail.com'),
(79, 'robakidzeanna@yahoo.com', '(null)'),
(7, 'jgrays01@nyit.edu', 'dt@gmail.com'),
(8, 'jgrays01@nyit.edu', 'falcons@gmail.com'),
(78, 'robakidzeanna@yahoo.com', 'sid@sid.com'),
(77, 'robakidzeanna@yahoo.com', 'jcg48@cornell.edu'),
(13, 'jgrays01@nyit.edu', 'robakidzeanna@yahoo.com'),
(85, 'robakidzeanna@yahoo.com', 'dt@gmail.com'),
(84, 'robakidzeanna@yahoo.com', 'falcons@gmail.com'),
(83, 'robakidzeanna@yahoo.com', 'dcool@gmail.com'),
(80, 'robakidzeanna@yahoo.com', 'dcool@gmail.com'),
(81, 'robakidzeanna@yahoo.com', 'falcons@gmail.com'),
(82, 'robakidzeanna@yahoo.com', 'falcons@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `management`
--

CREATE TABLE IF NOT EXISTS `management` (
  `managementid` int(11) NOT NULL AUTO_INCREMENT,
  `managementtype` varchar(50) NOT NULL,
  `management_password` varchar(500) NOT NULL,
  `management_since` date NOT NULL,
  PRIMARY KEY (`managementid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='management table' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `management`
--

INSERT INTO `management` (`managementid`, `managementtype`, `management_password`, `management_since`) VALUES
(1, 'Admin1', '1234', '2015-11-20'),
(2, 'Manager1', 'manager1234', '2015-12-07');

-- --------------------------------------------------------

--
-- Table structure for table `SOCIAL`
--

CREATE TABLE IF NOT EXISTS `SOCIAL` (
  `PostID` int(11) NOT NULL AUTO_INCREMENT,
  `Email` varchar(50) NOT NULL,
  `FirstName` varchar(30) NOT NULL,
  `LastName` varchar(30) NOT NULL,
  `DATE_POSTED` datetime NOT NULL,
  `POST_TEXT` longtext,
  `POST_PHOTO` longblob,
  `POST_VIDEO` varchar(1000) DEFAULT NULL,
  `ACTIVITY_TYPE` varchar(200) DEFAULT NULL,
  `user_location` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`PostID`),
  KEY `Email` (`Email`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `SOCIAL`
--

INSERT INTO `SOCIAL` (`PostID`, `Email`, `FirstName`, `LastName`, `DATE_POSTED`, `POST_TEXT`, `POST_PHOTO`, `POST_VIDEO`, `ACTIVITY_TYPE`, `user_location`) VALUES
(4, 'jgrays01@nyit.edu', 'Janina', 'Grayson', '2015-12-05 00:55:45', 'According to my Fitbit, I burned 600 calories dancing!', 0x6e756c6c, 'null', 'dancing', NULL),
(8, 'manager1@fitperfect.com', 'Management', 'Manager', '2015-12-09 02:31:27', 'Newsfeed error resolved. Use reload button to get data.', 0x6e756c6c, 'null', 'newsfeed', NULL),
(7, 'jgrays01@nyit.edu', 'Janina', 'Grayson', '2015-12-08 05:23:41', 'Rock climbing is excellent exercise. I try to go as much as possible', 0x6e756c6c, 'null', 'rock climbing', NULL),
(9, 'jgrays01@nyit.edu', 'Janina', 'Grayson', '2015-12-13 20:26:54', '1 Infinite Loop Cupertino CA 95014 United States', 0x6e756c6c, 'null', 'City Bicycle Ride', NULL),
(19, 'robakidzeanna@yahoo.com', 'Anuki', 'Robakidze', '2015-12-16 17:15:04', 'Walking is fun ! Yaaay', 0x6e756c6c, 'null', 'walking', NULL),
(18, 'robakidzeanna@yahoo.com', 'Anuki', 'Robakidze', '2015-12-16 02:07:29', 'running is cool', 0x6e756c6c, 'null', 'running', NULL),
(17, 'robakidzeanna@yahoo.com', 'Anuki', 'Robakidze', '2015-12-16 00:19:53', 'I am competing with Janina lets see who wins! ', 0x6e756c6c, 'null', 'walking', NULL),
(16, 'robakidzeanna@yahoo.com', 'Anuki', 'Robakidze', '2015-12-14 06:43:07', 'Zumbaaa ! ', 0x6e756c6c, 'null', 'Dancing', NULL),
(15, 'robakidzeanna@yahoo.com', 'Anuki', 'Robakidze', '2015-12-14 06:43:03', 'Zumbaaa ! ', 0x6e756c6c, 'null', 'Dancing', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_account`
--

CREATE TABLE IF NOT EXISTS `user_account` (
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `email` varchar(320) NOT NULL,
  `profile_photo` longblob NOT NULL,
  `age` int(11) DEFAULT NULL,
  `user_since` date NOT NULL,
  `challenges_completed` int(11) NOT NULL,
  `challenges_won` int(11) NOT NULL,
  `location_enabled` tinyint(1) NOT NULL,
  `goal_steps` int(11) NOT NULL,
  `goal_caloriestoburn` int(11) NOT NULL,
  `goal_floors` int(11) NOT NULL,
  `goal_activeminutes` int(11) NOT NULL,
  `device_type` varchar(50) NOT NULL,
  `last_login` date DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='UserAccount';

--
-- Dumping data for table `user_account`
--

INSERT INTO `user_account` (`firstname`, `lastname`, `email`, `profile_photo`, `age`, `user_since`, `challenges_completed`, `challenges_won`, `location_enabled`, `goal_steps`, `goal_caloriestoburn`, `goal_floors`, `goal_activeminutes`, `device_type`, `last_login`) VALUES
('Sid', 'Sachdev', 'sid@sid.com', '', 21, '0000-00-00', 0, 0, 0, 0, 0, 0, 0, '', NULL),
('Janina', 'Grayson', 'jcg48@cornell.edu', '', NULL, '2015-12-07', 0, 0, 0, 0, 0, 0, 0, '', '2015-12-10'),
('Dan', 'Cool', 'dcool@gmail.com', '', 30, '2015-12-01', 0, 0, 0, 0, 0, 0, 0, '', NULL),
('Matt', 'Ryan', 'falcons@gmail.com', '', 25, '2015-12-01', 0, 0, 0, 0, 0, 0, 0, '', '2015-12-06'),
('SIDISAWESOME', 'Cool', 'chelseafc@gmail.com', '', 21, '2015-12-01', 0, 0, 0, 0, 0, 0, 0, '', NULL),
('Deborah', 'Todman', 'dt@gmail.com', '', 40, '2015-12-04', 0, 0, 0, 0, 0, 0, 0, '', NULL),
('Janina-test', 'test-test', 'test@email.com', '', 20, '2015-12-06', 0, 0, 0, 0, 0, 0, 0, '', '2015-12-06'),
('Randall', 'Cobb', 'packers@gmail.com', '', 25, '2015-12-07', 0, 0, 0, 0, 0, 0, 0, '', NULL),
('Janina', 'Grayson', 'jgrays01@nyit.edu', '', 28, '2015-12-07', 0, 0, 1, 10000, 2000, 10, 30, 'Other', '2015-12-16'),
('Anuki', 'Robakidze', 'robakidzeanna@yahoo.com', '', NULL, '2015-12-16', 0, 0, 0, 0, 0, 0, 0, 'Apple_Watch', '2015-12-16'),
('Ana', 'Robakidze', 'arobakid@nyit.edu', '', 22, '2015-12-16', 0, 0, 0, 0, 0, 0, 0, '', NULL);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
