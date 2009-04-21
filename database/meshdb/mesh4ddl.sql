l/*
SQLyog - Free MySQL GUI v5.19
Host - 5.0.20-nt : Database - meshprototype2
*********************************************************************
Server version : 5.0.20-nt
*/
SET NAMES utf8;

SET SQL_MODE='';

create database if not exists `meshprototype2`;

USE `meshprototype2`;

/*Table structure for table `namespace` */

DROP TABLE IF EXISTS `namespace`;

CREATE TABLE `namespace` (
  `NAMESPACE_ID` int(11) NOT NULL auto_increment,
  `NAME` varchar(100) NOT NULL,
  `DESC` varchar(100) NOT NULL,
  PRIMARY KEY  (`NAMESPACE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `profiledomain` (                         
`DOMAIN_ID` int(8) NOT NULL auto_increment,          
`DOMAIN_NAME` varchar(256) NOT NULL,                 
`DOMAIN_DESC` varchar(512) NOT NULL,                 
`CHRONO_SORT` tinyint(1) default '0',
PRIMARY KEY  (`DOMAIN_ID`)                           
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `userinfo` */

DROP TABLE IF EXISTS `userinfo`;

DROP TABLE IF EXISTS `email_invites`;

CREATE TABLE `email_invites` (
  `EMAIL` varchar(100) NOT NULL,
  `UNIQUE_KEY` varchar(100) NOT NULL,
  PRIMARY KEY  (`EMAIL`),
  UNIQUE KEY `UNIQUE_KEY` (`UNIQUE_KEY`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `email_preference_user`;

CREATE TABLE `email_preference_user` (
  `EMAIL_PREFERENCE_USER_ID` bigint(20) NOT NULL auto_increment,
  `user_ID` bigint(10) NOT NULL,
  `board_ID` int(10) default NULL,
  `friend_ID` bigint(10) default NULL,
  `Frequency` int(5) NOT NULL default '1' COMMENT 'in days; Ex:0--> As it happens; 1-->Once in a day',
  PRIMARY KEY  (`EMAIL_PREFERENCE_USER_ID`),
  KEY `FK_email_preference_user_board` (`board_ID`),
  KEY `FK_email_preference_user_user` (`user_ID`),
  KEY `FK_email_preference_user_FRIEND` (`friend_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;

CREATE TABLE `userinfo` (
  `USER_ID_SEQUENCE` bigint(10) NOT NULL auto_increment,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(200) default NULL,
  `dateofbirth` date default NULL,
  `country` varchar(100) default NULL,
  `sex` tinyint(1) default NULL,
  `photo` varchar(100) default NULL,
  `TIME_CREATED` timestamp NULL default NULL,
  `LAST_EDIT` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `DELETED` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`USER_ID_SEQUENCE`),
  UNIQUE KEY `username_index` (`username`),
  UNIQUE KEY `email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE userinfo ADD COLUMN enabled bool AFTER password;
ALTER TABLE userinfo ALTER COLUMN enabled SET DEFAULT 1;

/*Table structure for table `message` */

DROP TABLE IF EXISTS `message`;

CREATE TABLE `message` (                                                                 
   `MessageID` bigint(20) NOT NULL auto_increment,                                        
   `Subject` varchar(256) default NULL,                                                   
   `Body` text,                                                                           
   `TimeStamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,  
   `MessageType` int(2) NOT NULL,                                                         
   `DELETED` tinyint(1) NOT NULL default '0',                                             
   PRIMARY KEY  (`MessageID`)                                                             
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 	
/*Table structure for table `boardinfo` */

DROP TABLE IF EXISTS `boardinfo`;

CREATE TABLE `boardinfo` (
  `BOARDID_SEQUENCE` int(10) NOT NULL auto_increment,
  `BOARDNAME` varchar(200) NOT NULL,
  `WEIGHT` float default NULL,
  `WIKI_LINK` varchar(300) default NULL,
  `IMAGE_URL` varchar(200) default NULL,
  `TIME_CREATED` timestamp NULL default NULL,
  `LAST_MODIFIED_TIME` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `USER_ID` bigint(20) NOT NULL default '1',
  `DESCRIPTION` varchar(300) default NULL,
  `TAGS` varchar(200) default NULL,
  `NO_OF_CONNECTIONS` int(10) NOT NULL default '0',
  `NO_OF_USERS` int(10) NOT NULL default '0',
  `NO_OF_CONTENTS` int(10) NOT NULL default '0',
  `NAMESPACE` int(11) NOT NULL default '1',
  `DELETED` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`BOARDID_SEQUENCE`),
  KEY `FK_nodeinfo` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `urlinfo`;

CREATE TABLE `urlinfo` (                                                                                                           
`URL_ID` bigint(20) NOT NULL auto_increment,                                                                                     
`URL_ADDRESS` varchar(248) NOT NULL default '',                                                                                  
`URL_TITLE` varchar(200) NOT NULL,                                                                                               
`URL_DESC` text,                                                                                                                 
`URL_TYPE` int(2) default '0',                                                                                                   
`SOURCE_TYPE` int(11) NOT NULL default '1',                                                                                      
`IMAGE_URL` varchar(248) default NULL,                                                                                           
`FILE_REFERENCE_STRING` varchar(248) default NULL,                                                                               
`ROOT_MESSAGEID` bigint(20) NOT NULL,                                                                                            
`NO_OF_POSTS` int(10) NOT NULL default '0',                                                                                      
`USER_ID` bigint(20) NOT NULL,                                                                                                   
`TAGS` varchar(200) default NULL,                                                                                                
`TIME_CREATED` timestamp NULL default NULL,                                                                                      
`PROFILE_DOMAIN` int(8) NOT NULL default '1',                                                                                    
`NAMESPACE` int(8) NOT NULL default '1',                                                                                        
`LAST_EDIT` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,                                            
`DELETED` tinyint(1) NOT NULL default '0',                                                                                       
PRIMARY KEY  (`URL_ID`),                                                                                                         
UNIQUE KEY `uniqueurl` (`URL_ADDRESS`,`USER_ID`),                                                                                
KEY `FK_urlinfo` (`USER_ID`),                                                                                                    
KEY `FK_urlinfo_namspace` (`NAMESPACE`),                                                                                         
KEY `filerefindex` (`FILE_REFERENCE_STRING`),                                                                                    
KEY `FK_urlinfo_domain` (`PROFILE_DOMAIN`),                                                                                      
CONSTRAINT `FK_urlinfo` FOREIGN KEY (`USER_ID`) REFERENCES `userinfo` (`USER_ID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE,  
CONSTRAINT `FK_urlinfo_domain` FOREIGN KEY (`PROFILE_DOMAIN`) REFERENCES `profiledomain` (`DOMAIN_ID`),        
CONSTRAINT `urlinfo_ibfk_1` FOREIGN KEY (`NAMESPACE`) REFERENCES `namespace` (`NAMESPACE_ID`) ON UPDATE CASCADE                  
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;  

CREATE TABLE `bookkeeping` (            
	`bk_key` varchar(128) NOT NULL,       
    `bk_value` varchar(64) default NULL,  
    PRIMARY KEY  (`bk_key`)               
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*Table structure for table `boardmessage` */

DROP TABLE IF EXISTS `boardmessage`;

CREATE TABLE `boardmessage` (
  `UserMessage_ID` bigint(20) NOT NULL,
  `FromUserID` bigint(20) NOT NULL,                                                                                                           
  `FromName` varchar(50) default 'Anonymous' COMMENT 'Deprecated',
  `BOARD_ID` int(10) NOT NULL,
  `MessageID` bigint(20) NOT NULL,
  `IsRead` tinyint(1) NOT NULL default '0' COMMENT '1=read',
  `IsRoot` tinyint(1) NOT NULL default '1',
  `NoOfReplies` int(8) default NULL,
  PRIMARY KEY  (`UserMessage_ID`),
  KEY `FK_nodemessage_from` (`FromUserID`),
  KEY `FK_nodemessage_nodeID` (`BOARD_ID`),
  KEY `FK_nodemessage` (`MessageID`),
  CONSTRAINT `boardmessage_ibfk_1` FOREIGN KEY (`MessageID`) REFERENCES `message` (`MessageID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `boardmessage_ibfk_2` FOREIGN KEY (`BOARD_ID`) REFERENCES `boardinfo` (`BOARDID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_nodemessage_FROM` FOREIGN KEY (`FromUserID`) REFERENCES `userinfo` (`USER_ID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `boardmessagedependency` */

DROP TABLE IF EXISTS `boardmessagedependency`;

CREATE TABLE `boardmessagedependency` (
  `MessageID` bigint(20) NOT NULL,
  `RootThread` bigint(20) NOT NULL,
  PRIMARY KEY  (`MessageID`),
  KEY `FK_nodemessagedependency_root` (`RootThread`),
  CONSTRAINT `boardmessagedependency_ibfk_1` FOREIGN KEY (`MessageID`) REFERENCES `message` (`MessageID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `boardmessagedependency_ibfk_3` FOREIGN KEY (`RootThread`) REFERENCES `message` (`MessageID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `boardtopics` */

DROP TABLE IF EXISTS `boardtopics`;

CREATE TABLE `boardtopics` (
  `BOARD_TAG_SEQUENCEID` bigint(20) NOT NULL auto_increment,
  `BOARD_ID` int(11) NOT NULL,
  `TOPIC_NAME` varchar(40) NOT NULL,
  `TOPIC_ID` int(11) default NULL,
  `ONTOLOGY_ID` int(11) default NULL,
  PRIMARY KEY  (`BOARD_TAG_SEQUENCEID`),
  KEY `FK_boardtopics` (`BOARD_ID`),
  CONSTRAINT `boardtopics_ibfk_1` FOREIGN KEY (`BOARD_ID`) REFERENCES `boardinfo` (`BOARDID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `contentvotecount` */

DROP TABLE IF EXISTS `contentvotecount`;

CREATE TABLE `contentvotecount` (
  `CONTENT_VOTE_NO_SEQUENCE` bigint(20) NOT NULL auto_increment,
  `CONTENT_ID` bigint(20) NOT NULL,
  `CONTENT_TYPE` smallint(3) NOT NULL,
  `VOTE_COUNT` int(8) NOT NULL default '0',
  PRIMARY KEY  (`CONTENT_VOTE_NO_SEQUENCE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `currentactivity` */

DROP TABLE IF EXISTS `currentactivity`;

CREATE TABLE `currentactivity` (                                        
	`ACTIVITY_OWNER_ID` bigint(20) NOT NULL auto_increment,               
	`OWNER_ID` bigint(20) NOT NULL,                                       
    `OWNER_TYPE` int(11) NOT NULL,                                        
    `CURRENT_ACTIVITY` int(11) NOT NULL,                                  
    `OWNER_NAMESPACE` int(8) NOT NULL default '1',                        
    `LAST_CALCULATED_TIME` timestamp NOT NULL default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  
    PRIMARY KEY  (`ACTIVITY_OWNER_ID`),                                   
    UNIQUE KEY `OWNER_ID` (`OWNER_ID`,`OWNER_TYPE`)                       
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `reportabuse` (                                                                                                                         
    `ABUSE_ID` bigint(20) NOT NULL auto_increment,                                                                                                     
    `OWNER_ID` bigint(20) NOT NULL,                                                                                                                    
    `OWNER_TYPE` int(11) NOT NULL,                                                                                                                     
    `USER_ABUSING_ID` bigint(20) NOT NULL,                                                                                                             
    `USER_REPORTING_ID` bigint(20) NOT NULL,                                                                                                           
    `ABUSE_STATEMENT` varchar(300) default NULL,                                                                                                       
    `ABUSE_OPTION` int(8) NOT NULL default '1',                                                                                                        
    `REPORT_TIME` timestamp NOT NULL default CURRENT_TIMESTAMP,                                                                                        
    `RESOLUTION` varchar(300) default NULL,                                                                                                            
    PRIMARY KEY  (`ABUSE_ID`),                                                                                                                         
    KEY `FK_reportabuse_reporter` (`USER_REPORTING_ID`),                                                                                               
    KEY `FK_reportabuse_abuser` (`USER_ABUSING_ID`),                                                                                                   
    CONSTRAINT `reportabuse_ibfk_1` FOREIGN KEY (`USER_REPORTING_ID`) REFERENCES `userinfo` (`USER_ID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE,  
    CONSTRAINT `reportabuse_ibfk_2` FOREIGN KEY (`USER_ABUSING_ID`) REFERENCES `userinfo` (`USER_ID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE     
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `eventstable` */

DROP TABLE IF EXISTS `eventstable`;

CREATE TABLE `eventstable` (
  `EVENT_ID` bigint(10) NOT NULL auto_increment,
  `SENTENCE_ID` varchar(100) default NULL,
  `TIMESTAMP_TO` date default NULL,
  `TIMESTAMP_FROM` date default NULL,
  `EVENT_TIME_TYPE` tinyint(4) default NULL,
  `LOCATIONSTAMP` varchar(100) default NULL,
  `EVENT_LOCATION_TYPE` tinyint(4) default NULL,
  PRIMARY KEY  (`EVENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `imagessequence` */

DROP TABLE IF EXISTS `imagessequence`;

CREATE TABLE `imagessequence` (
  `IMAGE_SEQUENCE_ID` bigint(20) NOT NULL,
  PRIMARY KEY  (`IMAGE_SEQUENCE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `invitelist` */

DROP TABLE IF EXISTS `invitelist`;

CREATE TABLE `invitelist` (
  `INVITE_ID` int(10) NOT NULL auto_increment,
  `NAME` varchar(100) NOT NULL,
  `EMAIL` varchar(200) NOT NULL,
  `TIME_OF_REQUEST` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `INVITE_MAIL_SENT` tinyint(1) NOT NULL default '0',
  `REGISTARTION_MAIL_SENT` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`INVITE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `roleID` int(10) NOT NULL auto_increment COMMENT 'This is autoFill',
  `roleName` varchar(100) NOT NULL COMMENT 'Enter the Role name here.',
  `roleDescription` varchar(100) default NULL COMMENT 'Optional. ',
  PRIMARY KEY  (`roleID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `searchquery` */

DROP TABLE IF EXISTS `searchquery`;

CREATE TABLE `searchquery` (
  `SEARCH_QUERY_HASH` bigint(20) NOT NULL,
  `SEARCH_QUERY` varchar(200) NOT NULL,
  `TIME_OF_QUERY` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `NO_OF_HITS` int(10) NOT NULL,
  PRIMARY KEY  (`SEARCH_QUERY_HASH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `searchtopicfile` */

DROP TABLE IF EXISTS `searchtopicfile`;

CREATE TABLE `searchtopicfile` (
  `NODE_ID` int(11) NOT NULL,
  `SEARCH_FILE` text NOT NULL,
  PRIMARY KEY  (`NODE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `semanticprofileownertypes` */

DROP TABLE IF EXISTS `semanticprofileownertypes`;

CREATE TABLE `semanticprofileownertypes` (
  `OWNER_TYPE_ID` int(11) NOT NULL auto_increment,
  `OWNER_TYPE` varchar(64) NOT NULL,
  PRIMARY KEY  (`OWNER_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `semanticprofilestore` */

DROP TABLE IF EXISTS `semanticprofilestore`;
	
CREATE TABLE `semanticprofilestore` (                                                                                                             
`PROFILE_TABLE_SEQUENCE` bigint(20) NOT NULL auto_increment,                                                                            
`SEMANTIC_PROFILE_OWNER_ID` bigint(20) NOT NULL,                                                                                                
`OWNER_TYPE` int(8) NOT NULL,                                                                                                                   
`SEMANTIC_PROFILE` mediumtext character set ucs2 NOT NULL,                                                                                      
`DATE_CREATED` ;timestamp NULL default NULL,                                                                                                     
`DATE_LAST_MODIFIED` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,                                                  
`PROFILE_DOMAIN` int(8) NOT NULL default '1',                                                                                                  
`NAMESPACE` int(8) NOT NULL default '1',                                                                                                       
`DELETED` tinyint(1) NOT NULL default '0',                                                                                                      
PRIMARY KEY  (`PROFILE_TABLE_SEQUENCE`),                                                                                                        
UNIQUE KEY `SEMANTIC_PROFILE_UNIQUE` (`SEMANTIC_PROFILE_OWNER_ID`,`OWNER_TYPE`),                                                                
KEY `FK_semanticprofilestore` (`OWNER_TYPE`),                                                                                                   
KEY `FK_semanticprofilestore_domain` (`PROFILE_DOMAIN`),                                                                                        
CONSTRAINT `FK_semanticprofilestore_domain` FOREIGN KEY (`PROFILE_DOMAIN`) REFERENCES `profiledomain` (`DOMAIN_ID`),          
CONSTRAINT `semanticprofilestore_ibfk_1` FOREIGN KEY (`OWNER_TYPE`) REFERENCES `semanticprofileownertypes` (`OWNER_TYPE_ID`) ON UPDATE CASCADE  
) ENGINE=InnoDB AUTO_INCREMENT=190896 DEFAULT CHARSET=utf8;

CREATE TABLE `profilewaittopicsstore` (                                                                                                             
`PROFILE_TABLE_SEQUENCE` bigint(20) NOT NULL auto_increment,                                                     
`SEMANTIC_PROFILE_OWNER_ID` bigint(20) NOT NULL,                                                                        
`OWNER_TYPE` int(8) NOT NULL,                                                                                            
`SEMANTIC_PROFILE_WAIT_TOPICS` mediumtext character set ucs2 NOT NULL,                                                   
PRIMARY KEY  (`PROFILE_TABLE_SEQUENCE`),                                                                                  
UNIQUE KEY `SEMANTIC_PROFILE_WAIT_UNIQUE` (`SEMANTIC_PROFILE_OWNER_ID`,`OWNER_TYPE`),                                     
KEY `FK_semanticprofilestorewait` (`OWNER_TYPE`),                                                                  
CONSTRAINT `semanticprofilestorewait_ibfk_1` FOREIGN KEY (`OWNER_TYPE`) REFERENCES `semanticprofileownertypes` (`OWNER_TYPE_ID`) ON UPDATE CASCADE ) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;



/*Table structure for table `tags` */

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `TAGS_ID` bigint(20) NOT NULL auto_increment,
  `TAG_NAME` varchar(40) NOT NULL,
  PRIMARY KEY  (`TAGS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `tempurlstore` */

DROP TABLE IF EXISTS `tempurlstore`;

CREATE TABLE `tempurlstore` (
  `URL_ADDRESS` varchar(150) NOT NULL,
  `TIME_SAVED` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `EXTRACTED_CONTENT` longtext NOT NULL,
  PRIMARY KEY  (`URL_ADDRESS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `urlboard` */

DROP TABLE IF EXISTS `urlboard`;

CREATE TABLE `urlboard` (                                                                                                  
`URLNodeSequenceID` bigint(10) NOT NULL auto_increment,                                                                  
`URLID` bigint(10) NOT NULL,                                                                                             
`BOARDID` int(10) NOT NULL,                                                                                              
`ATTACH_TYPE` int(8) NOT NULL default '1' COMMENT '1 = Direct Attach',                                                   
PRIMARY KEY  (`URLNodeSequenceID`),                      
UNIQUE KEY `urlboardunique` (`URLID`,`BOARDID`),			
KEY `FK_urlnodes` (`BOARDID`),                                                                                           
KEY `FK_urlnodes2` (`URLID`),                                                                                            
CONSTRAINT `urlboard_ibfk_2` FOREIGN KEY (`URLID`) REFERENCES `urlinfo` (`URL_ID`) ON DELETE CASCADE ON UPDATE CASCADE,  
CONSTRAINT `urlboard_ibfk_3` FOREIGN KEY (`BOARDID`) REFERENCES `boardinfo` (`BOARDID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE       
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*Table structure for table `urlmessagedependency` */

DROP TABLE IF EXISTS `urlmessagedependency`;

CREATE TABLE `urlmessagedependency` (
  `MessageID` bigint(20) NOT NULL,
  `RootThread` bigint(20) NOT NULL,
  PRIMARY KEY  (`MessageID`),
  KEY `FK_urlmessagedependency` (`RootThread`),
  CONSTRAINT `urlmessagedependency_ibfk_1` FOREIGN KEY (`MessageID`) REFERENCES `message` (`MessageID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `urlmessagedependency_ibfk_2` FOREIGN KEY (`RootThread`) REFERENCES `message` (`MessageID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `urlmessages` */

DROP TABLE IF EXISTS `urlmessages`;

CREATE TABLE `urlmessages` (
  `URL_MessageID` bigint(20) NOT NULL,
  `FromUserID` bigint(20) default NULL,
  `URL_ID` bigint(20) NOT NULL,
  `MessageID` bigint(20) NOT NULL,
  `IsRoot` tinyint(1) NOT NULL default '1',
  `No_Of_Replies` int(8) NOT NULL,
  PRIMARY KEY  (`URL_MessageID`),
  KEY `FK_urlmessages` (`FromUserID`),
  KEY `FK_urlmessages_url` (`URL_ID`),
  KEY `FK_urlmessages_message` (`MessageID`),
  CONSTRAINT `urlmessages_ibfk_1` FOREIGN KEY (`FromUserID`) REFERENCES `userinfo` (`USER_ID_SEQUENCE`) ON UPDATE CASCADE,
  CONSTRAINT `urlmessages_ibfk_2` FOREIGN KEY (`URL_ID`) REFERENCES `urlinfo` (`URL_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `urlmessages_ibfk_3` FOREIGN KEY (`MessageID`) REFERENCES `message` (`MessageID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `userboardlinks` */

DROP TABLE IF EXISTS `userboardlinks`;

CREATE TABLE `userboardlinks` (
  `USER_LINK_SEQUENCE_ID` int(11) NOT NULL auto_increment,
  `USER_NODE_LINK_NAME` varchar(50) NOT NULL,
  `AFINNITY_CONSTANT` smallint(2) NOT NULL default '0',
  PRIMARY KEY  (`USER_LINK_SEQUENCE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `userboardmapping` */

DROP TABLE IF EXISTS `userboardmapping`;

CREATE TABLE `userboardmapping` (                                                                                                                               
`USER_BOARD_SEQUENCEID` bigint(20) NOT NULL auto_increment,                                                                                                   
`USERID` bigint(10) NOT NULL,                                                                                                                                 
`BOARDID` int(10) NOT NULL,                                                                                                                                   
`USER_LINK_ID` int(11) NOT NULL,                                                                                                                              
`RECEIVE_ALERTS` tinyint(1) NOT NULL default '1',                                                                                                                        
`AFFINITY_CONSTANT` smallint(8) NOT NULL default '5',                                                                                                         
PRIMARY KEY  (`USER_BOARD_SEQUENCEID`),                                                                                                                       
UNIQUE KEY `UNIQUE_BOARD` (`USERID`,`BOARDID`),                                                                                                               
KEY `FK_usernodemapping_user` (`USERID`),                                                                                                                     
KEY `FK_usernodemapping_nodeid` (`BOARDID`),                                                                                                                  
KEY `FK_usernodemapping` (`USER_LINK_ID`),                                                                                                                    
CONSTRAINT `FK_usernodemapping_user` FOREIGN KEY (`USERID`) REFERENCES `userinfo` (`USER_ID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE,                   
CONSTRAINT `userboardmapping_ibfk_1` FOREIGN KEY (`USER_LINK_ID`) REFERENCES `userboardlinks` (`USER_LINK_SEQUENCE_ID`) ON DELETE CASCADE ON UPDATE CASCADE,  
CONSTRAINT `userboardmapping_ibfk_2` FOREIGN KEY (`BOARDID`) REFERENCES `boardinfo` (`BOARDID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE                  
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `crawlurl`;

CREATE TABLE `crawlurl` (                                                                                     
`CRAWL_URL_ID` bigint(20) NOT NULL auto_increment,                                                          
`URL` varchar(255) NOT NULL,                                                                                
`SOURCE` varchar(255) default NULL,                                                                         
`DOMAIN` int(11) NOT NULL,                                                                                  
`TIME` timestamp NOT NULL default CURRENT_TIMESTAMP,                                                        
PRIMARY KEY  (`CRAWL_URL_ID`),                                                                              
UNIQUE KEY `CRAWL_URL_ID` (`CRAWL_URL_ID`),                                                                 
UNIQUE KEY `NewIndex1` (`URL`),                                                                             
KEY `FK_crawlurl` (`DOMAIN`),                                                                               
CONSTRAINT `FK_crawlurl` FOREIGN KEY (`DOMAIN`) REFERENCES `profiledomain` (`DOMAIN_ID`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `usermessage` */

DROP TABLE IF EXISTS `usermessage`;

CREATE TABLE `usermessage` (
  `UserMessage_ID` bigint(20) NOT NULL auto_increment,
  `FromMessage` bigint(20) NOT NULL,
  `ToMessage` bigint(20) NOT NULL,
  `MessageID` bigint(20) NOT NULL,
  `ISRead` tinyint(1) NOT NULL default '0' COMMENT '1=read',
  `IsLatest` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`UserMessage_ID`),
  KEY `FK_usermessage_from` (`FromMessage`),
  KEY `FK_usermessage_TO` (`ToMessage`),
  KEY `FK_usermessage_messageID` (`MessageID`),
  CONSTRAINT `FK_usermessage_FROM` FOREIGN KEY (`FromMessage`) REFERENCES `userinfo` (`USER_ID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_usermessage_messageID` FOREIGN KEY (`MessageID`) REFERENCES `message` (`MessageID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_usermessage_TO` FOREIGN KEY (`ToMessage`) REFERENCES `userinfo` (`USER_ID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `usermessagedependency` */

DROP TABLE IF EXISTS `usermessagedependency`;

CREATE TABLE `usermessagedependency` (
  `MessageID` bigint(20) NOT NULL,
  `PreviousThread` bigint(20) default NULL COMMENT '=1 means the MessageID is a new subject',
  `RootThread` bigint(20) NOT NULL,
  `NoofReplies` int(11) default NULL,
  PRIMARY KEY  (`MessageID`),
  KEY `FK_messagedependency_messageID` (`PreviousThread`),
  KEY `FK_messagedependency_root_Thread` (`RootThread`),
  CONSTRAINT `FK_messagedependency_MessageID` FOREIGN KEY (`MessageID`) REFERENCES `message` (`MessageID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_messagedependency_root_Thread` FOREIGN KEY (`RootThread`) REFERENCES `message` (`MessageID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usermessagedependency_ibfk_1` FOREIGN KEY (`PreviousThread`) REFERENCES `usermessagedependency` (`MessageID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `userproperty` */

DROP TABLE IF EXISTS `userproperty`;

CREATE TABLE `userproperty` (
  `userID` bigint(10) NOT NULL,
  `roleID` int(10) NOT NULL,
  `value` varchar(255) default NULL,
  `userProperty` int(10) NOT NULL auto_increment,
  PRIMARY KEY  (`userProperty`),
  KEY `FK_userproperty` (`roleID`),
  KEY `FK_userproperty_userID` (`userID`),
  CONSTRAINT `FK_userproperty_role` FOREIGN KEY (`roleID`) REFERENCES `role` (`roleID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_userproperty_userID` FOREIGN KEY (`userID`) REFERENCES `userinfo` (`USER_ID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `userrole` */

DROP TABLE IF EXISTS `userrole`;

CREATE TABLE `userrole` (
  `userID` bigint(10) NOT NULL COMMENT 'Foriegn Key',
  `roleID` int(10) NOT NULL COMMENT 'Foriegn Key',
  `userroleID` int(10) NOT NULL auto_increment,
  PRIMARY KEY  (`userroleID`),
  KEY `FK_userrole_role` (`roleID`),
  KEY `FK_userrole_userID` (`userID`),
  CONSTRAINT `FK_userrole_role` FOREIGN KEY (`roleID`) REFERENCES `role` (`roleID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_userrole_userID` FOREIGN KEY (`userID`) REFERENCES `userinfo` (`USER_ID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `usertouserlink` */

DROP TABLE IF EXISTS `usertouserlink`;

CREATE TABLE `usertouserlink` (
  `USER_LINK_SEQUENCE_ID` int(11) NOT NULL auto_increment,
  `USER_TO_USER_LINK_NAME` varchar(50) NOT NULL,
  PRIMARY KEY  (`USER_LINK_SEQUENCE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `usertousermapping` */

DROP TABLE IF EXISTS `usertousermapping`;

CREATE TABLE `usertousermapping` (
  `USER_MAPPING_SEQUNCE_ID` bigint(20) NOT NULL auto_increment,
  `USER_ID` bigint(20) NOT NULL,
  `MAPPED_USER_ID` bigint(20) NOT NULL,
  `RELATION_ID` int(11) NOT NULL,
  `MUTUAL` tinyint(1) NOT NULL, 
  `AFFINITY_CONSTANT` smallint(8) NOT NULL default '5',
  PRIMARY KEY  (`USER_MAPPING_SEQUNCE_ID`),
  UNIQUE KEY `UNIQUE_FRIENDS` (`USER_ID`,`MAPPED_USER_ID`),
  KEY `FK_usertousermapping` (`USER_ID`),
  KEY `FK_usertousermapping_mapped` (`MAPPED_USER_ID`),
  KEY `FK_usertousermapping_relation` (`RELATION_ID`),
  CONSTRAINT `usertousermapping_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `userinfo` (`USER_ID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usertousermapping_ibfk_2` FOREIGN KEY (`MAPPED_USER_ID`) REFERENCES `userinfo` (`USER_ID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usertousermapping_ibfk_3` FOREIGN KEY (`RELATION_ID`) REFERENCES `usertouserlink` (`USER_LINK_SEQUENCE_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `voteinfo` */

DROP TABLE IF EXISTS `voteinfo`;

CREATE TABLE `voteinfo` (
  `VOTE_ID` bigint(20) NOT NULL auto_increment,
  `TARGET_ID` bigint(20) NOT NULL,
  `TARGET_TYPE` smallint(6) NOT NULL default '1' COMMENT '1 content, 2 topic, 3 forums, 4 users',
  `USER_ID` bigint(20) NOT NULL,
  `TIME_STAMP` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `VOTE_TYPE` tinyint(1) NOT NULL default '1' COMMENT '1 means a positive vote',
  PRIMARY KEY  (`VOTE_ID`,`TARGET_ID`,`TARGET_TYPE`,`USER_ID`,`TIME_STAMP`,`VOTE_TYPE`),
  KEY `FK_voteinfo_user` (`USER_ID`),
  CONSTRAINT `voteinfo_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `userinfo` (`USER_ID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `urluser` (                                                                                                                           
`URL_USER_ID` bigint(20) NOT NULL auto_increment,
`URL_ID` bigint(20) NOT NULL,
`USER_ID` bigint(20) NOT NULL,
`SHARED_WITH_USER` bigint(20) default NULL,
`ATTACH_TYPE` int(8) NOT NULL default '1',
PRIMARY KEY  (`URL_USER_ID`),
UNIQUE KEY `URL_USER_ID_UNIQUE` (`URL_ID`,`USER_ID`,`ATTACH_TYPE`,`SHARED_WITH_USER`),
KEY `FK_urluser` (`USER_ID`),
KEY `FK_urluser_shared` (`SHARED_WITH_USER`),
CONSTRAINT `FK_urluser_shared` FOREIGN KEY (`SHARED_WITH_USER`) REFERENCES `userinfo` (`USER_ID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE,  
CONSTRAINT `urluser_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `userinfo` (`USER_ID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT `urluser_ibfk_2` FOREIGN KEY (`URL_ID`) REFERENCES `urlinfo` (`URL_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
		 
CREATE TABLE `usermapping` (                                                                                  
`user_id` bigint(20) NOT NULL,                                                                              
`archived_urls` text,                                                                                       
`last_modified` datetime default NULL,                                                                      
PRIMARY KEY  (`user_id`),                                                                                   
CONSTRAINT `FK_usermapping` FOREIGN KEY (`user_id`) REFERENCES `usermapping` (`user_id`) ON UPDATE CASCADE  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `summary` (                                     
`SUMMARY_SEQUENCE_ID` bigint(20) NOT NULL auto_increment,  
`ENTITY_ID` bigint(20) NOT NULL,                           
`ENTITY_TYPE` int(10) NOT NULL,                            
`SUMMARY_TEXT` mediumtext NOT NULL,                        
PRIMARY KEY  (`SUMMARY_SEQUENCE_ID`)                       
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
		 
		 
CREATE TABLE `deletefromindex` (                                    
`DELETE_SEQUENCE_ID` bigint(20) NOT NULL auto_increment,          
`SEMANTIC_PROFILE_ID` bigint(20) NOT NULL,                        
`PROFILE_TYPE` int(8) NOT NULL,                                   
PRIMARY KEY  (`DELETE_SEQUENCE_ID`),                              
UNIQUE KEY `profileindex` (`SEMANTIC_PROFILE_ID`,`PROFILE_TYPE`)  
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
		 
CREATE TABLE `profileinvites` (                                                                                                              
  `PROFILE_INVITE_ID` bigint(20) NOT NULL auto_increment,                                                                          
  `INVITE_ENTITY_ID` bigint(20) NOT NULL,                                                                                          
  `INVITE_ENTITY_TYPE` int(11) NOT NULL,                                                                                            
  `USER_ID` bigint(20) NOT NULL,
  `HAS_REJECTED` tinyint(4) NOT NULL,
  PRIMARY KEY  (`PROFILE_INVITE_ID`), 
  UNIQUE KEY `INVITES_UNIQUE` (`INVITE_ENTITY_ID`,`USER_ID`),   
  KEY `FK_boardinvites` (`INVITE_ENTITY_ID`),
  KEY `FK_boardinvites_user` (`USER_ID`),
  CONSTRAINT `profileinvites_ibfk_2` FOREIGN KEY (`USER_ID`) REFERENCES `userinfo` (`USER_ID_SEQUENCE`) ON DELETE CASCADE ON UPDATE CASCADE  
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
				
				
				
CREATE TABLE `dailydigest` (                                                                                  
`DailyDigest_ID` int(20) NOT NULL auto_increment,                                                           
`User_ID` int(10) default NULL,                                                                             
`Friends_ID` varchar(500) default NULL COMMENT 'These are friendIDs with each string seperated by comma.',  
`Board_ID` varchar(500) default NULL COMMENT 'These are boardIDs with each string seperated by comma',      
`Recommendations` int(1) NOT NULL default '0' COMMENT '0--> Yes ; 1--> No Recommendations',                 
PRIMARY KEY  (`DailyDigest_ID`)                                                                             
 ); 
 
 
 CREATE TRIGGER url_profile_trigger BEFORE UPDATE ON `meshprototype2`.`urlinfo`  FOR EACH ROW UPDATE `meshprototype2`.`semanticprofilestore` SET date_last_modified = NOW() WHERE semantic_profile_owner_id = OLD.url_id AND owner_type = (SELECT owner_type_id FROM semanticprofileownertypes WHERE OWNER_TYPE = 'URL');


CREATE TRIGGER board_profile_trigger BEFORE UPDATE ON `meshprototype2`.`boardinfo`  FOR EACH ROW UPDATE `meshprototype2`.`semanticprofilestore` SET date_last_modified = NOW() WHERE semantic_profile_owner_id = OLD.boardid_sequence AND owner_type = (SELECT owner_type_id FROM semanticprofileownertypes WHERE OWNER_TYPE = 'BOARD');


CREATE TRIGGER user_profile_trigger BEFORE UPDATE ON `meshprototype2`.`userinfo`  FOR EACH ROW UPDATE `meshprototype2`.`semanticprofilestore` SET date_last_modified = NOW() WHERE semantic_profile_owner_id = OLD.user_id_sequence AND owner_type = (SELECT owner_type_id FROM semanticprofileownertypes WHERE OWNER_TYPE = 'USER'); 


create index sem_modified on semanticprofilestore(DATE_LAST_MODIFIED);
create index url_modified on urlinfo(last_edit);
create index board_modified on boardinfo(LAST_MODIFIED_TIME);
create index user_modified on userinfo (last_edit);
