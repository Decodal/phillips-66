# ************************************************************
# Sequel Ace SQL dump
# Version 20021
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: 192.168.10.101 (MySQL 5.5.5-10.5.9-MariaDB-1:10.5.9+maria~focal)
# Database: base-craft-3
# Generation Time: 2022-01-10 13:56:43 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table cc1_announcements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_announcements`;

CREATE TABLE `cc1_announcements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `pluginId` int(11) DEFAULT NULL,
  `heading` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `unread` tinyint(1) NOT NULL DEFAULT 1,
  `dateRead` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cc1_idx_hakvaarjdnljzgxsntttdrsomxxhiosqkgui` (`userId`,`unread`,`dateRead`,`dateCreated`),
  KEY `cc1_idx_ekcjmclfocejjpkrykjtzhhegnkxzpksfmgy` (`dateRead`),
  KEY `cc1_fk_joinocixdvcyhlcbckpzlmqfzzcmdxbiobyb` (`pluginId`),
  CONSTRAINT `cc1_fk_joinocixdvcyhlcbckpzlmqfzzcmdxbiobyb` FOREIGN KEY (`pluginId`) REFERENCES `cc1_plugins` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_fk_rxwfiyyookaaijbvufuezovxmyjrawrohhtp` FOREIGN KEY (`userId`) REFERENCES `cc1_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_announcements` WRITE;
/*!40000 ALTER TABLE `cc1_announcements` DISABLE KEYS */;

INSERT INTO `cc1_announcements` (`id`, `userId`, `pluginId`, `heading`, `body`, `unread`, `dateRead`, `dateCreated`)
VALUES
	(1,17,NULL,'Editor Slideouts','Double-click entries and other editable elements to try the new editor slideout interface.',1,NULL,'2021-12-07 16:56:03'),
	(2,1,NULL,'Editor Slideouts','Double-click entries and other editable elements to try the new editor slideout interface.',0,'2021-12-08 15:31:37','2021-12-07 16:56:03'),
	(3,17,NULL,'Streamlined Entry Publishing Flow','The entry publishing workflow is now [simpler and more intuitive](https://craftcms.com/knowledge-base/editing-entries).',1,NULL,'2021-12-07 16:56:03'),
	(4,1,NULL,'Streamlined Entry Publishing Flow','The entry publishing workflow is now [simpler and more intuitive](https://craftcms.com/knowledge-base/editing-entries).',0,'2021-12-08 15:31:37','2021-12-07 16:56:03');

/*!40000 ALTER TABLE `cc1_announcements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_assetindexdata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_assetindexdata`;

CREATE TABLE `cc1_assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT 0,
  `completed` tinyint(1) DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `cc1_assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `cc1_assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `cc1_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_assets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_assets`;

CREATE TABLE `cc1_assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `uploaderId` int(11) DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_assets_folderId_idx` (`folderId`),
  KEY `cc1_assets_volumeId_idx` (`volumeId`),
  KEY `cc1_assets_volumeId_keptFile_idx` (`volumeId`,`keptFile`),
  KEY `cc1_assets_uploaderId_fk` (`uploaderId`),
  CONSTRAINT `cc1_assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `cc1_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_assets_id_fk` FOREIGN KEY (`id`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_assets_uploaderId_fk` FOREIGN KEY (`uploaderId`) REFERENCES `cc1_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cc1_assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `cc1_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_assettransformindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_assettransformindex`;

CREATE TABLE `cc1_assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT 0,
  `inProgress` tinyint(1) NOT NULL DEFAULT 0,
  `error` tinyint(1) NOT NULL DEFAULT 0,
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_assettransforms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_assettransforms`;

CREATE TABLE `cc1_assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_assettransforms_name_idx` (`name`),
  KEY `cc1_assettransforms_handle_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_categories`;

CREATE TABLE `cc1_categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_categories_groupId_idx` (`groupId`),
  KEY `cc1_categories_parentId_fk` (`parentId`),
  CONSTRAINT `cc1_categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `cc1_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_categories_id_fk` FOREIGN KEY (`id`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `cc1_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_categories` WRITE;
/*!40000 ALTER TABLE `cc1_categories` DISABLE KEYS */;

INSERT INTO `cc1_categories` (`id`, `groupId`, `parentId`, `deletedWithGroup`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,1,NULL,NULL,'2018-09-18 14:03:03','2018-09-18 14:03:03','4c418afd-a6d2-40ff-a3ef-213d58187aba'),
	(3,1,NULL,NULL,'2018-09-18 14:03:18','2018-09-18 14:03:18','0b481c17-35b0-425b-944e-2e38e279fe91'),
	(4,1,NULL,NULL,'2018-09-18 14:03:26','2018-09-18 14:03:26','2b5e410e-5b19-42c8-a8bb-0c0bfa5502aa');

/*!40000 ALTER TABLE `cc1_categories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_categorygroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_categorygroups`;

CREATE TABLE `cc1_categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `defaultPlacement` enum('beginning','end') NOT NULL DEFAULT 'end',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_categorygroups_structureId_idx` (`structureId`),
  KEY `cc1_categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `cc1_categorygroups_dateDeleted_idx` (`dateDeleted`),
  KEY `cc1_categorygroups_name_idx` (`name`),
  KEY `cc1_categorygroups_handle_idx` (`handle`),
  CONSTRAINT `cc1_categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `cc1_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cc1_categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `cc1_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_categorygroups` WRITE;
/*!40000 ALTER TABLE `cc1_categorygroups` DISABLE KEYS */;

INSERT INTO `cc1_categorygroups` (`id`, `structureId`, `fieldLayoutId`, `name`, `handle`, `defaultPlacement`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,1,7,'User Type','userType','end','2018-09-18 14:02:42','2018-09-18 14:02:42',NULL,'487681cb-7ad0-4313-b7f4-dd17bba6be08');

/*!40000 ALTER TABLE `cc1_categorygroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_categorygroups_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_categorygroups_sites`;

CREATE TABLE `cc1_categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `cc1_categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `cc1_categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `cc1_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `cc1_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `cc1_categorygroups_sites` DISABLE KEYS */;

INSERT INTO `cc1_categorygroups_sites` (`id`, `groupId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,1,'user-type/{slug}','user-type/_category','2018-09-18 14:02:42','2018-09-18 14:02:42','209362b5-877b-4e95-a9e6-005860c0b000');

/*!40000 ALTER TABLE `cc1_categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_changedattributes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_changedattributes`;

CREATE TABLE `cc1_changedattributes` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `cc1_changedattributes_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `cc1_changedattributes_siteId_fk` (`siteId`),
  KEY `cc1_changedattributes_userId_fk` (`userId`),
  CONSTRAINT `cc1_changedattributes_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cc1_changedattributes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `cc1_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cc1_changedattributes_userId_fk` FOREIGN KEY (`userId`) REFERENCES `cc1_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_changedattributes` WRITE;
/*!40000 ALTER TABLE `cc1_changedattributes` DISABLE KEYS */;

INSERT INTO `cc1_changedattributes` (`elementId`, `siteId`, `attribute`, `dateUpdated`, `propagated`, `userId`)
VALUES
	(42,1,'title','2020-08-18 08:40:21',0,1),
	(63,1,'slug','2020-08-18 08:40:22',0,1),
	(63,1,'title','2020-08-18 08:40:22',0,1);

/*!40000 ALTER TABLE `cc1_changedattributes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_changedfields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_changedfields`;

CREATE TABLE `cc1_changedfields` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `cc1_changedfields_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `cc1_changedfields_siteId_fk` (`siteId`),
  KEY `cc1_changedfields_fieldId_fk` (`fieldId`),
  KEY `cc1_changedfields_userId_fk` (`userId`),
  CONSTRAINT `cc1_changedfields_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cc1_changedfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `cc1_fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cc1_changedfields_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `cc1_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cc1_changedfields_userId_fk` FOREIGN KEY (`userId`) REFERENCES `cc1_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_changedfields` WRITE;
/*!40000 ALTER TABLE `cc1_changedfields` DISABLE KEYS */;

INSERT INTO `cc1_changedfields` (`elementId`, `siteId`, `fieldId`, `dateUpdated`, `propagated`, `userId`)
VALUES
	(6,1,1,'2021-02-16 16:48:35',0,17),
	(30,1,1,'2020-08-18 08:40:21',0,1),
	(30,1,26,'2020-08-18 08:40:21',0,1),
	(30,1,27,'2020-08-18 08:40:21',0,1),
	(43,1,1,'2020-08-18 08:40:22',0,1),
	(43,1,26,'2020-08-18 08:40:22',0,1),
	(43,1,27,'2020-08-18 08:40:22',0,1),
	(64,1,1,'2020-08-18 08:40:22',0,1),
	(64,1,26,'2020-08-18 08:40:22',0,1),
	(64,1,27,'2020-08-18 08:40:22',0,1),
	(137,1,1,'2020-08-18 08:40:24',0,1),
	(137,1,26,'2020-08-18 08:40:24',0,1),
	(137,1,27,'2020-08-18 08:40:24',0,1),
	(147,1,1,'2020-08-18 08:40:24',0,1),
	(147,1,26,'2020-08-18 08:40:24',0,1),
	(147,1,27,'2020-08-18 08:40:24',0,1),
	(152,1,1,'2020-08-18 08:40:24',0,1),
	(152,1,26,'2020-08-18 08:40:24',0,1),
	(152,1,27,'2020-08-18 08:40:24',0,1),
	(157,1,1,'2020-08-18 08:40:24',0,1),
	(157,1,26,'2020-08-18 08:40:24',0,1),
	(157,1,27,'2020-08-18 08:40:24',0,1),
	(162,1,1,'2020-08-18 08:40:25',0,1),
	(162,1,26,'2020-08-18 08:40:25',0,1),
	(162,1,27,'2020-08-18 08:40:25',0,1),
	(167,1,1,'2020-08-18 08:40:25',0,1),
	(167,1,26,'2020-08-18 08:40:25',0,1),
	(167,1,27,'2020-08-18 08:40:25',0,1),
	(172,1,1,'2020-08-18 08:40:25',0,1),
	(172,1,26,'2020-08-18 08:40:25',0,1),
	(172,1,27,'2020-08-18 08:40:25',0,1),
	(177,1,1,'2020-08-18 08:40:25',0,1),
	(177,1,26,'2020-08-18 08:40:25',0,1),
	(177,1,27,'2020-08-18 08:40:25',0,1),
	(182,1,1,'2020-08-18 08:40:25',0,1),
	(182,1,26,'2020-08-18 08:40:25',0,1),
	(182,1,27,'2020-08-18 08:40:25',0,1),
	(187,1,1,'2020-08-18 08:40:25',0,1),
	(187,1,26,'2020-08-18 08:40:25',0,1),
	(187,1,27,'2020-08-18 08:40:25',0,1),
	(192,1,1,'2020-08-18 08:40:26',0,1),
	(192,1,26,'2020-08-18 08:40:26',0,1),
	(192,1,27,'2020-08-18 08:40:26',0,1),
	(197,1,1,'2020-08-18 08:40:26',0,1),
	(197,1,26,'2020-08-18 08:40:26',0,1),
	(197,1,27,'2020-08-18 08:40:26',0,1),
	(208,1,1,'2020-08-18 08:40:26',0,1),
	(208,1,26,'2020-08-18 08:40:26',0,1),
	(208,1,27,'2020-08-18 08:40:26',0,1),
	(211,1,1,'2020-08-18 08:40:26',0,1),
	(211,1,26,'2020-08-18 08:40:26',0,1),
	(211,1,27,'2020-08-18 08:40:26',0,1),
	(216,1,1,'2020-08-18 08:40:27',0,1),
	(216,1,26,'2020-08-18 08:40:27',0,1),
	(216,1,27,'2020-08-18 08:40:27',0,1),
	(220,1,1,'2020-08-18 08:40:27',0,1),
	(220,1,26,'2020-08-18 08:40:27',0,1),
	(220,1,27,'2020-08-18 08:40:27',0,1),
	(225,1,1,'2020-08-18 08:40:27',0,1),
	(225,1,26,'2020-08-18 08:40:27',0,1),
	(225,1,27,'2020-08-18 08:40:27',0,1),
	(230,1,1,'2020-08-18 08:40:27',0,1),
	(230,1,26,'2020-08-18 08:40:27',0,1),
	(230,1,27,'2020-08-18 08:40:27',0,1),
	(235,1,1,'2020-08-18 08:40:27',0,1),
	(235,1,26,'2020-08-18 08:40:27',0,1),
	(235,1,27,'2020-08-18 08:40:27',0,1),
	(245,1,1,'2020-08-18 08:40:28',0,1),
	(245,1,26,'2020-08-18 08:40:28',0,1),
	(245,1,27,'2020-08-18 08:40:28',0,1),
	(249,1,1,'2020-08-18 08:40:28',0,1),
	(252,1,1,'2020-08-18 08:40:28',0,1);

/*!40000 ALTER TABLE `cc1_changedfields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_content
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_content`;

CREATE TABLE `cc1_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_metaTitle` text DEFAULT NULL,
  `field_metaDescription` text DEFAULT NULL,
  `field_metaRobots` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `cc1_content_siteId_idx` (`siteId`),
  KEY `cc1_content_title_idx` (`title`),
  CONSTRAINT `cc1_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `cc1_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_content` WRITE;
/*!40000 ALTER TABLE `cc1_content` DISABLE KEYS */;

INSERT INTO `cc1_content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`, `field_metaTitle`, `field_metaDescription`, `field_metaRobots`)
VALUES
	(1,1,1,NULL,'2018-06-08 15:06:11','2018-07-04 09:56:40','e614e50f-6038-4a08-a4ea-28863a94d4b8',NULL,NULL,NULL),
	(2,2,1,'Active','2018-09-18 14:03:03','2018-09-18 14:03:03','806f40fc-4cf4-48d0-952d-d5dc41668c3c',NULL,NULL,NULL),
	(3,3,1,'Deferred','2018-09-18 14:03:18','2018-09-18 14:03:18','66662de2-c6ea-4e57-8a4a-d9a4b0e16c33',NULL,NULL,NULL),
	(4,4,1,'Pensioner','2018-09-18 14:03:26','2018-09-18 14:03:26','29bda433-c3f6-4d9d-b264-728bd0e75308',NULL,NULL,NULL),
	(5,5,1,'Homepage','2018-09-18 14:24:27','2020-08-18 08:40:09','0f40e158-7618-44d4-9cfa-33757dd11906',NULL,NULL,NULL),
	(6,6,1,'Scheme information','2018-09-18 15:51:16','2021-02-16 16:48:34','62df02da-7ea9-48de-84a3-9588b6e5fa42',NULL,NULL,NULL),
	(7,8,1,'Lorem ipsum dolor sit amet','2018-09-19 10:43:18','2018-10-16 11:35:36','f88f83be-fefa-4360-abb5-a6b82b7e736f',NULL,NULL,NULL),
	(8,10,1,'Vestibulum posuere congue dui ac convallis','2018-09-19 10:52:50','2018-10-16 11:35:50','7d941c79-9674-4601-aa50-4390c234fc5f',NULL,NULL,NULL),
	(9,17,1,NULL,'2018-12-19 10:36:14','2018-12-19 10:51:47','63b93535-8c82-4814-83e9-6a7580e28b3a',NULL,NULL,NULL),
	(10,24,1,'This is an example of a complex block','2020-07-28 13:32:59','2020-07-28 13:48:00','1417c970-3eaf-4dfc-ae90-842b1dd605e5',NULL,NULL,NULL),
	(11,28,1,'Homepage','2020-08-18 08:40:09','2020-08-18 08:40:09','c74ece6b-a2ad-486c-9474-e28c91181278',NULL,NULL,NULL),
	(12,29,1,'Homepage','2020-08-18 08:40:09','2020-08-18 08:40:09','016300d1-68ae-40c0-b932-2d708d63b8bf',NULL,NULL,NULL),
	(13,30,1,'Scheme information','2020-08-18 08:40:20','2020-08-18 08:40:21','95127ea3-722b-4665-9f67-ce5262ca6ffd',NULL,NULL,NULL),
	(14,41,1,'This is an example of a complex block','2020-08-18 08:40:21','2020-08-18 08:40:21','2505d671-7381-41c5-b62e-ee71164a18d3',NULL,NULL,NULL),
	(15,42,1,'This complex block example has its own template, entry, and space for more fields','2020-08-18 08:40:21','2020-08-18 08:40:21','33e762e1-4bc8-491c-af1e-260c8d8d02ba',NULL,NULL,NULL),
	(16,43,1,'Scheme information','2020-08-18 08:40:21','2020-08-18 08:40:21','9160ef85-b10d-4ba0-8fe2-82893446d6e2',NULL,NULL,NULL),
	(17,63,1,'This complex bock has its own template, entry, and could easily have more fields than this title.','2020-08-18 08:40:22','2020-08-18 08:40:22','5989ef7e-6091-4760-bfa2-b28a18ec03d2',NULL,NULL,NULL),
	(18,64,1,'Scheme information','2020-08-18 08:40:22','2020-08-18 08:40:22','26be0691-9952-4db6-b328-f1d884b5a11d',NULL,NULL,NULL),
	(19,81,1,'Scheme information','2020-08-18 08:40:22','2020-08-18 08:40:22','132ab460-1bfd-46ce-adf4-cb85e7608d09',NULL,NULL,NULL),
	(20,89,1,'Scheme information','2020-08-18 08:40:22','2020-08-18 08:40:22','9ffc5528-d855-48a0-8ed6-8875689b3034',NULL,NULL,NULL),
	(21,97,1,'Scheme information','2020-08-18 08:40:22','2020-08-18 08:40:22','d7f1a8e1-ef96-4a9e-a5f8-7bf93d98c04c',NULL,NULL,NULL),
	(22,105,1,'Scheme information','2020-08-18 08:40:23','2020-08-18 08:40:23','513f5f9b-3936-4f14-9c93-b73e6d60408a',NULL,NULL,NULL),
	(23,113,1,'Scheme information','2020-08-18 08:40:23','2020-08-18 08:40:23','ecdbb579-bb1e-49b6-8081-dee25add2814',NULL,NULL,NULL),
	(24,121,1,'Scheme information','2020-08-18 08:40:23','2020-08-18 08:40:23','9973d3e6-6989-48df-8780-3717396c4d39',NULL,NULL,NULL),
	(25,129,1,'Scheme information','2020-08-18 08:40:23','2020-08-18 08:40:23','ed68ccde-b4d0-427d-be92-11758733f224',NULL,NULL,NULL),
	(26,137,1,'Scheme information','2020-08-18 08:40:23','2020-08-18 08:40:24','b9716dec-b264-4355-bedb-fc3e76776def',NULL,NULL,NULL),
	(27,147,1,'Scheme information','2020-08-18 08:40:24','2020-08-18 08:40:24','c4f08505-78fc-4f28-b81b-703879b0bd1e',NULL,NULL,NULL),
	(28,152,1,'Scheme information','2020-08-18 08:40:24','2020-08-18 08:40:24','55b69646-b63b-4a3f-a8a9-c07006e3b6a6',NULL,NULL,NULL),
	(29,157,1,'Scheme information','2020-08-18 08:40:24','2020-08-18 08:40:24','cb19ce5b-2f56-4cfd-8fd7-36cbd9b71b04',NULL,NULL,NULL),
	(30,162,1,'Scheme information','2020-08-18 08:40:24','2020-08-18 08:40:24','de493bda-c5bb-4dab-8e21-168f5454fdac',NULL,NULL,NULL),
	(31,167,1,'Scheme information','2020-08-18 08:40:25','2020-08-18 08:40:25','ac1e9f5e-126b-45ff-85c5-041d8eb72cab',NULL,NULL,NULL),
	(32,172,1,'Scheme information','2020-08-18 08:40:25','2020-08-18 08:40:25','623c80c3-abdc-47bf-ad81-9316d2150413',NULL,NULL,NULL),
	(33,177,1,'Scheme information','2020-08-18 08:40:25','2020-08-18 08:40:25','f7874bea-f34d-4cfc-8b5f-8b16fce66747',NULL,NULL,NULL),
	(34,182,1,'Scheme information','2020-08-18 08:40:25','2020-08-18 08:40:25','a05cad17-6853-454b-b7ba-503db460b070',NULL,NULL,NULL),
	(35,187,1,'Scheme information','2020-08-18 08:40:25','2020-08-18 08:40:25','80be36f7-6729-4958-be65-c4fcdc0086db',NULL,NULL,NULL),
	(36,192,1,'Scheme information','2020-08-18 08:40:25','2020-08-18 08:40:25','755e43a3-6f99-4630-b3a1-9e4a1835cc7d',NULL,NULL,NULL),
	(37,197,1,'Scheme information','2020-08-18 08:40:26','2020-08-18 08:40:26','b98f9f43-56c7-44af-a1a4-2478d427147f',NULL,NULL,NULL),
	(38,202,1,'Vestibulum posuere congue dui ac convallis','2020-08-18 08:40:26','2020-08-18 08:40:26','f274eb08-5e9c-4b83-82ae-8db7e82f602c',NULL,NULL,NULL),
	(39,208,1,'Lorem ipsum dolor sit amet','2020-08-18 08:40:26','2020-08-18 08:40:26','727ee2d1-b910-452a-8159-97e31d64fe45',NULL,NULL,NULL),
	(40,211,1,'Lorem ipsum dolor sit amet','2020-08-18 08:40:26','2020-08-18 08:40:26','49bb4889-7a9f-4f41-b7fa-aa3defb9388b',NULL,NULL,NULL),
	(41,216,1,'Scheme information','2020-08-18 08:40:26','2020-08-18 08:40:26','4a00dcc2-78dc-4f08-8ddc-9f7f4cb5624b',NULL,NULL,NULL),
	(42,220,1,'Lorem ipsum dolor sit amet','2020-08-18 08:40:27','2020-08-18 08:40:27','6d5fbc89-2381-4921-bfef-b379d6d41fa4',NULL,NULL,NULL),
	(43,225,1,'Lorem ipsum dolor sit amet','2020-08-18 08:40:27','2020-08-18 08:40:27','6ac39f7f-da6b-4bba-b472-9d1ddb613b67',NULL,NULL,NULL),
	(44,230,1,'Lorem ipsum dolor sit amet','2020-08-18 08:40:27','2020-08-18 08:40:27','de750d40-ed55-4659-bab1-5b66d971f13d',NULL,NULL,NULL),
	(45,235,1,'Vestibulum posuere congue dui ac convallis','2020-08-18 08:40:27','2020-08-18 08:40:27','e0f7d98e-bf8f-4626-ab4e-b2a5fcfed9df',NULL,NULL,NULL),
	(46,245,1,'Lorem ipsum dolor sit amet','2020-08-18 08:40:27','2020-08-18 08:40:27','ae4c29e5-fc02-4f72-ba82-6fa31d5cb5c0',NULL,NULL,NULL),
	(47,249,1,'Scheme information','2020-08-18 08:40:28','2020-08-18 08:40:28','ec5df377-8b40-4f95-a8ce-85029fa402d7',NULL,NULL,NULL),
	(48,252,1,'Scheme information','2020-08-18 08:40:28','2020-08-18 08:40:28','a9b161ea-fb3f-40fb-94a0-85d621920b96',NULL,NULL,NULL),
	(49,255,1,'Scheme information','2021-02-16 16:48:35','2021-02-16 16:48:35','ece447c7-ea78-42fe-8ee1-093209a82aaa',NULL,NULL,NULL);

/*!40000 ALTER TABLE `cc1_content` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_craftidtokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_craftidtokens`;

CREATE TABLE `cc1_craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `cc1_craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `cc1_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_deprecationerrors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_deprecationerrors`;

CREATE TABLE `cc1_deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` text DEFAULT NULL,
  `traces` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_deprecationerrors` WRITE;
/*!40000 ALTER TABLE `cc1_deprecationerrors` DISABLE KEYS */;

INSERT INTO `cc1_deprecationerrors` (`id`, `key`, `fingerprint`, `lastOccurrence`, `file`, `line`, `message`, `traces`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(548,'siteUrl','/home/vagrant/base-craft-3/vendor/yiisoft/yii2/base/BaseObject.php:109','2022-01-10 13:56:23','/home/vagrant/base-craft-3/vendor/yiisoft/yii2/base/BaseObject.php',109,'The `siteUrl` config setting has been deprecated. You can set your site’s Base URL setting on a per-environment basis using an alias or environment variable. See [Environmental Configuration](https://craftcms.com/docs/3.x/config/#environmental-configuration) for more info.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/home/vagrant/base-craft-3/vendor/craftcms/cms/src/config/GeneralConfig.php\",\"line\":1873,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"siteUrl\\\", \\\"The `siteUrl` config setting has been deprecated. You can set yo...\\\"\"},{\"objectClass\":\"craft\\\\config\\\\GeneralConfig\",\"file\":\"/home/vagrant/base-craft-3/vendor/yiisoft/yii2/base/BaseObject.php\",\"line\":109,\"class\":\"craft\\\\config\\\\GeneralConfig\",\"method\":\"init\",\"args\":null},{\"objectClass\":\"craft\\\\config\\\\GeneralConfig\",\"file\":\"/home/vagrant/base-craft-3/vendor/craftcms/cms/src/services/Config.php\",\"line\":101,\"class\":\"yii\\\\base\\\\BaseObject\",\"method\":\"__construct\",\"args\":\"[\\\"siteUrl\\\" => \\\"https://local.base-craft-3/\\\", \\\"defaultWeekStartDay\\\" => 0, \\\"enableCsrfProtection\\\" => true, \\\"omitScriptNameInUrls\\\" => true, ...]\"},{\"objectClass\":\"craft\\\\services\\\\Config\",\"file\":\"/home/vagrant/base-craft-3/vendor/craftcms/cms/src/services/Config.php\",\"line\":169,\"class\":\"craft\\\\services\\\\Config\",\"method\":\"getConfigSettings\",\"args\":\"\\\"general\\\"\"},{\"objectClass\":\"craft\\\\services\\\\Config\",\"file\":\"/home/vagrant/base-craft-3/vendor/craftcms/cms/src/helpers/App.php\",\"line\":769,\"class\":\"craft\\\\services\\\\Config\",\"method\":\"getGeneral\",\"args\":null},{\"objectClass\":null,\"file\":\"/home/vagrant/base-craft-3/vendor/craftcms/cms/src/config/app.web.php\",\"line\":11,\"class\":\"craft\\\\helpers\\\\App\",\"method\":\"webRequestConfig\",\"args\":null},{\"objectClass\":null,\"file\":null,\"line\":null,\"class\":null,\"method\":\"{closure}\",\"args\":null},{\"objectClass\":null,\"file\":\"/home/vagrant/base-craft-3/vendor/yiisoft/yii2/di/Container.php\",\"line\":634,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"Closure, []\"},{\"objectClass\":\"yii\\\\di\\\\Container\",\"file\":\"/home/vagrant/base-craft-3/vendor/yiisoft/yii2/BaseYii.php\",\"line\":349,\"class\":\"yii\\\\di\\\\Container\",\"method\":\"invoke\",\"args\":\"Closure, []\"},{\"objectClass\":null,\"file\":\"/home/vagrant/base-craft-3/vendor/yiisoft/yii2/di/ServiceLocator.php\",\"line\":137,\"class\":\"yii\\\\BaseYii\",\"method\":\"createObject\",\"args\":\"Closure\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/home/vagrant/base-craft-3/vendor/yiisoft/yii2/base/Module.php\",\"line\":748,\"class\":\"yii\\\\di\\\\ServiceLocator\",\"method\":\"get\",\"args\":\"\\\"request\\\", true\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/home/vagrant/base-craft-3/vendor/craftcms/cms/src/web/Application.php\",\"line\":337,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"get\",\"args\":\"\\\"request\\\", true\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/home/vagrant/base-craft-3/vendor/yiisoft/yii2/web/Application.php\",\"line\":161,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"get\",\"args\":\"\\\"request\\\"\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/home/vagrant/base-craft-3/vendor/craftcms/cms/src/base/ApplicationTrait.php\",\"line\":1452,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"getRequest\",\"args\":null},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/home/vagrant/base-craft-3/vendor/craftcms/cms/src/web/Application.php\",\"line\":90,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"_preInit\",\"args\":null},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/home/vagrant/base-craft-3/vendor/yiisoft/yii2/base/BaseObject.php\",\"line\":109,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"init\",\"args\":null},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/home/vagrant/base-craft-3/vendor/yiisoft/yii2/base/Application.php\",\"line\":212,\"class\":\"yii\\\\base\\\\BaseObject\",\"method\":\"__construct\",\"args\":\"[\\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"announcements\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Announcements\\\"], \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", \\\"name\\\" => \\\"Craft CMS\\\", ...]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":null,\"line\":null,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"__construct\",\"args\":\"[\\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"announcements\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Announcements\\\"], \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", \\\"name\\\" => \\\"Craft CMS\\\", ...]\"},{\"objectClass\":\"ReflectionClass\",\"file\":\"/home/vagrant/base-craft-3/vendor/yiisoft/yii2/di/Container.php\",\"line\":420,\"class\":\"ReflectionClass\",\"method\":\"newInstanceArgs\",\"args\":\"[[\\\"vendorPath\\\" => \\\"/home/vagrant/base-craft-3/vendor\\\", \\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"announcements\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Announcements\\\"], \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", ...]]\"},{\"objectClass\":\"yii\\\\di\\\\Container\",\"file\":\"/home/vagrant/base-craft-3/vendor/yiisoft/yii2/di/Container.php\",\"line\":171,\"class\":\"yii\\\\di\\\\Container\",\"method\":\"build\",\"args\":\"\\\"craft\\\\web\\\\Application\\\", [], [\\\"vendorPath\\\" => \\\"/home/vagrant/base-craft-3/vendor\\\", \\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"announcements\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Announcements\\\"], \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", ...]\"},{\"objectClass\":\"yii\\\\di\\\\Container\",\"file\":\"/home/vagrant/base-craft-3/vendor/yiisoft/yii2/BaseYii.php\",\"line\":365,\"class\":\"yii\\\\di\\\\Container\",\"method\":\"get\",\"args\":\"\\\"craft\\\\web\\\\Application\\\", [], [\\\"vendorPath\\\" => \\\"/home/vagrant/base-craft-3/vendor\\\", \\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"announcements\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Announcements\\\"], \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", ...]\"},{\"objectClass\":null,\"file\":\"/home/vagrant/base-craft-3/vendor/craftcms/cms/src/Craft.php\",\"line\":67,\"class\":\"yii\\\\BaseYii\",\"method\":\"createObject\",\"args\":\"[\\\"vendorPath\\\" => \\\"/home/vagrant/base-craft-3/vendor\\\", \\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"announcements\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Announcements\\\"], \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", ...], []\"},{\"objectClass\":null,\"file\":\"/home/vagrant/base-craft-3/vendor/craftcms/cms/bootstrap/bootstrap.php\",\"line\":242,\"class\":\"Craft\",\"method\":\"createObject\",\"args\":\"[\\\"vendorPath\\\" => \\\"/home/vagrant/base-craft-3/vendor\\\", \\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"announcements\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Announcements\\\"], \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", ...]\"},{\"objectClass\":null,\"file\":\"/home/vagrant/base-craft-3/vendor/craftcms/cms/bootstrap/web.php\",\"line\":51,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/home/vagrant/base-craft-3/vendor/craftcms/cms/bootstrap/bootstr...\\\"\"},{\"objectClass\":null,\"file\":\"/home/vagrant/base-craft-3/public/index.php\",\"line\":20,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/home/vagrant/base-craft-3/vendor/craftcms/cms/bootstrap/web.php\\\"\"}]','2022-01-10 13:56:23','2022-01-10 13:56:23','33ba7c6f-6350-43a4-a461-56abc27088e8');

/*!40000 ALTER TABLE `cc1_deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_drafts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_drafts`;

CREATE TABLE `cc1_drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `provisional` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  `trackChanges` tinyint(1) NOT NULL DEFAULT 0,
  `dateLastMerged` datetime DEFAULT NULL,
  `saved` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `cc1_drafts_sourceId_fk` (`sourceId`),
  KEY `cc1_drafts_creatorId_fk` (`creatorId`),
  KEY `cc1_idx_cntsduaittpblubgctfugeqvohbpbrbmbaog` (`saved`),
  KEY `cc1_idx_jauqzaazzfsmgfvogomqpugconnyekboapcv` (`creatorId`,`provisional`),
  CONSTRAINT `cc1_drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `cc1_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cc1_drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_elementindexsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_elementindexsettings`;

CREATE TABLE `cc1_elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_elements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_elements`;

CREATE TABLE `cc1_elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `canonicalId` int(11) DEFAULT NULL,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `archived` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateLastMerged` datetime DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `cc1_elements_type_idx` (`type`),
  KEY `cc1_elements_enabled_idx` (`enabled`),
  KEY `cc1_elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `cc1_elements_dateDeleted_idx` (`dateDeleted`),
  KEY `cc1_elements_draftId_fk` (`draftId`),
  KEY `cc1_elements_revisionId_fk` (`revisionId`),
  KEY `cc1_fk_btykqzfxiavmizcnjvwjxjpughslstmkxkab` (`canonicalId`),
  KEY `cc1_idx_zdnsmecuvejofnlavwqwlspgyxatdyjvhabr` (`archived`,`dateDeleted`,`draftId`,`revisionId`,`canonicalId`),
  CONSTRAINT `cc1_elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `cc1_drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `cc1_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cc1_elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `cc1_revisions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_fk_btykqzfxiavmizcnjvwjxjpughslstmkxkab` FOREIGN KEY (`canonicalId`) REFERENCES `cc1_elements` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_elements` WRITE;
/*!40000 ALTER TABLE `cc1_elements` DISABLE KEYS */;

INSERT INTO `cc1_elements` (`id`, `canonicalId`, `draftId`, `revisionId`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `dateLastMerged`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2018-06-08 15:06:11','2018-07-04 09:56:40',NULL,NULL,'ec21a52a-cd99-4186-b6f2-7eec8c806746'),
	(2,NULL,NULL,NULL,7,'craft\\elements\\Category',1,0,'2018-09-18 14:03:03','2018-09-18 14:03:03',NULL,NULL,'4ac0675e-d032-4fb1-baa9-c56af1b238cb'),
	(3,NULL,NULL,NULL,7,'craft\\elements\\Category',1,0,'2018-09-18 14:03:18','2018-09-18 14:03:18',NULL,NULL,'f7b0e7ef-c8b4-4c72-bf07-21b1af635be9'),
	(4,NULL,NULL,NULL,7,'craft\\elements\\Category',1,0,'2018-09-18 14:03:26','2018-09-18 14:03:26',NULL,NULL,'3a012609-86d8-409f-a053-00499483ee74'),
	(5,NULL,NULL,NULL,8,'craft\\elements\\Entry',1,0,'2018-09-18 14:24:27','2020-08-18 08:40:09',NULL,NULL,'001c4cb9-b81f-40fb-ab31-e42a100b069c'),
	(6,NULL,NULL,NULL,10,'craft\\elements\\Entry',1,0,'2018-09-18 15:51:16','2021-02-16 16:48:34',NULL,NULL,'7fb4ea35-bcea-4ff1-b0de-765579881404'),
	(7,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2018-09-18 15:54:03','2021-02-16 16:48:34',NULL,NULL,'c1e62da5-cf68-4e09-bb60-4a267b128949'),
	(8,NULL,NULL,NULL,10,'craft\\elements\\Entry',1,0,'2018-09-19 10:43:18','2018-10-16 11:35:36',NULL,NULL,'ba0ece93-d3f2-47eb-918c-ddc230721470'),
	(9,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2018-09-19 10:43:18','2018-10-16 11:35:36',NULL,NULL,'3c40a9ce-8e76-48ce-bf06-fc57c4e80334'),
	(10,NULL,NULL,NULL,10,'craft\\elements\\Entry',1,0,'2018-09-19 10:52:50','2018-10-16 11:35:50',NULL,NULL,'63ddca00-a3f5-4cb7-9614-c9be03684573'),
	(11,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2018-09-19 10:52:51','2018-10-16 11:35:50',NULL,NULL,'a2e05047-b667-4b06-b00b-c9f2a3f38c0f'),
	(12,NULL,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2018-09-19 10:52:51','2018-10-16 11:35:50',NULL,NULL,'d954413d-0053-4930-a13c-1be0db1c1b36'),
	(13,NULL,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2018-09-19 10:52:51','2018-10-16 11:35:50',NULL,'2021-02-16 16:08:17','632e3beb-520a-4601-a5d8-ea9fac7a8dc6'),
	(14,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2018-09-19 10:52:51','2018-10-16 11:35:50',NULL,NULL,'0af44e43-2e85-423f-b1ad-503a025c22a1'),
	(15,NULL,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2018-09-19 10:52:51','2018-10-16 11:35:50',NULL,NULL,'7fd52dc3-a0b0-42f1-8091-1e4805bffe5a'),
	(16,NULL,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2018-09-20 14:53:50','2018-10-16 11:35:36',NULL,NULL,'a6b68ab4-0091-4f62-bce1-8be6809d51a2'),
	(17,NULL,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2018-12-19 10:36:14','2018-12-19 10:51:47',NULL,NULL,'1ada1eba-1c56-4e56-8a21-4eb8915f604a'),
	(18,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2019-03-20 09:18:13','2020-07-28 14:04:06',NULL,'2021-02-16 16:08:18','65646ef1-077b-4436-971c-65b0ac34cae7'),
	(19,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2019-06-18 09:32:13','2021-02-16 16:48:34',NULL,NULL,'131fc705-9e2a-45a9-af84-3aac069f9213'),
	(20,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2019-06-18 09:32:13','2021-02-16 16:48:35',NULL,NULL,'375d3dc7-0def-4523-b935-c83a8116a680'),
	(21,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2019-06-18 09:35:18','2021-02-16 16:48:34',NULL,NULL,'3c20c9ca-f835-4e42-abec-0f6472f66f84'),
	(22,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2019-06-18 09:35:18','2021-02-16 16:48:34',NULL,NULL,'bf6fdc60-60a5-4771-9c61-34223e43302b'),
	(23,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2019-06-18 09:37:35','2021-02-16 16:48:34',NULL,NULL,'38321f7a-42b7-4009-be2a-29642f6e6b76'),
	(24,NULL,NULL,NULL,18,'craft\\elements\\Entry',1,0,'2020-07-28 13:32:59','2020-07-28 13:48:00',NULL,NULL,'ac75931d-365d-4708-8ef3-8e246462f961'),
	(25,NULL,NULL,NULL,13,'craft\\elements\\MatrixBlock',1,0,'2020-07-28 13:34:03','2021-02-16 16:48:35',NULL,NULL,'1ca7858f-0c21-4d0d-bdf3-d0538714d84f'),
	(26,NULL,NULL,NULL,17,'craft\\elements\\MatrixBlock',1,0,'2020-07-28 13:34:03','2021-02-16 16:48:35',NULL,NULL,'ca5e024c-20ae-4b38-b076-bb66664e91eb'),
	(27,NULL,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2020-07-28 14:04:06','2021-02-16 16:48:34',NULL,NULL,'e04ad7a7-473d-49ce-aed0-d08190768762'),
	(28,5,NULL,1,8,'craft\\elements\\Entry',1,0,'2018-09-18 14:25:58','2018-09-18 14:25:58',NULL,NULL,'567003ff-7d13-43fe-acd9-a29a14502310'),
	(29,5,NULL,2,8,'craft\\elements\\Entry',1,0,'2020-08-18 08:40:09','2020-08-18 08:40:09',NULL,NULL,'d6b8ddbf-ce11-4482-a7f7-23fd60823784'),
	(30,6,NULL,3,10,'craft\\elements\\Entry',1,0,'2020-07-28 14:04:07','2020-08-18 08:40:21',NULL,NULL,'6cc63163-deac-43c6-a633-0c687df8261c'),
	(31,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:20','2020-08-18 08:40:21',NULL,NULL,'69047e4b-4d9f-4063-9cb6-0a8df4da90cc'),
	(32,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,NULL,'cd3e0c9d-e7c8-4ff5-aa8d-c3a88e8be025'),
	(33,NULL,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,NULL,'73d29342-30f1-4877-b5ba-e8a1383386d5'),
	(34,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,NULL,'c4d463ed-9ebf-4f24-bec1-b64309822dee'),
	(35,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,NULL,'80cc9acf-06cd-4a91-b283-ae97c53ec44d'),
	(36,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,NULL,'1e1d80df-16f9-42f0-959d-74381c20ff6b'),
	(37,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,NULL,'dd10f745-10cb-41e4-a2b9-a3d686d07aff'),
	(38,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,NULL,'8f2edba5-91dc-4301-8b43-07a32e2a5c66'),
	(39,NULL,NULL,NULL,13,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,NULL,'5b722dec-9333-4f21-b783-f6c73b2b41aa'),
	(40,NULL,NULL,NULL,17,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,NULL,'17aefb4e-d105-4ca8-865d-0cd483ea6b89'),
	(41,24,NULL,4,18,'craft\\elements\\Entry',1,0,'2020-07-28 13:48:00','2020-08-18 08:40:21',NULL,NULL,'1bcc9292-9904-4c17-b882-6a8a2a4b2979'),
	(42,24,NULL,5,18,'craft\\elements\\Entry',1,0,'2020-07-28 13:34:40','2020-08-18 08:40:21',NULL,NULL,'be9abd8d-33a1-4ca8-a21c-72372af26d7c'),
	(43,6,NULL,6,10,'craft\\elements\\Entry',1,0,'2020-07-28 13:34:03','2020-08-18 08:40:21',NULL,NULL,'6a46cc8a-ef48-4b39-b3ae-34ef5d1430bf'),
	(44,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:21','4485c061-70ec-4ea5-8fc3-ca820a80e0d2'),
	(45,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:21','f1209a00-9d84-4118-ae8f-a397c9aeb04f'),
	(46,NULL,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:21','49c9892f-42fe-4625-adb3-ef24ab85d22b'),
	(47,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:21','5b924aa2-1287-4d94-a105-2db3bb03316a'),
	(48,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:21','cc0fff0a-686b-4f00-823e-5c3b2b813665'),
	(49,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:21','02c9cb51-d93e-41e8-9a67-0d2ece25fa6e'),
	(50,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:21','4577153b-299a-4103-9640-bce61030851c'),
	(51,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:21','026ed016-6e16-442e-8982-aa275330ac76'),
	(52,NULL,NULL,NULL,13,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:22','0382847a-dce0-4359-9b19-05410c61de73'),
	(53,NULL,NULL,NULL,17,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:22','d3ea7bd6-e9d7-41ed-87bb-0defdcbacf30'),
	(54,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,NULL,'fab1ea1a-00d5-4990-a085-f09a6ffb743b'),
	(55,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,NULL,'da412c5c-3cd4-436d-95d5-b67f8c259935'),
	(56,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,NULL,'110c3b3a-5d50-4c4f-b3eb-a294d1cd6ad6'),
	(57,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,NULL,'f3ccae83-394b-4725-965d-629c8a6a32b5'),
	(58,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,NULL,'807ff611-d2f6-430f-ae02-84ad7970d4f6'),
	(59,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,NULL,'26ef58df-d238-4925-a303-cbbd8c679a4a'),
	(60,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,NULL,'3cec8d75-39cb-408d-bbe9-07b00fbbe929'),
	(61,NULL,NULL,NULL,13,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,NULL,'e34667fe-9e4e-467a-b528-6504e42117f1'),
	(62,NULL,NULL,NULL,17,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21',NULL,NULL,'60ddb2ce-d883-4a76-9290-b1aedbdacd59'),
	(63,24,NULL,7,18,'craft\\elements\\Entry',1,0,'2020-07-28 13:32:59','2020-08-18 08:40:22',NULL,NULL,'9a10c577-b41b-4468-9976-9ff153253472'),
	(64,6,NULL,8,10,'craft\\elements\\Entry',1,0,'2020-07-28 13:26:19','2020-08-18 08:40:22',NULL,NULL,'a98ff6db-ad70-4a37-a57f-fcce3d797a13'),
	(65,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:22','5e5df917-2b52-4df5-b329-bfcd230e796a'),
	(66,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:22','62c85488-a759-4a0e-a254-79aedf286939'),
	(67,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:22','ee57fd64-871c-4e11-b5d8-559ba60ca5b5'),
	(68,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:22','90a169b6-6814-47e1-94a1-b136e42dff41'),
	(69,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:22','567ca3c6-cf9e-4dbd-8b47-4f11b8f9d935'),
	(70,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:22','8028613e-ee1e-4ee4-8e9a-6cf9100a0e76'),
	(71,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:22','4b4052e1-e7ac-45cd-ac86-2374c2056c15'),
	(72,NULL,NULL,NULL,13,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:22','75943e08-f79a-49a3-94e4-7ee49061312c'),
	(73,NULL,NULL,NULL,17,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:21',NULL,'2020-08-18 08:40:22','40a03d10-b0a0-4433-be41-a8c76f1b1582'),
	(74,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'d37f7957-9147-485f-b7a5-dbcfe30706eb'),
	(75,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'25eed32d-c58b-4ba5-8c12-78f6f66a8946'),
	(76,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'c7a0bf9b-5593-436f-9300-ba772f3c35da'),
	(77,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'245c618a-6be1-4a6d-a72d-6d24117db4a1'),
	(78,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'8813a221-9933-458c-9fc1-78b9892f2f39'),
	(79,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'a238aa68-1c4a-48d9-8a1e-1ab94384fb20'),
	(80,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'caf7cfee-4ef5-43e1-894e-9d63ea3a6cbd'),
	(81,6,NULL,9,10,'craft\\elements\\Entry',1,0,'2019-06-18 09:54:02','2020-07-28 14:04:06',NULL,NULL,'a19ebc0a-d54c-41a8-b6ee-2321122f38d8'),
	(82,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'4bee9da1-1705-48fd-8636-2986e425fa23'),
	(83,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'9c1a555a-a67a-4919-a5a3-0c7befcb7519'),
	(84,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'05f35afd-d230-4db8-91ad-e461578f1a79'),
	(85,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'f715feb6-9f3a-410a-a054-cf7146658bce'),
	(86,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'924a9f2e-aa10-4838-81a2-e3dd9c038f69'),
	(87,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'391f294f-15b8-4255-bfa4-18bb14d4d406'),
	(88,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'6438c54d-2b85-4fbc-9054-2e1580a8dd98'),
	(89,6,NULL,10,10,'craft\\elements\\Entry',1,0,'2019-06-18 09:52:55','2020-07-28 14:04:06',NULL,NULL,'d1840b13-6000-462d-9f40-208e20154230'),
	(90,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'611565d7-31eb-4b04-836e-85c9e39f0da7'),
	(91,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'63613a7d-7739-422e-89d6-667a89118c84'),
	(92,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'095295e5-9869-4539-a52b-d71bc016b074'),
	(93,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'5e3a10f3-cbdc-4222-98b3-19f03c49e33e'),
	(94,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'2f7e158b-f10f-4f37-bb5f-15477a74f4a2'),
	(95,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'adb9f8df-0efa-4187-95e9-9b49062538a7'),
	(96,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'15ce805d-830c-4411-9d44-e74c287f4013'),
	(97,6,NULL,11,10,'craft\\elements\\Entry',1,0,'2019-06-18 09:38:48','2020-07-28 14:04:06',NULL,NULL,'2cb86f61-c50d-4da3-ace0-8482c2a34653'),
	(98,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'9d103001-57cb-4889-8a67-4d7587ce9663'),
	(99,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'6da3a773-e4fd-45af-b296-82aae6ad2448'),
	(100,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'e7097e89-ca9d-4bf2-b524-2f51b3f79297'),
	(101,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22',NULL,NULL,'2df636ef-0ed1-4989-8d7e-5e90605a3c3d'),
	(102,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'85532d3a-785c-48cd-9912-c38971dbf646'),
	(103,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'fa5fb4a7-a901-453d-87b5-27b831d185d8'),
	(104,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'0f461a03-04a6-461e-b643-dcd537a7407e'),
	(105,6,NULL,12,10,'craft\\elements\\Entry',1,0,'2019-06-18 09:37:35','2020-07-28 14:04:06',NULL,NULL,'cd21b3c2-211d-496a-8f06-35822b2609d9'),
	(106,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'ecaeebda-9684-4f0f-a503-be35e37a7549'),
	(107,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'a0a0358a-d98a-46d5-9ef3-07c3c70aaec2'),
	(108,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'1f4db167-c61a-4640-96ea-2184d432443c'),
	(109,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'012ec09e-80de-4603-a5ca-d267a9b80abf'),
	(110,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'f53112ca-1ec9-4a6e-980b-1c4238e44a85'),
	(111,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'21295c85-fe62-49bc-9eda-d5904b236f51'),
	(112,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'deff20a8-a53f-4ab1-910c-891256d827ae'),
	(113,6,NULL,13,10,'craft\\elements\\Entry',1,0,'2019-06-18 09:35:18','2020-07-28 14:04:06',NULL,NULL,'7b542f53-a3c1-406d-9973-89df242fbcdf'),
	(114,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'966188c3-404e-46d1-ba7b-4d8c78d66dbd'),
	(115,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'8dfc3cf8-4121-4886-a8bc-90f4c99d2c64'),
	(116,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'6fb6cb72-bed3-493c-a97a-5e08c89185ea'),
	(117,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'35a227a8-6565-4fe7-86a6-33bbb74e0701'),
	(118,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'a61ac697-b762-4a53-a3b9-35684e1cf8c1'),
	(119,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'f1dcdcec-f07f-457c-9391-5d2af9481ff5'),
	(120,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'42ee8415-b1c5-40d9-b813-3efcc30998af'),
	(121,6,NULL,14,10,'craft\\elements\\Entry',1,0,'2019-06-18 09:32:14','2020-07-28 14:04:06',NULL,NULL,'02356c5a-e7ef-4d60-bf9b-454fed2392c7'),
	(122,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'951a23c4-42e5-455e-8fbc-d218d8604422'),
	(123,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'ef99389a-d403-416a-9586-148ae535ea6d'),
	(124,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'a4816e23-e9a7-477a-a67a-aa8c8dfec155'),
	(125,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'fb0b4c5e-c9d0-4dc5-a6b3-7740508385c1'),
	(126,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'4e168e76-09b4-4daf-bfa8-fcd201d9c191'),
	(127,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'41285355-c01a-4598-b6bf-ebc40084735e'),
	(128,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'14dcc235-c863-4f9e-bd9a-b125409c1318'),
	(129,6,NULL,15,10,'craft\\elements\\Entry',1,0,'2019-03-20 14:32:11','2020-07-28 14:04:06',NULL,NULL,'60aa28e2-56ee-4eab-bd05-9408474a633d'),
	(130,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'b73c887f-b584-43ca-9b1b-62b4b5afaba2'),
	(131,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'a8baf09d-39e4-4e3c-bdbf-4ff9a6ef9168'),
	(132,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'51bf891f-60bd-4df8-8b4d-cc87a9584e58'),
	(133,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'24776234-e9bc-45a0-a97a-abe7f71b3609'),
	(134,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'c5a400ab-e4e7-4f76-a239-9b45be8db379'),
	(135,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'7e6a98ae-ea9a-416d-b6c6-aa4802a5515d'),
	(136,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,NULL,'350bf052-3097-471c-95c9-42857874d98a'),
	(137,6,NULL,16,10,'craft\\elements\\Entry',1,0,'2019-03-20 14:28:06','2020-08-18 08:40:24',NULL,'2021-02-16 16:41:54','013b3ff7-44d2-4c32-a0cd-def832970aa6'),
	(138,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,'2020-08-18 08:40:24','b02b67e6-c727-4f17-ae28-eeff152066c6'),
	(139,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,'2020-08-18 08:40:24','f6d27afe-ca4a-4c30-9c03-ee8e0c8f8402'),
	(140,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:23','2020-08-18 08:40:22',NULL,'2020-08-18 08:40:24','67f3a6f2-7829-4732-9ec5-ff2f6bc7621f'),
	(141,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:22',NULL,'2020-08-18 08:40:24','6b5959af-e1a4-4cc3-8f87-fb5a3e74ce7c'),
	(142,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:22',NULL,'2020-08-18 08:40:24','a377c243-8942-435d-9985-644ad920c58c'),
	(143,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:22',NULL,'2020-08-18 08:40:24','40e03582-f0fe-493d-94e0-0d6ac3f220a6'),
	(144,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:22',NULL,'2020-08-18 08:40:24','4b34a906-4e27-4174-a322-4f1daa5414de'),
	(145,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24',NULL,NULL,'dba3f031-58b8-416f-9833-37abcb9311da'),
	(146,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24',NULL,NULL,'de347597-b3a3-48ed-adc7-4249d6b7a716'),
	(147,6,NULL,17,10,'craft\\elements\\Entry',1,0,'2019-03-20 13:57:27','2020-08-18 08:40:24',NULL,NULL,'6653f5ee-996c-4564-8099-b4f26cf780f3'),
	(148,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24',NULL,'2020-08-18 08:40:24','c95d3f92-a09b-4416-8734-44d18cfecee9'),
	(149,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24',NULL,'2020-08-18 08:40:24','2c04d660-dde9-466e-9539-2ca765c3171f'),
	(150,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24',NULL,NULL,'3f2eba6a-ca2c-478e-b4a6-5cf8cc03a053'),
	(151,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24',NULL,NULL,'4327df7d-702b-43a7-99a7-c5002711fd39'),
	(152,6,NULL,18,10,'craft\\elements\\Entry',1,0,'2019-03-20 13:57:03','2020-08-18 08:40:24',NULL,NULL,'91dc35b8-7b08-4dfe-b594-6ea5ad3a620d'),
	(153,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24',NULL,'2020-08-18 08:40:24','62a2c9b9-7863-4942-aaf5-38f7c984fae6'),
	(154,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24',NULL,'2020-08-18 08:40:24','d779f128-cdfa-498f-b50e-edb26d5f0ea0'),
	(155,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24',NULL,NULL,'c56d5ef2-fd89-4228-8de9-1bf487aea16a'),
	(156,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24',NULL,NULL,'81133ecd-2b93-4a85-9229-618948bf68a8'),
	(157,6,NULL,19,10,'craft\\elements\\Entry',1,0,'2019-03-20 13:56:38','2020-08-18 08:40:24',NULL,NULL,'ddee54f8-9746-42ee-a0d7-bf2058c2acb9'),
	(158,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24',NULL,'2020-08-18 08:40:24','542fc5dd-a56e-4ba5-8a6d-5709a34b2c6d'),
	(159,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24',NULL,'2020-08-18 08:40:24','5787f957-6f4c-45a1-afe0-4be48659411a'),
	(160,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24',NULL,NULL,'6a530160-296a-4d39-8a82-460f169a58ca'),
	(161,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24',NULL,NULL,'b0193c04-0f7e-498d-8ba1-51eab666e6f3'),
	(162,6,NULL,20,10,'craft\\elements\\Entry',1,0,'2019-03-20 11:02:35','2020-08-18 08:40:24',NULL,NULL,'27b31390-f492-4e75-9a43-6de4fa84bdd5'),
	(163,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24',NULL,'2020-08-18 08:40:25','bbb2650b-9469-4bd5-91c2-1d9f45c6c906'),
	(164,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24',NULL,'2020-08-18 08:40:25','e6321e3c-9d8a-4a6a-9ed6-e8e9a12d4e4d'),
	(165,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24',NULL,NULL,'e3c56904-b5de-4727-86ad-f034eb7f47d6'),
	(166,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24',NULL,NULL,'b981f08a-d4c4-40f9-9c3c-eeed2650d06c'),
	(167,6,NULL,21,10,'craft\\elements\\Entry',1,0,'2019-03-20 10:58:56','2020-08-18 08:40:25',NULL,NULL,'e8bb680f-3976-4516-9e51-adbf05ee4b5f'),
	(168,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:24',NULL,'2020-08-18 08:40:25','69e57845-961a-4686-b540-77f6abc523bc'),
	(169,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:24',NULL,'2020-08-18 08:40:25','f952c4ca-2229-4203-8302-3f62f3bdebb4'),
	(170,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,NULL,'9ba7b460-4a45-430c-afd0-07f8c9f1dbe3'),
	(171,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,NULL,'b9756613-d808-434d-882f-c09b6dda65c6'),
	(172,6,NULL,22,10,'craft\\elements\\Entry',1,0,'2019-03-20 10:45:12','2020-08-18 08:40:25',NULL,NULL,'f8b99657-35b2-4df7-b79b-44ad34784421'),
	(173,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,'2020-08-18 08:40:25','162257c1-37d2-42e9-b508-2c6a3e2fe973'),
	(174,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,'2020-08-18 08:40:25','1b605028-2071-498a-bb2d-86e4bef019f1'),
	(175,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,NULL,'933b0a8e-eb9f-4131-b91b-da892abf73a4'),
	(176,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,NULL,'f36b4e6b-d540-4f6b-8fb9-5372ec7d085f'),
	(177,6,NULL,23,10,'craft\\elements\\Entry',1,0,'2019-03-20 10:39:20','2020-08-18 08:40:25',NULL,NULL,'2ef65c48-df08-4fd2-a1a9-26bbe10c15ed'),
	(178,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,'2020-08-18 08:40:25','f7f17fd0-49a0-45c3-b701-f061ec48b648'),
	(179,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,'2020-08-18 08:40:25','50248eba-a359-42e7-b58a-cf520e369c31'),
	(180,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,NULL,'22f88468-5768-4640-8c1a-9f9a244c2aaf'),
	(181,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,NULL,'9bccbd38-b4e7-4784-ace8-cd045973be64'),
	(182,6,NULL,24,10,'craft\\elements\\Entry',1,0,'2019-03-20 10:03:28','2020-08-18 08:40:25',NULL,NULL,'5194dd36-b0ac-46ab-b4f9-0433ac851d25'),
	(183,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,'2020-08-18 08:40:25','a23e221c-afcb-449c-9a3e-df912ae6a6e4'),
	(184,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,'2020-08-18 08:40:25','4121a596-473a-4cea-851c-d5e6adf0160d'),
	(185,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,NULL,'abcdd488-cbd5-4706-9fec-c89d5aad8a06'),
	(186,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,NULL,'49104095-b0dd-4f6c-a0b5-b3e1d811a60b'),
	(187,6,NULL,25,10,'craft\\elements\\Entry',1,0,'2019-03-20 10:02:56','2020-08-18 08:40:25',NULL,NULL,'aad563fc-b36f-4c6c-8988-1afd8d6a9532'),
	(188,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,'2020-08-18 08:40:25','e66508d2-7100-45de-b021-1191f962882f'),
	(189,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,'2020-08-18 08:40:25','5dc00e30-34d8-45b3-8c08-30f593a6d609'),
	(190,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,NULL,'2f5c5fb6-f475-4a46-8cb6-700ca5288d7e'),
	(191,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,NULL,'42bf4da8-f8b1-45d2-8f60-0ec1dd97330d'),
	(192,6,NULL,26,10,'craft\\elements\\Entry',1,0,'2019-03-20 10:02:38','2020-08-18 08:40:25',NULL,NULL,'2f7a1397-984f-4887-85cf-c9806ace6244'),
	(193,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,'2020-08-18 08:40:26','d1823591-bef8-4bb8-815b-d282c0a46389'),
	(194,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25',NULL,'2020-08-18 08:40:26','db066e68-cc35-4597-b89d-4f39f3174eb3'),
	(195,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2020-08-18 08:40:26',NULL,NULL,'c801b17e-329f-4f29-ae9f-392f84a5cda6'),
	(196,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2020-08-18 08:40:26',NULL,NULL,'8efb0638-9376-41ce-ab0b-2d94ca8bd74d'),
	(197,6,NULL,27,10,'craft\\elements\\Entry',1,0,'2019-03-20 09:18:13','2020-08-18 08:40:26',NULL,NULL,'028c2654-c317-4525-a979-adbb86bd4113'),
	(198,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2020-08-18 08:40:26',NULL,'2020-08-18 08:40:26','3326ff07-53de-4925-845e-aed1293a591c'),
	(199,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2020-08-18 08:40:26',NULL,'2020-08-18 08:40:26','1d421061-34fd-49ab-becf-8baf2cf6e450'),
	(200,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2020-08-18 08:40:26',NULL,NULL,'1b66c263-ffc4-4523-b775-00792458bd5f'),
	(201,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2020-08-18 08:40:26',NULL,NULL,'cbe992a3-1943-49a3-97a7-a9fc3dda5e74'),
	(202,10,NULL,28,10,'craft\\elements\\Entry',1,0,'2018-10-16 11:35:50','2018-10-16 11:35:50',NULL,NULL,'56921c45-b28b-41c5-b439-7167edb8a9fd'),
	(203,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2018-10-16 11:35:50',NULL,NULL,'3532bfe5-738a-49a2-b5a1-e68ddd4ed32c'),
	(204,NULL,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2018-10-16 11:35:50',NULL,NULL,'44564630-fd98-40fd-8a58-248acfcc6fbb'),
	(205,NULL,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2018-10-16 11:35:50',NULL,NULL,'77682f60-ac95-4076-b367-efc798268e94'),
	(206,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2018-10-16 11:35:50',NULL,NULL,'0435a303-c434-4a3a-9446-91ee63a5dfe9'),
	(207,NULL,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2018-10-16 11:35:50',NULL,NULL,'23f36918-ed7a-4c32-81bc-657088a988af'),
	(208,8,NULL,29,10,'craft\\elements\\Entry',1,0,'2018-10-16 11:35:36','2020-08-18 08:40:26',NULL,NULL,'a2ee8008-207b-411f-8b8b-069f60388271'),
	(209,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2020-08-18 08:40:26',NULL,NULL,'ca4bdfa0-bd11-4982-854a-77aa68bc1309'),
	(210,NULL,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2020-08-18 08:40:26',NULL,NULL,'e9a3ace2-ba7e-432c-a1ca-799d29118359'),
	(211,8,NULL,30,10,'craft\\elements\\Entry',1,0,'2018-10-16 11:35:30','2020-08-18 08:40:26',NULL,NULL,'706d8cb3-341b-4b67-9c05-a21e720dfcfc'),
	(212,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2020-08-18 08:40:26',NULL,'2020-08-18 08:40:26','26698716-9d3b-4f03-91f9-8010ab0d56cc'),
	(213,NULL,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2020-08-18 08:40:26',NULL,'2020-08-18 08:40:26','df9e3040-5ea4-4cb9-ad8a-a9e56cd76a73'),
	(214,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2020-08-18 08:40:26',NULL,NULL,'18ed2fc5-b95c-4b0f-9a52-6a70a0f9c08e'),
	(215,NULL,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2020-08-18 08:40:26',NULL,NULL,'cc6656d1-006c-4de6-8eae-0d8c738e486f'),
	(216,6,NULL,31,10,'craft\\elements\\Entry',1,0,'2018-10-16 11:21:26','2020-08-18 08:40:26',NULL,NULL,'3fd1a767-6768-4212-8059-58f7d65294c5'),
	(217,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2020-08-18 08:40:26',NULL,'2020-08-18 08:40:27','60afd59a-f568-45ef-a32a-f994b2418088'),
	(218,NULL,NULL,NULL,14,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2020-08-18 08:40:26',NULL,'2020-08-18 08:40:27','5b49c7f7-8ae5-4d92-b01b-a8634582b965'),
	(219,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:26','2020-08-18 08:40:26',NULL,NULL,'5d759221-74e0-4cf9-b251-14e6701786fd'),
	(220,8,NULL,32,10,'craft\\elements\\Entry',1,0,'2018-09-20 15:09:37','2020-08-18 08:40:27',NULL,NULL,'d5f5c3bc-4a13-443e-9e15-456892028012'),
	(221,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2020-08-18 08:40:26',NULL,'2020-08-18 08:40:27','d79bcc93-1794-4421-96c9-9dfaab217e64'),
	(222,NULL,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2020-08-18 08:40:26',NULL,'2020-08-18 08:40:27','0982bf5c-b165-4b3d-beee-e8d9a64904e8'),
	(223,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27',NULL,NULL,'b4285e10-c418-4387-aa16-e5818fc9c10b'),
	(224,NULL,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27',NULL,NULL,'4d115111-c76a-4720-820e-d5cecc11895e'),
	(225,8,NULL,33,10,'craft\\elements\\Entry',1,0,'2018-09-20 15:07:17','2020-08-18 08:40:27',NULL,NULL,'c08bf1c2-4011-40f7-95ee-1d366cec1f9c'),
	(226,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27',NULL,'2020-08-18 08:40:27','b978219c-066f-4306-ba11-a06e3769d275'),
	(227,NULL,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27',NULL,'2020-08-18 08:40:27','5da97e17-b904-4bbf-b473-b8ca212975f4'),
	(228,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27',NULL,NULL,'a52f42ab-e012-4acb-b212-f5bae37e54f5'),
	(229,NULL,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27',NULL,NULL,'f57b6599-ead8-4c03-bb8f-3557a67e1510'),
	(230,8,NULL,34,10,'craft\\elements\\Entry',1,0,'2018-09-20 14:53:50','2020-08-18 08:40:27',NULL,NULL,'b7c2d1cd-f2dd-4df5-a7dd-43db20a4b198'),
	(231,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27',NULL,'2020-08-18 08:40:27','3fadc485-0a89-47dd-9cc9-e1aa70b081da'),
	(232,NULL,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27',NULL,'2020-08-18 08:40:27','23812bd2-8a7b-46b8-8fac-ca53ae4eb35d'),
	(233,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27',NULL,NULL,'33c5131b-597e-4068-983b-d0924a5e5ee4'),
	(234,NULL,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27',NULL,NULL,'747581fa-5acb-4cc0-ade1-198733c4583e'),
	(235,10,NULL,35,10,'craft\\elements\\Entry',1,0,'2018-09-19 10:52:51','2020-08-18 08:40:27',NULL,NULL,'35c2bb18-f12f-4be9-a2ad-722f25d19854'),
	(236,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2018-10-16 11:35:50',NULL,'2020-08-18 08:40:27','24fca16a-98ff-4b93-a0f2-be7c4d9601f7'),
	(237,NULL,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2018-10-16 11:35:50',NULL,'2020-08-18 08:40:27','5b52012f-949c-471f-895c-9e3cdb8b6504'),
	(238,NULL,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2018-10-16 11:35:50',NULL,'2020-08-18 08:40:27','2279fdd0-34ee-462f-b4ff-9caf051563dd'),
	(239,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2018-10-16 11:35:50',NULL,'2020-08-18 08:40:27','ab9d01cd-ab02-4f5f-b8b2-d083624f67a7'),
	(240,NULL,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2018-10-16 11:35:50',NULL,'2020-08-18 08:40:27','719e180d-1d40-4baa-92c4-3724a297cf57'),
	(241,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27',NULL,NULL,'97d74a41-b127-4813-94f5-6db231d02a25'),
	(242,NULL,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27',NULL,NULL,'8fec6ef2-c1ac-4fb9-a7fb-5dc71ca148e5'),
	(243,NULL,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27',NULL,NULL,'1d19d881-d1e4-43f9-87d3-8919b023f233'),
	(244,NULL,NULL,NULL,6,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27',NULL,NULL,'94c014a5-1833-4186-a5fd-564b2d3efb7d'),
	(245,8,NULL,36,10,'craft\\elements\\Entry',1,0,'2018-09-19 10:43:18','2020-08-18 08:40:27',NULL,NULL,'fb2726f5-d292-4e96-846e-1e7acad44b5f'),
	(246,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27',NULL,'2020-08-18 08:40:28','300dba66-fe21-4eac-9ad8-527d868ec1d5'),
	(247,NULL,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27',NULL,'2020-08-18 08:40:28','5f8441c5-1915-4685-a7c0-e4190ed2debf'),
	(248,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:28','2020-08-18 08:40:28',NULL,NULL,'1cdd2ac1-7d64-40d3-9a80-22af33ba5608'),
	(249,6,NULL,37,10,'craft\\elements\\Entry',1,0,'2018-09-18 15:54:03','2020-08-18 08:40:28',NULL,NULL,'5957f3f6-5d40-4c35-84a9-358496b4b04b'),
	(250,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:28','2020-08-18 08:40:26',NULL,'2020-08-18 08:40:28','1d6f70f1-127b-4d4e-b434-0a0488e9fb74'),
	(251,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:28','2020-08-18 08:40:28',NULL,NULL,'848e21a3-eb6c-4639-ac90-e24715637dac'),
	(252,6,NULL,38,10,'craft\\elements\\Entry',1,0,'2018-09-18 15:51:16','2020-08-18 08:40:28',NULL,NULL,'7f09e9dc-22b7-4c2b-baf0-924fcf839c93'),
	(253,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-08-18 08:40:28','2020-08-18 08:40:28',NULL,'2020-08-18 08:40:28','dfcde823-c748-459c-ab69-4f3b31b1ae59'),
	(254,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2021-02-16 16:48:35','2021-02-16 16:48:35',NULL,NULL,'a2ba55a6-4a09-4982-a5c0-75d04c5477bc'),
	(255,6,NULL,39,10,'craft\\elements\\Entry',1,0,'2021-02-16 16:48:34','2021-02-16 16:48:34',NULL,NULL,'96550ff1-8293-4f8f-a0b6-a9a9780f1929'),
	(256,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2021-02-16 16:48:35','2021-02-16 16:48:34',NULL,NULL,'5b608843-96c9-41c6-a0d8-c81a7239846c'),
	(257,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2021-02-16 16:48:35','2021-02-16 16:48:34',NULL,NULL,'a428518e-1334-470e-a855-7e7b3a0fd069'),
	(258,NULL,NULL,NULL,12,'craft\\elements\\MatrixBlock',1,0,'2021-02-16 16:48:35','2021-02-16 16:48:34',NULL,NULL,'a5f501d9-881a-4fd7-a52d-147dfd6c32db'),
	(259,NULL,NULL,NULL,16,'craft\\elements\\MatrixBlock',1,0,'2021-02-16 16:48:35','2021-02-16 16:48:34',NULL,NULL,'fa3912e1-48fa-438d-be06-b704e9ca4355'),
	(260,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2021-02-16 16:48:35','2021-02-16 16:48:34',NULL,NULL,'be1a2e5f-9f13-4f9c-a17e-58067017fc94'),
	(261,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2021-02-16 16:48:35','2021-02-16 16:48:34',NULL,NULL,'2d4f41fd-de33-48af-8af6-411975fe02e4'),
	(262,NULL,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2021-02-16 16:48:35','2021-02-16 16:48:35',NULL,NULL,'3da53b12-476c-407f-948b-8c2c762a9096'),
	(263,NULL,NULL,NULL,4,'craft\\elements\\MatrixBlock',1,0,'2021-02-16 16:48:35','2021-02-16 16:48:35',NULL,NULL,'aad05f8e-4933-475c-aa2e-0565f2b8d87a'),
	(264,NULL,NULL,NULL,13,'craft\\elements\\MatrixBlock',1,0,'2021-02-16 16:48:35','2021-02-16 16:48:35',NULL,NULL,'f0e15ada-4687-4e55-a39e-5e9f8528a714'),
	(265,NULL,NULL,NULL,17,'craft\\elements\\MatrixBlock',1,0,'2021-02-16 16:48:35','2021-02-16 16:48:35',NULL,NULL,'cc39fe90-2bbb-4f4a-a69f-5e6af42b35fa');

/*!40000 ALTER TABLE `cc1_elements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_elements_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_elements_sites`;

CREATE TABLE `cc1_elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `cc1_elements_sites_siteId_idx` (`siteId`),
  KEY `cc1_elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `cc1_elements_sites_enabled_idx` (`enabled`),
  KEY `cc1_elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `cc1_elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `cc1_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_elements_sites` WRITE;
/*!40000 ALTER TABLE `cc1_elements_sites` DISABLE KEYS */;

INSERT INTO `cc1_elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,NULL,NULL,1,'2018-06-08 15:06:11','2018-07-04 09:56:40','66f379f6-8645-464e-9ce6-718eca29d406'),
	(2,2,1,'active','user-type/active',1,'2018-09-18 14:03:03','2018-09-18 14:03:07','0f9cd912-357b-4738-8102-c8197ea3771f'),
	(3,3,1,'deferred','user-type/deferred',1,'2018-09-18 14:03:18','2018-09-18 14:03:22','1447aced-7193-4c45-8366-47c648cfe232'),
	(4,4,1,'pensioner','user-type/pensioner',1,'2018-09-18 14:03:26','2018-09-18 14:03:29','0b184ff6-6189-41df-94f7-c93d55f39065'),
	(5,5,1,'homepage','__home__',1,'2018-09-18 14:24:27','2018-09-18 14:25:58','5a1554da-3b4b-4969-b5a1-094483fda817'),
	(6,6,1,'scheme-information','scheme-information',1,'2018-09-18 15:51:16','2020-07-28 14:04:06','0c5060f4-08e1-41c6-95b0-0200f1dc016d'),
	(7,7,1,NULL,NULL,1,'2018-09-18 15:54:03','2020-07-28 14:04:06','cc55442d-4abc-4f77-a0d8-6989eb2c4f5a'),
	(8,8,1,'lorem-ipsum-dolor-sit-amet','lorem-ipsum-dolor-sit-amet',1,'2018-09-19 10:43:18','2021-02-16 16:48:39','662c7638-d72a-425d-b969-efe52157f66b'),
	(9,9,1,NULL,NULL,1,'2018-09-19 10:43:18','2018-10-16 11:35:36','57576afc-e314-450d-a305-b22de4346bf0'),
	(10,10,1,'vestibulum-posuere-congue-dui-ac-convallis','vestibulum-posuere-congue-dui-ac-convallis',1,'2018-09-19 10:52:50','2018-10-16 11:35:50','cf74bce5-dafc-461e-9567-c5b322ab9114'),
	(11,11,1,NULL,NULL,1,'2018-09-19 10:52:51','2018-10-16 11:35:50','8c4720e8-beb3-4c8b-9f0f-ac627fe15522'),
	(12,12,1,NULL,NULL,1,'2018-09-19 10:52:51','2018-10-16 11:35:50','fcd7bccf-68f0-41a6-abf4-9694f61c26cf'),
	(13,13,1,NULL,NULL,1,'2018-09-19 10:52:51','2018-10-16 11:35:50','da595827-9e68-45e6-8522-05e41e3989b0'),
	(14,14,1,NULL,NULL,1,'2018-09-19 10:52:51','2018-10-16 11:35:50','20147152-26f2-490d-b620-fdd1680f7125'),
	(15,15,1,NULL,NULL,1,'2018-09-19 10:52:51','2018-10-16 11:35:50','5e822d5c-8764-4cc9-9f2b-e30d8ce51d90'),
	(16,16,1,NULL,NULL,1,'2018-09-20 14:53:50','2018-10-16 11:35:36','023a3f2e-e341-4613-8eed-68768c829577'),
	(17,17,1,NULL,NULL,1,'2018-12-19 10:36:14','2018-12-19 10:51:47','c7be376b-3d79-4c61-9dd1-64dd487d32dc'),
	(18,18,1,NULL,NULL,1,'2019-03-20 09:18:13','2020-07-28 14:04:06','30ddc143-f6e6-413c-892e-13059e053990'),
	(19,19,1,NULL,NULL,1,'2019-06-18 09:32:13','2020-07-28 14:04:06','dc802936-a2fb-46fd-882d-534a213ad513'),
	(20,20,1,NULL,NULL,1,'2019-06-18 09:32:13','2020-07-28 14:04:06','23301e53-6c07-4615-b093-eaf39980959a'),
	(21,21,1,NULL,NULL,1,'2019-06-18 09:35:18','2020-07-28 14:04:06','fc138505-52d8-4a57-a4b6-6f6d77a1ffd5'),
	(22,22,1,NULL,NULL,1,'2019-06-18 09:35:18','2020-07-28 14:04:06','7ac1b7ab-2adb-4423-9606-f45b76a14b55'),
	(23,23,1,NULL,NULL,1,'2019-06-18 09:37:35','2020-07-28 14:04:06','0b8b5489-cd0d-4b9f-9d6f-81e8ccbc2c57'),
	(24,24,1,'complex-block-example',NULL,1,'2020-07-28 13:32:59','2020-07-28 13:48:00','ddc9c030-8de1-4cc9-b5b3-151e1e3f2ce4'),
	(25,25,1,NULL,NULL,1,'2020-07-28 13:34:03','2020-07-28 14:04:06','7db1c8a6-db5b-433b-8e8b-88dd8c4d9aff'),
	(26,26,1,NULL,NULL,1,'2020-07-28 13:34:03','2020-07-28 14:04:07','cde50e7f-c10a-4257-ba94-e0567db11dd4'),
	(27,27,1,NULL,NULL,1,'2020-07-28 14:04:06','2020-07-28 14:04:06','b0427809-b374-491d-af1f-a3b866567bc2'),
	(28,28,1,'homepage','__home__',1,'2020-08-18 08:40:09','2020-08-18 08:40:09','3f3b1311-44a6-46e1-be50-276b5ce699d1'),
	(29,29,1,'homepage','__home__',1,'2020-08-18 08:40:09','2020-08-18 08:40:09','8e1a0863-6cdd-4a10-9c6c-6b8881de0010'),
	(30,30,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:20','2020-08-18 08:40:20','0c9a435e-4b5f-4300-aad8-1b06565681d3'),
	(31,31,1,NULL,NULL,1,'2020-08-18 08:40:20','2020-08-18 08:40:20','6523aa5a-b7bd-42c1-9a63-99f1b1a91407'),
	(32,32,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','0133fe66-0a6c-4ad8-a503-48e8250ff3fc'),
	(33,33,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','615fa3f7-0c46-4c26-b218-6271f3242d55'),
	(34,34,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','55f6d61b-7817-4414-91ad-5f815e87be9a'),
	(35,35,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','022c3311-26c3-4e2f-9bc1-90e26de62c82'),
	(36,36,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','7aedeba3-4d61-4c65-8ce4-0c24878ce2ac'),
	(37,37,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','e4f6fdee-a50c-47c3-8b0d-ce463e46221a'),
	(38,38,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','7a8b0a08-c9ea-4c21-8158-185b94a888c2'),
	(39,39,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','4b4854aa-080c-47ea-867c-42cbb380b201'),
	(40,40,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','8369a06a-4451-44aa-abf5-898038f8911d'),
	(41,41,1,'complex-block-example',NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','ce3b2fb7-279c-4591-b1c5-29c852a6b5d6'),
	(42,42,1,'complex-block-example',NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','f0014b94-5549-4ee7-a2ce-489d3fde9cbb'),
	(43,43,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:21','2020-08-18 08:40:21','29ca52b8-5b6f-46ae-97da-5586682c1879'),
	(44,44,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','b2bec9be-7376-4211-9eeb-a2542dfc199c'),
	(45,45,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','90fe82fb-f71e-4387-82df-af696740613e'),
	(46,46,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','c5a291e4-f681-48b3-b5af-1b2679d05fd0'),
	(47,47,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','37ab46e7-a3c4-4d2c-9b29-6648bce0afed'),
	(48,48,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','fee36e0a-b609-4cb8-ae01-26fae10fc56f'),
	(49,49,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','171de369-aa02-449d-84b3-b84736fe6e52'),
	(50,50,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','cf5cc268-52f7-49ff-baa2-8969b201cb65'),
	(51,51,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','aff77e4b-d58d-4834-b0f1-14eb6831318f'),
	(52,52,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','faa8bf27-c881-42f4-85eb-2e6a728e7266'),
	(53,53,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','07f02b6f-d90e-4805-92b6-e3f054e11ada'),
	(54,54,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','0ab41149-a5d2-41ba-a44c-68ae7f9ef33e'),
	(55,55,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','19a21309-17ef-4ddf-8049-fa70f7fec04f'),
	(56,56,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','7d2588ea-c8f2-4d2b-83e6-bd8b0d9727b0'),
	(57,57,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','234dd672-2a1c-4f1e-977e-e2ecd624ec60'),
	(58,58,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','335fca36-7a54-4884-9bbf-6b73ed64d258'),
	(59,59,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','10d1f78c-4a2b-4d69-81b3-473b136a3ca7'),
	(60,60,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','0b5a2dd2-7f2e-4b19-b2d4-dbefe080718e'),
	(61,61,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','2d5d530f-8bb0-4a06-a5f8-51d5eb4a2a54'),
	(62,62,1,NULL,NULL,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','64f77123-b453-4254-92a4-62737d090435'),
	(63,63,1,'this-complex-bock-has-its-own-template-entry-and-could-easily-have-more-fields-than-this-title',NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','22ce40db-8b3e-4ddb-944a-2f37594f5eea'),
	(64,64,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:22','2020-08-18 08:40:22','936c9068-6076-43fa-be93-3809898fdd21'),
	(65,65,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','fbd153dd-d2cb-4769-b5a3-e32fef54c8e1'),
	(66,66,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','7d3576c1-56a9-4b04-9feb-d934a158d264'),
	(67,67,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','4d8c0bfd-728b-4e1b-8c06-6574e4aecb09'),
	(68,68,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','8c9c5baa-c356-4aad-a212-9b59d2a68951'),
	(69,69,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','7bae768b-4ede-4cca-af20-30596a51cc86'),
	(70,70,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','fb359e94-6178-45b7-acdd-83c2049c96ce'),
	(71,71,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','393cc990-1a3c-4e3e-aa22-affaedaffdfc'),
	(72,72,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','5fd8ce83-c9be-48c6-b137-6ee6ec503b7f'),
	(73,73,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','84bd4754-e3a2-4ef4-be75-b44cb8b35c99'),
	(74,74,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','a802af07-4265-4840-a981-764fbfccb2c2'),
	(75,75,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','2190ee88-4181-44bd-8434-4e0c660fa4be'),
	(76,76,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','2f41367a-0f2d-495f-a61b-721c27224046'),
	(77,77,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','4eb24b5e-d449-4638-b6a7-1dc288b885ca'),
	(78,78,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','d9acfb31-f895-4aac-b296-81c331bd569e'),
	(79,79,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','b6827436-c195-462a-aa77-1037f79bb747'),
	(80,80,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','0386983b-984d-4eae-a744-b756769a5aa9'),
	(81,81,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:22','2020-08-18 08:40:22','c4f016bf-077a-4fdf-9281-52f1b7a07b09'),
	(82,82,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','b55a0cd0-350a-48b1-b6cd-a7acd7c153fa'),
	(83,83,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','5ef2dc68-f973-4217-8961-5ea98ed883bd'),
	(84,84,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','e8272dc3-53fd-4249-ad0e-2d15fd85fb22'),
	(85,85,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','462a9fbd-fd55-4d4f-9c9e-2bd1419ef6f2'),
	(86,86,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','d9e078e7-5dce-4ed3-957d-1d0e9ec8120c'),
	(87,87,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','4f2c3bea-07ff-44f2-bcd9-c81e6b6ab33e'),
	(88,88,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','b1b5fada-a132-4316-93cd-de2e9786f817'),
	(89,89,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:22','2020-08-18 08:40:22','003e2855-63de-42d3-84fb-42a3fb98606b'),
	(90,90,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','4a6faede-beb3-4f87-a711-e30ae353c865'),
	(91,91,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','702eadaf-598a-4a61-a429-445c9414bf29'),
	(92,92,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','55d8215a-f452-4fc1-b078-c9eeb68c595c'),
	(93,93,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','02907a50-db76-4800-9195-d31d50e4c541'),
	(94,94,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','c34787e1-cca4-46ec-84b5-ce4b6651bdeb'),
	(95,95,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','0b4c54fc-c257-453a-981a-85c7efc3e298'),
	(96,96,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','f88f3d46-50a4-403d-ac06-09a557a8b973'),
	(97,97,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:22','2020-08-18 08:40:22','9c59ebd9-5e99-46e8-b89d-392e1796b824'),
	(98,98,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','02aa1f7e-c93c-417e-9611-1261c4884aaa'),
	(99,99,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','26eae9e4-b420-4cbb-8c05-de4a1d9a48d5'),
	(100,100,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','36bd01af-b049-4c9a-8bf0-9c893f5316a2'),
	(101,101,1,NULL,NULL,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','92899681-d209-40ce-8567-a5217a5598e9'),
	(102,102,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','bfe5b3f1-7546-4332-bb7a-0ff27c14c3cb'),
	(103,103,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','aa785283-d8be-4214-903f-424135fd447f'),
	(104,104,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','8c6036ad-d5b0-4126-98a7-149f779c9259'),
	(105,105,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:23','2020-08-18 08:40:23','50e6898b-4101-4667-9b87-e2b7f05c1e30'),
	(106,106,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','bde85f71-070d-4a8a-b908-055b8dbd4017'),
	(107,107,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','131b3fb7-fa07-4d30-a878-c62ffe63cfd3'),
	(108,108,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','6d371fc9-abb0-4064-87ed-7b20636d78af'),
	(109,109,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','b9f457a0-0f77-4eca-9a3f-efd3c9562e87'),
	(110,110,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','40aaa0fa-2aeb-452b-aea3-e38a3b31690e'),
	(111,111,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','89b81410-d6bc-4014-ba5a-29d94595f930'),
	(112,112,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','bea77b7c-9486-42fe-98c5-bfebcffb687c'),
	(113,113,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:23','2020-08-18 08:40:23','3d3f77e2-22cb-41fa-82c4-a2281de4edd2'),
	(114,114,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','e13addb2-26be-4475-acc3-400b02d27c2a'),
	(115,115,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','a31e5d24-1d9b-4b8c-bfc7-0a389ac9b244'),
	(116,116,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','0e710097-2ba8-49e1-b847-85362aa5086b'),
	(117,117,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','d80fc83f-b68c-4daa-af2d-feda44304e10'),
	(118,118,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','1df3d6f6-fb59-4cc4-b345-a7fb1018340f'),
	(119,119,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','5e4c165d-351a-4a90-b99e-10cd16379bf9'),
	(120,120,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','e6d25dc7-9ceb-47f8-99a7-67387262c896'),
	(121,121,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:23','2020-08-18 08:40:23','608f3561-64bc-45b5-b75f-c6bbb32c5e8b'),
	(122,122,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','0298a100-7a54-481c-b463-b34fabe46b9f'),
	(123,123,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','12facd2b-c3c9-4b37-b4e9-74c456ac60cb'),
	(124,124,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','fa2a9dba-c18a-4361-8a04-1fc21df198e4'),
	(125,125,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','00f49369-79fa-4cbd-9a4c-e3425b5079c3'),
	(126,126,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','2d5c31c1-95ca-4ba5-9010-deb9121cbe4b'),
	(127,127,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','823fa5cf-7a5f-4184-8da6-0b96f0b58472'),
	(128,128,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','6b98cf8f-8eca-4fff-9fc9-ccb8242e1f0d'),
	(129,129,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:23','2020-08-18 08:40:23','b6d73510-b532-4090-aea9-2a586e81ca36'),
	(130,130,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','b3139b3a-67f0-40f0-93ff-bd3a2c6ab1e9'),
	(131,131,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','65a64f92-5149-40d7-8ca6-8ac412b8326f'),
	(132,132,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','7c624a11-4af4-44c0-922a-0672baf34d9e'),
	(133,133,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','ebb60e79-89dd-4894-8e60-d45d2673e623'),
	(134,134,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','938d2ca1-e137-4ce0-8d88-24b582e2755d'),
	(135,135,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','f79491e8-d896-4d46-b3d4-84972f01a790'),
	(136,136,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','7d2d1152-5772-4803-b388-00a40c579ee0'),
	(137,137,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:23','2020-08-18 08:40:23','fb7fee4f-f064-4458-b429-3ec646294924'),
	(138,138,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','38cb1b0c-9f75-447d-8989-21a3a28d7908'),
	(139,139,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','32dd2e10-51a9-4b04-96cb-24ac2510c1d1'),
	(140,140,1,NULL,NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','c5eeb091-daae-49c5-a8a0-6d14486136a7'),
	(141,141,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','32f4ce3f-7e3f-4105-ae0f-a46e28be3b56'),
	(142,142,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','76bfe63b-8669-4717-89e6-2719690de220'),
	(143,143,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','3d325f3a-c754-4e07-ae7a-03d0cb8cee92'),
	(144,144,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','a937d565-71e6-4b63-aae7-4209f683fc99'),
	(145,145,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','fd2fd6b8-fe16-4314-9065-ce45eba7c1f7'),
	(146,146,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','44d5aaba-353f-4274-8302-dba3b890cf9c'),
	(147,147,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:24','2020-08-18 08:40:24','bd7572ab-1c8c-4188-a62c-2d0fef785e32'),
	(148,148,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','6caa1619-84d7-415e-a5fd-0384a7757345'),
	(149,149,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','3a9ee8aa-ec7f-4bc1-9d7b-e7b01fc86879'),
	(150,150,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','02b4c909-d654-4684-b9da-4f628798f4dc'),
	(151,151,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','44de8599-ab0e-4c02-8234-4e70071e2192'),
	(152,152,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:24','2020-08-18 08:40:24','258fc74f-d1a9-4431-ba93-651ce22e41a2'),
	(153,153,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','5c023010-bd30-4e58-8d7b-26c7e2b4a7f9'),
	(154,154,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','60020ccb-c410-4372-aec9-d9ad0bf26f98'),
	(155,155,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','4a51278c-7cf0-44fd-983a-f178bcda3314'),
	(156,156,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','4347ee5a-3146-41da-9818-67a0de65d01b'),
	(157,157,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:24','2020-08-18 08:40:24','3e255ce6-d474-4cca-881e-783cff2450fc'),
	(158,158,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','74ff9369-cf64-4fdb-a7a5-1461def82d67'),
	(159,159,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','e716f001-5983-4620-8535-24cd6f45124a'),
	(160,160,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','695cd438-eceb-419c-a5c9-476466a21415'),
	(161,161,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','d2c8b4ce-c6e5-4739-90de-bad956354865'),
	(162,162,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:24','2020-08-18 08:40:24','99de6808-0af4-45c4-a85d-3f23be83ac48'),
	(163,163,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','28214887-bdf5-46ec-bc81-54bf49e04544'),
	(164,164,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','22dde0df-0493-42f7-b045-b54d05aad82b'),
	(165,165,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','7ec67226-db4a-4acf-85f7-bbd24a7abce3'),
	(166,166,1,NULL,NULL,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','37510bd1-fd48-46c6-8c56-d3d689974d71'),
	(167,167,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:25','2020-08-18 08:40:25','e086b34e-ce11-46d7-9dcd-bf5111faf26b'),
	(168,168,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','30e13895-e8b9-4486-9141-e427ae93cee6'),
	(169,169,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','58b61c2d-e2f6-45bb-8b02-2a41651e0a30'),
	(170,170,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','395d279c-375c-4082-8f28-9a9ab04ae54a'),
	(171,171,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','fbaa3b31-1622-4cb3-a7fe-68bc6279dbf3'),
	(172,172,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:25','2020-08-18 08:40:25','9c27e90e-7140-4b30-af0f-92bb636020ae'),
	(173,173,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','0bda2881-7439-46fa-aa9c-8f9fa4301ee3'),
	(174,174,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','3cf3d10f-4d54-4df8-a166-21a75faf65ea'),
	(175,175,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','4b9eed78-81df-4686-bfac-2d86a97207c8'),
	(176,176,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','5f10c958-bc20-4a57-ba24-21cf8222d9af'),
	(177,177,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:25','2020-08-18 08:40:25','bee1cc01-7c18-4c63-a59f-a72968f5fcd4'),
	(178,178,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','73dc7a28-175a-47ac-b1ab-293aa0e8f1c2'),
	(179,179,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','ff6b38a6-46b0-41fd-aeef-b162e827d227'),
	(180,180,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','d427ca6a-27fb-4f4b-8b4b-5d0da29139e7'),
	(181,181,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','b8d78e33-2d3e-4603-87a4-f2265f05e517'),
	(182,182,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:25','2020-08-18 08:40:25','9b2e30af-ab38-43e3-a93c-c77120b7739c'),
	(183,183,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','f2d1747b-7165-4009-9382-8ac1468dc089'),
	(184,184,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','426af2aa-c959-410f-a747-0d50d1ba5e07'),
	(185,185,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','8e15feec-0562-4942-a644-62e3ec822edd'),
	(186,186,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','8abd9b05-1524-45a3-bb8d-4d16c07991de'),
	(187,187,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:25','2020-08-18 08:40:25','08ae74e4-4512-4b29-ac22-14634508e4aa'),
	(188,188,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','50df8fca-5cad-4fa2-badb-acecf8359158'),
	(189,189,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','8eaabe4d-fc4a-459e-ba9b-3c812fd3beb7'),
	(190,190,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','c2db39be-4248-441b-8ebc-2db1f6448dee'),
	(191,191,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','18476391-10a2-4964-b1a9-70c580a01e98'),
	(192,192,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:25','2020-08-18 08:40:25','0ed4a1ee-f7aa-4c35-bf83-fd08f80b74c6'),
	(193,193,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','71a52caf-c8b3-4cb3-8f92-27492b52ee12'),
	(194,194,1,NULL,NULL,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','8b43f5ba-5644-4e43-af60-bfb946a8ffc5'),
	(195,195,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','2ef0be8e-7f63-457f-8039-2ff7dbc9ef2d'),
	(196,196,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','7f7dc566-dac8-4a69-9c1f-28fdbf8f5b25'),
	(197,197,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:26','2020-08-18 08:40:26','0bf69f62-3b1b-4638-ace4-58b1ca913b9f'),
	(198,198,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','f3fdb47b-7da5-496d-aaeb-077a7afeece3'),
	(199,199,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','9bd90577-cb61-4a22-b5f5-1731f71ea8d1'),
	(200,200,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','9acc7a42-045b-4897-b7d0-42527bf4de68'),
	(201,201,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','a2626240-27bd-4cbb-8d08-a13514454dc8'),
	(202,202,1,'vestibulum-posuere-congue-dui-ac-convallis','vestibulum-posuere-congue-dui-ac-convallis',1,'2020-08-18 08:40:26','2020-08-18 08:40:26','429891b5-0afc-4dbf-aed3-c7522630a2ce'),
	(203,203,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','64620010-4632-4be7-8fcd-c0ebb5cde522'),
	(204,204,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','110dda47-d050-4b22-8ab2-3b02786a3ac2'),
	(205,205,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','b4cb8ddb-5721-4bf7-9ce9-3bb1198c1bd6'),
	(206,206,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','45ed58df-44d1-422c-84ed-a117c3cd2187'),
	(207,207,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','4f042593-5f15-4571-856a-9386191bdbff'),
	(208,208,1,'lorem-ipsum-dolor-sit-amet','lorem-ipsum-dolor-sit-amet',1,'2020-08-18 08:40:26','2020-08-18 08:40:26','47408745-caeb-4a5f-a1f4-f8492e189455'),
	(209,209,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','76993263-4473-4cff-8e83-4a694a631cdf'),
	(210,210,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','a0c615d7-6d55-4bcf-b24a-6280be27254a'),
	(211,211,1,'lorem-ipsum-dolor-sit-amet','lorem-ipsum-dolor-sit-amet',1,'2020-08-18 08:40:26','2020-08-18 08:40:26','68924290-abdd-4668-934a-1276bb114e86'),
	(212,212,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','9a22f00a-5e57-4e67-acf9-84b4b89e0521'),
	(213,213,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','22a8b89d-e0b7-437e-b8fc-a24137632c16'),
	(214,214,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','767adae3-1927-43c8-ab73-34ccbffcecb8'),
	(215,215,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','8a564e51-44cc-47e3-9bab-26fe4d5050ab'),
	(216,216,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:26','2020-08-18 08:40:26','9a4e1340-cceb-49ed-90f6-35a479b3d539'),
	(217,217,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','3b03817b-e331-4040-9d31-b0e5d78e0c73'),
	(218,218,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','8a77cc8a-1974-4ca4-a828-9300299fa71a'),
	(219,219,1,NULL,NULL,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','25f362d5-6be3-495f-b4a0-b61c51e40432'),
	(220,220,1,'lorem-ipsum-dolor-sit-amet','lorem-ipsum-dolor-sit-amet',1,'2020-08-18 08:40:27','2020-08-18 08:40:27','4212ee0b-4dc1-4c3d-a0b5-8307a3026d00'),
	(221,221,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','9d60e294-83b2-4aff-9249-0adca26c41bc'),
	(222,222,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','4992e5f7-38cf-4df5-afef-1a8e3d217792'),
	(223,223,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','2e68577a-5ba5-425e-a81c-dfd93ec6f9b5'),
	(224,224,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','4d9d684b-638d-49e6-87d9-8b5d358cb50d'),
	(225,225,1,'lorem-ipsum-dolor-sit-amet','lorem-ipsum-dolor-sit-amet',1,'2020-08-18 08:40:27','2020-08-18 08:40:27','fbc08f58-87da-4089-b135-ad11438ca486'),
	(226,226,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','483d2940-f9fb-44ea-b122-f08225cfaef6'),
	(227,227,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','acde344c-55c7-4a5d-968f-ca0fa9bf0509'),
	(228,228,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','0dd3da77-d17c-48f1-8ad5-ca5c6272d53a'),
	(229,229,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','da4cf469-aa07-45f1-8a6f-b09fe6faba21'),
	(230,230,1,'lorem-ipsum-dolor-sit-amet','lorem-ipsum-dolor-sit-amet',1,'2020-08-18 08:40:27','2020-08-18 08:40:27','d45e4c55-4b97-4cc7-aa80-03545a4bd4d2'),
	(231,231,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','94fd5eae-3755-4853-8638-406d0f93f116'),
	(232,232,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','0dcb7812-baca-407d-a637-58dba1e03b21'),
	(233,233,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','e770b92b-c6de-4f67-a6fd-b989237f4c55'),
	(234,234,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','95a65530-f433-4d03-8f38-632952f01944'),
	(235,235,1,'vestibulum-posuere-congue-dui-ac-convallis','vestibulum-posuere-congue-dui-ac-convallis',1,'2020-08-18 08:40:27','2020-08-18 08:40:27','004ff73e-646f-4a7f-b8d2-f0bed3acc5f6'),
	(236,236,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','c358f8b2-db03-4e07-8cd7-fe5890bbaf02'),
	(237,237,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','734705c9-5aa0-4825-96cb-d5dd1d8c8238'),
	(238,238,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','bdbb618b-8d21-4aa1-b2a5-c1bbd8a147bf'),
	(239,239,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','e329745a-9f0a-4eac-a03a-73c1cc98fc4f'),
	(240,240,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','0d95b866-9c06-4278-9e63-eba41a2324be'),
	(241,241,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','9c3467e9-6a99-4cf8-80ab-f7aeea4b48ac'),
	(242,242,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','f4e764be-8cb0-4c9f-8d59-5a97ad57202b'),
	(243,243,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','43d07d94-5fe9-4be6-a1ff-2f309788fe43'),
	(244,244,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','d1d964b8-e118-405b-bb72-12bbed119820'),
	(245,245,1,'lorem-ipsum-dolor-sit-amet','lorem-ipsum-dolor-sit-amet',1,'2020-08-18 08:40:27','2020-08-18 08:40:27','8775d181-4710-45c1-ac62-468c84c82147'),
	(246,246,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','7208fd82-fbb0-499e-837c-188fbc1725df'),
	(247,247,1,NULL,NULL,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','0afd86c8-16dd-4e8e-abd6-bbeec48c8f19'),
	(248,248,1,NULL,NULL,1,'2020-08-18 08:40:28','2020-08-18 08:40:28','da539906-b2ca-4dea-9a19-84ce594a8ff7'),
	(249,249,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:28','2020-08-18 08:40:28','90faf588-62a2-4609-9a1c-06c8e98902c0'),
	(250,250,1,NULL,NULL,1,'2020-08-18 08:40:28','2020-08-18 08:40:28','9a327af8-ff56-4931-a563-a4e6548174dc'),
	(251,251,1,NULL,NULL,1,'2020-08-18 08:40:28','2020-08-18 08:40:28','fe1d3114-4666-45be-b03d-b7efba18057b'),
	(252,252,1,'scheme-information','scheme-information',1,'2020-08-18 08:40:28','2020-08-18 08:40:28','dd4c8793-c098-4d62-932a-1c3af2f6968f'),
	(253,253,1,NULL,NULL,1,'2020-08-18 08:40:28','2020-08-18 08:40:28','9f295690-48e4-4550-a68d-8160b82d044d'),
	(254,254,1,NULL,NULL,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','38b43c6a-69d1-4bca-9cd0-f5f403700ec6'),
	(255,255,1,'scheme-information','scheme-information',1,'2021-02-16 16:48:35','2021-02-16 16:48:35','20a7d257-570b-46ca-a5a5-fb811aed1b12'),
	(256,256,1,NULL,NULL,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','466512a7-2a77-48ac-b3a9-cb3b60ba8cc7'),
	(257,257,1,NULL,NULL,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','75e121e0-3213-422b-b856-adfdfedc9648'),
	(258,258,1,NULL,NULL,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','58c9cc73-1e85-45e4-b243-497f57795d74'),
	(259,259,1,NULL,NULL,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','532810d9-bef1-456a-8b17-5c4bb287490a'),
	(260,260,1,NULL,NULL,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','5bf3396e-6f0e-469b-b160-dedd41b8347e'),
	(261,261,1,NULL,NULL,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','efeaa77e-cb7c-4905-897a-ee1f1906a491'),
	(262,262,1,NULL,NULL,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','be079add-df81-435a-a266-54416f806592'),
	(263,263,1,NULL,NULL,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','0a43cf12-34dd-459d-ad46-4bf048c75069'),
	(264,264,1,NULL,NULL,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','6f2f45ec-78f4-4ba2-88c7-b7ca7669bf6f'),
	(265,265,1,NULL,NULL,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','c4a27941-50ad-4456-8cea-f210730e855e');

/*!40000 ALTER TABLE `cc1_elements_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_entries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_entries`;

CREATE TABLE `cc1_entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_entries_postDate_idx` (`postDate`),
  KEY `cc1_entries_expiryDate_idx` (`expiryDate`),
  KEY `cc1_entries_authorId_idx` (`authorId`),
  KEY `cc1_entries_sectionId_idx` (`sectionId`),
  KEY `cc1_entries_typeId_idx` (`typeId`),
  KEY `cc1_entries_parentId_fk` (`parentId`),
  CONSTRAINT `cc1_entries_id_fk` FOREIGN KEY (`id`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `cc1_entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cc1_entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `cc1_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `cc1_entrytypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_fk_vjbhgtpgndixfqnldistejgumtehjzkczuae` FOREIGN KEY (`authorId`) REFERENCES `cc1_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_entries` WRITE;
/*!40000 ALTER TABLE `cc1_entries` DISABLE KEYS */;

INSERT INTO `cc1_entries` (`id`, `sectionId`, `parentId`, `typeId`, `authorId`, `postDate`, `expiryDate`, `deletedWithEntryType`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(5,1,NULL,1,NULL,'2018-09-18 14:24:00',NULL,NULL,'2018-09-18 14:24:27','2018-09-18 14:25:58','a94fd234-08c2-4370-acfe-f5d04efed2e4'),
	(6,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2018-09-18 15:51:16','2020-07-28 14:04:06','819d98da-16ca-4729-94e2-d377390a61f7'),
	(8,2,NULL,2,1,'2018-09-19 10:43:00',NULL,NULL,'2018-09-19 10:43:18','2018-10-16 11:35:36','8d155d02-a6cb-4cfe-a9a6-abe2393db471'),
	(10,2,NULL,2,1,'2018-09-19 10:52:00',NULL,NULL,'2018-09-19 10:52:50','2018-10-16 11:35:50','3fd48918-bbb7-4ca5-9fcf-043bb9b44c7d'),
	(24,3,NULL,4,17,'2020-07-28 13:32:00',NULL,NULL,'2020-07-28 13:32:59','2020-07-28 13:48:00','bf817d1b-cfbb-44e9-9e19-ce4c48ffdc5a'),
	(28,1,NULL,1,NULL,'2018-09-18 14:24:00',NULL,NULL,'2020-08-18 08:40:09','2020-08-18 08:40:09','e690cd05-f14b-4545-b554-e93e4605e6cf'),
	(29,1,NULL,1,NULL,'2018-09-18 14:24:00',NULL,NULL,'2020-08-18 08:40:09','2020-08-18 08:40:09','47542319-1e90-43a0-a7f6-dcf2a8ac0005'),
	(30,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:20','2020-08-18 08:40:20','9689bb43-5275-4f12-a097-462c62f39e58'),
	(41,3,NULL,4,17,'2020-07-28 13:32:00',NULL,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','00d4bd3b-522e-47fe-80e9-a39b38516bf0'),
	(42,3,NULL,4,17,'2020-07-28 13:32:00',NULL,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','dc06fd7a-e798-4f63-9027-1d5a5ba8d3d1'),
	(43,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','2c799b5e-8820-4a04-ae1f-12ccd46475e0'),
	(63,3,NULL,4,17,'2020-07-28 13:32:00',NULL,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','1dca74af-21c5-4b62-80f6-aaa38376769f'),
	(64,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','945659f0-e0cd-42fb-98b7-60267be539b4'),
	(81,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','73b11193-01f6-4554-96d3-bc484ef1a8fe'),
	(89,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','38b92a0b-35e2-4df6-a61a-a613ff002f4f'),
	(97,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','ffbf04a9-6c0b-4481-aa6f-af540aa6b174'),
	(105,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','775ce100-bd31-4e16-af0d-60a6b7ab99ea'),
	(113,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','207039f7-835e-47e8-82c1-ce850f5a14da'),
	(121,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','4ebdeab3-9056-487b-9c64-59d36a5a2e92'),
	(129,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','19c92969-8b27-47bd-9a6e-01e1f42af424'),
	(137,2,NULL,3,1,'2018-09-18 15:51:00',NULL,1,'2020-08-18 08:40:23','2020-08-18 08:40:24','402c3e53-7533-4d36-9cd4-f8a3f99e0edd'),
	(147,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:24','2020-08-18 08:40:24','5a3ec029-e3af-47b2-a959-226ed92fb9b6'),
	(152,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:24','2020-08-18 08:40:24','2170e333-8dad-49cb-a30e-a39f66493738'),
	(157,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:24','2020-08-18 08:40:24','d339f99f-aaac-4eb5-a34c-91f3614afce8'),
	(162,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:24','2020-08-18 08:40:24','292e7806-c64b-4c85-8e1f-b9c3750e85dd'),
	(167,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:25','2020-08-18 08:40:25','ab9fa385-a559-4322-a424-b2449ed77b54'),
	(172,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:25','2020-08-18 08:40:25','de289fb3-73b0-4d01-be98-b22c3ccc328a'),
	(177,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:25','2020-08-18 08:40:25','b92b3a9a-efa4-4c65-a7e1-3aa657c7b6a7'),
	(182,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:25','2020-08-18 08:40:25','94ffb7f2-33f4-4fb3-af61-f134431d50ce'),
	(187,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:25','2020-08-18 08:40:25','26c68a2c-67d2-4b32-8e55-fd1fe6ab05b6'),
	(192,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:25','2020-08-18 08:40:25','5a983c5d-12d0-49a9-9508-072d0fce6477'),
	(197,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:26','2020-08-18 08:40:26','e720ea0c-d32e-4613-8ce9-00d01feaf2e2'),
	(202,2,NULL,2,1,'2018-09-19 10:52:00',NULL,NULL,'2020-08-18 08:40:26','2020-08-18 08:40:26','cd21829b-84dc-4efa-ba3a-e0f7d39b39cb'),
	(208,2,NULL,2,1,'2018-09-19 10:43:00',NULL,NULL,'2020-08-18 08:40:26','2020-08-18 08:40:26','f053ec6f-417d-4cbd-ae63-9eedcb89e63b'),
	(211,2,NULL,2,1,'2018-09-19 10:43:00',NULL,NULL,'2020-08-18 08:40:26','2020-08-18 08:40:26','1926471b-575c-48b7-8f34-5bbf16abb564'),
	(216,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:26','2020-08-18 08:40:26','79b6b0bc-0401-49b1-a4d0-eee8e69ff163'),
	(220,2,NULL,2,1,'2018-09-19 10:43:00',NULL,NULL,'2020-08-18 08:40:27','2020-08-18 08:40:27','481845a0-1227-4ed0-9f2f-d4b6988b9ad3'),
	(225,2,NULL,2,1,'2018-09-19 10:43:00',NULL,NULL,'2020-08-18 08:40:27','2020-08-18 08:40:27','09e4096e-ddc1-4553-b90f-34c4129ce132'),
	(230,2,NULL,2,1,'2018-09-19 10:43:00',NULL,NULL,'2020-08-18 08:40:27','2020-08-18 08:40:27','333157a1-6b34-4377-82be-df5ffd7f4d9c'),
	(235,2,NULL,2,1,'2018-09-19 10:52:00',NULL,NULL,'2020-08-18 08:40:27','2020-08-18 08:40:27','80f9b669-f757-43b4-a0b7-9d65283872b2'),
	(245,2,NULL,2,1,'2018-09-19 10:43:00',NULL,NULL,'2020-08-18 08:40:27','2020-08-18 08:40:27','0959ef01-7227-46da-a9fe-f3ebd39c99a8'),
	(249,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:28','2020-08-18 08:40:28','1aa6965d-91a8-45b8-b424-3724fadb61c7'),
	(252,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2020-08-18 08:40:28','2020-08-18 08:40:28','5022e795-8d3d-4ee8-bd36-9150ea9028b5'),
	(255,2,NULL,2,1,'2018-09-18 15:51:00',NULL,NULL,'2021-02-16 16:48:35','2021-02-16 16:48:35','6738254d-c48b-4fd0-a2cb-392fa15de47f');

/*!40000 ALTER TABLE `cc1_entries` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_entrydrafterrors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_entrydrafterrors`;

CREATE TABLE `cc1_entrydrafterrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cc1_entrydrafterrors_draftId_fk` (`draftId`),
  CONSTRAINT `cc1_entrydrafterrors_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `cc1_entrydrafts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_entrydrafts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_entrydrafts`;

CREATE TABLE `cc1_entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_entrydrafts_sectionId_idx` (`sectionId`),
  KEY `cc1_entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `cc1_entrydrafts_siteId_idx` (`siteId`),
  KEY `cc1_entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `cc1_entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `cc1_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `cc1_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `cc1_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `cc1_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_entrytypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_entrytypes`;

CREATE TABLE `cc1_entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT 1,
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text DEFAULT NULL,
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_entrytypes_sectionId_idx` (`sectionId`),
  KEY `cc1_entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `cc1_entrytypes_dateDeleted_idx` (`dateDeleted`),
  KEY `cc1_entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `cc1_entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  CONSTRAINT `cc1_entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `cc1_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cc1_entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `cc1_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_entrytypes` WRITE;
/*!40000 ALTER TABLE `cc1_entrytypes` DISABLE KEYS */;

INSERT INTO `cc1_entrytypes` (`id`, `sectionId`, `fieldLayoutId`, `name`, `handle`, `hasTitleField`, `titleTranslationMethod`, `titleTranslationKeyFormat`, `titleFormat`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,1,8,'Homepage','homepage',0,'site',NULL,'{section.name|raw}',1,'2018-09-18 14:24:27','2018-09-18 14:25:54',NULL,'7f619003-659d-4e4c-89a4-f62a69b611e0'),
	(2,2,10,'Default','default',1,'site',NULL,NULL,1,'2018-09-18 15:48:31','2018-09-19 08:28:13',NULL,'d4e1f2ba-ed64-4743-b767-9cfdf9c65220'),
	(3,2,15,'Default Two-Column','default2Col',1,'site',NULL,NULL,2,'2019-03-20 14:26:21','2019-03-20 14:26:21','2021-02-16 16:41:54','333c886e-aea5-493e-b666-c57f750d2049'),
	(4,3,18,'Complex block example','complexBlockExample',1,'site',NULL,NULL,1,'2020-07-28 13:31:11','2020-07-28 13:47:25',NULL,'e9185c5d-5c46-404d-8b9e-0f6bd3904f2d');

/*!40000 ALTER TABLE `cc1_entrytypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_entryversionerrors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_entryversionerrors`;

CREATE TABLE `cc1_entryversionerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `versionId` int(11) DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cc1_entryversionerrors_versionId_fk` (`versionId`),
  CONSTRAINT `cc1_entryversionerrors_versionId_fk` FOREIGN KEY (`versionId`) REFERENCES `cc1_entryversions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_entryversionerrors` WRITE;
/*!40000 ALTER TABLE `cc1_entryversionerrors` DISABLE KEYS */;

INSERT INTO `cc1_entryversionerrors` (`id`, `versionId`, `error`)
VALUES
	(1,30,'Setting unknown property: craft\\behaviors\\CustomFieldBehavior::closeOthers'),
	(2,29,'Setting unknown property: craft\\behaviors\\CustomFieldBehavior::closeOthers'),
	(3,28,'Setting unknown property: craft\\behaviors\\CustomFieldBehavior::closeOthers'),
	(4,27,'Setting unknown property: craft\\behaviors\\CustomFieldBehavior::closeOthers'),
	(5,26,'Setting unknown property: craft\\behaviors\\CustomFieldBehavior::closeOthers'),
	(6,25,'Setting unknown property: craft\\behaviors\\CustomFieldBehavior::closeOthers'),
	(7,24,'Setting unknown property: craft\\behaviors\\CustomFieldBehavior::column'),
	(8,11,'Setting unknown property: craft\\behaviors\\CustomFieldBehavior::expanderText');

/*!40000 ALTER TABLE `cc1_entryversionerrors` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_entryversions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_entryversions`;

CREATE TABLE `cc1_entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text DEFAULT NULL,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_entryversions_sectionId_idx` (`sectionId`),
  KEY `cc1_entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `cc1_entryversions_siteId_idx` (`siteId`),
  KEY `cc1_entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `cc1_entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `cc1_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cc1_entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `cc1_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `cc1_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `cc1_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_entryversions` WRITE;
/*!40000 ALTER TABLE `cc1_entryversions` DISABLE KEYS */;

INSERT INTO `cc1_entryversions` (`id`, `entryId`, `sectionId`, `creatorId`, `siteId`, `num`, `notes`, `data`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(11,10,2,1,1,2,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Vestibulum posuere congue dui ac convallis\",\"slug\":\"vestibulum-posuere-congue-dui-ac-convallis\",\"postDate\":1537354320,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"8\",\"fields\":{\"1\":{\"11\":{\"type\":\"regularCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"text\":\"<p>Fusce sollicitudin, eros vitae luctus ultrices, sapien elit lobortis est, non pellentesque tortor libero vehicula mauris. Donec rutrum purus id lectus mattis viverra. Maecenas aliquam porttitor erat, eget molestie neque. Vestibulum fermentum augue id leo mollis, blandit dignissim elit porta. Sed eget neque enim. Sed porta libero nec lectus tristique tristique. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus vestibulum non magna eget faucibus.</p>\"}},\"12\":{\"type\":\"sectionHeading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"headingText\":\"Section heading 3\",\"headingLevel\":\"h3\"}},\"13\":{\"type\":\"infoPanel\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"panelHeading\":\"Info panel\",\"panelText\":\"<p>Nam congue risus imperdiet, varius ex ac, venenatis odio. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>\"}},\"14\":{\"type\":\"expanderBlock\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"expanderHeading\":\"Expander block heading\",\"expanderText\":\"<p>Suspendisse vitae ultrices metus. Nulla ac bibendum dui. In efficitur felis eu orci laoreet posuere. Mauris vestibulum dapibus velit, nec mattis tellus tempus sit amet. </p>\",\"class\":null}},\"15\":{\"type\":\"address\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"email\":\"test@test.com\",\"postalAddress\":\"Test 123\\nTest Road\\nTest Town\\nTE57 1NG\",\"telephone\":\"01234567890\",\"website\":\"www.test.com\"}}},\"26\":[],\"27\":[\"2\"]}}','2018-10-16 11:35:50','2018-10-16 11:35:50','bd713127-9895-4854-b44c-3e044bf19533'),
	(24,6,2,17,1,16,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Scheme information\",\"slug\":\"scheme-information\",\"postDate\":1537285860,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"7\":{\"type\":\"regularCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\"],\"column\":\"2\",\"text\":\"<p>\\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \\nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \\nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \\ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \\nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \\nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \\nPellentesque habitant morbi tristique senectus et netus et malesuada \\nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \\nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \\nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \\nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \\ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\\n in nisl.\\n</p>\\n<p>\\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \\nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \\nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \\nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \\nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \\npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \\nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \\nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \\nsodales sem.\\n</p>\",\"customClass\":null}},\"18\":{\"type\":\"chartJs\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"column\":\"1\",\"chartData\":[{\"col1\":\"Data1\",\"col2\":\"60\",\"col3\":\"#da8102\"},{\"col1\":\"Data2\",\"col2\":\"30\",\"col3\":\"#071d49\"},{\"col1\":\"Data3\",\"col2\":\"10\",\"col3\":\"#b80e80\"}],\"chartType\":\"bar\",\"chartOptionsOverride\":null}}},\"26\":[],\"27\":[\"2\",\"3\",\"4\"]}}','2019-03-20 14:32:11','2019-03-20 14:32:11','9c19d229-29b4-450e-852d-5d0c6d91f654'),
	(25,6,2,17,1,17,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Scheme information\",\"slug\":\"scheme-information\",\"postDate\":1537285860,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"7\":{\"type\":\"regularCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\"],\"text\":\"<p>\\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \\nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \\nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \\ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \\nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \\nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \\nPellentesque habitant morbi tristique senectus et netus et malesuada \\nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \\nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \\nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \\nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \\ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\\n in nisl.\\n</p>\\n<p>\\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \\nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \\nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \\nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \\nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \\npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \\nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \\nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \\nsodales sem.\\n</p>\",\"customClass\":null}},\"19\":{\"type\":\"expander\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\"],\"expanderHeading\":\"This is only in an expander for active and deffered members\",\"closeOthers\":false,\"expanderEndcap\":false,\"customClass\":null}},\"18\":{\"type\":\"chartJs\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"chartData\":[{\"col1\":\"Data1\",\"col2\":\"60\",\"col3\":\"#da8102\"},{\"col1\":\"Data2\",\"col2\":\"30\",\"col3\":\"#071d49\"},{\"col1\":\"Data3\",\"col2\":\"10\",\"col3\":\"#b80e80\"}],\"chartType\":\"bar\",\"chartOptionsOverride\":null}},\"20\":{\"type\":\"expander\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\"],\"expanderHeading\":null,\"closeOthers\":false,\"expanderEndcap\":true,\"customClass\":null}}},\"26\":[],\"27\":[\"2\",\"3\",\"4\"]}}','2019-06-18 09:32:14','2019-06-18 09:32:14','2b15c285-b3c1-4aa3-8b5b-64e85383756d'),
	(26,6,2,17,1,18,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Scheme information\",\"slug\":\"scheme-information\",\"postDate\":1537285860,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"21\":{\"type\":\"column\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"columnClass\":\"col-md-6\"}},\"7\":{\"type\":\"regularCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\"],\"text\":\"<p>\\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \\nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \\nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \\ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \\nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \\nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \\nPellentesque habitant morbi tristique senectus et netus et malesuada \\nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \\nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \\nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \\nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \\ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\\n in nisl.\\n</p>\\n<p>\\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \\nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \\nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \\nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \\nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \\npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \\nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \\nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \\nsodales sem.\\n</p>\",\"customClass\":null}},\"22\":{\"type\":\"column\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"columnClass\":\"col-md-6\"}},\"19\":{\"type\":\"expander\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\"],\"expanderHeading\":\"This is only in an expander for active and deffered members\",\"closeOthers\":false,\"expanderEndcap\":false,\"customClass\":null}},\"18\":{\"type\":\"chartJs\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"chartData\":[{\"col1\":\"Data1\",\"col2\":\"60\",\"col3\":\"#da8102\"},{\"col1\":\"Data2\",\"col2\":\"30\",\"col3\":\"#071d49\"},{\"col1\":\"Data3\",\"col2\":\"10\",\"col3\":\"#b80e80\"}],\"chartType\":\"bar\",\"chartOptionsOverride\":null}},\"20\":{\"type\":\"expander\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\"],\"expanderHeading\":null,\"closeOthers\":false,\"expanderEndcap\":true,\"customClass\":null}}},\"26\":[],\"27\":[\"2\",\"3\",\"4\"]}}','2019-06-18 09:35:18','2019-06-18 09:35:18','35ea00b5-e181-40ed-adc9-fd20d612cc65'),
	(27,6,2,17,1,19,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Scheme information\",\"slug\":\"scheme-information\",\"postDate\":1537285860,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"21\":{\"type\":\"column\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"columnClass\":\"col-md-6\"}},\"7\":{\"type\":\"regularCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\"],\"text\":\"<p>\\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \\nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \\nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \\ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \\nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \\nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \\nPellentesque habitant morbi tristique senectus et netus et malesuada \\nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \\nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \\nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \\nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \\ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\\n in nisl.\\n</p>\\n<p>\\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \\nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \\nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \\nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \\nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \\npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \\nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \\nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \\nsodales sem.\\n</p>\",\"customClass\":null}},\"22\":{\"type\":\"column\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"columnClass\":\"col-md-6\"}},\"23\":{\"type\":\"regularCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"text\":\"<p>This is the second of two columns defined for md breakpoint and above using column blocks</p>\",\"customClass\":null}},\"19\":{\"type\":\"expander\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\"],\"expanderHeading\":\"This is only in an expander for active and deffered members\",\"closeOthers\":false,\"expanderEndcap\":false,\"customClass\":null}},\"18\":{\"type\":\"chartJs\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"chartData\":[{\"col1\":\"Data1\",\"col2\":\"60\",\"col3\":\"#da8102\"},{\"col1\":\"Data2\",\"col2\":\"30\",\"col3\":\"#071d49\"},{\"col1\":\"Data3\",\"col2\":\"10\",\"col3\":\"#b80e80\"}],\"chartType\":\"bar\",\"chartOptionsOverride\":null}},\"20\":{\"type\":\"expander\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\"],\"expanderHeading\":null,\"closeOthers\":false,\"expanderEndcap\":true,\"customClass\":null}}},\"26\":[],\"27\":[\"2\",\"3\",\"4\"]}}','2019-06-18 09:37:35','2019-06-18 09:37:35','906a4c0a-0087-4ca5-bb6e-c46f0e9fcb98'),
	(28,6,2,17,1,20,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Scheme information\",\"slug\":\"scheme-information\",\"postDate\":1537285860,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"21\":{\"type\":\"column\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"columnClass\":\"col-md-6\"}},\"7\":{\"type\":\"regularCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"text\":\"<p>\\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \\nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \\nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \\ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \\nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \\nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \\nPellentesque habitant morbi tristique senectus et netus et malesuada \\nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \\nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \\nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \\nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \\ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\\n in nisl.\\n</p>\\n<p>\\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \\nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \\nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \\nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \\nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \\npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \\nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \\nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \\nsodales sem.\\n</p>\",\"customClass\":null}},\"22\":{\"type\":\"column\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"columnClass\":\"col-md-6\"}},\"23\":{\"type\":\"regularCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"text\":\"<p>This is the second of two columns defined for md breakpoint and above using column blocks</p>\",\"customClass\":null}},\"19\":{\"type\":\"expander\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\"],\"expanderHeading\":\"This is only in an expander for active and deffered members\",\"closeOthers\":false,\"expanderEndcap\":false,\"customClass\":null}},\"18\":{\"type\":\"chartJs\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"chartData\":[{\"col1\":\"Data1\",\"col2\":\"60\",\"col3\":\"#da8102\"},{\"col1\":\"Data2\",\"col2\":\"30\",\"col3\":\"#071d49\"},{\"col1\":\"Data3\",\"col2\":\"10\",\"col3\":\"#b80e80\"}],\"chartType\":\"bar\",\"chartOptionsOverride\":null}},\"20\":{\"type\":\"expander\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\"],\"expanderHeading\":null,\"closeOthers\":false,\"expanderEndcap\":true,\"customClass\":null}}},\"26\":[],\"27\":[\"2\",\"3\",\"4\"]}}','2019-06-18 09:38:48','2019-06-18 09:38:48','e7863dd6-f2d9-4da6-9d5f-99f24a9d660f'),
	(29,6,2,17,1,21,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Scheme information\",\"slug\":\"scheme-information\",\"postDate\":1537285860,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"21\":{\"type\":\"column\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\"],\"columnClass\":\"col-md-6\"}},\"7\":{\"type\":\"regularCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"text\":\"<p>This is a one column page for Pensioners, check it out!</p><p>\\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \\nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \\nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \\ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \\nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \\nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \\nPellentesque habitant morbi tristique senectus et netus et malesuada \\nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \\nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \\nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \\nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \\ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\\n in nisl.\\n</p>\\n<p>\\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \\nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \\nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \\nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \\nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \\npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \\nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \\nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \\nsodales sem.\\n</p>\",\"customClass\":null}},\"22\":{\"type\":\"column\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\"],\"columnClass\":\"col-md-6\"}},\"23\":{\"type\":\"regularCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"text\":\"<p>This is the second of two columns defined for md breakpoint and above using column blocks</p>\",\"customClass\":null}},\"19\":{\"type\":\"expander\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\"],\"expanderHeading\":\"This is only in an expander for active and deffered members\",\"closeOthers\":false,\"expanderEndcap\":false,\"customClass\":null}},\"18\":{\"type\":\"chartJs\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"chartData\":[{\"col1\":\"Data1\",\"col2\":\"60\",\"col3\":\"#da8102\"},{\"col1\":\"Data2\",\"col2\":\"30\",\"col3\":\"#071d49\"},{\"col1\":\"Data3\",\"col2\":\"10\",\"col3\":\"#b80e80\"}],\"chartType\":\"bar\",\"chartOptionsOverride\":null}},\"20\":{\"type\":\"expander\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\"],\"expanderHeading\":null,\"closeOthers\":false,\"expanderEndcap\":true,\"customClass\":null}}},\"26\":[],\"27\":[\"2\",\"3\",\"4\"]}}','2019-06-18 09:52:55','2019-06-18 09:52:55','5491b2ae-49ad-4c7a-a909-172b645c29ac'),
	(30,6,2,17,1,22,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Scheme information\",\"slug\":\"scheme-information\",\"postDate\":1537285860,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"21\":{\"type\":\"column\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\"],\"columnClass\":\"col-md-6\"}},\"7\":{\"type\":\"regularCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"text\":\"<p>This is a one column page for Pensioners, check it out!</p>\\n<p>\\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \\nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \\nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \\ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \\nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \\nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \\nPellentesque habitant morbi tristique senectus et netus et malesuada \\nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \\nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \\nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \\nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \\ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\\n in nisl.\\n</p>\\n<p>\\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \\nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \\nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \\nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \\nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \\npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \\nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \\nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \\nsodales sem.\\n</p>\",\"customClass\":null}},\"22\":{\"type\":\"column\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\"],\"columnClass\":\"col-md-6\"}},\"23\":{\"type\":\"regularCopy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\"],\"text\":\"<p>This is the second of two columns defined for md breakpoint and above using column blocks. As a pensioner this is a one column page though, check it out!</p>\",\"customClass\":null}},\"19\":{\"type\":\"expander\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\"],\"expanderHeading\":\"This is only in an expander for active and deffered members\",\"closeOthers\":false,\"expanderEndcap\":false,\"customClass\":null}},\"18\":{\"type\":\"chartJs\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\",\"4\"],\"chartData\":[{\"col1\":\"Data1\",\"col2\":\"60\",\"col3\":\"#da8102\"},{\"col1\":\"Data2\",\"col2\":\"30\",\"col3\":\"#071d49\"},{\"col1\":\"Data3\",\"col2\":\"10\",\"col3\":\"#b80e80\"}],\"chartType\":\"bar\",\"chartOptionsOverride\":null}},\"20\":{\"type\":\"expander\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"audience\":[\"2\",\"3\"],\"expanderHeading\":null,\"closeOthers\":false,\"expanderEndcap\":true,\"customClass\":null}}},\"26\":[],\"27\":[\"2\",\"3\",\"4\"]}}','2019-06-18 09:54:02','2019-06-18 09:54:02','3df1087c-775f-4b52-ae71-8d5b95377572');

/*!40000 ALTER TABLE `cc1_entryversions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_fieldgroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_fieldgroups`;

CREATE TABLE `cc1_fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_fieldgroups_name_idx` (`name`),
  KEY `cc1_idx_wjfrfkcspgzkhvvifkszgmwgobwydnkqmmui` (`dateDeleted`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_fieldgroups` WRITE;
/*!40000 ALTER TABLE `cc1_fieldgroups` DISABLE KEYS */;

INSERT INTO `cc1_fieldgroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,'Common','2018-06-08 15:06:11','2018-06-08 15:06:11',NULL,'19f91227-b509-4907-9c91-9588a3b86198'),
	(2,'Meta Data','2018-09-18 14:27:00','2018-09-18 14:27:00',NULL,'1a3f503b-1ef7-4fcf-a7a1-5c428503eaf7');

/*!40000 ALTER TABLE `cc1_fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_fieldlayoutfields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_fieldlayoutfields`;

CREATE TABLE `cc1_fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `cc1_fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `cc1_fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `cc1_fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `cc1_fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `cc1_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `cc1_fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `cc1_fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `cc1_fieldlayoutfields` DISABLE KEYS */;

INSERT INTO `cc1_fieldlayoutfields` (`id`, `layoutId`, `tabId`, `fieldId`, `required`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(88,10,27,27,0,1,'2018-09-19 08:28:13','2018-09-19 08:28:13','85ed3853-eda1-491a-98de-a847effbd2e1'),
	(89,10,27,1,0,2,'2018-09-19 08:28:13','2018-09-19 08:28:13','5cd18f60-8211-4fd4-8859-5db670058054'),
	(90,10,28,24,0,1,'2018-09-19 08:28:13','2018-09-19 08:28:13','ddf371a4-dd7c-46cb-b675-7fb7abffc76f'),
	(91,10,28,25,0,2,'2018-09-19 08:28:13','2018-09-19 08:28:13','697738da-af8b-46f3-ae52-a138ec21f2f3'),
	(92,10,28,23,0,3,'2018-09-19 08:28:13','2018-09-19 08:28:13','84202777-bcda-4651-809a-3e61b7e589d5'),
	(93,10,28,26,0,4,'2018-09-19 08:28:13','2018-09-19 08:28:13','5166ad4c-dcf2-4c37-91ef-7f23191d162b'),
	(575,15,155,27,1,1,'2019-03-20 14:26:21','2019-03-20 14:26:21','075ba50a-4ef9-4da9-bf06-9f94be492465'),
	(576,15,155,1,0,2,'2019-03-20 14:26:21','2019-03-20 14:26:21','cdd82ada-2e14-434f-a007-46d09d6fcd4e'),
	(577,15,156,24,0,1,'2019-03-20 14:26:21','2019-03-20 14:26:21','dfe232cf-a81c-4952-a3ca-733cbae5638b'),
	(578,15,156,25,0,2,'2019-03-20 14:26:21','2019-03-20 14:26:21','4205e85f-6c71-4ca0-ad65-318469c09050'),
	(579,15,156,23,0,3,'2019-03-20 14:26:21','2019-03-20 14:26:21','3d906b14-e818-4ca9-adf8-54bda2207319'),
	(580,15,156,26,0,4,'2019-03-20 14:26:21','2019-03-20 14:26:21','0a89a50d-cb7d-49ba-9d1f-909b5a5f308c'),
	(1282,16,335,64,1,0,'2021-02-16 16:08:20','2021-02-16 16:08:20','22b73e3b-fb8f-41ba-b310-4bbb71281ffb'),
	(1283,16,335,65,1,1,'2021-02-16 16:08:20','2021-02-16 16:08:20','93f1ad09-273d-404f-badc-aa144823fc8b'),
	(1284,4,336,10,1,0,'2021-02-16 16:08:20','2021-02-16 16:08:20','0c0c7745-b257-4b42-b402-7355530c6c9e'),
	(1285,4,336,11,0,1,'2021-02-16 16:08:20','2021-02-16 16:08:20','fd7e156b-e84d-4b56-bcd1-bdc90f45213a'),
	(1286,4,336,72,1,2,'2021-02-16 16:08:20','2021-02-16 16:08:20','2039b2a8-ece4-40fe-9bc4-6a973dd7aa6d'),
	(1287,1,337,2,1,0,'2021-02-16 16:08:20','2021-02-16 16:08:20','79175c99-ba73-4a74-aabe-1cb8af844d4c'),
	(1288,1,337,3,1,1,'2021-02-16 16:08:20','2021-02-16 16:08:20','738214ce-0568-4cea-85c4-3ccc1d231b77'),
	(1289,1,337,30,0,2,'2021-02-16 16:08:20','2021-02-16 16:08:20','703f9030-77ff-4a5d-862e-8541360c9a0a'),
	(1290,2,338,4,1,0,'2021-02-16 16:08:20','2021-02-16 16:08:20','b392198c-c79c-4a61-855e-201f77040b0d'),
	(1291,2,338,5,1,1,'2021-02-16 16:08:20','2021-02-16 16:08:20','b262c6dd-b1c1-43c9-a8b5-da6e18f7b6ed'),
	(1292,2,338,6,1,2,'2021-02-16 16:08:20','2021-02-16 16:08:20','882b83fb-7b7e-4988-b9de-2b53da2e8941'),
	(1293,2,338,31,0,3,'2021-02-16 16:08:20','2021-02-16 16:08:20','90393fc2-6871-4337-a718-6d44a133b0cd'),
	(1294,5,339,14,1,0,'2021-02-16 16:08:20','2021-02-16 16:08:20','3bf4b9ab-f492-45c6-b940-07568beb313f'),
	(1295,5,339,15,1,1,'2021-02-16 16:08:20','2021-02-16 16:08:20','97120021-6672-481d-bded-5d19e4a43385'),
	(1296,5,339,16,1,2,'2021-02-16 16:08:20','2021-02-16 16:08:20','cb1046f0-0f87-4fe5-b0fc-111355f9b11a'),
	(1297,5,339,17,0,3,'2021-02-16 16:08:20','2021-02-16 16:08:20','d5b5a004-01b9-4120-a7c8-e2fcc139fce3'),
	(1298,5,339,33,0,4,'2021-02-16 16:08:20','2021-02-16 16:08:20','d60dc6b9-b894-46a1-9e4b-8bcb1b3db04c'),
	(1299,6,340,22,1,0,'2021-02-16 16:08:20','2021-02-16 16:08:20','ba0f5e3d-b239-47b6-983a-98ca4a781be6'),
	(1300,6,340,18,0,1,'2021-02-16 16:08:20','2021-02-16 16:08:20','833c1e71-4f24-4ba0-89a0-2ff4ad443e32'),
	(1301,6,340,19,0,2,'2021-02-16 16:08:20','2021-02-16 16:08:20','9368dae3-44dc-4e61-8cb6-0485a9a2b5c3'),
	(1302,6,340,20,0,3,'2021-02-16 16:08:20','2021-02-16 16:08:20','c5f4d1d3-1929-46c1-8a14-14f3482000e8'),
	(1303,6,340,21,0,4,'2021-02-16 16:08:20','2021-02-16 16:08:20','42b4b39d-f7e9-445c-b890-3d466040e68b'),
	(1304,6,340,34,0,5,'2021-02-16 16:08:20','2021-02-16 16:08:20','f1847f05-39b2-40f0-8788-060a3e237c70'),
	(1305,12,341,36,1,0,'2021-02-16 16:08:20','2021-02-16 16:08:20','5bf4dcfc-f87c-4366-bfbb-c4700502f633'),
	(1306,12,341,38,1,1,'2021-02-16 16:08:20','2021-02-16 16:08:20','45028921-4905-48c3-997d-dfa73a5e4c1f'),
	(1307,12,341,39,0,2,'2021-02-16 16:08:20','2021-02-16 16:08:20','f0643502-f6e1-48dd-98a7-82b206207f2a'),
	(1308,11,342,29,1,0,'2021-02-16 16:08:20','2021-02-16 16:08:20','82b8afa6-167a-4f93-9f5d-3ca7957d9762'),
	(1309,11,342,28,0,1,'2021-02-16 16:08:20','2021-02-16 16:08:20','acda8016-f505-4736-8d58-69a7c3e26a1e'),
	(1310,11,342,35,0,2,'2021-02-16 16:08:20','2021-02-16 16:08:20','6ecf78d5-3292-48d2-987c-d76ceb923a8d'),
	(1311,13,343,40,1,0,'2021-02-16 16:08:21','2021-02-16 16:08:21','fe27ad61-498e-41c8-bf79-57a563c8a5a8'),
	(1312,13,343,41,1,1,'2021-02-16 16:08:21','2021-02-16 16:08:21','373cfe1b-fe4f-401f-a486-dafc486f7c6d'),
	(1313,13,343,42,0,2,'2021-02-16 16:08:21','2021-02-16 16:08:21','aaf3803f-b7fb-49cb-b78c-82ce0ff00297'),
	(1314,17,344,73,1,0,'2021-02-16 16:08:21','2021-02-16 16:08:21','33a5fcde-fcc0-453d-87fc-27c11c9140f3'),
	(1315,17,344,74,1,1,'2021-02-16 16:08:21','2021-02-16 16:08:21','897b3669-ea7a-4c5c-b306-e13e8a502131'),
	(1316,17,344,75,0,2,'2021-02-16 16:08:21','2021-02-16 16:08:21','c2d677b6-901a-4fb6-8ec3-a89672d408cc');

/*!40000 ALTER TABLE `cc1_fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_fieldlayouts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_fieldlayouts`;

CREATE TABLE `cc1_fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_fieldlayouts_type_idx` (`type`),
  KEY `cc1_fieldlayouts_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_fieldlayouts` WRITE;
/*!40000 ALTER TABLE `cc1_fieldlayouts` DISABLE KEYS */;

INSERT INTO `cc1_fieldlayouts` (`id`, `type`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,'craft\\elements\\MatrixBlock','2018-06-08 15:21:41','2020-07-28 14:16:50',NULL,'b16a71f3-3d72-4a61-a074-efe92e3c96da'),
	(2,'craft\\elements\\MatrixBlock','2018-06-08 15:21:41','2020-07-28 14:16:50',NULL,'37e09d75-1883-4ad9-95cc-f19b4c4df308'),
	(3,'craft\\elements\\MatrixBlock','2018-06-08 15:21:41','2020-07-28 14:16:50','2021-02-16 16:08:18','0becca22-d02e-45cd-a891-bf1383abad07'),
	(4,'craft\\elements\\MatrixBlock','2018-06-08 15:21:41','2020-07-28 14:16:50',NULL,'367369ee-9647-438b-bf8b-ff4b3699b9c3'),
	(5,'craft\\elements\\MatrixBlock','2018-06-08 15:21:42','2020-07-28 14:16:50',NULL,'5c7ad637-6ad9-4478-b25a-57ad6546036f'),
	(6,'craft\\elements\\MatrixBlock','2018-06-08 15:21:42','2020-07-28 14:16:50',NULL,'bc2d5f4a-eabf-4945-9c59-7795e76095c8'),
	(7,'craft\\elements\\Category','2018-09-18 14:02:42','2018-09-18 14:02:42',NULL,'d5c3e2ff-f782-4699-aa03-79999ece0d02'),
	(8,'craft\\elements\\Entry','2018-09-18 14:24:27','2018-09-18 14:25:54',NULL,'148c2504-1d9e-43a4-a0c6-238ca6e45f90'),
	(9,'craft\\elements\\Asset','2018-09-18 15:44:56','2018-09-18 15:44:56',NULL,'80d391fe-4e2b-4a64-becb-e87ffdd3e01b'),
	(10,'craft\\elements\\Entry','2018-09-18 15:48:31','2018-09-19 08:28:13',NULL,'4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25'),
	(11,'craft\\elements\\MatrixBlock','2018-09-20 14:10:03','2020-07-28 14:16:50',NULL,'e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6'),
	(12,'craft\\elements\\MatrixBlock','2018-12-19 10:15:22','2020-07-28 14:16:50',NULL,'3bc7e98f-c970-40d1-b342-a1b1e130a8c6'),
	(13,'craft\\elements\\MatrixBlock','2018-12-19 10:15:22','2020-07-28 14:16:51',NULL,'f06db91c-fcf3-4bbe-bc18-932cf833e843'),
	(14,'craft\\elements\\MatrixBlock','2019-03-19 12:30:13','2020-07-28 14:16:51','2021-02-16 16:08:19','73835224-c8b5-4511-b1e5-161a2767ca00'),
	(15,'craft\\elements\\Entry','2019-03-20 14:26:21','2019-03-20 14:26:21','2021-02-16 16:41:54','bf37840d-fe71-4dc0-b95d-773c5dedc732'),
	(16,'craft\\elements\\MatrixBlock','2019-06-17 15:43:09','2020-07-28 14:16:50',NULL,'7f135f5d-7f7e-43c6-89c2-c9d314463bab'),
	(17,'craft\\elements\\MatrixBlock','2020-07-28 13:30:18','2020-07-28 14:16:51',NULL,'c615ba6a-f6ea-4cf0-9f48-6238b6f411a6'),
	(18,'craft\\elements\\Entry','2020-07-28 13:31:11','2020-07-28 13:47:25',NULL,'aaae58c0-9e7d-429f-9431-9aec827c0892');

/*!40000 ALTER TABLE `cc1_fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_fieldlayouttabs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_fieldlayouttabs`;

CREATE TABLE `cc1_fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `elements` text DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `cc1_fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `cc1_fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `cc1_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `cc1_fieldlayouttabs` DISABLE KEYS */;

INSERT INTO `cc1_fieldlayouttabs` (`id`, `layoutId`, `name`, `elements`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(27,10,'Common',NULL,1,'2018-09-19 08:28:13','2018-09-19 08:28:13','7c210e46-dc54-4821-9df6-983f52537455'),
	(28,10,'Meta Data',NULL,2,'2018-09-19 08:28:13','2018-09-19 08:28:13','b30a0c32-5e77-442d-ab2c-307c83275c5b'),
	(155,15,'Common',NULL,1,'2019-03-20 14:26:21','2019-03-20 14:26:21','2dead19a-5b66-4783-8f22-434ddfd8cdd3'),
	(156,15,'Meta Data',NULL,2,'2019-03-20 14:26:21','2019-03-20 14:26:21','aa530b3f-5080-4e9a-9ff7-2aaddd71ef05'),
	(327,3,'Content',NULL,1,'2020-07-28 14:16:50','2020-07-28 14:16:50','9245e6ee-13a5-4553-8efb-1a8cbbd370e5'),
	(332,14,'Content',NULL,1,'2020-07-28 14:16:51','2020-07-28 14:16:51','81b09505-d3a9-4eeb-ab6d-18464d1b3420'),
	(335,16,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"e5c6aa84-2b70-442a-8644-f770bd175f5e\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"1d688057-345a-422a-aa63-aa4a68a77b8e\"}]',1,'2021-02-16 16:08:20','2021-02-16 16:08:20','0494deb9-8251-4a13-9408-bf98ea02ab8f'),
	(336,4,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"beae91d9-6a66-4564-ad98-479dc01a8fa6\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"6f138b56-70c1-4f14-86c1-ce4dba2419a7\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5\"}]',1,'2021-02-16 16:08:20','2021-02-16 16:08:20','4c5b77cf-db4c-4ec3-a9ad-1678dd5a5b32'),
	(337,1,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"240c52e2-5b2b-44b4-b84a-2d9d7e52a166\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"a9bd9689-f1e0-4829-b0e8-30c6f5421e78\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"a2cabb95-d2eb-42f4-aa19-feb397936e1b\"}]',1,'2021-02-16 16:08:20','2021-02-16 16:08:20','7ce40297-ee7f-492c-a4df-b0482a7b8335'),
	(338,2,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"eedde671-8654-49cd-a5cf-f8c3e085622b\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"2c5024eb-d84d-48e9-b563-5fe3f04e492a\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"5f112cb5-ed35-4598-9eb1-91cf4dc530f9\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"b0b0e35d-5244-4c94-9703-16fdb54cdfb2\"}]',1,'2021-02-16 16:08:20','2021-02-16 16:08:20','54ba8dad-1fca-4082-a92a-3b1c8e65c485'),
	(339,5,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"beeb828c-dc5e-4e47-8c97-0f135bb9a04b\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"2e5c26cd-0323-4b2b-8396-94ac2fea5242\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"b796b2ec-27c8-4abe-8aad-b9e0f9b37604\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"fb6a0de8-332a-4630-b076-0f5d456ba62e\"}]',1,'2021-02-16 16:08:20','2021-02-16 16:08:20','060a9070-3ec4-49fc-a025-946ff0301d68'),
	(340,6,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"c6923d93-967e-4eca-9896-4fc4b0aef49b\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"32edc157-ef3f-482a-bb47-35a197e45492\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"6c7223b2-62a4-48a7-8b05-b43b380f5a56\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"b2dd979f-9ed1-424d-badc-8878aaa2eeeb\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"2a9d8e6a-029f-4644-9150-0b1e27e5ff69\"}]',1,'2021-02-16 16:08:20','2021-02-16 16:08:20','d5b3e099-0aa2-4a79-a012-2ca05846b99b'),
	(341,12,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"bdd9b8ca-edbb-4746-bb26-3956af7cfcc3\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"c587c76f-f9ae-48fd-afa5-954f3caf67ed\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"8a5f2409-1498-42af-949f-7dfa9ca4d51b\"}]',1,'2021-02-16 16:08:20','2021-02-16 16:08:20','2d522676-179e-4c57-994f-a870ef28ec46'),
	(342,11,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"760aa4ac-bb5c-4db3-b72d-2883f1e62b94\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"d21039a6-5a67-4877-8b49-1d312d245ed7\"}]',1,'2021-02-16 16:08:20','2021-02-16 16:08:20','06df6646-2ce4-46c6-ad7a-1a012739fc91'),
	(343,13,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"be63b0dc-b343-42c6-b6e5-4632786f15e1\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"f648a86b-dc9f-42cd-bf78-9849c5f82edc\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a\"}]',1,'2021-02-16 16:08:21','2021-02-16 16:08:21','e6f295cf-d72b-4144-9211-19e884cc021e'),
	(344,17,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"b4609297-ca56-4695-a83b-501b8cc00f69\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"198eace8-d3c2-49be-b3f1-73c39d079e46\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"3fa300c4-ea59-46b4-a8ce-3f73030ed3ce\"}]',1,'2021-02-16 16:08:21','2021-02-16 16:08:21','c8a2aca5-352b-4a7e-813a-3d28875d1f27');

/*!40000 ALTER TABLE `cc1_fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_fields`;

CREATE TABLE `cc1_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `columnSuffix` char(8) DEFAULT NULL,
  `instructions` text DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT 1,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_fields_groupId_idx` (`groupId`),
  KEY `cc1_fields_context_idx` (`context`),
  KEY `cc1_fields_handle_context_idx` (`handle`,`context`),
  CONSTRAINT `cc1_fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `cc1_fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_fields` WRITE;
/*!40000 ALTER TABLE `cc1_fields` DISABLE KEYS */;

INSERT INTO `cc1_fields` (`id`, `groupId`, `name`, `handle`, `context`, `columnSuffix`, `instructions`, `searchable`, `translationMethod`, `translationKeyFormat`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'Content Blocks','contentBlocks','global',NULL,'',1,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_contentblocks}}\",\"maxBlocks\":\"\",\"minBlocks\":\"\",\"propagationMethod\":\"all\"}','2018-06-08 15:21:40','2021-02-16 16:08:17','093fa743-22d4-484c-a853-1101eac54810'),
	(2,NULL,'Audience','audience','matrixBlockType:335eb808-1466-42d9-b578-c010b4ec1ee2',NULL,'Choose who can see this',1,'site',NULL,'craft\\fields\\Categories','{\"allowLimit\":false,\"allowMultipleSources\":false,\"allowSelfRelations\":false,\"branchLimit\":\"\",\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"showSiteMenu\":true,\"source\":\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\",\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2018-06-08 15:21:41','2021-02-16 16:08:20','240c52e2-5b2b-44b4-b84a-2d9d7e52a166'),
	(3,NULL,'Rich Text Field','text','matrixBlockType:335eb808-1466-42d9-b578-c010b4ec1ee2',NULL,'',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"cleanupHtml\":true,\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"\",\"removeEmptyTags\":\"1\",\"removeInlineStyles\":\"1\",\"removeNbsp\":\"1\",\"showHtmlButtonForNonAdmins\":\"\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":true,\"uiMode\":\"enlarged\"}','2018-06-08 15:21:41','2021-02-16 16:08:20','a9bd9689-f1e0-4829-b0e8-30c6f5421e78'),
	(4,NULL,'Audience','audience','matrixBlockType:8bf2bae8-96e9-4da1-a5be-17f5b24a90a7',NULL,'Choose who can see this',1,'site',NULL,'craft\\fields\\Categories','{\"allowLimit\":false,\"allowMultipleSources\":false,\"allowSelfRelations\":false,\"branchLimit\":\"\",\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"showSiteMenu\":true,\"source\":\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\",\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2018-06-08 15:21:41','2021-02-16 16:08:20','eedde671-8654-49cd-a5cf-f8c3e085622b'),
	(5,NULL,'Heading Text','headingText','matrixBlockType:8bf2bae8-96e9-4da1-a5be-17f5b24a90a7',NULL,'',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\",\"uiMode\":\"normal\"}','2018-06-08 15:21:41','2021-02-16 16:08:20','2c5024eb-d84d-48e9-b563-5fe3f04e492a'),
	(6,NULL,'Heading Level','headingLevel','matrixBlockType:8bf2bae8-96e9-4da1-a5be-17f5b24a90a7',NULL,'Choose a level from 2-6 (the page title is Heading Level 1). Sections and sub sections should be nested, e.g., Level 3s will be considered subsections of the previous Level 2.',1,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"Level 2\",\"value\":\"h2\",\"default\":\"1\"},{\"label\":\"Level 3\",\"value\":\"h3\",\"default\":\"\"},{\"label\":\"Level 4\",\"value\":\"h4\",\"default\":\"\"},{\"label\":\"Level 5\",\"value\":\"h5\",\"default\":\"\"},{\"label\":\"Level 6\",\"value\":\"h6\",\"default\":\"\"}]}','2018-06-08 15:21:41','2021-02-16 16:08:20','5f112cb5-ed35-4598-9eb1-91cf4dc530f9'),
	(10,NULL,'Audience','audience','matrixBlockType:895fd754-94d9-420d-b450-cd9e841217cf',NULL,'Choose who can see this',1,'site',NULL,'craft\\fields\\Categories','{\"allowLimit\":false,\"allowMultipleSources\":false,\"allowSelfRelations\":false,\"branchLimit\":\"\",\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"showSiteMenu\":true,\"source\":\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\",\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2018-06-08 15:21:41','2021-02-16 16:08:20','beae91d9-6a66-4564-ad98-479dc01a8fa6'),
	(11,NULL,'Expander heading','expanderHeading','matrixBlockType:895fd754-94d9-420d-b450-cd9e841217cf',NULL,'Heading for the expander',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\",\"uiMode\":\"normal\"}','2018-06-08 15:21:41','2021-02-16 16:08:20','6f138b56-70c1-4f14-86c1-ce4dba2419a7'),
	(14,NULL,'Audience','audience','matrixBlockType:8edc53d1-4c5f-43e9-abf3-8f33dd538f78',NULL,'Choose who can see this',1,'site',NULL,'craft\\fields\\Categories','{\"allowLimit\":false,\"allowMultipleSources\":false,\"allowSelfRelations\":false,\"branchLimit\":\"\",\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"showSiteMenu\":true,\"source\":\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\",\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2018-06-08 15:21:42','2021-02-16 16:08:20','beeb828c-dc5e-4e47-8c97-0f135bb9a04b'),
	(15,NULL,'Image','image','matrixBlockType:8edc53d1-4c5f-43e9-abf3-8f33dd538f78',NULL,'',1,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:3b244919-9ddb-4ed8-b47d-f3e626e7c0fa\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":true,\"singleUploadLocationSource\":\"volume:3b244919-9ddb-4ed8-b47d-f3e626e7c0fa\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":false,\"validateRelatedElements\":false,\"viewMode\":\"large\"}','2018-06-08 15:21:42','2021-02-16 16:08:20','2e5c26cd-0323-4b2b-8396-94ac2fea5242'),
	(16,NULL,'Description','altTag','matrixBlockType:8edc53d1-4c5f-43e9-abf3-8f33dd538f78',NULL,'A short description of what\'s in the image for visually impaired members.',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\",\"uiMode\":\"normal\"}','2018-06-08 15:21:42','2021-02-16 16:08:20','b796b2ec-27c8-4abe-8aad-b9e0f9b37604'),
	(17,NULL,'Caption','caption','matrixBlockType:8edc53d1-4c5f-43e9-abf3-8f33dd538f78',NULL,'Show a caption under the image. Leave blank if not required.',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\",\"uiMode\":\"normal\"}','2018-06-08 15:21:42','2021-02-16 16:08:20','7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85'),
	(18,NULL,'Email','email','matrixBlockType:c0cedc50-ca5f-42ed-963f-381bf873d16c',NULL,'',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\",\"uiMode\":\"normal\"}','2018-06-08 15:21:42','2021-02-16 16:08:20','88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b'),
	(19,NULL,'Postal Address','postalAddress','matrixBlockType:c0cedc50-ca5f-42ed-963f-381bf873d16c',NULL,'',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"5\",\"multiline\":\"1\",\"placeholder\":\"\",\"uiMode\":\"normal\"}','2018-06-08 15:21:42','2021-02-16 16:08:20','32edc157-ef3f-482a-bb47-35a197e45492'),
	(20,NULL,'Telephone','telephone','matrixBlockType:c0cedc50-ca5f-42ed-963f-381bf873d16c',NULL,'',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\",\"uiMode\":\"normal\"}','2018-06-08 15:21:42','2021-02-16 16:08:20','6c7223b2-62a4-48a7-8b05-b43b380f5a56'),
	(21,NULL,'Website','website','matrixBlockType:c0cedc50-ca5f-42ed-963f-381bf873d16c',NULL,'',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\",\"uiMode\":\"normal\"}','2018-06-08 15:21:42','2021-02-16 16:08:20','b2dd979f-9ed1-424d-badc-8878aaa2eeeb'),
	(22,NULL,'Audience','audience','matrixBlockType:c0cedc50-ca5f-42ed-963f-381bf873d16c',NULL,'Choose who can see this',1,'site',NULL,'craft\\fields\\Categories','{\"allowLimit\":false,\"allowMultipleSources\":false,\"allowSelfRelations\":false,\"branchLimit\":\"\",\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"showSiteMenu\":true,\"source\":\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\",\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2018-06-08 15:21:42','2021-02-16 16:08:20','c6923d93-967e-4eca-9896-4fc4b0aef49b'),
	(23,2,'Meta Title','metaTitle','global',NULL,'',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-09-18 14:27:13','2018-09-18 14:27:13','dc209373-ba42-457b-b966-9348d5dc2bd0'),
	(24,2,'Meta Description','metaDescription','global',NULL,'',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-09-18 14:27:35','2018-09-18 14:27:48','7440313c-7463-4420-9eb9-241d282c63e0'),
	(25,2,'Meta Robots','metaRobots','global',NULL,'',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-09-18 14:28:18','2018-09-18 14:28:18','e62d7067-3196-4b2d-9ca7-639bdc6d66e1'),
	(26,2,'Open Graph Image','openGraphImage','global',NULL,'',1,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":null,\"defaultUploadLocationSource\":null,\"defaultUploadLocationSubpath\":\"\",\"limit\":\"\",\"localizeRelations\":false,\"restrictFiles\":\"\",\"selectionLabel\":\"\",\"singleUploadLocationSource\":null,\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"list\"}','2018-09-18 14:29:40','2020-08-18 08:40:04','6fe97c8b-54af-45ab-8350-0e7d9b783087'),
	(27,1,'Page Audience','pageAudience','global',NULL,'',1,'site',NULL,'craft\\fields\\Categories','{\"branchLimit\":\"\",\"sources\":\"*\",\"source\":\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\",\"targetSiteId\":null,\"viewMode\":null,\"limit\":null,\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-09-18 16:07:33','2018-09-18 16:07:33','f1d06c4c-d798-495c-8897-846aeea5932c'),
	(28,NULL,'Mr Table','mrTable','matrixBlockType:32eb2020-0636-40c1-8e9d-4c1ceba0c3c6',NULL,'',1,'none',NULL,'supercool\\tablemaker\\fields\\TableMakerField','{\"columnsAddRowLabel\":\"\",\"columnsInstructions\":\"\",\"columnsLabel\":\"\",\"rowsAddRowLabel\":\"\",\"rowsInstructions\":\"\",\"rowsLabel\":\"\"}','2018-09-20 14:10:03','2021-02-16 16:08:20','760aa4ac-bb5c-4db3-b72d-2883f1e62b94'),
	(29,NULL,'Audience','audience','matrixBlockType:32eb2020-0636-40c1-8e9d-4c1ceba0c3c6',NULL,'',1,'site',NULL,'craft\\fields\\Categories','{\"allowLimit\":false,\"allowMultipleSources\":false,\"allowSelfRelations\":false,\"branchLimit\":\"\",\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"showSiteMenu\":true,\"source\":\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\",\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2018-09-20 15:08:59','2021-02-16 16:08:20','e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737'),
	(30,NULL,'Custom Class','customClass','matrixBlockType:335eb808-1466-42d9-b578-c010b4ec1ee2',NULL,'Attach one or more classes to this element separated by spaces',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"class-1 class-2\",\"uiMode\":\"normal\"}','2018-12-19 09:53:16','2021-02-16 16:08:20','a2cabb95-d2eb-42f4-aa19-feb397936e1b'),
	(31,NULL,'Custom Class','customClass','matrixBlockType:8bf2bae8-96e9-4da1-a5be-17f5b24a90a7',NULL,'Attach one or more classes to this element separated by spaces',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"class-1 class-2\",\"uiMode\":\"normal\"}','2018-12-19 09:53:16','2021-02-16 16:08:20','b0b0e35d-5244-4c94-9703-16fdb54cdfb2'),
	(33,NULL,'Custom Class','customClass','matrixBlockType:8edc53d1-4c5f-43e9-abf3-8f33dd538f78',NULL,'Attach one or more classes to this element separated by spaces',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"class-1 class-2\",\"uiMode\":\"normal\"}','2018-12-19 09:53:17','2021-02-16 16:08:20','fb6a0de8-332a-4630-b076-0f5d456ba62e'),
	(34,NULL,'Custom Class','customClass','matrixBlockType:c0cedc50-ca5f-42ed-963f-381bf873d16c',NULL,'Attach one or more classes to this element separated by spaces',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"class-1 class-2\",\"uiMode\":\"normal\"}','2018-12-19 09:53:17','2021-02-16 16:08:20','2a9d8e6a-029f-4644-9150-0b1e27e5ff69'),
	(35,NULL,'Custom Class','customClass','matrixBlockType:32eb2020-0636-40c1-8e9d-4c1ceba0c3c6',NULL,'Attach one or more classes to this element separated by spaces',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"class-1 class-2\",\"uiMode\":\"normal\"}','2018-12-19 09:53:17','2021-02-16 16:08:20','d21039a6-5a67-4877-8b49-1d312d245ed7'),
	(36,NULL,'Audience','audience','matrixBlockType:6658b45c-1dc5-4548-a40c-b31cf3270af7',NULL,'',1,'site',NULL,'craft\\fields\\Categories','{\"allowLimit\":false,\"allowMultipleSources\":false,\"allowSelfRelations\":false,\"branchLimit\":\"\",\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"showSiteMenu\":true,\"source\":\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\",\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2018-12-19 10:15:22','2021-02-16 16:08:20','bdd9b8ca-edbb-4746-bb26-3956af7cfcc3'),
	(38,NULL,'Table Data','tableData','matrixBlockType:6658b45c-1dc5-4548-a40c-b31cf3270af7',NULL,'Enter your table data; you can use \"null\" to merge with the preceding cell, or \"blank\" to leave a cutout where a cell would be.',1,'none',NULL,'supercool\\tablemaker\\fields\\TableMakerField','{\"columnsAddRowLabel\":\"\",\"columnsInstructions\":\"\",\"columnsLabel\":\"\",\"rowsAddRowLabel\":\"\",\"rowsInstructions\":\"\",\"rowsLabel\":\"\"}','2018-12-19 10:15:22','2020-08-18 08:40:04','c587c76f-f9ae-48fd-afa5-954f3caf67ed'),
	(39,NULL,'Custom Class','customClass','matrixBlockType:6658b45c-1dc5-4548-a40c-b31cf3270af7',NULL,'Attach one or more classes to this element separated by spaces',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"class-1 class-2\",\"uiMode\":\"normal\"}','2018-12-19 10:15:22','2021-02-16 16:08:20','8a5f2409-1498-42af-949f-7dfa9ca4d51b'),
	(40,NULL,'Audience','audience','matrixBlockType:c5697269-6f3a-43f6-801d-7331b4eb8d1f',NULL,'',1,'site',NULL,'craft\\fields\\Categories','{\"allowLimit\":false,\"allowMultipleSources\":false,\"allowSelfRelations\":false,\"branchLimit\":\"\",\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"showSiteMenu\":true,\"source\":\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\",\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2018-12-19 10:15:22','2021-02-16 16:08:20','be63b0dc-b343-42c6-b6e5-4632786f15e1'),
	(41,NULL,'Template Name','templateName','matrixBlockType:c5697269-6f3a-43f6-801d-7331b4eb8d1f',NULL,'The file name of the desired twig template, located in templates/_custom-blocks',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"template-name.twig\",\"uiMode\":\"normal\"}','2018-12-19 10:15:22','2021-02-16 16:08:21','f648a86b-dc9f-42cd-bf78-9849c5f82edc'),
	(42,NULL,'Custom Class','customClass','matrixBlockType:c5697269-6f3a-43f6-801d-7331b4eb8d1f',NULL,'Attach one or more classes to this element separated by spaces',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"class-1 class-2\",\"uiMode\":\"normal\"}','2018-12-19 10:17:17','2021-02-16 16:08:20','3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a'),
	(64,NULL,'Audience','audience','matrixBlockType:3fd02122-a67c-49b4-be89-00987f3f47ef',NULL,'',1,'site',NULL,'craft\\fields\\Categories','{\"allowLimit\":false,\"allowMultipleSources\":false,\"allowSelfRelations\":false,\"branchLimit\":\"\",\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"showSiteMenu\":true,\"source\":\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\",\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2019-06-17 15:43:09','2021-02-16 16:08:19','e5c6aa84-2b70-442a-8644-f770bd175f5e'),
	(65,NULL,'Column Class','columnClass','matrixBlockType:3fd02122-a67c-49b4-be89-00987f3f47ef',NULL,'Input a class or string of classes in Bootstrap 12-grid syntax to define this column',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\".col-md-6 .col-lg-4\",\"uiMode\":\"normal\"}','2019-06-17 15:43:09','2021-02-16 16:08:19','1d688057-345a-422a-aa63-aa4a68a77b8e'),
	(72,NULL,'Expander Attributes','expanderAttributes','matrixBlockType:895fd754-94d9-420d-b450-cd9e841217cf',NULL,'',1,'none',NULL,'craft\\fields\\MultiSelect','{\"multi\":true,\"optgroups\":true,\"options\":[{\"label\":\"Closes others\",\"value\":\"closesOthers\",\"default\":\"1\"},{\"label\":\"Defaults open\",\"value\":\"defaultsOpen\",\"default\":\"\"},{\"label\":\"Is endcap\",\"value\":\"isEndcap\",\"default\":\"\"}]}','2020-07-28 13:23:10','2021-02-16 16:08:20','0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5'),
	(73,NULL,'Audience','audience','matrixBlockType:08fbe61c-eb52-486c-8fb2-3fec0451c15c',NULL,'',1,'site',NULL,'craft\\fields\\Categories','{\"allowLimit\":false,\"allowMultipleSources\":false,\"allowSelfRelations\":false,\"branchLimit\":\"\",\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"showSiteMenu\":true,\"source\":\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\",\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2020-07-28 13:30:18','2021-02-16 16:08:21','b4609297-ca56-4695-a83b-501b8cc00f69'),
	(74,NULL,'Complex Entry','complexEntry','matrixBlockType:08fbe61c-eb52-486c-8fb2-3fec0451c15c',NULL,'',1,'site',NULL,'craft\\fields\\Entries','{\"allowSelfRelations\":false,\"limit\":\"1\",\"localizeRelations\":false,\"selectionLabel\":\"\",\"showSiteMenu\":true,\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2020-07-28 13:30:18','2021-02-16 16:08:21','198eace8-d3c2-49be-b3f1-73c39d079e46'),
	(75,NULL,'Custom Class','customClass','matrixBlockType:08fbe61c-eb52-486c-8fb2-3fec0451c15c',NULL,'',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\",\"uiMode\":\"normal\"}','2020-07-28 13:30:18','2021-02-16 16:08:21','3fa300c4-ea59-46b4-a8ce-3f73030ed3ce');

/*!40000 ALTER TABLE `cc1_fields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_globalsets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_globalsets`;

CREATE TABLE `cc1_globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `cc1_globalsets_name_idx` (`name`),
  KEY `cc1_globalsets_handle_idx` (`handle`),
  KEY `cc1_idx_fsccjduhergptztpjdzamqfuhonvfuracxhi` (`sortOrder`),
  CONSTRAINT `cc1_globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `cc1_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cc1_globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_gqlschemas
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_gqlschemas`;

CREATE TABLE `cc1_gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `isPublic` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_gqlschemas_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_gqlschemas` WRITE;
/*!40000 ALTER TABLE `cc1_gqlschemas` DISABLE KEYS */;

INSERT INTO `cc1_gqlschemas` (`id`, `name`, `scope`, `dateCreated`, `dateUpdated`, `uid`, `isPublic`)
VALUES
	(1,'Public Schema','[]','2021-02-16 16:05:58','2021-02-16 16:05:58','161d2128-bf6c-472d-9226-87d639514edd',1);

/*!40000 ALTER TABLE `cc1_gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_gqltokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_gqltokens`;

CREATE TABLE `cc1_gqltokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_gqltokens_schemaId_fk` (`schemaId`),
  CONSTRAINT `cc1_gqltokens_schemaId_fk` FOREIGN KEY (`schemaId`) REFERENCES `cc1_gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_gqltokens` WRITE;
/*!40000 ALTER TABLE `cc1_gqltokens` DISABLE KEYS */;

INSERT INTO `cc1_gqltokens` (`id`, `name`, `accessToken`, `enabled`, `expiryDate`, `lastUsed`, `schemaId`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Public Token','__PUBLIC__',0,NULL,NULL,1,'2020-08-18 08:40:15','2021-02-16 16:05:58','ef82272d-bbb3-42bd-84ad-6e9af50371a7');

/*!40000 ALTER TABLE `cc1_gqltokens` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_info`;

CREATE TABLE `cc1_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT 0,
  `configVersion` char(12) NOT NULL DEFAULT '000000000000',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_info` WRITE;
/*!40000 ALTER TABLE `cc1_info` DISABLE KEYS */;

INSERT INTO `cc1_info` (`id`, `version`, `schemaVersion`, `maintenance`, `configVersion`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'3.7.24','3.7.8',0,'iyhjqpxqgmsj','2@udgyvhbqaw','2018-06-08 15:06:10','2021-12-23 09:14:14','28d7ac2a-6d53-4a1d-8ec8-185ceade46a4');

/*!40000 ALTER TABLE `cc1_info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_matrixblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_matrixblocks`;

CREATE TABLE `cc1_matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_matrixblocks_ownerId_idx` (`ownerId`),
  KEY `cc1_matrixblocks_fieldId_idx` (`fieldId`),
  KEY `cc1_matrixblocks_typeId_idx` (`typeId`),
  KEY `cc1_matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `cc1_matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `cc1_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `cc1_matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_matrixblocks` WRITE;
/*!40000 ALTER TABLE `cc1_matrixblocks` DISABLE KEYS */;

INSERT INTO `cc1_matrixblocks` (`id`, `ownerId`, `fieldId`, `typeId`, `sortOrder`, `deletedWithOwner`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(7,6,1,1,2,NULL,'2018-09-18 15:54:03','2020-07-28 14:04:06','16f7c5dc-1619-473b-986c-b0cbebf89fed'),
	(9,8,1,1,1,NULL,'2018-09-19 10:43:18','2018-10-16 11:35:36','e2e3db6f-2977-4e74-ab4c-6e00900f9b90'),
	(11,10,1,1,1,NULL,'2018-09-19 10:52:51','2018-10-16 11:35:50','f550d092-b5b2-4c57-b271-1ddc8bfa8f40'),
	(12,10,1,2,2,NULL,'2018-09-19 10:52:51','2018-10-16 11:35:50','0f31c52a-c7e2-412c-9a1e-1741b7b3a4e1'),
	(14,10,1,4,4,NULL,'2018-09-19 10:52:51','2018-10-16 11:35:50','50133104-7a53-4076-92f7-73381411ab71'),
	(15,10,1,6,5,NULL,'2018-09-19 10:52:51','2018-10-16 11:35:50','30f99418-27de-4010-86e9-af776cc6e4fb'),
	(16,8,1,7,2,NULL,'2018-09-20 14:53:50','2018-10-16 11:35:36','79d5f5e2-af5c-4ee7-8d03-52ff371b021b'),
	(19,6,1,4,6,NULL,'2019-06-18 09:32:13','2020-07-28 14:04:06','424215f3-002b-48d6-ad75-d5fb0ced9b3d'),
	(20,6,1,4,8,NULL,'2019-06-18 09:32:13','2020-07-28 14:04:06','165ba5f7-537c-43ee-a317-ec4baec4cc61'),
	(21,6,1,11,1,NULL,'2019-06-18 09:35:18','2020-07-28 14:04:06','843e7c9b-3391-45d2-8ef9-bbf8909b96f8'),
	(22,6,1,11,4,NULL,'2019-06-18 09:35:18','2020-07-28 14:04:06','e3031541-e2db-40dc-8801-df344fb66b22'),
	(23,6,1,1,5,NULL,'2019-06-18 09:37:35','2020-07-28 14:04:06','d7a56a62-693c-44de-bab8-6674431a2773'),
	(25,6,1,9,9,NULL,'2020-07-28 13:34:03','2020-07-28 14:04:07','320f90dd-841a-401e-9c88-940bb2625b40'),
	(26,6,1,12,10,NULL,'2020-07-28 13:34:03','2020-07-28 14:04:07','a2822f45-653b-46ff-84ee-6e9e6df34dd8'),
	(27,6,1,8,3,NULL,'2020-07-28 14:04:06','2020-07-28 14:04:06','45b8d55c-3f8e-4a59-b2ad-69d9e6671d0c'),
	(31,30,1,11,1,NULL,'2020-08-18 08:40:20','2020-08-18 08:40:20','e22defb6-e33f-4071-8b14-9812e303091e'),
	(32,30,1,1,2,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','a0f7d6ac-c436-4dbe-8a0a-2b771e070490'),
	(33,30,1,8,3,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','a9ea7950-7e41-49a5-be48-41d97d621ccf'),
	(34,30,1,11,4,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','6c6ecf09-59d2-45ce-9c4f-d026a0195955'),
	(35,30,1,1,5,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','1863613d-cdda-46a1-b4d3-9e04ff21f3a1'),
	(36,30,1,4,6,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','ba3dc001-5442-4e9b-9bf0-23304fbc5d39'),
	(38,30,1,4,8,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','f9abf475-34cc-42d8-90fc-6b3c43560670'),
	(39,30,1,9,9,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','5cc75eb6-001c-4a22-a295-42c04c4daf9f'),
	(40,30,1,12,10,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','c0c49403-fbb7-496d-a4d0-4b63d80a219e'),
	(44,43,1,11,1,0,'2020-08-18 08:40:21','2020-08-18 08:40:21','84c50c1f-e0b4-45a6-ade1-9bdbbf09398f'),
	(45,43,1,1,2,0,'2020-08-18 08:40:21','2020-08-18 08:40:21','077a5607-3953-4553-8c86-9021f0fac73b'),
	(46,43,1,8,3,0,'2020-08-18 08:40:21','2020-08-18 08:40:21','fa342fa6-776b-4c07-868f-5902f799bbfe'),
	(47,43,1,11,4,0,'2020-08-18 08:40:21','2020-08-18 08:40:21','f0988aba-7804-45e8-bba8-349b81be67f2'),
	(48,43,1,1,5,0,'2020-08-18 08:40:21','2020-08-18 08:40:21','85734b9e-91b6-4c6d-a3ed-7c0f294388f5'),
	(49,43,1,4,6,0,'2020-08-18 08:40:21','2020-08-18 08:40:21','e57ed754-7afd-4d68-8f4a-15294088f164'),
	(51,43,1,4,8,0,'2020-08-18 08:40:21','2020-08-18 08:40:21','17d53b16-2591-4c45-8c31-4442df3985bf'),
	(52,43,1,9,9,0,'2020-08-18 08:40:21','2020-08-18 08:40:21','adcee775-2858-41b6-959a-1d8a5e651125'),
	(53,43,1,12,10,0,'2020-08-18 08:40:21','2020-08-18 08:40:21','429ca9b6-07e7-4f89-ab95-c7b71cd71f19'),
	(54,43,1,11,1,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','fa97dd54-81de-47cd-a2e2-f26d7f1d94fa'),
	(55,43,1,1,2,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','7cd26b9f-8fd8-4182-8031-739885deb3f5'),
	(56,43,1,11,3,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','c7a2a19e-4dfa-4a68-9ebb-e2bcad453e67'),
	(57,43,1,1,4,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','ec70eebc-824f-45ac-a5e1-c4f0d9bc60cc'),
	(58,43,1,4,5,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','206a37ba-1f1a-4a6e-8cfc-0699973027d2'),
	(60,43,1,4,7,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','e9bffc4f-2f77-4976-a04d-cb4cb7d201f8'),
	(61,43,1,9,8,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','4a516c72-b802-4bae-9576-d4e2a6c34198'),
	(62,43,1,12,9,NULL,'2020-08-18 08:40:21','2020-08-18 08:40:21','14e1a30e-7cae-480e-b34d-699d6636e116'),
	(65,64,1,11,1,0,'2020-08-18 08:40:22','2020-08-18 08:40:22','1c301019-7965-472f-9493-345273d70e1b'),
	(66,64,1,1,2,0,'2020-08-18 08:40:22','2020-08-18 08:40:22','7127d259-73d3-4a4e-823a-7ad325a59b53'),
	(67,64,1,11,3,0,'2020-08-18 08:40:22','2020-08-18 08:40:22','faa7713d-ed41-462a-9931-2cadceb91f98'),
	(68,64,1,1,4,0,'2020-08-18 08:40:22','2020-08-18 08:40:22','d1f248e9-201c-47b4-9492-8b25c8ce033c'),
	(69,64,1,4,5,0,'2020-08-18 08:40:22','2020-08-18 08:40:22','a857a7c7-348c-419c-aa2e-d17c31c48d19'),
	(71,64,1,4,7,0,'2020-08-18 08:40:22','2020-08-18 08:40:22','ba9171e5-428a-4ea6-b367-1d21a58b5641'),
	(72,64,1,9,8,0,'2020-08-18 08:40:22','2020-08-18 08:40:22','9fe3d45e-1765-4447-add8-df68c46ac867'),
	(73,64,1,12,9,0,'2020-08-18 08:40:22','2020-08-18 08:40:22','a2506f81-4c2e-4141-b574-3cac986b14e6'),
	(74,64,1,11,1,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','4e135a03-ae90-4162-afe7-740a303388fe'),
	(75,64,1,1,2,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','3f7b95a0-cd58-4b25-ae98-9079c9eb9ea3'),
	(76,64,1,11,3,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','0deda6c5-f6df-43c3-bb4d-0fef75ef7377'),
	(77,64,1,1,4,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','9caaec8d-8029-46f7-9204-a2d0db2effad'),
	(78,64,1,4,5,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','256a0fc0-365b-473d-9851-d7d68d40892a'),
	(80,64,1,4,7,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','49f998ae-2617-481d-aa42-c21013d83583'),
	(82,81,1,11,1,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','81bd4d2b-c922-4421-8f87-b1ba9460f92e'),
	(83,81,1,1,2,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','52ffc840-7721-4290-a4d7-939958e4e418'),
	(84,81,1,11,3,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','a309e0dc-38b9-4a2d-b67f-07499fb002b2'),
	(85,81,1,1,4,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','fbe50656-8cef-4291-bd56-5bcfe9e79162'),
	(86,81,1,4,5,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','e4ae87ba-7b4c-4a61-85fe-dcf848825a9d'),
	(88,81,1,4,7,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','b7349edc-d085-434f-9cb5-acecaf08c72e'),
	(90,89,1,11,1,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','08e7dd5d-793f-45d0-a0d4-c2ed5ac5aec6'),
	(91,89,1,1,2,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','ea635b65-dde6-4a41-850b-bae3d1e07a52'),
	(92,89,1,11,3,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','83265ad9-de58-49bc-ba19-d1e0fc9437c4'),
	(93,89,1,1,4,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','c7316bb3-34d7-4f2b-84fa-52c87dad3fa7'),
	(94,89,1,4,5,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','7e022d62-7480-4a98-8c20-96efdb06bd3c'),
	(96,89,1,4,7,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','e32aa263-9bfa-495a-9a09-c2106069e893'),
	(98,97,1,11,1,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','2921bd1d-b20f-47b1-81a7-4cd4c312517c'),
	(99,97,1,1,2,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','d3c49acb-e7e1-4d89-85e4-1c52513d6b85'),
	(100,97,1,11,3,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','7b15ceca-a739-444c-9071-57193bb97163'),
	(101,97,1,1,4,NULL,'2020-08-18 08:40:22','2020-08-18 08:40:22','f981f023-8c8f-4dfe-ba2b-1d3a1597f675'),
	(102,97,1,4,5,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','447aa7db-9621-4d18-9bf0-7497c636b1ec'),
	(104,97,1,4,7,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','d1f85264-3b30-408c-823f-b940f4b1a848'),
	(106,105,1,11,1,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','047ad100-b936-4333-8ecf-43812dfd6444'),
	(107,105,1,1,2,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','9b70fd84-a6aa-4698-9299-f534b4fbc194'),
	(108,105,1,11,3,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','8ee7e2f9-240b-420b-8b26-3a6c5197d77e'),
	(109,105,1,1,4,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','e154af4e-73f1-4896-a54a-18f5d9fa7728'),
	(110,105,1,4,5,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','b197075d-9a8f-4f8a-8963-1056fe8d8c97'),
	(112,105,1,4,7,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','a7a005ee-e9e2-4e10-9e3b-89082ebda93a'),
	(114,113,1,11,1,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','529d1c65-ec23-48aa-9b2a-75c065913c6d'),
	(115,113,1,1,2,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','787d2e32-2a67-4471-a933-babcc49afa8a'),
	(116,113,1,11,3,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','26bb3195-7b62-4d1f-8614-7bba8969d204'),
	(117,113,1,1,4,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','9edf967b-4699-4bce-b6c6-8dbc6fbbece8'),
	(118,113,1,4,5,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','2224acbf-db1c-4942-8d8b-89d8b894b045'),
	(120,113,1,4,7,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','ca6635c6-a641-4e9d-9bc3-f48685ca9045'),
	(122,121,1,11,1,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','54fb79a5-8e0e-47ec-bc10-4270febec23b'),
	(123,121,1,1,2,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','faa84de7-50fb-4a9b-bdbd-d91257df6536'),
	(124,121,1,11,3,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','0aaa9aec-2812-49b1-9e75-9f554f49192b'),
	(125,121,1,1,4,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','c3280f77-30bb-420b-81b0-5183bddb62fa'),
	(126,121,1,4,5,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','0f94cf43-4d1c-4c89-b661-e3dc3dcc6765'),
	(128,121,1,4,7,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','4f9c469c-10e8-4318-a5c9-9293de53a5d4'),
	(130,129,1,11,1,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','5f552c55-e01c-4b09-857d-99da3b65a6e1'),
	(131,129,1,1,2,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','b46e6ce3-4cf4-4b4d-8193-79b469f28d57'),
	(132,129,1,11,3,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','1387616f-f0b5-4863-bb3d-d9867950837d'),
	(133,129,1,1,4,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','bd07f1f8-8c48-4210-ac1a-fc458ba8c4d6'),
	(134,129,1,4,5,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','29235350-fbd8-4657-851e-347bfb82515e'),
	(136,129,1,4,7,NULL,'2020-08-18 08:40:23','2020-08-18 08:40:23','0403223f-ef33-4d4c-b9d5-4de3551b6c22'),
	(138,137,1,11,1,0,'2020-08-18 08:40:23','2020-08-18 08:40:23','d2e46684-bc06-44a9-983b-b81d18f8a463'),
	(139,137,1,1,2,0,'2020-08-18 08:40:23','2020-08-18 08:40:23','9f86ae7a-269c-4bb3-8328-245ebd007fd1'),
	(140,137,1,11,3,0,'2020-08-18 08:40:23','2020-08-18 08:40:23','5ec9c0bf-2387-4f69-ae8a-c6867f3dd971'),
	(141,137,1,1,4,0,'2020-08-18 08:40:24','2020-08-18 08:40:24','14b74794-dedd-484d-b7e1-9f579f0ac0fd'),
	(142,137,1,4,5,0,'2020-08-18 08:40:24','2020-08-18 08:40:24','1757e151-1331-47fa-9737-f7e05a134123'),
	(144,137,1,4,7,0,'2020-08-18 08:40:24','2020-08-18 08:40:24','6ab0d36c-dbc1-4baf-bc01-7e8de57dc246'),
	(145,137,1,1,1,NULL,'2020-08-18 08:40:24','2020-08-18 08:40:24','6450cf0a-60e0-426e-8d61-6f7b7c004b83'),
	(148,147,1,1,1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24','7de009e0-4c0b-4d7a-8b4f-ab6f4f73a4d0'),
	(150,147,1,1,1,NULL,'2020-08-18 08:40:24','2020-08-18 08:40:24','1f2edb8e-144b-430e-ae61-4573c7193bd6'),
	(153,152,1,1,1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24','471b6585-b523-4eab-a183-1b0c479746a4'),
	(155,152,1,1,1,NULL,'2020-08-18 08:40:24','2020-08-18 08:40:24','8fdef166-7c46-4186-bad7-3cbb2c7a66ab'),
	(158,157,1,1,1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24','315092d7-482e-409f-861c-fe97949f7e6e'),
	(160,157,1,1,1,NULL,'2020-08-18 08:40:24','2020-08-18 08:40:24','39ce7ecb-038e-4ca7-87e2-b532d71732d6'),
	(163,162,1,1,1,0,'2020-08-18 08:40:24','2020-08-18 08:40:24','9b139d99-f836-4750-a4ce-99ac1f15390f'),
	(165,162,1,1,1,NULL,'2020-08-18 08:40:24','2020-08-18 08:40:24','66fdaa08-15d5-42d3-98ea-a38fd7daed4e'),
	(168,167,1,1,1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25','dc1a5b9b-d877-4c18-8beb-30196d2d33c1'),
	(170,167,1,1,1,NULL,'2020-08-18 08:40:25','2020-08-18 08:40:25','e2f6ac39-2919-40c7-a4fe-def8c3e3a2a8'),
	(173,172,1,1,1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25','658773f5-2660-4552-ba67-0a251eabde7f'),
	(175,172,1,1,1,NULL,'2020-08-18 08:40:25','2020-08-18 08:40:25','f4fd8d15-933f-463a-b9b4-0a476dd20a0a'),
	(178,177,1,1,1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25','678a2ab1-9804-4330-9906-e0431a33c2a2'),
	(180,177,1,1,1,NULL,'2020-08-18 08:40:25','2020-08-18 08:40:25','7853a148-06d9-4fe1-b0d0-10bd03288c51'),
	(183,182,1,1,1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25','05f7ccb0-3cb2-4b68-8834-f6327ceb075c'),
	(185,182,1,1,1,NULL,'2020-08-18 08:40:25','2020-08-18 08:40:25','505647d0-90d4-432a-9168-9625652370c6'),
	(188,187,1,1,1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25','a1d36f50-a679-4dd3-8139-da4cc3c304a9'),
	(190,187,1,1,1,NULL,'2020-08-18 08:40:25','2020-08-18 08:40:25','eb7093b3-be1c-4a9c-ab24-2a8c2ab48c8c'),
	(193,192,1,1,1,0,'2020-08-18 08:40:25','2020-08-18 08:40:25','bbbbdefb-b3e0-4685-8e9f-74e922cea76c'),
	(195,192,1,1,1,NULL,'2020-08-18 08:40:26','2020-08-18 08:40:26','3456905d-4b14-4bdc-810d-3e79db95c634'),
	(198,197,1,1,1,0,'2020-08-18 08:40:26','2020-08-18 08:40:26','ddedbe45-558f-4800-80b8-ace85960a06b'),
	(200,197,1,1,1,NULL,'2020-08-18 08:40:26','2020-08-18 08:40:26','f8af4efc-04ad-460a-94bb-14dd2d968e51'),
	(203,202,1,1,1,NULL,'2020-08-18 08:40:26','2020-08-18 08:40:26','81b12541-2a5c-4611-9b8c-b8c26335b4c5'),
	(204,202,1,2,2,NULL,'2020-08-18 08:40:26','2020-08-18 08:40:26','6f4dc0ef-cfca-40d5-b1f4-6ebe0a2ea1a9'),
	(206,202,1,4,4,NULL,'2020-08-18 08:40:26','2020-08-18 08:40:26','7f300afd-0fa5-442d-8f7f-4caf344ecfa4'),
	(207,202,1,6,5,NULL,'2020-08-18 08:40:26','2020-08-18 08:40:26','ffad9c1c-d5a2-42c9-8ada-70061dcec911'),
	(209,208,1,1,1,NULL,'2020-08-18 08:40:26','2020-08-18 08:40:26','adbf11e5-0d7a-427c-9d22-6e6a4ff2e9e5'),
	(210,208,1,7,2,NULL,'2020-08-18 08:40:26','2020-08-18 08:40:26','dd17a980-085a-4b41-b2ce-b84723c66d3b'),
	(212,211,1,1,1,0,'2020-08-18 08:40:26','2020-08-18 08:40:26','63a32ebb-d9bf-4db0-b9dd-54f8e5734bee'),
	(213,211,1,7,2,0,'2020-08-18 08:40:26','2020-08-18 08:40:26','642854f8-d1a7-4dcc-9e2d-2708e6ffabb5'),
	(214,211,1,1,1,NULL,'2020-08-18 08:40:26','2020-08-18 08:40:26','ebc086d3-779c-4767-ac99-e7ce170b661f'),
	(215,211,1,8,2,NULL,'2020-08-18 08:40:26','2020-08-18 08:40:26','55048998-9a5a-4334-9093-4055bbc97d39'),
	(217,216,1,1,1,0,'2020-08-18 08:40:26','2020-08-18 08:40:26','ebdc27ba-f509-4da3-90e5-3258dd7ab03c'),
	(219,216,1,1,1,NULL,'2020-08-18 08:40:26','2020-08-18 08:40:26','4b730b46-3838-4fbf-92d5-70754ec8d4c9'),
	(221,220,1,1,1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27','751b7553-194c-4ce6-a93f-bff577dbd461'),
	(222,220,1,8,2,0,'2020-08-18 08:40:27','2020-08-18 08:40:27','c715c083-e7c4-409d-9e14-cc92d7ff9567'),
	(223,220,1,1,1,NULL,'2020-08-18 08:40:27','2020-08-18 08:40:27','a87855f8-66f4-4f7d-9a7d-8d7550c4a2ad'),
	(224,220,1,8,2,NULL,'2020-08-18 08:40:27','2020-08-18 08:40:27','a750cb07-5c93-41d6-867e-4325961bf294'),
	(226,225,1,1,1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27','d9041391-48c8-4b61-8dc3-9395a7f201d3'),
	(227,225,1,8,2,0,'2020-08-18 08:40:27','2020-08-18 08:40:27','b5cb97af-4159-4f49-89c9-2c49347b0cf2'),
	(228,225,1,1,1,NULL,'2020-08-18 08:40:27','2020-08-18 08:40:27','4fba04dd-f036-4ff8-87a3-9bb7f0a21579'),
	(229,225,1,8,2,NULL,'2020-08-18 08:40:27','2020-08-18 08:40:27','76477853-8234-4b8f-9d99-7de3029869c0'),
	(231,230,1,1,1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27','9cbd78dd-58ab-4046-a5db-6b7e8887b25a'),
	(232,230,1,8,2,0,'2020-08-18 08:40:27','2020-08-18 08:40:27','23c6e19f-2af1-44df-b154-6849a08d5a41'),
	(233,230,1,1,1,NULL,'2020-08-18 08:40:27','2020-08-18 08:40:27','54c2e69f-b8a8-438c-b716-513c8d63ab56'),
	(234,230,1,8,2,NULL,'2020-08-18 08:40:27','2020-08-18 08:40:27','45d43f56-ef85-4f4b-9a7b-ac49d285406d'),
	(236,235,1,1,1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27','34dab61a-8f00-4e0c-90f2-4276854a5f2c'),
	(237,235,1,2,2,0,'2020-08-18 08:40:27','2020-08-18 08:40:27','7352215c-d23c-48c5-aa8f-73f2307ce9f9'),
	(239,235,1,4,4,0,'2020-08-18 08:40:27','2020-08-18 08:40:27','17a5eec1-1dfc-4799-a2c8-69eef6c04b16'),
	(240,235,1,6,5,0,'2020-08-18 08:40:27','2020-08-18 08:40:27','a52bc228-8c0f-45ac-9018-53c031e88b95'),
	(241,235,1,1,1,NULL,'2020-08-18 08:40:27','2020-08-18 08:40:27','91d43bb0-c4e2-453c-878b-7bcaf536a7bd'),
	(242,235,1,2,2,NULL,'2020-08-18 08:40:27','2020-08-18 08:40:27','52b282b4-16d8-4cc2-9fe2-4258f186a825'),
	(244,235,1,6,4,NULL,'2020-08-18 08:40:27','2020-08-18 08:40:27','15ddb4be-abb5-44fa-b977-02487db13b29'),
	(246,245,1,1,1,0,'2020-08-18 08:40:27','2020-08-18 08:40:27','aed502cb-69e9-45ac-b39a-4bb0ce0df76d'),
	(247,245,1,8,2,0,'2020-08-18 08:40:27','2020-08-18 08:40:27','7317e205-e02d-4b20-9750-6a5a89178460'),
	(248,245,1,1,1,NULL,'2020-08-18 08:40:28','2020-08-18 08:40:28','09eb97b7-90bd-41a6-b268-618bdf704c9d'),
	(250,249,1,1,1,0,'2020-08-18 08:40:28','2020-08-18 08:40:28','765fb5dd-2229-4b1a-89b7-970436e26a97'),
	(251,249,1,1,1,NULL,'2020-08-18 08:40:28','2020-08-18 08:40:28','fe7a30f9-d1e9-41df-82c2-9954997c8e21'),
	(253,252,1,1,1,0,'2020-08-18 08:40:28','2020-08-18 08:40:28','ecab39fb-bf8a-4ceb-a108-c8d4a216f023'),
	(254,6,1,1,7,NULL,'2021-02-16 16:48:35','2021-02-16 16:48:35','1f17566c-b1ba-49f6-84de-9cfa811d4c84'),
	(256,255,1,11,1,NULL,'2021-02-16 16:48:35','2021-02-16 16:48:35','41a6a45d-2171-47ba-ba7d-b8a30fea9907'),
	(257,255,1,1,2,NULL,'2021-02-16 16:48:35','2021-02-16 16:48:35','4a5494dc-ac25-4056-82fb-9f90d6be29e3'),
	(258,255,1,8,3,NULL,'2021-02-16 16:48:35','2021-02-16 16:48:35','f1c6e388-f4db-4d03-85fb-3a0949bbe504'),
	(259,255,1,11,4,NULL,'2021-02-16 16:48:35','2021-02-16 16:48:35','6d272695-9edf-401f-a9c2-5fb1cac0bcee'),
	(260,255,1,1,5,NULL,'2021-02-16 16:48:35','2021-02-16 16:48:35','f5247b79-a6e7-4c3d-9144-6047567e90da'),
	(261,255,1,4,6,NULL,'2021-02-16 16:48:35','2021-02-16 16:48:35','9ed91244-53a7-46b1-b49b-0a8a1b9283b7'),
	(262,255,1,1,7,NULL,'2021-02-16 16:48:35','2021-02-16 16:48:35','8e22eb00-05ce-4560-a951-74fb8825a2bf'),
	(263,255,1,4,8,NULL,'2021-02-16 16:48:35','2021-02-16 16:48:35','cce11911-9b14-400b-9f1e-6e94adc39781'),
	(264,255,1,9,9,NULL,'2021-02-16 16:48:35','2021-02-16 16:48:35','034d9d70-972d-4e4d-b62a-066d49570825'),
	(265,255,1,12,10,NULL,'2021-02-16 16:48:35','2021-02-16 16:48:35','7c4c7553-f5e7-4147-ae07-c8f3d8bdb2d2');

/*!40000 ALTER TABLE `cc1_matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_matrixblocktypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_matrixblocktypes`;

CREATE TABLE `cc1_matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `cc1_matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `cc1_matrixblocktypes_name_fieldId_idx` (`name`,`fieldId`),
  KEY `cc1_matrixblocktypes_handle_fieldId_idx` (`handle`,`fieldId`),
  CONSTRAINT `cc1_matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `cc1_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `cc1_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `cc1_matrixblocktypes` DISABLE KEYS */;

INSERT INTO `cc1_matrixblocktypes` (`id`, `fieldId`, `fieldLayoutId`, `name`, `handle`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,'Regular Copy','regularCopy',3,'2018-06-08 15:21:41','2020-07-28 14:16:50','335eb808-1466-42d9-b578-c010b4ec1ee2'),
	(2,1,2,'Section Heading','sectionHeading',4,'2018-06-08 15:21:41','2020-07-28 14:16:50','8bf2bae8-96e9-4da1-a5be-17f5b24a90a7'),
	(4,1,4,'Expander','expander',2,'2018-06-08 15:21:41','2020-07-28 14:16:50','895fd754-94d9-420d-b450-cd9e841217cf'),
	(5,1,5,'Regular Image','regularImage',5,'2018-06-08 15:21:42','2021-02-16 16:08:20','8edc53d1-4c5f-43e9-abf3-8f33dd538f78'),
	(6,1,6,'Address','address',6,'2018-06-08 15:21:42','2021-02-16 16:08:20','c0cedc50-ca5f-42ed-963f-381bf873d16c'),
	(7,1,11,'Responsive Table','responsiveTable',8,'2018-09-20 14:10:02','2021-02-16 16:08:20','32eb2020-0636-40c1-8e9d-4c1ceba0c3c6'),
	(8,1,12,'Table','table',7,'2018-12-19 10:15:22','2021-02-16 16:08:20','6658b45c-1dc5-4548-a40c-b31cf3270af7'),
	(9,1,13,'Static Block','staticBlock',9,'2018-12-19 10:15:22','2021-02-16 16:08:21','c5697269-6f3a-43f6-801d-7331b4eb8d1f'),
	(11,1,16,'Column','column',1,'2019-06-17 15:43:09','2020-07-28 14:16:50','3fd02122-a67c-49b4-be89-00987f3f47ef'),
	(12,1,17,'Complex Block','complexBlock',10,'2020-07-28 13:30:18','2021-02-16 16:08:21','08fbe61c-eb52-486c-8fb2-3fec0451c15c');

/*!40000 ALTER TABLE `cc1_matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_matrixcontent_contentblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_matrixcontent_contentblocks`;

CREATE TABLE `cc1_matrixcontent_contentblocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_sectionHeading_headingText` text DEFAULT NULL,
  `field_sectionHeading_headingLevel` varchar(255) DEFAULT NULL,
  `field_expander_expanderHeading` text DEFAULT NULL,
  `field_expanderBlock_customClass` text DEFAULT NULL,
  `field_regularImage_altTag` text DEFAULT NULL,
  `field_regularImage_caption` text DEFAULT NULL,
  `field_address_email` text DEFAULT NULL,
  `field_address_postalAddress` text DEFAULT NULL,
  `field_address_telephone` text DEFAULT NULL,
  `field_address_website` text DEFAULT NULL,
  `field_regularCopy_text` text DEFAULT NULL,
  `field_expanderBlock_expanderText` text DEFAULT NULL,
  `field_responsiveTable_mrTable` text DEFAULT NULL,
  `field_regularCopy_customClass` text DEFAULT NULL,
  `field_sectionHeading_customClass` text DEFAULT NULL,
  `field_regularImage_customClass` text DEFAULT NULL,
  `field_address_customClass` text DEFAULT NULL,
  `field_responsiveTable_customClass` text DEFAULT NULL,
  `field_table_tableData` text DEFAULT NULL,
  `field_table_customClass` text DEFAULT NULL,
  `field_staticBlock_templateName` text DEFAULT NULL,
  `field_staticBlock_customClass` text DEFAULT NULL,
  `field_column_columnClass` text DEFAULT NULL,
  `field_expander_expanderAttributes` varchar(255) DEFAULT NULL,
  `field_complexBlock_customClass` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_matrixcontent_contentblocks_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `cc1_matrixcontent_contentblocks_siteId_fk` (`siteId`),
  CONSTRAINT `cc1_matrixcontent_contentblocks_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_matrixcontent_contentblocks_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `cc1_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_matrixcontent_contentblocks` WRITE;
/*!40000 ALTER TABLE `cc1_matrixcontent_contentblocks` DISABLE KEYS */;

INSERT INTO `cc1_matrixcontent_contentblocks` (`id`, `elementId`, `siteId`, `dateCreated`, `dateUpdated`, `uid`, `field_sectionHeading_headingText`, `field_sectionHeading_headingLevel`, `field_expander_expanderHeading`, `field_expanderBlock_customClass`, `field_regularImage_altTag`, `field_regularImage_caption`, `field_address_email`, `field_address_postalAddress`, `field_address_telephone`, `field_address_website`, `field_regularCopy_text`, `field_expanderBlock_expanderText`, `field_responsiveTable_mrTable`, `field_regularCopy_customClass`, `field_sectionHeading_customClass`, `field_regularImage_customClass`, `field_address_customClass`, `field_responsiveTable_customClass`, `field_table_tableData`, `field_table_customClass`, `field_staticBlock_templateName`, `field_staticBlock_customClass`, `field_column_columnClass`, `field_expander_expanderAttributes`, `field_complexBlock_customClass`)
VALUES
	(1,7,1,'2018-09-18 15:54:03','2021-02-16 16:48:34','83cb9404-1b81-449b-bb21-0d45b8bab040',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is a one column page for Pensioners, check it out!</p>\n<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(2,9,1,'2018-09-19 10:43:18','2018-10-16 11:35:36','857269a6-2c51-45dd-a69b-ab9b995d49dc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Cras tempus dolor at luctus ultrices. Suspendisse aliquam, elit sit amet\n finibus mattis, diam quam gravida orci, eu efficitur odio quam at \npurus. Cras tellus augue, ultrices finibus ligula elementum, maximus \nullamcorper urna. Fusce malesuada ut urna ut auctor. Nulla lacinia \nlacinia facilisis. Curabitur urna augue, tristique non commodo vitae, \ndictum et neque. Maecenas scelerisque, augue eget volutpat molestie, \neros magna malesuada justo, nec cursus elit lacus sit amet turpis. \nAenean elit est, consectetur vel diam id, tincidunt accumsan tellus. \nInteger nec fermentum arcu. Sed felis sem, pretium ac vestibulum eu, \nvehicula sit amet lacus. Quisque a feugiat metus. Duis feugiat nulla id \nnisi tincidunt, at tempus libero facilisis. Donec blandit dapibus \nmauris, eget malesuada augue sodales in.\n</p>\n<h2>Lorem ipsum heading 2<br /></h2>\n<p>Nam congue risus imperdiet, varius ex ac, venenatis odio. Lorem ipsum \ndolor sit amet, consectetur adipiscing elit. Sed at interdum arcu. Duis \neu semper urna. Ut tellus nibh, elementum non quam ut, commodo pulvinar \nnisl. Etiam dapibus diam dolor, ut ullamcorper felis rutrum non. Aenean \nplacerat metus enim. Donec varius, massa vel posuere vulputate, ligula \nurna hendrerit ipsum, ut ornare urna mauris id mi.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(3,11,1,'2018-09-19 10:52:51','2018-10-16 11:35:50','d4eff52f-d242-47b5-b680-57ee783458b2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Fusce sollicitudin, eros vitae luctus ultrices, sapien elit lobortis est, non pellentesque tortor libero vehicula mauris. Donec rutrum purus id lectus mattis viverra. Maecenas aliquam porttitor erat, eget molestie neque. Vestibulum fermentum augue id leo mollis, blandit dignissim elit porta. Sed eget neque enim. Sed porta libero nec lectus tristique tristique. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus vestibulum non magna eget faucibus.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(4,12,1,'2018-09-19 10:52:51','2018-10-16 11:35:50','da4facf5-4777-4038-b5d6-2eca08b0f120','Section heading 3','h3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(5,13,1,'2018-09-19 10:52:51','2018-10-16 11:35:50','1320fe49-ee56-45bb-b941-4114335bc2a6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(6,14,1,'2018-09-19 10:52:51','2018-10-16 11:35:50','3c99c6a5-a726-4767-a1bb-ee0cd27fbca0',NULL,NULL,'Expander block heading',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Suspendisse vitae ultrices metus. Nulla ac bibendum dui. In efficitur felis eu orci laoreet posuere. Mauris vestibulum dapibus velit, nec mattis tellus tempus sit amet. </p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(7,15,1,'2018-09-19 10:52:51','2018-10-16 11:35:50','683a3b76-9ae3-4d53-b8cb-c67c175756fa',NULL,NULL,NULL,NULL,NULL,NULL,'test@test.com','Test 123\nTest Road\nTest Town\nTE57 1NG','01234567890','www.test.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(8,16,1,'2018-09-20 14:53:50','2018-10-16 11:35:36','bc4743fe-906e-4a30-a3e6-573fa8b528cb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"columns\":[{\"heading\":\"Column 1\",\"width\":\"\",\"align\":\"left\"},{\"heading\":\"Column 2\",\"width\":\"\",\"align\":\"left\"},{\"heading\":\"Column 3\",\"width\":\"\",\"align\":\"left\"}],\"rows\":[[\"Mickey\",\"Pluto\",\"Donald\"],[\"Mouse\",\"Dog\",\"Duck\"],[\"1928\",\"1930\",\"1934\"],[\"Steamboat Willie\",\"The Chain Gang\",\"The Wise Little Hen\"]],\"table\":\"\\n            <table>\\n                <thead>\\n                    <tr>\\n        <th align=\\\"left\\\" width=\\\"\\\">Column 1</th><th align=\\\"left\\\" width=\\\"\\\">Column 2</th><th align=\\\"left\\\" width=\\\"\\\">Column 3</th>\\n                    </tr>\\n                </thead>\\n\\n                <tbody>\\n\\n        <tr><td align=\\\"left\\\">Mickey</td><td align=\\\"left\\\">Pluto</td><td align=\\\"left\\\">Donald</td></tr><tr><td align=\\\"left\\\">Mouse</td><td align=\\\"left\\\">Dog</td><td align=\\\"left\\\">Duck</td></tr><tr><td align=\\\"left\\\">1928</td><td align=\\\"left\\\">1930</td><td align=\\\"left\\\">1934</td></tr><tr><td align=\\\"left\\\">Steamboat Willie</td><td align=\\\"left\\\">The Chain Gang</td><td align=\\\"left\\\">The Wise Little Hen</td></tr>\\n\\n                </tbody>\\n\\n            </table>\\n        \"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(9,18,1,'2019-03-20 09:18:13','2020-07-28 14:04:06','2378d66c-b6f2-4043-a0bc-50ca4e369f1e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(10,19,1,'2019-06-18 09:32:13','2021-02-16 16:48:34','909f53c6-dd8a-4c40-b632-7a5da3b7d8d0',NULL,NULL,'This is only an expander for Active and Deferred members',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"closesOthers\"]',NULL),
	(11,20,1,'2019-06-18 09:32:13','2021-02-16 16:48:35','441c93fd-3be8-4e39-832b-b924ece9638a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"isEndcap\"]',NULL),
	(12,21,1,'2019-06-18 09:35:18','2021-02-16 16:48:34','cc7e0b18-b149-482f-81ab-a4d31a6b33ba',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(13,22,1,'2019-06-18 09:35:18','2021-02-16 16:48:34','7a8e75a5-a75d-4164-8992-8bf8a374a906',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(14,23,1,'2019-06-18 09:37:35','2021-02-16 16:48:34','a1869c23-d0ad-4e4c-9a7a-504503d83cab',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is the second of two columns defined for md breakpoint and above using column blocks. As a pensioner this is a one column page though, check it out!</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(15,25,1,'2020-07-28 13:34:03','2021-02-16 16:48:35','e1f9a51e-fa16-4281-b4ab-9eefefe7ddb6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'static-block-example',NULL,NULL,NULL,NULL),
	(16,26,1,'2020-07-28 13:34:03','2021-02-16 16:48:35','ddefcb9b-7774-4bc9-acf7-3dad182ef917',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(17,27,1,'2020-07-28 14:04:06','2021-02-16 16:48:34','1ee8cf2d-39c1-410d-85ed-39f1421084a7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"columns\":[{\"heading\":\"blank\",\"width\":\"\",\"align\":\"left\"},{\"heading\":\"Here\'s a table with extra functionality\",\"width\":\"\",\"align\":\"left\"},{\"heading\":\"null\",\"width\":\"\",\"align\":\"left\"}],\"rows\":[[\"Cell 1\",\"Cell 2\",\"Cell 3\"],[\"Cell 1 and 2\",\"null\",\"Cell 3\"]],\"table\":\"\\n            <table>\\n                <thead>\\n                    <tr>\\n        <th align=\\\"left\\\" width=\\\"\\\">blank</th><th align=\\\"left\\\" width=\\\"\\\">Here\'s a table with extra functionality</th><th align=\\\"left\\\" width=\\\"\\\">null</th>\\n                    </tr>\\n                </thead>\\n\\n                <tbody>\\n\\n        <tr><td align=\\\"left\\\">Cell 1</td><td align=\\\"left\\\">Cell 2</td><td align=\\\"left\\\">Cell 3</td></tr><tr><td align=\\\"left\\\">Cell 1 and 2</td><td align=\\\"left\\\">null</td><td align=\\\"left\\\">Cell 3</td></tr>\\n\\n                </tbody>\\n\\n            </table>\\n        \"}',NULL,NULL,NULL,NULL,NULL,NULL),
	(18,31,1,'2020-08-18 08:40:20','2020-08-18 08:40:21','6052caec-8ac8-4e8e-aaa5-4562d755c8ae',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(19,32,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','e031fc43-643b-4793-a444-ae779de0f985',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is a one column page for Pensioners, check it out!</p>\n<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(20,33,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','c0bea8df-29a0-446c-89c4-4284af5ec406',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"columns\":[{\"heading\":\"blank\",\"width\":\"\",\"align\":\"left\"},{\"heading\":\"Here\'s a table with extra functionality\",\"width\":\"\",\"align\":\"left\"},{\"heading\":\"null\",\"width\":\"\",\"align\":\"left\"}],\"rows\":[[\"Cell 1\",\"Cell 2\",\"Cell 3\"],[\"Cell 1 and 2\",\"null\",\"Cell 3\"]],\"table\":\"\\n            <table>\\n                <thead>\\n                    <tr>\\n        <th align=\\\"left\\\" width=\\\"\\\">blank</th><th align=\\\"left\\\" width=\\\"\\\">Here\'s a table with extra functionality</th><th align=\\\"left\\\" width=\\\"\\\">null</th>\\n                    </tr>\\n                </thead>\\n\\n                <tbody>\\n\\n        <tr><td align=\\\"left\\\">Cell 1</td><td align=\\\"left\\\">Cell 2</td><td align=\\\"left\\\">Cell 3</td></tr><tr><td align=\\\"left\\\">Cell 1 and 2</td><td align=\\\"left\\\">null</td><td align=\\\"left\\\">Cell 3</td></tr>\\n\\n                </tbody>\\n\\n            </table>\\n        \"}',NULL,NULL,NULL,NULL,NULL,NULL),
	(21,34,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','3695f824-100b-4f16-b816-e7eccd2ac9f8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(22,35,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','b3d18665-ac8c-4861-baae-ee8e3993d290',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is the second of two columns defined for md breakpoint and above using column blocks. As a pensioner this is a one column page though, check it out!</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(23,36,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','5d6d1095-d88b-4026-8e19-c7bf4f2e215a',NULL,NULL,'This is only in an expander for active and deffered members',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"closesOthers\"]',NULL),
	(24,37,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','25ae0007-4f8a-4288-88af-7760591b9927',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(25,38,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','bccaf6df-847b-46f5-a3b9-c356aeac1eb3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"isEndcap\"]',NULL),
	(26,39,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','29c740be-6eb7-4823-9687-b3ef4fb26143',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'static-block-example',NULL,NULL,NULL,NULL),
	(27,40,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','7192a810-4067-4418-ba46-278a8ca5df11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(28,44,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','4f3759e3-3bd6-4824-9384-052f237e2fe2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(29,45,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','f8f31c8a-26ac-4f19-a864-bddc47588641',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is a one column page for Pensioners, check it out!</p>\n<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(30,46,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','d7cb297f-0b9a-4d3b-80d4-3a03de1726c2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"columns\":[{\"heading\":\"blank\",\"width\":\"\",\"align\":\"left\"},{\"heading\":\"Here\'s a table with extra functionality\",\"width\":\"\",\"align\":\"left\"},{\"heading\":\"null\",\"width\":\"\",\"align\":\"left\"}],\"rows\":[[\"Cell 1\",\"Cell 2\",\"Cell 3\"],[\"Cell 1 and 2\",\"null\",\"Cell 3\"]],\"table\":\"\\n            <table>\\n                <thead>\\n                    <tr>\\n        <th align=\\\"left\\\" width=\\\"\\\">blank</th><th align=\\\"left\\\" width=\\\"\\\">Here\'s a table with extra functionality</th><th align=\\\"left\\\" width=\\\"\\\">null</th>\\n                    </tr>\\n                </thead>\\n\\n                <tbody>\\n\\n        <tr><td align=\\\"left\\\">Cell 1</td><td align=\\\"left\\\">Cell 2</td><td align=\\\"left\\\">Cell 3</td></tr><tr><td align=\\\"left\\\">Cell 1 and 2</td><td align=\\\"left\\\">null</td><td align=\\\"left\\\">Cell 3</td></tr>\\n\\n                </tbody>\\n\\n            </table>\\n        \"}',NULL,NULL,NULL,NULL,NULL,NULL),
	(31,47,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','5e14a12f-71d1-4e7b-bd06-17b0d53517bb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(32,48,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','54aa7471-e1e5-4140-9bbd-6a92c7839cf7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is the second of two columns defined for md breakpoint and above using column blocks. As a pensioner this is a one column page though, check it out!</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(33,49,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','dad53449-7e3c-44a7-ada9-af976ac57c18',NULL,NULL,'This is only in an expander for active and deffered members',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"closesOthers\"]',NULL),
	(34,50,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','f19a25d3-4406-4f2d-aa8a-fa37ec5fa6a4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(35,51,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','f7d44708-8920-4855-84ee-f71b8d3dfb0a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"isEndcap\"]',NULL),
	(36,52,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','040088f0-4953-44c6-b19b-cc2d0a8c7eab',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'static-block-example',NULL,NULL,NULL,NULL),
	(37,53,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','5d9e5a97-71a4-4515-8da3-922a5c459a31',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(38,54,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','f1a08546-e667-437b-ab96-9fb45943dd69',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(39,55,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','7abb6c1f-b0a3-4b53-840f-e366c3bc0288',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is a one column page for Pensioners, check it out!</p>\n<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(40,56,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','35bdf5ca-edc1-435a-b03a-b90956e83335',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(41,57,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','76386da7-818c-4db1-99eb-ebcd7d926c62',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is the second of two columns defined for md breakpoint and above using column blocks. As a pensioner this is a one column page though, check it out!</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(42,58,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','b2106ae6-4a24-4374-a354-c025a9e73067',NULL,NULL,'This is only in an expander for active and deffered members',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"closesOthers\"]',NULL),
	(43,59,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','43e3355f-12d5-4cb7-aeee-c4078762df6d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(44,60,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','d106d59b-30a2-4b96-80ed-628b59db7c5a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"isEndcap\"]',NULL),
	(45,61,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','7419c012-56e3-4bfa-aa68-4a762b31a82e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'static-block-example',NULL,NULL,NULL,NULL),
	(46,62,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','db607f76-2b8f-477a-9fb4-27b2cee59aa9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(47,65,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','7c2a0dfe-fd56-45d1-8e7a-dc3d8c1b5c9b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(48,66,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','e1ee6230-bbf9-4dd7-b3da-a8003942776d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is a one column page for Pensioners, check it out!</p>\n<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(49,67,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','c9457c2c-ef9d-4345-aca9-11b1451a470e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(50,68,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','b96ab2cf-e9f9-4936-bbab-7634f2d57163',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is the second of two columns defined for md breakpoint and above using column blocks. As a pensioner this is a one column page though, check it out!</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(51,69,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','df72405a-57b2-493c-9d20-77131e5ec687',NULL,NULL,'This is only in an expander for active and deffered members',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"closesOthers\"]',NULL),
	(52,70,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','5fb667b6-cd81-4193-a05c-66ccae4da5c1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(53,71,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','f81b7d35-4c7f-45b9-b59d-127d6b9748d4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"isEndcap\"]',NULL),
	(54,72,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','b03506a9-68e2-429a-b053-2f038cfe02f6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'static-block-example',NULL,NULL,NULL,NULL),
	(55,73,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','e21bce28-fd5e-458f-8ea4-2daddd7c5010',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(56,74,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','58773a89-cfff-41a6-a69a-b7c7f70644a1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(57,75,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','10a28c63-acce-4ffe-b603-261e8c1b7c8f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is a one column page for Pensioners, check it out!</p>\n<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(58,76,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','7e4a716c-46a7-41c9-86d8-65e52b5a256f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(59,77,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','73ac5a38-a048-4054-aac4-2f3942ce55fe',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is the second of two columns defined for md breakpoint and above using column blocks. As a pensioner this is a one column page though, check it out!</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(60,78,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','c6404d8d-f75a-409c-bf02-e64c0a7cddbc',NULL,NULL,'This is only in an expander for active and deffered members',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"closesOthers\"]',NULL),
	(61,79,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','7cbe2888-1078-44e2-9fa8-e38e77afdc4b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(62,80,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','22724970-42e2-4e1c-8999-1a838bb2e008',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"isEndcap\"]',NULL),
	(63,82,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','d323c949-a366-41b4-a7a1-1155846df549',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(64,83,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','a8f37bd1-c042-4802-b1e5-90a915c36899',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is a one column page for Pensioners, check it out!</p>\n<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(65,84,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','8788e0ea-8770-44b0-b03d-a743f10997a6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(66,85,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','40d27325-355e-4c7c-9a09-6d031702acda',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is the second of two columns defined for md breakpoint and above using column blocks. As a pensioner this is a one column page though, check it out!</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(67,86,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','f01d742e-d5b3-43e9-9771-7b2d59a2f73a',NULL,NULL,'This is only in an expander for active and deffered members',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"closesOthers\"]',NULL),
	(68,87,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','19233a7a-9f51-4902-ae65-65e997993b9c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(69,88,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','590cc72d-fdd1-4aec-a2cf-a4adcb53749d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"isEndcap\"]',NULL),
	(70,90,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','aeb26f0b-0f31-4a8f-83d4-8813d0667329',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(71,91,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','f1c0d1a8-16ae-4673-b30a-02b2e2efa224',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is a one column page for Pensioners, check it out!</p>\n<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(72,92,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','ac4967e9-bcd8-446b-8c5c-232e713a6118',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(73,93,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','8263cd2a-476a-4f02-a3af-c0ddcc999503',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is the second of two columns defined for md breakpoint and above using column blocks. As a pensioner this is a one column page though, check it out!</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(74,94,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','b636dccb-9443-4f60-9fd6-8fb1e2504c35',NULL,NULL,'This is only in an expander for active and deffered members',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"closesOthers\"]',NULL),
	(75,95,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','36e57c7e-e7a0-4f0c-92f0-c35dd642e074',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(76,96,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','0a83aee6-2470-4762-9077-80fe7edbaed8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"isEndcap\"]',NULL),
	(77,98,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','ab595626-ddf2-4d90-bcf6-30cc304d8d4a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(78,99,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','077acc15-9f36-4604-ac94-e46c327db9a4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is a one column page for Pensioners, check it out!</p>\n<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(79,100,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','08c1bb35-534f-490f-9639-1718b3fef060',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(80,101,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','9d44af19-c612-4cb9-a990-d3b13fad52b2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is the second of two columns defined for md breakpoint and above using column blocks. As a pensioner this is a one column page though, check it out!</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(81,102,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','10201219-01af-4d64-a786-e7200187b923',NULL,NULL,'This is only in an expander for active and deffered members',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"closesOthers\"]',NULL),
	(82,103,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','89bd74e6-cf28-43e6-94f7-9cae926d45b4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(83,104,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','1b572f78-dbab-46fb-9c7c-9539bebc6156',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"isEndcap\"]',NULL),
	(84,106,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','9092086a-053f-4fd4-9c8f-0e7cfa500d3e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(85,107,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','fbacb4c8-6c13-4479-aaa9-4ba3de64f48a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is a one column page for Pensioners, check it out!</p>\n<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(86,108,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','497336ae-bd5e-4a44-a255-f8345be510eb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(87,109,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','f0700072-6531-4ce8-94f2-66090e99bcc7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is the second of two columns defined for md breakpoint and above using column blocks. As a pensioner this is a one column page though, check it out!</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(88,110,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','227dc9fa-eb5e-4a87-92a8-0ef4498ceda6',NULL,NULL,'This is only in an expander for active and deffered members',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"closesOthers\"]',NULL),
	(89,111,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','653860a0-b976-4cda-819f-e4750aaf10e7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(90,112,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','09e37825-fcbc-47a4-af94-a10c60e85118',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"isEndcap\"]',NULL),
	(91,114,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','7ea2fb4f-74fd-4633-a608-8422c9c1d4fa',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(92,115,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','026124b7-9e66-43b9-9058-3921607dabf8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is a one column page for Pensioners, check it out!</p>\n<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(93,116,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','98af3fd7-a1ed-4bd4-9f96-c327f5066163',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(94,117,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','1e4c7568-5d01-4d28-adca-7df920471fab',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is the second of two columns defined for md breakpoint and above using column blocks. As a pensioner this is a one column page though, check it out!</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(95,118,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','5ea2f9c8-1df2-4b04-a812-717565862eec',NULL,NULL,'This is only in an expander for active and deffered members',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"closesOthers\"]',NULL),
	(96,119,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','34751e89-5ea7-44d3-ad71-c0026876b867',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(97,120,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','c631a9f2-59cb-49f1-bc1f-666cc7211817',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"isEndcap\"]',NULL),
	(98,122,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','40fc6d78-d6bc-4ce0-b913-c9aa42aa829f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(99,123,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','ee3504b1-0e42-4689-997f-a4c0ccac6812',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is a one column page for Pensioners, check it out!</p>\n<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(100,124,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','e6977cb3-cc5a-438a-aed0-7060993047c2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(101,125,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','97aff80c-4d93-4519-86cd-3e3ee8288ac9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is the second of two columns defined for md breakpoint and above using column blocks. As a pensioner this is a one column page though, check it out!</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(102,126,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','07b3399e-976e-4704-ac1c-e4c8cbcdc71b',NULL,NULL,'This is only in an expander for active and deffered members',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"closesOthers\"]',NULL),
	(103,127,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','fbf3cc10-e0eb-4a1e-b87e-131039985e89',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(104,128,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','20030865-460e-40fa-af00-e3d97fe37e7b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"isEndcap\"]',NULL),
	(105,130,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','067f2bf7-7fcf-42f1-9a73-d6e5c37d49ff',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(106,131,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','05e8e7f9-cd58-43ff-abe3-00f82e02d291',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is a one column page for Pensioners, check it out!</p>\n<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(107,132,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','9a6b4189-c55f-4632-b4d8-600ac2fec5cc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(108,133,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','30cb1e2f-33ad-4a04-a870-0da8cf0bdd33',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is the second of two columns defined for md breakpoint and above using column blocks. As a pensioner this is a one column page though, check it out!</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(109,134,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','059338f5-fd97-4b1e-ac93-d24eafcbe8ca',NULL,NULL,'This is only in an expander for active and deffered members',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"closesOthers\"]',NULL),
	(110,135,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','fb04e97d-03e9-4497-b313-e3902b40d270',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(111,136,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','cfd20972-15b0-4d63-88e3-67379a912d24',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"isEndcap\"]',NULL),
	(112,138,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','9d2246b4-2393-492f-b069-94aaf7001856',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(113,139,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','5f1f4b44-2bac-4566-9bbb-db35ca3a23b3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is a one column page for Pensioners, check it out!</p>\n<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(114,140,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','ef1b8377-e42b-4da6-b357-656d6d36af10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(115,141,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','9b47ebef-e18c-431c-a9d6-888f15fccb27',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is the second of two columns defined for md breakpoint and above using column blocks. As a pensioner this is a one column page though, check it out!</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(116,142,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','606f31af-aa32-4870-b5d3-7e7315e9289b',NULL,NULL,'This is only in an expander for active and deffered members',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"closesOthers\"]',NULL),
	(117,143,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','825f67ad-7c97-4251-9876-8cf954a74572',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(118,144,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','2da1cd22-e357-4bb4-9b6a-9a0707eb3578',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"isEndcap\"]',NULL),
	(119,145,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','8631eb1e-890b-4c42-ae60-a96b72f06cf1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(120,146,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','e933f0d3-6969-4f8e-ad67-2b1d2baf915b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(121,148,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','7eecb6b7-ffd3-4262-8c40-e90aab9e55b1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(122,149,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','67ec68a2-8468-4b62-ae37-a89d135fc6b7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(123,150,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','83fed517-e9d9-4d03-8c0b-113308554f70',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(124,151,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','71b43ebf-67e9-4132-8daf-d747ec56c6ed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(125,153,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','267f2ef8-6bbf-4640-8d14-01441f2a50a1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(126,154,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','48465da2-162a-4348-85c1-bed72a13b887',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(127,155,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','39c83eaf-06a8-4297-9463-4cb4e01a013e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(128,156,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','50a3405b-04b9-49fe-bfcd-293d5e5bb5cd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(129,158,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','4f1c9ee9-ccf4-48c4-8684-7b2f82e8f402',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(130,159,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','c7434763-3948-400e-976e-4392d53231a9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(131,160,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','84861238-9039-49f0-9e90-b287ce3dfb32',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(132,161,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','47dc1666-9b20-42ff-bf45-68da97daa67b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(133,163,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','b80fe8da-d419-4617-b4be-e01efc59c329',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(134,164,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','d1e5986f-d4ca-44f6-9775-5dbdbf9bd69d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(135,165,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','ddcdc18e-0b54-404b-9716-9b83a24387c1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(136,166,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','f4b29ebb-6ce5-40b6-b8aa-48d7556acd59',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(137,168,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','499cdd53-d4c1-49f6-ac64-1c8a790c6e94',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(138,169,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','ad07208c-a4fb-412f-aa7f-d7f12ffc2c47',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(139,170,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','e604b7f9-554f-4b8f-8ca2-920e2af0ac83',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(140,171,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','22bd8743-b78f-4c8a-85fd-52961752b8b7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(141,173,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','acc572e5-b1db-4181-bb7e-90f03da9777f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(142,174,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','d126e370-7a82-4dd4-abc7-38c1013ad6ee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(143,175,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','7078c93d-5bca-4046-a8b4-cc3ab213cbd5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(144,176,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','e45dd7f6-4db3-4e79-9624-f4bd78e657df',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(145,178,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','ffc7f7c9-a181-4314-9d2f-223fa129ccdc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(146,179,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','d4556632-a1eb-4d19-8251-5e325743f6ba',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(147,180,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','e4104973-c662-43f7-a9a6-61a7f6209685',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(148,181,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','e9e6f180-1661-4651-9aa4-ccec1775e73f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(149,183,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','a3cf0853-8ccb-450b-9b69-3d89558ad08a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(150,184,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','3fed5b41-68c1-475a-9cad-d0e24232d060',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(151,185,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','1693b21a-07f0-4a65-9f46-51818078e501',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(152,186,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','d30ed031-b641-4242-9257-5967402b42f3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(153,188,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','b4b8fbe8-1959-446b-812c-13170819b794',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(154,189,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','0ad57aed-47e2-4392-a62b-13b55829b1fb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(155,190,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','a40c99e5-089f-453e-86c8-f39a82bbb7e2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(156,191,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','381df4ef-538a-4641-b221-7269cff02bd6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(157,193,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','0c7d7a37-20a4-46f0-a4c3-0394e2074f7b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(158,194,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','60eb24b7-929b-40ec-92fa-0b330d18c4b0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(159,195,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','b7f48fc6-aa99-4925-800f-f24c206a4490',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(160,196,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','8a36baed-830a-4dd8-994d-8202cc44f3b0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(161,198,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','2e76edff-be06-492e-88cd-4f2280d7753c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(162,199,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','020a9784-d0d1-4054-a885-ee65d0860c6c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(163,200,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','2ea18683-1640-4511-b1bd-fe9ea9c9c452',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(164,201,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','1a29fc0e-cf31-412d-b036-e8532641574b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(165,203,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','7d649d71-5b3d-4aa8-9a40-e47830f5cee1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Fusce sollicitudin, eros vitae luctus ultrices, sapien elit lobortis est, non pellentesque tortor libero vehicula mauris. Donec rutrum purus id lectus mattis viverra. Maecenas aliquam porttitor erat, eget molestie neque. Vestibulum fermentum augue id leo mollis, blandit dignissim elit porta. Sed eget neque enim. Sed porta libero nec lectus tristique tristique. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus vestibulum non magna eget faucibus.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(166,204,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','6c43fb44-cc4a-4640-bbc8-9646f56507a9','Section heading 3','h3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(167,205,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','58695678-818c-4e99-a460-ca6070f847a8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(168,206,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','e1800640-589a-4a90-bbbb-7d3d3cef5c35',NULL,NULL,'Expander block heading',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[]',NULL),
	(169,207,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','814fd369-da2f-4a19-b6b7-88cfc374ec8f',NULL,NULL,NULL,NULL,NULL,NULL,'test@test.com','Test 123\nTest Road\nTest Town\nTE57 1NG','01234567890','www.test.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(170,209,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','5f274ffe-07ee-45c4-840e-11a0cbb3bcd9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Cras tempus dolor at luctus ultrices. Suspendisse aliquam, elit sit amet\n finibus mattis, diam quam gravida orci, eu efficitur odio quam at \npurus. Cras tellus augue, ultrices finibus ligula elementum, maximus \nullamcorper urna. Fusce malesuada ut urna ut auctor. Nulla lacinia \nlacinia facilisis. Curabitur urna augue, tristique non commodo vitae, \ndictum et neque. Maecenas scelerisque, augue eget volutpat molestie, \neros magna malesuada justo, nec cursus elit lacus sit amet turpis. \nAenean elit est, consectetur vel diam id, tincidunt accumsan tellus. \nInteger nec fermentum arcu. Sed felis sem, pretium ac vestibulum eu, \nvehicula sit amet lacus. Quisque a feugiat metus. Duis feugiat nulla id \nnisi tincidunt, at tempus libero facilisis. Donec blandit dapibus \nmauris, eget malesuada augue sodales in.\n</p>\n<h2>Lorem ipsum heading 2<br /></h2>\n<p>Nam congue risus imperdiet, varius ex ac, venenatis odio. Lorem ipsum \ndolor sit amet, consectetur adipiscing elit. Sed at interdum arcu. Duis \neu semper urna. Ut tellus nibh, elementum non quam ut, commodo pulvinar \nnisl. Etiam dapibus diam dolor, ut ullamcorper felis rutrum non. Aenean \nplacerat metus enim. Donec varius, massa vel posuere vulputate, ligula \nurna hendrerit ipsum, ut ornare urna mauris id mi.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(171,210,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','095daca9-2345-46a6-99da-a138f9a112be',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"columns\":[{\"heading\":\"Column 1\",\"width\":\"\",\"align\":\"left\"},{\"heading\":\"Column 2\",\"width\":\"\",\"align\":\"left\"},{\"heading\":\"Column 3\",\"width\":\"\",\"align\":\"left\"}],\"rows\":[[\"Mickey\",\"Pluto\",\"Donald\"],[\"Mouse\",\"Dog\",\"Duck\"],[\"1928\",\"1930\",\"1934\"],[\"Steamboat Willie\",\"The Chain Gang\",\"The Wise Little Hen\"]],\"table\":\"\\n            <table>\\n                <thead>\\n                    <tr>\\n        <th align=\\\"left\\\" width=\\\"\\\">Column 1</th><th align=\\\"left\\\" width=\\\"\\\">Column 2</th><th align=\\\"left\\\" width=\\\"\\\">Column 3</th>\\n                    </tr>\\n                </thead>\\n\\n                <tbody>\\n\\n        <tr><td align=\\\"left\\\">Mickey</td><td align=\\\"left\\\">Pluto</td><td align=\\\"left\\\">Donald</td></tr><tr><td align=\\\"left\\\">Mouse</td><td align=\\\"left\\\">Dog</td><td align=\\\"left\\\">Duck</td></tr><tr><td align=\\\"left\\\">1928</td><td align=\\\"left\\\">1930</td><td align=\\\"left\\\">1934</td></tr><tr><td align=\\\"left\\\">Steamboat Willie</td><td align=\\\"left\\\">The Chain Gang</td><td align=\\\"left\\\">The Wise Little Hen</td></tr>\\n\\n                </tbody>\\n\\n            </table>\\n        \"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(172,212,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','75c86b8c-bacd-4dac-9087-f070be07f18e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Cras tempus dolor at luctus ultrices. Suspendisse aliquam, elit sit amet\n finibus mattis, diam quam gravida orci, eu efficitur odio quam at \npurus. Cras tellus augue, ultrices finibus ligula elementum, maximus \nullamcorper urna. Fusce malesuada ut urna ut auctor. Nulla lacinia \nlacinia facilisis. Curabitur urna augue, tristique non commodo vitae, \ndictum et neque. Maecenas scelerisque, augue eget volutpat molestie, \neros magna malesuada justo, nec cursus elit lacus sit amet turpis. \nAenean elit est, consectetur vel diam id, tincidunt accumsan tellus. \nInteger nec fermentum arcu. Sed felis sem, pretium ac vestibulum eu, \nvehicula sit amet lacus. Quisque a feugiat metus. Duis feugiat nulla id \nnisi tincidunt, at tempus libero facilisis. Donec blandit dapibus \nmauris, eget malesuada augue sodales in.\n</p>\n<h2>Lorem ipsum heading 2<br /></h2>\n<p>Nam congue risus imperdiet, varius ex ac, venenatis odio. Lorem ipsum \ndolor sit amet, consectetur adipiscing elit. Sed at interdum arcu. Duis \neu semper urna. Ut tellus nibh, elementum non quam ut, commodo pulvinar \nnisl. Etiam dapibus diam dolor, ut ullamcorper felis rutrum non. Aenean \nplacerat metus enim. Donec varius, massa vel posuere vulputate, ligula \nurna hendrerit ipsum, ut ornare urna mauris id mi.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(173,213,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','14a46b37-4c44-47d6-b477-6df1ce353f7f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"columns\":[{\"heading\":\"Column 1\",\"width\":\"\",\"align\":\"left\"},{\"heading\":\"Column 2\",\"width\":\"\",\"align\":\"left\"},{\"heading\":\"Column 3\",\"width\":\"\",\"align\":\"left\"}],\"rows\":[[\"Mickey\",\"Pluto\",\"Donald\"],[\"Mouse\",\"Dog\",\"Duck\"],[\"1928\",\"1930\",\"1934\"],[\"Steamboat Willie\",\"The Chain Gang\",\"The Wise Little Hen\"]],\"table\":\"\\n            <table>\\n                <thead>\\n                    <tr>\\n        <th align=\\\"left\\\" width=\\\"\\\">Column 1</th><th align=\\\"left\\\" width=\\\"\\\">Column 2</th><th align=\\\"left\\\" width=\\\"\\\">Column 3</th>\\n                    </tr>\\n                </thead>\\n\\n                <tbody>\\n\\n        <tr><td align=\\\"left\\\">Mickey</td><td align=\\\"left\\\">Pluto</td><td align=\\\"left\\\">Donald</td></tr><tr><td align=\\\"left\\\">Mouse</td><td align=\\\"left\\\">Dog</td><td align=\\\"left\\\">Duck</td></tr><tr><td align=\\\"left\\\">1928</td><td align=\\\"left\\\">1930</td><td align=\\\"left\\\">1934</td></tr><tr><td align=\\\"left\\\">Steamboat Willie</td><td align=\\\"left\\\">The Chain Gang</td><td align=\\\"left\\\">The Wise Little Hen</td></tr>\\n\\n                </tbody>\\n\\n            </table>\\n        \"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(174,214,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','439eb37d-b1fc-43ef-82ce-0b1364cecd03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Cras tempus dolor at luctus ultrices. Suspendisse aliquam, elit sit amet\n finibus mattis, diam quam gravida orci, eu efficitur odio quam at \npurus. Cras tellus augue, ultrices finibus ligula elementum, maximus \nullamcorper urna. Fusce malesuada ut urna ut auctor. Nulla lacinia \nlacinia facilisis. Curabitur urna augue, tristique non commodo vitae, \ndictum et neque. Maecenas scelerisque, augue eget volutpat molestie, \neros magna malesuada justo, nec cursus elit lacus sit amet turpis. \nAenean elit est, consectetur vel diam id, tincidunt accumsan tellus. \nInteger nec fermentum arcu. Sed felis sem, pretium ac vestibulum eu, \nvehicula sit amet lacus. Quisque a feugiat metus. Duis feugiat nulla id \nnisi tincidunt, at tempus libero facilisis. Donec blandit dapibus \nmauris, eget malesuada augue sodales in.\n</p>\n<h2>Lorem ipsum heading 2<br /></h2>\n<p>Nam congue risus imperdiet, varius ex ac, venenatis odio. Lorem ipsum \ndolor sit amet, consectetur adipiscing elit. Sed at interdum arcu. Duis \neu semper urna. Ut tellus nibh, elementum non quam ut, commodo pulvinar \nnisl. Etiam dapibus diam dolor, ut ullamcorper felis rutrum non. Aenean \nplacerat metus enim. Donec varius, massa vel posuere vulputate, ligula \nurna hendrerit ipsum, ut ornare urna mauris id mi.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(175,215,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','20753fcd-1e52-49e6-b949-9313ac5b78d3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"rows\":[],\"table\":\"\\n            <table>\\n                <thead>\\n                    <tr>\\n        \\n                    </tr>\\n                </thead>\\n\\n                <tbody>\\n\\n        \\n\\n                </tbody>\\n\\n            </table>\\n        \"}',NULL,NULL,NULL,NULL,NULL,NULL),
	(176,217,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','75e10939-0273-4844-a395-02cbea5f6142',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(177,218,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','070c64cd-b994-43a4-bbfc-dd6429bfcef0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(178,219,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','8f0c5bad-6296-4018-97fe-8081a9133754',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(179,221,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','7138e972-b586-477f-9928-5b71eccd4c41',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Cras tempus dolor at luctus ultrices. Suspendisse aliquam, elit sit amet\n finibus mattis, diam quam gravida orci, eu efficitur odio quam at \npurus. Cras tellus augue, ultrices finibus ligula elementum, maximus \nullamcorper urna. Fusce malesuada ut urna ut auctor. Nulla lacinia \nlacinia facilisis. Curabitur urna augue, tristique non commodo vitae, \ndictum et neque. Maecenas scelerisque, augue eget volutpat molestie, \neros magna malesuada justo, nec cursus elit lacus sit amet turpis. \nAenean elit est, consectetur vel diam id, tincidunt accumsan tellus. \nInteger nec fermentum arcu. Sed felis sem, pretium ac vestibulum eu, \nvehicula sit amet lacus. Quisque a feugiat metus. Duis feugiat nulla id \nnisi tincidunt, at tempus libero facilisis. Donec blandit dapibus \nmauris, eget malesuada augue sodales in.\n</p>\n<h2>Lorem ipsum heading 2<br /></h2>\n<p>Nam congue risus imperdiet, varius ex ac, venenatis odio. Lorem ipsum \ndolor sit amet, consectetur adipiscing elit. Sed at interdum arcu. Duis \neu semper urna. Ut tellus nibh, elementum non quam ut, commodo pulvinar \nnisl. Etiam dapibus diam dolor, ut ullamcorper felis rutrum non. Aenean \nplacerat metus enim. Donec varius, massa vel posuere vulputate, ligula \nurna hendrerit ipsum, ut ornare urna mauris id mi.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(180,222,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','35e05736-8c9f-4410-b9d2-0c17765b95c6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"rows\":[],\"table\":\"\\n            <table>\\n                <thead>\\n                    <tr>\\n        \\n                    </tr>\\n                </thead>\\n\\n                <tbody>\\n\\n        \\n\\n                </tbody>\\n\\n            </table>\\n        \"}',NULL,NULL,NULL,NULL,NULL,NULL),
	(181,223,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','475b6d09-ecbf-4ecf-95dc-54981f61f48d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Cras tempus dolor at luctus ultrices. Suspendisse aliquam, elit sit amet\n finibus mattis, diam quam gravida orci, eu efficitur odio quam at \npurus. Cras tellus augue, ultrices finibus ligula elementum, maximus \nullamcorper urna. Fusce malesuada ut urna ut auctor. Nulla lacinia \nlacinia facilisis. Curabitur urna augue, tristique non commodo vitae, \ndictum et neque. Maecenas scelerisque, augue eget volutpat molestie, \neros magna malesuada justo, nec cursus elit lacus sit amet turpis. \nAenean elit est, consectetur vel diam id, tincidunt accumsan tellus. \nInteger nec fermentum arcu. Sed felis sem, pretium ac vestibulum eu, \nvehicula sit amet lacus. Quisque a feugiat metus. Duis feugiat nulla id \nnisi tincidunt, at tempus libero facilisis. Donec blandit dapibus \nmauris, eget malesuada augue sodales in.\n</p>\n<h2>Lorem ipsum heading 2<br /></h2>\n<p>Nam congue risus imperdiet, varius ex ac, venenatis odio. Lorem ipsum \ndolor sit amet, consectetur adipiscing elit. Sed at interdum arcu. Duis \neu semper urna. Ut tellus nibh, elementum non quam ut, commodo pulvinar \nnisl. Etiam dapibus diam dolor, ut ullamcorper felis rutrum non. Aenean \nplacerat metus enim. Donec varius, massa vel posuere vulputate, ligula \nurna hendrerit ipsum, ut ornare urna mauris id mi.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(182,224,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','8c694505-14e4-4a8d-b00a-25f546129a70',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"rows\":[],\"table\":\"\\n            <table>\\n                <thead>\\n                    <tr>\\n        \\n                    </tr>\\n                </thead>\\n\\n                <tbody>\\n\\n        \\n\\n                </tbody>\\n\\n            </table>\\n        \"}',NULL,NULL,NULL,NULL,NULL,NULL),
	(183,226,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','a73059c0-819a-47e7-a3eb-37c71dde6c14',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Cras tempus dolor at luctus ultrices. Suspendisse aliquam, elit sit amet\n finibus mattis, diam quam gravida orci, eu efficitur odio quam at \npurus. Cras tellus augue, ultrices finibus ligula elementum, maximus \nullamcorper urna. Fusce malesuada ut urna ut auctor. Nulla lacinia \nlacinia facilisis. Curabitur urna augue, tristique non commodo vitae, \ndictum et neque. Maecenas scelerisque, augue eget volutpat molestie, \neros magna malesuada justo, nec cursus elit lacus sit amet turpis. \nAenean elit est, consectetur vel diam id, tincidunt accumsan tellus. \nInteger nec fermentum arcu. Sed felis sem, pretium ac vestibulum eu, \nvehicula sit amet lacus. Quisque a feugiat metus. Duis feugiat nulla id \nnisi tincidunt, at tempus libero facilisis. Donec blandit dapibus \nmauris, eget malesuada augue sodales in.\n</p>\n<h2>Lorem ipsum heading 2<br /></h2>\n<p>Nam congue risus imperdiet, varius ex ac, venenatis odio. Lorem ipsum \ndolor sit amet, consectetur adipiscing elit. Sed at interdum arcu. Duis \neu semper urna. Ut tellus nibh, elementum non quam ut, commodo pulvinar \nnisl. Etiam dapibus diam dolor, ut ullamcorper felis rutrum non. Aenean \nplacerat metus enim. Donec varius, massa vel posuere vulputate, ligula \nurna hendrerit ipsum, ut ornare urna mauris id mi.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(184,227,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','c1861fe7-67b4-4558-9ec5-2ab0aa2e42ea',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"rows\":[],\"table\":\"\\n            <table>\\n                <thead>\\n                    <tr>\\n        \\n                    </tr>\\n                </thead>\\n\\n                <tbody>\\n\\n        \\n\\n                </tbody>\\n\\n            </table>\\n        \"}',NULL,NULL,NULL,NULL,NULL,NULL),
	(185,228,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','bb9ed439-1c00-4c65-9196-f3211cdcb15a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Cras tempus dolor at luctus ultrices. Suspendisse aliquam, elit sit amet\n finibus mattis, diam quam gravida orci, eu efficitur odio quam at \npurus. Cras tellus augue, ultrices finibus ligula elementum, maximus \nullamcorper urna. Fusce malesuada ut urna ut auctor. Nulla lacinia \nlacinia facilisis. Curabitur urna augue, tristique non commodo vitae, \ndictum et neque. Maecenas scelerisque, augue eget volutpat molestie, \neros magna malesuada justo, nec cursus elit lacus sit amet turpis. \nAenean elit est, consectetur vel diam id, tincidunt accumsan tellus. \nInteger nec fermentum arcu. Sed felis sem, pretium ac vestibulum eu, \nvehicula sit amet lacus. Quisque a feugiat metus. Duis feugiat nulla id \nnisi tincidunt, at tempus libero facilisis. Donec blandit dapibus \nmauris, eget malesuada augue sodales in.\n</p>\n<h2>Lorem ipsum heading 2<br /></h2>\n<p>Nam congue risus imperdiet, varius ex ac, venenatis odio. Lorem ipsum \ndolor sit amet, consectetur adipiscing elit. Sed at interdum arcu. Duis \neu semper urna. Ut tellus nibh, elementum non quam ut, commodo pulvinar \nnisl. Etiam dapibus diam dolor, ut ullamcorper felis rutrum non. Aenean \nplacerat metus enim. Donec varius, massa vel posuere vulputate, ligula \nurna hendrerit ipsum, ut ornare urna mauris id mi.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(186,229,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','067a678e-0730-418d-8f4c-45ab75d1640c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"rows\":[],\"table\":\"\\n            <table>\\n                <thead>\\n                    <tr>\\n        \\n                    </tr>\\n                </thead>\\n\\n                <tbody>\\n\\n        \\n\\n                </tbody>\\n\\n            </table>\\n        \"}',NULL,NULL,NULL,NULL,NULL,NULL),
	(187,231,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','34c80015-7ab1-4c05-bff7-e270b72f0a6c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Cras tempus dolor at luctus ultrices. Suspendisse aliquam, elit sit amet\n finibus mattis, diam quam gravida orci, eu efficitur odio quam at \npurus. Cras tellus augue, ultrices finibus ligula elementum, maximus \nullamcorper urna. Fusce malesuada ut urna ut auctor. Nulla lacinia \nlacinia facilisis. Curabitur urna augue, tristique non commodo vitae, \ndictum et neque. Maecenas scelerisque, augue eget volutpat molestie, \neros magna malesuada justo, nec cursus elit lacus sit amet turpis. \nAenean elit est, consectetur vel diam id, tincidunt accumsan tellus. \nInteger nec fermentum arcu. Sed felis sem, pretium ac vestibulum eu, \nvehicula sit amet lacus. Quisque a feugiat metus. Duis feugiat nulla id \nnisi tincidunt, at tempus libero facilisis. Donec blandit dapibus \nmauris, eget malesuada augue sodales in.\n</p>\n<h2>Lorem ipsum heading 2<br /></h2>\n<p>Nam congue risus imperdiet, varius ex ac, venenatis odio. Lorem ipsum \ndolor sit amet, consectetur adipiscing elit. Sed at interdum arcu. Duis \neu semper urna. Ut tellus nibh, elementum non quam ut, commodo pulvinar \nnisl. Etiam dapibus diam dolor, ut ullamcorper felis rutrum non. Aenean \nplacerat metus enim. Donec varius, massa vel posuere vulputate, ligula \nurna hendrerit ipsum, ut ornare urna mauris id mi.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(188,232,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','87fab968-71fa-4837-befd-7327528fa457',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"rows\":[],\"table\":\"\\n            <table>\\n                <thead>\\n                    <tr>\\n        \\n                    </tr>\\n                </thead>\\n\\n                <tbody>\\n\\n        \\n\\n                </tbody>\\n\\n            </table>\\n        \"}',NULL,NULL,NULL,NULL,NULL,NULL),
	(189,233,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','18eaa78a-1aed-477f-9837-c97c5cc48e2f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Cras tempus dolor at luctus ultrices. Suspendisse aliquam, elit sit amet\n finibus mattis, diam quam gravida orci, eu efficitur odio quam at \npurus. Cras tellus augue, ultrices finibus ligula elementum, maximus \nullamcorper urna. Fusce malesuada ut urna ut auctor. Nulla lacinia \nlacinia facilisis. Curabitur urna augue, tristique non commodo vitae, \ndictum et neque. Maecenas scelerisque, augue eget volutpat molestie, \neros magna malesuada justo, nec cursus elit lacus sit amet turpis. \nAenean elit est, consectetur vel diam id, tincidunt accumsan tellus. \nInteger nec fermentum arcu. Sed felis sem, pretium ac vestibulum eu, \nvehicula sit amet lacus. Quisque a feugiat metus. Duis feugiat nulla id \nnisi tincidunt, at tempus libero facilisis. Donec blandit dapibus \nmauris, eget malesuada augue sodales in.\n</p>\n<h2>Lorem ipsum heading 2<br /></h2>\n<p>Nam congue risus imperdiet, varius ex ac, venenatis odio. Lorem ipsum \ndolor sit amet, consectetur adipiscing elit. Sed at interdum arcu. Duis \neu semper urna. Ut tellus nibh, elementum non quam ut, commodo pulvinar \nnisl. Etiam dapibus diam dolor, ut ullamcorper felis rutrum non. Aenean \nplacerat metus enim. Donec varius, massa vel posuere vulputate, ligula \nurna hendrerit ipsum, ut ornare urna mauris id mi.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(190,234,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','29c9bb42-5b3e-4f23-a48a-ebf8f597b0d2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"rows\":[],\"table\":\"\\n            <table>\\n                <thead>\\n                    <tr>\\n        \\n                    </tr>\\n                </thead>\\n\\n                <tbody>\\n\\n        \\n\\n                </tbody>\\n\\n            </table>\\n        \"}',NULL,NULL,NULL,NULL,NULL,NULL),
	(191,236,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','f90dee6f-22f5-448c-bb2b-f8f86080a336',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Fusce sollicitudin, eros vitae luctus ultrices, sapien elit lobortis est, non pellentesque tortor libero vehicula mauris. Donec rutrum purus id lectus mattis viverra. Maecenas aliquam porttitor erat, eget molestie neque. Vestibulum fermentum augue id leo mollis, blandit dignissim elit porta. Sed eget neque enim. Sed porta libero nec lectus tristique tristique. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus vestibulum non magna eget faucibus.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(192,237,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','a30649bf-f3b6-4b27-acbb-1681e2b40879','Section heading 3','h3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(193,238,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','c0edd44d-29e1-4bde-b70d-a3eba055c886',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(194,239,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','b5b4025d-bca7-4e75-b90e-4a10b0fd008b',NULL,NULL,'Expander block heading',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[]',NULL),
	(195,240,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','5541e825-0887-4a37-b748-b7a9844b43ea',NULL,NULL,NULL,NULL,NULL,NULL,'test@test.com','Test 123\nTest Road\nTest Town\nTE57 1NG','01234567890','www.test.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(196,241,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','f38b9631-3a03-44cf-9433-549bcc316be5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Fusce sollicitudin, eros vitae luctus ultrices, sapien elit lobortis est, non pellentesque tortor libero vehicula mauris. Donec rutrum purus id lectus mattis viverra. Maecenas aliquam porttitor erat, eget molestie neque. Vestibulum fermentum augue id leo mollis, blandit dignissim elit porta. Sed eget neque enim. Sed porta libero nec lectus tristique tristique. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus vestibulum non magna eget faucibus.</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(197,242,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','2a270be0-9f36-4b19-9f19-8758cdabce4c','Section heading 3','h3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(198,243,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','2b4b788c-83d2-4eea-b4e5-b682ba8a9b12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(199,244,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','99a2787b-c58b-4f95-aa29-6db3eea3b2d7',NULL,NULL,NULL,NULL,NULL,NULL,'test@test.com','Test 123\nTest Road\nTest Town\nTE57 1NG','01234567890','www.test.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(200,246,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','3b7661a0-3bc1-4473-8090-5d96e808cc65',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Cras tempus dolor at luctus ultrices. Suspendisse aliquam, elit sit amet\n finibus mattis, diam quam gravida orci, eu efficitur odio quam at \npurus. Cras tellus augue, ultrices finibus ligula elementum, maximus \nullamcorper urna. Fusce malesuada ut urna ut auctor. Nulla lacinia \nlacinia facilisis. Curabitur urna augue, tristique non commodo vitae, \ndictum et neque. Maecenas scelerisque, augue eget volutpat molestie, \neros magna malesuada justo, nec cursus elit lacus sit amet turpis. \nAenean elit est, consectetur vel diam id, tincidunt accumsan tellus. \nInteger nec fermentum arcu. Sed felis sem, pretium ac vestibulum eu, \nvehicula sit amet lacus. Quisque a feugiat metus. Duis feugiat nulla id \nnisi tincidunt, at tempus libero facilisis. Donec blandit dapibus \nmauris, eget malesuada augue sodales in.\n</p>\n<h2>Lorem ipsum heading 2<br /></h2>\n<p>Nam congue risus imperdiet, varius ex ac, venenatis odio. Lorem ipsum \ndolor sit amet, consectetur adipiscing elit. Sed at interdum arcu. Duis \neu semper urna. Ut tellus nibh, elementum non quam ut, commodo pulvinar \nnisl. Etiam dapibus diam dolor, ut ullamcorper felis rutrum non. Aenean \nplacerat metus enim. Donec varius, massa vel posuere vulputate, ligula \nurna hendrerit ipsum, ut ornare urna mauris id mi.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(201,247,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','d3b9a0b8-1e04-4cac-bca9-a683ea294149',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"rows\":[],\"table\":\"\\n            <table>\\n                <thead>\\n                    <tr>\\n        \\n                    </tr>\\n                </thead>\\n\\n                <tbody>\\n\\n        \\n\\n                </tbody>\\n\\n            </table>\\n        \"}',NULL,NULL,NULL,NULL,NULL,NULL),
	(202,248,1,'2020-08-18 08:40:28','2020-08-18 08:40:28','adc8902f-a0bc-4114-aba3-218b4f56cdc4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Cras tempus dolor at luctus ultrices. Suspendisse aliquam, elit sit amet\n finibus mattis, diam quam gravida orci, eu efficitur odio quam at \npurus. Cras tellus augue, ultrices finibus ligula elementum, maximus \nullamcorper urna. Fusce malesuada ut urna ut auctor. Nulla lacinia \nlacinia facilisis. Curabitur urna augue, tristique non commodo vitae, \ndictum et neque. Maecenas scelerisque, augue eget volutpat molestie, \neros magna malesuada justo, nec cursus elit lacus sit amet turpis. \nAenean elit est, consectetur vel diam id, tincidunt accumsan tellus. \nInteger nec fermentum arcu. Sed felis sem, pretium ac vestibulum eu, \nvehicula sit amet lacus. Quisque a feugiat metus. Duis feugiat nulla id \nnisi tincidunt, at tempus libero facilisis. Donec blandit dapibus \nmauris, eget malesuada augue sodales in.\n</p>\n<h2>Lorem ipsum heading 2<br /></h2><p>Nam congue risus imperdiet, varius ex ac, venenatis odio. Lorem ipsum \ndolor sit amet, consectetur adipiscing elit. Sed at interdum arcu. Duis \neu semper urna. Ut tellus nibh, elementum non quam ut, commodo pulvinar \nnisl. Etiam dapibus diam dolor, ut ullamcorper felis rutrum non. Aenean \nplacerat metus enim. Donec varius, massa vel posuere vulputate, ligula \nurna hendrerit ipsum, ut ornare urna mauris id mi.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(203,250,1,'2020-08-18 08:40:28','2020-08-18 08:40:28','692fe2f1-bb9c-41d6-ac1f-1e4e3b2f8022',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(204,251,1,'2020-08-18 08:40:28','2020-08-18 08:40:28','878254f9-da25-4040-8521-09a5572afe60',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(205,253,1,'2020-08-18 08:40:28','2020-08-18 08:40:28','320fa782-2a13-4258-a024-9a3b77e26a59',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(206,254,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','8fb5a6ed-3cce-417c-b9c5-7a5a68e5c8d7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is only inside an expander for Active and Deferred members</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(207,256,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','d0133c08-d014-4a74-9a20-17f3616c73c4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(208,257,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','7eaba3fa-0256-491c-a949-47894b085e98',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is a one column page for Pensioners, check it out!</p>\n<p>\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Proin egestas \nvel est sagittis sagittis. Maecenas lacinia fringilla tincidunt. In \nvitae erat quis massa dignissim tempor sit amet interdum massa. Integer \ncommodo sem nisl, id ultricies velit dignissim in. Vestibulum ante ipsum\n primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc \nsagittis, ante in mattis sagittis, nulla elit faucibus tellus, id \nscelerisque nunc nulla in turpis. Nunc semper blandit ultrices. \nPellentesque habitant morbi tristique senectus et netus et malesuada \nfames ac turpis egestas. Phasellus dapibus dolor tortor, quis malesuada \nest ornare eget. In semper imperdiet lorem a commodo. Suspendisse \nimperdiet nisl sit amet venenatis porta. Aenean fermentum accumsan orci \nsit amet mattis. Mauris tempus lobortis diam, vel efficitur dolor \ndapibus eget. Mauris purus odio, condimentum vitae gravida vitae, luctus\n in nisl.\n</p>\n<p>\nFusce imperdiet ante nec quam efficitur rutrum. Proin tristique ligula \nsit amet mi pharetra ornare. Ut eget enim id nunc pharetra varius \nfacilisis vitae odio. Orci varius natoque penatibus et magnis dis \nparturient montes, nascetur ridiculus mus. Fusce ligula lectus, lacinia \nquis nulla sit amet, vestibulum eleifend velit. Praesent rhoncus tortor \npulvinar ex lobortis, at congue eros congue. Curabitur ac feugiat diam, \nsed pulvinar erat. Nullam ullamcorper erat ut nunc pellentesque, ac \nvulputate eros molestie. Etiam in lacus mollis, ultrices justo at, \nsodales sem.\n</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(209,258,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','8198c7c7-983f-477d-ad82-5bbc6a44461c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"columns\":[{\"heading\":\"blank\",\"width\":\"\",\"align\":\"left\"},{\"heading\":\"Here\'s a table with extra functionality\",\"width\":\"\",\"align\":\"left\"},{\"heading\":\"null\",\"width\":\"\",\"align\":\"left\"}],\"rows\":[[\"Cell 1\",\"Cell 2\",\"Cell 3\"],[\"Cell 1 and 2\",\"null\",\"Cell 3\"]],\"table\":\"\\n            <table>\\n                <thead>\\n                    <tr>\\n        <th align=\\\"left\\\" width=\\\"\\\">blank</th><th align=\\\"left\\\" width=\\\"\\\">Here\'s a table with extra functionality</th><th align=\\\"left\\\" width=\\\"\\\">null</th>\\n                    </tr>\\n                </thead>\\n\\n                <tbody>\\n\\n        <tr><td align=\\\"left\\\">Cell 1</td><td align=\\\"left\\\">Cell 2</td><td align=\\\"left\\\">Cell 3</td></tr><tr><td align=\\\"left\\\">Cell 1 and 2</td><td align=\\\"left\\\">null</td><td align=\\\"left\\\">Cell 3</td></tr>\\n\\n                </tbody>\\n\\n            </table>\\n        \"}',NULL,NULL,NULL,NULL,NULL,NULL),
	(210,259,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','7f9a9d37-be81-4881-86ca-86a27c9312fd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'col-md-6',NULL,NULL),
	(211,260,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','ea2bc0ba-3470-4ab3-9483-21acedd8ed85',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is the second of two columns defined for md breakpoint and above using column blocks. As a pensioner this is a one column page though, check it out!</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(212,261,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','15938580-d562-4786-849d-7e5145c7cde9',NULL,NULL,'This is only an expander for Active and Deferred members',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"closesOthers\"]',NULL),
	(213,262,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','b978df41-06c2-4114-a8db-d8b303e699b8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>This is only inside an expander for Active and Deferred members</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(214,263,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','60ef9826-e715-4b6b-ba24-1450c2e75b23',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'[\"isEndcap\"]',NULL),
	(215,264,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','38ce7806-326c-4fb7-a15a-839d16a778e0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'static-block-example',NULL,NULL,NULL,NULL),
	(216,265,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','1cb92757-5795-45e4-841c-e5cb1b87e450',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `cc1_matrixcontent_contentblocks` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_migrations`;

CREATE TABLE `cc1_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `track` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_migrations_track_name_unq_idx` (`track`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_migrations` WRITE;
/*!40000 ALTER TABLE `cc1_migrations` DISABLE KEYS */;

INSERT INTO `cc1_migrations` (`id`, `track`, `name`, `applyTime`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'craft','Install','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','647285fb-c3be-4753-8648-df53751829e3'),
	(2,'craft','m150403_183908_migrations_table_changes','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','6b33b8ab-367a-4112-aec1-b0baaf77df9e'),
	(3,'craft','m150403_184247_plugins_table_changes','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','97666962-b53e-4168-a895-cddf302525f4'),
	(4,'craft','m150403_184533_field_version','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','364125fb-dad5-413f-8388-7b2e2a24c2a9'),
	(5,'craft','m150403_184729_type_columns','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','911cf14c-c6e6-487a-95fc-61a77b330060'),
	(6,'craft','m150403_185142_volumes','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','a25b1518-da3b-47ab-918d-6088df4dfe89'),
	(7,'craft','m150428_231346_userpreferences','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','fb38c87b-4db7-432f-986b-660f725fd08e'),
	(8,'craft','m150519_150900_fieldversion_conversion','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','be564afe-5a03-4322-a894-74287e2cb630'),
	(9,'craft','m150617_213829_update_email_settings','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','bd31691c-fc89-4c8f-a383-93eedd6b7073'),
	(10,'craft','m150721_124739_templatecachequeries','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','1d21283f-e2c4-40e5-8d2f-1178f58a22b3'),
	(11,'craft','m150724_140822_adjust_quality_settings','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','faa2099b-1fb8-4f4f-81ea-2fb2af36b200'),
	(12,'craft','m150815_133521_last_login_attempt_ip','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','00f9fa0b-1608-4551-992a-d2eb15bb16ff'),
	(13,'craft','m151002_095935_volume_cache_settings','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','552345c7-ee96-4589-aef7-a14a4faf4bfe'),
	(14,'craft','m151005_142750_volume_s3_storage_settings','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','4cb50565-e90b-401a-a997-2ad3be5798b9'),
	(15,'craft','m151016_133600_delete_asset_thumbnails','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','3ca33c6d-0d80-4654-a331-36c8355af20e'),
	(16,'craft','m151209_000000_move_logo','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','3e7e4ee2-9073-4a38-9c89-3cae6a3e7071'),
	(17,'craft','m151211_000000_rename_fileId_to_assetId','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','a4f0ed5e-2916-463b-9bae-b30d41c4f152'),
	(18,'craft','m151215_000000_rename_asset_permissions','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','1ad49055-ae65-42f0-96ff-7884a03ac860'),
	(19,'craft','m160707_000001_rename_richtext_assetsource_setting','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','f090ac70-3192-4404-bf1e-37664efed647'),
	(20,'craft','m160708_185142_volume_hasUrls_setting','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','8f06781b-eb61-488d-b035-318c0af16b03'),
	(21,'craft','m160714_000000_increase_max_asset_filesize','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','34c0de58-c158-4da0-9d8f-14835a19a20d'),
	(22,'craft','m160727_194637_column_cleanup','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','18bc99d8-e329-4c1b-8e61-52443fbf4f37'),
	(23,'craft','m160804_110002_userphotos_to_assets','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','25f3457f-fd8b-43ac-8ccf-24e04e4e733a'),
	(24,'craft','m160807_144858_sites','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','d3031d2d-df99-42f8-a3a0-647cfef759c2'),
	(25,'craft','m160829_000000_pending_user_content_cleanup','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','b6289c7c-0bde-45e8-a112-a99a89e2fdbd'),
	(26,'craft','m160830_000000_asset_index_uri_increase','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','fb37ffcf-1896-47bc-ac76-c0b6738eb2df'),
	(27,'craft','m160912_230520_require_entry_type_id','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','60f452c0-dcd3-4d1c-8d5f-2bcf302fef74'),
	(28,'craft','m160913_134730_require_matrix_block_type_id','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','2dbbe4ed-3494-4665-89c9-a9e9e04c0d28'),
	(29,'craft','m160920_174553_matrixblocks_owner_site_id_nullable','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','981221dd-f55f-44d6-a387-9931acb5a01f'),
	(30,'craft','m160920_231045_usergroup_handle_title_unique','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','6d5682aa-c61e-4185-a756-200e85dd6a11'),
	(31,'craft','m160925_113941_route_uri_parts','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','ca047fef-6d60-44d0-ae00-1da3e759d24d'),
	(32,'craft','m161006_205918_schemaVersion_not_null','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','622125fb-5fe1-4191-8cac-7703e67d6afa'),
	(33,'craft','m161007_130653_update_email_settings','2018-06-08 15:06:12','2018-06-08 15:06:12','2018-06-08 15:06:12','d059ddbf-796e-4040-86c9-16fb08243cdf'),
	(34,'craft','m161013_175052_newParentId','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','d40dcb95-0bd8-4c47-baad-b5091d225549'),
	(35,'craft','m161021_102916_fix_recent_entries_widgets','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','a180a266-f4c8-4dd4-89e5-e5e92ce3749a'),
	(36,'craft','m161021_182140_rename_get_help_widget','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','88e45246-f3a6-4267-8da0-cc6685a4d891'),
	(37,'craft','m161025_000000_fix_char_columns','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','2da32a48-eecb-4826-af78-31e4579d7ca5'),
	(38,'craft','m161029_124145_email_message_languages','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','3f1e34b4-7055-4db8-94f9-e3dc139f858e'),
	(39,'craft','m161108_000000_new_version_format','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','648f5d71-e425-4bac-b85d-57c7bf588a97'),
	(40,'craft','m161109_000000_index_shuffle','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','b82513aa-eabc-4ffb-a9a4-24ee19a44eba'),
	(41,'craft','m161122_185500_no_craft_app','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','b272c146-8c72-4bdf-8092-f1bb4cbe988b'),
	(42,'craft','m161125_150752_clear_urlmanager_cache','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','3a4501fb-f62b-4ccd-b4b6-ff186134eb7a'),
	(43,'craft','m161220_000000_volumes_hasurl_notnull','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','83241c84-e671-41e1-a0dd-3a4eb66fd43b'),
	(44,'craft','m170114_161144_udates_permission','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','5bb6ef77-996c-41b8-accf-8a89d3ea4ac3'),
	(45,'craft','m170120_000000_schema_cleanup','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','312550dc-a227-47f1-8441-b04b617b524b'),
	(46,'craft','m170126_000000_assets_focal_point','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','026533bb-d867-42dd-866f-85be9e60de2f'),
	(47,'craft','m170206_142126_system_name','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','9fe2779d-5ab9-470f-ad3b-3df4c6d10796'),
	(48,'craft','m170217_044740_category_branch_limits','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','61bc3972-e74e-45c8-8d70-37c78f6dcfce'),
	(49,'craft','m170217_120224_asset_indexing_columns','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','172ae984-87e4-4ef0-84b5-a3e3f0b3b532'),
	(50,'craft','m170223_224012_plain_text_settings','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','66d9230e-164b-4b04-9cd6-a4e397e30638'),
	(51,'craft','m170227_120814_focal_point_percentage','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','bb0cfe07-a017-4702-ac90-3d7fd301d8cb'),
	(52,'craft','m170228_171113_system_messages','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','bd9a5d06-8187-4dd5-9fc8-5ddb08485782'),
	(53,'craft','m170303_140500_asset_field_source_settings','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','fd1d19eb-3961-4990-9a20-bc04d8f15394'),
	(54,'craft','m170306_150500_asset_temporary_uploads','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','fa5beccd-d081-4993-910e-d1d565c89316'),
	(55,'craft','m170414_162429_rich_text_config_setting','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','bfe041b7-56d0-4d43-a046-5c8c1be50cf8'),
	(56,'craft','m170523_190652_element_field_layout_ids','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','14754823-00f9-45e6-84fa-75de09a32f51'),
	(57,'craft','m170612_000000_route_index_shuffle','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','62a501ce-e8df-446d-809d-27fc9b4c813f'),
	(58,'craft','m170621_195237_format_plugin_handles','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','a3ef72db-2101-4950-9367-03d0c893dc89'),
	(59,'craft','m170630_161028_deprecation_changes','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','57c0bdd5-c17b-4674-945b-3a6ee7bf63fd'),
	(60,'craft','m170703_181539_plugins_table_tweaks','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','a32f0c77-0781-40fa-a70a-ba86c0b96b08'),
	(61,'craft','m170704_134916_sites_tables','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','41d87496-c958-40b4-8f82-e1cdc01ba9a5'),
	(62,'craft','m170706_183216_rename_sequences','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','e3519c6e-3c33-42e7-b0ac-a7a0237195c0'),
	(63,'craft','m170707_094758_delete_compiled_traits','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','e2fcb103-2ed3-4086-b406-2836f47991e0'),
	(64,'craft','m170731_190138_drop_asset_packagist','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','1226999c-c7a0-4e94-93ba-a35f1a5946af'),
	(65,'craft','m170810_201318_create_queue_table','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','73219ef0-b9e0-408e-916e-4e4f3530097e'),
	(66,'craft','m170816_133741_delete_compiled_behaviors','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','83b9ffb6-a5cb-4899-9110-aa75853ce821'),
	(67,'craft','m170821_180624_deprecation_line_nullable','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','2b90e389-10ee-47d1-a184-721af1fddb48'),
	(68,'craft','m170903_192801_longblob_for_queue_jobs','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','eb578165-8aa9-40db-92ab-e14a0ad4983c'),
	(69,'craft','m170914_204621_asset_cache_shuffle','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','f6360665-cb73-4add-83f0-936f2e8fd8a1'),
	(70,'craft','m171011_214115_site_groups','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','a89b39c4-85b6-4d90-86be-96f935a3cd0c'),
	(71,'craft','m171012_151440_primary_site','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','25aad42d-2c2d-437b-9bd9-aae7525b7521'),
	(72,'craft','m171013_142500_transform_interlace','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','f11674f4-6004-433e-8bc8-b502f0ba78aa'),
	(73,'craft','m171016_092553_drop_position_select','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','1964cc1d-8a62-43eb-805e-1fa96a7e0de8'),
	(74,'craft','m171016_221244_less_strict_translation_method','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','fbe3d49c-3660-433b-b54c-a6862eb45aef'),
	(75,'craft','m171107_000000_assign_group_permissions','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','5821738f-69b7-40a6-ad16-0fa5112cc70c'),
	(76,'craft','m171117_000001_templatecache_index_tune','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','4f598922-2c71-466d-85d2-938201bc9626'),
	(77,'craft','m171126_105927_disabled_plugins','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','690cbd94-6867-49dd-b15e-45d804962be1'),
	(78,'craft','m171130_214407_craftidtokens_table','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','59019ade-4a80-4a2a-bbe5-cf396d507aa4'),
	(79,'craft','m171202_004225_update_email_settings','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','a77fc52b-e6e1-4eec-b904-e3629483492d'),
	(80,'craft','m171204_000001_templatecache_index_tune_deux','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','f2df496a-7a3d-4ee2-a029-3aae51acdb11'),
	(81,'craft','m171205_130908_remove_craftidtokens_refreshtoken_column','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','4e2df759-557b-497b-8193-442517929609'),
	(82,'craft','m171218_143135_longtext_query_column','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','b3c0a886-99bc-4a51-bac6-e05febd3f0ee'),
	(83,'craft','m171231_055546_environment_variables_to_aliases','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','03052f7e-5e9f-444b-a6aa-7344c5dd2172'),
	(84,'craft','m180113_153740_drop_users_archived_column','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','0b2ad4a4-bd97-400d-b470-07970e595e0f'),
	(85,'craft','m180122_213433_propagate_entries_setting','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','fcfad468-8b91-4ac3-9e83-8374ee1470a6'),
	(86,'craft','m180124_230459_fix_propagate_entries_values','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','cf293f1d-c4cd-4e0b-bb30-c210058b2d40'),
	(87,'craft','m180128_235202_set_tag_slugs','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','a51b8237-1d1d-413b-adf3-e93698db0797'),
	(88,'craft','m180202_185551_fix_focal_points','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','2c14aeef-5c4d-4cf2-a138-9c5e122b7cf0'),
	(89,'craft','m180217_172123_tiny_ints','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','3f6faacf-0eb2-463f-9130-314a78b428b7'),
	(90,'craft','m180321_233505_small_ints','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','293fae23-c7fd-4672-95ff-12e2189cf278'),
	(91,'craft','m180328_115523_new_license_key_statuses','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','a2d2b2c8-28a4-4c39-8807-fecbbf9313b4'),
	(92,'craft','m180404_182320_edition_changes','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','719865af-8a29-4c0e-ba8c-ba12e277f2d8'),
	(93,'craft','m180411_102218_fix_db_routes','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','a0228df9-dff9-42eb-87a9-7088cef664c4'),
	(94,'craft','m180416_205628_resourcepaths_table','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','e721eaa1-27fe-4bd9-ac0f-6dc50dd38ecc'),
	(95,'craft','m180418_205713_widget_cleanup','2018-06-08 15:06:13','2018-06-08 15:06:13','2018-06-08 15:06:13','63d8dcc5-3002-4bdd-8ceb-0e5725a08744'),
	(96,'plugin:redactor','m180430_204710_remove_old_plugins','2018-06-08 15:25:37','2018-06-08 15:25:37','2018-06-08 15:25:37','38b90943-0790-46f8-94e0-43d4f895c1e5'),
	(97,'plugin:redactor','Install','2018-06-08 15:25:37','2018-06-08 15:25:37','2018-06-08 15:25:37','56758315-0480-4d0c-bd34-80e4d9e8b2af'),
	(98,'craft','m180824_193422_case_sensitivity_fixes','2018-09-18 09:45:22','2018-09-18 09:45:22','2018-09-18 09:45:22','494e3d6c-fa4a-4c5f-bd7e-d4006575ff67'),
	(99,'craft','m180901_151639_fix_matrixcontent_tables','2018-09-18 09:45:22','2018-09-18 09:45:22','2018-09-18 09:45:22','4e9bb13f-4c22-47f0-aed4-57e95c2685e1'),
	(100,'craft','m181112_203955_sequences_table','2020-08-18 08:27:54','2020-08-18 08:27:54','2020-08-18 08:27:54','40d6dd0b-6284-4aa1-a3e3-585341c8b9e5'),
	(101,'craft','m170630_161027_deprecation_line_nullable','2020-08-18 08:39:57','2020-08-18 08:39:57','2020-08-18 08:39:57','5e25ef94-1f13-43f4-bf1a-02c1445fd22a'),
	(102,'craft','m180425_203349_searchable_fields','2020-08-18 08:39:57','2020-08-18 08:39:57','2020-08-18 08:39:57','d67d773d-b503-45ae-ad28-f50bc564b5f5'),
	(103,'craft','m180516_153000_uids_in_field_settings','2020-08-18 08:39:58','2020-08-18 08:39:58','2020-08-18 08:39:58','87149c8d-7824-42d8-a47f-1e5a36925eb7'),
	(104,'craft','m180517_173000_user_photo_volume_to_uid','2020-08-18 08:39:58','2020-08-18 08:39:58','2020-08-18 08:39:58','1ac0ad3b-7577-4916-8815-262a003b5571'),
	(105,'craft','m180518_173000_permissions_to_uid','2020-08-18 08:39:58','2020-08-18 08:39:58','2020-08-18 08:39:58','0e752cdb-6c02-40fa-ae3c-1c7f0933b620'),
	(106,'craft','m180520_173000_matrix_context_to_uids','2020-08-18 08:39:58','2020-08-18 08:39:58','2020-08-18 08:39:58','4bdecbfd-3d48-4960-96db-67a101bf6b14'),
	(107,'craft','m180521_172900_project_config_table','2020-08-18 08:39:58','2020-08-18 08:39:58','2020-08-18 08:39:58','9176d054-6fe7-4c97-ad9b-bef4bb6d80e9'),
	(108,'craft','m180521_173000_initial_yml_and_snapshot','2020-08-18 08:39:59','2020-08-18 08:39:59','2020-08-18 08:39:59','4f296f71-f325-4e5e-8a95-c533417e9a73'),
	(109,'craft','m180731_162030_soft_delete_sites','2020-08-18 08:39:59','2020-08-18 08:39:59','2020-08-18 08:39:59','058cb21e-959a-4ff7-abdf-706f7dedf52c'),
	(110,'craft','m180810_214427_soft_delete_field_layouts','2020-08-18 08:39:59','2020-08-18 08:39:59','2020-08-18 08:39:59','0a485583-99d3-4f9b-805d-6043f6dbaf8a'),
	(111,'craft','m180810_214439_soft_delete_elements','2020-08-18 08:40:00','2020-08-18 08:40:00','2020-08-18 08:40:00','3880c4d5-b732-4bd6-8702-326f2e112ead'),
	(112,'craft','m180904_112109_permission_changes','2020-08-18 08:40:00','2020-08-18 08:40:00','2020-08-18 08:40:00','6e1f3b85-6781-48f9-87c7-96044a8fc84e'),
	(113,'craft','m180910_142030_soft_delete_sitegroups','2020-08-18 08:40:00','2020-08-18 08:40:00','2020-08-18 08:40:00','8d35a564-8089-4526-b4c8-4fd0369f7dec'),
	(114,'craft','m181011_160000_soft_delete_asset_support','2020-08-18 08:40:00','2020-08-18 08:40:00','2020-08-18 08:40:00','56226693-6d48-4676-b98a-cb06e2a9cea5'),
	(115,'craft','m181016_183648_set_default_user_settings','2020-08-18 08:40:00','2020-08-18 08:40:00','2020-08-18 08:40:00','5c96e6c6-1817-42fb-a624-88e7156a5cd9'),
	(116,'craft','m181017_225222_system_config_settings','2020-08-18 08:40:01','2020-08-18 08:40:01','2020-08-18 08:40:01','679489a6-13c7-43b2-9b42-ff54295672be'),
	(117,'craft','m181018_222343_drop_userpermissions_from_config','2020-08-18 08:40:01','2020-08-18 08:40:01','2020-08-18 08:40:01','114ed276-e9a7-4f18-a7c8-f0063586e4f0'),
	(118,'craft','m181029_130000_add_transforms_routes_to_config','2020-08-18 08:40:01','2020-08-18 08:40:01','2020-08-18 08:40:01','8a38ee48-e154-43e2-87c3-4fb272907c9e'),
	(119,'craft','m181121_001712_cleanup_field_configs','2020-08-18 08:40:01','2020-08-18 08:40:01','2020-08-18 08:40:01','7f414a15-a3a2-4fe5-aa51-b1bef8903b7e'),
	(120,'craft','m181128_193942_fix_project_config','2020-08-18 08:40:01','2020-08-18 08:40:01','2020-08-18 08:40:01','53262445-d335-4dac-9478-95c07c6e3bf1'),
	(121,'craft','m181130_143040_fix_schema_version','2020-08-18 08:40:01','2020-08-18 08:40:01','2020-08-18 08:40:01','b56ec974-6bf4-4f40-8025-48dd675edabe'),
	(122,'craft','m181211_143040_fix_entry_type_uids','2020-08-18 08:40:01','2020-08-18 08:40:01','2020-08-18 08:40:01','48d5a98c-5570-4775-9cbf-4855dd1d148c'),
	(123,'craft','m181217_153000_fix_structure_uids','2020-08-18 08:40:01','2020-08-18 08:40:01','2020-08-18 08:40:01','d1429eb3-54bb-45dd-b1a5-62dd66417767'),
	(124,'craft','m190104_152725_store_licensed_plugin_editions','2020-08-18 08:40:01','2020-08-18 08:40:01','2020-08-18 08:40:01','3d8fd654-7be4-4d09-ab90-d2b6f4d7393f'),
	(125,'craft','m190108_110000_cleanup_project_config','2020-08-18 08:40:01','2020-08-18 08:40:01','2020-08-18 08:40:01','f6a879b7-4886-48e1-953c-c050a1b1524b'),
	(126,'craft','m190108_113000_asset_field_setting_change','2020-08-18 08:40:01','2020-08-18 08:40:01','2020-08-18 08:40:01','6617d0eb-a986-4226-94b1-364498b4d74f'),
	(127,'craft','m190109_172845_fix_colspan','2020-08-18 08:40:01','2020-08-18 08:40:01','2020-08-18 08:40:01','acce490e-4ff8-416d-beff-0c2ca4b800d7'),
	(128,'craft','m190110_150000_prune_nonexisting_sites','2020-08-18 08:40:01','2020-08-18 08:40:01','2020-08-18 08:40:01','c02f1953-6d72-492b-a9b4-e6f2b61fe545'),
	(129,'craft','m190110_214819_soft_delete_volumes','2020-08-18 08:40:02','2020-08-18 08:40:02','2020-08-18 08:40:02','bd632c8c-0b70-418b-947d-04142dfe9d09'),
	(130,'craft','m190112_124737_fix_user_settings','2020-08-18 08:40:02','2020-08-18 08:40:02','2020-08-18 08:40:02','1e1ec6fe-5b59-4249-b048-ad46501e38f1'),
	(131,'craft','m190112_131225_fix_field_layouts','2020-08-18 08:40:02','2020-08-18 08:40:02','2020-08-18 08:40:02','45711c53-9876-4608-b6c0-58cb4b7e2659'),
	(132,'craft','m190112_201010_more_soft_deletes','2020-08-18 08:40:04','2020-08-18 08:40:04','2020-08-18 08:40:04','ef03c7f8-461c-44cc-b4f2-5fc94c9acc95'),
	(133,'craft','m190114_143000_more_asset_field_setting_changes','2020-08-18 08:40:04','2020-08-18 08:40:04','2020-08-18 08:40:04','2bc9de12-8d67-4e6a-8313-66f1e4024123'),
	(134,'craft','m190121_120000_rich_text_config_setting','2020-08-18 08:40:04','2020-08-18 08:40:04','2020-08-18 08:40:04','a6d9e9ab-bd14-4437-908c-2925f1c8b3f3'),
	(135,'craft','m190125_191628_fix_email_transport_password','2020-08-18 08:40:04','2020-08-18 08:40:04','2020-08-18 08:40:04','54f3fa56-1df6-42ef-87a4-02912d3ccb22'),
	(136,'craft','m190128_181422_cleanup_volume_folders','2020-08-18 08:40:04','2020-08-18 08:40:04','2020-08-18 08:40:04','0dfd40d2-219f-4942-b72a-c05d1277add7'),
	(137,'craft','m190205_140000_fix_asset_soft_delete_index','2020-08-18 08:40:04','2020-08-18 08:40:04','2020-08-18 08:40:04','e8e0c5c6-7c6a-46e1-8f3d-8491de379f9a'),
	(138,'craft','m190218_143000_element_index_settings_uid','2020-08-18 08:40:04','2020-08-18 08:40:04','2020-08-18 08:40:04','cba1556c-3f49-4e3c-a550-04f2c2986966'),
	(139,'craft','m190312_152740_element_revisions','2020-08-18 08:40:06','2020-08-18 08:40:06','2020-08-18 08:40:06','8ef9a59d-7ebc-4174-96dd-0c129c816f6c'),
	(140,'craft','m190327_235137_propagation_method','2020-08-18 08:40:07','2020-08-18 08:40:07','2020-08-18 08:40:07','66040386-f40b-4715-a486-9969501e951c'),
	(141,'craft','m190401_223843_drop_old_indexes','2020-08-18 08:40:07','2020-08-18 08:40:07','2020-08-18 08:40:07','5ac168fe-1496-4077-b94d-0b44bc9c6f17'),
	(142,'craft','m190416_014525_drop_unique_global_indexes','2020-08-18 08:40:07','2020-08-18 08:40:07','2020-08-18 08:40:07','3e384e14-fd35-42ea-bfed-313ffb476b51'),
	(143,'craft','m190417_085010_add_image_editor_permissions','2020-08-18 08:40:07','2020-08-18 08:40:07','2020-08-18 08:40:07','8455fd5e-65a2-4073-a45e-39cfa681b74b'),
	(144,'craft','m190502_122019_store_default_user_group_uid','2020-08-18 08:40:07','2020-08-18 08:40:07','2020-08-18 08:40:07','c49f6260-606c-4366-a0d5-ff3f6cdaaec0'),
	(145,'craft','m190504_150349_preview_targets','2020-08-18 08:40:07','2020-08-18 08:40:07','2020-08-18 08:40:07','5586dec9-ec42-46b3-86d8-aa8eb07f92ce'),
	(146,'craft','m190516_184711_job_progress_label','2020-08-18 08:40:07','2020-08-18 08:40:07','2020-08-18 08:40:07','5abd4c81-ce44-46f0-821e-0054d86462a7'),
	(147,'craft','m190523_190303_optional_revision_creators','2020-08-18 08:40:08','2020-08-18 08:40:08','2020-08-18 08:40:08','db7d6db4-0ecf-4329-b5b6-0afafd5f05ab'),
	(148,'craft','m190529_204501_fix_duplicate_uids','2020-08-18 08:40:08','2020-08-18 08:40:08','2020-08-18 08:40:08','b09b6707-1d06-4032-8f28-301df87b3c19'),
	(149,'craft','m190605_223807_unsaved_drafts','2020-08-18 08:40:08','2020-08-18 08:40:08','2020-08-18 08:40:08','fa7f4dde-fd0a-4ed4-b6e8-2c388bc26e03'),
	(150,'craft','m190607_230042_entry_revision_error_tables','2020-08-18 08:40:08','2020-08-18 08:40:08','2020-08-18 08:40:08','7b715b39-e3bd-46b7-8ac3-d54473bfb314'),
	(151,'craft','m190608_033429_drop_elements_uid_idx','2020-08-18 08:40:08','2020-08-18 08:40:08','2020-08-18 08:40:08','fd150552-1468-442f-b539-8d8cd2d5b05a'),
	(152,'craft','m190617_164400_add_gqlschemas_table','2020-08-18 08:40:08','2020-08-18 08:40:08','2020-08-18 08:40:08','45913408-5ca9-483f-85a4-c463209ec122'),
	(153,'craft','m190624_234204_matrix_propagation_method','2020-08-18 08:40:08','2020-08-18 08:40:08','2020-08-18 08:40:08','f89a9426-371f-4018-b3ac-076974a7fb0e'),
	(154,'craft','m190711_153020_drop_snapshots','2020-08-18 08:40:08','2020-08-18 08:40:08','2020-08-18 08:40:08','756f7258-426d-44b2-bace-d00b0666bcfe'),
	(155,'craft','m190712_195914_no_draft_revisions','2020-08-18 08:40:08','2020-08-18 08:40:08','2020-08-18 08:40:08','2c6c317b-5cb7-4033-9e6f-8832bbf2ba6e'),
	(156,'craft','m190723_140314_fix_preview_targets_column','2020-08-18 08:40:08','2020-08-18 08:40:08','2020-08-18 08:40:08','5ca5a631-5e82-4b4e-93ed-58199056f3dc'),
	(157,'craft','m190820_003519_flush_compiled_templates','2020-08-18 08:40:08','2020-08-18 08:40:08','2020-08-18 08:40:08','7787d7c3-79ac-4a20-9c2f-d408eab7d90c'),
	(158,'craft','m190823_020339_optional_draft_creators','2020-08-18 08:40:08','2020-08-18 08:40:08','2020-08-18 08:40:08','3b8257f8-ddd1-4b7b-8072-9d171e39c066'),
	(159,'craft','m190913_152146_update_preview_targets','2020-08-18 08:40:09','2020-08-18 08:40:09','2020-08-18 08:40:09','b6f96acb-0539-4ee0-9263-14fa63e5169b'),
	(160,'craft','m191107_122000_add_gql_project_config_support','2020-08-18 08:40:10','2020-08-18 08:40:10','2020-08-18 08:40:10','a76b8703-283d-4b28-a96e-f8dd6e511486'),
	(161,'craft','m191204_085100_pack_savable_component_settings','2020-08-18 08:40:10','2020-08-18 08:40:10','2020-08-18 08:40:10','f960b048-9772-48d5-b8ae-4fb090eac084'),
	(162,'craft','m191206_001148_change_tracking','2020-08-18 08:40:11','2020-08-18 08:40:11','2020-08-18 08:40:11','b2567541-10fb-4a3f-860d-e9a0ccaba7ca'),
	(163,'craft','m191216_191635_asset_upload_tracking','2020-08-18 08:40:11','2020-08-18 08:40:11','2020-08-18 08:40:11','c4e01a0c-7bc4-4643-8f68-3c8ad9a13e8b'),
	(164,'craft','m191222_002848_peer_asset_permissions','2020-08-18 08:40:11','2020-08-18 08:40:11','2020-08-18 08:40:11','2f13bb28-99bf-4af3-8cc2-5bbb10da4e45'),
	(165,'craft','m200127_172522_queue_channels','2020-08-18 08:40:12','2020-08-18 08:40:12','2020-08-18 08:40:12','6c9c8162-2b4b-4b18-bdf9-d7c8ba0e9914'),
	(166,'craft','m200211_175048_truncate_element_query_cache','2020-08-18 08:40:12','2020-08-18 08:40:12','2020-08-18 08:40:12','1b47e3da-5692-432a-8a6f-361ed905bb80'),
	(167,'craft','m200213_172522_new_elements_index','2020-08-18 08:40:12','2020-08-18 08:40:12','2020-08-18 08:40:12','e9a66682-1426-45de-8290-59af3b88215b'),
	(168,'craft','m200228_195211_long_deprecation_messages','2020-08-18 08:40:12','2020-08-18 08:40:12','2020-08-18 08:40:12','1b632640-01fa-4715-bee0-5950c78a3608'),
	(169,'craft','m200306_054652_disabled_sites','2020-08-18 08:40:12','2020-08-18 08:40:12','2020-08-18 08:40:12','de4c282f-78c4-440a-9396-1e61e40a31ee'),
	(170,'craft','m200522_191453_clear_template_caches','2020-08-18 08:40:12','2020-08-18 08:40:12','2020-08-18 08:40:12','21f99f80-32ab-4ca3-a0db-51255d7b9db3'),
	(171,'craft','m200606_231117_migration_tracks','2020-08-18 08:40:13','2020-08-18 08:40:13','2020-08-18 08:40:13','4914fa58-884b-4073-a458-a261aed64716'),
	(172,'craft','m200619_215137_title_translation_method','2020-08-18 08:40:14','2020-08-18 08:40:14','2020-08-18 08:40:14','f0807ec9-b76f-484c-ae67-64dcf62aa74b'),
	(173,'craft','m200620_005028_user_group_descriptions','2020-08-18 08:40:14','2020-08-18 08:40:14','2020-08-18 08:40:14','b2f0c3b1-fa41-4b6d-b45d-8ec9188ffcfc'),
	(174,'craft','m200620_230205_field_layout_changes','2020-08-18 08:40:14','2020-08-18 08:40:14','2020-08-18 08:40:14','a3b68612-417d-4646-aec7-1fb8b10b8c1f'),
	(175,'craft','m200625_131100_move_entrytypes_to_top_project_config','2020-08-18 08:40:14','2020-08-18 08:40:14','2020-08-18 08:40:14','fef5f340-d268-47b2-a4af-06276f57e123'),
	(176,'craft','m200629_112700_remove_project_config_legacy_files','2020-08-18 08:40:14','2020-08-18 08:40:14','2020-08-18 08:40:14','06c09ef0-f7f9-4ddd-98a4-777b67e04c75'),
	(177,'craft','m200630_183000_drop_configmap','2020-08-18 08:40:14','2020-08-18 08:40:14','2020-08-18 08:40:14','ee3f8a4c-3f49-40fb-b7c7-5e04ac27688e'),
	(178,'craft','m200715_113400_transform_index_error_flag','2020-08-18 08:40:15','2020-08-18 08:40:15','2020-08-18 08:40:15','4ba121ce-b494-4d00-9239-6772ef255b33'),
	(179,'craft','m200716_110900_replace_file_asset_permissions','2020-08-18 08:40:15','2020-08-18 08:40:15','2020-08-18 08:40:15','38b2ea0c-df9e-449d-ae26-97710bebf430'),
	(180,'craft','m200716_153800_public_token_settings_in_project_config','2020-08-18 08:40:15','2020-08-18 08:40:15','2020-08-18 08:40:15','a0661f5a-55ba-4129-b147-0e7715fca2bd'),
	(181,'craft','m200720_175543_drop_unique_constraints','2020-08-18 08:40:15','2020-08-18 08:40:15','2020-08-18 08:40:15','10e7726b-4c87-4eeb-bbe7-eaed2d1c53da'),
	(182,'plugin:redactor','m190225_003922_split_cleanup_html_settings','2020-08-18 09:28:28','2020-08-18 09:28:28','2020-08-18 09:28:28','54dae058-a683-4011-94bd-2a6506a81ec9'),
	(183,'craft','m200825_051217_project_config_version','2021-12-07 16:56:00','2021-12-07 16:56:00','2021-12-07 16:56:00','a49fc293-a654-446c-9901-42aa58b20f83'),
	(184,'craft','m201116_190500_asset_title_translation_method','2021-12-07 16:56:01','2021-12-07 16:56:01','2021-12-07 16:56:01','aa320646-b932-480c-b84f-f753aa4ed1a1'),
	(185,'craft','m201124_003555_plugin_trials','2021-12-07 16:56:01','2021-12-07 16:56:01','2021-12-07 16:56:01','3e658352-1917-4a15-b166-753cccc3bffe'),
	(186,'craft','m210209_135503_soft_delete_field_groups','2021-12-07 16:56:01','2021-12-07 16:56:01','2021-12-07 16:56:01','26365423-ea99-4166-a050-35268888f61d'),
	(187,'craft','m210212_223539_delete_invalid_drafts','2021-12-07 16:56:01','2021-12-07 16:56:01','2021-12-07 16:56:01','e482d40a-0a3a-4570-9fd2-c60e7541dd6e'),
	(188,'craft','m210214_202731_track_saved_drafts','2021-12-07 16:56:01','2021-12-07 16:56:01','2021-12-07 16:56:01','f1cfba93-84a8-4a32-9969-dc1164df35e5'),
	(189,'craft','m210223_150900_add_new_element_gql_schema_components','2021-12-07 16:56:01','2021-12-07 16:56:01','2021-12-07 16:56:01','3f90185f-f643-44ae-b94f-4a9ff48a3662'),
	(190,'craft','m210302_212318_canonical_elements','2021-12-07 16:56:01','2021-12-07 16:56:01','2021-12-07 16:56:01','c514f644-8078-4f9e-82c1-6a5fd223a0e7'),
	(191,'craft','m210326_132000_invalidate_projectconfig_cache','2021-12-07 16:56:01','2021-12-07 16:56:01','2021-12-07 16:56:01','15ac2b14-abf3-4977-9326-fe547700004a'),
	(192,'craft','m210329_214847_field_column_suffixes','2021-12-07 16:56:01','2021-12-07 16:56:01','2021-12-07 16:56:01','1f2add1b-931f-41ab-879c-42392300850b'),
	(193,'craft','m210331_220322_null_author','2021-12-07 16:56:01','2021-12-07 16:56:01','2021-12-07 16:56:01','624aa2d9-228b-41db-96b8-4266ab098a15'),
	(194,'craft','m210405_231315_provisional_drafts','2021-12-07 16:56:01','2021-12-07 16:56:01','2021-12-07 16:56:01','57dc5478-e0f8-47ef-8ad8-f65a292badf8'),
	(195,'craft','m210602_111300_project_config_names_in_config','2021-12-07 16:56:01','2021-12-07 16:56:01','2021-12-07 16:56:01','542f9670-a74a-4a64-b541-dbe9543f53d3'),
	(196,'craft','m210611_233510_default_placement_settings','2021-12-07 16:56:01','2021-12-07 16:56:01','2021-12-07 16:56:01','2bd6903b-654d-4cb8-88d4-4f9e539a20d5'),
	(197,'craft','m210613_145522_sortable_global_sets','2021-12-07 16:56:01','2021-12-07 16:56:01','2021-12-07 16:56:01','75d0d53c-601f-47e7-bc37-656e4353ffec'),
	(198,'craft','m210613_184103_announcements','2021-12-07 16:56:01','2021-12-07 16:56:01','2021-12-07 16:56:01','60bf9dc9-6053-4821-8d86-615e8be57cbf'),
	(199,'craft','m210829_000000_element_index_tweak','2021-12-07 16:56:01','2021-12-07 16:56:01','2021-12-07 16:56:01','402e1f42-ee74-41d8-af9c-ef48bf91eea0');

/*!40000 ALTER TABLE `cc1_migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_plugins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_plugins`;

CREATE TABLE `cc1_plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','trial','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_plugins` WRITE;
/*!40000 ALTER TABLE `cc1_plugins` DISABLE KEYS */;

INSERT INTO `cc1_plugins` (`id`, `handle`, `version`, `schemaVersion`, `licenseKeyStatus`, `licensedEdition`, `installDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'field-manager','2.2.4','1.0.0','unknown',NULL,'2018-06-08 15:14:14','2018-06-08 15:14:14','2022-01-10 13:55:11','a53ecf0d-1a53-42b1-870d-4389f5a5bede'),
	(2,'redactor','2.8.8','2.3.0','unknown',NULL,'2018-06-08 15:25:37','2018-06-08 15:25:37','2022-01-10 13:55:11','085ae0a9-2d89-4064-ac8c-fdc8b58fa489'),
	(3,'cookies','1.1.15','1.0.0','unknown',NULL,'2018-09-18 09:43:04','2018-09-18 09:43:04','2022-01-10 13:55:11','2b4da8e1-1364-41aa-a112-a9facb85fd36'),
	(4,'tablemaker','2.0.1','1.0.0','unknown',NULL,'2018-09-20 14:30:11','2018-09-20 14:30:11','2022-01-10 13:55:11','96e726c2-be9b-41f3-b50f-822d793a240c'),
	(5,'kint','1.0.0','1.0.0','unknown',NULL,'2021-12-23 09:14:14','2021-12-23 09:14:14','2022-01-10 13:55:11','279f3ae3-33f1-4416-b7b5-90f1edffe767');

/*!40000 ALTER TABLE `cc1_plugins` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_projectconfig
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_projectconfig`;

CREATE TABLE `cc1_projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_projectconfig` WRITE;
/*!40000 ALTER TABLE `cc1_projectconfig` DISABLE KEYS */;

INSERT INTO `cc1_projectconfig` (`path`, `value`)
VALUES
	('categoryGroups.487681cb-7ad0-4313-b7f4-dd17bba6be08.handle','\"userType\"'),
	('categoryGroups.487681cb-7ad0-4313-b7f4-dd17bba6be08.name','\"User Type\"'),
	('categoryGroups.487681cb-7ad0-4313-b7f4-dd17bba6be08.siteSettings.68b81c3c-1a31-4373-89c3-7dbdff84908c.hasUrls','true'),
	('categoryGroups.487681cb-7ad0-4313-b7f4-dd17bba6be08.siteSettings.68b81c3c-1a31-4373-89c3-7dbdff84908c.template','\"user-type/_category\"'),
	('categoryGroups.487681cb-7ad0-4313-b7f4-dd17bba6be08.siteSettings.68b81c3c-1a31-4373-89c3-7dbdff84908c.uriFormat','\"user-type/{slug}\"'),
	('categoryGroups.487681cb-7ad0-4313-b7f4-dd17bba6be08.structure.maxLevels','null'),
	('categoryGroups.487681cb-7ad0-4313-b7f4-dd17bba6be08.structure.uid','\"9e0fada2-4eb1-4c1f-86c4-139419ba319b\"'),
	('dateModified','1640250854'),
	('email.fromEmail','\"d.hughes@concertconsult.co.uk\"'),
	('email.fromName','\"Concert Base Craft 3\"'),
	('email.template','\"\"'),
	('email.transportSettings.password','\"test\"'),
	('email.transportSettings.timeout','\"10\"'),
	('email.transportSettings.username','\"test\"'),
	('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Gmail\"'),
	('entryTypes.7f619003-659d-4e4c-89a4-f62a69b611e0.handle','\"homepage\"'),
	('entryTypes.7f619003-659d-4e4c-89a4-f62a69b611e0.hasTitleField','false'),
	('entryTypes.7f619003-659d-4e4c-89a4-f62a69b611e0.name','\"Homepage\"'),
	('entryTypes.7f619003-659d-4e4c-89a4-f62a69b611e0.section','\"e3ca366b-16e2-4855-a2a5-9c0f779d8c1b\"'),
	('entryTypes.7f619003-659d-4e4c-89a4-f62a69b611e0.sortOrder','1'),
	('entryTypes.7f619003-659d-4e4c-89a4-f62a69b611e0.titleFormat','\"{section.name|raw}\"'),
	('entryTypes.7f619003-659d-4e4c-89a4-f62a69b611e0.titleLabel','null'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.0.elements.0.instructions','null'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.0.elements.0.label','\"Title\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.0.elements.1.fieldUid','\"f1d06c4c-d798-495c-8897-846aeea5932c\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.0.elements.1.required','false'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.0.elements.2.fieldUid','\"093fa743-22d4-484c-a853-1101eac54810\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.0.elements.2.required','false'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.0.name','\"Common\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.0.sortOrder','1'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.1.elements.0.fieldUid','\"7440313c-7463-4420-9eb9-241d282c63e0\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.1.elements.0.required','false'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.1.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.1.elements.1.fieldUid','\"e62d7067-3196-4b2d-9ca7-639bdc6d66e1\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.1.elements.1.required','false'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.1.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.1.elements.2.fieldUid','\"dc209373-ba42-457b-b966-9348d5dc2bd0\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.1.elements.2.required','false'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.1.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.1.elements.3.fieldUid','\"6fe97c8b-54af-45ab-8350-0e7d9b783087\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.1.elements.3.required','false'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.1.elements.3.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.1.name','\"Meta Data\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.fieldLayouts.4fd8c12b-1e5b-4faa-b9bf-da87b0cd5d25.tabs.1.sortOrder','2'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.handle','\"default\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.hasTitleField','true'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.name','\"Default\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.section','\"39f758c4-55bd-4111-9963-e5d9a7143820\"'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.sortOrder','1'),
	('entryTypes.d4e1f2ba-ed64-4743-b767-9cfdf9c65220.titleFormat','null'),
	('entryTypes.e9185c5d-5c46-404d-8b9e-0f6bd3904f2d.handle','\"complexBlockExample\"'),
	('entryTypes.e9185c5d-5c46-404d-8b9e-0f6bd3904f2d.hasTitleField','true'),
	('entryTypes.e9185c5d-5c46-404d-8b9e-0f6bd3904f2d.name','\"Complex block example\"'),
	('entryTypes.e9185c5d-5c46-404d-8b9e-0f6bd3904f2d.section','\"93167c2e-8b5f-495c-a89a-3de3262088c3\"'),
	('entryTypes.e9185c5d-5c46-404d-8b9e-0f6bd3904f2d.sortOrder','1'),
	('entryTypes.e9185c5d-5c46-404d-8b9e-0f6bd3904f2d.titleFormat','null'),
	('entryTypes.e9185c5d-5c46-404d-8b9e-0f6bd3904f2d.titleLabel','\"Title\"'),
	('fieldGroups.19f91227-b509-4907-9c91-9588a3b86198.name','\"Common\"'),
	('fieldGroups.1a3f503b-1ef7-4fcf-a7a1-5c428503eaf7.name','\"Meta Data\"'),
	('fields.093fa743-22d4-484c-a853-1101eac54810.contentColumnType','\"string\"'),
	('fields.093fa743-22d4-484c-a853-1101eac54810.fieldGroup','\"19f91227-b509-4907-9c91-9588a3b86198\"'),
	('fields.093fa743-22d4-484c-a853-1101eac54810.handle','\"contentBlocks\"'),
	('fields.093fa743-22d4-484c-a853-1101eac54810.instructions','\"\"'),
	('fields.093fa743-22d4-484c-a853-1101eac54810.name','\"Content Blocks\"'),
	('fields.093fa743-22d4-484c-a853-1101eac54810.searchable','true'),
	('fields.093fa743-22d4-484c-a853-1101eac54810.settings.contentTable','\"{{%matrixcontent_contentblocks}}\"'),
	('fields.093fa743-22d4-484c-a853-1101eac54810.settings.maxBlocks','\"\"'),
	('fields.093fa743-22d4-484c-a853-1101eac54810.settings.minBlocks','\"\"'),
	('fields.093fa743-22d4-484c-a853-1101eac54810.settings.propagationMethod','\"all\"'),
	('fields.093fa743-22d4-484c-a853-1101eac54810.translationKeyFormat','null'),
	('fields.093fa743-22d4-484c-a853-1101eac54810.translationMethod','\"site\"'),
	('fields.093fa743-22d4-484c-a853-1101eac54810.type','\"craft\\\\fields\\\\Matrix\"'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.contentColumnType','\"string\"'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.fieldGroup','\"1a3f503b-1ef7-4fcf-a7a1-5c428503eaf7\"'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.handle','\"openGraphImage\"'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.instructions','\"\"'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.name','\"Open Graph Image\"'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.searchable','true'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.settings.allowedKinds','null'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.settings.defaultUploadLocationSource','null'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.settings.defaultUploadLocationSubpath','\"\"'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.settings.limit','\"\"'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.settings.localizeRelations','false'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.settings.restrictFiles','\"\"'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.settings.selectionLabel','\"\"'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.settings.singleUploadLocationSource','null'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.settings.singleUploadLocationSubpath','\"\"'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.settings.source','null'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.settings.sources','\"*\"'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.settings.targetSiteId','null'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.settings.useSingleFolder','\"\"'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.settings.viewMode','\"list\"'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.translationKeyFormat','null'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.translationMethod','\"site\"'),
	('fields.6fe97c8b-54af-45ab-8350-0e7d9b783087.type','\"craft\\\\fields\\\\Assets\"'),
	('fields.7440313c-7463-4420-9eb9-241d282c63e0.contentColumnType','\"text\"'),
	('fields.7440313c-7463-4420-9eb9-241d282c63e0.fieldGroup','\"1a3f503b-1ef7-4fcf-a7a1-5c428503eaf7\"'),
	('fields.7440313c-7463-4420-9eb9-241d282c63e0.handle','\"metaDescription\"'),
	('fields.7440313c-7463-4420-9eb9-241d282c63e0.instructions','\"\"'),
	('fields.7440313c-7463-4420-9eb9-241d282c63e0.name','\"Meta Description\"'),
	('fields.7440313c-7463-4420-9eb9-241d282c63e0.searchable','true'),
	('fields.7440313c-7463-4420-9eb9-241d282c63e0.settings.charLimit','\"\"'),
	('fields.7440313c-7463-4420-9eb9-241d282c63e0.settings.code','\"\"'),
	('fields.7440313c-7463-4420-9eb9-241d282c63e0.settings.columnType','\"text\"'),
	('fields.7440313c-7463-4420-9eb9-241d282c63e0.settings.initialRows','\"4\"'),
	('fields.7440313c-7463-4420-9eb9-241d282c63e0.settings.multiline','\"\"'),
	('fields.7440313c-7463-4420-9eb9-241d282c63e0.settings.placeholder','\"\"'),
	('fields.7440313c-7463-4420-9eb9-241d282c63e0.translationKeyFormat','null'),
	('fields.7440313c-7463-4420-9eb9-241d282c63e0.translationMethod','\"none\"'),
	('fields.7440313c-7463-4420-9eb9-241d282c63e0.type','\"craft\\\\fields\\\\PlainText\"'),
	('fields.dc209373-ba42-457b-b966-9348d5dc2bd0.contentColumnType','\"text\"'),
	('fields.dc209373-ba42-457b-b966-9348d5dc2bd0.fieldGroup','\"1a3f503b-1ef7-4fcf-a7a1-5c428503eaf7\"'),
	('fields.dc209373-ba42-457b-b966-9348d5dc2bd0.handle','\"metaTitle\"'),
	('fields.dc209373-ba42-457b-b966-9348d5dc2bd0.instructions','\"\"'),
	('fields.dc209373-ba42-457b-b966-9348d5dc2bd0.name','\"Meta Title\"'),
	('fields.dc209373-ba42-457b-b966-9348d5dc2bd0.searchable','true'),
	('fields.dc209373-ba42-457b-b966-9348d5dc2bd0.settings.charLimit','\"\"'),
	('fields.dc209373-ba42-457b-b966-9348d5dc2bd0.settings.code','\"\"'),
	('fields.dc209373-ba42-457b-b966-9348d5dc2bd0.settings.columnType','\"text\"'),
	('fields.dc209373-ba42-457b-b966-9348d5dc2bd0.settings.initialRows','\"4\"'),
	('fields.dc209373-ba42-457b-b966-9348d5dc2bd0.settings.multiline','\"\"'),
	('fields.dc209373-ba42-457b-b966-9348d5dc2bd0.settings.placeholder','\"\"'),
	('fields.dc209373-ba42-457b-b966-9348d5dc2bd0.translationKeyFormat','null'),
	('fields.dc209373-ba42-457b-b966-9348d5dc2bd0.translationMethod','\"none\"'),
	('fields.dc209373-ba42-457b-b966-9348d5dc2bd0.type','\"craft\\\\fields\\\\PlainText\"'),
	('fields.e62d7067-3196-4b2d-9ca7-639bdc6d66e1.contentColumnType','\"text\"'),
	('fields.e62d7067-3196-4b2d-9ca7-639bdc6d66e1.fieldGroup','\"1a3f503b-1ef7-4fcf-a7a1-5c428503eaf7\"'),
	('fields.e62d7067-3196-4b2d-9ca7-639bdc6d66e1.handle','\"metaRobots\"'),
	('fields.e62d7067-3196-4b2d-9ca7-639bdc6d66e1.instructions','\"\"'),
	('fields.e62d7067-3196-4b2d-9ca7-639bdc6d66e1.name','\"Meta Robots\"'),
	('fields.e62d7067-3196-4b2d-9ca7-639bdc6d66e1.searchable','true'),
	('fields.e62d7067-3196-4b2d-9ca7-639bdc6d66e1.settings.charLimit','\"\"'),
	('fields.e62d7067-3196-4b2d-9ca7-639bdc6d66e1.settings.code','\"\"'),
	('fields.e62d7067-3196-4b2d-9ca7-639bdc6d66e1.settings.columnType','\"text\"'),
	('fields.e62d7067-3196-4b2d-9ca7-639bdc6d66e1.settings.initialRows','\"4\"'),
	('fields.e62d7067-3196-4b2d-9ca7-639bdc6d66e1.settings.multiline','\"\"'),
	('fields.e62d7067-3196-4b2d-9ca7-639bdc6d66e1.settings.placeholder','\"\"'),
	('fields.e62d7067-3196-4b2d-9ca7-639bdc6d66e1.translationKeyFormat','null'),
	('fields.e62d7067-3196-4b2d-9ca7-639bdc6d66e1.translationMethod','\"none\"'),
	('fields.e62d7067-3196-4b2d-9ca7-639bdc6d66e1.type','\"craft\\\\fields\\\\PlainText\"'),
	('fields.f1d06c4c-d798-495c-8897-846aeea5932c.contentColumnType','\"string\"'),
	('fields.f1d06c4c-d798-495c-8897-846aeea5932c.fieldGroup','\"19f91227-b509-4907-9c91-9588a3b86198\"'),
	('fields.f1d06c4c-d798-495c-8897-846aeea5932c.handle','\"pageAudience\"'),
	('fields.f1d06c4c-d798-495c-8897-846aeea5932c.instructions','\"\"'),
	('fields.f1d06c4c-d798-495c-8897-846aeea5932c.name','\"Page Audience\"'),
	('fields.f1d06c4c-d798-495c-8897-846aeea5932c.searchable','true'),
	('fields.f1d06c4c-d798-495c-8897-846aeea5932c.settings.branchLimit','\"\"'),
	('fields.f1d06c4c-d798-495c-8897-846aeea5932c.settings.limit','null'),
	('fields.f1d06c4c-d798-495c-8897-846aeea5932c.settings.localizeRelations','false'),
	('fields.f1d06c4c-d798-495c-8897-846aeea5932c.settings.selectionLabel','\"\"'),
	('fields.f1d06c4c-d798-495c-8897-846aeea5932c.settings.source','\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\"'),
	('fields.f1d06c4c-d798-495c-8897-846aeea5932c.settings.sources','\"*\"'),
	('fields.f1d06c4c-d798-495c-8897-846aeea5932c.settings.targetSiteId','null'),
	('fields.f1d06c4c-d798-495c-8897-846aeea5932c.settings.viewMode','null'),
	('fields.f1d06c4c-d798-495c-8897-846aeea5932c.translationKeyFormat','null'),
	('fields.f1d06c4c-d798-495c-8897-846aeea5932c.translationMethod','\"site\"'),
	('fields.f1d06c4c-d798-495c-8897-846aeea5932c.type','\"craft\\\\fields\\\\Categories\"'),
	('graphql.publicToken.enabled','false'),
	('graphql.publicToken.expiryDate','null'),
	('graphql.schemas.161d2128-bf6c-472d-9226-87d639514edd.isPublic','true'),
	('graphql.schemas.161d2128-bf6c-472d-9226-87d639514edd.name','\"Public Schema\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.field','\"093fa743-22d4-484c-a853-1101eac54810\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.0.fieldUid','\"b4609297-ca56-4695-a83b-501b8cc00f69\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.0.instructions','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.0.label','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.0.required','true'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.0.tip','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.0.warning','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.0.width','100'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.1.fieldUid','\"198eace8-d3c2-49be-b3f1-73c39d079e46\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.1.instructions','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.1.label','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.1.required','true'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.1.tip','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.1.warning','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.1.width','100'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.2.fieldUid','\"3fa300c4-ea59-46b4-a8ce-3f73030ed3ce\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.2.instructions','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.2.label','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.2.required','false'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.2.tip','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.2.warning','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.elements.2.width','100'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fieldLayouts.c615ba6a-f6ea-4cf0-9f48-6238b6f411a6.tabs.0.sortOrder','1'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.contentColumnType','\"string\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.fieldGroup','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.handle','\"complexEntry\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.instructions','\"\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.name','\"Complex Entry\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.searchable','true'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.settings.allowSelfRelations','false'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.settings.limit','\"1\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.settings.localizeRelations','false'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.settings.selectionLabel','\"\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.settings.showSiteMenu','true'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.settings.source','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.settings.sources','\"*\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.settings.targetSiteId','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.settings.validateRelatedElements','false'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.settings.viewMode','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.translationKeyFormat','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.translationMethod','\"site\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.198eace8-d3c2-49be-b3f1-73c39d079e46.type','\"craft\\\\fields\\\\Entries\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.3fa300c4-ea59-46b4-a8ce-3f73030ed3ce.contentColumnType','\"text\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.3fa300c4-ea59-46b4-a8ce-3f73030ed3ce.fieldGroup','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.3fa300c4-ea59-46b4-a8ce-3f73030ed3ce.handle','\"customClass\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.3fa300c4-ea59-46b4-a8ce-3f73030ed3ce.instructions','\"\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.3fa300c4-ea59-46b4-a8ce-3f73030ed3ce.name','\"Custom Class\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.3fa300c4-ea59-46b4-a8ce-3f73030ed3ce.searchable','true'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.3fa300c4-ea59-46b4-a8ce-3f73030ed3ce.settings.byteLimit','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.3fa300c4-ea59-46b4-a8ce-3f73030ed3ce.settings.charLimit','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.3fa300c4-ea59-46b4-a8ce-3f73030ed3ce.settings.code','\"\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.3fa300c4-ea59-46b4-a8ce-3f73030ed3ce.settings.columnType','\"text\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.3fa300c4-ea59-46b4-a8ce-3f73030ed3ce.settings.initialRows','\"4\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.3fa300c4-ea59-46b4-a8ce-3f73030ed3ce.settings.multiline','\"\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.3fa300c4-ea59-46b4-a8ce-3f73030ed3ce.settings.placeholder','\"\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.3fa300c4-ea59-46b4-a8ce-3f73030ed3ce.settings.uiMode','\"normal\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.3fa300c4-ea59-46b4-a8ce-3f73030ed3ce.translationKeyFormat','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.3fa300c4-ea59-46b4-a8ce-3f73030ed3ce.translationMethod','\"none\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.3fa300c4-ea59-46b4-a8ce-3f73030ed3ce.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.contentColumnType','\"string\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.fieldGroup','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.handle','\"audience\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.instructions','\"\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.name','\"Audience\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.searchable','true'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.settings.allowLimit','false'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.settings.allowMultipleSources','false'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.settings.allowSelfRelations','false'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.settings.branchLimit','\"\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.settings.limit','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.settings.localizeRelations','false'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.settings.selectionLabel','\"\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.settings.showSiteMenu','true'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.settings.source','\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.settings.sources','\"*\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.settings.targetSiteId','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.settings.validateRelatedElements','false'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.settings.viewMode','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.translationKeyFormat','null'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.translationMethod','\"site\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.fields.b4609297-ca56-4695-a83b-501b8cc00f69.type','\"craft\\\\fields\\\\Categories\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.handle','\"complexBlock\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.name','\"Complex Block\"'),
	('matrixBlockTypes.08fbe61c-eb52-486c-8fb2-3fec0451c15c.sortOrder','10'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.field','\"093fa743-22d4-484c-a853-1101eac54810\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.0.fieldUid','\"e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.0.instructions','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.0.label','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.0.required','true'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.0.tip','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.0.warning','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.0.width','100'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.1.fieldUid','\"760aa4ac-bb5c-4db3-b72d-2883f1e62b94\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.1.instructions','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.1.label','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.1.required','false'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.1.tip','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.1.warning','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.1.width','100'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.2.fieldUid','\"d21039a6-5a67-4877-8b49-1d312d245ed7\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.2.instructions','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.2.label','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.2.required','false'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.2.tip','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.2.warning','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.elements.2.width','100'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fieldLayouts.e7d8c8cd-b91c-4fb3-862e-0d9782fecbc6.tabs.0.sortOrder','1'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.760aa4ac-bb5c-4db3-b72d-2883f1e62b94.contentColumnType','\"text\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.760aa4ac-bb5c-4db3-b72d-2883f1e62b94.fieldGroup','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.760aa4ac-bb5c-4db3-b72d-2883f1e62b94.handle','\"mrTable\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.760aa4ac-bb5c-4db3-b72d-2883f1e62b94.instructions','\"\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.760aa4ac-bb5c-4db3-b72d-2883f1e62b94.name','\"Mr Table\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.760aa4ac-bb5c-4db3-b72d-2883f1e62b94.searchable','true'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.760aa4ac-bb5c-4db3-b72d-2883f1e62b94.settings.columnsAddRowLabel','\"\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.760aa4ac-bb5c-4db3-b72d-2883f1e62b94.settings.columnsInstructions','\"\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.760aa4ac-bb5c-4db3-b72d-2883f1e62b94.settings.columnsLabel','\"\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.760aa4ac-bb5c-4db3-b72d-2883f1e62b94.settings.rowsAddRowLabel','\"\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.760aa4ac-bb5c-4db3-b72d-2883f1e62b94.settings.rowsInstructions','\"\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.760aa4ac-bb5c-4db3-b72d-2883f1e62b94.settings.rowsLabel','\"\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.760aa4ac-bb5c-4db3-b72d-2883f1e62b94.translationKeyFormat','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.760aa4ac-bb5c-4db3-b72d-2883f1e62b94.translationMethod','\"none\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.760aa4ac-bb5c-4db3-b72d-2883f1e62b94.type','\"supercool\\\\tablemaker\\\\fields\\\\TableMakerField\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.d21039a6-5a67-4877-8b49-1d312d245ed7.contentColumnType','\"text\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.d21039a6-5a67-4877-8b49-1d312d245ed7.fieldGroup','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.d21039a6-5a67-4877-8b49-1d312d245ed7.handle','\"customClass\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.d21039a6-5a67-4877-8b49-1d312d245ed7.instructions','\"Attach one or more classes to this element separated by spaces\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.d21039a6-5a67-4877-8b49-1d312d245ed7.name','\"Custom Class\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.d21039a6-5a67-4877-8b49-1d312d245ed7.searchable','true'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.d21039a6-5a67-4877-8b49-1d312d245ed7.settings.byteLimit','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.d21039a6-5a67-4877-8b49-1d312d245ed7.settings.charLimit','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.d21039a6-5a67-4877-8b49-1d312d245ed7.settings.code','\"\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.d21039a6-5a67-4877-8b49-1d312d245ed7.settings.columnType','\"text\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.d21039a6-5a67-4877-8b49-1d312d245ed7.settings.initialRows','\"4\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.d21039a6-5a67-4877-8b49-1d312d245ed7.settings.multiline','\"\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.d21039a6-5a67-4877-8b49-1d312d245ed7.settings.placeholder','\"class-1 class-2\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.d21039a6-5a67-4877-8b49-1d312d245ed7.settings.uiMode','\"normal\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.d21039a6-5a67-4877-8b49-1d312d245ed7.translationKeyFormat','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.d21039a6-5a67-4877-8b49-1d312d245ed7.translationMethod','\"none\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.d21039a6-5a67-4877-8b49-1d312d245ed7.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.contentColumnType','\"string\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.fieldGroup','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.handle','\"audience\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.instructions','\"\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.name','\"Audience\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.searchable','true'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.settings.allowLimit','false'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.settings.allowMultipleSources','false'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.settings.allowSelfRelations','false'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.settings.branchLimit','\"\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.settings.limit','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.settings.localizeRelations','false'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.settings.selectionLabel','\"\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.settings.showSiteMenu','true'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.settings.source','\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.settings.sources','\"*\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.settings.targetSiteId','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.settings.validateRelatedElements','false'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.settings.viewMode','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.translationKeyFormat','null'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.translationMethod','\"site\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.fields.e1119f5e-93e3-4ff3-97f9-cc6e7d8f1737.type','\"craft\\\\fields\\\\Categories\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.handle','\"responsiveTable\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.name','\"Responsive Table\"'),
	('matrixBlockTypes.32eb2020-0636-40c1-8e9d-4c1ceba0c3c6.sortOrder','8'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.field','\"093fa743-22d4-484c-a853-1101eac54810\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.0.fieldUid','\"240c52e2-5b2b-44b4-b84a-2d9d7e52a166\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.0.instructions','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.0.label','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.0.required','true'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.0.tip','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.0.warning','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.0.width','100'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.1.fieldUid','\"a9bd9689-f1e0-4829-b0e8-30c6f5421e78\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.1.instructions','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.1.label','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.1.required','true'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.1.tip','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.1.warning','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.1.width','100'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.2.fieldUid','\"a2cabb95-d2eb-42f4-aa19-feb397936e1b\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.2.instructions','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.2.label','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.2.required','false'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.2.tip','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.2.warning','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.elements.2.width','100'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fieldLayouts.b16a71f3-3d72-4a61-a074-efe92e3c96da.tabs.0.sortOrder','1'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.contentColumnType','\"string\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.fieldGroup','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.handle','\"audience\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.instructions','\"Choose who can see this\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.name','\"Audience\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.searchable','true'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.settings.allowLimit','false'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.settings.allowMultipleSources','false'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.settings.allowSelfRelations','false'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.settings.branchLimit','\"\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.settings.limit','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.settings.localizeRelations','false'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.settings.selectionLabel','\"\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.settings.showSiteMenu','true'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.settings.source','\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.settings.sources','\"*\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.settings.targetSiteId','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.settings.validateRelatedElements','false'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.settings.viewMode','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.translationKeyFormat','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.translationMethod','\"site\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.240c52e2-5b2b-44b4-b84a-2d9d7e52a166.type','\"craft\\\\fields\\\\Categories\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a2cabb95-d2eb-42f4-aa19-feb397936e1b.contentColumnType','\"text\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a2cabb95-d2eb-42f4-aa19-feb397936e1b.fieldGroup','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a2cabb95-d2eb-42f4-aa19-feb397936e1b.handle','\"customClass\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a2cabb95-d2eb-42f4-aa19-feb397936e1b.instructions','\"Attach one or more classes to this element separated by spaces\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a2cabb95-d2eb-42f4-aa19-feb397936e1b.name','\"Custom Class\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a2cabb95-d2eb-42f4-aa19-feb397936e1b.searchable','true'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a2cabb95-d2eb-42f4-aa19-feb397936e1b.settings.byteLimit','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a2cabb95-d2eb-42f4-aa19-feb397936e1b.settings.charLimit','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a2cabb95-d2eb-42f4-aa19-feb397936e1b.settings.code','\"\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a2cabb95-d2eb-42f4-aa19-feb397936e1b.settings.columnType','\"text\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a2cabb95-d2eb-42f4-aa19-feb397936e1b.settings.initialRows','\"4\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a2cabb95-d2eb-42f4-aa19-feb397936e1b.settings.multiline','\"\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a2cabb95-d2eb-42f4-aa19-feb397936e1b.settings.placeholder','\"class-1 class-2\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a2cabb95-d2eb-42f4-aa19-feb397936e1b.settings.uiMode','\"normal\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a2cabb95-d2eb-42f4-aa19-feb397936e1b.translationKeyFormat','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a2cabb95-d2eb-42f4-aa19-feb397936e1b.translationMethod','\"none\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a2cabb95-d2eb-42f4-aa19-feb397936e1b.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.contentColumnType','\"text\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.fieldGroup','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.handle','\"text\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.instructions','\"\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.name','\"Rich Text Field\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.searchable','true'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.settings.availableTransforms','\"*\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.settings.availableVolumes','\"*\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.settings.cleanupHtml','true'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.settings.columnType','\"text\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.settings.configSelectionMode','\"choose\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.settings.defaultTransform','\"\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.settings.manualConfig','\"\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.settings.purifierConfig','\"\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.settings.purifyHtml','\"1\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.settings.redactorConfig','\"\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.settings.removeEmptyTags','\"1\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.settings.removeInlineStyles','\"1\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.settings.removeNbsp','\"1\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.settings.showHtmlButtonForNonAdmins','\"\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.settings.showUnpermittedFiles','false'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.settings.showUnpermittedVolumes','true'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.settings.uiMode','\"enlarged\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.translationKeyFormat','null'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.translationMethod','\"none\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.fields.a9bd9689-f1e0-4829-b0e8-30c6f5421e78.type','\"craft\\\\redactor\\\\Field\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.handle','\"regularCopy\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.name','\"Regular Copy\"'),
	('matrixBlockTypes.335eb808-1466-42d9-b578-c010b4ec1ee2.sortOrder','3'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.field','\"093fa743-22d4-484c-a853-1101eac54810\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fieldLayouts.7f135f5d-7f7e-43c6-89c2-c9d314463bab.tabs.0.elements.0.fieldUid','\"e5c6aa84-2b70-442a-8644-f770bd175f5e\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fieldLayouts.7f135f5d-7f7e-43c6-89c2-c9d314463bab.tabs.0.elements.0.instructions','null'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fieldLayouts.7f135f5d-7f7e-43c6-89c2-c9d314463bab.tabs.0.elements.0.label','null'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fieldLayouts.7f135f5d-7f7e-43c6-89c2-c9d314463bab.tabs.0.elements.0.required','true'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fieldLayouts.7f135f5d-7f7e-43c6-89c2-c9d314463bab.tabs.0.elements.0.tip','null'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fieldLayouts.7f135f5d-7f7e-43c6-89c2-c9d314463bab.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fieldLayouts.7f135f5d-7f7e-43c6-89c2-c9d314463bab.tabs.0.elements.0.warning','null'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fieldLayouts.7f135f5d-7f7e-43c6-89c2-c9d314463bab.tabs.0.elements.0.width','100'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fieldLayouts.7f135f5d-7f7e-43c6-89c2-c9d314463bab.tabs.0.elements.1.fieldUid','\"1d688057-345a-422a-aa63-aa4a68a77b8e\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fieldLayouts.7f135f5d-7f7e-43c6-89c2-c9d314463bab.tabs.0.elements.1.instructions','null'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fieldLayouts.7f135f5d-7f7e-43c6-89c2-c9d314463bab.tabs.0.elements.1.label','null'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fieldLayouts.7f135f5d-7f7e-43c6-89c2-c9d314463bab.tabs.0.elements.1.required','true'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fieldLayouts.7f135f5d-7f7e-43c6-89c2-c9d314463bab.tabs.0.elements.1.tip','null'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fieldLayouts.7f135f5d-7f7e-43c6-89c2-c9d314463bab.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fieldLayouts.7f135f5d-7f7e-43c6-89c2-c9d314463bab.tabs.0.elements.1.warning','null'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fieldLayouts.7f135f5d-7f7e-43c6-89c2-c9d314463bab.tabs.0.elements.1.width','100'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fieldLayouts.7f135f5d-7f7e-43c6-89c2-c9d314463bab.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fieldLayouts.7f135f5d-7f7e-43c6-89c2-c9d314463bab.tabs.0.sortOrder','1'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.1d688057-345a-422a-aa63-aa4a68a77b8e.contentColumnType','\"text\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.1d688057-345a-422a-aa63-aa4a68a77b8e.fieldGroup','null'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.1d688057-345a-422a-aa63-aa4a68a77b8e.handle','\"columnClass\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.1d688057-345a-422a-aa63-aa4a68a77b8e.instructions','\"Input a class or string of classes in Bootstrap 12-grid syntax to define this column\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.1d688057-345a-422a-aa63-aa4a68a77b8e.name','\"Column Class\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.1d688057-345a-422a-aa63-aa4a68a77b8e.searchable','true'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.1d688057-345a-422a-aa63-aa4a68a77b8e.settings.byteLimit','null'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.1d688057-345a-422a-aa63-aa4a68a77b8e.settings.charLimit','null'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.1d688057-345a-422a-aa63-aa4a68a77b8e.settings.code','\"\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.1d688057-345a-422a-aa63-aa4a68a77b8e.settings.columnType','\"text\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.1d688057-345a-422a-aa63-aa4a68a77b8e.settings.initialRows','\"4\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.1d688057-345a-422a-aa63-aa4a68a77b8e.settings.multiline','\"\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.1d688057-345a-422a-aa63-aa4a68a77b8e.settings.placeholder','\".col-md-6 .col-lg-4\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.1d688057-345a-422a-aa63-aa4a68a77b8e.settings.uiMode','\"normal\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.1d688057-345a-422a-aa63-aa4a68a77b8e.translationKeyFormat','null'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.1d688057-345a-422a-aa63-aa4a68a77b8e.translationMethod','\"none\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.1d688057-345a-422a-aa63-aa4a68a77b8e.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.contentColumnType','\"string\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.fieldGroup','null'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.handle','\"audience\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.instructions','\"\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.name','\"Audience\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.searchable','true'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.settings.allowLimit','false'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.settings.allowMultipleSources','false'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.settings.allowSelfRelations','false'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.settings.branchLimit','\"\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.settings.limit','null'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.settings.localizeRelations','false'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.settings.selectionLabel','\"\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.settings.showSiteMenu','true'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.settings.source','\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.settings.sources','\"*\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.settings.targetSiteId','null'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.settings.validateRelatedElements','false'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.settings.viewMode','null'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.translationKeyFormat','null'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.translationMethod','\"site\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.fields.e5c6aa84-2b70-442a-8644-f770bd175f5e.type','\"craft\\\\fields\\\\Categories\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.handle','\"column\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.name','\"Column\"'),
	('matrixBlockTypes.3fd02122-a67c-49b4-be89-00987f3f47ef.sortOrder','1'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.field','\"093fa743-22d4-484c-a853-1101eac54810\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.0.fieldUid','\"bdd9b8ca-edbb-4746-bb26-3956af7cfcc3\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.0.instructions','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.0.label','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.0.required','true'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.0.tip','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.0.warning','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.0.width','100'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.1.fieldUid','\"c587c76f-f9ae-48fd-afa5-954f3caf67ed\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.1.instructions','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.1.label','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.1.required','true'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.1.tip','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.1.warning','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.1.width','100'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.2.fieldUid','\"8a5f2409-1498-42af-949f-7dfa9ca4d51b\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.2.instructions','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.2.label','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.2.required','false'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.2.tip','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.2.warning','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.elements.2.width','100'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fieldLayouts.3bc7e98f-c970-40d1-b342-a1b1e130a8c6.tabs.0.sortOrder','1'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.8a5f2409-1498-42af-949f-7dfa9ca4d51b.contentColumnType','\"text\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.8a5f2409-1498-42af-949f-7dfa9ca4d51b.fieldGroup','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.8a5f2409-1498-42af-949f-7dfa9ca4d51b.handle','\"customClass\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.8a5f2409-1498-42af-949f-7dfa9ca4d51b.instructions','\"Attach one or more classes to this element separated by spaces\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.8a5f2409-1498-42af-949f-7dfa9ca4d51b.name','\"Custom Class\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.8a5f2409-1498-42af-949f-7dfa9ca4d51b.searchable','true'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.8a5f2409-1498-42af-949f-7dfa9ca4d51b.settings.byteLimit','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.8a5f2409-1498-42af-949f-7dfa9ca4d51b.settings.charLimit','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.8a5f2409-1498-42af-949f-7dfa9ca4d51b.settings.code','\"\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.8a5f2409-1498-42af-949f-7dfa9ca4d51b.settings.columnType','\"text\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.8a5f2409-1498-42af-949f-7dfa9ca4d51b.settings.initialRows','\"4\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.8a5f2409-1498-42af-949f-7dfa9ca4d51b.settings.multiline','\"\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.8a5f2409-1498-42af-949f-7dfa9ca4d51b.settings.placeholder','\"class-1 class-2\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.8a5f2409-1498-42af-949f-7dfa9ca4d51b.settings.uiMode','\"normal\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.8a5f2409-1498-42af-949f-7dfa9ca4d51b.translationKeyFormat','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.8a5f2409-1498-42af-949f-7dfa9ca4d51b.translationMethod','\"none\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.8a5f2409-1498-42af-949f-7dfa9ca4d51b.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.contentColumnType','\"string\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.fieldGroup','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.handle','\"audience\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.instructions','\"\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.name','\"Audience\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.searchable','true'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.settings.allowLimit','false'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.settings.allowMultipleSources','false'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.settings.allowSelfRelations','false'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.settings.branchLimit','\"\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.settings.limit','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.settings.localizeRelations','false'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.settings.selectionLabel','\"\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.settings.showSiteMenu','true'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.settings.source','\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.settings.sources','\"*\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.settings.targetSiteId','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.settings.validateRelatedElements','false'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.settings.viewMode','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.translationKeyFormat','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.translationMethod','\"site\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.bdd9b8ca-edbb-4746-bb26-3956af7cfcc3.type','\"craft\\\\fields\\\\Categories\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.c587c76f-f9ae-48fd-afa5-954f3caf67ed.contentColumnType','\"text\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.c587c76f-f9ae-48fd-afa5-954f3caf67ed.fieldGroup','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.c587c76f-f9ae-48fd-afa5-954f3caf67ed.handle','\"tableData\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.c587c76f-f9ae-48fd-afa5-954f3caf67ed.instructions','\"Enter your table data; you can use \\\"null\\\" to merge with the preceding cell, or \\\"blank\\\" to leave a cutout where a cell would be.\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.c587c76f-f9ae-48fd-afa5-954f3caf67ed.name','\"Table Data\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.c587c76f-f9ae-48fd-afa5-954f3caf67ed.searchable','true'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.c587c76f-f9ae-48fd-afa5-954f3caf67ed.settings.columnsAddRowLabel','\"\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.c587c76f-f9ae-48fd-afa5-954f3caf67ed.settings.columnsInstructions','\"\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.c587c76f-f9ae-48fd-afa5-954f3caf67ed.settings.columnsLabel','\"\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.c587c76f-f9ae-48fd-afa5-954f3caf67ed.settings.rowsAddRowLabel','\"\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.c587c76f-f9ae-48fd-afa5-954f3caf67ed.settings.rowsInstructions','\"\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.c587c76f-f9ae-48fd-afa5-954f3caf67ed.settings.rowsLabel','\"\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.c587c76f-f9ae-48fd-afa5-954f3caf67ed.translationKeyFormat','null'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.c587c76f-f9ae-48fd-afa5-954f3caf67ed.translationMethod','\"none\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.fields.c587c76f-f9ae-48fd-afa5-954f3caf67ed.type','\"supercool\\\\tablemaker\\\\fields\\\\TableMakerField\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.handle','\"table\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.name','\"Table\"'),
	('matrixBlockTypes.6658b45c-1dc5-4548-a40c-b31cf3270af7.sortOrder','7'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.field','\"093fa743-22d4-484c-a853-1101eac54810\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.0.fieldUid','\"beae91d9-6a66-4564-ad98-479dc01a8fa6\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.0.instructions','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.0.label','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.0.required','true'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.0.tip','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.0.warning','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.0.width','100'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.1.fieldUid','\"6f138b56-70c1-4f14-86c1-ce4dba2419a7\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.1.instructions','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.1.label','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.1.required','false'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.1.tip','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.1.warning','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.1.width','100'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.2.fieldUid','\"0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.2.instructions','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.2.label','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.2.required','true'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.2.tip','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.2.warning','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.elements.2.width','100'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fieldLayouts.367369ee-9647-438b-bf8b-ff4b3699b9c3.tabs.0.sortOrder','1'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.contentColumnType','\"string\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.fieldGroup','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.handle','\"expanderAttributes\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.instructions','\"\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.name','\"Expander Attributes\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.searchable','true'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.multi','true'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.optgroups','true'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.options.0.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.options.0.__assoc__.0.1','\"Closes others\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.options.0.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.options.0.__assoc__.1.1','\"closesOthers\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.options.0.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.options.0.__assoc__.2.1','\"1\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.options.1.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.options.1.__assoc__.0.1','\"Defaults open\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.options.1.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.options.1.__assoc__.1.1','\"defaultsOpen\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.options.1.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.options.1.__assoc__.2.1','\"\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.options.2.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.options.2.__assoc__.0.1','\"Is endcap\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.options.2.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.options.2.__assoc__.1.1','\"isEndcap\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.options.2.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.settings.options.2.__assoc__.2.1','\"\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.translationKeyFormat','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.translationMethod','\"none\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.0377bb6b-a3eb-471e-81d9-6e2ae2d6edb5.type','\"craft\\\\fields\\\\MultiSelect\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.6f138b56-70c1-4f14-86c1-ce4dba2419a7.contentColumnType','\"text\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.6f138b56-70c1-4f14-86c1-ce4dba2419a7.fieldGroup','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.6f138b56-70c1-4f14-86c1-ce4dba2419a7.handle','\"expanderHeading\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.6f138b56-70c1-4f14-86c1-ce4dba2419a7.instructions','\"Heading for the expander\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.6f138b56-70c1-4f14-86c1-ce4dba2419a7.name','\"Expander heading\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.6f138b56-70c1-4f14-86c1-ce4dba2419a7.searchable','true'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.6f138b56-70c1-4f14-86c1-ce4dba2419a7.settings.byteLimit','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.6f138b56-70c1-4f14-86c1-ce4dba2419a7.settings.charLimit','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.6f138b56-70c1-4f14-86c1-ce4dba2419a7.settings.code','\"\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.6f138b56-70c1-4f14-86c1-ce4dba2419a7.settings.columnType','\"text\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.6f138b56-70c1-4f14-86c1-ce4dba2419a7.settings.initialRows','\"4\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.6f138b56-70c1-4f14-86c1-ce4dba2419a7.settings.multiline','\"\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.6f138b56-70c1-4f14-86c1-ce4dba2419a7.settings.placeholder','\"\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.6f138b56-70c1-4f14-86c1-ce4dba2419a7.settings.uiMode','\"normal\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.6f138b56-70c1-4f14-86c1-ce4dba2419a7.translationKeyFormat','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.6f138b56-70c1-4f14-86c1-ce4dba2419a7.translationMethod','\"none\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.6f138b56-70c1-4f14-86c1-ce4dba2419a7.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.contentColumnType','\"string\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.fieldGroup','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.handle','\"audience\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.instructions','\"Choose who can see this\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.name','\"Audience\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.searchable','true'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.settings.allowLimit','false'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.settings.allowMultipleSources','false'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.settings.allowSelfRelations','false'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.settings.branchLimit','\"\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.settings.limit','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.settings.localizeRelations','false'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.settings.selectionLabel','\"\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.settings.showSiteMenu','true'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.settings.source','\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.settings.sources','\"*\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.settings.targetSiteId','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.settings.validateRelatedElements','false'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.settings.viewMode','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.translationKeyFormat','null'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.translationMethod','\"site\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.fields.beae91d9-6a66-4564-ad98-479dc01a8fa6.type','\"craft\\\\fields\\\\Categories\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.handle','\"expander\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.name','\"Expander\"'),
	('matrixBlockTypes.895fd754-94d9-420d-b450-cd9e841217cf.sortOrder','2'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.field','\"093fa743-22d4-484c-a853-1101eac54810\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.0.fieldUid','\"eedde671-8654-49cd-a5cf-f8c3e085622b\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.0.instructions','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.0.label','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.0.required','true'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.0.tip','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.0.warning','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.0.width','100'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.1.fieldUid','\"2c5024eb-d84d-48e9-b563-5fe3f04e492a\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.1.instructions','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.1.label','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.1.required','true'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.1.tip','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.1.warning','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.1.width','100'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.2.fieldUid','\"5f112cb5-ed35-4598-9eb1-91cf4dc530f9\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.2.instructions','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.2.label','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.2.required','true'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.2.tip','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.2.warning','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.2.width','100'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.3.fieldUid','\"b0b0e35d-5244-4c94-9703-16fdb54cdfb2\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.3.instructions','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.3.label','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.3.required','false'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.3.tip','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.3.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.3.warning','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.elements.3.width','100'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fieldLayouts.37e09d75-1883-4ad9-95cc-f19b4c4df308.tabs.0.sortOrder','1'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.2c5024eb-d84d-48e9-b563-5fe3f04e492a.contentColumnType','\"text\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.2c5024eb-d84d-48e9-b563-5fe3f04e492a.fieldGroup','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.2c5024eb-d84d-48e9-b563-5fe3f04e492a.handle','\"headingText\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.2c5024eb-d84d-48e9-b563-5fe3f04e492a.instructions','\"\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.2c5024eb-d84d-48e9-b563-5fe3f04e492a.name','\"Heading Text\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.2c5024eb-d84d-48e9-b563-5fe3f04e492a.searchable','true'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.2c5024eb-d84d-48e9-b563-5fe3f04e492a.settings.byteLimit','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.2c5024eb-d84d-48e9-b563-5fe3f04e492a.settings.charLimit','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.2c5024eb-d84d-48e9-b563-5fe3f04e492a.settings.code','\"\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.2c5024eb-d84d-48e9-b563-5fe3f04e492a.settings.columnType','\"text\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.2c5024eb-d84d-48e9-b563-5fe3f04e492a.settings.initialRows','\"4\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.2c5024eb-d84d-48e9-b563-5fe3f04e492a.settings.multiline','\"\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.2c5024eb-d84d-48e9-b563-5fe3f04e492a.settings.placeholder','\"\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.2c5024eb-d84d-48e9-b563-5fe3f04e492a.settings.uiMode','\"normal\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.2c5024eb-d84d-48e9-b563-5fe3f04e492a.translationKeyFormat','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.2c5024eb-d84d-48e9-b563-5fe3f04e492a.translationMethod','\"none\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.2c5024eb-d84d-48e9-b563-5fe3f04e492a.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.contentColumnType','\"string\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.fieldGroup','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.handle','\"headingLevel\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.instructions','\"Choose a level from 2-6 (the page title is Heading Level 1). Sections and sub sections should be nested, e.g., Level 3s will be considered subsections of the previous Level 2.\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.name','\"Heading Level\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.searchable','true'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.optgroups','true'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.0.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.0.__assoc__.0.1','\"Level 2\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.0.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.0.__assoc__.1.1','\"h2\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.0.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.0.__assoc__.2.1','\"1\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.1.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.1.__assoc__.0.1','\"Level 3\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.1.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.1.__assoc__.1.1','\"h3\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.1.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.1.__assoc__.2.1','\"\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.2.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.2.__assoc__.0.1','\"Level 4\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.2.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.2.__assoc__.1.1','\"h4\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.2.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.2.__assoc__.2.1','\"\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.3.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.3.__assoc__.0.1','\"Level 5\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.3.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.3.__assoc__.1.1','\"h5\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.3.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.3.__assoc__.2.1','\"\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.4.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.4.__assoc__.0.1','\"Level 6\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.4.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.4.__assoc__.1.1','\"h6\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.4.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.settings.options.4.__assoc__.2.1','\"\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.translationKeyFormat','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.translationMethod','\"none\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.5f112cb5-ed35-4598-9eb1-91cf4dc530f9.type','\"craft\\\\fields\\\\Dropdown\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.b0b0e35d-5244-4c94-9703-16fdb54cdfb2.contentColumnType','\"text\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.b0b0e35d-5244-4c94-9703-16fdb54cdfb2.fieldGroup','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.b0b0e35d-5244-4c94-9703-16fdb54cdfb2.handle','\"customClass\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.b0b0e35d-5244-4c94-9703-16fdb54cdfb2.instructions','\"Attach one or more classes to this element separated by spaces\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.b0b0e35d-5244-4c94-9703-16fdb54cdfb2.name','\"Custom Class\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.b0b0e35d-5244-4c94-9703-16fdb54cdfb2.searchable','true'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.b0b0e35d-5244-4c94-9703-16fdb54cdfb2.settings.byteLimit','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.b0b0e35d-5244-4c94-9703-16fdb54cdfb2.settings.charLimit','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.b0b0e35d-5244-4c94-9703-16fdb54cdfb2.settings.code','\"\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.b0b0e35d-5244-4c94-9703-16fdb54cdfb2.settings.columnType','\"text\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.b0b0e35d-5244-4c94-9703-16fdb54cdfb2.settings.initialRows','\"4\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.b0b0e35d-5244-4c94-9703-16fdb54cdfb2.settings.multiline','\"\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.b0b0e35d-5244-4c94-9703-16fdb54cdfb2.settings.placeholder','\"class-1 class-2\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.b0b0e35d-5244-4c94-9703-16fdb54cdfb2.settings.uiMode','\"normal\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.b0b0e35d-5244-4c94-9703-16fdb54cdfb2.translationKeyFormat','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.b0b0e35d-5244-4c94-9703-16fdb54cdfb2.translationMethod','\"none\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.b0b0e35d-5244-4c94-9703-16fdb54cdfb2.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.contentColumnType','\"string\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.fieldGroup','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.handle','\"audience\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.instructions','\"Choose who can see this\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.name','\"Audience\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.searchable','true'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.settings.allowLimit','false'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.settings.allowMultipleSources','false'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.settings.allowSelfRelations','false'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.settings.branchLimit','\"\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.settings.limit','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.settings.localizeRelations','false'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.settings.selectionLabel','\"\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.settings.showSiteMenu','true'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.settings.source','\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.settings.sources','\"*\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.settings.targetSiteId','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.settings.validateRelatedElements','false'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.settings.viewMode','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.translationKeyFormat','null'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.translationMethod','\"site\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.fields.eedde671-8654-49cd-a5cf-f8c3e085622b.type','\"craft\\\\fields\\\\Categories\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.handle','\"sectionHeading\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.name','\"Section Heading\"'),
	('matrixBlockTypes.8bf2bae8-96e9-4da1-a5be-17f5b24a90a7.sortOrder','4'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.field','\"093fa743-22d4-484c-a853-1101eac54810\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.0.fieldUid','\"beeb828c-dc5e-4e47-8c97-0f135bb9a04b\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.0.instructions','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.0.label','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.0.required','true'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.0.tip','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.0.warning','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.0.width','100'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.1.fieldUid','\"2e5c26cd-0323-4b2b-8396-94ac2fea5242\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.1.instructions','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.1.label','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.1.required','true'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.1.tip','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.1.warning','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.1.width','100'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.2.fieldUid','\"b796b2ec-27c8-4abe-8aad-b9e0f9b37604\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.2.instructions','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.2.label','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.2.required','true'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.2.tip','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.2.warning','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.2.width','100'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.3.fieldUid','\"7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.3.instructions','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.3.label','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.3.required','false'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.3.tip','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.3.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.3.warning','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.3.width','100'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.4.fieldUid','\"fb6a0de8-332a-4630-b076-0f5d456ba62e\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.4.instructions','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.4.label','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.4.required','false'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.4.tip','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.4.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.4.warning','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.elements.4.width','100'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fieldLayouts.5c7ad637-6ad9-4478-b25a-57ad6546036f.tabs.0.sortOrder','1'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.contentColumnType','\"string\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.fieldGroup','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.handle','\"image\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.instructions','\"\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.name','\"Image\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.searchable','true'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.allowedKinds.0','\"image\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.allowSelfRelations','false'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.defaultUploadLocationSource','\"volume:3b244919-9ddb-4ed8-b47d-f3e626e7c0fa\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.defaultUploadLocationSubpath','\"\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.limit','\"1\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.localizeRelations','false'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.restrictFiles','\"1\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.selectionLabel','\"\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.showSiteMenu','true'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.showUnpermittedFiles','false'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.showUnpermittedVolumes','true'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.singleUploadLocationSource','\"volume:3b244919-9ddb-4ed8-b47d-f3e626e7c0fa\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.singleUploadLocationSubpath','\"\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.source','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.sources','\"*\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.targetSiteId','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.useSingleFolder','false'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.validateRelatedElements','false'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.settings.viewMode','\"large\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.translationKeyFormat','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.translationMethod','\"site\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.2e5c26cd-0323-4b2b-8396-94ac2fea5242.type','\"craft\\\\fields\\\\Assets\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85.contentColumnType','\"text\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85.fieldGroup','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85.handle','\"caption\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85.instructions','\"Show a caption under the image. Leave blank if not required.\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85.name','\"Caption\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85.searchable','true'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85.settings.byteLimit','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85.settings.charLimit','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85.settings.code','\"\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85.settings.columnType','\"text\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85.settings.initialRows','\"4\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85.settings.multiline','\"\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85.settings.placeholder','\"\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85.settings.uiMode','\"normal\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85.translationKeyFormat','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85.translationMethod','\"none\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.7f9c6a7c-ffc9-4060-8bd0-ad34dcff7e85.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.b796b2ec-27c8-4abe-8aad-b9e0f9b37604.contentColumnType','\"text\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.b796b2ec-27c8-4abe-8aad-b9e0f9b37604.fieldGroup','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.b796b2ec-27c8-4abe-8aad-b9e0f9b37604.handle','\"altTag\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.b796b2ec-27c8-4abe-8aad-b9e0f9b37604.instructions','\"A short description of what\'s in the image for visually impaired members.\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.b796b2ec-27c8-4abe-8aad-b9e0f9b37604.name','\"Description\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.b796b2ec-27c8-4abe-8aad-b9e0f9b37604.searchable','true'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.b796b2ec-27c8-4abe-8aad-b9e0f9b37604.settings.byteLimit','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.b796b2ec-27c8-4abe-8aad-b9e0f9b37604.settings.charLimit','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.b796b2ec-27c8-4abe-8aad-b9e0f9b37604.settings.code','\"\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.b796b2ec-27c8-4abe-8aad-b9e0f9b37604.settings.columnType','\"text\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.b796b2ec-27c8-4abe-8aad-b9e0f9b37604.settings.initialRows','\"4\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.b796b2ec-27c8-4abe-8aad-b9e0f9b37604.settings.multiline','\"\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.b796b2ec-27c8-4abe-8aad-b9e0f9b37604.settings.placeholder','\"\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.b796b2ec-27c8-4abe-8aad-b9e0f9b37604.settings.uiMode','\"normal\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.b796b2ec-27c8-4abe-8aad-b9e0f9b37604.translationKeyFormat','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.b796b2ec-27c8-4abe-8aad-b9e0f9b37604.translationMethod','\"none\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.b796b2ec-27c8-4abe-8aad-b9e0f9b37604.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.contentColumnType','\"string\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.fieldGroup','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.handle','\"audience\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.instructions','\"Choose who can see this\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.name','\"Audience\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.searchable','true'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.settings.allowLimit','false'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.settings.allowMultipleSources','false'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.settings.allowSelfRelations','false'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.settings.branchLimit','\"\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.settings.limit','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.settings.localizeRelations','false'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.settings.selectionLabel','\"\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.settings.showSiteMenu','true'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.settings.source','\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.settings.sources','\"*\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.settings.targetSiteId','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.settings.validateRelatedElements','false'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.settings.viewMode','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.translationKeyFormat','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.translationMethod','\"site\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.beeb828c-dc5e-4e47-8c97-0f135bb9a04b.type','\"craft\\\\fields\\\\Categories\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.fb6a0de8-332a-4630-b076-0f5d456ba62e.contentColumnType','\"text\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.fb6a0de8-332a-4630-b076-0f5d456ba62e.fieldGroup','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.fb6a0de8-332a-4630-b076-0f5d456ba62e.handle','\"customClass\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.fb6a0de8-332a-4630-b076-0f5d456ba62e.instructions','\"Attach one or more classes to this element separated by spaces\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.fb6a0de8-332a-4630-b076-0f5d456ba62e.name','\"Custom Class\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.fb6a0de8-332a-4630-b076-0f5d456ba62e.searchable','true'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.fb6a0de8-332a-4630-b076-0f5d456ba62e.settings.byteLimit','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.fb6a0de8-332a-4630-b076-0f5d456ba62e.settings.charLimit','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.fb6a0de8-332a-4630-b076-0f5d456ba62e.settings.code','\"\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.fb6a0de8-332a-4630-b076-0f5d456ba62e.settings.columnType','\"text\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.fb6a0de8-332a-4630-b076-0f5d456ba62e.settings.initialRows','\"4\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.fb6a0de8-332a-4630-b076-0f5d456ba62e.settings.multiline','\"\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.fb6a0de8-332a-4630-b076-0f5d456ba62e.settings.placeholder','\"class-1 class-2\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.fb6a0de8-332a-4630-b076-0f5d456ba62e.settings.uiMode','\"normal\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.fb6a0de8-332a-4630-b076-0f5d456ba62e.translationKeyFormat','null'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.fb6a0de8-332a-4630-b076-0f5d456ba62e.translationMethod','\"none\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.fields.fb6a0de8-332a-4630-b076-0f5d456ba62e.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.handle','\"regularImage\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.name','\"Regular Image\"'),
	('matrixBlockTypes.8edc53d1-4c5f-43e9-abf3-8f33dd538f78.sortOrder','5'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.field','\"093fa743-22d4-484c-a853-1101eac54810\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.0.fieldUid','\"c6923d93-967e-4eca-9896-4fc4b0aef49b\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.0.instructions','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.0.label','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.0.required','true'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.0.tip','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.0.warning','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.0.width','100'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.1.fieldUid','\"88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.1.instructions','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.1.label','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.1.required','false'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.1.tip','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.1.warning','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.1.width','100'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.2.fieldUid','\"32edc157-ef3f-482a-bb47-35a197e45492\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.2.instructions','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.2.label','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.2.required','false'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.2.tip','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.2.warning','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.2.width','100'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.3.fieldUid','\"6c7223b2-62a4-48a7-8b05-b43b380f5a56\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.3.instructions','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.3.label','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.3.required','false'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.3.tip','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.3.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.3.warning','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.3.width','100'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.4.fieldUid','\"b2dd979f-9ed1-424d-badc-8878aaa2eeeb\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.4.instructions','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.4.label','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.4.required','false'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.4.tip','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.4.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.4.warning','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.4.width','100'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.5.fieldUid','\"2a9d8e6a-029f-4644-9150-0b1e27e5ff69\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.5.instructions','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.5.label','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.5.required','false'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.5.tip','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.5.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.5.warning','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.elements.5.width','100'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fieldLayouts.bc2d5f4a-eabf-4945-9c59-7795e76095c8.tabs.0.sortOrder','1'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.2a9d8e6a-029f-4644-9150-0b1e27e5ff69.contentColumnType','\"text\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.2a9d8e6a-029f-4644-9150-0b1e27e5ff69.fieldGroup','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.2a9d8e6a-029f-4644-9150-0b1e27e5ff69.handle','\"customClass\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.2a9d8e6a-029f-4644-9150-0b1e27e5ff69.instructions','\"Attach one or more classes to this element separated by spaces\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.2a9d8e6a-029f-4644-9150-0b1e27e5ff69.name','\"Custom Class\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.2a9d8e6a-029f-4644-9150-0b1e27e5ff69.searchable','true'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.2a9d8e6a-029f-4644-9150-0b1e27e5ff69.settings.byteLimit','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.2a9d8e6a-029f-4644-9150-0b1e27e5ff69.settings.charLimit','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.2a9d8e6a-029f-4644-9150-0b1e27e5ff69.settings.code','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.2a9d8e6a-029f-4644-9150-0b1e27e5ff69.settings.columnType','\"text\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.2a9d8e6a-029f-4644-9150-0b1e27e5ff69.settings.initialRows','\"4\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.2a9d8e6a-029f-4644-9150-0b1e27e5ff69.settings.multiline','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.2a9d8e6a-029f-4644-9150-0b1e27e5ff69.settings.placeholder','\"class-1 class-2\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.2a9d8e6a-029f-4644-9150-0b1e27e5ff69.settings.uiMode','\"normal\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.2a9d8e6a-029f-4644-9150-0b1e27e5ff69.translationKeyFormat','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.2a9d8e6a-029f-4644-9150-0b1e27e5ff69.translationMethod','\"none\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.2a9d8e6a-029f-4644-9150-0b1e27e5ff69.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.32edc157-ef3f-482a-bb47-35a197e45492.contentColumnType','\"text\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.32edc157-ef3f-482a-bb47-35a197e45492.fieldGroup','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.32edc157-ef3f-482a-bb47-35a197e45492.handle','\"postalAddress\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.32edc157-ef3f-482a-bb47-35a197e45492.instructions','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.32edc157-ef3f-482a-bb47-35a197e45492.name','\"Postal Address\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.32edc157-ef3f-482a-bb47-35a197e45492.searchable','true'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.32edc157-ef3f-482a-bb47-35a197e45492.settings.byteLimit','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.32edc157-ef3f-482a-bb47-35a197e45492.settings.charLimit','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.32edc157-ef3f-482a-bb47-35a197e45492.settings.code','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.32edc157-ef3f-482a-bb47-35a197e45492.settings.columnType','\"text\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.32edc157-ef3f-482a-bb47-35a197e45492.settings.initialRows','\"5\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.32edc157-ef3f-482a-bb47-35a197e45492.settings.multiline','\"1\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.32edc157-ef3f-482a-bb47-35a197e45492.settings.placeholder','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.32edc157-ef3f-482a-bb47-35a197e45492.settings.uiMode','\"normal\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.32edc157-ef3f-482a-bb47-35a197e45492.translationKeyFormat','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.32edc157-ef3f-482a-bb47-35a197e45492.translationMethod','\"none\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.32edc157-ef3f-482a-bb47-35a197e45492.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.6c7223b2-62a4-48a7-8b05-b43b380f5a56.contentColumnType','\"text\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.6c7223b2-62a4-48a7-8b05-b43b380f5a56.fieldGroup','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.6c7223b2-62a4-48a7-8b05-b43b380f5a56.handle','\"telephone\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.6c7223b2-62a4-48a7-8b05-b43b380f5a56.instructions','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.6c7223b2-62a4-48a7-8b05-b43b380f5a56.name','\"Telephone\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.6c7223b2-62a4-48a7-8b05-b43b380f5a56.searchable','true'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.6c7223b2-62a4-48a7-8b05-b43b380f5a56.settings.byteLimit','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.6c7223b2-62a4-48a7-8b05-b43b380f5a56.settings.charLimit','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.6c7223b2-62a4-48a7-8b05-b43b380f5a56.settings.code','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.6c7223b2-62a4-48a7-8b05-b43b380f5a56.settings.columnType','\"text\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.6c7223b2-62a4-48a7-8b05-b43b380f5a56.settings.initialRows','\"4\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.6c7223b2-62a4-48a7-8b05-b43b380f5a56.settings.multiline','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.6c7223b2-62a4-48a7-8b05-b43b380f5a56.settings.placeholder','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.6c7223b2-62a4-48a7-8b05-b43b380f5a56.settings.uiMode','\"normal\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.6c7223b2-62a4-48a7-8b05-b43b380f5a56.translationKeyFormat','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.6c7223b2-62a4-48a7-8b05-b43b380f5a56.translationMethod','\"none\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.6c7223b2-62a4-48a7-8b05-b43b380f5a56.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b.contentColumnType','\"text\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b.fieldGroup','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b.handle','\"email\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b.instructions','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b.name','\"Email\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b.searchable','true'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b.settings.byteLimit','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b.settings.charLimit','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b.settings.code','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b.settings.columnType','\"text\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b.settings.initialRows','\"4\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b.settings.multiline','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b.settings.placeholder','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b.settings.uiMode','\"normal\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b.translationKeyFormat','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b.translationMethod','\"none\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.88b7b7eb-99a3-4b0d-8761-eb7f1a6e895b.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.b2dd979f-9ed1-424d-badc-8878aaa2eeeb.contentColumnType','\"text\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.b2dd979f-9ed1-424d-badc-8878aaa2eeeb.fieldGroup','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.b2dd979f-9ed1-424d-badc-8878aaa2eeeb.handle','\"website\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.b2dd979f-9ed1-424d-badc-8878aaa2eeeb.instructions','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.b2dd979f-9ed1-424d-badc-8878aaa2eeeb.name','\"Website\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.b2dd979f-9ed1-424d-badc-8878aaa2eeeb.searchable','true'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.b2dd979f-9ed1-424d-badc-8878aaa2eeeb.settings.byteLimit','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.b2dd979f-9ed1-424d-badc-8878aaa2eeeb.settings.charLimit','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.b2dd979f-9ed1-424d-badc-8878aaa2eeeb.settings.code','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.b2dd979f-9ed1-424d-badc-8878aaa2eeeb.settings.columnType','\"text\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.b2dd979f-9ed1-424d-badc-8878aaa2eeeb.settings.initialRows','\"4\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.b2dd979f-9ed1-424d-badc-8878aaa2eeeb.settings.multiline','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.b2dd979f-9ed1-424d-badc-8878aaa2eeeb.settings.placeholder','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.b2dd979f-9ed1-424d-badc-8878aaa2eeeb.settings.uiMode','\"normal\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.b2dd979f-9ed1-424d-badc-8878aaa2eeeb.translationKeyFormat','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.b2dd979f-9ed1-424d-badc-8878aaa2eeeb.translationMethod','\"none\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.b2dd979f-9ed1-424d-badc-8878aaa2eeeb.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.contentColumnType','\"string\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.fieldGroup','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.handle','\"audience\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.instructions','\"Choose who can see this\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.name','\"Audience\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.searchable','true'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.settings.allowLimit','false'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.settings.allowMultipleSources','false'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.settings.allowSelfRelations','false'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.settings.branchLimit','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.settings.limit','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.settings.localizeRelations','false'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.settings.selectionLabel','\"\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.settings.showSiteMenu','true'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.settings.source','\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.settings.sources','\"*\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.settings.targetSiteId','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.settings.validateRelatedElements','false'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.settings.viewMode','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.translationKeyFormat','null'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.translationMethod','\"site\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.fields.c6923d93-967e-4eca-9896-4fc4b0aef49b.type','\"craft\\\\fields\\\\Categories\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.handle','\"address\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.name','\"Address\"'),
	('matrixBlockTypes.c0cedc50-ca5f-42ed-963f-381bf873d16c.sortOrder','6'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.field','\"093fa743-22d4-484c-a853-1101eac54810\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.0.fieldUid','\"be63b0dc-b343-42c6-b6e5-4632786f15e1\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.0.instructions','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.0.label','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.0.required','true'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.0.tip','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.0.warning','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.0.width','100'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.1.fieldUid','\"f648a86b-dc9f-42cd-bf78-9849c5f82edc\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.1.instructions','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.1.label','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.1.required','true'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.1.tip','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.1.warning','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.1.width','100'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.2.fieldUid','\"3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.2.instructions','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.2.label','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.2.required','false'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.2.tip','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.2.warning','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.elements.2.width','100'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fieldLayouts.f06db91c-fcf3-4bbe-bc18-932cf833e843.tabs.0.sortOrder','1'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a.contentColumnType','\"text\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a.fieldGroup','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a.handle','\"customClass\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a.instructions','\"Attach one or more classes to this element separated by spaces\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a.name','\"Custom Class\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a.searchable','true'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a.settings.byteLimit','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a.settings.charLimit','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a.settings.code','\"\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a.settings.columnType','\"text\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a.settings.initialRows','\"4\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a.settings.multiline','\"\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a.settings.placeholder','\"class-1 class-2\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a.settings.uiMode','\"normal\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a.translationKeyFormat','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a.translationMethod','\"none\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.3c8cf0ad-b4d3-43fc-a891-5738d2b28b8a.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.contentColumnType','\"string\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.fieldGroup','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.handle','\"audience\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.instructions','\"\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.name','\"Audience\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.searchable','true'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.settings.allowLimit','false'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.settings.allowMultipleSources','false'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.settings.allowSelfRelations','false'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.settings.branchLimit','\"\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.settings.limit','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.settings.localizeRelations','false'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.settings.selectionLabel','\"\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.settings.showSiteMenu','true'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.settings.source','\"group:487681cb-7ad0-4313-b7f4-dd17bba6be08\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.settings.sources','\"*\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.settings.targetSiteId','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.settings.validateRelatedElements','false'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.settings.viewMode','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.translationKeyFormat','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.translationMethod','\"site\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.be63b0dc-b343-42c6-b6e5-4632786f15e1.type','\"craft\\\\fields\\\\Categories\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.f648a86b-dc9f-42cd-bf78-9849c5f82edc.contentColumnType','\"text\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.f648a86b-dc9f-42cd-bf78-9849c5f82edc.fieldGroup','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.f648a86b-dc9f-42cd-bf78-9849c5f82edc.handle','\"templateName\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.f648a86b-dc9f-42cd-bf78-9849c5f82edc.instructions','\"The file name of the desired twig template, located in templates/_custom-blocks\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.f648a86b-dc9f-42cd-bf78-9849c5f82edc.name','\"Template Name\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.f648a86b-dc9f-42cd-bf78-9849c5f82edc.searchable','true'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.f648a86b-dc9f-42cd-bf78-9849c5f82edc.settings.byteLimit','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.f648a86b-dc9f-42cd-bf78-9849c5f82edc.settings.charLimit','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.f648a86b-dc9f-42cd-bf78-9849c5f82edc.settings.code','\"\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.f648a86b-dc9f-42cd-bf78-9849c5f82edc.settings.columnType','\"text\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.f648a86b-dc9f-42cd-bf78-9849c5f82edc.settings.initialRows','\"4\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.f648a86b-dc9f-42cd-bf78-9849c5f82edc.settings.multiline','\"\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.f648a86b-dc9f-42cd-bf78-9849c5f82edc.settings.placeholder','\"template-name.twig\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.f648a86b-dc9f-42cd-bf78-9849c5f82edc.settings.uiMode','\"normal\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.f648a86b-dc9f-42cd-bf78-9849c5f82edc.translationKeyFormat','null'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.f648a86b-dc9f-42cd-bf78-9849c5f82edc.translationMethod','\"none\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.fields.f648a86b-dc9f-42cd-bf78-9849c5f82edc.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.handle','\"staticBlock\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.name','\"Static Block\"'),
	('matrixBlockTypes.c5697269-6f3a-43f6-801d-7331b4eb8d1f.sortOrder','9'),
	('plugins.cookies.enabled','\"1\"'),
	('plugins.cookies.licenseKey','null'),
	('plugins.cookies.schemaVersion','\"1.0.0\"'),
	('plugins.cookies.settings','null'),
	('plugins.field-manager.enabled','\"1\"'),
	('plugins.field-manager.licenseKey','null'),
	('plugins.field-manager.schemaVersion','\"1.0.0\"'),
	('plugins.field-manager.settings','null'),
	('plugins.kint.edition','\"standard\"'),
	('plugins.kint.enabled','true'),
	('plugins.kint.schemaVersion','\"1.0.0\"'),
	('plugins.redactor.enabled','\"1\"'),
	('plugins.redactor.licenseKey','null'),
	('plugins.redactor.schemaVersion','\"2.3.0\"'),
	('plugins.redactor.settings','null'),
	('plugins.tablemaker.enabled','\"1\"'),
	('plugins.tablemaker.licenseKey','null'),
	('plugins.tablemaker.schemaVersion','\"1.0.0\"'),
	('plugins.tablemaker.settings','null'),
	('sections.39f758c4-55bd-4111-9963-e5d9a7143820.enableVersioning','true'),
	('sections.39f758c4-55bd-4111-9963-e5d9a7143820.handle','\"mainContentPages\"'),
	('sections.39f758c4-55bd-4111-9963-e5d9a7143820.name','\"Main Content Pages\"'),
	('sections.39f758c4-55bd-4111-9963-e5d9a7143820.previewTargets.0.label','\"Primary entry page\"'),
	('sections.39f758c4-55bd-4111-9963-e5d9a7143820.previewTargets.0.urlFormat','\"{url}\"'),
	('sections.39f758c4-55bd-4111-9963-e5d9a7143820.propagationMethod','\"all\"'),
	('sections.39f758c4-55bd-4111-9963-e5d9a7143820.siteSettings.68b81c3c-1a31-4373-89c3-7dbdff84908c.enabledByDefault','true'),
	('sections.39f758c4-55bd-4111-9963-e5d9a7143820.siteSettings.68b81c3c-1a31-4373-89c3-7dbdff84908c.hasUrls','true'),
	('sections.39f758c4-55bd-4111-9963-e5d9a7143820.siteSettings.68b81c3c-1a31-4373-89c3-7dbdff84908c.template','\"_templates/entry\"'),
	('sections.39f758c4-55bd-4111-9963-e5d9a7143820.siteSettings.68b81c3c-1a31-4373-89c3-7dbdff84908c.uriFormat','\"{slug}\"'),
	('sections.39f758c4-55bd-4111-9963-e5d9a7143820.structure.maxLevels','null'),
	('sections.39f758c4-55bd-4111-9963-e5d9a7143820.structure.uid','\"3bcd708c-ee39-4622-b37f-9e14c54daffb\"'),
	('sections.39f758c4-55bd-4111-9963-e5d9a7143820.type','\"structure\"'),
	('sections.93167c2e-8b5f-495c-a89a-3de3262088c3.enableVersioning','true'),
	('sections.93167c2e-8b5f-495c-a89a-3de3262088c3.handle','\"complexBlocks\"'),
	('sections.93167c2e-8b5f-495c-a89a-3de3262088c3.name','\"Complex Blocks\"'),
	('sections.93167c2e-8b5f-495c-a89a-3de3262088c3.propagationMethod','\"all\"'),
	('sections.93167c2e-8b5f-495c-a89a-3de3262088c3.siteSettings.68b81c3c-1a31-4373-89c3-7dbdff84908c.enabledByDefault','true'),
	('sections.93167c2e-8b5f-495c-a89a-3de3262088c3.siteSettings.68b81c3c-1a31-4373-89c3-7dbdff84908c.hasUrls','false'),
	('sections.93167c2e-8b5f-495c-a89a-3de3262088c3.siteSettings.68b81c3c-1a31-4373-89c3-7dbdff84908c.template','null'),
	('sections.93167c2e-8b5f-495c-a89a-3de3262088c3.siteSettings.68b81c3c-1a31-4373-89c3-7dbdff84908c.uriFormat','null'),
	('sections.93167c2e-8b5f-495c-a89a-3de3262088c3.type','\"channel\"'),
	('sections.e3ca366b-16e2-4855-a2a5-9c0f779d8c1b.enableVersioning','true'),
	('sections.e3ca366b-16e2-4855-a2a5-9c0f779d8c1b.handle','\"homepage\"'),
	('sections.e3ca366b-16e2-4855-a2a5-9c0f779d8c1b.name','\"Homepage\"'),
	('sections.e3ca366b-16e2-4855-a2a5-9c0f779d8c1b.previewTargets.0.label','\"Primary entry page\"'),
	('sections.e3ca366b-16e2-4855-a2a5-9c0f779d8c1b.previewTargets.0.urlFormat','\"{url}\"'),
	('sections.e3ca366b-16e2-4855-a2a5-9c0f779d8c1b.propagationMethod','\"all\"'),
	('sections.e3ca366b-16e2-4855-a2a5-9c0f779d8c1b.siteSettings.68b81c3c-1a31-4373-89c3-7dbdff84908c.enabledByDefault','true'),
	('sections.e3ca366b-16e2-4855-a2a5-9c0f779d8c1b.siteSettings.68b81c3c-1a31-4373-89c3-7dbdff84908c.hasUrls','true'),
	('sections.e3ca366b-16e2-4855-a2a5-9c0f779d8c1b.siteSettings.68b81c3c-1a31-4373-89c3-7dbdff84908c.template','\"\"'),
	('sections.e3ca366b-16e2-4855-a2a5-9c0f779d8c1b.siteSettings.68b81c3c-1a31-4373-89c3-7dbdff84908c.uriFormat','\"__home__\"'),
	('sections.e3ca366b-16e2-4855-a2a5-9c0f779d8c1b.type','\"single\"'),
	('siteGroups.c47fc095-639f-4ecb-aee4-f753bf707827.name','\"Concert Base Craft 3\"'),
	('sites.68b81c3c-1a31-4373-89c3-7dbdff84908c.baseUrl','\"//localhost:3000/\"'),
	('sites.68b81c3c-1a31-4373-89c3-7dbdff84908c.handle','\"default\"'),
	('sites.68b81c3c-1a31-4373-89c3-7dbdff84908c.hasUrls','true'),
	('sites.68b81c3c-1a31-4373-89c3-7dbdff84908c.language','\"en\"'),
	('sites.68b81c3c-1a31-4373-89c3-7dbdff84908c.name','\"Concert Base Craft 3\"'),
	('sites.68b81c3c-1a31-4373-89c3-7dbdff84908c.primary','true'),
	('sites.68b81c3c-1a31-4373-89c3-7dbdff84908c.siteGroup','\"c47fc095-639f-4ecb-aee4-f753bf707827\"'),
	('sites.68b81c3c-1a31-4373-89c3-7dbdff84908c.sortOrder','1'),
	('system.edition','\"pro\"'),
	('system.live','true'),
	('system.name','\"Base Craft 3\"'),
	('system.schemaVersion','\"3.7.8\"'),
	('system.timeZone','\"Europe/London\"'),
	('users.allowPublicRegistration','false'),
	('users.defaultGroup','null'),
	('users.photoSubpath','null'),
	('users.photoVolumeUid','null'),
	('users.requireEmailVerification','true'),
	('volumes.3b244919-9ddb-4ed8-b47d-f3e626e7c0fa.handle','\"uploads\"'),
	('volumes.3b244919-9ddb-4ed8-b47d-f3e626e7c0fa.hasUrls','true'),
	('volumes.3b244919-9ddb-4ed8-b47d-f3e626e7c0fa.name','\"Uploads\"'),
	('volumes.3b244919-9ddb-4ed8-b47d-f3e626e7c0fa.settings.path','\"@webroot/assets/uploads\"'),
	('volumes.3b244919-9ddb-4ed8-b47d-f3e626e7c0fa.sortOrder','1'),
	('volumes.3b244919-9ddb-4ed8-b47d-f3e626e7c0fa.type','\"craft\\\\volumes\\\\Local\"'),
	('volumes.3b244919-9ddb-4ed8-b47d-f3e626e7c0fa.url','\"@web/assets/uploads\"');

/*!40000 ALTER TABLE `cc1_projectconfig` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_queue`;

CREATE TABLE `cc1_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text DEFAULT NULL,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) unsigned NOT NULL DEFAULT 1024,
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT 0,
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT 0,
  `dateFailed` datetime DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cc1_queue_channel_fail_timeUpdated_timePushed_idx` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `cc1_queue_channel_fail_timeUpdated_delay_idx` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_relations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_relations`;

CREATE TABLE `cc1_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `cc1_relations_sourceId_idx` (`sourceId`),
  KEY `cc1_relations_targetId_idx` (`targetId`),
  KEY `cc1_relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `cc1_relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `cc1_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `cc1_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cc1_relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_relations` WRITE;
/*!40000 ALTER TABLE `cc1_relations` DISABLE KEYS */;

INSERT INTO `cc1_relations` (`id`, `fieldId`, `sourceId`, `sourceSiteId`, `targetId`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(44,27,8,NULL,2,1,'2018-10-16 11:35:36','2018-10-16 11:35:36','0703c980-067d-41f8-8ed8-ef1de9c087b5'),
	(45,27,8,NULL,3,2,'2018-10-16 11:35:36','2018-10-16 11:35:36','e6695eaf-dc76-476a-839d-7be3ac55395d'),
	(46,27,8,NULL,4,3,'2018-10-16 11:35:36','2018-10-16 11:35:36','ab86a23e-46ce-496e-be66-5569671c7304'),
	(47,2,9,NULL,2,1,'2018-10-16 11:35:36','2018-10-16 11:35:36','e2363aea-3777-4023-8bda-2fce279af3cd'),
	(48,2,9,NULL,3,2,'2018-10-16 11:35:36','2018-10-16 11:35:36','2b7cd672-c31f-4835-93c2-a824221cd395'),
	(49,2,9,NULL,4,3,'2018-10-16 11:35:36','2018-10-16 11:35:36','8178459f-81aa-4ff6-aa1c-b4b3b8ec29f8'),
	(50,29,16,NULL,2,1,'2018-10-16 11:35:36','2018-10-16 11:35:36','b5c8369b-8d69-47e8-a57e-b46d57b13fce'),
	(51,27,10,NULL,2,1,'2018-10-16 11:35:50','2018-10-16 11:35:50','4f37f457-254f-46d0-b805-0352b8edcf6c'),
	(52,2,11,NULL,2,1,'2018-10-16 11:35:50','2018-10-16 11:35:50','6a350332-df72-461c-9da5-2dc6fd2e44f3'),
	(53,2,11,NULL,3,2,'2018-10-16 11:35:50','2018-10-16 11:35:50','3bbc5356-a365-4bf9-8f7c-6aae8aa3c3b1'),
	(54,2,11,NULL,4,3,'2018-10-16 11:35:50','2018-10-16 11:35:50','5c33a4f3-efd3-4fbb-8512-da67c20c6161'),
	(55,4,12,NULL,2,1,'2018-10-16 11:35:50','2018-10-16 11:35:50','37672be4-58c2-485a-9622-2794a6674651'),
	(56,4,12,NULL,3,2,'2018-10-16 11:35:50','2018-10-16 11:35:50','21dba4ab-ff5c-499d-a3a8-9c227a1b7040'),
	(57,4,12,NULL,4,3,'2018-10-16 11:35:50','2018-10-16 11:35:50','fbb701e5-8043-4e6c-b231-9ddf916c749a'),
	(61,10,14,NULL,2,1,'2018-10-16 11:35:50','2018-10-16 11:35:50','b738e27d-380d-4ccf-98f7-7606f4b06ec2'),
	(62,10,14,NULL,3,2,'2018-10-16 11:35:50','2018-10-16 11:35:50','34b31197-38d5-4a38-9b6d-7d3027ab95a5'),
	(63,10,14,NULL,4,3,'2018-10-16 11:35:50','2018-10-16 11:35:50','62d91261-771c-4663-a464-fb3311bda941'),
	(64,22,15,NULL,2,1,'2018-10-16 11:35:50','2018-10-16 11:35:50','cabeb90d-90dd-4380-a390-885ee68398b0'),
	(65,22,15,NULL,3,2,'2018-10-16 11:35:50','2018-10-16 11:35:50','9b70b6b9-0748-4845-b737-9213bd409663'),
	(66,22,15,NULL,4,3,'2018-10-16 11:35:50','2018-10-16 11:35:50','23847118-5867-4a89-90cc-52648abbc560'),
	(333,27,6,NULL,2,1,'2020-07-28 14:04:06','2020-07-28 14:04:06','27d71da7-00bd-44fb-92b9-5efe2c824a3e'),
	(334,27,6,NULL,3,2,'2020-07-28 14:04:06','2020-07-28 14:04:06','30932caa-0371-4cf5-92e8-7e40c9a915f3'),
	(335,27,6,NULL,4,3,'2020-07-28 14:04:06','2020-07-28 14:04:06','a69c9c5b-d41c-42d4-8a94-0607452815e0'),
	(336,64,21,NULL,2,1,'2020-07-28 14:04:06','2020-07-28 14:04:06','833bb688-885d-45a8-9695-3af41fb7c6cb'),
	(337,64,21,NULL,3,2,'2020-07-28 14:04:06','2020-07-28 14:04:06','608a589c-2b9f-4979-a807-7f46130fa9b9'),
	(338,2,7,NULL,2,1,'2020-07-28 14:04:06','2020-07-28 14:04:06','2aed764e-f50c-43b9-bf5f-62c20cd84da3'),
	(339,2,7,NULL,3,2,'2020-07-28 14:04:06','2020-07-28 14:04:06','7c8ffd01-0ab4-44b2-a474-70b50edf0745'),
	(340,2,7,NULL,4,3,'2020-07-28 14:04:06','2020-07-28 14:04:06','05c7cccf-de7e-4970-99b6-af6cbb7edcaf'),
	(341,36,27,NULL,2,1,'2020-07-28 14:04:06','2020-07-28 14:04:06','e3eaa295-f2dc-4c1f-ac59-af0477594e20'),
	(342,36,27,NULL,3,2,'2020-07-28 14:04:06','2020-07-28 14:04:06','1e514153-52ad-455f-972c-4ee968146d44'),
	(343,36,27,NULL,4,3,'2020-07-28 14:04:06','2020-07-28 14:04:06','e606b00c-1a45-4b51-8821-4911d6c758ed'),
	(344,64,22,NULL,2,1,'2020-07-28 14:04:06','2020-07-28 14:04:06','edba285b-921a-4a11-97f8-2dcc8e5f4cd3'),
	(345,64,22,NULL,3,2,'2020-07-28 14:04:06','2020-07-28 14:04:06','74c90528-e6f6-43d2-ab42-a4ad0fde62db'),
	(346,2,23,NULL,2,1,'2020-07-28 14:04:06','2020-07-28 14:04:06','06042046-5053-48b9-81f0-45fafaf90816'),
	(347,2,23,NULL,3,2,'2020-07-28 14:04:06','2020-07-28 14:04:06','3b9c575b-28c9-49db-af6f-34fccd9392b1'),
	(348,10,19,NULL,2,1,'2020-07-28 14:04:06','2020-07-28 14:04:06','c74124d0-c233-421d-9e06-772f343368c1'),
	(349,10,19,NULL,3,2,'2020-07-28 14:04:06','2020-07-28 14:04:06','7b199bf6-0993-4a8e-beac-d8c9336921d9'),
	(353,10,20,NULL,2,1,'2020-07-28 14:04:06','2020-07-28 14:04:06','b77384fd-4b37-40df-858a-a37f06d2c12a'),
	(354,10,20,NULL,3,2,'2020-07-28 14:04:06','2020-07-28 14:04:06','8616c34f-a6dc-4ad8-8abf-d38dcd68f297'),
	(355,40,25,NULL,2,1,'2020-07-28 14:04:07','2020-07-28 14:04:07','34addfd1-9409-4e2f-8c3f-7f024ffa550d'),
	(356,40,25,NULL,3,2,'2020-07-28 14:04:07','2020-07-28 14:04:07','4febd6ca-43a7-4e4f-8e4d-861293cbcbd1'),
	(357,40,25,NULL,4,3,'2020-07-28 14:04:07','2020-07-28 14:04:07','c5543bae-4b77-4fd9-9852-cb885e201135'),
	(358,73,26,NULL,2,1,'2020-07-28 14:04:07','2020-07-28 14:04:07','8d54ab09-c86e-4dbc-b31d-f2851662d791'),
	(359,73,26,NULL,3,2,'2020-07-28 14:04:07','2020-07-28 14:04:07','927b11b0-2481-460c-bb69-592928898ec6'),
	(360,73,26,NULL,4,3,'2020-07-28 14:04:07','2020-07-28 14:04:07','281ba82d-be12-46a1-afd6-cb9ebf397961'),
	(361,74,26,NULL,24,1,'2020-07-28 14:04:07','2020-07-28 14:04:07','10bcf16c-8872-417d-998d-73fb1b21ddb9'),
	(362,27,30,NULL,2,1,'2020-08-18 08:40:20','2020-08-18 08:40:20','6635f92c-83c4-4570-b4b8-d1e1922ae25c'),
	(363,27,30,NULL,3,2,'2020-08-18 08:40:20','2020-08-18 08:40:20','664e98ab-daf4-4863-b8ea-a1b3a034f135'),
	(364,27,30,NULL,4,3,'2020-08-18 08:40:20','2020-08-18 08:40:20','840a745c-6410-4de8-b067-f0b94d70e667'),
	(365,64,31,NULL,2,1,'2020-08-18 08:40:20','2020-08-18 08:40:20','24aec4b8-790e-4cb3-b709-730ebdbe7286'),
	(366,64,31,NULL,3,2,'2020-08-18 08:40:20','2020-08-18 08:40:20','e68fe7b4-c012-469b-a321-934e28a3d125'),
	(367,2,32,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','e26d33e5-cc4c-48a4-a3b5-bba1341de46e'),
	(368,2,32,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','3f904c03-b448-4711-8f23-b3161eac1bf7'),
	(369,2,32,NULL,4,3,'2020-08-18 08:40:21','2020-08-18 08:40:21','cbbb9acf-1fdb-4673-bde1-438d3c279c0f'),
	(370,36,33,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','6f97b44a-204f-44c4-baa2-fce4ccfd4d41'),
	(371,36,33,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','9573151e-9d54-46fb-942c-cb8e886cad79'),
	(372,36,33,NULL,4,3,'2020-08-18 08:40:21','2020-08-18 08:40:21','1ed42768-4ab2-4ebe-af0f-1d2f85d0c4b9'),
	(373,64,34,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','baf611e2-a330-4b40-b233-54204178f1b6'),
	(374,64,34,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','00f30bf5-3693-49e1-a6f5-248c79accd74'),
	(375,2,35,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','4ad8aa39-927c-4fd0-94b9-142445f248ab'),
	(376,2,35,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','22745ca9-cfe4-4a7d-b85f-8ca5c40586a5'),
	(377,10,36,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','b85c173e-40ab-4dd6-b1b2-d4d92b080860'),
	(378,10,36,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','b7fd2530-b2c6-4514-ada6-821d4fff1fb7'),
	(382,10,38,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','947dceff-bafe-41af-8e07-a5ae8c06c454'),
	(383,10,38,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','0b695d37-576a-425c-b340-c8e0a15542e6'),
	(384,40,39,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','0a6f345f-4bab-43ae-9971-8adbd0291a35'),
	(385,40,39,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','e6c2d89e-d3fb-4fa6-b9a8-02986ffc66cd'),
	(386,40,39,NULL,4,3,'2020-08-18 08:40:21','2020-08-18 08:40:21','be4fd164-47fd-4f42-b872-b08d16293bce'),
	(387,73,40,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','399154ba-daa4-4839-8bcb-c46d28dd2489'),
	(388,73,40,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','5bd31912-af0b-429a-8c10-28537df6d317'),
	(389,73,40,NULL,4,3,'2020-08-18 08:40:21','2020-08-18 08:40:21','9c20f8c2-0246-4d40-a5cc-7ccc2652a2da'),
	(390,74,40,NULL,24,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','66db35e5-b11f-48fc-8cd1-b91df8139225'),
	(391,27,43,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','31874897-a8d5-49c0-af06-5f707cbeef43'),
	(392,27,43,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','5e2fb8ab-0c3d-487c-9874-e73f7cf787c4'),
	(393,27,43,NULL,4,3,'2020-08-18 08:40:21','2020-08-18 08:40:21','8f0da4d5-c74c-408d-a1bf-fbba0ed5905c'),
	(394,64,44,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','f6dcd069-f083-4e23-b5bf-83ae32b584f0'),
	(395,64,44,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','6ac2b7fb-2723-4b59-9d42-46ae405817b0'),
	(396,2,45,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','0ef4fa8f-084e-46fd-aef9-7d14d408ff89'),
	(397,2,45,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','e956118e-81d5-4ab3-a0d6-2a64bb6491e7'),
	(398,2,45,NULL,4,3,'2020-08-18 08:40:21','2020-08-18 08:40:21','fc6af753-c3d1-4d33-bef2-f17df6c5e65e'),
	(399,36,46,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','e9a691bc-8475-4920-9317-a44bce9241c3'),
	(400,36,46,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','6f867213-e296-410e-b8e3-cb88187a71ac'),
	(401,36,46,NULL,4,3,'2020-08-18 08:40:21','2020-08-18 08:40:21','30a33637-02c1-4ef9-9d9c-37e49dfc1d92'),
	(402,64,47,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','15d00dbb-69be-4825-8558-867b53809543'),
	(403,64,47,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','0802185d-2324-4170-af5c-b35026381cdd'),
	(404,2,48,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','bf0c4f81-29c2-4643-ab61-ba75f198e31a'),
	(405,2,48,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','406896a0-c260-4c63-9066-7645d3a0ecc4'),
	(406,10,49,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','bb7421f9-40e3-4e8e-a91a-4e94814ccd23'),
	(407,10,49,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','b1d15c7a-412c-4efc-85ef-d43c9788390c'),
	(411,10,51,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','bb85d516-958f-4e3b-81f3-aa719b9a0d60'),
	(412,10,51,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','0824a65e-53c0-48e7-83e8-ba7f289d92c4'),
	(413,40,52,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','19e6b7af-fdb3-42bb-a013-65565669718a'),
	(414,40,52,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','06770597-f667-4550-8739-4971dfa8018f'),
	(415,40,52,NULL,4,3,'2020-08-18 08:40:21','2020-08-18 08:40:21','560e8a62-5102-46cc-8d48-aeaaa8ae45a1'),
	(416,73,53,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','10d6eb38-54d2-4892-912c-609967dd7a1b'),
	(417,73,53,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','eb3f394d-b29c-4b2c-9cb1-50d00a068bbc'),
	(418,73,53,NULL,4,3,'2020-08-18 08:40:21','2020-08-18 08:40:21','554c6433-67c7-40f7-8680-2d9a58d1282d'),
	(419,74,53,NULL,24,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','f0a1157d-a621-4b63-8313-b05af2324c22'),
	(420,64,54,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','d7294276-59ee-4054-9ca7-55afb4c5ac7f'),
	(421,64,54,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','1a07b23f-6aed-49ca-910a-b419d189399f'),
	(422,2,55,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','473af0fe-43c6-4ce4-ae69-2ea362fce2ec'),
	(423,2,55,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','95951472-9a2d-48bc-aa15-35b2acaee5c4'),
	(424,2,55,NULL,4,3,'2020-08-18 08:40:21','2020-08-18 08:40:21','e939c45b-16d1-4e56-adc3-c569115878a7'),
	(425,64,56,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','2fa4791e-b015-4d41-850b-5788f360004e'),
	(426,64,56,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','6bbf66bf-739d-409c-8abc-4feeb9f86184'),
	(427,2,57,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','1a513170-464b-4f50-9b3b-97e6e8113b22'),
	(428,2,57,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','ac20c861-d091-4614-8765-ea44534eac67'),
	(429,10,58,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','7eb16181-53f4-4c63-81ae-044a2e692c57'),
	(430,10,58,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','084a52e5-b923-490a-9858-e2166df469d2'),
	(434,10,60,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','9662b24f-d568-45bd-8598-f417ab4dff20'),
	(435,10,60,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','015f3025-6e5b-4e84-8315-782bd1ffe387'),
	(436,40,61,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','7fde5442-5616-438e-8664-b615d92aca61'),
	(437,40,61,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','7234c1f8-3615-4cb7-bd3d-930e9b837619'),
	(438,40,61,NULL,4,3,'2020-08-18 08:40:21','2020-08-18 08:40:21','9edd95e9-4c73-43db-84b0-ad043905621d'),
	(439,73,62,NULL,2,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','23000e8e-0ef0-4027-bd75-d6fc206c41f4'),
	(440,73,62,NULL,3,2,'2020-08-18 08:40:21','2020-08-18 08:40:21','48008910-5b0f-4e76-915d-94b20690e52d'),
	(441,73,62,NULL,4,3,'2020-08-18 08:40:21','2020-08-18 08:40:21','35ddd085-b888-4518-a621-af66ebb5635e'),
	(442,74,62,NULL,24,1,'2020-08-18 08:40:21','2020-08-18 08:40:21','40b0dd86-fecb-4adb-8c07-99753cb05858'),
	(443,27,64,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','eb011362-eeb5-403a-a1fc-0b70816990b1'),
	(444,27,64,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','ea9588e5-ba25-4d86-9820-039d6f17ee2b'),
	(445,27,64,NULL,4,3,'2020-08-18 08:40:22','2020-08-18 08:40:22','fa951b68-3ada-4a73-85de-1eaa7438c8c4'),
	(446,64,65,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','30246820-39ce-4909-8a16-6a811903aef4'),
	(447,64,65,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','931e84f8-6e97-4d5b-aee8-1e3ae5546b11'),
	(448,2,66,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','58896f93-4e50-41e2-8504-18b8e101b828'),
	(449,2,66,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','78bd6252-69d0-477b-905e-a9088591c939'),
	(450,2,66,NULL,4,3,'2020-08-18 08:40:22','2020-08-18 08:40:22','7784727e-268e-44f3-9d60-e11e565f1eef'),
	(451,64,67,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','1f8a732c-aeda-4227-b369-d089cc3a869b'),
	(452,64,67,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','42d989f4-080c-4fab-803c-77478ec4d7ce'),
	(453,2,68,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','ff2c19d6-47cc-41de-ae9c-631877624080'),
	(454,2,68,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','32f586d6-2d47-4a1c-9691-71c8a530c950'),
	(455,10,69,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','2dc75409-b9ca-4cc8-ae98-f5e8e91e6c22'),
	(456,10,69,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','15084a14-d6c3-4d2f-9761-436f58608325'),
	(460,10,71,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','b4f8eecd-64f0-4f6f-8c61-1903f2399b82'),
	(461,10,71,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','ac419d30-729b-41a0-afee-ef7bbbfa33a5'),
	(462,40,72,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','1b39f7fa-ddfa-4352-8e86-9c3c6435f0b4'),
	(463,40,72,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','da4f9348-800d-4787-af7c-6e4975d0425a'),
	(464,40,72,NULL,4,3,'2020-08-18 08:40:22','2020-08-18 08:40:22','37ebac62-bc99-4990-ba2d-3a6995d47a96'),
	(465,73,73,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','2da67440-4d5a-4804-900b-31fb60bc8f49'),
	(466,73,73,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','909ab536-6a31-4c33-b89e-ae96aa479978'),
	(467,73,73,NULL,4,3,'2020-08-18 08:40:22','2020-08-18 08:40:22','d57bdff4-8f25-47b5-b9a4-10d1cee2ab3a'),
	(468,74,73,NULL,24,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','babe4004-20d2-4d53-b122-c4363b7783f7'),
	(469,64,74,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','d5ac6a42-7d55-4612-9f6f-4ede9b568f5b'),
	(470,64,74,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','4ad3ae45-6064-492c-876f-d66453f26483'),
	(471,2,75,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','c51c040a-da64-4b42-ab86-ff799bbded1f'),
	(472,2,75,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','e34fa9d0-6e27-4ea6-86c0-b6b355459e8f'),
	(473,2,75,NULL,4,3,'2020-08-18 08:40:22','2020-08-18 08:40:22','9eb78e84-40a8-42ab-a27d-6b2e86c2dc58'),
	(474,64,76,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','b171b7e0-8841-4d39-a6d8-72d9f6854174'),
	(475,64,76,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','77df7ca8-1af3-4a5a-a073-678ff53625ea'),
	(476,2,77,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','bdb59125-158a-4191-a759-a2f98b4fc0cb'),
	(477,2,77,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','eeee7bdd-343a-4e88-84a5-86658d780445'),
	(478,10,78,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','ec8d3301-5819-400a-befb-b5f4bae4947b'),
	(479,10,78,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','000e53ba-649a-4806-bf57-490d19a6094d'),
	(483,10,80,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','79fa4498-967b-4534-b038-a0ab767e3f77'),
	(484,10,80,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','1dfe4bda-616f-4a58-bb08-18f2793873c7'),
	(485,27,81,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','85d0daa2-ade3-4fbe-abd3-6ce5be648479'),
	(486,27,81,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','71a8a035-f007-43b2-b506-0f154ccaf290'),
	(487,27,81,NULL,4,3,'2020-08-18 08:40:22','2020-08-18 08:40:22','79f7133e-1e18-4369-ad6d-a6092effdbce'),
	(488,64,82,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','50559641-6c17-4cff-8622-5b77a9df66d7'),
	(489,64,82,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','8cf1c699-7ff5-4543-8c47-ad67da234a76'),
	(490,2,83,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','521385be-4e02-4c6c-abf0-e8f51fd6628f'),
	(491,2,83,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','7f5d35e0-fb85-423f-9346-008aaa11938d'),
	(492,2,83,NULL,4,3,'2020-08-18 08:40:22','2020-08-18 08:40:22','c8992fe9-aa75-4c1c-b23f-c84e4568ba49'),
	(493,64,84,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','dbcaaffd-a564-45d9-844a-c85a34298408'),
	(494,64,84,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','d5f7504d-e5b8-4baf-a8a8-5474347001a4'),
	(495,2,85,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','97bcc3b7-ce88-4689-b7f1-1f31572036c7'),
	(496,2,85,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','06241e70-db7b-49ba-81a5-432a65215d3e'),
	(497,10,86,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','752cf09d-93eb-4dfe-91f2-0fa6ffba6d5e'),
	(498,10,86,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','1c4d8afc-d14c-47b8-bc53-b4ee99e1c6c9'),
	(502,10,88,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','2f803d38-6b2a-478d-9f88-37eddb33fc23'),
	(503,10,88,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','70085ede-1e53-4140-a00c-de2d068c34e4'),
	(504,27,89,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','af686465-b861-4f26-a301-593465533105'),
	(505,27,89,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','f143995a-4cf7-447a-8b96-80ad43629e40'),
	(506,27,89,NULL,4,3,'2020-08-18 08:40:22','2020-08-18 08:40:22','76589529-2f6e-4434-a793-a1ec33900c0b'),
	(507,64,90,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','0f93554d-a644-4941-ae56-12a47e107663'),
	(508,64,90,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','d400a022-755d-4960-81ad-74e4e6e832c4'),
	(509,2,91,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','6180b92a-1427-4e02-ae0f-1931bcfa2ded'),
	(510,2,91,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','21ff28dc-b82d-481f-a2ba-c464aeaa7914'),
	(511,2,91,NULL,4,3,'2020-08-18 08:40:22','2020-08-18 08:40:22','9239c0fe-a46c-46e2-b27b-522963a4d7ac'),
	(512,64,92,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','f6876eb3-bc0d-40d9-bc4e-8462d01469e3'),
	(513,64,92,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','f34832b9-8d6c-4bb0-9ddc-bb3ff9d15dd3'),
	(514,2,93,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','c6af5770-7fba-4556-ac4b-f5027c9ae95e'),
	(515,2,93,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','0d5a7cfe-9d43-49eb-ab28-1fc1aba8fe74'),
	(516,10,94,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','504921b6-dd52-42fb-a3b9-5f91c56c0dcf'),
	(517,10,94,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','b0356ae9-1547-41fc-af28-ca0b95b6f662'),
	(521,10,96,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','b9f71687-9584-46e0-a42a-47aa490fae9b'),
	(522,10,96,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','0c2c9558-b678-4c69-b6a7-9d92e71ac17f'),
	(523,27,97,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','a2a8c035-fa42-4b9a-871d-c13990e75b26'),
	(524,27,97,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','bf4f402f-4499-4853-b201-aa72c7b2f867'),
	(525,27,97,NULL,4,3,'2020-08-18 08:40:22','2020-08-18 08:40:22','8ed658dd-5965-44b8-8424-c42470f6407c'),
	(526,64,98,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','985fecff-09bd-434f-be9c-1232fa9a9170'),
	(527,64,98,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','f42dc2f6-8f93-4793-b0aa-d087ae7b6ec4'),
	(528,2,99,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','6961260c-ff9e-4c9a-9d9c-253854f4a709'),
	(529,2,99,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','b17c71e8-131e-4c0d-ae4b-c7e2119bc2aa'),
	(530,2,99,NULL,4,3,'2020-08-18 08:40:22','2020-08-18 08:40:22','c9e131fb-1f97-4799-bc67-604a4d6b713a'),
	(531,64,100,NULL,2,1,'2020-08-18 08:40:22','2020-08-18 08:40:22','24e05e27-18ba-47e4-9dff-e74d2ac5b338'),
	(532,64,100,NULL,3,2,'2020-08-18 08:40:22','2020-08-18 08:40:22','0bb48f04-092e-4e01-97bd-891e469382d8'),
	(533,2,101,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','15bef303-79d8-4ff5-88b7-6419ce9d1ba0'),
	(534,2,101,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','fc8e3570-c8ae-487c-877b-b6419f18e2c4'),
	(535,10,102,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','21849d01-9f50-486c-8eba-2db87c564206'),
	(536,10,102,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','cdda461a-d1e9-4058-beed-c968c1cb216c'),
	(540,10,104,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','d1fb71a7-049c-4a9f-ac4f-eadd15f33d52'),
	(541,10,104,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','c6da1022-0676-41ab-8723-10b7cf51865d'),
	(542,27,105,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','054e7110-4914-4b16-adab-312acd625f94'),
	(543,27,105,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','5a6ffa7c-b0b0-4f98-94a9-cc10b5d83b86'),
	(544,27,105,NULL,4,3,'2020-08-18 08:40:23','2020-08-18 08:40:23','c49ddcf7-d67f-4317-8118-1303b29e4f27'),
	(545,64,106,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','9ce1e2b0-0b35-4cba-86a9-b890f9ff5ad0'),
	(546,64,106,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','1c2f7f1b-7a9b-4892-b548-437a361f3a03'),
	(547,2,107,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','9286531c-ba9f-430a-83d6-03a3bee56e88'),
	(548,2,107,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','26f17775-7580-4d64-a422-14900bb48d97'),
	(549,2,107,NULL,4,3,'2020-08-18 08:40:23','2020-08-18 08:40:23','9e50d3de-447a-4a68-acb1-548cb80323ba'),
	(550,64,108,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','6fa623dc-da0b-48c8-a175-a1cb80d90a1a'),
	(551,64,108,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','667cec8f-3b91-4276-a298-6f0e891e31c0'),
	(552,2,109,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','9fed9011-a1fd-4911-9abd-27ef414bffe4'),
	(553,2,109,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','8fabf91c-803c-4efc-8215-e666d8ba742a'),
	(554,10,110,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','0cca843c-8c03-408b-8e15-9597812f8617'),
	(555,10,110,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','28d8059b-3a29-4b80-980b-cdbb463e7c5f'),
	(559,10,112,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','7357a72d-f8ec-4c1d-bce3-5b4f485f8e3a'),
	(560,10,112,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','b27077e5-3967-450d-910f-b134a8383948'),
	(561,27,113,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','e6abcf61-c997-44b9-a7e0-16c7356ef37a'),
	(562,27,113,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','38057646-f04f-45dd-b1b3-221c4879b060'),
	(563,27,113,NULL,4,3,'2020-08-18 08:40:23','2020-08-18 08:40:23','ef4ec1dd-bafd-46d6-ae8a-7d6e9b079ef2'),
	(564,64,114,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','4c838a9d-52a2-4346-b450-a38c6f07b1ed'),
	(565,64,114,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','80cb1043-b907-457b-a571-58da4076ac93'),
	(566,2,115,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','b7a5d0db-6ecb-4331-aed1-2476405a4570'),
	(567,2,115,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','507bd07d-e068-41e2-b97c-db8b668b7b6c'),
	(568,2,115,NULL,4,3,'2020-08-18 08:40:23','2020-08-18 08:40:23','fed4bab6-4ad3-4e2b-9fb9-a80846d71d68'),
	(569,64,116,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','0a36122a-f2b1-4550-9222-c1fbec517361'),
	(570,64,116,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','2ab01a13-a389-4bab-8a34-e042dd77c8ad'),
	(571,2,117,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','2a42007b-5af8-40ab-855a-77e0188ed4c2'),
	(572,2,117,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','ef857aef-cd9a-4a43-94ab-86ea73ef5be0'),
	(573,10,118,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','4c0b53fa-82f9-4d89-92bc-3b110bb8f045'),
	(574,10,118,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','b829e278-577c-4fb3-8171-86d651068ed3'),
	(578,10,120,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','6198c359-68c0-44bb-a1ab-b6e24e34c11e'),
	(579,10,120,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','d19edb1e-0d13-4124-8790-990c12646991'),
	(580,27,121,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','ce3a8fb5-fc55-4171-bcf9-63efcf4a50b4'),
	(581,27,121,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','45c7d997-d013-4c54-b342-2d6a4cf9adec'),
	(582,27,121,NULL,4,3,'2020-08-18 08:40:23','2020-08-18 08:40:23','bc1e13ed-3990-4ce7-bcfd-05ff260b0bf2'),
	(583,64,122,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','cc8f772c-2343-42e2-a511-45520c8d191f'),
	(584,64,122,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','30596f10-16a6-40bb-907b-890b4198ab6a'),
	(585,2,123,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','65e335ad-40e2-4777-82eb-4611f5f97aac'),
	(586,2,123,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','2363f9f9-5960-4442-9c99-25766119b60a'),
	(587,2,123,NULL,4,3,'2020-08-18 08:40:23','2020-08-18 08:40:23','cc4c500b-14e0-40d2-9601-658d870ea30d'),
	(588,64,124,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','ea921002-b6e4-4937-9812-d64681aa6373'),
	(589,64,124,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','f8dfdab0-0d8e-4931-808d-1e201cb9095a'),
	(590,2,125,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','dfc57599-330f-4e8e-9c87-fd877c8807f0'),
	(591,2,125,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','6277cf66-2c96-4c9c-90b7-758c5cde658c'),
	(592,10,126,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','abc82c02-3d47-4d09-9095-e73232fa6fff'),
	(593,10,126,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','2d3ce3b0-46ba-4a88-91a1-73a8bb75c03c'),
	(597,10,128,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','b592b51c-f726-4553-801d-83a22c18b79d'),
	(598,10,128,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','723e9797-c438-4e7a-acfa-cea188800f31'),
	(599,27,129,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','0ad5edb2-cde3-4028-8fe6-1c31019dc59d'),
	(600,27,129,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','028c96f6-f6b1-487c-8a08-08fac9eb64a6'),
	(601,27,129,NULL,4,3,'2020-08-18 08:40:23','2020-08-18 08:40:23','d8798f55-b96f-4683-8c58-223f3dba3a0d'),
	(602,64,130,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','d8daa45f-ac20-49a4-b3ad-6c4c442170bb'),
	(603,64,130,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','20c6d4c7-ef09-41da-8636-3dcd386482ab'),
	(604,2,131,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','5c91f96b-0611-4084-a4c7-de593f39dc8e'),
	(605,2,131,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','6477eada-e0c7-4d6a-8fdf-2a0a89902831'),
	(606,2,131,NULL,4,3,'2020-08-18 08:40:23','2020-08-18 08:40:23','e9374c68-cb70-4c09-b290-9d1457f30fe1'),
	(607,64,132,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','bab6df1c-52ba-4fad-9036-01c7f12e13e0'),
	(608,64,132,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','476cb43a-c024-48f2-8c50-b66fc6eb7044'),
	(609,2,133,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','266f799c-ba77-4110-ab90-630ee1f43291'),
	(610,2,133,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','0ca79c91-ad7a-401b-be23-42080d85f347'),
	(611,10,134,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','8c156e98-7612-4985-a53b-108aa5402e76'),
	(612,10,134,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','d53f4973-3c4a-48c9-b3c1-41ae5d46da21'),
	(616,10,136,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','a30859ad-277b-4cc9-afae-fe26ccecc499'),
	(617,10,136,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','8ef14ae2-6e11-4336-afb4-941af8ebe81d'),
	(618,27,137,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','ce2ccf29-f601-4294-8e0d-b9f3640fbafc'),
	(619,27,137,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','64549287-5333-4dc0-874b-f18d4e01ff27'),
	(620,27,137,NULL,4,3,'2020-08-18 08:40:23','2020-08-18 08:40:23','e6536b22-b0ca-4461-b24b-dd95611ced09'),
	(621,64,138,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','95786c8d-cfdf-4426-9307-e8a0bfcb2c03'),
	(622,64,138,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','a760fdef-5ab2-49be-a2d7-7587b7c585af'),
	(623,2,139,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','cc110143-dd15-4031-8ce6-fc3848775646'),
	(624,2,139,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','786e0d67-649a-422d-abc0-fc79778dabaf'),
	(625,2,139,NULL,4,3,'2020-08-18 08:40:23','2020-08-18 08:40:23','fb905b48-2c89-4ebb-af7b-e77613900dc3'),
	(626,64,140,NULL,2,1,'2020-08-18 08:40:23','2020-08-18 08:40:23','dc007121-39aa-4a35-8a36-1128f5088d6e'),
	(627,64,140,NULL,3,2,'2020-08-18 08:40:23','2020-08-18 08:40:23','f980b04e-bda0-4a29-a924-e34dbd07df45'),
	(628,2,141,NULL,2,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','d66bccf0-af5e-4076-9da6-f1a3b8bb3274'),
	(629,2,141,NULL,3,2,'2020-08-18 08:40:24','2020-08-18 08:40:24','686b2974-e4fc-42b6-825b-4fed47b2d491'),
	(630,10,142,NULL,2,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','1e45733c-1599-49bc-9c9c-f3147bbdd747'),
	(631,10,142,NULL,3,2,'2020-08-18 08:40:24','2020-08-18 08:40:24','770ec4a6-184a-482b-bdde-cee56105c786'),
	(635,10,144,NULL,2,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','4a90e660-866b-4943-ba63-7bc9ab1a9f29'),
	(636,10,144,NULL,3,2,'2020-08-18 08:40:24','2020-08-18 08:40:24','e04633a3-354b-4d9a-854d-8863f5841604'),
	(637,2,145,NULL,2,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','9afb23b1-d68e-437d-bffd-7f294538154f'),
	(641,27,147,NULL,2,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','3031c407-5329-49a0-bc01-5bd5b644186a'),
	(642,27,147,NULL,3,2,'2020-08-18 08:40:24','2020-08-18 08:40:24','ce2fab70-28e0-4a94-961d-fd35fc76a23e'),
	(643,27,147,NULL,4,3,'2020-08-18 08:40:24','2020-08-18 08:40:24','9165feb8-1165-4df5-ab2f-d0d45dc9323c'),
	(644,2,148,NULL,2,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','408a5825-da38-400a-b19d-f6852a77013f'),
	(648,2,150,NULL,2,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','4e234103-ea00-41b7-bf0e-7d7921377291'),
	(652,27,152,NULL,2,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','9b872b63-4c62-48a9-a522-063f021b8c70'),
	(653,27,152,NULL,3,2,'2020-08-18 08:40:24','2020-08-18 08:40:24','086c71e8-b1af-438c-830a-77c294aee1e5'),
	(654,27,152,NULL,4,3,'2020-08-18 08:40:24','2020-08-18 08:40:24','c1fbd6d8-0925-4261-9ce5-0ef8e0d5b096'),
	(655,2,153,NULL,2,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','2a708d76-8810-4f28-a5c8-dfbbae44785c'),
	(659,2,155,NULL,2,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','581271a6-0572-4eb2-b505-339de6babca9'),
	(663,27,157,NULL,2,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','f4d22a27-965d-4d67-bf05-49cbdbe6a1a1'),
	(664,27,157,NULL,3,2,'2020-08-18 08:40:24','2020-08-18 08:40:24','ca1d900a-73be-46b7-ab49-b110aca90a0c'),
	(665,27,157,NULL,4,3,'2020-08-18 08:40:24','2020-08-18 08:40:24','1fe4ae1e-ad66-47eb-8f07-1a55c08e8de5'),
	(666,2,158,NULL,2,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','b427ee87-eccc-4418-9c1a-c2bf830915b9'),
	(670,2,160,NULL,2,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','f25512c2-a5bd-4b38-bcb1-b209ab1229cd'),
	(674,27,162,NULL,2,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','d3935fef-5bcb-4bfe-ba3a-198cb1978022'),
	(675,27,162,NULL,3,2,'2020-08-18 08:40:24','2020-08-18 08:40:24','3a6b80cd-a25f-41a5-8fcb-7f364326f2a6'),
	(676,27,162,NULL,4,3,'2020-08-18 08:40:24','2020-08-18 08:40:24','afac5d42-a24f-4036-b4cd-ebb937b3c15d'),
	(677,2,163,NULL,2,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','e212c542-f4ba-4d5f-9f6f-728241aef5d8'),
	(681,2,165,NULL,2,1,'2020-08-18 08:40:24','2020-08-18 08:40:24','4bd17bb9-bca1-4294-9642-9666129d8e37'),
	(685,27,167,NULL,2,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','4250790b-6f67-429b-94db-f48369ddad11'),
	(686,27,167,NULL,3,2,'2020-08-18 08:40:25','2020-08-18 08:40:25','1881590e-0465-4679-8369-714cffa4ccab'),
	(687,27,167,NULL,4,3,'2020-08-18 08:40:25','2020-08-18 08:40:25','bd46a692-f82c-4fef-86de-1a5b03798552'),
	(688,2,168,NULL,2,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','fa482dd5-ad87-4684-acc2-d9a7bf44603d'),
	(692,2,170,NULL,2,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','13d18c5b-3a19-4d60-88f4-82a2de507313'),
	(696,27,172,NULL,2,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','abe8b47b-d882-457c-aec4-69895ee9741a'),
	(697,27,172,NULL,3,2,'2020-08-18 08:40:25','2020-08-18 08:40:25','72dbd7e8-f9b9-44b6-935a-6852fb283702'),
	(698,27,172,NULL,4,3,'2020-08-18 08:40:25','2020-08-18 08:40:25','89412c05-dc00-4132-b6f4-d22351ad3f8e'),
	(699,2,173,NULL,2,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','7a9d01b3-abe0-431a-8f87-ce7cb95fd550'),
	(703,2,175,NULL,2,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','db897765-cb83-479e-a0a3-5dd3511a0e19'),
	(707,27,177,NULL,2,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','7bff241d-f331-48d3-9474-7ee8af8ea38c'),
	(708,27,177,NULL,3,2,'2020-08-18 08:40:25','2020-08-18 08:40:25','2e547daf-8850-4981-99a6-ea20cde69bd2'),
	(709,27,177,NULL,4,3,'2020-08-18 08:40:25','2020-08-18 08:40:25','c418a045-6849-4e01-a478-fb3620f7087a'),
	(710,2,178,NULL,2,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','e63e67a6-1d8a-4f90-b4fb-8ec7a7a6c479'),
	(714,2,180,NULL,2,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','6c22a64c-20ee-46c5-9bca-1efe36b35444'),
	(718,27,182,NULL,2,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','95c7fa0b-3437-44ff-b53e-6ce09aa39c4b'),
	(719,27,182,NULL,3,2,'2020-08-18 08:40:25','2020-08-18 08:40:25','9f6a6c8d-83d8-4fca-8a08-bc48250376d3'),
	(720,27,182,NULL,4,3,'2020-08-18 08:40:25','2020-08-18 08:40:25','be2c75ee-4041-4488-8104-88a2d3374caf'),
	(721,2,183,NULL,2,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','157d2f20-e6a9-4869-b13d-db1d56868c71'),
	(725,2,185,NULL,2,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','1c757ae1-f7c3-43bc-90e6-9652c8f29c58'),
	(729,27,187,NULL,2,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','a22fe205-14fc-42a9-ac04-cdb88bff32b4'),
	(730,27,187,NULL,3,2,'2020-08-18 08:40:25','2020-08-18 08:40:25','6857aafa-9613-4178-a621-9d90888db1fe'),
	(731,27,187,NULL,4,3,'2020-08-18 08:40:25','2020-08-18 08:40:25','b3a988a3-ff2c-4c7e-8487-4e579cc590aa'),
	(732,2,188,NULL,2,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','65466708-a081-43b4-bb03-cc49876cb4da'),
	(736,2,190,NULL,2,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','ec1023e6-c5a6-43d1-8d7b-b8601e75c3eb'),
	(740,27,192,NULL,2,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','32f044ad-fabb-46d7-969d-5661a9049a36'),
	(741,27,192,NULL,3,2,'2020-08-18 08:40:25','2020-08-18 08:40:25','72c2a371-ebff-4391-8803-6198efa1a9eb'),
	(742,27,192,NULL,4,3,'2020-08-18 08:40:25','2020-08-18 08:40:25','8ffb3cd7-1255-4a88-84aa-0bce1987088e'),
	(743,2,193,NULL,2,1,'2020-08-18 08:40:25','2020-08-18 08:40:25','a96351bd-71d6-484c-8356-bdd5d5555b5e'),
	(747,2,195,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','b3b4a4a9-6268-4135-a80a-2246a8757bf1'),
	(751,27,197,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','dbe6bbbb-9819-42ce-af98-48ce897c4c34'),
	(752,27,197,NULL,3,2,'2020-08-18 08:40:26','2020-08-18 08:40:26','2870a6bf-1c23-478d-847b-f14de4a6476f'),
	(753,27,197,NULL,4,3,'2020-08-18 08:40:26','2020-08-18 08:40:26','ebf22104-e4e4-49d3-976b-e536ea63b78e'),
	(754,2,198,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','50264d6a-4ad8-4908-ad45-5e57eb6c6656'),
	(758,2,200,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','73270b98-35a1-4bbe-9053-28686ee7417f'),
	(762,27,202,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','005f3a83-6d80-4a07-a347-35e0e781be5c'),
	(763,2,203,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','407883e4-9941-4156-b6a4-977c432905cf'),
	(764,2,203,NULL,3,2,'2020-08-18 08:40:26','2020-08-18 08:40:26','dcc73d69-25e4-4264-b2ca-6a65e338e973'),
	(765,2,203,NULL,4,3,'2020-08-18 08:40:26','2020-08-18 08:40:26','ddd698f7-3684-4797-b984-9b70d1de11c0'),
	(766,4,204,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','4deebba6-2ee3-43b5-9fd3-cdde36bf1b9b'),
	(767,4,204,NULL,3,2,'2020-08-18 08:40:26','2020-08-18 08:40:26','0e5dabc7-9019-4991-8b66-4cfd58908610'),
	(768,4,204,NULL,4,3,'2020-08-18 08:40:26','2020-08-18 08:40:26','f1c2c46f-ae85-4fa4-963b-05c5f67d77e4'),
	(772,10,206,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','f655a5ba-7993-421c-949f-7ea99d7c4c03'),
	(773,10,206,NULL,3,2,'2020-08-18 08:40:26','2020-08-18 08:40:26','8cedacef-cd80-4396-8d9e-cbae7f5f6060'),
	(774,10,206,NULL,4,3,'2020-08-18 08:40:26','2020-08-18 08:40:26','92b2881c-b689-42ed-8b5a-30a18a324495'),
	(775,22,207,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','95526cc3-267d-442d-b6db-727ae05188cd'),
	(776,22,207,NULL,3,2,'2020-08-18 08:40:26','2020-08-18 08:40:26','02481948-5ac3-4bc1-a18f-2db53fd48d65'),
	(777,22,207,NULL,4,3,'2020-08-18 08:40:26','2020-08-18 08:40:26','656039b5-01f3-474b-96e4-bdba3cdfa45d'),
	(778,27,208,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','0be37832-a43c-45b5-9125-accff43a4482'),
	(779,27,208,NULL,3,2,'2020-08-18 08:40:26','2020-08-18 08:40:26','118b40ea-a722-4094-9249-df7bc058dd56'),
	(780,27,208,NULL,4,3,'2020-08-18 08:40:26','2020-08-18 08:40:26','11399192-a039-4849-9f41-0737b5681f2d'),
	(781,2,209,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','091a5673-b609-4837-b008-b298ad9b8553'),
	(782,2,209,NULL,3,2,'2020-08-18 08:40:26','2020-08-18 08:40:26','08c4efa9-2006-4f25-b574-267dd4941111'),
	(783,2,209,NULL,4,3,'2020-08-18 08:40:26','2020-08-18 08:40:26','765087e0-590c-41a3-b754-2b826b0ae1d6'),
	(784,29,210,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','9f783b5c-b8e2-4569-96aa-125b68f06b78'),
	(785,27,211,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','376ecec9-255f-42b6-9c80-e6174b1532e9'),
	(786,27,211,NULL,3,2,'2020-08-18 08:40:26','2020-08-18 08:40:26','ccbce5c4-fc4b-41c5-a984-9b76f23f7525'),
	(787,27,211,NULL,4,3,'2020-08-18 08:40:26','2020-08-18 08:40:26','d132081e-e918-4227-a672-1607c4d606f8'),
	(788,2,212,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','8305c990-e911-48f3-8959-e816d0609dbc'),
	(789,2,212,NULL,3,2,'2020-08-18 08:40:26','2020-08-18 08:40:26','68a5e7b4-084d-4c2a-9264-469884df161f'),
	(790,2,212,NULL,4,3,'2020-08-18 08:40:26','2020-08-18 08:40:26','695874d1-4391-4b6b-9bc6-cd1d508ffd99'),
	(791,29,213,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','c4da18dd-25ac-4df5-ac22-f5905a116339'),
	(792,2,214,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','fab11762-6317-49a7-b41c-6a3a3d4c4db4'),
	(793,2,214,NULL,3,2,'2020-08-18 08:40:26','2020-08-18 08:40:26','d803a9df-b64f-46b6-b91f-577e95f5fd9f'),
	(794,2,214,NULL,4,3,'2020-08-18 08:40:26','2020-08-18 08:40:26','f7a1fd19-d59d-4b7c-b267-45ed8dd82213'),
	(795,36,215,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','9f26ce25-b0f8-44c6-9639-302d508c0441'),
	(796,27,216,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','97435459-cd3d-47cf-a67e-c35850cfc2c3'),
	(797,27,216,NULL,3,2,'2020-08-18 08:40:26','2020-08-18 08:40:26','a7a53ce9-5800-47f2-960e-5e7ea6a9ed70'),
	(798,27,216,NULL,4,3,'2020-08-18 08:40:26','2020-08-18 08:40:26','67c836de-ad73-48b4-bdf3-41b174392984'),
	(799,2,217,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','c482ac79-99c4-46c1-8043-43e9b98e46ad'),
	(803,2,219,NULL,2,1,'2020-08-18 08:40:26','2020-08-18 08:40:26','4611d994-332c-4205-ae90-5c011e4bc074'),
	(807,2,221,NULL,2,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','6cc8e46a-363b-4c59-8a7c-bf5570be19ff'),
	(808,2,221,NULL,3,2,'2020-08-18 08:40:27','2020-08-18 08:40:27','bc3cc804-5c94-468a-a3d8-83b9feeeeafc'),
	(809,2,221,NULL,4,3,'2020-08-18 08:40:27','2020-08-18 08:40:27','67b62fd6-fa77-4031-8bd7-73d9a865c3ef'),
	(810,36,222,NULL,2,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','a3cc57e9-bbc3-4345-89b8-73056c8431c7'),
	(811,2,223,NULL,2,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','6b170040-021a-4964-b0c5-4c580c7d3a4a'),
	(812,2,223,NULL,3,2,'2020-08-18 08:40:27','2020-08-18 08:40:27','a5573390-078b-474d-a810-8f2a6e7bc73f'),
	(813,2,223,NULL,4,3,'2020-08-18 08:40:27','2020-08-18 08:40:27','34d23f9d-e706-47b9-9ddd-b3c0ae038cbe'),
	(814,36,224,NULL,2,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','bce1aa37-19e1-4d30-9011-8cefc2a5ea08'),
	(818,2,226,NULL,2,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','0afa6bc1-aeba-4ff5-80ea-b9b59e0ce461'),
	(819,2,226,NULL,3,2,'2020-08-18 08:40:27','2020-08-18 08:40:27','aa8669de-5b73-45a9-b824-d18c4a392c56'),
	(820,2,226,NULL,4,3,'2020-08-18 08:40:27','2020-08-18 08:40:27','fa158bf5-1c3c-4df5-832c-09f5e7509340'),
	(821,36,227,NULL,2,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','5d676057-b129-4369-ba13-bfc9812e376a'),
	(822,2,228,NULL,2,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','7d204c80-584c-458e-a4d3-81896681f985'),
	(823,2,228,NULL,3,2,'2020-08-18 08:40:27','2020-08-18 08:40:27','3c9c668d-e11f-4f19-ab3e-f77e25c39231'),
	(824,2,228,NULL,4,3,'2020-08-18 08:40:27','2020-08-18 08:40:27','0c490d60-ef68-4fd3-8b2c-125622e2ebc4'),
	(828,2,231,NULL,2,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','6705a489-695c-4759-8b09-6c04ac857c24'),
	(829,2,231,NULL,3,2,'2020-08-18 08:40:27','2020-08-18 08:40:27','3ef5d905-c99f-43f6-a183-47ae0da005e9'),
	(830,2,231,NULL,4,3,'2020-08-18 08:40:27','2020-08-18 08:40:27','9f981a60-af66-4577-a628-ec5258c5951c'),
	(831,2,233,NULL,2,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','cbaecd5d-e9ba-4bba-9ac7-42273e1a235b'),
	(832,2,233,NULL,3,2,'2020-08-18 08:40:27','2020-08-18 08:40:27','a2420989-1488-45cd-bc45-13c9a63e828d'),
	(833,2,233,NULL,4,3,'2020-08-18 08:40:27','2020-08-18 08:40:27','9afe77ec-ecdd-4fe2-a760-dbe2a1a9bed9'),
	(835,2,236,NULL,2,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','ee5c17ee-6e84-4283-8cf0-f242410fb93d'),
	(836,2,236,NULL,3,2,'2020-08-18 08:40:27','2020-08-18 08:40:27','cffb88f5-ab40-497a-81a0-b2e4741490aa'),
	(837,2,236,NULL,4,3,'2020-08-18 08:40:27','2020-08-18 08:40:27','b4ab7436-37eb-4a6f-9d89-353c71f5ed0a'),
	(838,4,237,NULL,2,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','db8bed1d-c210-4c70-9ec9-3bc809ed5e4c'),
	(839,4,237,NULL,3,2,'2020-08-18 08:40:27','2020-08-18 08:40:27','2c0f1224-72ab-4d1c-bad7-5a5905850216'),
	(840,4,237,NULL,4,3,'2020-08-18 08:40:27','2020-08-18 08:40:27','05c519e6-f399-496b-b24a-10ee1be343f0'),
	(844,10,239,NULL,2,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','2ea09dd5-0ea1-4feb-821e-0f0db4770cc9'),
	(845,10,239,NULL,3,2,'2020-08-18 08:40:27','2020-08-18 08:40:27','4226d4a6-9c22-4e5f-add7-8e0f1a4ad987'),
	(846,10,239,NULL,4,3,'2020-08-18 08:40:27','2020-08-18 08:40:27','71f34a3b-f77c-407e-b468-0b0f93fba150'),
	(847,22,240,NULL,2,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','c2e03118-c808-4651-aadf-96f2f5dee4d0'),
	(848,22,240,NULL,3,2,'2020-08-18 08:40:27','2020-08-18 08:40:27','f3829c55-7be8-48ee-89e7-5d712127f16a'),
	(849,22,240,NULL,4,3,'2020-08-18 08:40:27','2020-08-18 08:40:27','1f482328-f837-43ee-a28b-513f44fdb9aa'),
	(850,2,241,NULL,2,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','0280694c-dad4-4ffe-b3b6-7a12f75c366b'),
	(851,2,241,NULL,3,2,'2020-08-18 08:40:27','2020-08-18 08:40:27','f49b5b1a-8045-4165-9c5f-714ceb474226'),
	(852,2,241,NULL,4,3,'2020-08-18 08:40:27','2020-08-18 08:40:27','34e30a8f-0b48-4334-a7b3-ee7192f93bb0'),
	(853,4,242,NULL,2,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','70b61420-3b6a-4024-87ea-f8a888c9a76a'),
	(854,4,242,NULL,3,2,'2020-08-18 08:40:27','2020-08-18 08:40:27','3d285ce3-525f-4fb4-b377-f045a84a2230'),
	(855,4,242,NULL,4,3,'2020-08-18 08:40:27','2020-08-18 08:40:27','7ac2aa75-e5d6-4341-87e4-fb3bb9210a84'),
	(859,22,244,NULL,2,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','a29e70e9-bc58-4662-8691-ad8a94bf474b'),
	(860,22,244,NULL,3,2,'2020-08-18 08:40:27','2020-08-18 08:40:27','1028c177-b7f4-4a54-b571-de3c11881e2c'),
	(861,22,244,NULL,4,3,'2020-08-18 08:40:27','2020-08-18 08:40:27','c2c8e0ef-fc62-4b7a-a235-d3d41877c077'),
	(865,2,246,NULL,2,1,'2020-08-18 08:40:27','2020-08-18 08:40:27','35e0f9d4-a741-4fff-8abc-02a636b1995a'),
	(866,2,246,NULL,3,2,'2020-08-18 08:40:27','2020-08-18 08:40:27','9e836970-b86f-4a27-ad9b-92e443778684'),
	(867,2,246,NULL,4,3,'2020-08-18 08:40:27','2020-08-18 08:40:27','1a850603-f815-44d3-8d8b-86302c5468cb'),
	(868,2,248,NULL,2,1,'2020-08-18 08:40:28','2020-08-18 08:40:28','45692e29-d11c-4bfb-a941-457dad912e38'),
	(869,2,248,NULL,3,2,'2020-08-18 08:40:28','2020-08-18 08:40:28','def6c784-5312-4fa7-80d8-7288c56c27b3'),
	(870,2,248,NULL,4,3,'2020-08-18 08:40:28','2020-08-18 08:40:28','d24d20a2-095e-40c2-95bd-a49f0613ab68'),
	(871,27,249,NULL,2,1,'2020-08-18 08:40:28','2020-08-18 08:40:28','ebedfb99-7c29-43b5-93b2-b90aa3916b0e'),
	(872,27,249,NULL,3,2,'2020-08-18 08:40:28','2020-08-18 08:40:28','a5017993-73fa-4168-8153-46e9c695c7f3'),
	(873,27,249,NULL,4,3,'2020-08-18 08:40:28','2020-08-18 08:40:28','5617ae46-b287-4e38-ab50-5d9bc6c65811'),
	(874,2,250,NULL,2,1,'2020-08-18 08:40:28','2020-08-18 08:40:28','f1d4c08f-ad7b-4d24-94b8-9051f1813305'),
	(875,2,251,NULL,2,1,'2020-08-18 08:40:28','2020-08-18 08:40:28','53c43696-02f3-4fbc-bd20-fab32cbba4aa'),
	(876,27,252,NULL,2,1,'2020-08-18 08:40:28','2020-08-18 08:40:28','d96a5507-fabd-4916-b1b3-de789e5f9107'),
	(877,27,252,NULL,3,2,'2020-08-18 08:40:28','2020-08-18 08:40:28','2b3c8463-30df-40ca-8491-ca53b885be57'),
	(878,27,252,NULL,4,3,'2020-08-18 08:40:28','2020-08-18 08:40:28','9fe4a8aa-7b73-4c17-bd75-b01770ef54ff'),
	(879,2,253,NULL,2,1,'2020-08-18 08:40:28','2020-08-18 08:40:28','7a5fd721-ad7b-4883-88a2-55e882db8edb'),
	(880,2,254,NULL,2,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','209022d2-7327-4940-9adf-c98becf1712c'),
	(881,2,254,NULL,3,2,'2021-02-16 16:48:35','2021-02-16 16:48:35','7948ea2e-ff65-41c9-9ae1-2e71a62b3623'),
	(882,2,254,NULL,4,3,'2021-02-16 16:48:35','2021-02-16 16:48:35','adbef33a-6b11-4764-8f5d-7538b83b75b2'),
	(883,27,255,NULL,2,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','d9096403-e4be-4113-9f95-aa2423b2bae7'),
	(884,27,255,NULL,3,2,'2021-02-16 16:48:35','2021-02-16 16:48:35','461993e4-2b79-4e0d-b150-e0fc8a08c369'),
	(885,27,255,NULL,4,3,'2021-02-16 16:48:35','2021-02-16 16:48:35','10efa216-4e3e-4597-9245-40cc8e58ae79'),
	(886,64,256,NULL,2,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','d6216bd3-608c-4f4a-a702-11e1c5b2a44b'),
	(887,64,256,NULL,3,2,'2021-02-16 16:48:35','2021-02-16 16:48:35','2b7f002b-c106-4a67-b012-af0f0cc5d34f'),
	(888,2,257,NULL,2,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','e7816848-4663-4a70-a394-42e0731258ca'),
	(889,2,257,NULL,3,2,'2021-02-16 16:48:35','2021-02-16 16:48:35','e14ac9ae-9981-4273-85f6-dfb3d1d4e25c'),
	(890,2,257,NULL,4,3,'2021-02-16 16:48:35','2021-02-16 16:48:35','62f8ba45-20d6-4993-b735-a8dd56053b7c'),
	(891,36,258,NULL,2,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','5946f9c2-5d92-4799-918d-8323710ebbe8'),
	(892,36,258,NULL,3,2,'2021-02-16 16:48:35','2021-02-16 16:48:35','0858316a-7ab2-47d3-a64f-82dd3db96964'),
	(893,36,258,NULL,4,3,'2021-02-16 16:48:35','2021-02-16 16:48:35','5976e2af-0f1d-477e-8265-3c61e2b09b9b'),
	(894,64,259,NULL,2,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','a9ecbf27-f0ef-497a-a3e5-f0ed59dbf975'),
	(895,64,259,NULL,3,2,'2021-02-16 16:48:35','2021-02-16 16:48:35','f0d1fa11-78d2-4ee6-b34e-9d0e2229d1b5'),
	(896,2,260,NULL,2,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','271a36ac-4fd8-44dc-9288-179b97a51c76'),
	(897,2,260,NULL,3,2,'2021-02-16 16:48:35','2021-02-16 16:48:35','a3543474-cc01-4090-9b63-d1a1e80ebd0d'),
	(898,10,261,NULL,2,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','1068cb25-fa3f-418b-a66d-d21518463cdd'),
	(899,10,261,NULL,3,2,'2021-02-16 16:48:35','2021-02-16 16:48:35','00072f04-7509-46b9-ab27-620cf571ec67'),
	(900,2,262,NULL,2,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','8d93cfe8-122a-4fb5-82a2-a5dbbe34b189'),
	(901,2,262,NULL,3,2,'2021-02-16 16:48:35','2021-02-16 16:48:35','2b900e6b-ef6c-4dfa-a6e4-69a520b9bf91'),
	(902,2,262,NULL,4,3,'2021-02-16 16:48:35','2021-02-16 16:48:35','cd45cf4d-83c7-4443-a06b-03c9526a0f34'),
	(903,10,263,NULL,2,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','0fddc910-41ae-4f44-8fef-e503f01333fb'),
	(904,10,263,NULL,3,2,'2021-02-16 16:48:35','2021-02-16 16:48:35','69d18ad7-0b9b-4ad0-a83a-0dddf961b116'),
	(905,40,264,NULL,2,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','f59facf4-8d82-45cd-a116-dee8a0017301'),
	(906,40,264,NULL,3,2,'2021-02-16 16:48:35','2021-02-16 16:48:35','830a5261-ffea-488f-bdda-3fd43d25d091'),
	(907,40,264,NULL,4,3,'2021-02-16 16:48:35','2021-02-16 16:48:35','77101d1e-3cd0-489e-93f8-fd955fbfb6ec'),
	(908,73,265,NULL,2,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','89a92d04-6413-4b85-90c9-bb4d8e2f2ac6'),
	(909,73,265,NULL,3,2,'2021-02-16 16:48:35','2021-02-16 16:48:35','43ccdd1f-7b8f-42fc-a016-7fb892d6a288'),
	(910,73,265,NULL,4,3,'2021-02-16 16:48:35','2021-02-16 16:48:35','4c9a77af-264e-4fb0-b152-cce94e5af28e'),
	(911,74,265,NULL,24,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','76ab8e30-15bc-49c3-ab25-f11561e7c905');

/*!40000 ALTER TABLE `cc1_relations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_resourcepaths
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_resourcepaths`;

CREATE TABLE `cc1_resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_resourcepaths` WRITE;
/*!40000 ALTER TABLE `cc1_resourcepaths` DISABLE KEYS */;

INSERT INTO `cc1_resourcepaths` (`hash`, `path`)
VALUES
	('1038043','@craft/web/assets/craftsupport/dist'),
	('1055b7d3','@craft/web/assets/fields/dist'),
	('105ebcd5','@lib/selectize'),
	('1087b3e1','@craft/web/assets/axios/dist'),
	('10c11f0c','@app/web/assets/jqueryui/dist'),
	('10f04449','@lib/garnishjs'),
	('116917f9','@craft/web/assets/recententries/dist'),
	('11ffdadd','@lib/timepicker'),
	('120d0970','@app/web/assets/login/dist'),
	('127e37fe','@app/web/assets/deprecationerrors/dist'),
	('12ac4a53','@bower/jquery/dist'),
	('13d4c686','@app/web/assets/craftsupport/dist'),
	('13e225fb','@app/web/assets/dashboard/dist'),
	('13fd02ff','@lib/fileupload'),
	('14850bb5','@app/web/assets/fields/dist'),
	('14db4e9','@app/web/assets/jquerytouchevents/dist'),
	('15fe1c5c','@craft/web/assets/recententries/dist'),
	('16331c0e','@app/web/assets/cp/dist'),
	('16f4d2a3','@app/web/assets/sites/dist'),
	('1703d68e','@lib/element-resize-detector'),
	('17a8372a','@app/web/assets/generalsettings/dist'),
	('18ad7b2b','@craft/redactor/assets/redactor/dist'),
	('19f9e228','@app/web/assets/matrixsettings/dist'),
	('1a32f85f','@lib/xregexp'),
	('1b1dc067','@app/web/assets/axios/dist'),
	('1b3e2759','@app/web/assets/findreplace/dist'),
	('1b5698e7','@lib/jquery-ui'),
	('1be097e2','@lib/element-resize-detector'),
	('1beda1d7','@craft/web/assets/matrixsettings/dist'),
	('1c3d5a03','@craft/web/assets/updater/dist'),
	('1d3c73fa','@craft/web/assets/dashboard/dist'),
	('1d466a47','@app/web/assets/updateswidget/dist'),
	('1d91278a','@app/web/assets/focusvisible/dist'),
	('1d991c5d','@app/web/assets/pluginstore/dist'),
	('1f0412c6','@lib/jquery.payment'),
	('1f5e3de8','@lib/iframe-resizer'),
	('1fba6037','@app/web/assets/cp/dist'),
	('2039bb2d','@app/web/assets/dashboard/dist'),
	('20fb3ed8','@app/web/assets/cp/dist'),
	('234be0e8','@lib/fabric'),
	('23fc2829','@app/web/assets/recententries/dist'),
	('246cc622','@lib/selectize'),
	('24c52ba6','@app/web/assets/login/dist'),
	('24f9a3f8','@craft/web/assets/iframeresizer/dist'),
	('2503fc22','@app/web/assets/feed/dist'),
	('25563495','@app/web/assets/updateswidget/dist'),
	('25586dfb','@lib/selectize'),
	('255ded34','@craft/web/assets/installer/dist'),
	('25cda02a','@lib/timepicker'),
	('25ffcb6a','@lib/velocity'),
	('270d8c46','@craft/web/assets/feed/dist'),
	('2749fa78','@lib/axios'),
	('275269a2','@app/web/assets/utilities/dist'),
	('28ca45d5','@lib/prismjs'),
	('28de2a8a','@lib/jquery-ui'),
	('291c8a06','@lib/velocity'),
	('29904aa1','@app/web/assets/picturefill/dist'),
	('2a4c4f5c','@lib/jquery-touch-events'),
	('2a868bab','@lib'),
	('2b445e32','@craft/web/assets/updateswidget/dist'),
	('2bc49854','@app/web/assets/craftsupport/dist'),
	('2caaaad8','@app/web/assets/dbbackup/dist'),
	('2cb6bd47','@craft/web/assets/cp/dist'),
	('2d7e37f7','@vendor/craftcms/redactor/lib/redactor'),
	('2d9eba31','@lib/jquery-ui'),
	('2de8739e','@lib/picturefill'),
	('2e0082a8','@lib/xregexp'),
	('2e9bc3b4','@lib/fabric'),
	('2ece608b','@app/web/assets/xregexp/dist'),
	('2f342971','@lib/xregexp'),
	('2f747ba','@app/web/assets/recententries/dist'),
	('2fd35597','@craft/web/assets/updateswidget/dist'),
	('30c5b3b','@app/web/assets/updateswidget/dist'),
	('31f765cf','@craft/redactor/assets/redactor/dist'),
	('323bd2e','@lib/velocity'),
	('3334068b','@vendor/craftcms/redactor/lib/redactor'),
	('3344e7fb','@app/web/assets/editentry/dist'),
	('3353bf68','@app/web/assets/utilities/dist'),
	('34703c17','@bower/jquery/dist'),
	('35007260','@lib/fileupload'),
	('350366aa','@app/web/assets/updater/dist'),
	('353b25ee','@lib/jquery.payment'),
	('35c479ed','@app/web/assets/updateswidget/dist'),
	('360d34d6','@lib/garnishjs'),
	('36839b0e','@craft/web/assets/d3/dist'),
	('37563f9d','@craft/web/assets/focusvisible/dist'),
	('3841b7de','@craft/web/assets/pluginstore/dist'),
	('384b3186','@bower/bootstrap/dist'),
	('38937d7b','@bower/jquery/dist'),
	('38b679a9','@craft/web/assets/matrix/dist'),
	('39d86482','@lib/jquery.payment'),
	('39e52e4e','@craft/web/assets/selectize/dist'),
	('3a79d137','@app/web/assets/tablesettings/dist'),
	('3a8f1ada','@app/web/assets/login/dist'),
	('3aa977b9','@craft/web/assets/plugins/dist'),
	('3b56d52c','@app/web/assets/craftsupport/dist'),
	('3b703b28','@craft/web/assets/generalsettings/dist'),
	('3c66c5cf','@app/web/assets/matrix/dist'),
	('3cd6bc7b','@craft/web/assets/pluginstore/dist'),
	('3d3ce1a6','@lib/element-resize-detector'),
	('3db61955','@app/web/assets/recententries/dist'),
	('3df61ded','@craft/web/assets/updates/dist'),
	('3e01515b','@app/web/assets/jquerypayment/dist'),
	('3e63f50d','@app/web/assets/utilities/dist'),
	('3eb10fa4','@app/web/assets/cp/dist'),
	('3fc4745c','@app/web/assets/updates/dist'),
	('3fdf1496','@app/web/assets/elementresizedetector/dist'),
	('40e5ecaa','@craft/web/assets/utilities/dist'),
	('41559011','@app/web/assets/recententries/dist'),
	('418449e1','@craft/web/assets/matrixsettings/dist'),
	('422e651c','@app/web/assets/userpermissions/dist'),
	('42807c49','@app/web/assets/utilities/dist'),
	('435e7c4d','@app/web/assets/updates/dist'),
	('4384ad93','@lib/jquery-touch-events'),
	('44209151','@lib/picturefill'),
	('4470f43f','@bower/jquery/dist'),
	('44b41e3f','@lib/jquery-touch-events'),
	('45292b33','@app/web/assets/cp/dist'),
	('4549a9fe','@craft/web/assets/edituser/dist'),
	('4720fab7','@app/web/assets/pluginstore/dist'),
	('47559bcc','@craft/web/assets/dashboard/dist'),
	('47aa441a','@app/web/assets/feed/dist'),
	('47dde5d1','@lib/velocity'),
	('48b6674a','@supercool/tablemaker/assetbundles/field/dist'),
	('491f2665','@app/web/assets/velocity/dist'),
	('49266c3','@app/web/assets/vue/dist'),
	('49d8acaa','@lib/jquery.payment'),
	('4a77eef9','@craft/web/assets/login/dist'),
	('4a85b100','@lib/d3'),
	('4baa1216','@app/web/assets/tablesettings/dist'),
	('4bb5323e','@lib/velocity'),
	('4c0542e5','@lib/timepicker'),
	('4c39174a','@vendor/craftcms/redactor/lib/redactor'),
	('4c3e77a8','@lib/garnishjs'),
	('4d0adc71','@lib/garnishjs'),
	('4d44067e','@verbb/base/resources/dist'),
	('4d8a268b','@lib/jquery-ui'),
	('4e6e9b0b','@craft/redactor/assets/field/dist'),
	('5024aa77','@craft/redactor/assets/field/dist'),
	('5044a65e','@app/web/assets/dbbackup/dist'),
	('5097c949','@app/web/assets/prismjs/dist'),
	('5128fdf9','@app/web/assets/cp/dist'),
	('51ca99b','@lib/jquery-ui'),
	('52ac23e8','@app/web/assets/fields/dist'),
	('52eb942b','@craft/web/assets/fields/dist'),
	('532df396','@app/web/assets/updates/dist'),
	('54571fa3','@app/web/assets/deprecationerrors/dist'),
	('55076a0f','@lib/xregexp'),
	('55cb0da6','@app/web/assets/dashboard/dist'),
	('55e0236a','@app/web/assets/tablesettings/dist'),
	('55ff0342','@lib/velocity'),
	('565212ac','@bower/jquery/dist'),
	('576b7fe6','@app/web/assets/matrixsettings/dist'),
	('577415f2','@app/web/assets/dbbackup/dist'),
	('57929dd6','@lib/jquery.payment'),
	('57c715e5','@craft/web/assets/garnish/dist'),
	('5826a2e2','@app/web/assets/login/dist'),
	('584c084f','@lib/fabric'),
	('5868eda7','@lib/element-resize-detector'),
	('5978a396','@lib/fabric'),
	('59e07566','@app/web/assets/feed/dist'),
	('5a3ac543','@bower/jquery/dist'),
	('5b02350','@lib/d3'),
	('5b6a6875','@craft/web/assets/craftsupport/dist'),
	('5b953f4f','@bower/yii2-pjax'),
	('5bf82303','@lib/fileupload'),
	('5bfa4a39','@lib/jquery.payment'),
	('5c18b79c','@app/web/assets/cp/dist'),
	('5cc890af','@lib/fileupload'),
	('5cca4d35','@app/web/assets/utilities/dist'),
	('5d287d1c','@lib/element-resize-detector'),
	('5ee203df','@app/web/assets/matrixsettings/dist'),
	('5f6b2e85','@lib/selectize'),
	('60c09f8f','@craft/web/assets/plugins/dist'),
	('628aca25','@app/web/assets/updater/dist'),
	('62beafd5','@app/web/assets/fabric/dist'),
	('62f2f63e','@app/web/assets/plugins/dist'),
	('63136b10','@craft/web/assets/matrix/dist'),
	('63372194','@lib/velocity'),
	('6354dcd3','@app/web/assets/matrix/dist'),
	('63e2171f','@craft/web/assets/tablesettings/dist'),
	('63e4a567','@craft/web/assets/pluginstore/dist'),
	('63ee233f','@bower/bootstrap/dist'),
	('6459d54f','@lib/iframe-resizer'),
	('647f5531','@craft/web/assets/feed/dist'),
	('64da13e7','@app/web/assets/utilities/dist'),
	('656d7e96','@lib/iframe-resizer'),
	('666e13b3','@craft/web/assets/fabric/dist'),
	('6677b12f','@lib/velocity'),
	('66a12b89','@app/web/assets/feed/dist'),
	('67b511a3','@lib/jquery-ui'),
	('682a2109','@app/web/assets/matrixsettings/dist'),
	('68faea58','@lib/fileupload'),
	('69a76923','@craft/web/assets/userpermissions/dist'),
	('6a838285','@app/web/assets/dbbackup/dist'),
	('6a952c27','@yii/debug/assets'),
	('6af8327a','@lib/timepicker'),
	('6b5650cf','@lib/jquery-ui'),
	('6be05fca','@lib/element-resize-detector'),
	('6c7e72b8','@lib/fabric'),
	('6da7ada6','@verbb/fieldmanager/resources/dist'),
	('6df07db8','@app/web/assets/tablesettings/dist'),
	('6f0c297d','@app/web/assets/dashboard/dist'),
	('6f2857b0','@app/web/assets/feed/dist'),
	('6f5fb4cc','@craft/web/assets/utilities/dist'),
	('6fba8040','@app/web/assets/updater/dist'),
	('7012eba6','@lib/picturefill'),
	('7126407f','@lib/picturefill'),
	('717d7ebe','@app/web/assets/craftsupport/dist'),
	('72b8d6e9','@bower/jquery/dist'),
	('7384a45b','@craft/web/assets/cp/dist'),
	('73fa1a90','@lib/xregexp'),
	('74485e9f','@app/web/assets/utilities/dist'),
	('74cf9ccf','@vendor/yiisoft/yii2/assets'),
	('7530dded','@lib/prismjs'),
	('756dcfa6','@app/web/assets/editentry/dist'),
	('75aa6eb6','@lib/element-resize-detector'),
	('76601075','@app/web/assets/matrixsettings/dist'),
	('768b1cef','@app/web/assets/updater/dist'),
	('77069361','@craft/web/assets/tablesettings/dist'),
	('7763e215','@lib'),
	('77b6d764','@lib/jquery-touch-events'),
	('77f84652','@bower/jquery/dist'),
	('78a6b9dd','@craft/redactor/assets/field/dist'),
	('78d67530','@craft/web/assets/deprecationerrors/dist'),
	('78ed34ba','@app/web/assets/systemmessages/dist'),
	('7938a686','@lib/garnishjs'),
	('79965e1a','@lib/selectize'),
	('79c2b959','@lib/element-resize-detector'),
	('7a1d5569','@app/web/assets/sites/dist'),
	('7a501ec7','@lib/jquery.payment'),
	('7d6230c0','@app/web/assets/tablesettings/dist'),
	('7eb7cbf7','@lib/d3'),
	('7f108e7c','@lib/jquery.payment'),
	('7f2c3b17','@craft/web/assets/utilities/dist'),
	('7f83602e','@lib/d3'),
	('7f9cbb43','@app/web/assets/fieldsettings/dist'),
	('7faf865f','@verbb/fieldmanager/resources/dist'),
	('7fefd27f','@app/web/assets/updateswidget/dist'),
	('80791453','@craft/web/assets/login/dist'),
	('80e836a1','@app/web/assets/updates/dist'),
	('810e0565','@craft/web/assets/recententries/dist'),
	('814fb7f0','@app/web/assets/utilities/dist'),
	('8164ae13','@app/web/assets/craftsupport/dist'),
	('81a3c95a','@craft/web/assets/picturefill/dist'),
	('82e3dafd','@app/web/assets/recententries/dist'),
	('82eed440','@lib/selectize'),
	('8490d06b','@yii/debug/assets'),
	('84a258c5','@lib/vue'),
	('84ea4725','@lib/xregexp'),
	('85c23747','@lib/garnishjs'),
	('860000c','@lib/d3'),
	('8654114b','@bower/bootstrap/dist'),
	('86ee772a','@lib/fileupload'),
	('87bf3f86','@bower/jquery/dist'),
	('888290ca','@lib/xregexp'),
	('8921762b','@lib/garnishjs'),
	('899fd238','@lib/fabric'),
	('89e0cf65','@craft/web/assets/searchindexes/dist'),
	('8a176713','@lib/jquery.payment'),
	('8a1b745a','@craft/web/assets/xregexp/dist'),
	('8be367d5','@app/web/assets/login/dist'),
	('8bfb9612','@app/web/assets/admintable/dist'),
	('8cf365a3','@app/web/assets/d3/dist'),
	('8d9de7d','@craft/web/assets/updater/dist'),
	('8da150b2','@craft/redactor/assets/field/dist'),
	('8dd87cc4','@app/web/assets/updates/dist'),
	('8e8603af','@lib/selectize'),
	('8ed14261','@craft/web/assets/matrixsettings/dist'),
	('8ff602d2','@app/web/assets/updateswidget/dist'),
	('905378e','@craft/web/assets/login/dist'),
	('909c72a2','@lib/jquery-ui'),
	('90a35685','@lib/d3'),
	('916492df','@craft/web/assets/craftsupport/dist'),
	('91d6727b','@craft/web/assets/updater/dist'),
	('92629db2','@supercool/tablemaker/assetbundles/field/dist'),
	('92905526','@app/web/assets/recententries/dist'),
	('93b9a1b0','@app/web/assets/deprecationerrors/dist'),
	('94e53f80','@app/web/assets/pluginstore/dist'),
	('9532f13b','@app/web/assets/edituser/dist'),
	('95339d8f','@supercool/tablemaker/assetbundles/field/dist'),
	('95429dfb','@app/web/assets/fields/dist'),
	('9557cb0c','@craft/web/assets/findreplace/dist'),
	('95f3997a','@craft/web/assets/craftsupport/dist'),
	('9630c8fb','@lib/velocity'),
	('96c643ea','@app/web/assets/cp/dist'),
	('96c8a1b6','@lib/xregexp'),
	('97200ff1','@app/web/assets/editcategory/dist'),
	('9747e74','@lib/jquery-ui'),
	('97acc10e','@lib/jquery-ui'),
	('97bf0358','@verbb/fieldmanager/resources/dist'),
	('97f28b7c','@verbb/base/resources/dist'),
	('983e7466','@app/web/assets/matrixsettings/dist'),
	('99688ee1','@lib'),
	('99a24a16','@lib/jquery-touch-events'),
	('99d9aa0e','@app/web/assets/updates/dist'),
	('9a2fbedf','@app/web/assets/feed/dist'),
	('9a4b32eb','@lib/axios'),
	('9b526ec3','@app/web/assets/generalsettings/dist'),
	('9bf3b5d3','@craft/web/assets/dbbackup/dist'),
	('9c67a215','@lib/fabric'),
	('9c8ed9a9','@app/web/assets/queuemanager/dist'),
	('9ca4e53c','@lib/selectize'),
	('9e0676d4','@lib/picturefill'),
	('9e20656','@app/web/assets/generalsettings/dist'),
	('9f15f9d0','@app/web/assets/dashboard/dist'),
	('9f792d','@app/web/assets/editentry/dist'),
	('9fffdb15','@lib/timepicker'),
	('a0008360','@lib/xregexp'),
	('a032016e','@lib/fileupload'),
	('a1424f19','@bower/jquery/dist'),
	('a31e4103','@lib/garnishjs'),
	('a39ebbf9','@lib/jquery-ui'),
	('a4fb4e56','@craft/redactor/assets/field/dist'),
	('a54013db','@lib/xregexp'),
	('a5514e66','@craft/web/assets/utilities/dist'),
	('a5ca9e9a','@craft/web/assets/cp/dist'),
	('a5ffb72f','@lib/element-resize-detector'),
	('a6af764a','@craft/web/assets/updateswidget/dist'),
	('a700e127','@app/web/assets/iframeresizer/dist'),
	('a82f9473','@lib/element-resize-detector'),
	('a83f724f','@app/web/assets/login/dist'),
	('a8b6c54c','@craft/web/assets/installer/dist'),
	('a8fc0201','@vendor/yiisoft/yii2/assets'),
	('a937f9c3','@lib/timepicker'),
	('a949fbb0','@lib/axios'),
	('a9f42009','@app/web/assets/feed/dist'),
	('aa2590d','@lib/vue'),
	('aa6cc7ea','@lib/selectize'),
	('aae6a43e','@craft/web/assets/feed/dist'),
	('ab31d49d','@app/web/assets/cp/dist'),
	('ac016731','@app/web/assets/cp/dist'),
	('ac2a1748','@app/web/assets/updateswidget/dist'),
	('ac4fc968','@craft/web/assets/vue/dist'),
	('acd14002','@lib/fileupload'),
	('acea178c','@lib/jquery.payment'),
	('ad7be610','@craft/web/assets/tablesettings/dist'),
	('ae596e80','@craft/web/assets/plugins/dist'),
	('ae71af9b','@craft/web/assets/feed/dist'),
	('af2c5751','@lib/selectize'),
	('b0cdb864','@lib/velocity'),
	('b0ec9f6','@app/web/assets/admintable/dist'),
	('b14c40bc','@app/web/assets/recententries/dist'),
	('b150301','@lib/picturefill'),
	('b1bd630d','@craft/web/assets/editentry/dist'),
	('b28d611d','@app/web/assets/fileupload/dist'),
	('b39d7d3e','@lib/jquery-touch-events'),
	('b43941fc','@lib/picturefill'),
	('b5aa9fa6','@craft/web/assets/pluginstore/dist'),
	('b658953d','@lib/fabric'),
	('b67f20c1','@lib/d3'),
	('b69b1350','@craft/web/assets/generalsettings/dist'),
	('b77dc8bf','@lib/timepicker'),
	('b7e3b83','@app/web/assets/recententries/dist'),
	('b86f1133','@craft/web/assets/velocity/dist'),
	('b8720550','@app/web/assets/fieldsettings/dist'),
	('b8da0090','@lib/picturefill'),
	('b94a74f','@craft/web/assets/dbbackup/dist'),
	('b9bc83','@lib'),
	('ba9c61ad','@lib/d3'),
	('bb151f50','@lib/timepicker'),
	('bb1caab8','@app/web/assets/selectize/dist'),
	('bb89dc45','@craft/web/assets/sites/dist'),
	('bba38ac8','@app/web/assets/craftsupport/dist'),
	('bc599893','@app/web/assets/updateswidget/dist'),
	('bc7f4577','@app/web/assets/updater/dist'),
	('bdabcce6','@craft/web/assets/jquerytouchevents/dist'),
	('bdf81384','@craft/web/assets/jquerypayment/dist'),
	('bf7e3c52','@lib/jquery-touch-events'),
	('c0141fda','@lib/xregexp'),
	('c0c39082','@app/web/assets/updateswidget/dist'),
	('c1677d8','@verbb/fieldmanager/resources/dist'),
	('c2102fd5','@lib/fileupload'),
	('c2cb3174','@app/web/assets/fields/dist'),
	('c2f4cecb','@app/web/assets/dbbackup/dist'),
	('c30addb9','@lib/garnishjs'),
	('c350b294','@app/web/assets/editentry/dist'),
	('c522f543','@lib/jquery.payment'),
	('c5ac1f3a','@app/web/assets/dashboard/dist'),
	('c5afdef','@lib'),
	('c64a4d02','@lib/garnishjs'),
	('c67fe8e9','@lib/d3'),
	('c70c6d7a','@app/web/assets/matrixsettings/dist'),
	('c7504bff','@app/web/assets/tablesettings/dist'),
	('c88aadd6','@bower/jquery/dist'),
	('c8a28186','@craft/web/assets/edituser/dist'),
	('c8dac8b8','@lib/picturefill'),
	('c94a960c','@app/web/assets/utilities/dist'),
	('c9f45af6','@app/web/assets/cp/dist'),
	('ca785b50','@lib/selectize'),
	('cb13fc3','@lib/jquery-touch-events'),
	('cb712866','@app/web/assets/sites/dist'),
	('cbd7269c','@app/web/assets/pluginstore/dist'),
	('cc148bf2','@verbb/fieldmanager/resources/dist'),
	('cc7290a0','@app/web/assets/matrix/dist'),
	('cdf8fef3','@lib/prismjs'),
	('ce513c43','@app/web/assets/craftsupport/dist'),
	('ce78f83a','@lib/fileupload'),
	('ce7a25a0','@app/web/assets/utilities/dist'),
	('cea74c41','@bower/yii2-pjax'),
	('cf7ef47a','@lib/jquery-touch-events'),
	('d032c946','@lib/fileupload'),
	('d096c2bd','@app/web/assets/updater/dist'),
	('d0eefea6','@app/web/assets/plugins/dist'),
	('d134c506','@lib/jquery-touch-events'),
	('d21cd70d','@lib/element-resize-detector'),
	('d238a1dc','@app/web/assets/matrix/dist'),
	('d24e1317','@lib/axios'),
	('d25eba8e','@verbb/fieldmanager/resources/dist'),
	('d2a4ab0c','@craft/web/assets/updater/dist'),
	('d30c993c','@lib/fabric'),
	('d3287cd4','@lib/element-resize-detector'),
	('d3a582f5','@craft/web/assets/dashboard/dist'),
	('d3b2cf8f','@lib/prismjs'),
	('d45d0e7a','@lib/d3'),
	('d467fc93','@app/web/assets/generalsettings/dist'),
	('d4d17ec9','@app/web/assets/login/dist'),
	('d51a2c8f','@app/web/assets/feed/dist'),
	('d53e5242','@app/web/assets/dashboard/dist'),
	('d57450d8','@craft/web/assets/matrixsettings/dist'),
	('d5fb46a4','@app/web/assets/admintable/dist'),
	('d64c0987','@lib/fabric'),
	('d690f9c4','@lib/picturefill'),
	('d6a0fada','@verbb/fieldmanager/resources/dist'),
	('d7328950','@craft/web/assets/dashboard/dist'),
	('d7832464','@supercool/tablemaker/assetbundles/field/dist'),
	('d835d995','@lib/d3'),
	('d899535e','@lib/jquery-ui'),
	('d8ae634a','@app/web/assets/clearcaches/dist'),
	('d9055aab','@lib/velocity'),
	('d93731eb','@lib/timepicker'),
	('d9ef7fa','@app/web/assets/craftsupport/dist'),
	('da8d974b','@app/web/assets/timepicker/dist'),
	('daf82e2b','@lib/picturefill'),
	('db67ed53','@craft/web/assets/recententries/dist'),
	('dcbeffb7','@app/web/assets/dbbackup/dist'),
	('dd1a83e8','@app/web/assets/editentry/dist'),
	('dd5c12e9','@lib/jquery-touch-events'),
	('dfda1860','@lib/prismjs'),
	('e0476c78','@lib/selectize'),
	('e0842b51','@lib/fabric'),
	('e1b1285a','@craft/web/assets/jqueryui/dist'),
	('e1e03473','@craft/web/assets/sites/dist'),
	('e2e78fda','@craft/redactor/assets/field/dist'),
	('e334f561','@app/web/assets/cp/dist'),
	('e37354a','@lib/prismjs'),
	('e3ba7b2b','@lib/fileupload'),
	('e3f67094','@app/web/assets/dashboard/dist'),
	('e4915eda','@app/web/assets/fields/dist'),
	('e4d078e0','@app/web/assets/matrixsettings/dist'),
	('e5ddaf3d','@craft/web/assets/updateswidget/dist'),
	('e6239711','@craft/web/assets/utilities/dist'),
	('e6b847ed','@craft/web/assets/cp/dist'),
	('e6c8699e','@lib/xregexp'),
	('e6d1cfb0','@craft/web/assets/fileupload/dist'),
	('e6faeb90','@lib/fileupload'),
	('e70ae01f','@app/web/assets/login/dist'),
	('e71a0623','@lib/element-resize-detector'),
	('e78b689c','@craft/web/assets/updates/dist'),
	('e7bc6245','@app/web/assets/generalsettings/dist'),
	('e7e019fc','@lib/garnishjs'),
	('ea0665a8','@supercool/tablemaker/assetbundles/field/dist'),
	('ea2b28f2','@lib/xregexp'),
	('ea59d487','@lib/iframe-resizer'),
	('ea76dd61','@app/web/assets/dbbackup/dist'),
	('eb56b84c','@bower/jquery/dist'),
	('eb88ce13','@lib/garnishjs'),
	('ec038b85','@lib/velocity'),
	('ec266c09','@craft/web/assets/deprecationerrors/dist'),
	('eca42d14','@lib/selectize'),
	('ed37205c','@lib/velocity'),
	('eda6303a','@app/web/assets/utilities/dist'),
	('edaa9244','@craft/redactor/assets/redactor/dist'),
	('ee093f67','@craft/web/assets/tablesettings/dist'),
	('efdd0854','@app/web/assets/feed/dist'),
	('f024246d','@lib/jquery.payment'),
	('f0b7ca3f','@lib/d3'),
	('f1108fb4','@lib/jquery.payment'),
	('f2a6cdc2','@lib/fabric'),
	('f2df2d7a','@craft/web/assets/installer/dist'),
	('f30340f5','@craft/web/assets/editentry/dist'),
	('f3120134','@app/web/assets/garnish/dist'),
	('f36fece2','@craft/web/assets/updates/dist'),
	('f4ffd1be','@app/web/assets/tablesettings/dist'),
	('f5989042','@app/web/assets/editentry/dist'),
	('f5c2ff6f','@lib/garnishjs'),
	('f5f75a84','@lib/d3'),
	('f6d846d1','@craft/web/assets/pluginstore/dist'),
	('f79a25b7','@supercool/tablemaker/assetbundles/field/dist'),
	('f7ad96e5','@craft/web/assets/elementresizedetector/dist'),
	('f80cb84a','@app/web/assets/pluginstore/dist'),
	('f821679c','@craft/web/assets/cp/dist'),
	('f9b6d6ac','@lib/jquery-touch-events'),
	('fabab276','@app/web/assets/matrix/dist'),
	('fb30dc25','@lib/prismjs'),
	('fb527ad5','@lib/picturefill'),
	('fbd5b19','@app/web/assets/matrix/dist'),
	('fcb8d721','@bower/jquery/dist'),
	('fcf64617','@lib/jquery-touch-events'),
	('fd57701a','@craft/web/assets/userpermissions/dist'),
	('fd8aa295','@app/web/assets/craftsupport/dist'),
	('fd8c7cf8','@bower/jquery/dist'),
	('fdbc41e8','@app/web/assets/dashboard/dist'),
	('fdd5bfe1','@app/web/assets/utilities/dist'),
	('fe12ea6e','@lib/picturefill'),
	('fe6423c1','@lib/jquery-ui'),
	('fe79d2ec','@app/web/assets/recententries/dist'),
	('fece1a2d','@lib/fabric'),
	('ff59341e','@craft/web/assets/editcategory/dist'),
	('ffa5b062','@lib/vue'),
	('ffeb47af','@lib/timepicker');

/*!40000 ALTER TABLE `cc1_resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_revisions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_revisions`;

CREATE TABLE `cc1_revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `cc1_revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `cc1_revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `cc1_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cc1_revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_revisions` WRITE;
/*!40000 ALTER TABLE `cc1_revisions` DISABLE KEYS */;

INSERT INTO `cc1_revisions` (`id`, `sourceId`, `creatorId`, `num`, `notes`)
VALUES
	(1,5,1,1,'Revision from Sep 18, 2018, 2:25:58 PM'),
	(2,5,1,2,NULL),
	(3,6,17,25,NULL),
	(4,24,17,3,NULL),
	(5,24,17,2,NULL),
	(6,6,17,24,NULL),
	(7,24,17,1,NULL),
	(8,6,17,23,NULL),
	(9,6,17,22,NULL),
	(10,6,17,21,NULL),
	(11,6,17,20,NULL),
	(12,6,17,19,NULL),
	(13,6,17,18,NULL),
	(14,6,17,17,NULL),
	(15,6,17,16,NULL),
	(16,6,17,15,NULL),
	(17,6,17,14,NULL),
	(18,6,17,13,NULL),
	(19,6,17,12,NULL),
	(20,6,17,11,'Reverted version 9.'),
	(21,6,17,10,NULL),
	(22,6,17,9,NULL),
	(23,6,17,8,NULL),
	(24,6,17,7,NULL),
	(25,6,17,6,NULL),
	(26,6,17,5,NULL),
	(27,6,17,4,NULL),
	(28,10,1,2,NULL),
	(29,8,1,6,NULL),
	(30,8,1,5,NULL),
	(31,6,1,3,NULL),
	(32,8,1,4,NULL),
	(33,8,1,3,NULL),
	(34,8,1,2,NULL),
	(35,10,1,1,NULL),
	(36,8,1,1,NULL),
	(37,6,1,2,NULL),
	(38,6,1,1,NULL),
	(39,6,17,26,NULL);

/*!40000 ALTER TABLE `cc1_revisions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_routes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_routes`;

CREATE TABLE `cc1_routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) DEFAULT NULL,
  `uriParts` varchar(255) NOT NULL,
  `uriPattern` varchar(255) NOT NULL,
  `template` varchar(500) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_routes_uriPattern_idx` (`uriPattern`),
  KEY `cc1_routes_siteId_idx` (`siteId`),
  CONSTRAINT `cc1_routes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `cc1_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_searchindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_searchindex`;

CREATE TABLE `cc1_searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `cc1_searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_searchindex` WRITE;
/*!40000 ALTER TABLE `cc1_searchindex` DISABLE KEYS */;

INSERT INTO `cc1_searchindex` (`elementId`, `attribute`, `fieldId`, `siteId`, `keywords`)
VALUES
	(1,'username',0,1,' d hughes concertconsult co uk '),
	(1,'firstname',0,1,''),
	(1,'lastname',0,1,''),
	(1,'fullname',0,1,''),
	(1,'email',0,1,' d hughes concertconsult co uk '),
	(1,'slug',0,1,''),
	(2,'slug',0,1,' active '),
	(2,'title',0,1,' active '),
	(3,'slug',0,1,' deferred '),
	(3,'title',0,1,' deferred '),
	(4,'slug',0,1,' pensioner '),
	(4,'title',0,1,' pensioner '),
	(5,'title',0,1,' homepage '),
	(5,'slug',0,1,' homepage '),
	(6,'field',1,1,' active deferred col md 6 active deferred pensioner this is a one column page for pensioners check it out lorem ipsum dolor sit amet consectetur adipiscing elit proin egestas vel est sagittis sagittis maecenas lacinia fringilla tincidunt in vitae erat quis massa dignissim tempor sit amet interdum massa integer commodo sem nisl id ultricies velit dignissim in vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nunc sagittis ante in mattis sagittis nulla elit faucibus tellus id scelerisque nunc nulla in turpis nunc semper blandit ultrices pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas phasellus dapibus dolor tortor quis malesuada est ornare eget in semper imperdiet lorem a commodo suspendisse imperdiet nisl sit amet venenatis porta aenean fermentum accumsan orci sit amet mattis mauris tempus lobortis diam vel efficitur dolor dapibus eget mauris purus odio condimentum vitae gravida vitae luctus in nisl fusce imperdiet ante nec quam efficitur rutrum proin tristique ligula sit amet mi pharetra ornare ut eget enim id nunc pharetra varius facilisis vitae odio orci varius natoque penatibus et magnis dis parturient montes nascetur ridiculus mus fusce ligula lectus lacinia quis nulla sit amet vestibulum eleifend velit praesent rhoncus tortor pulvinar ex lobortis at congue eros congue curabitur ac feugiat diam sed pulvinar erat nullam ullamcorper erat ut nunc pellentesque ac vulputate eros molestie etiam in lacus mollis ultrices justo at sodales sem active deferred pensioner blank left heres a table with extra functionality left null left cell 1 cell 2 cell 3 cell 1 and 2 null cell 3 blank heres a table with extra functionality null cell 1 cell 2 cell 3 cell 1 and 2 null cell 3 active deferred col md 6 active deferred this is the second of two columns defined for md breakpoint and above using column blocks as a pensioner this is a one column page though check it out active deferred closesothers this is only an expander for active and deferred members active deferred pensioner this is only inside an expander for active and deferred members active deferred isendcap active deferred pensioner static block example active deferred pensioner this is an example of a complex block '),
	(6,'title',0,1,' scheme information '),
	(6,'slug',0,1,' scheme information '),
	(7,'field',2,1,' active deferred pensioner '),
	(7,'field',3,1,' this is a one column page for pensioners check it out lorem ipsum dolor sit amet consectetur adipiscing elit proin egestas vel est sagittis sagittis maecenas lacinia fringilla tincidunt in vitae erat quis massa dignissim tempor sit amet interdum massa integer commodo sem nisl id ultricies velit dignissim in vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nunc sagittis ante in mattis sagittis nulla elit faucibus tellus id scelerisque nunc nulla in turpis nunc semper blandit ultrices pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas phasellus dapibus dolor tortor quis malesuada est ornare eget in semper imperdiet lorem a commodo suspendisse imperdiet nisl sit amet venenatis porta aenean fermentum accumsan orci sit amet mattis mauris tempus lobortis diam vel efficitur dolor dapibus eget mauris purus odio condimentum vitae gravida vitae luctus in nisl fusce imperdiet ante nec quam efficitur rutrum proin tristique ligula sit amet mi pharetra ornare ut eget enim id nunc pharetra varius facilisis vitae odio orci varius natoque penatibus et magnis dis parturient montes nascetur ridiculus mus fusce ligula lectus lacinia quis nulla sit amet vestibulum eleifend velit praesent rhoncus tortor pulvinar ex lobortis at congue eros congue curabitur ac feugiat diam sed pulvinar erat nullam ullamcorper erat ut nunc pellentesque ac vulputate eros molestie etiam in lacus mollis ultrices justo at sodales sem '),
	(7,'slug',0,1,''),
	(6,'field',27,1,' active deferred pensioner '),
	(6,'field',24,1,''),
	(6,'field',25,1,''),
	(6,'field',23,1,''),
	(6,'field',26,1,''),
	(8,'field',27,1,' active deferred pensioner '),
	(8,'field',1,1,' active deferred pensioner cras tempus dolor at luctus ultrices suspendisse aliquam elit sit amet finibus mattis diam quam gravida orci eu efficitur odio quam at purus cras tellus augue ultrices finibus ligula elementum maximus ullamcorper urna fusce malesuada ut urna ut auctor nulla lacinia lacinia facilisis curabitur urna augue tristique non commodo vitae dictum et neque maecenas scelerisque augue eget volutpat molestie eros magna malesuada justo nec cursus elit lacus sit amet turpis aenean elit est consectetur vel diam id tincidunt accumsan tellus integer nec fermentum arcu sed felis sem pretium ac vestibulum eu vehicula sit amet lacus quisque a feugiat metus duis feugiat nulla id nisi tincidunt at tempus libero facilisis donec blandit dapibus mauris eget malesuada augue sodales in lorem ipsum heading 2 nam congue risus imperdiet varius ex ac venenatis odio lorem ipsum dolor sit amet consectetur adipiscing elit sed at interdum arcu duis eu semper urna ut tellus nibh elementum non quam ut commodo pulvinar nisl etiam dapibus diam dolor ut ullamcorper felis rutrum non aenean placerat metus enim donec varius massa vel posuere vulputate ligula urna hendrerit ipsum ut ornare urna mauris id mi active column 1 left column 2 left column 3 left mickey pluto donald mouse dog duck 1928 1930 1934 steamboat willie the chain gang the wise little hen column 1column 2column 3 mickeyplutodonaldmousedogduck192819301934steamboat williethe chain gangthe wise little hen '),
	(8,'field',24,1,''),
	(8,'field',25,1,''),
	(8,'field',23,1,''),
	(8,'field',26,1,''),
	(9,'field',2,1,' active deferred pensioner '),
	(9,'field',3,1,' cras tempus dolor at luctus ultrices suspendisse aliquam elit sit amet finibus mattis diam quam gravida orci eu efficitur odio quam at purus cras tellus augue ultrices finibus ligula elementum maximus ullamcorper urna fusce malesuada ut urna ut auctor nulla lacinia lacinia facilisis curabitur urna augue tristique non commodo vitae dictum et neque maecenas scelerisque augue eget volutpat molestie eros magna malesuada justo nec cursus elit lacus sit amet turpis aenean elit est consectetur vel diam id tincidunt accumsan tellus integer nec fermentum arcu sed felis sem pretium ac vestibulum eu vehicula sit amet lacus quisque a feugiat metus duis feugiat nulla id nisi tincidunt at tempus libero facilisis donec blandit dapibus mauris eget malesuada augue sodales in lorem ipsum heading 2 nam congue risus imperdiet varius ex ac venenatis odio lorem ipsum dolor sit amet consectetur adipiscing elit sed at interdum arcu duis eu semper urna ut tellus nibh elementum non quam ut commodo pulvinar nisl etiam dapibus diam dolor ut ullamcorper felis rutrum non aenean placerat metus enim donec varius massa vel posuere vulputate ligula urna hendrerit ipsum ut ornare urna mauris id mi '),
	(9,'slug',0,1,''),
	(8,'slug',0,1,' lorem ipsum dolor sit amet '),
	(8,'title',0,1,' lorem ipsum dolor sit amet '),
	(10,'field',27,1,' active '),
	(10,'field',1,1,' active deferred pensioner fusce sollicitudin eros vitae luctus ultrices sapien elit lobortis est non pellentesque tortor libero vehicula mauris donec rutrum purus id lectus mattis viverra maecenas aliquam porttitor erat eget molestie neque vestibulum fermentum augue id leo mollis blandit dignissim elit porta sed eget neque enim sed porta libero nec lectus tristique tristique interdum et malesuada fames ac ante ipsum primis in faucibus phasellus vestibulum non magna eget faucibus active deferred pensioner h3 section heading 3 active deferred pensioner info panel nam congue risus imperdiet varius ex ac venenatis odio lorem ipsum dolor sit amet consectetur adipiscing elit active deferred pensioner expander block heading suspendisse vitae ultrices metus nulla ac bibendum dui in efficitur felis eu orci laoreet posuere mauris vestibulum dapibus velit nec mattis tellus tempus sit amet active deferred pensioner test test com test 123 test road test town te57 1ng 01234567890 www test com '),
	(10,'field',24,1,''),
	(10,'field',25,1,''),
	(10,'field',23,1,''),
	(10,'field',26,1,''),
	(11,'field',2,1,' active deferred pensioner '),
	(11,'field',3,1,' fusce sollicitudin eros vitae luctus ultrices sapien elit lobortis est non pellentesque tortor libero vehicula mauris donec rutrum purus id lectus mattis viverra maecenas aliquam porttitor erat eget molestie neque vestibulum fermentum augue id leo mollis blandit dignissim elit porta sed eget neque enim sed porta libero nec lectus tristique tristique interdum et malesuada fames ac ante ipsum primis in faucibus phasellus vestibulum non magna eget faucibus '),
	(11,'slug',0,1,''),
	(12,'field',4,1,' active deferred pensioner '),
	(12,'field',5,1,' section heading 3 '),
	(12,'field',6,1,' h3 '),
	(12,'slug',0,1,''),
	(13,'field',7,1,' active deferred pensioner '),
	(13,'field',8,1,' info panel '),
	(13,'field',9,1,' nam congue risus imperdiet varius ex ac venenatis odio lorem ipsum dolor sit amet consectetur adipiscing elit '),
	(13,'slug',0,1,''),
	(14,'field',10,1,' active deferred pensioner '),
	(14,'field',11,1,' expander block heading '),
	(14,'field',12,1,' suspendisse vitae ultrices metus nulla ac bibendum dui in efficitur felis eu orci laoreet posuere mauris vestibulum dapibus velit nec mattis tellus tempus sit amet '),
	(14,'field',13,1,''),
	(14,'slug',0,1,''),
	(15,'field',18,1,' test test com '),
	(15,'field',19,1,' test 123 test road test town te57 1ng '),
	(15,'field',20,1,' 01234567890 '),
	(15,'field',21,1,' www test com '),
	(15,'field',22,1,' active deferred pensioner '),
	(15,'slug',0,1,''),
	(10,'slug',0,1,' vestibulum posuere congue dui ac convallis '),
	(10,'title',0,1,' vestibulum posuere congue dui ac convallis '),
	(16,'field',28,1,' column 1 left column 2 left column 3 left mickey pluto donald mouse dog duck 1928 1930 1934 steamboat willie the chain gang the wise little hen column 1column 2column 3 mickeyplutodonaldmousedogduck192819301934steamboat williethe chain gangthe wise little hen '),
	(16,'slug',0,1,''),
	(16,'field',29,1,' active '),
	(17,'username',0,1,' ben '),
	(17,'firstname',0,1,' benjamin '),
	(17,'lastname',0,1,' havery '),
	(17,'fullname',0,1,' benjamin havery '),
	(17,'email',0,1,' b havery concertconsult co uk '),
	(17,'slug',0,1,''),
	(7,'field',30,1,''),
	(18,'field',43,1,' active deferred pensioner '),
	(18,'field',44,1,' data1 60 da8102 data1 60 da8102 data2 30 071d49 data2 30 071d49 data3 10 b80e80 data3 10 b80e80 '),
	(18,'field',45,1,' bar '),
	(18,'slug',0,1,''),
	(18,'field',46,1,''),
	(254,'field',2,1,' active deferred pensioner '),
	(18,'field',49,1,' 1 '),
	(19,'field',10,1,' active deferred '),
	(254,'slug',0,1,''),
	(19,'field',11,1,' this is only an expander for active and deferred members '),
	(19,'slug',0,1,''),
	(20,'field',10,1,' active deferred '),
	(20,'field',11,1,''),
	(20,'slug',0,1,''),
	(21,'field',64,1,' active deferred '),
	(21,'field',65,1,' col md 6 '),
	(21,'slug',0,1,''),
	(22,'field',64,1,' active deferred '),
	(22,'field',65,1,' col md 6 '),
	(22,'slug',0,1,''),
	(23,'field',2,1,' active deferred '),
	(23,'field',3,1,' this is the second of two columns defined for md breakpoint and above using column blocks as a pensioner this is a one column page though check it out '),
	(23,'field',30,1,''),
	(23,'slug',0,1,''),
	(19,'field',72,1,' closesothers '),
	(20,'field',72,1,' isendcap '),
	(24,'slug',0,1,' complex block example '),
	(24,'title',0,1,' this is an example of a complex block '),
	(25,'field',40,1,' active deferred pensioner '),
	(25,'field',41,1,' static block example '),
	(25,'field',42,1,''),
	(25,'slug',0,1,''),
	(26,'field',73,1,' active deferred pensioner '),
	(26,'field',74,1,' this is an example of a complex block '),
	(26,'field',75,1,''),
	(26,'slug',0,1,''),
	(27,'field',36,1,' active deferred pensioner '),
	(27,'field',38,1,' blank left here s a table with extra functionality left null left cell 1 cell 2 cell 3 cell 1 and 2 null cell 3 blankhere s a table with extra functionalitynull cell 1cell 2cell 3cell 1 and 2nullcell 3 '),
	(27,'field',39,1,''),
	(27,'slug',0,1,''),
	(254,'field',3,1,' this is only inside an expander for active and deferred members '),
	(254,'field',30,1,'');

/*!40000 ALTER TABLE `cc1_searchindex` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_sections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_sections`;

CREATE TABLE `cc1_sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT 0,
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `defaultPlacement` enum('beginning','end') NOT NULL DEFAULT 'end',
  `previewTargets` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_sections_structureId_idx` (`structureId`),
  KEY `cc1_sections_dateDeleted_idx` (`dateDeleted`),
  KEY `cc1_sections_name_idx` (`name`),
  KEY `cc1_sections_handle_idx` (`handle`),
  CONSTRAINT `cc1_sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `cc1_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_sections` WRITE;
/*!40000 ALTER TABLE `cc1_sections` DISABLE KEYS */;

INSERT INTO `cc1_sections` (`id`, `structureId`, `name`, `handle`, `type`, `enableVersioning`, `propagationMethod`, `defaultPlacement`, `previewTargets`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,'Homepage','homepage','single',1,'all','end','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\"}]','2018-09-18 14:24:27','2020-08-18 08:40:08',NULL,'e3ca366b-16e2-4855-a2a5-9c0f779d8c1b'),
	(2,2,'Main Content Pages','mainContentPages','structure',1,'all','end','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\"}]','2018-09-18 15:48:31','2020-08-18 08:40:08',NULL,'39f758c4-55bd-4111-9963-e5d9a7143820'),
	(3,NULL,'Complex Blocks','complexBlocks','channel',1,'all','end',NULL,'2020-07-28 13:31:10','2020-07-28 13:31:10',NULL,'93167c2e-8b5f-495c-a89a-3de3262088c3');

/*!40000 ALTER TABLE `cc1_sections` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_sections_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_sections_sites`;

CREATE TABLE `cc1_sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `cc1_sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `cc1_sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `cc1_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `cc1_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_sections_sites` WRITE;
/*!40000 ALTER TABLE `cc1_sections_sites` DISABLE KEYS */;

INSERT INTO `cc1_sections_sites` (`id`, `sectionId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `enabledByDefault`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,1,'__home__','',1,'2018-09-18 14:24:27','2018-09-18 14:25:54','7b7875ab-878e-492e-ba92-f94f990c702b'),
	(2,2,1,1,'{slug}','_templates/entry',1,'2018-09-18 15:48:31','2018-09-19 08:28:57','686e8ca1-f756-44f5-89f7-9dd70399ea56'),
	(3,3,1,0,NULL,NULL,1,'2020-07-28 13:31:10','2020-07-28 13:31:10','1ad0559a-5001-4d46-b818-74b25ea12474');

/*!40000 ALTER TABLE `cc1_sections_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_sequences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_sequences`;

CREATE TABLE `cc1_sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_sessions`;

CREATE TABLE `cc1_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_sessions_uid_idx` (`uid`),
  KEY `cc1_sessions_token_idx` (`token`),
  KEY `cc1_sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `cc1_sessions_userId_idx` (`userId`),
  CONSTRAINT `cc1_sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `cc1_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_sessions` WRITE;
/*!40000 ALTER TABLE `cc1_sessions` DISABLE KEYS */;

INSERT INTO `cc1_sessions` (`id`, `userId`, `token`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(13,1,'HSozDL2s3EwuSOg0BFS-hbo4dYN5T5XyTKXtKtxaP7heqnMSUUMEAiwfBWiVx2ecYL2bsW-0CXFx-wrYD7iN_aMRMHyKQKmScTEz','2022-01-10 13:55:07','2022-01-10 13:56:23','36fb1067-8199-4fd6-ba65-3e8b49e841cf');

/*!40000 ALTER TABLE `cc1_sessions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_shunnedmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_shunnedmessages`;

CREATE TABLE `cc1_shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `cc1_shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `cc1_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_sitegroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_sitegroups`;

CREATE TABLE `cc1_sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_sitegroups_dateDeleted_idx` (`dateDeleted`),
  KEY `cc1_sitegroups_name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_sitegroups` WRITE;
/*!40000 ALTER TABLE `cc1_sitegroups` DISABLE KEYS */;

INSERT INTO `cc1_sitegroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,'Concert Base Craft 3','2018-06-08 15:06:11','2018-06-08 15:06:11',NULL,'c47fc095-639f-4ecb-aee4-f753bf707827');

/*!40000 ALTER TABLE `cc1_sitegroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_sites`;

CREATE TABLE `cc1_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 0,
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_sites_sortOrder_idx` (`sortOrder`),
  KEY `cc1_sites_groupId_fk` (`groupId`),
  KEY `cc1_sites_dateDeleted_idx` (`dateDeleted`),
  KEY `cc1_sites_handle_idx` (`handle`),
  CONSTRAINT `cc1_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `cc1_sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_sites` WRITE;
/*!40000 ALTER TABLE `cc1_sites` DISABLE KEYS */;

INSERT INTO `cc1_sites` (`id`, `groupId`, `primary`, `enabled`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,1,1,1,'Concert Base Craft 3','default','en',1,'//localhost:3000/',1,'2018-06-08 15:06:11','2018-12-19 10:49:38',NULL,'68b81c3c-1a31-4373-89c3-7dbdff84908c');

/*!40000 ALTER TABLE `cc1_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_structureelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_structureelements`;

CREATE TABLE `cc1_structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `cc1_structureelements_root_idx` (`root`),
  KEY `cc1_structureelements_lft_idx` (`lft`),
  KEY `cc1_structureelements_rgt_idx` (`rgt`),
  KEY `cc1_structureelements_level_idx` (`level`),
  KEY `cc1_structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `cc1_structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `cc1_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_structureelements` WRITE;
/*!40000 ALTER TABLE `cc1_structureelements` DISABLE KEYS */;

INSERT INTO `cc1_structureelements` (`id`, `structureId`, `elementId`, `root`, `lft`, `rgt`, `level`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,NULL,1,1,8,0,'2018-09-18 14:03:03','2018-09-18 14:03:26','062e1b13-3dc0-4080-a1fb-a3fc704cce0d'),
	(2,1,2,1,2,3,1,'2018-09-18 14:03:03','2018-09-18 14:03:03','56f5deb0-67cb-47af-89b1-d6753e51d266'),
	(3,1,3,1,4,5,1,'2018-09-18 14:03:18','2018-09-18 14:03:18','626247be-167d-4921-bec9-f2aca67822f3'),
	(4,1,4,1,6,7,1,'2018-09-18 14:03:26','2018-09-18 14:03:26','0b0e7d3e-2b44-4fe3-899c-3a02a39fe356'),
	(5,2,NULL,5,1,76,0,'2018-09-18 15:51:16','2021-02-16 16:48:35','bf82fe3e-da30-44a4-9638-c724e512c349'),
	(6,2,6,5,2,21,1,'2018-09-18 15:51:16','2020-08-18 08:40:27','cbe02e19-7f9a-4aad-804b-6f87f3d247ec'),
	(7,2,8,5,3,10,2,'2018-09-19 10:43:18','2020-08-18 08:40:27','396f92d2-66b1-42fd-9da1-00e885cf37ee'),
	(8,2,10,5,4,5,3,'2018-09-19 10:52:50','2018-09-19 10:52:50','14fd2165-831c-4fcb-8ae0-02d8f63b9f2f'),
	(9,2,30,5,38,39,1,'2020-08-18 08:40:20','2021-02-16 16:48:35','6cf19813-ae52-41b4-9cff-28ff4e795356'),
	(10,2,43,5,40,41,1,'2020-08-18 08:40:21','2021-02-16 16:48:35','a6324cea-9d8b-49b5-a7ab-f925d62f62fa'),
	(11,2,64,5,42,43,1,'2020-08-18 08:40:22','2021-02-16 16:48:35','6d2f95ab-2455-40b1-aae1-6c3bc9cd20f5'),
	(12,2,81,5,36,37,1,'2020-08-18 08:40:22','2021-02-16 16:48:35','f6a1a4b9-ad9f-403d-a831-cf9c9c9add82'),
	(13,2,89,5,34,35,1,'2020-08-18 08:40:22','2021-02-16 16:48:35','75c146da-733e-4d41-9e91-22885c06866e'),
	(14,2,97,5,32,33,1,'2020-08-18 08:40:22','2021-02-16 16:48:35','d3941885-abbe-46de-b77d-17a6b8131c69'),
	(15,2,105,5,30,31,1,'2020-08-18 08:40:23','2021-02-16 16:48:35','70b4a237-664f-439e-bbe0-8129ec8c6523'),
	(16,2,113,5,28,29,1,'2020-08-18 08:40:23','2021-02-16 16:48:35','7b776671-5a60-43e3-b5a7-4b22ca6e601f'),
	(17,2,121,5,26,27,1,'2020-08-18 08:40:23','2021-02-16 16:48:35','73847087-54ea-4c70-9563-045acc276a3d'),
	(18,2,129,5,24,25,1,'2020-08-18 08:40:23','2021-02-16 16:48:35','819f110e-98e1-4d52-82a6-d56e2a09c953'),
	(19,2,137,5,44,45,1,'2020-08-18 08:40:23','2021-02-16 16:48:35','61979aa9-ece4-4004-990b-89ca458f7eb7'),
	(20,2,147,5,46,47,1,'2020-08-18 08:40:24','2021-02-16 16:48:35','ea984704-af01-4428-91c3-0aefaf3e09ea'),
	(21,2,152,5,48,49,1,'2020-08-18 08:40:24','2021-02-16 16:48:35','08bc2592-e8f4-45b9-b3e8-0d0fa696e0bb'),
	(22,2,157,5,50,51,1,'2020-08-18 08:40:24','2021-02-16 16:48:35','07179450-0735-489a-a3d2-0746af223d2b'),
	(23,2,162,5,52,53,1,'2020-08-18 08:40:24','2021-02-16 16:48:35','8278991e-7c17-40de-b8d4-2fb97496e379'),
	(24,2,167,5,54,55,1,'2020-08-18 08:40:25','2021-02-16 16:48:35','944f3b1d-173b-425c-ba1c-6277cb2961f4'),
	(25,2,172,5,56,57,1,'2020-08-18 08:40:25','2021-02-16 16:48:35','433af4bb-79e4-4064-8c72-43a0153b65d0'),
	(26,2,177,5,58,59,1,'2020-08-18 08:40:25','2021-02-16 16:48:35','9ddb2380-f8ea-423d-82c9-46e3b0e07e03'),
	(27,2,182,5,60,61,1,'2020-08-18 08:40:25','2021-02-16 16:48:35','986d65e8-44b4-4da4-b81b-4e73e42ef65d'),
	(28,2,187,5,62,63,1,'2020-08-18 08:40:25','2021-02-16 16:48:35','29e15112-7838-4449-8d5a-e8e333421044'),
	(29,2,192,5,64,65,1,'2020-08-18 08:40:25','2021-02-16 16:48:35','8b65b00a-cbcf-491b-ab2c-56921b20eeaa'),
	(30,2,197,5,66,67,1,'2020-08-18 08:40:26','2021-02-16 16:48:35','3afbcfde-3b40-441d-b25f-6de2e0a1ffcf'),
	(31,2,202,5,6,7,3,'2020-08-18 08:40:26','2020-08-18 08:40:26','1ca30c93-aefa-4c99-b8e3-84b700db4c34'),
	(32,2,208,5,11,12,2,'2020-08-18 08:40:26','2020-08-18 08:40:27','d7ceadea-ce20-4f8a-9d1d-25ff72898427'),
	(33,2,211,5,13,14,2,'2020-08-18 08:40:26','2020-08-18 08:40:27','a43b575e-d572-420a-9c6d-688e7c7809c8'),
	(34,2,216,5,68,69,1,'2020-08-18 08:40:26','2021-02-16 16:48:35','a34184eb-0d45-4ff3-86fb-adabc51538d3'),
	(35,2,220,5,15,16,2,'2020-08-18 08:40:27','2020-08-18 08:40:27','fa861e28-1854-47c3-af9c-da8394400bb7'),
	(36,2,225,5,17,18,2,'2020-08-18 08:40:27','2020-08-18 08:40:27','800e6adb-7398-4232-b952-087c6f178f81'),
	(37,2,230,5,19,20,2,'2020-08-18 08:40:27','2020-08-18 08:40:27','41ce0a8a-5903-449a-ab92-b540e6219cd2'),
	(38,2,235,5,8,9,3,'2020-08-18 08:40:27','2020-08-18 08:40:27','a61b1334-3b27-4888-8175-b6ff0cb15dcf'),
	(39,2,245,5,70,71,1,'2020-08-18 08:40:27','2021-02-16 16:48:35','efa4bf8d-e18a-4cf1-9eef-3bbda7c1a2b9'),
	(40,2,249,5,72,73,1,'2020-08-18 08:40:28','2021-02-16 16:48:35','2320281f-c7f8-4311-b67b-198251254e26'),
	(41,2,252,5,74,75,1,'2020-08-18 08:40:28','2021-02-16 16:48:35','9ef116ef-5f32-4529-8dba-f10773a348fe'),
	(42,2,255,5,22,23,1,'2021-02-16 16:48:35','2021-02-16 16:48:35','c4236c1f-854a-423f-bef7-23cd9988f65c');

/*!40000 ALTER TABLE `cc1_structureelements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_structures
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_structures`;

CREATE TABLE `cc1_structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_structures` WRITE;
/*!40000 ALTER TABLE `cc1_structures` DISABLE KEYS */;

INSERT INTO `cc1_structures` (`id`, `maxLevels`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,'2018-09-18 14:02:42','2018-09-18 14:02:42',NULL,'9e0fada2-4eb1-4c1f-86c4-139419ba319b'),
	(2,NULL,'2018-09-18 15:48:31','2018-09-19 08:28:57',NULL,'3bcd708c-ee39-4622-b37f-9e14c54daffb');

/*!40000 ALTER TABLE `cc1_structures` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_systemmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_systemmessages`;

CREATE TABLE `cc1_systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `cc1_systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_systemsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_systemsettings`;

CREATE TABLE `cc1_systemsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(15) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_systemsettings_category_unq_idx` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_systemsettings` WRITE;
/*!40000 ALTER TABLE `cc1_systemsettings` DISABLE KEYS */;

INSERT INTO `cc1_systemsettings` (`id`, `category`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'email','{\"fromEmail\":\"d.hughes@concertconsult.co.uk\",\"fromName\":\"Concert Base Craft 3\",\"template\":\"\",\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Gmail\",\"transportSettings\":{\"username\":\"test\",\"password\":\"test\",\"timeout\":\"10\"}}','2018-06-08 15:06:12','2018-09-18 10:33:15','b3835e6c-acb3-4085-a8f0-63c5b3756400');

/*!40000 ALTER TABLE `cc1_systemsettings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_taggroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_taggroups`;

CREATE TABLE `cc1_taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  KEY `cc1_taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `cc1_taggroups_name_idx` (`name`),
  KEY `cc1_taggroups_handle_idx` (`handle`),
  CONSTRAINT `cc1_taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `cc1_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_tags`;

CREATE TABLE `cc1_tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_tags_groupId_idx` (`groupId`),
  CONSTRAINT `cc1_tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `cc1_taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_tags_id_fk` FOREIGN KEY (`id`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_templatecacheelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_templatecacheelements`;

CREATE TABLE `cc1_templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `cc1_templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `cc1_templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `cc1_templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `cc1_templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_templatecachequeries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_templatecachequeries`;

CREATE TABLE `cc1_templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cc1_templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `cc1_templatecachequeries_type_idx` (`type`),
  CONSTRAINT `cc1_templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `cc1_templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_templatecaches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_templatecaches`;

CREATE TABLE `cc1_templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cc1_templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `cc1_templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `cc1_templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `cc1_templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `cc1_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_tokens`;

CREATE TABLE `cc1_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text DEFAULT NULL,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_tokens_token_unq_idx` (`token`),
  KEY `cc1_tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_usergroups`;

CREATE TABLE `cc1_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_usergroups_handle_idx` (`handle`),
  KEY `cc1_usergroups_name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_usergroups_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_usergroups_users`;

CREATE TABLE `cc1_usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `cc1_usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `cc1_usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `cc1_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `cc1_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_userpermissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_userpermissions`;

CREATE TABLE `cc1_userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_userpermissions` WRITE;
/*!40000 ALTER TABLE `cc1_userpermissions` DISABLE KEYS */;

INSERT INTO `cc1_userpermissions` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'editimagesinvolume:3b244919-9ddb-4ed8-b47d-f3e626e7c0fa','2020-08-18 08:40:07','2020-08-18 08:40:07','dd31c54f-05a2-4887-a9fb-eb6f6e60e25c');

/*!40000 ALTER TABLE `cc1_userpermissions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_userpermissions_usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_userpermissions_usergroups`;

CREATE TABLE `cc1_userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `cc1_userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `cc1_userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `cc1_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `cc1_userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_userpermissions_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_userpermissions_users`;

CREATE TABLE `cc1_userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `cc1_userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `cc1_userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `cc1_userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `cc1_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cc1_userpreferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_userpreferences`;

CREATE TABLE `cc1_userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `cc1_userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `cc1_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_userpreferences` WRITE;
/*!40000 ALTER TABLE `cc1_userpreferences` DISABLE KEYS */;

INSERT INTO `cc1_userpreferences` (`userId`, `preferences`)
VALUES
	(1,'{\"language\":\"en\",\"weekStartDay\":\"0\",\"enableDebugToolbarForSite\":true,\"enableDebugToolbarForCp\":true}'),
	(17,'{\"language\":null,\"weekStartDay\":null,\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false}');

/*!40000 ALTER TABLE `cc1_userpreferences` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_users`;

CREATE TABLE `cc1_users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `suspended` tinyint(1) NOT NULL DEFAULT 0,
  `pending` tinyint(1) NOT NULL DEFAULT 0,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT 0,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT 0,
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_users_uid_idx` (`uid`),
  KEY `cc1_users_verificationCode_idx` (`verificationCode`),
  KEY `cc1_users_photoId_fk` (`photoId`),
  KEY `cc1_users_email_idx` (`email`),
  KEY `cc1_users_username_idx` (`username`),
  CONSTRAINT `cc1_users_id_fk` FOREIGN KEY (`id`) REFERENCES `cc1_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `cc1_assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_users` WRITE;
/*!40000 ALTER TABLE `cc1_users` DISABLE KEYS */;

INSERT INTO `cc1_users` (`id`, `username`, `photoId`, `firstName`, `lastName`, `email`, `password`, `admin`, `locked`, `suspended`, `pending`, `lastLoginDate`, `lastLoginAttemptIp`, `invalidLoginWindowStart`, `invalidLoginCount`, `lastInvalidLoginDate`, `lockoutDate`, `hasDashboard`, `verificationCode`, `verificationCodeIssuedDate`, `unverifiedEmail`, `passwordResetRequired`, `lastPasswordChangeDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'d.hughes@concertconsult.co.uk',NULL,'','','d.hughes@concertconsult.co.uk','$2y$13$DfvvKOARoDAFq.uqeOOKwucfBgx2HCrQlO2T0szRDXCVMly5UXyGi',1,0,0,0,'2022-01-10 13:55:07','192.168.10.1',NULL,NULL,'2018-12-19 09:46:44',NULL,1,NULL,NULL,NULL,0,'2018-06-08 15:06:12','2018-06-08 15:06:12','2022-01-10 13:55:07','4108afff-8441-4447-bd3d-c661861b5656'),
	(17,'Ben',NULL,'Benjamin','Havery','b.havery@concertconsult.co.uk','$2y$13$Q8e0TetyImOv.PfgCTFB.ubIMUPGhcW2GU/0PNnRgC3rsrxB9uaSu',1,0,0,0,'2021-02-16 16:05:15','192.168.10.1',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2018-12-19 10:51:13','2018-12-19 10:36:14','2021-02-16 16:05:16','59f44d99-bb4d-4815-bd31-5683114974db');

/*!40000 ALTER TABLE `cc1_users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_volumefolders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_volumefolders`;

CREATE TABLE `cc1_volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc1_volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `cc1_volumefolders_parentId_idx` (`parentId`),
  KEY `cc1_volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `cc1_volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `cc1_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cc1_volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `cc1_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_volumefolders` WRITE;
/*!40000 ALTER TABLE `cc1_volumefolders` DISABLE KEYS */;

INSERT INTO `cc1_volumefolders` (`id`, `parentId`, `volumeId`, `name`, `path`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,1,'Uploads','','2018-09-18 15:44:56','2018-09-18 15:44:56','9b48327f-9ec4-4481-abc1-2682e548cd2c'),
	(2,NULL,NULL,'Temporary source',NULL,'2018-09-19 10:50:11','2018-09-19 10:50:11','844bade8-87e2-4d07-ba07-744734e92d38'),
	(3,2,NULL,'user_1','user_1/','2018-09-19 10:50:11','2018-09-19 10:50:11','daedbf05-fa58-4e0a-93d5-71f57efe8571'),
	(4,2,NULL,'user_17','user_17/','2021-02-16 16:46:33','2021-02-16 16:46:33','d1e8469c-68d5-4143-b535-3bebac235cc0');

/*!40000 ALTER TABLE `cc1_volumefolders` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_volumes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_volumes`;

CREATE TABLE `cc1_volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `url` varchar(255) DEFAULT NULL,
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `cc1_volumes_dateDeleted_idx` (`dateDeleted`),
  KEY `cc1_volumes_name_idx` (`name`),
  KEY `cc1_volumes_handle_idx` (`handle`),
  CONSTRAINT `cc1_volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `cc1_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_volumes` WRITE;
/*!40000 ALTER TABLE `cc1_volumes` DISABLE KEYS */;

INSERT INTO `cc1_volumes` (`id`, `fieldLayoutId`, `name`, `handle`, `type`, `hasUrls`, `url`, `titleTranslationMethod`, `titleTranslationKeyFormat`, `settings`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,9,'Uploads','uploads','craft\\volumes\\Local',1,'@web/assets/uploads','site',NULL,'{\"path\":\"@webroot/assets/uploads\"}',1,'2018-09-18 15:44:56','2018-09-18 15:44:56',NULL,'3b244919-9ddb-4ed8-b47d-f3e626e7c0fa');

/*!40000 ALTER TABLE `cc1_volumes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cc1_widgets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cc1_widgets`;

CREATE TABLE `cc1_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cc1_widgets_userId_idx` (`userId`),
  CONSTRAINT `cc1_widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `cc1_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cc1_widgets` WRITE;
/*!40000 ALTER TABLE `cc1_widgets` DISABLE KEYS */;

INSERT INTO `cc1_widgets` (`id`, `userId`, `type`, `sortOrder`, `colspan`, `settings`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'craft\\widgets\\RecentEntries',1,0,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2018-06-08 15:06:16','2018-06-08 15:06:16','33dff5e8-6859-43b5-8b6a-3f133f2be762'),
	(2,1,'craft\\widgets\\CraftSupport',2,0,'[]',1,'2018-06-08 15:06:16','2018-06-08 15:06:16','6ed4244c-7e9b-4db9-a849-6a9ff0524b71'),
	(3,1,'craft\\widgets\\Updates',3,0,'[]',1,'2018-06-08 15:06:16','2018-06-08 15:06:16','bca8c3d0-921d-4795-9b60-142277cf5d88'),
	(4,1,'craft\\widgets\\Feed',4,0,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2018-06-08 15:06:16','2018-06-08 15:06:16','5e53f9c8-3f37-44c4-a05b-a7b3d9d6a42b'),
	(5,17,'craft\\widgets\\RecentEntries',1,0,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2019-03-19 12:17:48','2019-03-19 12:17:48','ddb735b5-3a36-41b9-8fc9-03f28863f2b8'),
	(6,17,'craft\\widgets\\CraftSupport',2,0,'[]',1,'2019-03-19 12:17:48','2019-03-19 12:17:48','e1934e5e-2633-4d41-90b3-20335c85e88d'),
	(7,17,'craft\\widgets\\Updates',3,0,'[]',1,'2019-03-19 12:17:48','2019-03-19 12:17:48','cc6d18ed-ab71-4da9-b859-4b80ea4eb0e8'),
	(8,17,'craft\\widgets\\Feed',4,0,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2019-03-19 12:17:48','2019-03-19 12:17:48','50bb751d-5ef8-4e91-8c88-b691bcf4f6bb');

/*!40000 ALTER TABLE `cc1_widgets` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
