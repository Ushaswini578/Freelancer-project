/*
SQLyog Ultimate v11.33 (64 bit)
MySQL - 5.0.45-community-nt : Database - freelancer
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`freelancer` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `freelancer`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL auto_increment,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) default NULL,
  PRIMARY KEY  (`admin_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `admin` */

insert  into `admin`(`admin_id`,`username`,`password`,`email`) values (1,'admin','admin','admin@gmail.com');

/*Table structure for table `bids` */

DROP TABLE IF EXISTS `bids`;

CREATE TABLE `bids` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `freelancer_name` varchar(100) default NULL,
  `bid_amount` decimal(10,2) default NULL,
  `proposal` text,
  `bid_date` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `status` varchar(20) default 'Pending',
  `femail` varchar(250) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `bids` */

insert  into `bids`(`id`,`project_id`,`freelancer_name`,`bid_amount`,`proposal`,`bid_date`,`status`,`femail`) values (1,1,'Sravani','4500.00','i complete things with teamSpirt','2026-04-12 01:18:36','Hired','mr.s.srikanthbabu@gmail.com');

/*Table structure for table `feedback` */

DROP TABLE IF EXISTS `feedback`;

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL auto_increment,
  `project_id` int(11) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `femail` varchar(150) NOT NULL,
  `rating` int(11) default NULL,
  `comments` text,
  PRIMARY KEY  (`feedback_id`),
  KEY `project_id` (`project_id`),
  KEY `user_id` (`user_name`),
  KEY `freelancer_id` (`femail`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `feedback` */

/*Table structure for table `freelancer` */

DROP TABLE IF EXISTS `freelancer`;

CREATE TABLE `freelancer` (
  `freelancer_id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(15) default NULL,
  `skills` varchar(255) default NULL,
  `experience` varchar(11) default NULL,
  `status` varchar(10) default 'Pending',
  `registration_date` date default NULL,
  PRIMARY KEY  (`freelancer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `freelancer` */

insert  into `freelancer`(`freelancer_id`,`name`,`email`,`password`,`phone`,`skills`,`experience`,`status`,`registration_date`) values (1,'Sravani','mr.s.srikanthbabu@gmail.com','sravani','9063643665','Java, Python, MySQL','1-2 Years','Approved','2026-03-24');

/*Table structure for table `payments` */

DROP TABLE IF EXISTS `payments`;

CREATE TABLE `payments` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `project_title` varchar(255) default NULL,
  `freelancer_name` varchar(150) default NULL,
  `user_name` varchar(150) default NULL,
  `amount` decimal(10,2) default NULL,
  `payment_status` enum('Pending','Paid') default 'Pending',
  `payment_method` varchar(50) default NULL,
  `transaction_id` varchar(100) default NULL,
  `payment_date` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `remarks` text,
  PRIMARY KEY  (`id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `payments` */

/*Table structure for table `project` */

DROP TABLE IF EXISTS `project`;

CREATE TABLE `project` (
  `project_id` int(11) NOT NULL auto_increment,
  `title` varchar(100) default NULL,
  `description` text,
  `budget` decimal(10,2) default NULL,
  `status` varchar(15) default 'open',
  `notes` varchar(200) default NULL,
  `femail` varchar(200) default NULL,
  `category` varchar(200) default NULL,
  `deadline` varchar(100) default NULL,
  `user_name` varchar(100) default NULL,
  `message` varchar(150) default NULL,
  `min_bid` decimal(10,2) default NULL,
  `selected_freelancer` varchar(100) default NULL,
  PRIMARY KEY  (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `project` */

insert  into `project`(`project_id`,`title`,`description`,`budget`,`status`,`notes`,`femail`,`category`,`deadline`,`user_name`,`message`,`min_bid`,`selected_freelancer`) values (1,'Vehicle Information System','vehicle info','5000.00','Assigned',NULL,'mr.s.srikanthbabu@gmail.com','Web Development','2026-04-10','Navya','hi',NULL,NULL),(2,'FreelancerFinder','Project Assignment','5000.00','Assigned',NULL,'pranavi4783@gmail.com','Web Development','2026-04-10','Navya','i am glad to associate with You',NULL,NULL),(3,'aa','hello','5000.00','Pending',NULL,NULL,'Web Development','2026-04-11','Navya',NULL,NULL,NULL),(4,'Andhra','Hllow','3000.00','Assigned',NULL,'mr.s.srikanthbabu@gmail.com','Web Development','2026-04-10','Navya','You are good',NULL,NULL);

/*Table structure for table `project_assignment` */

DROP TABLE IF EXISTS `project_assignment`;

CREATE TABLE `project_assignment` (
  `assignment_id` int(11) NOT NULL auto_increment,
  `project_id` int(11) NOT NULL,
  `freelancer_id` int(11) NOT NULL,
  `assigned_date` date default NULL,
  `status` enum('in-progress','completed') default 'in-progress',
  PRIMARY KEY  (`assignment_id`),
  KEY `project_id` (`project_id`),
  KEY `freelancer_id` (`freelancer_id`),
  CONSTRAINT `project_assignment_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`),
  CONSTRAINT `project_assignment_ibfk_2` FOREIGN KEY (`freelancer_id`) REFERENCES `freelancer` (`freelancer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `project_assignment` */

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(15) default NULL,
  `status` varchar(10) default NULL,
  `registration_date` date default NULL,
  PRIMARY KEY  (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `user` */

insert  into `user`(`user_id`,`name`,`email`,`password`,`phone`,`status`,`registration_date`) values (1,'Srikanth','srikanth@gmail.com','srikanth','9063643665','Active','2026-03-24'),(2,'Navya','navya@gmail.com','12345','9063643665','Active','2026-03-29');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
