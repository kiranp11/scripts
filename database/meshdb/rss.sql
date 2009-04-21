/*
SQLyog Community Edition- MySQL GUI v6.56
MySQL - 5.0.20-nt : Database - meshprototype2
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`meshprototype2` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `meshprototype2`;

/*Table structure for table `rssinfo` */

DROP TABLE IF EXISTS `rssinfo`;

CREATE TABLE `rssinfo` (                                        
           `RSS_SEQUENCE_ID` bigint(20) NOT NULL auto_increment,         
           `RSS` varchar(512) NOT NULL,                                  
           `RSS_NAME` varchar(512) NOT NULL,                             
           `LAST_URL` varchar(512) default NULL,                         
           `Date_Created` timestamp NOT NULL default CURRENT_TIMESTAMP,  
           PRIMARY KEY  (`RSS_SEQUENCE_ID`),                             
           UNIQUE KEY `RSS_ID_INDEX` (`RSS`)                             
         ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `spi_rss` */

DROP TABLE IF EXISTS `spi_rss`;

CREATE TABLE `spi_rss` (
  `SPI_RSS_SEQUENCE` bigint(20) NOT NULL auto_increment,
  `SEMANTIC_PROFILE_OWNER_ID` bigint(20) NOT NULL,
  `RSS_ID` bigint(20) NOT NULL,
  `OWNER_TYPE` int(8) NOT NULL,
  `DATE_CREATED` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `DATE_LAST_MODIFIED` timestamp NOT NULL default '0000-00-00 00:00:00',
  `NAMESPACE` int(8) NOT NULL default '1',
  PRIMARY KEY  (`SPI_RSS_SEQUENCE`),
  KEY `FK_spi_rss_SPI_owner_type` (`OWNER_TYPE`),
  KEY `FK_spi_rss_SPI_owner` (`SEMANTIC_PROFILE_OWNER_ID`),
  KEY `FK_spi_rss` (`RSS_ID`),
  CONSTRAINT `FK_spi_rss` FOREIGN KEY (`RSS_ID`) REFERENCES `rssinfo` (`RSS_SEQUENCE_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `spi_url` */

DROP TABLE IF EXISTS `spi_url`;

CREATE TABLE `spi_url` (
  `SPI_URL_SEQUENCE` bigint(20) NOT NULL auto_increment,
  `SEMANTIC_PROFILE_OWNER_ID` bigint(20) NOT NULL,
  `URL_ID` bigint(10) NOT NULL,
  `OWNER_TYPE` int(8) NOT NULL,
  `RSS_ID` bigint(20) NOT NULL,
  `DATE_CREATED` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `DATE_LAST_MODIFIED` timestamp NULL default NULL,
  `is_Matched` tinyint(2) NOT NULL default '0' COMMENT '0--> untested ; 1--> Successful Match; -1 --> Un-Successful Match',
  `is_Read` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`SPI_URL_SEQUENCE`),
  KEY `FK_spi_url` (`URL_ID`),
  KEY `FK_spi_url_SPI_owner` (`SEMANTIC_PROFILE_OWNER_ID`),
  KEY `FK_spi_url_SPI_owner_type` (`OWNER_TYPE`),
  KEY `FK_spi_url_rss` (`RSS_ID`),
  CONSTRAINT `FK_spi_url` FOREIGN KEY (`URL_ID`) REFERENCES `urlinfo` (`URL_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `spi_url_ibfk_1` FOREIGN KEY (`RSS_ID`) REFERENCES `rssinfo` (`RSS_SEQUENCE_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
