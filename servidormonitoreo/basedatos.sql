-- MySQL dump 10.16  Distrib 10.1.38-MariaDB, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: zabbix
-- ------------------------------------------------------
-- Server version	10.1.38-MariaDB-0+deb9u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acknowledges`
--

DROP TABLE IF EXISTS `acknowledges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acknowledges` (
  `acknowledgeid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `action` int(11) NOT NULL DEFAULT '0',
  `old_severity` int(11) NOT NULL DEFAULT '0',
  `new_severity` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`acknowledgeid`),
  KEY `acknowledges_1` (`userid`),
  KEY `acknowledges_2` (`eventid`),
  KEY `acknowledges_3` (`clock`),
  CONSTRAINT `c_acknowledges_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_acknowledges_2` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acknowledges`
--

LOCK TABLES `acknowledges` WRITE;
/*!40000 ALTER TABLE `acknowledges` DISABLE KEYS */;
/*!40000 ALTER TABLE `acknowledges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `actionid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `eventsource` int(11) NOT NULL DEFAULT '0',
  `evaltype` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `esc_period` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '1h',
  `def_shortdata` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `def_longdata` text COLLATE utf8_bin NOT NULL,
  `r_shortdata` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `r_longdata` text COLLATE utf8_bin NOT NULL,
  `formula` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `pause_suppressed` int(11) NOT NULL DEFAULT '1',
  `ack_shortdata` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ack_longdata` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`actionid`),
  UNIQUE KEY `actions_2` (`name`),
  KEY `actions_1` (`eventsource`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
INSERT INTO `actions` VALUES (2,'Auto discovery. Linux servers.',1,0,1,'0','','','','','',1,'',''),(3,'Report problems to Zabbix administrators',0,0,1,'1h','Problem: {EVENT.NAME}','Problem started at {EVENT.TIME} on {EVENT.DATE}\r\nProblem name: {EVENT.NAME}\r\nHost: {HOST.NAME}\r\nSeverity: {EVENT.SEVERITY}\r\n\r\nOriginal problem ID: {EVENT.ID}\r\n{TRIGGER.URL}','Resolved: {EVENT.NAME}','Problem has been resolved at {EVENT.RECOVERY.TIME} on {EVENT.RECOVERY.DATE}\r\nProblem name: {EVENT.NAME}\r\nHost: {HOST.NAME}\r\nSeverity: {EVENT.SEVERITY}\r\n\r\nOriginal problem ID: {EVENT.ID}\r\n{TRIGGER.URL}','',1,'Updated problem: {EVENT.NAME}','{USER.FULLNAME} {EVENT.UPDATE.ACTION} problem at {EVENT.UPDATE.DATE} {EVENT.UPDATE.TIME}.\r\n{EVENT.UPDATE.MESSAGE}\r\n\r\nCurrent problem status is {EVENT.STATUS}, acknowledged: {EVENT.ACK.STATUS}.'),(4,'Report not supported items',3,0,1,'1h','{ITEM.STATE}: {HOST.NAME}:{ITEM.NAME}','Host: {HOST.NAME}\r\nItem: {ITEM.NAME}\r\nKey: {ITEM.KEY}\r\nState: {ITEM.STATE}','{ITEM.STATE}: {HOST.NAME}:{ITEM.NAME}','Host: {HOST.NAME}\r\nItem: {ITEM.NAME}\r\nKey: {ITEM.KEY}\r\nState: {ITEM.STATE}','',1,'',''),(5,'Report not supported low level discovery rules',3,0,1,'1h','{LLDRULE.STATE}: {HOST.NAME}:{LLDRULE.NAME}','Host: {HOST.NAME}\r\nLow level discovery rule: {LLDRULE.NAME}\r\nKey: {LLDRULE.KEY}\r\nState: {LLDRULE.STATE}','{LLDRULE.STATE}: {HOST.NAME}:{LLDRULE.NAME}','Host: {HOST.NAME}\r\nLow level discovery rule: {LLDRULE.NAME}\r\nKey: {LLDRULE.KEY}\r\nState: {LLDRULE.STATE}','',1,'',''),(6,'Report unknown triggers',3,0,1,'1h','{TRIGGER.STATE}: {TRIGGER.NAME}','Trigger name: {TRIGGER.NAME}\r\nExpression: {TRIGGER.EXPRESSION}\r\nState: {TRIGGER.STATE}','{TRIGGER.STATE}: {TRIGGER.NAME}','Trigger name: {TRIGGER.NAME}\r\nExpression: {TRIGGER.EXPRESSION}\r\nState: {TRIGGER.STATE}','',1,'','');
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alerts` (
  `alertid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `mediatypeid` bigint(20) unsigned DEFAULT NULL,
  `sendto` varchar(1024) COLLATE utf8_bin NOT NULL DEFAULT '',
  `subject` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `message` text COLLATE utf8_bin NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `retries` int(11) NOT NULL DEFAULT '0',
  `error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `esc_step` int(11) NOT NULL DEFAULT '0',
  `alerttype` int(11) NOT NULL DEFAULT '0',
  `p_eventid` bigint(20) unsigned DEFAULT NULL,
  `acknowledgeid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`alertid`),
  KEY `alerts_1` (`actionid`),
  KEY `alerts_2` (`clock`),
  KEY `alerts_3` (`eventid`),
  KEY `alerts_4` (`status`),
  KEY `alerts_5` (`mediatypeid`),
  KEY `alerts_6` (`userid`),
  KEY `alerts_7` (`p_eventid`),
  KEY `c_alerts_6` (`acknowledgeid`),
  CONSTRAINT `c_alerts_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_2` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_4` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_5` FOREIGN KEY (`p_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_6` FOREIGN KEY (`acknowledgeid`) REFERENCES `acknowledges` (`acknowledgeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_discovery`
--

DROP TABLE IF EXISTS `application_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_discovery` (
  `application_discoveryid` bigint(20) unsigned NOT NULL,
  `applicationid` bigint(20) unsigned NOT NULL,
  `application_prototypeid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`application_discoveryid`),
  KEY `application_discovery_1` (`applicationid`),
  KEY `application_discovery_2` (`application_prototypeid`),
  CONSTRAINT `c_application_discovery_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE,
  CONSTRAINT `c_application_discovery_2` FOREIGN KEY (`application_prototypeid`) REFERENCES `application_prototype` (`application_prototypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_discovery`
--

LOCK TABLES `application_discovery` WRITE;
/*!40000 ALTER TABLE `application_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `application_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_prototype`
--

DROP TABLE IF EXISTS `application_prototype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_prototype` (
  `application_prototypeid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`application_prototypeid`),
  KEY `application_prototype_1` (`itemid`),
  KEY `application_prototype_2` (`templateid`),
  CONSTRAINT `c_application_prototype_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_application_prototype_2` FOREIGN KEY (`templateid`) REFERENCES `application_prototype` (`application_prototypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_prototype`
--

LOCK TABLES `application_prototype` WRITE;
/*!40000 ALTER TABLE `application_prototype` DISABLE KEYS */;
INSERT INTO `application_prototype` VALUES (1,23665,NULL,'Startup {#SERVICE.STARTUPNAME} services');
/*!40000 ALTER TABLE `application_prototype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_template`
--

DROP TABLE IF EXISTS `application_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_template` (
  `application_templateid` bigint(20) unsigned NOT NULL,
  `applicationid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`application_templateid`),
  UNIQUE KEY `application_template_1` (`applicationid`,`templateid`),
  KEY `application_template_2` (`templateid`),
  CONSTRAINT `c_application_template_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE,
  CONSTRAINT `c_application_template_2` FOREIGN KEY (`templateid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_template`
--

LOCK TABLES `application_template` WRITE;
/*!40000 ALTER TABLE `application_template` DISABLE KEYS */;
INSERT INTO `application_template` VALUES (1,207,206),(12,252,206),(13,262,206),(14,272,206),(15,282,206),(16,292,206),(17,302,206),(18,329,206),(19,345,179),(20,346,13),(21,347,5),(22,348,21),(23,349,15),(24,350,7),(25,351,1),(26,352,17),(27,353,9),(28,354,23),(29,355,207),(165,797,780),(166,799,780),(168,803,771),(167,803,784),(169,804,800),(170,805,799),(171,811,784),(172,812,800),(173,813,799),(174,820,784),(175,821,800),(176,822,799),(177,823,784),(178,824,800),(179,825,799),(180,836,826),(181,837,827),(182,838,826),(183,839,827),(185,840,771),(184,840,784),(186,841,800),(187,842,799),(191,846,800),(192,847,799),(193,856,848),(194,857,849),(195,858,852),(196,859,853),(197,860,854),(198,861,855),(205,868,848),(206,869,851),(207,870,852),(208,871,853),(209,872,854),(210,873,855),(212,874,771),(211,874,784),(213,875,800),(214,876,799),(215,883,784),(216,884,800),(217,885,799),(219,892,771),(218,892,784),(220,893,800),(221,894,799),(223,901,771),(222,901,784),(224,902,800),(225,903,799),(227,910,770),(226,910,781),(228,911,798),(229,912,797),(231,913,771),(230,913,782),(232,914,800),(233,915,799),(235,916,771),(234,916,784),(236,917,800),(237,918,799),(244,934,771),(243,934,784),(245,935,800),(246,936,799),(247,942,784),(248,943,800),(249,944,799),(251,949,771),(250,949,784),(252,950,800),(253,951,799),(263,969,784),(264,970,800),(265,971,799),(266,977,784),(267,978,800),(268,979,799),(270,986,771),(269,986,784),(271,987,800),(272,988,799),(273,992,782),(274,993,800),(275,994,799),(276,998,781),(277,999,798),(278,1000,797),(279,1014,779),(280,1015,776),(281,1016,777),(282,1017,778),(284,1018,771),(283,1018,784),(285,1019,800),(286,1020,799),(287,1021,779),(288,1022,776),(289,1023,777),(290,1024,778),(291,1025,786),(292,1026,800),(293,1027,799),(295,1028,771),(294,1028,784),(296,1029,800),(297,1030,799),(298,1037,779),(299,1038,776),(300,1039,777),(301,1040,778),(302,1041,784),(303,1042,800),(304,1043,799),(305,1048,852),(306,1049,855),(307,1050,854),(308,1051,853),(309,1052,848),(310,1053,784),(311,1054,800),(312,1055,799),(313,1057,1056),(314,1058,771),(317,1058,784),(315,1059,800),(316,1060,799),(318,1069,800),(319,1070,799),(320,1078,800),(321,1079,799),(322,1087,798),(323,1088,797),(324,1094,800),(325,1095,799),(326,1101,800),(327,1102,799);
/*!40000 ALTER TABLE `application_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `applications` (
  `applicationid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`applicationid`),
  UNIQUE KEY `applications_2` (`hostid`,`name`),
  CONSTRAINT `c_applications_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applications`
--

LOCK TABLES `applications` WRITE;
/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
INSERT INTO `applications` VALUES (1,10001,'OS',0),(5,10001,'Filesystems',0),(7,10001,'Network interfaces',0),(9,10001,'Processes',0),(13,10001,'CPU',0),(15,10001,'Memory',0),(17,10001,'Performance',0),(21,10001,'General',0),(23,10001,'Security',0),(179,10047,'Zabbix server',0),(206,10050,'Zabbix agent',0),(207,10001,'Zabbix agent',0),(252,10074,'Zabbix agent',0),(253,10074,'CPU',0),(254,10074,'Filesystems',0),(255,10074,'General',0),(256,10074,'Memory',0),(257,10074,'Network interfaces',0),(258,10074,'OS',0),(259,10074,'Performance',0),(260,10074,'Processes',0),(261,10074,'Security',0),(262,10075,'Zabbix agent',0),(263,10075,'CPU',0),(264,10075,'Filesystems',0),(265,10075,'General',0),(266,10075,'Memory',0),(267,10075,'Network interfaces',0),(268,10075,'OS',0),(269,10075,'Performance',0),(270,10075,'Processes',0),(271,10075,'Security',0),(272,10076,'Zabbix agent',0),(273,10076,'CPU',0),(274,10076,'Filesystems',0),(275,10076,'General',0),(276,10076,'Memory',0),(277,10076,'Network interfaces',0),(278,10076,'OS',0),(279,10076,'Performance',0),(280,10076,'Processes',0),(281,10076,'Security',0),(282,10077,'Zabbix agent',0),(283,10077,'CPU',0),(284,10077,'Filesystems',0),(285,10077,'General',0),(286,10077,'Memory',0),(287,10077,'Network interfaces',0),(288,10077,'OS',0),(289,10077,'Performance',0),(290,10077,'Processes',0),(291,10077,'Security',0),(292,10078,'Zabbix agent',0),(293,10078,'CPU',0),(294,10078,'Filesystems',0),(295,10078,'General',0),(296,10078,'Memory',0),(297,10078,'Network interfaces',0),(298,10078,'OS',0),(299,10078,'Performance',0),(300,10078,'Processes',0),(301,10078,'Security',0),(302,10079,'Zabbix agent',0),(303,10079,'CPU',0),(304,10079,'Filesystems',0),(305,10079,'General',0),(306,10079,'Memory',0),(307,10079,'Network interfaces',0),(308,10079,'OS',0),(309,10079,'Performance',0),(310,10079,'Processes',0),(311,10079,'Security',0),(319,10081,'General',0),(320,10081,'Performance',0),(321,10081,'Services',0),(322,10081,'Filesystems',0),(323,10081,'OS',0),(324,10081,'Processes',0),(325,10081,'CPU',0),(328,10081,'Memory',0),(329,10081,'Zabbix agent',0),(330,10081,'Network interfaces',0),(331,10076,'Logical partitions',0),(345,10084,'Zabbix server',0),(346,10084,'CPU',0),(347,10084,'Filesystems',0),(348,10084,'General',0),(349,10084,'Memory',0),(350,10084,'Network interfaces',0),(351,10084,'OS',0),(352,10084,'Performance',0),(353,10084,'Processes',0),(354,10084,'Security',0),(355,10084,'Zabbix agent',0),(356,10048,'Zabbix proxy',0),(446,10093,'FTP service',0),(447,10094,'HTTP service',0),(448,10095,'HTTPS service',0),(449,10096,'IMAP service',0),(450,10097,'LDAP service',0),(451,10098,'NNTP service',0),(452,10099,'NTP service',0),(453,10100,'POP service',0),(454,10101,'SMTP service',0),(455,10102,'SSH service',0),(456,10103,'Telnet service',0),(732,10169,'Classes',0),(733,10169,'Compilation',0),(734,10169,'Garbage collector',0),(735,10169,'Memory',0),(736,10169,'Memory pool',0),(737,10169,'Operating system',0),(738,10169,'Runtime',0),(739,10169,'Threads',0),(740,10170,'MySQL',0),(741,10171,'Fans',0),(742,10171,'Temperature',0),(743,10171,'Voltage',0),(744,10172,'Fans',0),(745,10172,'Temperature',0),(746,10172,'Voltage',0),(747,10173,'Clusters',0),(748,10173,'General',0),(749,10173,'Log',0),(750,10174,'CPU',0),(751,10174,'Disks',0),(752,10174,'Filesystems',0),(753,10174,'General',0),(754,10174,'Interfaces',0),(755,10174,'Memory',0),(756,10174,'Network',0),(757,10174,'Storage',0),(758,10175,'CPU',0),(759,10175,'Datastore',0),(760,10175,'General',0),(761,10175,'Hardware',0),(762,10175,'Memory',0),(763,10175,'Network',0),(770,10182,'Network interfaces',0),(771,10183,'Network interfaces',0),(772,10184,'Internal items',0),(773,10184,'Memory',0),(774,10184,'Storage',0),(775,10184,'CPU',0),(776,10185,'Internal items',0),(777,10185,'Memory',0),(778,10185,'Storage',0),(779,10185,'CPU',0),(780,10186,'Status',0),(781,10187,'Network interfaces',0),(782,10188,'Network interfaces',0),(783,10189,'Network interfaces',0),(784,10190,'Network interfaces',0),(786,10192,'Network interfaces',0),(797,10203,'Status',0),(798,10203,'General',0),(799,10204,'Status',0),(800,10204,'General',0),(803,10207,'Network interfaces',0),(804,10207,'General',0),(805,10207,'Status',0),(806,10207,'CPU',0),(807,10207,'Memory',0),(808,10207,'Temperature',0),(809,10207,'Fans',0),(810,10207,'Inventory',0),(811,10208,'Network interfaces',0),(812,10208,'General',0),(813,10208,'Status',0),(814,10208,'CPU',0),(815,10208,'Memory',0),(816,10208,'Temperature',0),(817,10208,'Power supply',0),(818,10208,'Fans',0),(819,10208,'Inventory',0),(820,10210,'Network interfaces',0),(821,10210,'General',0),(822,10210,'Status',0),(823,10211,'Network interfaces',0),(824,10211,'General',0),(825,10211,'Status',0),(826,10209,'CPU',0),(827,10209,'Memory',0),(828,10210,'Temperature',0),(829,10210,'Power supply',0),(830,10210,'Fans',0),(831,10210,'Inventory',0),(832,10211,'Temperature',0),(833,10211,'Power supply',0),(834,10211,'Fans',0),(835,10211,'Inventory',0),(836,10210,'CPU',0),(837,10210,'Memory',0),(838,10211,'CPU',0),(839,10211,'Memory',0),(840,10218,'Network interfaces',0),(841,10218,'General',0),(842,10218,'Status',0),(846,10220,'General',0),(847,10220,'Status',0),(848,10212,'Memory',0),(849,10213,'CPU',0),(851,10215,'CPU',0),(852,10216,'Inventory',0),(853,10217,'Temperature',0),(854,10217,'Power supply',0),(855,10217,'Fans',0),(856,10218,'Memory',0),(857,10218,'CPU',0),(858,10218,'Inventory',0),(859,10218,'Temperature',0),(860,10218,'Power supply',0),(861,10218,'Fans',0),(868,10220,'Memory',0),(869,10220,'CPU',0),(870,10220,'Inventory',0),(871,10220,'Temperature',0),(872,10220,'Power supply',0),(873,10220,'Fans',0),(874,10221,'Network interfaces',0),(875,10221,'General',0),(876,10221,'Status',0),(877,10221,'CPU',0),(878,10221,'Memory',0),(879,10221,'Temperature',0),(880,10221,'Power supply',0),(881,10221,'Fans',0),(882,10221,'Inventory',0),(883,10222,'Network interfaces',0),(884,10222,'General',0),(885,10222,'Status',0),(886,10222,'CPU',0),(887,10222,'Memory',0),(888,10222,'Temperature',0),(889,10222,'Fans',0),(890,10222,'Power supply',0),(891,10222,'Inventory',0),(892,10223,'Network interfaces',0),(893,10223,'General',0),(894,10223,'Status',0),(895,10223,'CPU',0),(896,10223,'Memory',0),(897,10223,'Temperature',0),(898,10223,'Fans',0),(899,10223,'Power supply',0),(900,10223,'Inventory',0),(901,10224,'Network interfaces',0),(902,10224,'General',0),(903,10224,'Status',0),(904,10224,'CPU',0),(905,10224,'Memory',0),(906,10224,'Temperature',0),(907,10224,'Power supply',0),(908,10224,'Fans',0),(909,10224,'Inventory',0),(910,10225,'Network interfaces',0),(911,10225,'General',0),(912,10225,'Status',0),(913,10226,'Network interfaces',0),(914,10226,'General',0),(915,10226,'Status',0),(916,10227,'Network interfaces',0),(917,10227,'General',0),(918,10227,'Status',0),(919,10227,'CPU',0),(920,10227,'Memory',0),(921,10227,'Temperature',0),(922,10227,'Fans',0),(923,10227,'Power supply',0),(924,10227,'Inventory',0),(934,10229,'Network interfaces',0),(935,10229,'General',0),(936,10229,'Status',0),(937,10229,'CPU',0),(938,10229,'Memory',0),(939,10229,'Temperature',0),(940,10229,'Fans',0),(941,10229,'Inventory',0),(942,10230,'Network interfaces',0),(943,10230,'General',0),(944,10230,'Status',0),(945,10230,'Temperature',0),(946,10230,'Power supply',0),(947,10230,'Fans',0),(948,10230,'Inventory',0),(949,10231,'Network interfaces',0),(950,10231,'General',0),(951,10231,'Status',0),(952,10231,'CPU',0),(953,10231,'Memory',0),(954,10231,'Temperature',0),(955,10231,'Power supply',0),(956,10231,'Fans',0),(957,10231,'Inventory',0),(969,10233,'Network interfaces',0),(970,10233,'General',0),(971,10233,'Status',0),(972,10233,'CPU',0),(973,10233,'Memory',0),(974,10233,'Temperature',0),(975,10233,'Storage',0),(976,10233,'Inventory',0),(977,10234,'Network interfaces',0),(978,10234,'General',0),(979,10234,'Status',0),(980,10234,'CPU',0),(981,10234,'Memory',0),(982,10234,'Temperature',0),(983,10234,'Power supply',0),(984,10234,'Fans',0),(985,10234,'Inventory',0),(986,10235,'Network interfaces',0),(987,10235,'General',0),(988,10235,'Status',0),(989,10235,'CPU',0),(990,10235,'Memory',0),(991,10235,'Inventory',0),(992,10236,'Network interfaces',0),(993,10236,'General',0),(994,10236,'Status',0),(995,10236,'CPU',0),(996,10236,'Memory',0),(997,10236,'Inventory',0),(998,10237,'Network interfaces',0),(999,10237,'General',0),(1000,10237,'Status',0),(1001,10237,'CPU',0),(1002,10237,'Memory',0),(1003,10237,'Inventory',0),(1014,10248,'CPU',0),(1015,10248,'Internal items',0),(1016,10248,'Memory',0),(1017,10248,'Storage',0),(1018,10248,'Network interfaces',0),(1019,10248,'General',0),(1020,10248,'Status',0),(1021,10249,'CPU',0),(1022,10249,'Internal items',0),(1023,10249,'Memory',0),(1024,10249,'Storage',0),(1025,10249,'Network interfaces',0),(1026,10249,'General',0),(1027,10249,'Status',0),(1028,10250,'Network interfaces',0),(1029,10250,'General',0),(1030,10250,'Status',0),(1031,10250,'CPU',0),(1032,10250,'Memory',0),(1033,10250,'Temperature',0),(1034,10250,'Fans',0),(1035,10250,'Power supply',0),(1036,10250,'Inventory',0),(1037,10251,'CPU',0),(1038,10251,'Internal items',0),(1039,10251,'Memory',0),(1040,10251,'Storage',0),(1041,10251,'Network interfaces',0),(1042,10251,'General',0),(1043,10251,'Status',0),(1044,10251,'Temperature',0),(1045,10251,'Fans',0),(1046,10251,'Power supply',0),(1047,10251,'Inventory',0),(1048,10253,'Inventory',0),(1049,10253,'Fans',0),(1050,10253,'Power supply',0),(1051,10253,'Temperature',0),(1052,10253,'Memory',0),(1053,10253,'Network interfaces',0),(1054,10253,'General',0),(1055,10253,'Status',0),(1056,10252,'CPU',0),(1057,10253,'CPU',0),(1058,10254,'Network interfaces',0),(1059,10254,'General',0),(1060,10254,'Status',0),(1061,10254,'CPU',0),(1062,10254,'Fans',0),(1063,10254,'Internal items',0),(1064,10254,'Inventory',0),(1065,10254,'Memory',0),(1066,10254,'Power supply',0),(1067,10254,'Storage',0),(1068,10254,'Temperature',0),(1069,10255,'General',0),(1070,10255,'Status',0),(1071,10255,'Disk arrays',0),(1072,10255,'Fans',0),(1073,10255,'Inventory',0),(1074,10255,'Physical disks',0),(1075,10255,'Power supply',0),(1076,10255,'Temperature',0),(1077,10255,'Virtual disks',0),(1078,10256,'General',0),(1079,10256,'Status',0),(1080,10256,'Disk arrays',0),(1081,10256,'Fans',0),(1082,10256,'Inventory',0),(1083,10256,'Physical disks',0),(1084,10256,'Power supply',0),(1085,10256,'Temperature',0),(1086,10256,'Virtual disks',0),(1087,10257,'General',0),(1088,10257,'Status',0),(1089,10257,'Fans',0),(1090,10257,'Inventory',0),(1091,10257,'Physical disks',0),(1092,10257,'Power supply',0),(1093,10257,'Temperature',0),(1094,10258,'General',0),(1095,10258,'Status',0),(1096,10258,'Fans',0),(1097,10258,'Inventory',0),(1098,10258,'Physical disks',0),(1099,10258,'Power supply',0),(1100,10258,'Temperature',0),(1101,10259,'General',0),(1102,10259,'Status',0),(1103,10259,'Fans',0),(1104,10259,'Temperature',0),(1105,10260,'http-8080',0),(1106,10260,'http-8443',0),(1107,10260,'jk-8009',0),(1108,10260,'Sessions',0),(1109,10260,'Tomcat',0),(1110,10261,'Zabbix server',0),(1111,10262,'Zabbix proxy',0),(1112,10173,'Datastore',0);
/*!40000 ALTER TABLE `applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditlog`
--

DROP TABLE IF EXISTS `auditlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditlog` (
  `auditid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `action` int(11) NOT NULL DEFAULT '0',
  `resourcetype` int(11) NOT NULL DEFAULT '0',
  `details` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `resourceid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `resourcename` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`auditid`),
  KEY `auditlog_1` (`userid`,`clock`),
  KEY `auditlog_2` (`clock`),
  CONSTRAINT `c_auditlog_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditlog`
--

LOCK TABLES `auditlog` WRITE;
/*!40000 ALTER TABLE `auditlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditlog_details`
--

DROP TABLE IF EXISTS `auditlog_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditlog_details` (
  `auditdetailid` bigint(20) unsigned NOT NULL,
  `auditid` bigint(20) unsigned NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `field_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `oldvalue` text COLLATE utf8_bin NOT NULL,
  `newvalue` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`auditdetailid`),
  KEY `auditlog_details_1` (`auditid`),
  CONSTRAINT `c_auditlog_details_1` FOREIGN KEY (`auditid`) REFERENCES `auditlog` (`auditid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditlog_details`
--

LOCK TABLES `auditlog_details` WRITE;
/*!40000 ALTER TABLE `auditlog_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditlog_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autoreg_host`
--

DROP TABLE IF EXISTS `autoreg_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoreg_host` (
  `autoreg_hostid` bigint(20) unsigned NOT NULL,
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `listen_ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `listen_port` int(11) NOT NULL DEFAULT '0',
  `listen_dns` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `host_metadata` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`autoreg_hostid`),
  KEY `autoreg_host_1` (`host`),
  KEY `autoreg_host_2` (`proxy_hostid`),
  CONSTRAINT `c_autoreg_host_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoreg_host`
--

LOCK TABLES `autoreg_host` WRITE;
/*!40000 ALTER TABLE `autoreg_host` DISABLE KEYS */;
/*!40000 ALTER TABLE `autoreg_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conditions` (
  `conditionid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `conditiontype` int(11) NOT NULL DEFAULT '0',
  `operator` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value2` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`conditionid`),
  KEY `conditions_1` (`actionid`),
  CONSTRAINT `c_conditions_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conditions`
--

LOCK TABLES `conditions` WRITE;
/*!40000 ALTER TABLE `conditions` DISABLE KEYS */;
INSERT INTO `conditions` VALUES (2,2,10,0,'0',''),(3,2,8,0,'9',''),(4,2,12,2,'Linux',''),(6,4,23,0,'0',''),(7,5,23,0,'2',''),(8,6,23,0,'4','');
/*!40000 ALTER TABLE `conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `configid` bigint(20) unsigned NOT NULL,
  `refresh_unsupported` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '10m',
  `work_period` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '1-5,09:00-18:00',
  `alert_usrgrpid` bigint(20) unsigned DEFAULT NULL,
  `default_theme` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT 'blue-theme',
  `authentication_type` int(11) NOT NULL DEFAULT '0',
  `ldap_host` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ldap_port` int(11) NOT NULL DEFAULT '389',
  `ldap_base_dn` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ldap_bind_dn` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ldap_bind_password` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ldap_search_attribute` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `dropdown_first_entry` int(11) NOT NULL DEFAULT '1',
  `dropdown_first_remember` int(11) NOT NULL DEFAULT '1',
  `discovery_groupid` bigint(20) unsigned NOT NULL,
  `max_in_table` int(11) NOT NULL DEFAULT '50',
  `search_limit` int(11) NOT NULL DEFAULT '1000',
  `severity_color_0` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '97AAB3',
  `severity_color_1` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '7499FF',
  `severity_color_2` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT 'FFC859',
  `severity_color_3` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT 'FFA059',
  `severity_color_4` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT 'E97659',
  `severity_color_5` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT 'E45959',
  `severity_name_0` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'Not classified',
  `severity_name_1` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'Information',
  `severity_name_2` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'Warning',
  `severity_name_3` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'Average',
  `severity_name_4` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'High',
  `severity_name_5` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'Disaster',
  `ok_period` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '5m',
  `blink_period` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '2m',
  `problem_unack_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT 'CC0000',
  `problem_ack_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT 'CC0000',
  `ok_unack_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '009900',
  `ok_ack_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '009900',
  `problem_unack_style` int(11) NOT NULL DEFAULT '1',
  `problem_ack_style` int(11) NOT NULL DEFAULT '1',
  `ok_unack_style` int(11) NOT NULL DEFAULT '1',
  `ok_ack_style` int(11) NOT NULL DEFAULT '1',
  `snmptrap_logging` int(11) NOT NULL DEFAULT '1',
  `server_check_interval` int(11) NOT NULL DEFAULT '10',
  `hk_events_mode` int(11) NOT NULL DEFAULT '1',
  `hk_events_trigger` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '365d',
  `hk_events_internal` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '1d',
  `hk_events_discovery` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '1d',
  `hk_events_autoreg` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '1d',
  `hk_services_mode` int(11) NOT NULL DEFAULT '1',
  `hk_services` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '365d',
  `hk_audit_mode` int(11) NOT NULL DEFAULT '1',
  `hk_audit` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '365d',
  `hk_sessions_mode` int(11) NOT NULL DEFAULT '1',
  `hk_sessions` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '365d',
  `hk_history_mode` int(11) NOT NULL DEFAULT '1',
  `hk_history_global` int(11) NOT NULL DEFAULT '0',
  `hk_history` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '90d',
  `hk_trends_mode` int(11) NOT NULL DEFAULT '1',
  `hk_trends_global` int(11) NOT NULL DEFAULT '0',
  `hk_trends` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '365d',
  `default_inventory_mode` int(11) NOT NULL DEFAULT '-1',
  `custom_color` int(11) NOT NULL DEFAULT '0',
  `http_auth_enabled` int(11) NOT NULL DEFAULT '0',
  `http_login_form` int(11) NOT NULL DEFAULT '0',
  `http_strip_domains` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `http_case_sensitive` int(11) NOT NULL DEFAULT '1',
  `ldap_configured` int(11) NOT NULL DEFAULT '0',
  `ldap_case_sensitive` int(11) NOT NULL DEFAULT '1',
  `db_extension` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`configid`),
  KEY `config_1` (`alert_usrgrpid`),
  KEY `config_2` (`discovery_groupid`),
  CONSTRAINT `c_config_1` FOREIGN KEY (`alert_usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`),
  CONSTRAINT `c_config_2` FOREIGN KEY (`discovery_groupid`) REFERENCES `hstgrp` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'10m','1-5,09:00-18:00',7,'blue-theme',0,'',389,'','','','',1,1,5,50,1000,'97AAB3','7499FF','FFC859','FFA059','E97659','E45959','Not classified','Information','Warning','Average','High','Disaster','5m','2m','CC0000','CC0000','009900','009900',1,1,1,1,1,10,1,'365d','1d','1d','1d',1,'365d',1,'365d',1,'365d',1,0,'90d',1,0,'365d',-1,0,0,0,'',1,0,1,'');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition`
--

DROP TABLE IF EXISTS `corr_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `correlationid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`corr_conditionid`),
  KEY `corr_condition_1` (`correlationid`),
  CONSTRAINT `c_corr_condition_1` FOREIGN KEY (`correlationid`) REFERENCES `correlation` (`correlationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition`
--

LOCK TABLES `corr_condition` WRITE;
/*!40000 ALTER TABLE `corr_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_group`
--

DROP TABLE IF EXISTS `corr_condition_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition_group` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `operator` int(11) NOT NULL DEFAULT '0',
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`corr_conditionid`),
  KEY `corr_condition_group_1` (`groupid`),
  CONSTRAINT `c_corr_condition_group_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE,
  CONSTRAINT `c_corr_condition_group_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_group`
--

LOCK TABLES `corr_condition_group` WRITE;
/*!40000 ALTER TABLE `corr_condition_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_tag`
--

DROP TABLE IF EXISTS `corr_condition_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition_tag` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`corr_conditionid`),
  CONSTRAINT `c_corr_condition_tag_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_tag`
--

LOCK TABLES `corr_condition_tag` WRITE;
/*!40000 ALTER TABLE `corr_condition_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_tagpair`
--

DROP TABLE IF EXISTS `corr_condition_tagpair`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition_tagpair` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `oldtag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `newtag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`corr_conditionid`),
  CONSTRAINT `c_corr_condition_tagpair_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_tagpair`
--

LOCK TABLES `corr_condition_tagpair` WRITE;
/*!40000 ALTER TABLE `corr_condition_tagpair` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_tagpair` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_tagvalue`
--

DROP TABLE IF EXISTS `corr_condition_tagvalue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition_tagvalue` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `operator` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`corr_conditionid`),
  CONSTRAINT `c_corr_condition_tagvalue_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_tagvalue`
--

LOCK TABLES `corr_condition_tagvalue` WRITE;
/*!40000 ALTER TABLE `corr_condition_tagvalue` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_tagvalue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_operation`
--

DROP TABLE IF EXISTS `corr_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_operation` (
  `corr_operationid` bigint(20) unsigned NOT NULL,
  `correlationid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`corr_operationid`),
  KEY `corr_operation_1` (`correlationid`),
  CONSTRAINT `c_corr_operation_1` FOREIGN KEY (`correlationid`) REFERENCES `correlation` (`correlationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_operation`
--

LOCK TABLES `corr_operation` WRITE;
/*!40000 ALTER TABLE `corr_operation` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `correlation`
--

DROP TABLE IF EXISTS `correlation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `correlation` (
  `correlationid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` text COLLATE utf8_bin NOT NULL,
  `evaltype` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `formula` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`correlationid`),
  UNIQUE KEY `correlation_2` (`name`),
  KEY `correlation_1` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `correlation`
--

LOCK TABLES `correlation` WRITE;
/*!40000 ALTER TABLE `correlation` DISABLE KEYS */;
/*!40000 ALTER TABLE `correlation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard`
--

DROP TABLE IF EXISTS `dashboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard` (
  `dashboardid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `private` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`dashboardid`),
  KEY `c_dashboard_1` (`userid`),
  CONSTRAINT `c_dashboard_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard`
--

LOCK TABLES `dashboard` WRITE;
/*!40000 ALTER TABLE `dashboard` DISABLE KEYS */;
INSERT INTO `dashboard` VALUES (1,'Global view',1,0),(2,'Zabbix server health',1,1);
/*!40000 ALTER TABLE `dashboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_user`
--

DROP TABLE IF EXISTS `dashboard_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_user` (
  `dashboard_userid` bigint(20) unsigned NOT NULL,
  `dashboardid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`dashboard_userid`),
  UNIQUE KEY `dashboard_user_1` (`dashboardid`,`userid`),
  KEY `c_dashboard_user_2` (`userid`),
  CONSTRAINT `c_dashboard_user_1` FOREIGN KEY (`dashboardid`) REFERENCES `dashboard` (`dashboardid`) ON DELETE CASCADE,
  CONSTRAINT `c_dashboard_user_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_user`
--

LOCK TABLES `dashboard_user` WRITE;
/*!40000 ALTER TABLE `dashboard_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_usrgrp`
--

DROP TABLE IF EXISTS `dashboard_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_usrgrp` (
  `dashboard_usrgrpid` bigint(20) unsigned NOT NULL,
  `dashboardid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`dashboard_usrgrpid`),
  UNIQUE KEY `dashboard_usrgrp_1` (`dashboardid`,`usrgrpid`),
  KEY `c_dashboard_usrgrp_2` (`usrgrpid`),
  CONSTRAINT `c_dashboard_usrgrp_1` FOREIGN KEY (`dashboardid`) REFERENCES `dashboard` (`dashboardid`) ON DELETE CASCADE,
  CONSTRAINT `c_dashboard_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_usrgrp`
--

LOCK TABLES `dashboard_usrgrp` WRITE;
/*!40000 ALTER TABLE `dashboard_usrgrp` DISABLE KEYS */;
INSERT INTO `dashboard_usrgrp` VALUES (1,2,7,3);
/*!40000 ALTER TABLE `dashboard_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dbversion`
--

DROP TABLE IF EXISTS `dbversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbversion` (
  `mandatory` int(11) NOT NULL DEFAULT '0',
  `optional` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dbversion`
--

LOCK TABLES `dbversion` WRITE;
/*!40000 ALTER TABLE `dbversion` DISABLE KEYS */;
INSERT INTO `dbversion` VALUES (4020000,4020000);
/*!40000 ALTER TABLE `dbversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dchecks`
--

DROP TABLE IF EXISTS `dchecks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dchecks` (
  `dcheckid` bigint(20) unsigned NOT NULL,
  `druleid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `key_` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmp_community` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ports` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `snmpv3_securityname` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmpv3_securitylevel` int(11) NOT NULL DEFAULT '0',
  `snmpv3_authpassphrase` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmpv3_privpassphrase` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `uniq` int(11) NOT NULL DEFAULT '0',
  `snmpv3_authprotocol` int(11) NOT NULL DEFAULT '0',
  `snmpv3_privprotocol` int(11) NOT NULL DEFAULT '0',
  `snmpv3_contextname` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `host_source` int(11) NOT NULL DEFAULT '1',
  `name_source` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dcheckid`),
  KEY `dchecks_1` (`druleid`,`host_source`,`name_source`),
  CONSTRAINT `c_dchecks_1` FOREIGN KEY (`druleid`) REFERENCES `drules` (`druleid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dchecks`
--

LOCK TABLES `dchecks` WRITE;
/*!40000 ALTER TABLE `dchecks` DISABLE KEYS */;
INSERT INTO `dchecks` VALUES (2,2,9,'system.uname','','10050','',0,'','',0,0,0,'',1,0);
/*!40000 ALTER TABLE `dchecks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dhosts`
--

DROP TABLE IF EXISTS `dhosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dhosts` (
  `dhostid` bigint(20) unsigned NOT NULL,
  `druleid` bigint(20) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `lastup` int(11) NOT NULL DEFAULT '0',
  `lastdown` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dhostid`),
  KEY `dhosts_1` (`druleid`),
  CONSTRAINT `c_dhosts_1` FOREIGN KEY (`druleid`) REFERENCES `drules` (`druleid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dhosts`
--

LOCK TABLES `dhosts` WRITE;
/*!40000 ALTER TABLE `dhosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `dhosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drules`
--

DROP TABLE IF EXISTS `drules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drules` (
  `druleid` bigint(20) unsigned NOT NULL,
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `iprange` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `delay` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '1h',
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`druleid`),
  UNIQUE KEY `drules_2` (`name`),
  KEY `drules_1` (`proxy_hostid`),
  CONSTRAINT `c_drules_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drules`
--

LOCK TABLES `drules` WRITE;
/*!40000 ALTER TABLE `drules` DISABLE KEYS */;
INSERT INTO `drules` VALUES (2,NULL,'Local network','192.168.0.1-254','1h',0,1);
/*!40000 ALTER TABLE `drules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dservices`
--

DROP TABLE IF EXISTS `dservices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dservices` (
  `dserviceid` bigint(20) unsigned NOT NULL,
  `dhostid` bigint(20) unsigned NOT NULL,
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `lastup` int(11) NOT NULL DEFAULT '0',
  `lastdown` int(11) NOT NULL DEFAULT '0',
  `dcheckid` bigint(20) unsigned NOT NULL,
  `ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `dns` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`dserviceid`),
  UNIQUE KEY `dservices_1` (`dcheckid`,`ip`,`port`),
  KEY `dservices_2` (`dhostid`),
  CONSTRAINT `c_dservices_1` FOREIGN KEY (`dhostid`) REFERENCES `dhosts` (`dhostid`) ON DELETE CASCADE,
  CONSTRAINT `c_dservices_2` FOREIGN KEY (`dcheckid`) REFERENCES `dchecks` (`dcheckid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dservices`
--

LOCK TABLES `dservices` WRITE;
/*!40000 ALTER TABLE `dservices` DISABLE KEYS */;
/*!40000 ALTER TABLE `dservices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `escalations`
--

DROP TABLE IF EXISTS `escalations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `escalations` (
  `escalationid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned DEFAULT NULL,
  `eventid` bigint(20) unsigned DEFAULT NULL,
  `r_eventid` bigint(20) unsigned DEFAULT NULL,
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `esc_step` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `itemid` bigint(20) unsigned DEFAULT NULL,
  `acknowledgeid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`escalationid`),
  UNIQUE KEY `escalations_1` (`triggerid`,`itemid`,`escalationid`),
  KEY `escalations_2` (`eventid`),
  KEY `escalations_3` (`nextcheck`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `escalations`
--

LOCK TABLES `escalations` WRITE;
/*!40000 ALTER TABLE `escalations` DISABLE KEYS */;
/*!40000 ALTER TABLE `escalations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_recovery`
--

DROP TABLE IF EXISTS `event_recovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_recovery` (
  `eventid` bigint(20) unsigned NOT NULL,
  `r_eventid` bigint(20) unsigned NOT NULL,
  `c_eventid` bigint(20) unsigned DEFAULT NULL,
  `correlationid` bigint(20) unsigned DEFAULT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`eventid`),
  KEY `event_recovery_1` (`r_eventid`),
  KEY `event_recovery_2` (`c_eventid`),
  CONSTRAINT `c_event_recovery_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_event_recovery_2` FOREIGN KEY (`r_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_event_recovery_3` FOREIGN KEY (`c_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_recovery`
--

LOCK TABLES `event_recovery` WRITE;
/*!40000 ALTER TABLE `event_recovery` DISABLE KEYS */;
INSERT INTO `event_recovery` VALUES (1,16,NULL,NULL,NULL),(12,15,NULL,NULL,NULL);
/*!40000 ALTER TABLE `event_recovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_suppress`
--

DROP TABLE IF EXISTS `event_suppress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_suppress` (
  `event_suppressid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned DEFAULT NULL,
  `suppress_until` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`event_suppressid`),
  UNIQUE KEY `event_suppress_1` (`eventid`,`maintenanceid`),
  KEY `event_suppress_2` (`suppress_until`),
  KEY `event_suppress_3` (`maintenanceid`),
  CONSTRAINT `c_event_suppress_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_event_suppress_2` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_suppress`
--

LOCK TABLES `event_suppress` WRITE;
/*!40000 ALTER TABLE `event_suppress` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_suppress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_tag`
--

DROP TABLE IF EXISTS `event_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_tag` (
  `eventtagid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`eventtagid`),
  KEY `event_tag_1` (`eventid`),
  CONSTRAINT `c_event_tag_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_tag`
--

LOCK TABLES `event_tag` WRITE;
/*!40000 ALTER TABLE `event_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `eventid` bigint(20) unsigned NOT NULL,
  `source` int(11) NOT NULL DEFAULT '0',
  `object` int(11) NOT NULL DEFAULT '0',
  `objectid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  `acknowledged` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  `name` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`eventid`),
  KEY `events_1` (`source`,`object`,`objectid`,`clock`),
  KEY `events_2` (`source`,`object`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,0,0,13560,1564099344,1,0,358210074,'Zabbix task manager processes more than 75% busy',3),(2,3,4,23261,1564099361,1,0,375566706,'No \"ipmi poller\" processes started.',0),(3,3,0,13476,1564099361,1,0,375566706,'Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:zabbix[process,ipmi poller,avg,busy].avg(10m)\": item is not supported.\".',0),(4,3,4,23262,1564099362,1,0,376489509,'No \"java poller\" processes started.',0),(5,3,0,13477,1564099362,1,0,376489509,'Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:zabbix[process,java poller,avg,busy].avg(10m)\": item is not supported.\".',0),(6,3,4,25367,1564099367,1,0,378580249,'No \"ipmi manager\" processes started.',0),(7,3,4,23267,1564099367,1,0,378840805,'No \"snmp trapper\" processes started.',0),(8,3,0,13482,1564099367,1,0,378840805,'Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:zabbix[process,snmp trapper,avg,busy].avg(10m)\": item is not supported.\".',0),(9,3,0,13563,1564099367,1,0,378580249,'Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:zabbix[process,ipmi manager,avg,busy].avg(10m)\": item is not supported.\".',0),(10,3,4,23328,1564099368,1,0,379561635,'No \"vmware collector\" processes started.',0),(11,3,0,13436,1564099368,1,0,379561635,'Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:zabbix[process,vmware collector,avg,busy].avg(10m)\": item is not supported.\".',0),(12,3,0,13491,1564099371,1,0,327279252,'Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:agent.ping.nodata(5m)\": item does not have enough data after server start or item creation.\".',0),(13,3,4,23635,1564099375,1,0,385552624,'No \"vmware collector\" processes started.',0),(14,3,0,13537,1564099375,1,0,385552624,'Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:zabbix[vmware,buffer,pused].max(10m)\": item is not supported.\".',0),(15,3,0,13491,1564099387,0,0,391568130,'',0),(16,0,0,13560,1564099404,0,0,410905444,'Zabbix task manager processes more than 75% busy',0),(17,3,0,13502,1564099713,1,0,670363429,'Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:system.uptime.change(0)\": cannot get values from value cache.\".',0);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expressions`
--

DROP TABLE IF EXISTS `expressions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expressions` (
  `expressionid` bigint(20) unsigned NOT NULL,
  `regexpid` bigint(20) unsigned NOT NULL,
  `expression` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `expression_type` int(11) NOT NULL DEFAULT '0',
  `exp_delimiter` varchar(1) COLLATE utf8_bin NOT NULL DEFAULT '',
  `case_sensitive` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`expressionid`),
  KEY `expressions_1` (`regexpid`),
  CONSTRAINT `c_expressions_1` FOREIGN KEY (`regexpid`) REFERENCES `regexps` (`regexpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expressions`
--

LOCK TABLES `expressions` WRITE;
/*!40000 ALTER TABLE `expressions` DISABLE KEYS */;
INSERT INTO `expressions` VALUES (1,1,'^(btrfs|ext2|ext3|ext4|reiser|xfs|ffs|ufs|jfs|jfs2|vxfs|hfs|apfs|refs|ntfs|fat32|zfs)$',3,',',0),(3,3,'^(Physical memory|Virtual memory|Memory buffers|Cached memory|Swap space)$',4,',',1),(5,4,'^(MMCSS|gupdate|SysmonLog|clr_optimization_v2.0.50727_32|clr_optimization_v4.0.30319_32)$',4,',',1),(6,5,'^(automatic|automatic delayed)$',3,',',1),(7,2,'^Software Loopback Interface',4,',',1),(8,2,'^(In)?[Ll]oop[Bb]ack[0-9._]*$',4,',',1),(9,2,'^NULL[0-9.]*$',4,',',1),(10,2,'^[Ll]o[0-9.]*$',4,',',1),(11,2,'^[Ss]ystem$',4,',',1),(12,2,'^Nu[0-9.]*$',4,',',1);
/*!40000 ALTER TABLE `expressions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `functions`
--

DROP TABLE IF EXISTS `functions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `functions` (
  `functionid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `name` varchar(12) COLLATE utf8_bin NOT NULL DEFAULT '',
  `parameter` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`functionid`),
  KEY `functions_1` (`triggerid`),
  KEY `functions_2` (`itemid`,`name`,`parameter`),
  CONSTRAINT `c_functions_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_functions_2` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `functions`
--

LOCK TABLES `functions` WRITE;
/*!40000 ALTER TABLE `functions` DISABLE KEYS */;
INSERT INTO `functions` VALUES (10199,10019,10016,'diff','0'),(10204,10055,10041,'last','0'),(10207,10058,10044,'diff','0'),(10208,10057,10043,'diff','0'),(12144,22181,13000,'last','0'),(12549,22232,13025,'nodata','5m'),(12550,10020,10047,'nodata','5m'),(12553,10056,10042,'last','0'),(12580,17350,10012,'last','0'),(12583,10025,10021,'change','0'),(12592,22686,13266,'last','0'),(12598,22454,13272,'last','0'),(12641,22189,13015,'max','10m'),(12645,22183,13073,'max','10m'),(12646,22191,13074,'max','10m'),(12648,23620,13075,'max','10m'),(12649,22185,13019,'max','10m'),(12651,22396,13017,'max','10m'),(12653,22219,13023,'min','10m'),(12715,22833,13328,'nodata','5m'),(12717,22835,13330,'last','0'),(12718,22836,13331,'last','0'),(12723,22853,13336,'diff','0'),(12724,22856,13337,'last','0'),(12725,22858,13338,'diff','0'),(12726,22859,13339,'change','0'),(12727,22861,13340,'diff','0'),(12728,22862,13341,'last','0'),(12729,22869,13342,'last','0'),(12730,22872,13343,'last','0'),(12731,22873,13344,'nodata','5m'),(12733,22875,13346,'last','0'),(12734,22876,13347,'last','0'),(12739,22893,13352,'diff','0'),(12740,22896,13353,'last','0'),(12741,22898,13354,'diff','0'),(12742,22899,13355,'change','0'),(12743,22901,13356,'diff','0'),(12744,22902,13357,'last','0'),(12745,22909,13358,'last','0'),(12746,22912,13359,'last','0'),(12747,22913,13360,'nodata','5m'),(12755,22933,13368,'diff','0'),(12757,22938,13370,'diff','0'),(12758,22939,13371,'change','0'),(12759,22941,13372,'diff','0'),(12760,22942,13373,'last','0'),(12761,22949,13374,'last','0'),(12762,22952,13375,'last','0'),(12763,22953,13376,'nodata','5m'),(12771,22973,13384,'diff','0'),(12773,22978,13386,'diff','0'),(12775,22981,13388,'diff','0'),(12776,22982,13389,'last','0'),(12777,22989,13390,'last','0'),(12778,22992,13391,'last','0'),(12779,22993,13392,'nodata','5m'),(12782,22996,13395,'last','0'),(12787,23013,13400,'diff','0'),(12788,23016,13401,'last','0'),(12789,23018,13402,'diff','0'),(12790,23019,13403,'change','0'),(12791,23021,13404,'diff','0'),(12792,23022,13405,'last','0'),(12793,23029,13406,'last','0'),(12794,23032,13407,'last','0'),(12795,23033,13408,'nodata','5m'),(12797,23035,13410,'last','0'),(12798,23036,13411,'last','0'),(12803,23053,13416,'diff','0'),(12805,23058,13418,'diff','0'),(12806,23059,13419,'change','0'),(12807,23061,13420,'diff','0'),(12808,23062,13421,'last','0'),(12809,23069,13422,'last','0'),(12810,23072,13423,'last','0'),(12812,23149,13425,'diff','0'),(12815,23150,13428,'change','0'),(12818,23668,13431,'min','10m'),(12820,23158,13433,'last','0'),(12824,23160,13437,'nodata','5m'),(12826,23165,13439,'last','0'),(12895,23271,13486,'min','10m'),(12896,23273,13487,'max','10m'),(12897,23274,13488,'max','10m'),(12898,23275,13489,'max','10m'),(12899,23276,13490,'max','10m'),(12900,23287,13491,'nodata','5m'),(12902,23289,13493,'last','0'),(12903,23290,13494,'last','0'),(12908,23307,13499,'diff','0'),(12909,23310,13500,'last','0'),(12910,23312,13501,'diff','0'),(12911,23313,13502,'change','0'),(12912,23315,13503,'diff','0'),(12913,23316,13504,'last','0'),(12914,23282,13505,'last','0'),(12915,23284,13506,'last','0'),(12926,22231,13026,'diff','0'),(12927,10059,10045,'diff','0'),(12928,23288,13492,'diff','0'),(12929,22834,13329,'diff','0'),(12930,22874,13345,'diff','0'),(12931,22914,13361,'diff','0'),(12932,22954,13377,'diff','0'),(12933,22994,13393,'diff','0'),(12934,23034,13409,'diff','0'),(12935,23161,13438,'diff','0'),(12936,23318,13507,'diff','0'),(12937,23319,13508,'diff','0'),(12938,23327,13509,'diff','0'),(12939,23320,13510,'diff','0'),(12940,23321,13511,'diff','0'),(12941,23322,13512,'diff','0'),(12942,23323,13513,'diff','0'),(12943,23324,13514,'diff','0'),(12944,23325,13515,'diff','0'),(12945,23326,13516,'diff','0'),(12946,23357,13517,'max','10m'),(12947,23342,13518,'max','10m'),(12948,23341,13519,'max','10m'),(12949,23359,13520,'min','10m'),(12965,23634,13536,'max','10m'),(12966,23635,13537,'max','10m'),(12994,23644,13544,'max','#3'),(12995,23645,13545,'max','#3'),(12996,23646,13546,'max','#3'),(12997,23647,13547,'max','#3'),(12998,23648,13548,'max','#3'),(13068,23115,13367,'avg','5m'),(13069,22922,13366,'avg','5m'),(13070,22918,13365,'avg','5m'),(13071,22917,13364,'avg','5m'),(13072,22882,13350,'avg','5m'),(13073,22878,13349,'avg','5m'),(13074,22877,13348,'avg','5m'),(13075,22962,13382,'avg','5m'),(13078,10010,10010,'avg','5m'),(13079,23296,13497,'avg','5m'),(13080,17362,13243,'avg','5m'),(13081,23301,13498,'avg','5m'),(13082,10009,10190,'avg','5m'),(13083,23292,13496,'avg','5m'),(13084,10013,10011,'avg','5m'),(13085,23291,13495,'avg','5m'),(13086,23042,13414,'avg','5m'),(13087,22842,13334,'avg','5m'),(13088,22838,13333,'avg','5m'),(13089,22837,13332,'avg','5m'),(13090,23007,13399,'avg','5m'),(13091,23002,13398,'avg','5m'),(13092,22998,13397,'avg','5m'),(13093,22997,13396,'avg','5m'),(13094,23143,13435,'avg','5m'),(13095,23140,13430,'avg','5m'),(13152,23651,13551,'max','#3'),(13154,23649,13549,'max','#3'),(13156,23650,13550,'max','#3'),(13157,23652,13552,'max','#3'),(13158,23653,13553,'max','#3'),(13159,23654,13285,'max','#3'),(13160,23661,13557,'last',''),(13161,23662,13558,'last',''),(13164,22424,13080,'avg','10m'),(13165,23252,13467,'avg','10m'),(13170,22412,13081,'avg','10m'),(13171,23253,13468,'avg','10m'),(13172,22430,13083,'avg','10m'),(13173,23255,13470,'avg','10m'),(13174,22422,13084,'avg','10m'),(13175,23256,13471,'avg','10m'),(13176,22406,13085,'avg','10m'),(13177,23257,13472,'avg','10m'),(13178,22408,13086,'avg','30m'),(13179,23258,13473,'avg','30m'),(13180,22402,13087,'avg','10m'),(13181,23259,13474,'avg','10m'),(13182,22418,13088,'avg','10m'),(13183,23260,13475,'avg','10m'),(13184,22416,13089,'avg','10m'),(13185,23261,13476,'avg','10m'),(13186,22689,13275,'avg','10m'),(13187,23262,13477,'avg','10m'),(13188,22399,13091,'avg','10m'),(13189,23264,13479,'avg','10m'),(13190,22420,13092,'avg','10m'),(13191,23265,13480,'avg','10m'),(13192,22414,13093,'min','10m'),(13193,23266,13481,'min','10m'),(13194,23171,13441,'avg','10m'),(13195,23267,13482,'avg','10m'),(13196,23663,13559,'avg','10m'),(13197,23664,13560,'avg','10m'),(13198,22426,13094,'avg','10m'),(13199,23268,13483,'avg','10m'),(13200,22404,13095,'avg','10m'),(13201,23269,13484,'avg','10m'),(13202,22400,13096,'avg','10m'),(13203,23270,13485,'avg','10m'),(13204,22401,13097,'avg','10m'),(13205,23328,13436,'avg','10m'),(13206,23347,13521,'avg','10m'),(13207,23360,13534,'avg','10m'),(13208,23352,13522,'avg','10m'),(13209,23351,13535,'avg','10m'),(13210,23350,13523,'avg','10m'),(13211,23353,13524,'avg','30m'),(13212,23354,13525,'avg','10m'),(13213,23356,13526,'avg','10m'),(13214,23355,13527,'avg','10m'),(13215,23349,13528,'avg','10m'),(13216,23348,13529,'avg','10m'),(13217,23343,13530,'avg','10m'),(13218,23344,13531,'avg','10m'),(13219,23345,13532,'avg','10m'),(13220,23346,13533,'avg','10m'),(13221,23666,13561,'min','#3'),(13222,25366,13562,'avg','10m'),(13223,25367,13563,'avg','10m'),(13224,25368,13564,'avg','10m'),(13225,25369,13565,'avg','10m'),(13226,25370,13566,'avg','10m'),(13227,25371,13567,'avg','10m'),(13228,25665,13568,'avg','10m'),(13229,25666,13569,'avg','10m'),(13230,25667,13570,'avg','10m'),(13231,25668,13571,'avg','10m'),(14257,26909,14168,'last','0'),(14258,26908,14168,'last','0'),(14259,26899,14169,'last','0'),(14260,26903,14169,'last','0'),(14261,26902,14170,'last','0'),(14262,26901,14170,'last','0'),(14263,26864,14171,'last','0'),(14264,26882,14171,'last','0'),(14265,26866,14172,'last','0'),(14266,26865,14172,'last','0'),(14267,26861,14173,'last','0'),(14268,26862,14173,'last','0'),(14269,26858,14174,'last','0'),(14270,26856,14174,'last','0'),(14271,26868,14175,'last','0'),(14272,26860,14175,'last','0'),(14273,26877,14176,'last','0'),(14274,26878,14176,'last','0'),(14275,26880,14177,'last','0'),(14276,26879,14177,'last','0'),(14277,26881,14178,'last','0'),(14278,26887,14179,'last','0'),(14279,26895,14179,'last','0'),(14280,26889,14180,'last','0'),(14281,26884,14180,'last','0'),(14282,26906,14181,'last','0'),(14283,26896,14181,'last','0'),(14284,26907,14182,'last','0'),(14285,26908,14182,'last','0'),(14286,26904,14183,'last','0'),(14287,26903,14183,'last','0'),(14288,26900,14184,'last','0'),(14289,26901,14184,'last','0'),(14290,26883,14185,'last','0'),(14291,26882,14185,'last','0'),(14292,26863,14186,'last','0'),(14293,26865,14186,'last','0'),(14294,26867,14187,'last','0'),(14295,26862,14187,'last','0'),(14296,26857,14188,'last','0'),(14297,26856,14188,'last','0'),(14298,26859,14189,'last','0'),(14299,26860,14189,'last','0'),(14300,26869,14190,'last','0'),(14301,26878,14190,'last','0'),(14302,26876,14191,'nodata','5m'),(14303,26875,14192,'str','Server'),(14304,26893,14193,'str','Client'),(14305,26924,14194,'last','0'),(14306,26932,14195,'last','0'),(14307,26932,14196,'last','0'),(14308,26930,14197,'last','0'),(14309,26930,14198,'last','0'),(14310,26931,14199,'last','0'),(14311,26931,14200,'last','0'),(14312,26929,14201,'last','0'),(14313,26929,14202,'last','0'),(14314,26928,14203,'last','0'),(14315,26928,14204,'last','0'),(14316,26925,14205,'last','0'),(14317,26943,14206,'last','0'),(14318,26943,14207,'last','0'),(14319,26939,14208,'last','0'),(14320,26939,14209,'last','0'),(14321,26940,14210,'last','0'),(14322,26940,14211,'last','0'),(14323,26941,14212,'last','0'),(14324,26941,14213,'last','0'),(14325,26942,14214,'last','0'),(14326,26942,14215,'last','0'),(14327,26938,14216,'last','0'),(14328,26938,14217,'last','0'),(14329,26937,14218,'last','0'),(14330,26937,14219,'last','0'),(14331,26933,14220,'last','0'),(14332,26933,14221,'last','0'),(14333,26934,14222,'last','0'),(14334,26935,14223,'last','0'),(14335,26935,14224,'last','0'),(14336,26936,14225,'last','0'),(14337,26936,14226,'last','0'),(14370,27036,14243,'avg','5m'),(14372,27044,14245,'avg','5m'),(14373,27044,14246,'avg','5m'),(14374,27052,14247,'avg','5m'),(14376,27060,14249,'avg','5m'),(14377,27060,14250,'avg','5m'),(14378,27067,14251,'max','#3'),(14379,27066,14252,'min','5m'),(14380,27065,14253,'avg','5m'),(14463,27138,14288,'max','#3'),(14464,27139,14289,'min','5m'),(14465,27140,14290,'avg','5m'),(14468,27149,14293,'max','#3'),(14469,27150,14294,'min','5m'),(14470,27151,14295,'avg','5m'),(14508,27192,14311,'max','#3'),(14509,27193,14312,'min','5m'),(14510,27194,14313,'avg','5m'),(14513,27208,14316,'avg','5m'),(14514,27205,14317,'avg','5m'),(14515,27212,14318,'avg','5m'),(14516,27212,14318,'max','5m'),(14517,27212,14319,'avg','5m'),(14518,27212,14319,'max','5m'),(14519,27212,14320,'avg','5m'),(14520,27212,14320,'min','5m'),(14522,27214,14322,'diff',''),(14523,27214,14322,'strlen',''),(14536,27225,14327,'max','#3'),(14537,27226,14328,'min','5m'),(14538,27227,14329,'avg','5m'),(14541,27240,14332,'avg','5m'),(14542,27239,14333,'avg','5m'),(14545,27237,14336,'diff',''),(14546,27237,14336,'strlen',''),(14547,27236,14337,'diff',''),(14548,27236,14337,'strlen',''),(14552,27247,14339,'avg','5m'),(14553,27247,14339,'max','5m'),(14554,27247,14340,'avg','5m'),(14555,27247,14340,'min','5m'),(14570,27261,14347,'max','#3'),(14571,27262,14348,'min','5m'),(14572,27263,14349,'avg','5m'),(14587,27282,14356,'max','#3'),(14588,27283,14357,'min','5m'),(14589,27284,14358,'avg','5m'),(14592,27294,14361,'avg','5m'),(14593,27293,14362,'avg','5m'),(14594,27296,14363,'diff',''),(14595,27296,14363,'strlen',''),(14596,27295,14364,'diff',''),(14597,27295,14364,'strlen',''),(14598,27297,14365,'diff',''),(14599,27297,14365,'strlen',''),(14600,27299,14366,'avg','5m'),(14601,27301,14367,'avg','5m'),(14602,27298,14368,'avg','5m'),(14603,27300,14369,'avg','5m'),(14606,27314,14372,'avg','5m'),(14607,27314,14372,'max','5m'),(14608,27314,14373,'avg','5m'),(14609,27314,14373,'max','5m'),(14610,27314,14374,'avg','5m'),(14611,27314,14374,'min','5m'),(14612,27315,14375,'avg','5m'),(14613,27315,14375,'max','5m'),(14614,27315,14376,'avg','5m'),(14615,27315,14376,'max','5m'),(14616,27315,14377,'avg','5m'),(14617,27315,14377,'min','5m'),(14620,27318,14380,'avg','5m'),(14621,27318,14380,'max','5m'),(14622,27318,14381,'avg','5m'),(14623,27318,14381,'max','5m'),(14624,27318,14382,'avg','5m'),(14625,27318,14382,'min','5m'),(14626,27320,14383,'diff',''),(14627,27320,14383,'strlen',''),(14641,27333,14389,'max','#3'),(14642,27334,14390,'min','5m'),(14643,27335,14391,'avg','5m'),(14663,27365,14403,'max','#3'),(14664,27366,14404,'min','5m'),(14665,27367,14405,'avg','5m'),(14668,27376,14408,'avg','5m'),(14669,27378,14409,'diff',''),(14670,27378,14409,'strlen',''),(14671,27380,14410,'avg','5m'),(14672,27385,14411,'diff',''),(14673,27385,14411,'strlen',''),(14676,27382,14413,'diff',''),(14677,27382,14413,'strlen',''),(14678,27414,14414,'avg','5m'),(14679,27417,14415,'avg','5m'),(14681,27419,14417,'diff',''),(14682,27419,14417,'strlen',''),(14689,27421,14420,'avg','5m'),(14690,27421,14420,'min','5m'),(14693,27424,14423,'avg','5m'),(14695,27442,14425,'avg','5m'),(14696,27427,14426,'avg','5m'),(14698,27428,14428,'diff',''),(14699,27428,14428,'strlen',''),(14702,27445,14430,'diff',''),(14703,27445,14430,'strlen',''),(14722,27430,14437,'avg','5m'),(14723,27430,14437,'min','5m'),(14726,27447,14439,'avg','5m'),(14727,27447,14439,'min','5m'),(14747,27462,14451,'max','#3'),(14748,27463,14452,'min','5m'),(14749,27464,14453,'avg','5m'),(14752,27478,14456,'avg','5m'),(14753,27477,14457,'avg','5m'),(14756,27485,14460,'avg','5m'),(14757,27485,14460,'max','5m'),(14758,27485,14461,'avg','5m'),(14759,27485,14461,'max','5m'),(14760,27485,14462,'avg','5m'),(14761,27485,14462,'min','5m'),(14762,27483,14463,'diff',''),(14763,27483,14463,'strlen',''),(14776,27496,14468,'max','#3'),(14777,27497,14469,'min','5m'),(14778,27498,14470,'avg','5m'),(14781,27511,14473,'avg','5m'),(14782,27509,14474,'diff',''),(14783,27509,14474,'strlen',''),(14784,27516,14475,'avg','5m'),(14785,27517,14476,'avg','5m'),(14786,27517,14476,'max','5m'),(14787,27517,14477,'avg','5m'),(14788,27517,14477,'max','5m'),(14789,27517,14478,'avg','5m'),(14790,27517,14478,'min','5m'),(14806,27532,14486,'max','#3'),(14807,27533,14487,'min','5m'),(14808,27534,14488,'avg','5m'),(14811,27547,14491,'avg','5m'),(14812,27545,14492,'diff',''),(14813,27545,14492,'strlen',''),(14814,27544,14493,'diff',''),(14815,27544,14493,'strlen',''),(14816,27552,14494,'avg','5m'),(14817,27553,14495,'avg','5m'),(14818,27553,14495,'max','5m'),(14819,27553,14496,'avg','5m'),(14820,27553,14496,'max','5m'),(14821,27553,14497,'avg','5m'),(14822,27553,14497,'min','5m'),(14838,27568,14505,'max','#3'),(14839,27569,14506,'min','5m'),(14840,27570,14507,'avg','5m'),(14843,27586,14510,'avg','5m'),(14844,27584,14511,'avg','5m'),(14845,27584,14511,'max','5m'),(14849,27584,14513,'avg','5m'),(14850,27584,14513,'min','5m'),(14851,27582,14514,'diff',''),(14852,27582,14514,'strlen',''),(14853,27579,14515,'diff',''),(14854,27579,14515,'strlen',''),(14855,27590,14516,'avg','5m'),(14871,27608,14524,'max','#3'),(14872,27609,14525,'min','5m'),(14873,27610,14526,'avg','5m'),(14889,27631,14534,'max','#3'),(14890,27632,14535,'min','5m'),(14891,27633,14536,'avg','5m'),(14907,27654,14544,'max','#3'),(14908,27655,14545,'min','5m'),(14909,27656,14546,'avg','5m'),(14912,27671,14549,'avg','5m'),(14913,27670,14550,'avg','5m'),(14914,27672,14551,'avg','5m'),(14915,27672,14551,'max','5m'),(14916,27672,14552,'avg','5m'),(14917,27672,14552,'max','5m'),(14918,27672,14553,'avg','5m'),(14919,27672,14553,'min','5m'),(14922,27678,14556,'diff',''),(14923,27678,14556,'strlen',''),(14924,27677,14557,'diff',''),(14925,27677,14557,'strlen',''),(14972,27734,14582,'max','#3'),(14973,27735,14583,'min','5m'),(14974,27736,14584,'avg','5m'),(14977,27753,14587,'avg','5m'),(14978,27752,14588,'avg','5m'),(14979,27751,14589,'avg','5m'),(14980,27751,14589,'max','5m'),(14981,27751,14590,'avg','5m'),(14982,27751,14590,'max','5m'),(14983,27751,14591,'avg','5m'),(14984,27751,14591,'min','5m'),(14985,27750,14592,'diff',''),(14986,27750,14592,'strlen',''),(15000,27766,14598,'max','#3'),(15001,27767,14599,'min','5m'),(15002,27768,14600,'avg','5m'),(15005,27777,14603,'diff',''),(15006,27777,14603,'strlen',''),(15013,27784,14606,'avg','5m'),(15014,27784,14606,'min','5m'),(15015,27785,14607,'diff',''),(15016,27785,14607,'strlen',''),(15032,27800,14615,'max','#3'),(15033,27801,14616,'min','5m'),(15034,27802,14617,'avg','5m'),(15038,27813,14621,'diff',''),(15039,27813,14621,'strlen',''),(15040,27820,14622,'avg','5m'),(15041,27819,14623,'avg','5m'),(15042,27821,14624,'avg','5m'),(15043,27821,14624,'max','5m'),(15044,27821,14625,'avg','5m'),(15045,27821,14625,'max','5m'),(15046,27821,14626,'avg','5m'),(15047,27821,14626,'min','5m'),(15094,27882,14652,'max','#3'),(15095,27883,14653,'min','5m'),(15096,27884,14654,'avg','5m'),(15099,27899,14657,'avg','5m'),(15100,27897,14658,'avg','5m'),(15101,27897,14658,'max','5m'),(15102,27897,14659,'avg','5m'),(15103,27897,14659,'max','5m'),(15104,27897,14660,'avg','5m'),(15105,27897,14660,'min','5m'),(15106,27894,14661,'diff',''),(15107,27894,14661,'strlen',''),(15108,27895,14662,'diff',''),(15109,27895,14662,'strlen',''),(15110,27904,14663,'avg','5m'),(15111,27905,14664,'avg','5m'),(15112,27905,14664,'max','5m'),(15113,27905,14665,'avg','5m'),(15114,27905,14665,'max','5m'),(15115,27905,14666,'avg','5m'),(15116,27905,14666,'min','5m'),(15117,27906,14667,'avg','5m'),(15118,27906,14668,'avg','5m'),(15131,27919,14673,'max','#3'),(15132,27920,14674,'min','5m'),(15133,27921,14675,'avg','5m'),(15136,27936,14678,'avg','5m'),(15137,27933,14679,'avg','5m'),(15138,27931,14680,'diff',''),(15139,27931,14680,'strlen',''),(15146,27941,14683,'avg','5m'),(15147,27941,14683,'min','5m'),(15163,27956,14691,'max','#3'),(15164,27957,14692,'min','5m'),(15165,27958,14693,'avg','5m'),(15168,27975,14696,'avg','5m'),(15169,27974,14697,'avg','5m'),(15170,27970,14698,'diff',''),(15171,27970,14698,'strlen',''),(15172,27967,14699,'diff',''),(15173,27967,14699,'strlen',''),(15186,27986,14704,'max','#3'),(15187,27987,14705,'min','5m'),(15188,27988,14706,'avg','5m'),(15191,27999,14709,'diff',''),(15192,27999,14709,'strlen',''),(15193,27998,14710,'diff',''),(15194,27998,14710,'strlen',''),(15195,28003,14711,'avg','5m'),(15196,28004,14712,'avg','5m'),(15209,28015,14717,'max','#3'),(15210,28016,14718,'min','5m'),(15211,28017,14719,'avg','5m'),(15214,28031,14722,'avg','5m'),(15215,28028,14723,'avg','5m'),(15216,28027,14724,'diff',''),(15217,28027,14724,'strlen',''),(15580,28045,14860,'avg','5m'),(15581,28046,14861,'avg','5m'),(15582,28046,14862,'avg','5m'),(15597,28070,14869,'max','#3'),(15598,28071,14870,'min','5m'),(15599,28072,14871,'avg','5m'),(15602,28084,14874,'avg','5m'),(15603,28085,14875,'avg','5m'),(15604,28085,14876,'avg','5m'),(15618,28107,14882,'max','#3'),(15619,28108,14883,'min','5m'),(15620,28109,14884,'avg','5m'),(15678,28130,14906,'max','#3'),(15679,28131,14907,'min','5m'),(15680,28132,14908,'avg','5m'),(15683,28143,14911,'avg','5m'),(15684,28142,14912,'diff',''),(15685,28142,14912,'strlen',''),(15686,28141,14913,'diff',''),(15687,28141,14913,'strlen',''),(15688,28150,14914,'avg','5m'),(15689,28150,14914,'max','5m'),(15690,28150,14915,'avg','5m'),(15691,28150,14915,'max','5m'),(15692,28150,14916,'avg','5m'),(15693,28150,14916,'min','5m'),(15694,28151,14917,'avg','5m'),(15697,28162,14920,'avg','5m'),(15698,28163,14921,'avg','5m'),(15699,28163,14922,'avg','5m'),(15713,28185,14928,'max','#3'),(15714,28186,14929,'min','5m'),(15715,28187,14930,'avg','5m'),(15721,28201,14934,'avg','5m'),(15722,28201,14934,'max','5m'),(15723,28201,14935,'avg','5m'),(15724,28201,14935,'min','5m'),(15726,28204,14937,'diff',''),(15727,28204,14937,'strlen',''),(15729,27030,14939,'last',''),(15730,27607,14940,'last',''),(15731,27032,14941,'last',''),(15732,27191,14942,'last',''),(15733,27332,14943,'last',''),(15734,27461,14944,'last',''),(15735,27531,14945,'last',''),(15736,27567,14946,'last',''),(15737,27630,14947,'last',''),(15738,27653,14948,'last',''),(15739,27733,14949,'last',''),(15740,27799,14950,'last',''),(15741,27955,14951,'last',''),(15742,28069,14952,'last',''),(15743,28129,14953,'last',''),(15744,27038,14954,'avg','5m'),(15745,27054,14955,'avg','5m'),(15746,28052,14956,'avg','5m'),(15747,28091,14957,'avg','5m'),(15748,28169,14958,'avg','5m'),(16352,27143,15161,'max','{$SNMP_TIMEOUT}'),(16353,27618,15162,'max','{$SNMP_TIMEOUT}'),(16354,28025,15163,'max','{$SNMP_TIMEOUT}'),(16375,27154,15170,'max','{$SNMP_TIMEOUT}'),(16376,27202,15171,'max','{$SNMP_TIMEOUT}'),(16377,27235,15172,'max','{$SNMP_TIMEOUT}'),(16378,27271,15173,'max','{$SNMP_TIMEOUT}'),(16379,27292,15174,'max','{$SNMP_TIMEOUT}'),(16380,27343,15175,'max','{$SNMP_TIMEOUT}'),(16381,27375,15176,'max','{$SNMP_TIMEOUT}'),(16382,27472,15177,'max','{$SNMP_TIMEOUT}'),(16383,27506,15178,'max','{$SNMP_TIMEOUT}'),(16384,27542,15179,'max','{$SNMP_TIMEOUT}'),(16385,27578,15180,'max','{$SNMP_TIMEOUT}'),(16386,27641,15181,'max','{$SNMP_TIMEOUT}'),(16387,27664,15182,'max','{$SNMP_TIMEOUT}'),(16388,27744,15183,'max','{$SNMP_TIMEOUT}'),(16389,27776,15184,'max','{$SNMP_TIMEOUT}'),(16390,27810,15185,'max','{$SNMP_TIMEOUT}'),(16391,27892,15186,'max','{$SNMP_TIMEOUT}'),(16392,27929,15187,'max','{$SNMP_TIMEOUT}'),(16393,27966,15188,'max','{$SNMP_TIMEOUT}'),(16394,27996,15189,'max','{$SNMP_TIMEOUT}'),(16395,28080,15190,'max','{$SNMP_TIMEOUT}'),(16396,28117,15191,'max','{$SNMP_TIMEOUT}'),(16397,28140,15192,'max','{$SNMP_TIMEOUT}'),(16398,28195,15193,'max','{$SNMP_TIMEOUT}'),(16445,28210,15208,'diff',''),(16446,28210,15208,'strlen',''),(16447,28208,15209,'diff',''),(16448,28208,15209,'strlen',''),(16457,28218,15214,'avg','5m'),(16458,28218,15214,'min','5m'),(16459,28221,15215,'avg','5m'),(16472,28233,15220,'max','#3'),(16473,28234,15221,'min','5m'),(16474,28235,15222,'avg','5m'),(16476,28243,15224,'max','{$SNMP_TIMEOUT}'),(16477,28246,15225,'avg','5m'),(16484,28247,15228,'avg','5m'),(16818,27213,15330,'count','#1,{$FAN_CRIT_STATUS},eq'),(16819,27479,15331,'count','#1,{$PSU_CRIT_STATUS},eq'),(16820,27479,15332,'count','#1,{$PSU_OK_STATUS},ne'),(16821,27480,15333,'count','#1,{$FAN_CRIT_STATUS},eq'),(16822,27480,15334,'count','#1,{$FAN_OK_STATUS},ne'),(16823,27784,15335,'avg','5m'),(16824,27783,15335,'last','0'),(16825,27784,15335,'max','5m'),(16826,27784,15336,'avg','5m'),(16827,27783,15336,'last','0'),(16828,27784,15336,'max','5m'),(16829,27786,15337,'count','#1,{$PSU_CRIT_STATUS},eq'),(16830,27786,15338,'count','#1,{$PSU_WARN_STATUS},eq'),(16831,27787,15339,'count','#1,{$FAN_CRIT_STATUS},eq'),(16832,27554,15340,'count','#1,{$PSU_CRIT_STATUS},eq'),(16833,27555,15341,'count','#1,{$FAN_CRIT_STATUS},eq'),(16834,27421,15342,'avg','5m'),(16835,27420,15342,'last','0'),(16836,27421,15342,'max','5m'),(16837,27421,15343,'avg','5m'),(16838,27420,15343,'last','0'),(16839,27421,15343,'max','5m'),(16840,27422,15344,'count','#1,{$PSU_CRIT_STATUS:\"critical\"},eq'),(16841,27422,15344,'count','#1,{$PSU_CRIT_STATUS:\"shutdown\"},eq'),(16842,27422,15345,'count','#1,{$PSU_WARN_STATUS:\"warning\"},eq'),(16843,27422,15345,'count','#1,{$PSU_WARN_STATUS:\"notFunctioning\"},eq'),(16844,27423,15346,'count','#1,{$FAN_CRIT_STATUS:\"critical\"},eq'),(16845,27423,15346,'count','#1,{$FAN_CRIT_STATUS:\"shutdown\"},eq'),(16846,27423,15347,'count','#1,{$FAN_WARN_STATUS:\"warning\"},eq'),(16847,27423,15347,'count','#1,{$FAN_WARN_STATUS:\"notFunctioning\"},eq'),(16848,27430,15348,'avg','5m'),(16849,27429,15348,'last','0'),(16850,27430,15348,'max','5m'),(16851,27447,15349,'avg','5m'),(16852,27446,15349,'last','0'),(16853,27447,15349,'max','5m'),(16854,28218,15350,'avg','5m'),(16855,28217,15350,'last','0'),(16856,28218,15350,'max','5m'),(16857,27430,15351,'avg','5m'),(16858,27429,15351,'last','0'),(16859,27430,15351,'max','5m'),(16860,27447,15352,'avg','5m'),(16861,27446,15352,'last','0'),(16862,27447,15352,'max','5m'),(16863,28218,15353,'avg','5m'),(16864,28217,15353,'last','0'),(16865,28218,15353,'max','5m'),(16866,27431,15354,'count','#1,{$PSU_CRIT_STATUS:\"critical\"},eq'),(16867,27431,15354,'count','#1,{$PSU_CRIT_STATUS:\"shutdown\"},eq'),(16868,27448,15355,'count','#1,{$PSU_CRIT_STATUS:\"critical\"},eq'),(16869,27448,15355,'count','#1,{$PSU_CRIT_STATUS:\"shutdown\"},eq'),(16870,28216,15356,'count','#1,{$PSU_CRIT_STATUS:\"critical\"},eq'),(16871,28216,15356,'count','#1,{$PSU_CRIT_STATUS:\"shutdown\"},eq'),(16872,27431,15357,'count','#1,{$PSU_WARN_STATUS:\"warning\"},eq'),(16873,27431,15357,'count','#1,{$PSU_WARN_STATUS:\"notFunctioning\"},eq'),(16874,27448,15358,'count','#1,{$PSU_WARN_STATUS:\"warning\"},eq'),(16875,27448,15358,'count','#1,{$PSU_WARN_STATUS:\"notFunctioning\"},eq'),(16876,28216,15359,'count','#1,{$PSU_WARN_STATUS:\"warning\"},eq'),(16877,28216,15359,'count','#1,{$PSU_WARN_STATUS:\"notFunctioning\"},eq'),(16878,27432,15360,'count','#1,{$FAN_CRIT_STATUS:\"critical\"},eq'),(16879,27432,15360,'count','#1,{$FAN_CRIT_STATUS:\"shutdown\"},eq'),(16880,27449,15361,'count','#1,{$FAN_CRIT_STATUS:\"critical\"},eq'),(16881,27449,15361,'count','#1,{$FAN_CRIT_STATUS:\"shutdown\"},eq'),(16882,28215,15362,'count','#1,{$FAN_CRIT_STATUS:\"critical\"},eq'),(16883,28215,15362,'count','#1,{$FAN_CRIT_STATUS:\"shutdown\"},eq'),(16884,27432,15363,'count','#1,{$FAN_WARN_STATUS:\"warning\"},eq'),(16885,27432,15363,'count','#1,{$FAN_WARN_STATUS:\"notFunctioning\"},eq'),(16886,27449,15364,'count','#1,{$FAN_WARN_STATUS:\"warning\"},eq'),(16887,27449,15364,'count','#1,{$FAN_WARN_STATUS:\"notFunctioning\"},eq'),(16888,28215,15365,'count','#1,{$FAN_WARN_STATUS:\"warning\"},eq'),(16889,28215,15365,'count','#1,{$FAN_WARN_STATUS:\"notFunctioning\"},eq'),(16890,27518,15366,'count','#1,{$PSU_CRIT_STATUS},eq'),(16891,27519,15367,'count','#1,{$FAN_CRIT_STATUS},eq'),(16892,27584,15368,'avg','5m'),(16893,27585,15368,'last','0'),(16894,27584,15368,'max','5m'),(16895,27593,15369,'count','#1,{$PSU_CRIT_STATUS},eq'),(16896,27595,15370,'count','#1,{$FAN_CRIT_STATUS},eq'),(16897,27673,15371,'count','#1,{$FAN_CRIT_STATUS:\"fanError\"},eq'),(16898,27673,15371,'count','#1,{$FAN_CRIT_STATUS:\"hardwareFaulty\"},eq'),(16899,27674,15372,'count','#1,{$PSU_CRIT_STATUS:\"psuError\"},eq'),(16900,27674,15372,'count','#1,{$PSU_CRIT_STATUS:\"rpsError\"},eq'),(16901,27674,15372,'count','#1,{$PSU_CRIT_STATUS:\"hardwareFaulty\"},eq'),(16902,28154,15373,'count','#1,{$FAN_CRIT_STATUS:\"bad\"},eq'),(16903,28154,15374,'count','#1,{$FAN_WARN_STATUS:\"warning\"},eq'),(16904,28155,15375,'count','#1,{$PSU_CRIT_STATUS:\"bad\"},eq'),(16905,28155,15376,'count','#1,{$PSU_WARN_STATUS:\"warning\"},eq'),(16906,27822,15377,'count','#1,{$FAN_CRIT_STATUS},eq'),(16907,27823,15378,'count','#1,{$PSU_CRIT_STATUS},eq'),(16908,27312,15379,'count','#1,{$PSU_CRIT_STATUS},eq'),(16909,27312,15380,'count','#1,{$PSU_OK_STATUS},ne'),(16910,27313,15381,'count','#1,{$FAN_CRIT_STATUS},eq'),(16911,27313,15382,'count','#1,{$FAN_OK_STATUS},ne'),(16912,27316,15383,'count','#1,{$PSU_CRIT_STATUS},eq'),(16913,27316,15384,'count','#1,{$PSU_OK_STATUS},ne'),(16914,27317,15385,'count','#1,{$FAN_CRIT_STATUS},eq'),(16915,27317,15386,'count','#1,{$FAN_OK_STATUS},ne'),(16916,28201,15387,'avg','5m'),(16917,28200,15387,'last','0'),(16918,28201,15387,'max','5m'),(16919,28202,15388,'count','#1,{$FAN_CRIT_STATUS},eq'),(16920,28206,15389,'count','#1,{$PSU_CRIT_STATUS},eq'),(16921,27247,15390,'avg','5m'),(16922,27246,15390,'last','0'),(16923,27247,15390,'max','5m'),(16924,27248,15391,'count','#1,{$PSU_CRIT_STATUS},eq'),(16925,27248,15392,'count','#1,{$PSU_OK_STATUS},ne'),(16926,27250,15393,'count','#1,{$FAN_CRIT_STATUS},eq'),(16927,27250,15394,'count','#1,{$FAN_OK_STATUS},ne'),(16928,27755,15395,'count','#1,{$FAN_CRIT_STATUS},eq'),(16929,27941,15396,'avg','5m'),(16930,27940,15396,'last','0'),(16931,27941,15396,'max','5m'),(16932,27941,15397,'avg','5m'),(16933,27940,15397,'last','0'),(16934,27941,15397,'max','5m'),(16935,27942,15398,'count','#1,{$FAN_CRIT_STATUS:\"failed\"},eq'),(16936,27943,15399,'count','#1,{$PSU_CRIT_STATUS:\"failed\"},eq'),(17237,27077,15490,'last',''),(17238,27077,15490,'diff',''),(17241,27604,15492,'last',''),(17242,27604,15492,'diff',''),(17243,28013,15493,'last',''),(17244,28013,15493,'diff',''),(17249,27087,15496,'last',''),(17250,27087,15496,'diff',''),(17253,27627,15498,'last',''),(17254,27627,15498,'diff',''),(17255,27984,15499,'last',''),(17256,27984,15499,'diff',''),(17261,27127,15502,'last',''),(17262,27127,15502,'diff',''),(17265,28105,15504,'last',''),(17266,28105,15504,'diff',''),(17269,27097,15506,'last',''),(17270,27097,15506,'diff',''),(17273,27107,15508,'last',''),(17274,27107,15508,'diff',''),(17277,27188,15510,'last',''),(17278,27188,15510,'diff',''),(17279,27223,15511,'last',''),(17280,27223,15511,'diff',''),(17281,27259,15512,'last',''),(17282,27259,15512,'diff',''),(17283,27280,15513,'last',''),(17284,27280,15513,'diff',''),(17285,27329,15514,'last',''),(17286,27329,15514,'diff',''),(17287,27458,15515,'last',''),(17288,27458,15515,'diff',''),(17289,27494,15516,'last',''),(17290,27494,15516,'diff',''),(17291,27528,15517,'last',''),(17292,27528,15517,'diff',''),(17293,27564,15518,'last',''),(17294,27564,15518,'diff',''),(17295,27650,15519,'last',''),(17296,27650,15519,'diff',''),(17297,27730,15520,'last',''),(17298,27730,15520,'diff',''),(17299,27764,15521,'last',''),(17300,27764,15521,'diff',''),(17301,27796,15522,'last',''),(17302,27796,15522,'diff',''),(17303,27880,15523,'last',''),(17304,27880,15523,'diff',''),(17305,27917,15524,'last',''),(17306,27917,15524,'diff',''),(17307,27952,15525,'last',''),(17308,27952,15525,'diff',''),(17309,28066,15526,'last',''),(17310,28066,15526,'diff',''),(17311,28126,15527,'last',''),(17312,28126,15527,'diff',''),(17313,28183,15528,'last',''),(17314,28183,15528,'diff',''),(17315,28231,15529,'last',''),(17316,28231,15529,'diff',''),(17357,27074,15550,'avg','15m'),(17358,27071,15550,'last',''),(17359,27075,15550,'avg','15m'),(17360,27076,15551,'avg','5m'),(17361,27073,15551,'avg','5m'),(17367,27599,15553,'avg','15m'),(17368,27603,15553,'last',''),(17369,27602,15553,'avg','15m'),(17370,28008,15554,'avg','15m'),(17371,28012,15554,'last',''),(17372,28011,15554,'avg','15m'),(17373,27598,15555,'avg','5m'),(17374,27601,15555,'avg','5m'),(17375,28007,15556,'avg','5m'),(17376,28010,15556,'avg','5m'),(17387,27084,15559,'avg','15m'),(17388,27081,15559,'last',''),(17389,27085,15559,'avg','15m'),(17390,27086,15560,'avg','5m'),(17391,27083,15560,'avg','5m'),(17397,27622,15562,'avg','15m'),(17398,27626,15562,'last',''),(17399,27625,15562,'avg','15m'),(17400,27979,15563,'avg','15m'),(17401,27983,15563,'last',''),(17402,27982,15563,'avg','15m'),(17403,27621,15564,'avg','5m'),(17404,27624,15564,'avg','5m'),(17405,27978,15565,'avg','5m'),(17406,27981,15565,'avg','5m'),(17417,27124,15568,'avg','15m'),(17418,27121,15568,'last',''),(17419,27125,15568,'avg','15m'),(17420,27126,15569,'avg','5m'),(17421,27123,15569,'avg','5m'),(17427,28100,15571,'avg','15m'),(17428,28104,15571,'last',''),(17429,28103,15571,'avg','15m'),(17430,28099,15572,'avg','5m'),(17431,28102,15572,'avg','5m'),(17437,27094,15574,'avg','15m'),(17438,27091,15574,'last',''),(17439,27095,15574,'avg','15m'),(17440,27096,15575,'avg','5m'),(17441,27093,15575,'avg','5m'),(17447,27104,15577,'avg','15m'),(17448,27101,15577,'last',''),(17449,27105,15577,'avg','15m'),(17450,27106,15578,'avg','5m'),(17451,27103,15578,'avg','5m'),(17457,27183,15580,'avg','15m'),(17458,27187,15580,'last',''),(17459,27186,15580,'avg','15m'),(17460,27218,15581,'avg','15m'),(17461,27222,15581,'last',''),(17462,27221,15581,'avg','15m'),(17463,27254,15582,'avg','15m'),(17464,27258,15582,'last',''),(17465,27257,15582,'avg','15m'),(17466,27275,15583,'avg','15m'),(17467,27279,15583,'last',''),(17468,27278,15583,'avg','15m'),(17469,27324,15584,'avg','15m'),(17470,27328,15584,'last',''),(17471,27327,15584,'avg','15m'),(17472,27453,15585,'avg','15m'),(17473,27457,15585,'last',''),(17474,27456,15585,'avg','15m'),(17475,27489,15586,'avg','15m'),(17476,27493,15586,'last',''),(17477,27492,15586,'avg','15m'),(17478,27523,15587,'avg','15m'),(17479,27527,15587,'last',''),(17480,27526,15587,'avg','15m'),(17481,27559,15588,'avg','15m'),(17482,27563,15588,'last',''),(17483,27562,15588,'avg','15m'),(17484,27645,15589,'avg','15m'),(17485,27649,15589,'last',''),(17486,27648,15589,'avg','15m'),(17487,27725,15590,'avg','15m'),(17488,27729,15590,'last',''),(17489,27728,15590,'avg','15m'),(17490,27759,15591,'avg','15m'),(17491,27763,15591,'last',''),(17492,27762,15591,'avg','15m'),(17493,27791,15592,'avg','15m'),(17494,27795,15592,'last',''),(17495,27794,15592,'avg','15m'),(17496,27875,15593,'avg','15m'),(17497,27879,15593,'last',''),(17498,27878,15593,'avg','15m'),(17499,27912,15594,'avg','15m'),(17500,27916,15594,'last',''),(17501,27915,15594,'avg','15m'),(17502,27947,15595,'avg','15m'),(17503,27951,15595,'last',''),(17504,27950,15595,'avg','15m'),(17505,28061,15596,'avg','15m'),(17506,28065,15596,'last',''),(17507,28064,15596,'avg','15m'),(17508,28121,15597,'avg','15m'),(17509,28125,15597,'last',''),(17510,28124,15597,'avg','15m'),(17511,28178,15598,'avg','15m'),(17512,28182,15598,'last',''),(17513,28181,15598,'avg','15m'),(17514,28226,15599,'avg','15m'),(17515,28230,15599,'last',''),(17516,28229,15599,'avg','15m'),(17517,27182,15600,'avg','5m'),(17518,27185,15600,'avg','5m'),(17519,27217,15601,'avg','5m'),(17520,27220,15601,'avg','5m'),(17521,27253,15602,'avg','5m'),(17522,27256,15602,'avg','5m'),(17523,27274,15603,'avg','5m'),(17524,27277,15603,'avg','5m'),(17525,27323,15604,'avg','5m'),(17526,27326,15604,'avg','5m'),(17527,27452,15605,'avg','5m'),(17528,27455,15605,'avg','5m'),(17529,27488,15606,'avg','5m'),(17530,27491,15606,'avg','5m'),(17531,27522,15607,'avg','5m'),(17532,27525,15607,'avg','5m'),(17533,27558,15608,'avg','5m'),(17534,27561,15608,'avg','5m'),(17535,27644,15609,'avg','5m'),(17536,27647,15609,'avg','5m'),(17537,27724,15610,'avg','5m'),(17538,27727,15610,'avg','5m'),(17539,27758,15611,'avg','5m'),(17540,27761,15611,'avg','5m'),(17541,27790,15612,'avg','5m'),(17542,27793,15612,'avg','5m'),(17543,27874,15613,'avg','5m'),(17544,27877,15613,'avg','5m'),(17545,27911,15614,'avg','5m'),(17546,27914,15614,'avg','5m'),(17547,27946,15615,'avg','5m'),(17548,27949,15615,'avg','5m'),(17549,28060,15616,'avg','5m'),(17550,28063,15616,'avg','5m'),(17551,28120,15617,'avg','5m'),(17552,28123,15617,'avg','5m'),(17553,28177,15618,'avg','5m'),(17554,28180,15618,'avg','5m'),(17555,28225,15619,'avg','5m'),(17556,28228,15619,'avg','5m'),(17657,28251,15640,'max','10m'),(17658,28250,15641,'avg','10m'),(17659,28252,15642,'last',''),(17660,28253,15643,'last',''),(17661,28254,15644,'last',''),(17662,28255,15645,'last',''),(17663,28256,15646,'last',''),(17664,28257,15647,'last',''),(17665,28258,15648,'last',''),(17666,28259,15649,'last',''),(17667,28260,15650,'last',''),(17668,28261,15651,'last',''),(17669,28262,15652,'last',''),(17670,28263,15653,'last',''),(17671,28264,15654,'last',''),(17672,28265,15655,'last',''),(17673,28266,15656,'last',''),(17674,28267,15657,'last',''),(17675,28268,15658,'last',''),(17676,28269,15659,'last',''),(17677,28270,15660,'last',''),(17678,28271,15661,'last',''),(17679,28272,15662,'last',''),(17680,28273,15663,'last',''),(17681,28274,15664,'last',''),(17682,28275,15665,'last',''),(17683,28276,15666,'last',''),(17684,28277,15667,'last',''),(17685,28278,15668,'last',''),(17686,28279,15669,'last',''),(17687,27091,15670,'change',''),(17688,27091,15670,'last',''),(17689,27090,15670,'last',''),(17690,27097,15670,'last',''),(17691,27091,15670,'prev',''),(17692,27101,15671,'change',''),(17693,27101,15671,'last',''),(17694,27100,15671,'last',''),(17695,27107,15671,'last',''),(17696,27101,15671,'prev',''),(17697,27187,15672,'change',''),(17698,27187,15672,'last',''),(17699,27189,15672,'last',''),(17700,27188,15672,'last',''),(17701,27187,15672,'prev',''),(17702,27222,15673,'change',''),(17703,27222,15673,'last',''),(17704,27224,15673,'last',''),(17705,27223,15673,'last',''),(17706,27222,15673,'prev',''),(17707,27258,15674,'change',''),(17708,27258,15674,'last',''),(17709,27260,15674,'last',''),(17710,27259,15674,'last',''),(17711,27258,15674,'prev',''),(17712,27279,15675,'change',''),(17713,27279,15675,'last',''),(17714,27281,15675,'last',''),(17715,27280,15675,'last',''),(17716,27279,15675,'prev',''),(17717,27328,15676,'change',''),(17718,27328,15676,'last',''),(17719,27330,15676,'last',''),(17720,27329,15676,'last',''),(17721,27328,15676,'prev',''),(17722,27457,15677,'change',''),(17723,27457,15677,'last',''),(17724,27459,15677,'last',''),(17725,27458,15677,'last',''),(17726,27457,15677,'prev',''),(17727,27493,15678,'change',''),(17728,27493,15678,'last',''),(17729,27495,15678,'last',''),(17730,27494,15678,'last',''),(17731,27493,15678,'prev',''),(17732,27527,15679,'change',''),(17733,27527,15679,'last',''),(17734,27529,15679,'last',''),(17735,27528,15679,'last',''),(17736,27527,15679,'prev',''),(17737,27563,15680,'change',''),(17738,27563,15680,'last',''),(17739,27565,15680,'last',''),(17740,27564,15680,'last',''),(17741,27563,15680,'prev',''),(17742,27649,15681,'change',''),(17743,27649,15681,'last',''),(17744,27651,15681,'last',''),(17745,27650,15681,'last',''),(17746,27649,15681,'prev',''),(17747,27729,15682,'change',''),(17748,27729,15682,'last',''),(17749,27731,15682,'last',''),(17750,27730,15682,'last',''),(17751,27729,15682,'prev',''),(17752,27763,15683,'change',''),(17753,27763,15683,'last',''),(17754,27765,15683,'last',''),(17755,27764,15683,'last',''),(17756,27763,15683,'prev',''),(17757,27795,15684,'change',''),(17758,27795,15684,'last',''),(17759,27797,15684,'last',''),(17760,27796,15684,'last',''),(17761,27795,15684,'prev',''),(17762,27879,15685,'change',''),(17763,27879,15685,'last',''),(17764,27881,15685,'last',''),(17765,27880,15685,'last',''),(17766,27879,15685,'prev',''),(17767,27916,15686,'change',''),(17768,27916,15686,'last',''),(17769,27918,15686,'last',''),(17770,27917,15686,'last',''),(17771,27916,15686,'prev',''),(17772,27951,15687,'change',''),(17773,27951,15687,'last',''),(17774,27953,15687,'last',''),(17775,27952,15687,'last',''),(17776,27951,15687,'prev',''),(17777,28065,15688,'change',''),(17778,28065,15688,'last',''),(17779,28067,15688,'last',''),(17780,28066,15688,'last',''),(17781,28065,15688,'prev',''),(17782,28125,15689,'change',''),(17783,28125,15689,'last',''),(17784,28127,15689,'last',''),(17785,28126,15689,'last',''),(17786,28125,15689,'prev',''),(17787,28182,15690,'change',''),(17788,28182,15690,'last',''),(17789,28184,15690,'last',''),(17790,28183,15690,'last',''),(17791,28182,15690,'prev',''),(17792,28230,15691,'change',''),(17793,28230,15691,'last',''),(17794,28232,15691,'last',''),(17795,28231,15691,'last',''),(17796,28230,15691,'prev',''),(17797,27071,15692,'change',''),(17798,27071,15692,'last',''),(17799,27070,15692,'last',''),(17800,27077,15692,'last',''),(17801,27071,15692,'prev',''),(17802,27603,15693,'change',''),(17803,27603,15693,'last',''),(17804,27605,15693,'last',''),(17805,27604,15693,'last',''),(17806,27603,15693,'prev',''),(17807,28012,15694,'change',''),(17808,28012,15694,'last',''),(17809,28014,15694,'last',''),(17810,28013,15694,'last',''),(17811,28012,15694,'prev',''),(17812,27081,15695,'change',''),(17813,27081,15695,'last',''),(17814,27080,15695,'last',''),(17815,27087,15695,'last',''),(17816,27081,15695,'prev',''),(17817,27626,15696,'change',''),(17818,27626,15696,'last',''),(17819,27628,15696,'last',''),(17820,27627,15696,'last',''),(17821,27626,15696,'prev',''),(17822,27983,15697,'change',''),(17823,27983,15697,'last',''),(17824,27985,15697,'last',''),(17825,27984,15697,'last',''),(17826,27983,15697,'prev',''),(17827,27121,15698,'change',''),(17828,27121,15698,'last',''),(17829,27120,15698,'last',''),(17830,27127,15698,'last',''),(17831,27121,15698,'prev',''),(17832,28104,15699,'change',''),(17833,28104,15699,'last',''),(17834,28106,15699,'last',''),(17835,28105,15699,'last',''),(17836,28104,15699,'prev',''),(17837,28281,15700,'last',''),(17838,28282,15701,'max','#3'),(17839,28283,15702,'min','5m'),(17840,28284,15703,'avg','5m'),(17841,28291,15704,'last',''),(17842,28292,15705,'max','{$SNMP_TIMEOUT}'),(17843,28295,15706,'avg','5m'),(17844,28298,15706,'avg','5m'),(17845,28296,15707,'avg','15m'),(17846,28300,15707,'last',''),(17847,28299,15707,'avg','15m'),(17848,28300,15708,'change',''),(17849,28300,15708,'last',''),(17850,28302,15708,'last',''),(17851,28301,15708,'last',''),(17852,28300,15708,'prev',''),(17853,28301,15709,'last',''),(17854,28301,15709,'diff',''),(17855,28310,15710,'avg','5m'),(17856,28316,15711,'avg','5m'),(17857,28322,15712,'avg','5m'),(17858,28322,15713,'avg','5m'),(17859,28323,15714,'avg','5m'),(17860,28324,15714,'last','0'),(17861,28323,15714,'max','5m'),(17862,28323,15715,'avg','5m'),(17863,28323,15715,'max','5m'),(17864,28323,15716,'avg','5m'),(17865,28323,15716,'min','5m'),(17866,28326,15717,'count','#1,{$FAN_CRIT_STATUS},eq'),(17867,28328,15718,'diff',''),(17868,28328,15718,'strlen',''),(17869,28329,15719,'count','#1,{$PSU_CRIT_STATUS},eq'),(17870,27238,15720,'count','#1,{$HEALTH_CRIT_STATUS},eq'),(17871,27238,15721,'count','#1,{$HEALTH_WARN_STATUS:\"offline\"},eq'),(17872,27238,15721,'count','#1,{$HEALTH_WARN_STATUS:\"testing\"},eq'),(17873,27814,15722,'count','#1,{$HEALTH_CRIT_STATUS},eq'),(17874,28330,15723,'max','#3'),(17875,28331,15724,'min','5m'),(17876,28332,15725,'avg','5m'),(17877,28339,15726,'last',''),(17878,28340,15727,'max','{$SNMP_TIMEOUT}'),(17879,28341,15728,'count','#1,{$HEALTH_DISASTER_STATUS},eq'),(17880,28341,15729,'count','#1,{$HEALTH_CRIT_STATUS},eq'),(17881,28341,15730,'count','#1,{$HEALTH_WARN_STATUS},eq'),(17882,28344,15731,'diff',''),(17883,28344,15731,'strlen',''),(17884,28345,15732,'diff',''),(17885,28345,15732,'strlen',''),(17886,28354,15733,'avg','5m'),(17887,28355,15733,'last','0'),(17888,28354,15733,'max','5m'),(17889,28354,15734,'avg','5m'),(17890,28355,15734,'last','0'),(17891,28354,15734,'max','5m'),(17892,28354,15735,'avg','5m'),(17893,28354,15735,'min','5m'),(17894,28356,15736,'avg','5m'),(17895,28357,15736,'last','0'),(17896,28356,15736,'max','5m'),(17897,28356,15737,'avg','5m'),(17898,28357,15737,'last','0'),(17899,28356,15737,'max','5m'),(17900,28356,15738,'avg','5m'),(17901,28356,15738,'min','5m'),(17902,28358,15739,'count','#1,{$PSU_CRIT_STATUS:\"critical\"},eq'),(17903,28358,15739,'count','#1,{$PSU_CRIT_STATUS:\"nonRecoverable\"},eq'),(17904,28358,15740,'count','#1,{$PSU_WARN_STATUS:\"nonCritical\"},eq'),(17905,28359,15741,'count','#1,{$FAN_CRIT_STATUS:\"criticalUpper\"},eq'),(17906,28359,15741,'count','#1,{$FAN_CRIT_STATUS:\"nonRecoverableUpper\"},eq'),(17907,28359,15741,'count','#1,{$FAN_CRIT_STATUS:\"criticalLower\"},eq'),(17908,28359,15741,'count','#1,{$FAN_CRIT_STATUS:\"nonRecoverableLower\"},eq'),(17909,28359,15741,'count','#1,{$FAN_CRIT_STATUS:\"failed\"},eq'),(17910,28359,15742,'count','#1,{$FAN_WARN_STATUS:\"nonCriticalUpper\"},eq'),(17911,28359,15742,'count','#1,{$FAN_WARN_STATUS:\"nonCriticalLower\"},eq'),(17912,28361,15743,'count','#1,{$DISK_FAIL_STATUS:\"critical\"},eq'),(17913,28361,15743,'count','#1,{$DISK_FAIL_STATUS:\"nonRecoverable\"},eq'),(17914,28361,15744,'count','#1,{$DISK_WARN_STATUS:\"nonCritical\"},eq'),(17915,28362,15745,'diff',''),(17916,28362,15745,'strlen',''),(17917,28363,15746,'count','#1,{$DISK_SMART_FAIL_STATUS},eq'),(17918,28373,15747,'count','#1,{$VDISK_CRIT_STATUS:\"failed\"},eq'),(17919,28373,15748,'count','#1,{$VDISK_WARN_STATUS:\"degraded\"},eq'),(17920,28374,15749,'count','#1,{$DISK_ARRAY_FAIL_STATUS:\"nonRecoverable\"},eq'),(17921,28374,15750,'count','#1,{$DISK_ARRAY_CRIT_STATUS:\"critical\"},eq'),(17922,28374,15751,'count','#1,{$DISK_ARRAY_WARN_STATUS:\"nonCritical\"},eq'),(17923,28376,15752,'count','#1,{$DISK_ARRAY_CACHE_BATTERY_WARN_STATUS},eq'),(17924,28376,15753,'count','#1,{$DISK_ARRAY_CACHE_BATTERY_OK_STATUS},ne'),(17925,28376,15754,'count','#1,{$DISK_ARRAY_CACHE_BATTERY_CRIT_STATUS},eq'),(17926,28377,15755,'max','#3'),(17927,28378,15756,'min','5m'),(17928,28379,15757,'avg','5m'),(17929,28386,15758,'last',''),(17930,28387,15759,'max','{$SNMP_TIMEOUT}'),(17931,28389,15760,'count','#1,{$HEALTH_CRIT_STATUS},eq'),(17932,28389,15761,'count','#1,{$HEALTH_WARN_STATUS},eq'),(17933,28391,15762,'diff',''),(17934,28391,15762,'strlen',''),(17935,28404,15763,'avg','5m'),(17936,28404,15763,'max','5m'),(17937,28404,15764,'avg','5m'),(17938,28404,15764,'max','5m'),(17939,28404,15765,'avg','5m'),(17940,28404,15765,'min','5m'),(17941,28406,15766,'avg','5m'),(17942,28406,15766,'max','5m'),(17943,28406,15767,'avg','5m'),(17944,28406,15767,'max','5m'),(17945,28406,15768,'avg','5m'),(17946,28406,15768,'min','5m'),(17947,28407,15769,'avg','5m'),(17948,28407,15769,'max','5m'),(17949,28407,15770,'avg','5m'),(17950,28407,15770,'max','5m'),(17951,28407,15771,'avg','5m'),(17952,28407,15771,'min','5m'),(17953,28408,15772,'avg','5m'),(17954,28408,15772,'max','5m'),(17955,28408,15773,'avg','5m'),(17956,28408,15773,'max','5m'),(17957,28408,15774,'avg','5m'),(17958,28408,15774,'min','5m'),(17959,28409,15775,'avg','5m'),(17960,28409,15775,'max','5m'),(17961,28409,15776,'avg','5m'),(17962,28409,15776,'max','5m'),(17963,28409,15777,'avg','5m'),(17964,28409,15777,'min','5m'),(17965,28410,15778,'avg','5m'),(17966,28410,15778,'max','5m'),(17967,28410,15779,'avg','5m'),(17968,28410,15779,'max','5m'),(17969,28410,15780,'avg','5m'),(17970,28410,15780,'min','5m'),(17971,28411,15781,'count','#1,{$PSU_CRIT_STATUS},eq'),(17972,28411,15782,'count','#1,{$PSU_WARN_STATUS},eq'),(17973,28412,15783,'count','#1,{$FAN_CRIT_STATUS},eq'),(17974,28412,15784,'count','#1,{$FAN_WARN_STATUS},eq'),(17975,28413,15785,'count','#1,{$DISK_ARRAY_CRIT_STATUS},eq'),(17976,28413,15786,'count','#1,{$DISK_ARRAY_WARN_STATUS},eq'),(17977,28415,15787,'count','#1,{$DISK_ARRAY_CACHE_CRIT_STATUS:\"cacheModCriticalFailure\"},eq'),(17978,28415,15788,'count','#1,{$DISK_ARRAY_CACHE_WARN_STATUS:\"invalid\"},eq'),(17979,28415,15788,'count','#1,{$DISK_ARRAY_CACHE_WARN_STATUS:\"cacheModDegradedFailsafeSpeed\"},eq'),(17980,28415,15788,'count','#1,{$DISK_ARRAY_CACHE_WARN_STATUS:\"cacheReadCacheNotMapped\"},eq'),(17981,28415,15788,'count','#1,{$DISK_ARRAY_CACHE_WARN_STATUS:\"cacheModFlashMemNotAttached\"},eq'),(17982,28415,15789,'count','#1,{$DISK_ARRAY_CACHE_OK_STATUS:\"enabled\"},ne'),(17983,28416,15790,'count','#1,{$DISK_ARRAY_CACHE_BATTERY_CRIT_STATUS:\"failed\"},eq'),(17984,28416,15790,'count','#1,{$DISK_ARRAY_CACHE_BATTERY_CRIT_STATUS:\"capacitorFailed\"},eq'),(17985,28416,15791,'count','#1,{$DISK_ARRAY_CACHE_BATTERY_WARN_STATUS:\"degraded\"},eq'),(17986,28416,15791,'count','#1,{$DISK_ARRAY_CACHE_BATTERY_WARN_STATUS:\"notPresent\"},eq'),(17987,28417,15792,'count','#1,{$DISK_FAIL_STATUS},eq'),(17988,28417,15793,'count','#1,{$DISK_WARN_STATUS},eq'),(17989,28418,15794,'count','#1,{$DISK_SMART_FAIL_STATUS:\"replaceDrive\"},eq'),(17990,28418,15794,'count','#1,{$DISK_SMART_FAIL_STATUS:\"replaceDriveSSDWearOut\"},eq'),(17991,28419,15795,'diff',''),(17992,28419,15795,'strlen',''),(17993,28423,15796,'count','#1,{$VDISK_CRIT_STATUS},eq'),(17994,28423,15797,'count','#1,{$VDISK_OK_STATUS},ne'),(17995,28426,15798,'max','#3'),(17996,28427,15799,'min','5m'),(17997,28428,15800,'avg','5m'),(17998,28435,15801,'last',''),(17999,28436,15802,'max','{$SNMP_TIMEOUT}'),(18000,28437,15803,'count','#1,{$HEALTH_DISASTER_STATUS},eq'),(18001,28437,15804,'count','#1,{$HEALTH_CRIT_STATUS},eq'),(18002,28437,15805,'count','#1,{$HEALTH_WARN_STATUS},eq'),(18003,28439,15806,'diff',''),(18004,28439,15806,'strlen',''),(18005,28446,15807,'avg','5m'),(18006,28446,15807,'max','5m'),(18007,28446,15808,'avg','5m'),(18008,28446,15808,'max','5m'),(18009,28446,15809,'avg','5m'),(18010,28446,15809,'min','5m'),(18011,28447,15810,'avg','5m'),(18012,28447,15810,'max','5m'),(18013,28447,15811,'avg','5m'),(18014,28447,15811,'max','5m'),(18015,28447,15812,'avg','5m'),(18016,28447,15812,'min','5m'),(18017,28448,15813,'avg','5m'),(18018,28448,15813,'max','5m'),(18019,28448,15814,'avg','5m'),(18020,28448,15814,'max','5m'),(18021,28448,15815,'avg','5m'),(18022,28448,15815,'min','5m'),(18023,28449,15816,'count','#1,{$PSU_OK_STATUS},ne'),(18024,28450,15817,'count','#1,{$FAN_OK_STATUS},ne'),(18025,28452,15818,'count','#1,{$DISK_OK_STATUS},ne'),(18026,28454,15819,'max','#3'),(18027,28455,15820,'min','5m'),(18028,28456,15821,'avg','5m'),(18029,28463,15822,'last',''),(18030,28464,15823,'max','{$SNMP_TIMEOUT}'),(18031,28465,15824,'count','#1,{$HEALTH_DISASTER_STATUS},eq'),(18032,28465,15825,'count','#1,{$HEALTH_CRIT_STATUS},eq'),(18033,28465,15826,'count','#1,{$HEALTH_WARN_STATUS},eq'),(18034,28467,15827,'diff',''),(18035,28467,15827,'strlen',''),(18036,28474,15828,'avg','5m'),(18037,28474,15828,'max','5m'),(18038,28474,15829,'avg','5m'),(18039,28474,15829,'max','5m'),(18040,28474,15830,'avg','5m'),(18041,28474,15830,'min','5m'),(18042,28475,15831,'avg','5m'),(18043,28475,15831,'max','5m'),(18044,28475,15832,'avg','5m'),(18045,28475,15832,'max','5m'),(18046,28475,15833,'avg','5m'),(18047,28475,15833,'min','5m'),(18048,28476,15834,'avg','5m'),(18049,28476,15834,'max','5m'),(18050,28476,15835,'avg','5m'),(18051,28476,15835,'max','5m'),(18052,28476,15836,'avg','5m'),(18053,28476,15836,'min','5m'),(18054,28477,15837,'count','#1,{$PSU_OK_STATUS},ne'),(18055,28478,15838,'count','#1,{$FAN_OK_STATUS},ne'),(18056,28480,15839,'count','#1,{$DISK_OK_STATUS},ne'),(18057,28482,15840,'max','#3'),(18058,28483,15841,'min','5m'),(18059,28484,15842,'avg','5m'),(18060,28491,15843,'last',''),(18061,28492,15844,'max','{$SNMP_TIMEOUT}'),(18062,28495,15845,'avg','5m'),(18063,28495,15845,'max','5m'),(18064,28495,15846,'avg','5m'),(18065,28495,15846,'max','5m'),(18066,28495,15847,'avg','5m'),(18067,28495,15847,'min','5m'),(18068,28503,15848,'last','0'),(18069,28532,15848,'last','0'),(18070,28506,15849,'last','0'),(18071,28505,15849,'last','0'),(18072,28509,15850,'last','0'),(18073,28508,15850,'last','0'),(18074,28513,15851,'str','off'),(18075,28512,15852,'str','off'),(18076,28535,15853,'avg','10m'),(18077,28536,15854,'avg','10m'),(18078,28537,15855,'avg','10m'),(18079,28538,15856,'avg','10m'),(18080,28543,15857,'max','10m'),(18081,28549,15858,'max','10m'),(18082,28542,15859,'max','10m'),(18083,28551,15860,'max','10m'),(18084,28548,15861,'max','10m'),(18085,28544,15862,'max','10m'),(18086,28541,15863,'min','10m'),(18087,28561,15864,'avg','10m'),(18088,28563,15865,'avg','10m'),(18089,28564,15866,'avg','10m'),(18090,28565,15867,'avg','10m'),(18091,28566,15868,'avg','10m'),(18092,28567,15869,'avg','10m'),(18093,28568,15870,'avg','30m'),(18094,28569,15871,'avg','10m'),(18095,28570,15872,'avg','10m'),(18096,28562,15873,'avg','10m'),(18097,28571,15874,'avg','10m'),(18098,28573,15875,'avg','10m'),(18099,28574,15876,'avg','10m'),(18100,28575,15877,'avg','10m'),(18101,28576,15878,'avg','10m'),(18102,28577,15879,'avg','10m'),(18103,28578,15880,'avg','10m'),(18104,28579,15881,'avg','10m'),(18105,28580,15882,'avg','10m'),(18106,28572,15883,'avg','10m'),(18107,28581,15884,'avg','10m'),(18108,28552,15885,'avg','10m'),(18109,28547,15886,'last',''),(18110,28559,15887,'avg','10m'),(18111,28582,15888,'avg','10m'),(18112,28583,15889,'avg','10m'),(18113,28599,15890,'max','10m'),(18114,28597,15891,'max','10m'),(18115,28596,15892,'max','10m'),(18116,28598,15893,'max','10m'),(18117,28587,15894,'min','10m'),(18118,28600,15895,'avg','10m'),(18119,28601,15896,'avg','10m'),(18120,28615,15897,'avg','10m'),(18121,28614,15898,'avg','10m'),(18122,28613,15899,'avg','10m'),(18123,28612,15900,'avg','30m'),(18124,28611,15901,'avg','10m'),(18125,28610,15902,'avg','10m'),(18126,28609,15903,'avg','10m'),(18127,28608,15904,'avg','10m'),(18128,28607,15905,'avg','10m'),(18129,28606,15906,'avg','10m'),(18130,28605,15907,'avg','10m'),(18131,28604,15908,'avg','10m'),(18132,28603,15909,'avg','10m'),(18133,28602,15910,'avg','10m'),(18134,28616,15911,'avg','10m'),(18135,28588,15912,'avg','10m'),(18136,28618,15913,'avg','10m'),(18137,28619,15914,'avg','10m');
/*!40000 ALTER TABLE `functions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalmacro`
--

DROP TABLE IF EXISTS `globalmacro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalmacro` (
  `globalmacroid` bigint(20) unsigned NOT NULL,
  `macro` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`globalmacroid`),
  UNIQUE KEY `globalmacro_1` (`macro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalmacro`
--

LOCK TABLES `globalmacro` WRITE;
/*!40000 ALTER TABLE `globalmacro` DISABLE KEYS */;
INSERT INTO `globalmacro` VALUES (2,'{$SNMP_COMMUNITY}','public');
/*!40000 ALTER TABLE `globalmacro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalvars`
--

DROP TABLE IF EXISTS `globalvars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalvars` (
  `globalvarid` bigint(20) unsigned NOT NULL,
  `snmp_lastsize` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`globalvarid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalvars`
--

LOCK TABLES `globalvars` WRITE;
/*!40000 ALTER TABLE `globalvars` DISABLE KEYS */;
/*!40000 ALTER TABLE `globalvars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graph_discovery`
--

DROP TABLE IF EXISTS `graph_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graph_discovery` (
  `graphid` bigint(20) unsigned NOT NULL,
  `parent_graphid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`graphid`),
  KEY `graph_discovery_1` (`parent_graphid`),
  CONSTRAINT `c_graph_discovery_1` FOREIGN KEY (`graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_graph_discovery_2` FOREIGN KEY (`parent_graphid`) REFERENCES `graphs` (`graphid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graph_discovery`
--

LOCK TABLES `graph_discovery` WRITE;
/*!40000 ALTER TABLE `graph_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `graph_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graph_theme`
--

DROP TABLE IF EXISTS `graph_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graph_theme` (
  `graphthemeid` bigint(20) unsigned NOT NULL,
  `theme` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `backgroundcolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `graphcolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `gridcolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `maingridcolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `gridbordercolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `textcolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `highlightcolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `leftpercentilecolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `rightpercentilecolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `nonworktimecolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `colorpalette` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`graphthemeid`),
  UNIQUE KEY `graph_theme_1` (`theme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graph_theme`
--

LOCK TABLES `graph_theme` WRITE;
/*!40000 ALTER TABLE `graph_theme` DISABLE KEYS */;
INSERT INTO `graph_theme` VALUES (1,'blue-theme','FFFFFF','FFFFFF','CCD5D9','ACBBC2','ACBBC2','1F2C33','E33734','429E47','E33734','EBEBEB','1A7C11,F63100,2774A4,A54F10,FC6EA3,6C59DC,AC8C14,611F27,F230E0,5CCD18,BB2A02,5A2B57,89ABF8,7EC25C,274482,2B5429,8048B4,FD5434,790E1F,87AC4D,E89DF4'),(2,'dark-theme','2B2B2B','2B2B2B','454545','4F4F4F','4F4F4F','F2F2F2','E45959','59DB8F','E45959','333333','199C0D,F63100,2774A4,F7941D,FC6EA3,6C59DC,C7A72D,BA2A5D,F230E0,5CCD18,BB2A02,AC41A5,89ABF8,7EC25C,3165D5,79A277,AA73DE,FD5434,F21C3E,87AC4D,E89DF4'),(3,'hc-light','FFFFFF','FFFFFF','555555','000000','333333','000000','333333','000000','000000','EBEBEB','1A7C11,F63100,2774A4,A54F10,FC6EA3,6C59DC,AC8C14,611F27,F230E0,5CCD18,BB2A02,5A2B57,89ABF8,7EC25C,274482,2B5429,8048B4,FD5434,790E1F,87AC4D,E89DF4'),(4,'hc-dark','000000','000000','666666','888888','4F4F4F','FFFFFF','FFFFFF','FFFFFF','FFFFFF','333333','199C0D,F63100,2774A4,F7941D,FC6EA3,6C59DC,C7A72D,BA2A5D,F230E0,5CCD18,BB2A02,AC41A5,89ABF8,7EC25C,3165D5,79A277,AA73DE,FD5434,F21C3E,87AC4D,E89DF4');
/*!40000 ALTER TABLE `graph_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graphs`
--

DROP TABLE IF EXISTS `graphs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graphs` (
  `graphid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `width` int(11) NOT NULL DEFAULT '900',
  `height` int(11) NOT NULL DEFAULT '200',
  `yaxismin` double(16,4) NOT NULL DEFAULT '0.0000',
  `yaxismax` double(16,4) NOT NULL DEFAULT '100.0000',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `show_work_period` int(11) NOT NULL DEFAULT '1',
  `show_triggers` int(11) NOT NULL DEFAULT '1',
  `graphtype` int(11) NOT NULL DEFAULT '0',
  `show_legend` int(11) NOT NULL DEFAULT '1',
  `show_3d` int(11) NOT NULL DEFAULT '0',
  `percent_left` double(16,4) NOT NULL DEFAULT '0.0000',
  `percent_right` double(16,4) NOT NULL DEFAULT '0.0000',
  `ymin_type` int(11) NOT NULL DEFAULT '0',
  `ymax_type` int(11) NOT NULL DEFAULT '0',
  `ymin_itemid` bigint(20) unsigned DEFAULT NULL,
  `ymax_itemid` bigint(20) unsigned DEFAULT NULL,
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`graphid`),
  KEY `graphs_1` (`name`),
  KEY `graphs_2` (`templateid`),
  KEY `graphs_3` (`ymin_itemid`),
  KEY `graphs_4` (`ymax_itemid`),
  CONSTRAINT `c_graphs_1` FOREIGN KEY (`templateid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_graphs_2` FOREIGN KEY (`ymin_itemid`) REFERENCES `items` (`itemid`),
  CONSTRAINT `c_graphs_3` FOREIGN KEY (`ymax_itemid`) REFERENCES `items` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graphs`
--

LOCK TABLES `graphs` WRITE;
/*!40000 ALTER TABLE `graphs` DISABLE KEYS */;
INSERT INTO `graphs` VALUES (387,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(392,'Zabbix server performance',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(404,'Zabbix data gathering process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(406,'Zabbix internal process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(410,'Zabbix cache usage, % used',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(420,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(433,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(436,'Swap usage',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(439,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(442,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(456,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(457,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(458,'Swap usage',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(459,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(461,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(462,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(463,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(464,'Swap usage',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(465,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(467,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(469,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(471,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(472,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(473,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(474,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(475,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(478,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(479,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(480,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(481,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(482,'Swap usage',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(483,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(484,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(485,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(487,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(491,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(492,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(493,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(494,'Network traffic on en0',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(495,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(496,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(497,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(498,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(517,'Zabbix internal process busy %',900,200,0.0000,100.0000,406,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(518,'Zabbix data gathering process busy %',900,200,0.0000,100.0000,404,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(519,'Zabbix server performance',900,200,0.0000,100.0000,392,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(520,'Zabbix cache usage, % used',900,200,0.0000,100.0000,410,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(521,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,420,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(522,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,442,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(523,'CPU jumps',900,200,0.0000,100.0000,439,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(524,'CPU load',900,200,0.0000,100.0000,433,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(525,'CPU utilization',900,200,0.0000,100.0000,387,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(526,'Swap usage',600,340,0.0000,100.0000,436,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(527,'Value cache effectiveness',900,200,0.0000,100.0000,NULL,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(528,'Value cache effectiveness',900,200,0.0000,100.0000,527,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(529,'Zabbix cache usage, % used',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(530,'Zabbix data gathering process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(531,'Zabbix internal process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(532,'Zabbix proxy performance',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(533,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,10026,0),(534,'Memory usage',900,200,0.0000,100.0000,533,1,1,0,1,0,0.0000,0.0000,1,2,NULL,23317,0),(540,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,22943,0),(541,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,22903,0),(542,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,22983,0),(543,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,23063,0),(544,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,22863,0),(545,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,23023,0),(546,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,23159,0),(638,'Class Loader',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(639,'File Descriptors',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(640,'Garbage Collector collections per second',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(641,'Memory Pool CMS Old Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(642,'Memory Pool CMS Perm Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(643,'Memory Pool Code Cache',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(644,'Memory Pool Perm Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(645,'Memory Pool PS Old Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(646,'Memory Pool PS Perm Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(647,'Memory Pool Tenured Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(648,'Threads',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(649,'MySQL bandwidth',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(650,'MySQL operations',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(651,'Fan speed and ambient temperature',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(652,'Voltage',900,200,0.0000,5.5000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(653,'Fan speed and temperature',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(654,'Voltage',900,200,0.0000,5.5000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(655,'#{#SNMPINDEX}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(657,'#{#SNMPINDEX}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(668,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(669,'Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(671,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(672,'Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(675,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(676,'CPU utilization',900,200,0.0000,100.0000,675,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(677,'CPU utilization',900,200,0.0000,100.0000,675,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(678,'Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(679,'Memory utilization',900,200,0.0000,100.0000,678,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(680,'Memory utilization',900,200,0.0000,100.0000,678,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(683,'{#SNMPVALUE}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(684,'{#SNMPVALUE}: Memory utilization',900,200,0.0000,100.0000,683,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(686,'{#SNMPVALUE}: Memory utilization',900,200,0.0000,100.0000,683,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(687,'#{#SNMPINDEX}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(688,'#{#SNMPINDEX}: CPU utilization',900,200,0.0000,100.0000,687,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(691,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(692,'CPU utilization',900,200,0.0000,100.0000,691,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(694,'#{#SNMPINDEX}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(695,'#{#SNMPINDEX}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(697,'Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(698,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(700,'#{#SNMPVALUE}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(701,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(703,'#{#SNMPVALUE}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(704,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(708,'{#MODULE_NAME}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(709,'{#MODULE_NAME}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(714,'{#ENT_NAME}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(715,'{#ENT_NAME}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(718,'{#SNMPVALUE}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(719,'{#SNMPVALUE}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(724,'#{#SNMPINDEX}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(725,'Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(727,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(728,'Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(730,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(731,'Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(733,'#{#SNMPVALUE}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(734,'#{#SNMPVALUE}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(736,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(737,'Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(738,'Interface {#IFDESCR}: Network traffic',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(739,'Interface {#IFDESCR}: Network traffic',900,200,0.0000,100.0000,738,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(740,'Interface {#IFDESCR}: Network traffic',900,200,0.0000,100.0000,738,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(741,'Interface {#IFDESCR}: Network traffic',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(742,'Interface {#IFDESCR}: Network traffic',900,200,0.0000,100.0000,741,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(743,'Interface {#IFDESCR}: Network traffic',900,200,0.0000,100.0000,741,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(744,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(745,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(746,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(747,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(748,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(749,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(750,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(752,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(753,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(754,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(755,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(756,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(758,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(759,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(760,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(762,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(763,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(764,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(766,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(767,'#{#SNMPINDEX}: CPU utilization',900,200,0.0000,100.0000,657,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(769,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(770,'#{#SNMPINDEX}: CPU utilization',900,200,0.0000,100.0000,657,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(772,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,766,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(773,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(774,'#{#SNMPVALUE}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(775,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(776,'#{#SNMPINDEX}: CPU utilization',900,200,0.0000,100.0000,657,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(778,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(779,'#{#SNMPINDEX}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(780,'#{#SNMPINDEX}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(781,'#{#SNMPINDEX}: Memory utilization',900,200,0.0000,100.0000,780,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(782,'#{#SNMPINDEX}: Memory utilization',900,200,0.0000,100.0000,780,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(783,'#{#SNMPINDEX}: Memory utilization',900,200,0.0000,100.0000,780,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(784,'{#SNMPVALUE}: Memory utilization',900,200,0.0000,100.0000,683,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(785,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(786,'{#SNMPVALUE}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(787,'{#SNMPVALUE}: CPU utilization',900,200,0.0000,100.0000,786,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(788,'Zabbix internal queues',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(789,'Zabbix internal queues',900,200,0.0000,100.0000,788,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(790,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(791,'{#DEVICE_DESCR}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(792,'#{#SNMPINDEX}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(793,'http-8080 worker threads',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(794,'http-8443 worker threads',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(795,'jk-8009 worker threads',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(796,'sessions /',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(797,'Value cache effectiveness',900,200,0.0000,100.0000,NULL,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(798,'Zabbix cache usage, % free',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(799,'Zabbix data gathering process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(800,'Zabbix internal process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(801,'Zabbix internal queues',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(802,'Zabbix server performance',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(803,'Zabbix cache usage, % free',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(804,'Zabbix data gathering process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(805,'Zabbix internal process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(806,'Zabbix proxy performance',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(807,'Zabbix internal queues',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0);
/*!40000 ALTER TABLE `graphs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graphs_items`
--

DROP TABLE IF EXISTS `graphs_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graphs_items` (
  `gitemid` bigint(20) unsigned NOT NULL,
  `graphid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT '0',
  `sortorder` int(11) NOT NULL DEFAULT '0',
  `color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '009600',
  `yaxisside` int(11) NOT NULL DEFAULT '0',
  `calc_fnc` int(11) NOT NULL DEFAULT '2',
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`gitemid`),
  KEY `graphs_items_1` (`itemid`),
  KEY `graphs_items_2` (`graphid`),
  CONSTRAINT `c_graphs_items_1` FOREIGN KEY (`graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_graphs_items_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graphs_items`
--

LOCK TABLES `graphs_items` WRITE;
/*!40000 ALTER TABLE `graphs_items` DISABLE KEYS */;
INSERT INTO `graphs_items` VALUES (5598,655,27036,5,0,'1A7C11',0,2,0),(5599,779,27038,5,0,'1A7C11',0,2,0),(5600,657,27052,5,0,'1A7C11',0,2,0),(5601,767,28045,5,0,'1A7C11',0,2,0),(5602,770,28084,5,0,'1A7C11',0,2,0),(5603,776,28162,5,0,'1A7C11',0,2,0),(5604,780,27054,5,0,'1A7C11',0,2,0),(5605,781,28052,5,0,'1A7C11',0,2,0),(5606,782,28091,5,0,'1A7C11',0,2,0),(5607,783,28169,5,0,'1A7C11',0,2,0),(5788,668,27208,5,0,'1A7C11',0,2,0),(5789,669,27205,5,0,'1A7C11',0,2,0),(5796,791,28310,5,0,'1A7C11',0,2,0),(5797,792,28316,5,0,'1A7C11',0,2,0),(5798,671,27240,5,0,'1A7C11',0,2,0),(5799,672,27239,5,0,'1A7C11',0,2,0),(5800,675,27294,5,0,'1A7C11',0,2,0),(5801,676,27299,5,0,'1A7C11',0,2,0),(5802,677,27301,5,0,'1A7C11',0,2,0),(5803,678,27293,5,0,'1A7C11',0,2,0),(5804,679,27298,5,0,'1A7C11',0,2,0),(5805,680,27300,5,0,'1A7C11',0,2,0),(5806,683,27414,5,0,'1A7C11',0,2,0),(5807,684,27424,5,0,'1A7C11',0,2,0),(5808,686,27442,5,0,'1A7C11',0,2,0),(5809,784,28221,5,0,'1A7C11',0,2,0),(5810,687,27417,5,0,'1A7C11',0,2,0),(5811,688,27427,5,0,'1A7C11',0,2,0),(5812,786,28246,5,0,'1A7C11',0,2,0),(5813,787,28247,5,0,'1A7C11',0,2,0),(5814,691,27376,5,0,'1A7C11',0,2,0),(5815,692,27380,5,0,'1A7C11',0,2,0),(5816,694,27478,5,0,'1A7C11',0,2,0),(5817,695,27477,5,0,'1A7C11',0,2,0),(5818,697,27516,5,0,'1A7C11',0,2,0),(5819,698,27511,5,0,'1A7C11',0,2,0),(5820,700,27552,5,0,'1A7C11',0,2,0),(5821,701,27547,5,0,'1A7C11',0,2,0),(5822,703,27590,5,0,'1A7C11',0,2,0),(5823,704,27586,5,0,'1A7C11',0,2,0),(5824,708,27671,5,0,'1A7C11',0,2,0),(5825,709,27670,5,0,'1A7C11',0,2,0),(5826,774,28151,5,0,'1A7C11',0,2,0),(5827,775,28143,5,0,'1A7C11',0,2,0),(5828,714,27753,5,0,'1A7C11',0,2,0),(5829,715,27752,5,0,'1A7C11',0,2,0),(5830,718,27820,5,0,'1A7C11',0,2,0),(5831,719,27819,5,0,'1A7C11',0,2,0),(5832,724,27904,5,0,'1A7C11',0,2,0),(5833,725,27899,5,0,'1A7C11',0,2,0),(5834,727,27936,5,0,'1A7C11',0,2,0),(5835,728,27933,5,0,'1A7C11',0,2,0),(5836,730,27975,5,0,'1A7C11',0,2,0),(5837,731,27974,5,0,'1A7C11',0,2,0),(5838,733,28003,5,0,'1A7C11',0,2,0),(5839,734,28004,5,0,'1A7C11',0,2,0),(5840,736,28031,5,0,'1A7C11',0,2,0),(5841,737,28028,5,0,'1A7C11',0,2,0),(6171,793,28532,0,0,'C80000',0,2,0),(6172,793,28503,0,1,'00C800',0,2,0),(6173,793,28504,0,2,'0000C8',0,2,0),(6174,794,28505,0,0,'C80000',0,2,0),(6175,794,28506,0,1,'00C800',0,2,0),(6176,794,28507,0,2,'0000C8',0,2,0),(6177,795,28508,0,0,'C80000',0,2,0),(6178,795,28509,0,1,'00C800',0,2,0),(6179,795,28510,0,2,'0000C8',0,2,0),(6180,796,28515,0,0,'C80000',0,2,0),(6181,796,28518,0,1,'00C800',0,2,0),(6182,796,28516,0,2,'0000C8',0,2,0),(6183,638,26892,0,0,'C80000',0,2,0),(6184,638,26891,0,1,'00C800',0,2,0),(6185,638,26910,0,2,'0000C8',0,2,0),(6186,639,26879,0,0,'C80000',0,2,0),(6187,639,26880,0,1,'00C800',0,2,0),(6188,640,26906,0,0,'C80000',0,2,0),(6189,640,26895,0,1,'00C800',0,2,0),(6190,640,26889,0,2,'0000C8',0,2,0),(6191,640,26884,0,3,'C8C800',0,2,0),(6192,640,26896,0,4,'00C8C9',0,2,0),(6193,640,26887,0,5,'C800C8',0,2,0),(6194,641,26900,0,0,'C80000',0,2,0),(6195,641,26901,0,1,'00C800',0,2,0),(6196,641,26902,0,2,'0000C8',0,2,0),(6197,642,26883,0,0,'C80000',0,2,0),(6198,642,26882,0,1,'00C800',0,2,0),(6199,642,26864,0,2,'0000C8',0,2,0),(6200,643,26863,0,0,'C80000',0,2,0),(6201,643,26865,0,1,'00C800',0,2,0),(6202,643,26866,0,2,'0000C8',0,2,0),(6203,644,26867,0,0,'C80000',0,2,0),(6204,644,26862,0,1,'00C800',0,2,0),(6205,644,26861,0,2,'0000C8',0,2,0),(6206,645,26857,0,0,'C80000',0,2,0),(6207,645,26856,0,1,'00C800',0,2,0),(6208,645,26858,0,2,'0000C8',0,2,0),(6209,646,26859,0,0,'0000C8',0,2,0),(6210,646,26860,0,1,'C80000',0,2,0),(6211,646,26868,0,2,'00C800',0,2,0),(6212,647,26869,0,0,'C80000',0,2,0),(6213,647,26878,0,1,'00C800',0,2,0),(6214,647,26877,0,2,'0000C8',0,2,0),(6215,648,26872,0,0,'C80000',0,2,0),(6216,648,26870,0,1,'00C800',0,2,0),(6217,648,26873,0,2,'0000C8',0,2,0),(6242,527,22199,0,0,'C80000',0,2,0),(6243,527,22196,0,1,'00C800',0,2,0),(6244,528,23628,0,0,'C80000',0,2,0),(6245,528,23625,0,1,'00C800',0,2,0),(6246,410,22185,0,0,'009900',0,2,0),(6247,410,22189,0,1,'DD0000',0,2,0),(6248,410,22396,0,2,'00DDDD',0,2,0),(6249,410,22183,0,3,'3333FF',0,2,0),(6250,410,22191,0,4,'999900',0,2,0),(6251,410,23634,0,5,'00FF00',0,2,0),(6252,520,23276,0,0,'009900',0,2,0),(6253,520,23273,0,1,'DD0000',0,2,0),(6254,520,23275,0,2,'00DDDD',0,2,0),(6255,520,23274,0,3,'3333FF',0,2,0),(6256,520,23620,0,4,'999900',0,2,0),(6257,520,23635,0,5,'00FF00',0,2,0),(6258,404,22404,0,0,'990099',0,2,0),(6259,404,22399,0,1,'990000',0,2,0),(6260,404,22416,0,2,'0000EE',0,2,0),(6261,404,22430,0,3,'FF33FF',0,2,0),(6262,404,22418,0,4,'009600',0,2,0),(6263,404,22402,0,5,'003300',0,2,0),(6264,404,22420,0,6,'CCCC00',0,2,0),(6265,404,22400,0,7,'33FFFF',0,2,0),(6266,404,22689,0,8,'DD0000',0,2,0),(6267,404,23171,0,9,'000099',0,2,0),(6268,404,22401,0,10,'00FF00',0,2,0),(6269,518,23269,0,0,'990099',0,2,0),(6270,518,23264,0,1,'990000',0,2,0),(6271,518,23261,0,2,'0000EE',0,2,0),(6272,518,23255,0,3,'FF33FF',0,2,0),(6273,518,23260,0,4,'009600',0,2,0),(6274,518,23259,0,5,'003300',0,2,0),(6275,518,23265,0,6,'CCCC00',0,2,0),(6276,518,23270,0,7,'33FFFF',0,2,0),(6277,518,23262,0,8,'DD0000',0,2,0),(6278,518,23267,0,9,'000099',0,2,0),(6279,518,23328,0,10,'00FF00',0,2,0),(6280,406,22426,0,0,'00EE00',0,2,0),(6281,406,22422,0,1,'0000EE',0,2,0),(6282,406,22408,0,2,'FFAA00',0,2,0),(6283,406,22424,0,3,'00EEEE',0,2,0),(6284,406,22412,0,4,'990099',0,2,0),(6285,406,22406,0,5,'EE0000',0,2,0),(6286,406,22414,0,6,'FF66FF',0,2,0),(6287,406,23663,0,7,'009999',0,2,0),(6288,406,25366,0,8,'BBBB00',0,2,0),(6289,406,25370,0,9,'AA0000',0,2,0),(6290,406,25665,0,10,'990000',0,2,0),(6291,406,25666,0,11,'008800',0,2,0),(6304,788,28248,0,0,'008800',0,2,0),(6306,392,22187,5,0,'00C800',0,2,0),(6307,392,23251,5,1,'C80000',1,2,0),(6308,519,23277,5,0,'00C800',0,2,0),(6309,519,23272,5,1,'C80000',1,2,0),(6310,649,26920,5,0,'00AA00',0,2,0),(6311,649,26919,5,1,'3333FF',0,2,0),(6312,650,26921,0,0,'C8C800',0,2,0),(6313,650,26922,0,1,'006400',0,2,0),(6314,650,26923,0,2,'C80000',0,2,0),(6315,650,26918,0,3,'0000EE',0,2,0),(6316,650,26917,0,4,'640000',0,2,0),(6317,650,26912,0,5,'00C800',0,2,0),(6318,650,26911,0,6,'C800C8',0,2,0),(6319,472,22945,5,0,'00AA00',0,2,0),(6320,472,22946,5,1,'3333FF',0,2,0),(6321,473,22950,0,0,'C80000',0,2,2),(6322,473,22948,0,1,'00C800',0,2,0),(6323,471,22924,0,0,'009900',0,2,0),(6324,471,22920,0,1,'000099',0,2,0),(6325,469,22922,0,0,'009900',0,2,0),(6326,469,22923,0,1,'000099',0,2,0),(6327,469,22921,0,2,'990000',0,2,0),(6328,498,23109,0,0,'009999',0,2,0),(6329,498,23112,0,1,'990099',0,2,0),(6330,498,23115,0,2,'999900',0,2,0),(6331,498,23113,0,3,'990000',0,2,0),(6332,498,23114,0,4,'000099',0,2,0),(6333,498,23110,0,5,'009900',0,2,0),(6334,540,22942,5,0,'00C800',0,2,0),(6335,492,23073,5,0,'00AA00',0,2,0),(6336,492,23074,5,1,'3333FF',0,2,0),(6337,467,22910,0,0,'C80000',0,2,2),(6338,467,22908,0,1,'00C800',0,2,0),(6339,465,22884,0,0,'009900',0,2,0),(6340,465,22880,0,1,'000099',0,2,0),(6341,463,22882,0,0,'009900',0,2,0),(6342,463,22883,0,1,'000099',0,2,0),(6343,463,22881,0,2,'990000',0,2,0),(6344,462,22886,1,0,'009999',0,2,0),(6345,462,22888,1,1,'990099',0,2,0),(6346,462,22891,1,2,'990000',0,2,0),(6347,462,22892,1,3,'000099',0,2,0),(6348,462,22885,1,4,'009900',0,2,0),(6349,541,22902,5,0,'00C800',0,2,0),(6350,464,22897,0,0,'AA0000',0,2,2),(6351,464,22895,0,1,'00AA00',0,2,0),(6352,478,22985,5,0,'00AA00',0,2,0),(6353,478,22986,5,1,'3333FF',0,2,0),(6354,479,22990,0,0,'C80000',0,2,2),(6355,479,22988,0,1,'00C800',0,2,0),(6356,475,22962,0,0,'009900',0,2,0),(6357,475,22963,0,1,'000099',0,2,0),(6358,475,22961,0,2,'990000',0,2,0),(6359,474,22968,1,0,'990099',0,2,0),(6360,474,22971,1,1,'990000',0,2,0),(6361,474,22972,1,2,'000099',0,2,0),(6362,474,22965,1,3,'009900',0,2,0),(6363,542,22982,5,0,'00C800',0,2,0),(6364,420,22446,5,0,'00AA00',0,2,0),(6365,420,22448,5,1,'3333FF',0,2,0),(6366,521,23280,5,0,'00AA00',0,2,0),(6367,521,23281,5,1,'3333FF',0,2,0),(6368,442,22456,0,0,'C80000',0,2,2),(6369,442,22452,0,1,'00C800',0,2,0),(6370,522,23285,0,0,'C80000',0,2,2),(6371,522,23283,0,1,'00C800',0,2,0),(6372,439,22680,0,0,'009900',0,2,0),(6373,439,22683,0,1,'000099',0,2,0),(6374,523,23298,0,0,'009900',0,2,0),(6375,523,23294,0,1,'000099',0,2,0),(6376,433,10010,0,0,'009900',0,2,0),(6377,433,22674,0,1,'000099',0,2,0),(6378,433,22677,0,2,'990000',0,2,0),(6379,524,23296,0,0,'009900',0,2,0),(6380,524,23297,0,1,'000099',0,2,0),(6381,524,23295,0,2,'990000',0,2,0),(6382,387,28499,0,0,'F230E0',0,2,0),(6383,387,28497,0,1,'5CCD18',0,2,0),(6384,387,22665,1,2,'FF5555',0,2,0),(6385,387,22668,1,3,'55FF55',0,2,0),(6386,387,22671,1,4,'009999',0,2,0),(6387,387,17358,1,5,'990099',0,2,0),(6388,387,17362,1,6,'999900',0,2,0),(6389,387,17360,1,7,'990000',0,2,0),(6390,387,17356,1,8,'000099',0,2,0),(6391,387,17354,1,9,'009900',0,2,0),(6392,525,28500,0,0,'F230E0',0,2,0),(6393,525,28498,0,1,'5CCD18',0,2,0),(6394,525,23304,1,2,'FF5555',0,2,0),(6395,525,23303,1,3,'55FF55',0,2,0),(6396,525,23300,1,4,'009999',0,2,0),(6397,525,23302,1,5,'990099',0,2,0),(6398,525,23301,1,6,'999900',0,2,0),(6399,525,23305,1,7,'990000',0,2,0),(6400,525,23306,1,8,'000099',0,2,0),(6401,525,23299,1,9,'009900',0,2,0),(6402,533,22181,5,0,'00C800',0,2,0),(6403,534,23316,5,0,'00C800',0,2,0),(6404,436,10030,0,0,'AA0000',0,2,2),(6405,436,10014,0,1,'00AA00',0,2,0),(6406,526,23311,0,0,'AA0000',0,2,2),(6407,526,23309,0,1,'00AA00',0,2,0),(6408,491,23070,0,0,'C80000',0,2,2),(6409,491,23068,0,1,'00C800',0,2,0),(6410,487,23042,0,0,'009900',0,2,0),(6411,487,23043,0,1,'000099',0,2,0),(6412,487,23041,0,2,'990000',0,2,0),(6413,543,23062,5,0,'00C800',0,2,0),(6414,494,23077,5,0,'00AA00',0,2,0),(6415,494,23078,5,1,'3333FF',0,2,0),(6416,493,23075,5,0,'00AA00',0,2,0),(6417,493,23076,5,1,'3333FF',0,2,0),(6418,461,22870,0,0,'C80000',0,2,2),(6419,461,22868,0,1,'00C800',0,2,0),(6420,459,22844,0,0,'009900',0,2,0),(6421,459,22840,0,1,'000099',0,2,0),(6422,457,22842,0,0,'009900',0,2,0),(6423,457,22843,0,1,'000099',0,2,0),(6424,457,22841,0,2,'990000',0,2,0),(6425,456,22846,1,0,'009999',0,2,0),(6426,456,22848,1,1,'990099',0,2,0),(6427,456,22851,1,2,'990000',0,2,0),(6428,456,22852,1,3,'000099',0,2,0),(6429,456,22845,1,4,'009900',0,2,0),(6430,544,22862,5,0,'00C800',0,2,0),(6431,458,22857,0,0,'AA0000',0,2,2),(6432,458,22855,0,1,'00AA00',0,2,0),(6433,484,23025,5,0,'00AA00',0,2,0),(6434,484,23026,5,1,'3333FF',0,2,0),(6435,485,23030,0,0,'C80000',0,2,2),(6436,485,23028,0,1,'00C800',0,2,0),(6437,483,23004,0,0,'009900',0,2,0),(6438,483,23000,0,1,'000099',0,2,0),(6439,481,23002,0,0,'009900',0,2,0),(6440,481,23003,0,1,'000099',0,2,0),(6441,481,23001,0,2,'990000',0,2,0),(6442,480,23007,1,0,'999900',0,2,0),(6443,480,23011,1,1,'990000',0,2,0),(6444,480,23012,1,2,'000099',0,2,0),(6445,480,23005,1,3,'009900',0,2,0),(6446,545,23022,5,0,'00C800',0,2,0),(6447,482,23017,0,0,'AA0000',0,2,2),(6448,482,23015,0,1,'00AA00',0,2,0),(6449,497,23169,5,0,'00AA00',0,2,0),(6450,497,23170,5,1,'3333FF',0,2,0),(6451,496,23167,0,0,'C80000',0,2,2),(6452,496,23164,0,1,'00C800',0,2,0),(6453,495,23143,0,0,'009900',0,2,0),(6454,495,23145,0,1,'000099',0,2,0),(6455,495,23144,0,2,'990000',0,2,0),(6456,546,23158,5,0,'00C800',0,2,0),(6457,651,26928,5,0,'EE0000',0,2,0),(6458,651,26927,0,1,'000000',1,2,0),(6459,652,26925,2,0,'880000',0,2,0),(6460,652,26932,0,1,'009900',0,2,0),(6461,652,26930,0,2,'00CCCC',0,2,0),(6462,652,26931,0,3,'000000',0,2,0),(6463,652,26929,0,4,'3333FF',0,2,0),(6464,652,26926,0,5,'777700',0,2,0),(6465,653,26933,2,0,'EE0000',0,2,0),(6466,653,26943,2,1,'EE00EE',0,2,0),(6467,653,26935,0,2,'000000',1,2,0),(6468,653,26936,4,3,'000000',1,2,0),(6469,654,26934,2,0,'880000',0,2,0),(6470,654,26939,0,1,'009900',0,2,0),(6471,654,26942,0,2,'00CCCC',0,2,0),(6472,654,26938,0,3,'000000',0,2,0),(6473,654,26937,0,4,'3333FF',0,2,0),(6474,406,28535,0,12,'80B0E0',0,2,0),(6475,406,28537,0,13,'4080B0',0,2,0),(6476,517,23268,0,0,'00EE00',0,2,0),(6477,517,23256,0,1,'0000EE',0,2,0),(6478,517,23258,0,2,'FFAA00',0,2,0),(6479,517,23252,0,3,'00EEEE',0,2,0),(6480,517,23253,0,4,'990099',0,2,0),(6481,517,23257,0,5,'EE0000',0,2,0),(6482,517,23266,0,6,'FF66FF',0,2,0),(6483,517,23664,0,7,'009999',0,2,0),(6484,517,25367,0,8,'BBBB00',0,2,0),(6485,517,25371,0,9,'AA0000',0,2,0),(6486,517,25667,0,10,'990000',0,2,0),(6487,517,25668,0,11,'008800',0,2,0),(6488,517,28536,0,12,'80B0E0',0,2,0),(6489,517,28538,0,13,'4080B0',0,2,0),(6490,788,28533,0,1,'EE0000',0,2,0),(6491,789,28249,0,0,'008800',0,2,0),(6492,789,28534,0,1,'EE0000',0,2,0),(6554,807,28617,0,0,'008800',0,2,0),(6555,529,23357,0,0,'DD0000',0,2,0),(6556,529,23341,0,1,'00DDDD',0,2,0),(6557,529,23342,0,2,'3333FF',0,2,0),(6558,529,28251,0,3,'00FF00',0,2,0),(6559,530,23345,0,0,'990099',0,2,0),(6560,530,23348,0,1,'990000',0,2,0),(6561,530,23355,0,2,'0000EE',0,2,0),(6562,530,23352,0,3,'FF33FF',0,2,0),(6563,530,23356,0,4,'007700',0,2,0),(6564,530,23354,0,5,'003300',0,2,0),(6565,530,23346,0,6,'33FFFF',0,2,0),(6566,530,23349,0,7,'DD0000',0,2,0),(6567,530,23344,0,8,'000099',0,7,0),(6568,530,28250,0,9,'00FF00',0,2,0),(6569,531,23353,0,0,'FFAA00',0,2,0),(6570,531,23347,0,1,'990099',0,2,0),(6571,531,23350,0,2,'EE0000',0,2,0),(6572,531,23343,0,3,'FF66FF',0,2,0),(6573,531,23351,0,4,'0000EE',0,2,0),(6574,531,23360,0,5,'00EE00',0,2,0),(6575,531,25369,0,6,'009999',0,2,0),(6576,531,25368,0,7,'BBBB00',0,2,0),(6577,531,28618,0,8,'990000',0,2,0),(6578,531,28619,0,9,'008800',0,2,0),(6579,532,23340,5,0,'00C800',0,2,0),(6580,532,23358,5,1,'C80000',1,2,0),(6581,738,27074,5,0,'1A7C11',0,2,0),(6582,738,27075,2,1,'2774A4',0,2,0),(6583,738,27073,0,2,'F63100',1,2,0),(6584,738,27076,0,3,'A54F10',1,2,0),(6585,738,27072,0,4,'FC6EA3',1,2,0),(6586,738,27069,0,5,'6C59DC',1,2,0),(6587,739,27599,5,0,'1A7C11',0,2,0),(6588,739,27602,2,1,'2774A4',0,2,0),(6589,739,27601,0,2,'F63100',1,2,0),(6590,739,27598,0,3,'A54F10',1,2,0),(6591,739,27600,0,4,'FC6EA3',1,2,0),(6592,739,27597,0,5,'6C59DC',1,2,0),(6593,740,28008,5,0,'1A7C11',0,2,0),(6594,740,28011,2,1,'2774A4',0,2,0),(6595,740,28010,0,2,'F63100',1,2,0),(6596,740,28007,0,3,'A54F10',1,2,0),(6597,740,28009,0,4,'FC6EA3',1,2,0),(6598,740,28006,0,5,'6C59DC',1,2,0),(6599,741,27084,5,0,'1A7C11',0,2,0),(6600,741,27085,2,1,'2774A4',0,2,0),(6601,741,27083,0,2,'F63100',1,2,0),(6602,741,27086,0,3,'A54F10',1,2,0),(6603,741,27082,0,4,'FC6EA3',1,2,0),(6604,741,27079,0,5,'6C59DC',1,2,0),(6605,742,27622,5,0,'1A7C11',0,2,0),(6606,742,27625,2,1,'2774A4',0,2,0),(6607,742,27624,0,2,'F63100',1,2,0),(6608,742,27621,0,3,'A54F10',1,2,0),(6609,742,27623,0,4,'FC6EA3',1,2,0),(6610,742,27620,0,5,'6C59DC',1,2,0),(6611,743,27979,5,0,'1A7C11',0,2,0),(6612,743,27982,2,1,'2774A4',0,2,0),(6613,743,27981,0,2,'F63100',1,2,0),(6614,743,27978,0,3,'A54F10',1,2,0),(6615,743,27980,0,4,'FC6EA3',1,2,0),(6616,743,27977,0,5,'6C59DC',1,2,0),(6617,744,27094,5,0,'1A7C11',0,2,0),(6618,744,27095,2,1,'2774A4',0,2,0),(6619,744,27093,0,2,'F63100',1,2,0),(6620,744,27096,0,3,'A54F10',1,2,0),(6621,744,27092,0,4,'FC6EA3',1,2,0),(6622,744,27089,0,5,'6C59DC',1,2,0),(6623,745,27104,5,0,'1A7C11',0,2,0),(6624,745,27105,2,1,'2774A4',0,2,0),(6625,745,27103,0,2,'F63100',1,2,0),(6626,745,27106,0,3,'A54F10',1,2,0),(6627,745,27102,0,4,'FC6EA3',1,2,0),(6628,745,27099,0,5,'6C59DC',1,2,0),(6629,746,27183,5,0,'1A7C11',0,2,0),(6630,746,27186,2,1,'2774A4',0,2,0),(6631,746,27185,0,2,'F63100',1,2,0),(6632,746,27182,0,3,'A54F10',1,2,0),(6633,746,27184,0,4,'FC6EA3',1,2,0),(6634,746,27181,0,5,'6C59DC',1,2,0),(6635,747,27218,5,0,'1A7C11',0,2,0),(6636,747,27221,2,1,'2774A4',0,2,0),(6637,747,27220,0,2,'F63100',1,2,0),(6638,747,27217,0,3,'A54F10',1,2,0),(6639,747,27219,0,4,'FC6EA3',1,2,0),(6640,747,27216,0,5,'6C59DC',1,2,0),(6641,748,27254,5,0,'1A7C11',0,2,0),(6642,748,27257,2,1,'2774A4',0,2,0),(6643,748,27256,0,2,'F63100',1,2,0),(6644,748,27253,0,3,'A54F10',1,2,0),(6645,748,27255,0,4,'FC6EA3',1,2,0),(6646,748,27252,0,5,'6C59DC',1,2,0),(6647,749,27275,5,0,'1A7C11',0,2,0),(6648,749,27278,2,1,'2774A4',0,2,0),(6649,749,27277,0,2,'F63100',1,2,0),(6650,749,27274,0,3,'A54F10',1,2,0),(6651,749,27276,0,4,'FC6EA3',1,2,0),(6652,749,27273,0,5,'6C59DC',1,2,0),(6653,750,27324,5,0,'1A7C11',0,2,0),(6654,750,27327,2,1,'2774A4',0,2,0),(6655,750,27326,0,2,'F63100',1,2,0),(6656,750,27323,0,3,'A54F10',1,2,0),(6657,750,27325,0,4,'FC6EA3',1,2,0),(6658,750,27322,0,5,'6C59DC',1,2,0),(6659,752,27453,5,0,'1A7C11',0,2,0),(6660,752,27456,2,1,'2774A4',0,2,0),(6661,752,27455,0,2,'F63100',1,2,0),(6662,752,27452,0,3,'A54F10',1,2,0),(6663,752,27454,0,4,'FC6EA3',1,2,0),(6664,752,27451,0,5,'6C59DC',1,2,0),(6665,753,27489,5,0,'1A7C11',0,2,0),(6666,753,27492,2,1,'2774A4',0,2,0),(6667,753,27491,0,2,'F63100',1,2,0),(6668,753,27488,0,3,'A54F10',1,2,0),(6669,753,27490,0,4,'FC6EA3',1,2,0),(6670,753,27487,0,5,'6C59DC',1,2,0),(6671,754,27523,5,0,'1A7C11',0,2,0),(6672,754,27526,2,1,'2774A4',0,2,0),(6673,754,27525,0,2,'F63100',1,2,0),(6674,754,27522,0,3,'A54F10',1,2,0),(6675,754,27524,0,4,'FC6EA3',1,2,0),(6676,754,27521,0,5,'6C59DC',1,2,0),(6677,755,27559,5,0,'1A7C11',0,2,0),(6678,755,27562,2,1,'2774A4',0,2,0),(6679,755,27561,0,2,'F63100',1,2,0),(6680,755,27558,0,3,'A54F10',1,2,0),(6681,755,27560,0,4,'FC6EA3',1,2,0),(6682,755,27557,0,5,'6C59DC',1,2,0),(6683,756,27645,5,0,'1A7C11',0,2,0),(6684,756,27648,2,1,'2774A4',0,2,0),(6685,756,27647,0,2,'F63100',1,2,0),(6686,756,27644,0,3,'A54F10',1,2,0),(6687,756,27646,0,4,'FC6EA3',1,2,0),(6688,756,27643,0,5,'6C59DC',1,2,0),(6689,758,27725,5,0,'1A7C11',0,2,0),(6690,758,27728,2,1,'2774A4',0,2,0),(6691,758,27727,0,2,'F63100',1,2,0),(6692,758,27724,0,3,'A54F10',1,2,0),(6693,758,27726,0,4,'FC6EA3',1,2,0),(6694,758,27723,0,5,'6C59DC',1,2,0),(6695,759,27759,5,0,'1A7C11',0,2,0),(6696,759,27762,2,1,'2774A4',0,2,0),(6697,759,27761,0,2,'F63100',1,2,0),(6698,759,27758,0,3,'A54F10',1,2,0),(6699,759,27760,0,4,'FC6EA3',1,2,0),(6700,759,27757,0,5,'6C59DC',1,2,0),(6701,760,27791,5,0,'1A7C11',0,2,0),(6702,760,27794,2,1,'2774A4',0,2,0),(6703,760,27793,0,2,'F63100',1,2,0),(6704,760,27790,0,3,'A54F10',1,2,0),(6705,760,27792,0,4,'FC6EA3',1,2,0),(6706,760,27789,0,5,'6C59DC',1,2,0),(6707,762,27875,5,0,'1A7C11',0,2,0),(6708,762,27878,2,1,'2774A4',0,2,0),(6709,762,27877,0,2,'F63100',1,2,0),(6710,762,27874,0,3,'A54F10',1,2,0),(6711,762,27876,0,4,'FC6EA3',1,2,0),(6712,762,27873,0,5,'6C59DC',1,2,0),(6713,763,27912,5,0,'1A7C11',0,2,0),(6714,763,27915,2,1,'2774A4',0,2,0),(6715,763,27914,0,2,'F63100',1,2,0),(6716,763,27911,0,3,'A54F10',1,2,0),(6717,763,27913,0,4,'FC6EA3',1,2,0),(6718,763,27910,0,5,'6C59DC',1,2,0),(6719,764,27947,5,0,'1A7C11',0,2,0),(6720,764,27950,2,1,'2774A4',0,2,0),(6721,764,27949,0,2,'F63100',1,2,0),(6722,764,27946,0,3,'A54F10',1,2,0),(6723,764,27948,0,4,'FC6EA3',1,2,0),(6724,764,27945,0,5,'6C59DC',1,2,0),(6725,769,28061,5,0,'1A7C11',0,2,0),(6726,769,28064,2,1,'2774A4',0,2,0),(6727,769,28063,0,2,'F63100',1,2,0),(6728,769,28060,0,3,'A54F10',1,2,0),(6729,769,28062,0,4,'FC6EA3',1,2,0),(6730,769,28059,0,5,'6C59DC',1,2,0),(6731,773,28121,5,0,'1A7C11',0,2,0),(6732,773,28124,2,1,'2774A4',0,2,0),(6733,773,28123,0,2,'F63100',1,2,0),(6734,773,28120,0,3,'A54F10',1,2,0),(6735,773,28122,0,4,'FC6EA3',1,2,0),(6736,773,28119,0,5,'6C59DC',1,2,0),(6737,778,28178,5,0,'1A7C11',0,2,0),(6738,778,28181,2,1,'2774A4',0,2,0),(6739,778,28180,0,2,'F63100',1,2,0),(6740,778,28177,0,3,'A54F10',1,2,0),(6741,778,28179,0,4,'FC6EA3',1,2,0),(6742,778,28176,0,5,'6C59DC',1,2,0),(6743,785,28226,5,0,'1A7C11',0,2,0),(6744,785,28229,2,1,'2774A4',0,2,0),(6745,785,28228,0,2,'F63100',1,2,0),(6746,785,28225,0,3,'A54F10',1,2,0),(6747,785,28227,0,4,'FC6EA3',1,2,0),(6748,785,28224,0,5,'6C59DC',1,2,0),(6749,790,28296,5,0,'1A7C11',0,2,0),(6750,790,28299,2,1,'2774A4',0,2,0),(6751,790,28298,0,2,'F63100',1,2,0),(6752,790,28295,0,3,'A54F10',1,2,0),(6753,790,28297,0,4,'FC6EA3',1,2,0),(6754,790,28294,0,5,'6C59DC',1,2,0),(6755,766,27124,5,0,'1A7C11',0,2,0),(6756,766,27125,2,1,'2774A4',0,2,0),(6757,766,27123,0,2,'F63100',1,2,0),(6758,766,27126,0,3,'A54F10',1,2,0),(6759,766,27122,0,4,'FC6EA3',1,2,0),(6760,766,27119,0,5,'6C59DC',1,2,0),(6761,772,28100,5,0,'1A7C11',0,2,0),(6762,772,28103,2,1,'2774A4',0,2,0),(6763,772,28102,0,2,'F63100',1,2,0),(6764,772,28099,0,3,'A54F10',1,2,0),(6765,772,28101,0,4,'FC6EA3',1,2,0),(6766,772,28098,0,5,'6C59DC',1,2,0),(6767,797,28546,0,0,'C80000',0,2,0),(6768,797,28545,0,1,'00C800',0,2,0),(6769,798,28551,0,0,'009900',0,2,0),(6770,798,28543,0,1,'DD0000',0,2,0),(6771,798,28542,0,2,'00DDDD',0,2,0),(6772,798,28549,0,3,'3333FF',0,2,0),(6773,798,28544,0,4,'999900',0,2,0),(6774,798,28548,0,5,'00FF00',0,2,0),(6775,799,28581,0,0,'990099',0,2,0),(6776,799,28574,0,1,'990000',0,2,0),(6777,799,28571,0,2,'0000EE',0,2,0),(6778,799,28565,0,3,'FF33FF',0,2,0),(6779,799,28570,0,4,'009600',0,2,0),(6780,799,28569,0,5,'003300',0,2,0),(6781,799,28577,0,6,'CCCC00',0,2,0),(6782,799,28552,0,7,'33FFFF',0,2,0),(6783,799,28573,0,8,'DD0000',0,2,0),(6784,799,28579,0,9,'000099',0,2,0),(6785,799,28559,0,10,'00FF00',0,2,0),(6786,800,28572,0,0,'00EE00',0,2,0),(6787,800,28566,0,1,'0000EE',0,2,0),(6788,800,28568,0,2,'FFAA00',0,2,0),(6789,800,28561,0,3,'00EEEE',0,2,0),(6790,800,28564,0,4,'990099',0,2,0),(6791,800,28567,0,5,'EE0000',0,2,0),(6792,800,28578,0,6,'FF66FF',0,2,0),(6793,800,28580,0,7,'009999',0,2,0),(6794,800,28562,0,8,'BBBB00',0,2,0),(6795,800,28563,0,9,'AA0000',0,2,0),(6796,800,28575,0,10,'990000',0,2,0),(6797,800,28576,0,11,'008800',0,2,0),(6798,800,28582,0,12,'80B0E0',0,2,0),(6799,800,28583,0,13,'4080B0',0,2,0),(6800,801,28560,0,0,'008800',0,2,0),(6801,801,28584,0,1,'EE0000',0,2,0),(6802,802,28550,5,0,'00C800',0,2,0),(6803,802,28540,0,1,'F63100',0,2,0),(6804,803,28599,0,0,'DD0000',0,2,0),(6805,803,28596,0,1,'00DDDD',0,2,0),(6806,803,28597,0,2,'3333FF',0,2,0),(6807,803,28598,0,3,'00FF00',0,2,0),(6808,804,28602,0,0,'990099',0,2,0),(6809,804,28606,0,1,'990000',0,2,0),(6810,804,28608,0,2,'0000EE',0,2,0),(6811,804,28615,0,3,'FF33FF',0,2,0),(6812,804,28610,0,4,'00EE00',0,2,0),(6813,804,28611,0,5,'003300',0,2,0),(6814,804,28616,0,6,'33FFFF',0,2,0),(6815,804,28607,0,7,'DD0000',0,2,0),(6816,804,28604,0,8,'000099',0,2,0),(6817,804,28588,0,9,'00FF00',0,2,0),(6818,805,28612,0,0,'FFAA00',0,2,0),(6819,805,28600,0,1,'990099',0,2,0),(6820,805,28613,0,2,'EE0000',0,2,0),(6821,805,28605,0,3,'FF66FF',0,2,0),(6822,805,28614,0,4,'960000',0,2,0),(6823,805,28601,0,5,'009600',0,2,0),(6824,805,28603,0,6,'009999',0,2,0),(6825,805,28609,0,7,'BBBB00',0,2,0),(6826,806,28595,0,0,'00C800',0,2,0),(6827,806,28586,0,1,'C80000',0,2,0);
/*!40000 ALTER TABLE `graphs_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_discovery`
--

DROP TABLE IF EXISTS `group_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_discovery` (
  `groupid` bigint(20) unsigned NOT NULL,
  `parent_group_prototypeid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupid`),
  KEY `c_group_discovery_2` (`parent_group_prototypeid`),
  CONSTRAINT `c_group_discovery_1` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE,
  CONSTRAINT `c_group_discovery_2` FOREIGN KEY (`parent_group_prototypeid`) REFERENCES `group_prototype` (`group_prototypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_discovery`
--

LOCK TABLES `group_discovery` WRITE;
/*!40000 ALTER TABLE `group_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_prototype`
--

DROP TABLE IF EXISTS `group_prototype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_prototype` (
  `group_prototypeid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `groupid` bigint(20) unsigned DEFAULT NULL,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`group_prototypeid`),
  KEY `group_prototype_1` (`hostid`),
  KEY `c_group_prototype_2` (`groupid`),
  KEY `c_group_prototype_3` (`templateid`),
  CONSTRAINT `c_group_prototype_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_group_prototype_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`),
  CONSTRAINT `c_group_prototype_3` FOREIGN KEY (`templateid`) REFERENCES `group_prototype` (`group_prototypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_prototype`
--

LOCK TABLES `group_prototype` WRITE;
/*!40000 ALTER TABLE `group_prototype` DISABLE KEYS */;
INSERT INTO `group_prototype` VALUES (37,10176,'{#CLUSTER.NAME}',NULL,NULL),(38,10176,'{#DATACENTER.NAME}',NULL,NULL),(39,10176,'',7,NULL),(40,10177,'{#CLUSTER.NAME} (vm)',NULL,NULL),(41,10177,'{#DATACENTER.NAME} (vm)',NULL,NULL),(42,10177,'{#HV.NAME}',NULL,NULL),(43,10177,'',6,NULL);
/*!40000 ALTER TABLE `group_prototype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` double(16,4) NOT NULL DEFAULT '0.0000',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
INSERT INTO `history` VALUES (25668,1564099308,0.0000,541329977),(23268,1564099308,0.0000,541478342),(23302,1564099342,0.0000,369312758),(23303,1564099343,2.7273,356587210),(23304,1564099344,0.0000,358014273),(23664,1564099344,83.9615,358210074),(23305,1564099345,13.4156,359005348),(23306,1564099346,9.0323,361134089),(23310,1564099350,100.0000,366749297),(23252,1564099352,51.1002,367450554),(23253,1564099353,0.0000,368006611),(23255,1564099355,45.0549,369854421),(23256,1564099356,42.8397,371644321),(28536,1564099356,42.4169,371676230),(23257,1564099357,0.7278,372088516),(23258,1564099358,0.0000,373383969),(28538,1564099358,39.5393,373534450),(23259,1564099359,0.0555,374407596),(23620,1564099360,0.1217,375299002),(23260,1564099360,36.7182,375375088),(23264,1564099364,32.6685,377125322),(23265,1564099365,31.2631,377648008),(23266,1564099366,29.4300,378036393),(25667,1564099367,0.0000,378715615),(25668,1564099368,28.6522,379373663),(23268,1564099368,28.6928,379467021),(23269,1564099369,27.9274,380055146),(23270,1564099370,27.5336,380572987),(25371,1564099371,26.5807,381322822),(23273,1564099373,4.0114,382857674),(23274,1564099374,0.0000,385083634),(23275,1564099375,0.1185,385715075),(23276,1564099376,0.0881,386107083),(28498,1564099378,0.0000,387232930),(28500,1564099380,0.0000,388327976),(23295,1564099395,0.0800,398140241),(23296,1564099396,0.5400,399625609),(23297,1564099397,0.2200,401643051),(23299,1564099399,89.2546,404953228),(23300,1564099400,0.0000,406169192),(23301,1564099401,7.8759,407862138),(23302,1564099402,0.0000,409498363),(23303,1564099403,0.1363,410035265),(23664,1564099404,0.0169,410905444),(23304,1564099404,0.0000,411778027),(23305,1564099405,0.9030,415006544),(23306,1564099406,0.7157,416156416),(23310,1564099410,100.0000,420297751),(23252,1564099412,0.0000,420611408),(23253,1564099413,0.0000,420987624),(23255,1564099415,0.0000,425303495),(23256,1564099416,0.0339,425657902),(28536,1564099416,0.0000,425735956),(23257,1564099417,0.5350,426793941),(23258,1564099418,0.0000,427115620),(28538,1564099418,0.0000,427190254),(23259,1564099419,0.0000,427515941),(23260,1564099420,0.0000,427971745),(23620,1564099420,0.1691,428114169),(23264,1564099424,0.0102,429157161),(23625,1564099425,0.5162,429605307),(23265,1564099425,0.0000,429677182),(23266,1564099426,0.0000,430765091),(25667,1564099427,0.0000,431309130),(23268,1564099428,0.0000,431705540),(25668,1564099428,0.0000,431856929),(23628,1564099428,0.2498,431932747),(23269,1564099429,0.0000,434368165),(23270,1564099430,0.0000,434815375),(25371,1564099431,0.0169,435676982),(23273,1564099433,4.0113,437671778),(10073,1564099433,0.6827,437841393),(23274,1564099434,0.0000,438357751),(10074,1564099434,0.0000,438432889),(10075,1564099435,0.0000,439299288),(23275,1564099435,0.1185,439344013),(10076,1564099436,0.1832,439675963),(23276,1564099436,0.1205,439856848),(10077,1564099437,0.0000,440495658),(23277,1564099437,0.9325,440631668),(10078,1564099438,0.0167,441163607),(28498,1564099438,0.0000,442735004),(28500,1564099440,0.0000,443228817),(23295,1564099455,0.0800,457508365),(23296,1564099456,0.2500,458931164),(23297,1564099457,0.1900,459895691),(23299,1564099459,95.8955,462685380),(23300,1564099460,0.0000,463678390),(23301,1564099461,2.8494,465565748),(23302,1564099462,0.0000,467300576),(23303,1564099463,0.0679,468072669),(23664,1564099464,0.0000,468355354),(23304,1564099464,0.0000,468875027),(23305,1564099465,0.5766,471523067),(23306,1564099466,0.4239,471375629),(23310,1564099470,100.0000,475204588),(23252,1564099472,0.0000,476354722),(23253,1564099473,0.0689,477860063),(23255,1564099475,0.0000,479659429),(23256,1564099476,0.0677,480827661),(28536,1564099476,0.0000,480889634),(23257,1564099477,0.2829,482238058),(23258,1564099478,0.0000,482977990),(28538,1564099478,0.0000,483050659),(23259,1564099479,0.0517,483442825),(23620,1564099480,0.1854,484761823),(23260,1564099480,0.0000,484887903),(23264,1564099484,0.0102,488170050),(23265,1564099485,0.0000,489005672),(23625,1564099485,1.3154,489078066),(23266,1564099486,0.0000,490267552),(25667,1564099487,0.0169,490999599),(25668,1564099488,0.0000,491399025),(23268,1564099488,0.0000,491470276),(23628,1564099488,0.0000,491495160),(23269,1564099489,0.0000,493279996),(23270,1564099490,0.0000,493612299),(25371,1564099491,0.0000,494121539),(23273,1564099493,4.0113,495426380),(10073,1564099493,0.7992,495547766),(23274,1564099494,0.0000,495918736),(10074,1564099494,0.0000,496054580),(10075,1564099495,0.0000,496744908),(23275,1564099495,0.1185,497118060),(23276,1564099496,0.1320,497877250),(10076,1564099496,0.2165,498008695),(10077,1564099497,0.0000,498466193),(23277,1564099497,1.0157,498578650),(10078,1564099498,0.0000,499542460),(28498,1564099498,0.0000,500938438),(28500,1564099500,0.0000,501176615),(23295,1564099515,0.1000,516111758),(23296,1564099516,0.4900,519352285),(23297,1564099517,0.2400,521618590),(23299,1564099519,96.7091,523180042),(23300,1564099520,0.0000,525366121),(23301,1564099521,2.3244,526596807),(23302,1564099522,0.0000,526455142),(23303,1564099523,0.1187,528396517),(23664,1564099524,0.0000,528889794),(23304,1564099524,0.0000,530993473),(23305,1564099525,0.5430,532148787),(23306,1564099526,0.3225,533564767),(23310,1564099530,100.0000,537099475),(23252,1564099532,0.0000,537501840),(23253,1564099533,0.0169,537830477),(23255,1564099535,0.0000,541624079),(23256,1564099536,0.0508,541914361),(28536,1564099536,0.0000,541993730),(23257,1564099537,0.3448,542774427),(23258,1564099538,0.0000,544130386),(28538,1564099538,0.0000,544279675),(23259,1564099539,0.0339,544906843),(23260,1564099540,0.0000,545149709),(23620,1564099540,0.1923,545222085),(23264,1564099544,0.0271,547395944),(23265,1564099545,0.0000,547801285),(23625,1564099545,1.7982,547946564),(23266,1564099546,0.0169,548480415),(25667,1564099547,0.0000,548798016),(23628,1564099548,0.0000,549061920),(23268,1564099548,0.0000,549135024),(25668,1564099548,0.0000,549162388),(23269,1564099549,0.0034,549932083),(23270,1564099550,0.0000,550170723),(25371,1564099551,0.0000,550437439),(10073,1564099553,0.7992,552020756),(23273,1564099553,4.0113,552089357),(10074,1564099554,0.0000,552688150),(23274,1564099554,0.0000,552757347),(10075,1564099555,0.0000,553009075),(23275,1564099555,0.1185,553101265),(23276,1564099556,0.1320,553709686),(10076,1564099556,0.2165,553851680),(10077,1564099557,0.0000,554304287),(23277,1564099557,1.0157,554447144),(10078,1564099558,0.0000,554941705),(28498,1564099558,0.0000,555324218),(28500,1564099560,0.0000,557146754),(23295,1564099575,0.1000,566657410),(23296,1564099576,0.2700,567907178),(23297,1564099577,0.2200,569358930),(23299,1564099579,95.5108,570636245),(23300,1564099580,0.0000,570888424),(23301,1564099581,3.3040,572873311),(23302,1564099582,0.0000,573381371),(23303,1564099583,0.1017,574548792),(23664,1564099584,0.0000,574843752),(23304,1564099584,0.0000,575158911),(23305,1564099585,0.5929,575467947),(23306,1564099586,0.4909,575806677),(23310,1564099590,100.0000,578769709),(23252,1564099592,0.0000,578681041),(23253,1564099593,0.0169,579767158),(23255,1564099595,0.0000,581701652),(23256,1564099596,0.1016,582068112),(28536,1564099596,0.0000,582143331),(23257,1564099597,0.3769,583879278),(28538,1564099598,0.0000,584125846),(23258,1564099598,0.0000,584189901),(23259,1564099599,0.0339,584799886),(23620,1564099600,0.2086,585037577),(23260,1564099600,0.0000,585155736),(23264,1564099604,0.0068,585958031),(23265,1564099605,0.0000,586754947),(23625,1564099605,2.2819,586823954),(23266,1564099606,0.0000,586984812),(25667,1564099607,0.0000,587519768),(25668,1564099608,0.0000,588223059),(23628,1564099608,0.0000,588406261),(23268,1564099608,0.0000,588499535),(23269,1564099609,0.0000,589255639),(23270,1564099610,0.0000,589516473),(25371,1564099611,0.0169,589883753),(23273,1564099613,4.0113,591190586),(10073,1564099613,0.7995,591262747),(10074,1564099614,0.0000,591404272),(23274,1564099614,0.0000,591474770),(10075,1564099615,0.0000,591975173),(23275,1564099615,0.1185,592045697),(23276,1564099616,0.1320,592382231),(10076,1564099616,0.2165,592454260),(23277,1564099617,1.0160,593322340),(10077,1564099617,0.0000,593386936),(10078,1564099618,0.0000,593736906),(28498,1564099618,0.0000,595176266),(28500,1564099620,0.0000,596071483),(23295,1564099635,0.0900,601276666),(23296,1564099636,0.1000,602661791),(23297,1564099637,0.1800,603777412),(23299,1564099639,96.4722,606035379),(23300,1564099640,0.0000,607608461),(23301,1564099641,2.4585,608501501),(23302,1564099642,0.0000,608887364),(23303,1564099643,0.0848,610704416),(23664,1564099644,0.0000,611628257),(23304,1564099644,0.0000,613507917),(23305,1564099645,0.5427,614639109),(23306,1564099646,0.3733,614536895),(23310,1564099650,100.0000,618175000),(23252,1564099652,0.0000,619620987),(23253,1564099653,0.0000,620821921),(23255,1564099655,0.0169,622157736),(28536,1564099656,0.0000,622849307),(23256,1564099656,0.0846,622909269),(23257,1564099657,0.2745,623777688),(23258,1564099658,0.0000,624040167),(28538,1564099658,0.0000,624144062),(23259,1564099659,0.0339,625583729),(23260,1564099660,0.0000,626057024),(23620,1564099660,0.2180,626325589),(23264,1564099664,0.0102,628518356),(23625,1564099665,2.7647,628918840),(23265,1564099665,0.0000,628988847),(23266,1564099666,0.0000,629267948),(25667,1564099667,0.0169,629542735),(23628,1564099668,0.0000,630158143),(23268,1564099668,0.0000,630303278),(25668,1564099668,0.0000,630383473),(23269,1564099669,0.0000,631452945),(23270,1564099670,0.0000,633303356),(25371,1564099671,0.0000,634100555),(10073,1564099673,0.7994,635023499),(23273,1564099673,4.0113,635179585),(10074,1564099674,0.0000,635598193),(23274,1564099674,0.0000,635772209),(10075,1564099675,0.0000,636369892),(23275,1564099675,0.1185,636517343),(23276,1564099676,0.1339,636752625),(10076,1564099676,0.2332,636826244),(23277,1564099677,1.0326,637200427),(10077,1564099677,0.0000,637338708),(28498,1564099678,0.0000,637931244),(10078,1564099678,0.0500,638003280),(28500,1564099680,0.0000,638632402),(23295,1564099695,0.0800,652296472),(23296,1564099696,0.0300,654255675),(23297,1564099697,0.1400,655100091),(23299,1564099699,96.9481,657387511),(23300,1564099700,0.0000,658353664),(23301,1564099701,2.0007,659316526),(23302,1564099702,0.0000,660300584),(23303,1564099703,0.0678,660926087),(23664,1564099704,0.0000,661957528),(23304,1564099704,0.0000,662704853),(23305,1564099705,0.6102,664067523),(23306,1564099706,0.4576,664826822),(23310,1564099710,100.0000,668106782),(23252,1564099712,0.0000,668652360),(23253,1564099713,0.0339,669161589),(23255,1564099715,0.0000,672208921),(23256,1564099716,0.0677,673876774),(28536,1564099716,0.0000,674007642),(23257,1564099717,0.2926,674522837),(28538,1564099718,0.0000,675077841),(23258,1564099718,0.0000,675228845),(23259,1564099719,0.0508,675693617),(23620,1564099720,0.2379,676178968),(23260,1564099720,0.0000,676299953),(23264,1564099724,0.0203,677399296),(23625,1564099725,3.1807,677937903),(23265,1564099725,0.0000,678154533),(23266,1564099726,0.0000,678551369),(25667,1564099727,0.0000,679072435),(23268,1564099728,0.0000,679522459),(25668,1564099728,0.0000,679741363),(23628,1564099728,0.0333,679931657),(23269,1564099729,0.0000,680428674),(23270,1564099730,0.0000,681307621),(25371,1564099731,0.0169,682060696),(10073,1564099733,0.7994,683665885),(23273,1564099733,4.0134,683805353),(10074,1564099734,0.0000,684325196),(23274,1564099734,0.0000,684475228),(23275,1564099735,0.1185,684875318),(10075,1564099735,0.0000,685009520),(23276,1564099736,0.1377,685344513),(10076,1564099736,0.2498,685491043),(23277,1564099737,1.0492,685835102),(10077,1564099737,0.0000,685954258),(10078,1564099738,0.0167,686875121),(28498,1564099738,0.0000,688025819),(28500,1564099740,0.0000,688453342),(23295,1564099755,0.0800,697529839),(23296,1564099756,0.0600,700669130),(23297,1564099757,0.1300,702663194),(23299,1564099759,96.8994,706261171),(23300,1564099760,0.0000,707993529),(23301,1564099761,1.9827,714542676),(23302,1564099762,0.0000,716561574),(23303,1564099763,0.1186,717210136),(23304,1564099764,0.0000,717756034),(23664,1564099764,0.0000,717828928),(23305,1564099765,0.5931,726040840),(23306,1564099766,0.4746,725838673),(23310,1564099770,100.0000,729041989),(23252,1564099772,0.0000,729293177),(23253,1564099773,0.0339,729604728),(23255,1564099775,0.0000,730938483),(28536,1564099776,0.0000,731285543),(23256,1564099776,0.0677,734644959),(23257,1564099777,0.2757,735077019),(23258,1564099778,0.0000,735578545),(28538,1564099778,0.0000,735651701),(23259,1564099779,0.0508,735918149),(23620,1564099780,0.2465,736401128),(23260,1564099780,0.0000,736475602),(23264,1564099784,0.0135,738751759),(23265,1564099785,0.0000,739709103),(23625,1564099785,3.5963,739779009),(23266,1564099786,0.0000,741038559),(25667,1564099787,0.0000,741373683),(23628,1564099788,0.0000,744827371),(23268,1564099788,0.0000,744912394),(25668,1564099788,0.0000,744940176),(23269,1564099789,0.0000,746624452),(23270,1564099790,0.0000,747200853),(25371,1564099791,0.0000,749566972),(10073,1564099793,0.7991,750354082),(23273,1564099793,4.0134,750425307),(10074,1564099794,0.0000,751390350),(23274,1564099794,0.0000,751532312),(23275,1564099795,0.1185,752841242),(10075,1564099795,0.0000,752913123),(23276,1564099796,0.1377,753325664),(10076,1564099796,0.2164,753397385),(23277,1564099797,1.0155,753826627),(10077,1564099797,0.0000,753899618),(10078,1564099798,0.0000,754132744),(28498,1564099798,0.0000,754875942),(28500,1564099800,0.0000,755282291),(23295,1564099815,0.1100,761082008),(23296,1564099816,0.3700,761743894),(23297,1564099817,0.2100,762985377),(23299,1564099819,96.0874,765176573),(23300,1564099820,0.0000,766086492),(23301,1564099821,2.2185,767092316),(23302,1564099822,0.0000,767456669),(23303,1564099823,0.1186,769086176),(23664,1564099824,0.0000,769321515),(23304,1564099824,0.0000,770683106),(23305,1564099825,0.8129,771091675),(23306,1564099826,0.6603,772387075),(23310,1564099830,100.0000,775566689),(23252,1564099832,0.0000,776211816),(23253,1564099833,0.0508,777106124),(23255,1564099835,0.0000,778495843),(23256,1564099836,0.0677,780711480),(28536,1564099836,0.0000,780807105),(23257,1564099837,0.3165,781667442),(28538,1564099838,0.0000,781968937),(23258,1564099838,0.0000,782043267),(23259,1564099839,0.0508,782291914),(23260,1564099840,0.0000,783476639),(23620,1564099840,0.2600,783545653),(23264,1564099844,0.0136,785586553),(23265,1564099845,0.0000,786022317),(23625,1564099845,4.0136,786167122),(23266,1564099846,0.0000,786597839),(25667,1564099847,0.0000,787028268),(25668,1564099848,0.0000,787462940),(23268,1564099848,0.0000,787533816),(23628,1564099848,0.0000,787557966),(23269,1564099849,0.0000,788040744),(23270,1564099850,0.0000,789028967),(25371,1564099851,0.0000,789431470),(23273,1564099853,4.0134,793171171),(10073,1564099853,0.7994,793299787),(10074,1564099854,0.0000,793828626),(23274,1564099854,0.0000,794082358),(23275,1564099855,0.1185,794741071),(10075,1564099855,0.0000,794887862),(23276,1564099856,0.1377,795468072),(10076,1564099856,0.2165,795544336),(10077,1564099857,0.0000,796003061),(23277,1564099857,1.0160,796072464),(10078,1564099858,0.0000,796269180),(28498,1564099858,0.0000,796873732),(28500,1564099860,0.0000,799121465),(23295,1564099875,0.1100,817301700),(23296,1564099876,0.2200,818054803),(23297,1564099877,0.2000,819093942),(23299,1564099879,96.7255,821230931),(23300,1564099880,0.0000,822922411),(23301,1564099881,2.3248,823843937),(23302,1564099882,0.0000,824660357),(23303,1564099883,0.0509,825956848),(23664,1564099884,0.0000,825579173),(23304,1564099884,0.0000,826973139),(23305,1564099885,0.4073,827269684),(23306,1564099886,0.4243,827356387),(23310,1564099890,100.0000,831316838),(23252,1564099892,0.0000,831551711),(23253,1564099893,0.0339,832816216),(23255,1564099895,0.0169,834343819),(28536,1564099896,0.0000,835009873),(23256,1564099896,0.0339,835157522),(23257,1564099897,0.2164,835825513),(28538,1564099898,0.0000,836360302),(23258,1564099898,0.0000,836438694),(23259,1564099899,0.0169,836760248),(23620,1564099900,0.2711,837318286),(23260,1564099900,0.0000,837480236),(23264,1564099904,0.0305,840019727),(23265,1564099905,0.0000,840620528),(23625,1564099905,4.4293,840773543),(23266,1564099906,0.0000,841472389),(25667,1564099907,0.0000,842018625),(23268,1564099908,0.0000,843041701),(23628,1564099908,0.0000,843183035),(25668,1564099908,0.0000,843262440),(23269,1564099909,0.0000,844057434),(23270,1564099910,0.0000,845247015),(25371,1564099911,0.0000,846047981),(23273,1564099913,4.0134,847115179),(10073,1564099913,0.7993,847187036),(10074,1564099914,0.0000,847508495),(23274,1564099914,0.0000,847661023),(23275,1564099915,0.1185,848249522),(10075,1564099915,0.0000,848391042),(10076,1564099916,0.2165,848642493),(23276,1564099916,0.1377,848713124),(10077,1564099917,0.0000,848999937),(23277,1564099917,1.0158,849070758),(10078,1564099918,0.0000,849465747),(28498,1564099918,0.0000,851158768),(28500,1564099920,0.0000,852655701),(23295,1564099935,0.1000,865208829),(23296,1564099936,0.0800,863298389),(23297,1564099937,0.1600,863575892),(23299,1564099939,96.6627,865926560),(23300,1564099940,0.0000,868166244),(23301,1564099941,2.5250,868146576),(23302,1564099942,0.0000,869700629),(23303,1564099943,0.0508,871148153),(23664,1564099944,0.0000,871642171),(23304,1564099944,0.0000,872190411),(23305,1564099945,0.6270,874633290),(23306,1564099946,0.3389,875169473),(23310,1564099950,100.0000,878428427),(23252,1564099952,0.0000,880105991),(23253,1564099953,0.0339,880353780),(23255,1564099955,0.0000,882561780),(23256,1564099956,0.0677,883723688),(28536,1564099956,0.0000,883855361),(23257,1564099957,0.2197,884450841),(23258,1564099958,0.0000,885028484),(28538,1564099958,0.0000,885239795),(23259,1564099959,0.0169,885683173),(23620,1564099960,0.2857,886798815),(23260,1564099960,0.0000,886873270),(23264,1564099964,0.0136,888434674),(23265,1564099965,0.0000,888750253),(23625,1564099965,4.6130,888865776),(23266,1564099966,0.0000,889286111),(25667,1564099967,0.0169,889715753),(23628,1564099968,0.0000,890361726),(25668,1564099968,0.0000,890650689),(23268,1564099968,0.0000,890738201),(23269,1564099969,0.0000,891298909),(23270,1564099970,0.0000,891752558),(25371,1564099971,0.0000,891989444);
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_log`
--

DROP TABLE IF EXISTS `history_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_log` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `source` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT '0',
  `value` text COLLATE utf8_bin NOT NULL,
  `logeventid` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_log_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_log`
--

LOCK TABLES `history_log` WRITE;
/*!40000 ALTER TABLE `history_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_str`
--

DROP TABLE IF EXISTS `history_str`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_str` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_str_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_str`
--

LOCK TABLES `history_str` WRITE;
/*!40000 ALTER TABLE `history_str` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_str` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_text`
--

DROP TABLE IF EXISTS `history_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_text` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` text COLLATE utf8_bin NOT NULL,
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_text_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_text`
--

LOCK TABLES `history_text` WRITE;
/*!40000 ALTER TABLE `history_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_uint`
--

DROP TABLE IF EXISTS `history_uint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_uint` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_uint_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_uint`
--

LOCK TABLES `history_uint` WRITE;
/*!40000 ALTER TABLE `history_uint` DISABLE KEYS */;
INSERT INTO `history_uint` VALUES (23662,1564099342,0,355643847),(23308,1564099348,1564099348,364006066),(23309,1564099349,2146430976,364239692),(28534,1564099354,0,371439810),(23314,1564099354,1,423371172),(23316,1564099356,1737461760,371573183),(28249,1564099369,0,379996295),(23272,1564099372,0,381778703),(23287,1564099387,1,391568130),(23291,1564099391,1,399369632),(23292,1564099392,130,395531529),(23662,1564099402,0,408309429),(23308,1564099408,1564099408,418085966),(23309,1564099409,2146430976,419558921),(28534,1564099414,0,426907166),(23314,1564099414,1,434873352),(23316,1564099416,1732059136,426263948),(28249,1564099429,0,434872394),(23272,1564099432,0,437270678),(23287,1564099447,1,448586315),(23291,1564099451,1,466283261),(23292,1564099452,130,455811259),(23294,1564099454,107,455071688),(23298,1564099458,245,461506284),(23662,1564099462,0,466215362),(23308,1564099468,1564099468,473424238),(23309,1564099469,2146430976,475127907),(28534,1564099474,0,479357068),(23314,1564099474,1,483382223),(23316,1564099476,1730928640,480999649),(28249,1564099489,0,493479614),(23272,1564099492,0,494854186),(23287,1564099507,1,507772185),(23291,1564099511,2,531028914),(23292,1564099512,131,515586597),(23294,1564099514,109,513992154),(23298,1564099518,238,523841961),(23662,1564099522,0,526286252),(23308,1564099528,1564099528,537188765),(23309,1564099529,2146430976,536814550),(28534,1564099534,0,541169938),(23314,1564099534,1,554823401),(23316,1564099536,1730695168,542599491),(28249,1564099549,0,549794825),(23272,1564099552,0,550793336),(23287,1564099567,1,560749496),(23291,1564099571,1,566966169),(23292,1564099572,130,566554839),(23294,1564099574,100,565562009),(23298,1564099578,233,570356300),(23662,1564099582,0,572888426),(23308,1564099588,1564099588,577194623),(23309,1564099589,2146430976,578359466),(28534,1564099594,0,581642079),(23314,1564099594,1,585245576),(23316,1564099596,1730543616,582647339),(28249,1564099609,0,589631708),(23272,1564099612,0,590398963),(23287,1564099627,1,597315942),(23291,1564099631,1,608100063),(23292,1564099632,130,604192810),(23294,1564099634,102,600361900),(23298,1564099638,235,604191462),(23662,1564099642,0,609014457),(23308,1564099648,1564099648,616116562),(23309,1564099649,2146430976,617412163),(28534,1564099654,0,624250975),(23314,1564099654,1,635201879),(23316,1564099656,1730449408,623269403),(28249,1564099669,0,631624805),(23271,1564099671,0,633954214),(23272,1564099672,0,634541409),(23287,1564099687,1,645685705),(23291,1564099691,1,665732165),(23292,1564099692,125,650193358),(23293,1564099693,1564099322,649712960),(23294,1564099694,96,651700450),(23298,1564099698,225,656324484),(23662,1564099702,0,659188358),(23308,1564099708,1564099708,666203800),(23309,1564099709,2146430976,667297515),(23313,1564099713,392,670363429),(28534,1564099714,0,672111145),(23314,1564099714,1,683931215),(23316,1564099716,1730293760,675215205),(28249,1564099729,0,681113005),(23272,1564099732,0,682692181),(23287,1564099747,1,692547553),(23291,1564099751,1,715518260),(23292,1564099752,124,696758255),(23294,1564099754,98,696178870),(23298,1564099758,233,705121539),(23662,1564099762,0,716024457),(23308,1564099768,1564099768,727930372),(23309,1564099769,2146430976,727944007),(28534,1564099774,0,731413531),(23314,1564099774,1,735237290),(23316,1564099776,1729609728,736146760),(28249,1564099789,0,747298827),(23272,1564099792,0,749959843),(23287,1564099807,1,757859921),(23291,1564099811,1,776369218),(23292,1564099812,124,761424876),(23294,1564099814,107,760519645),(23298,1564099818,252,764187750),(23662,1564099822,0,767525605),(23308,1564099828,1564099828,773773178),(23309,1564099829,2146430976,774108604),(28534,1564099834,0,780294528),(23314,1564099834,1,794696716),(23316,1564099836,1729363968,780396055),(28249,1564099849,0,788284174),(23272,1564099852,0,789940542),(23287,1564099867,1,802509011),(23291,1564099871,1,817352074),(23292,1564099872,124,811379359),(23294,1564099874,100,816226945),(23298,1564099878,229,821192463),(23662,1564099882,0,824085069),(23308,1564099888,1564099888,829487475),(23309,1564099889,2146430976,830287171),(28534,1564099894,0,836181871),(23314,1564099894,1,850329854),(23316,1564099896,1729515520,836578471),(28249,1564099909,0,844434149),(23272,1564099912,0,846528733),(23287,1564099927,1,854760229),(23291,1564099931,1,873660648),(23292,1564099932,125,858863580),(23294,1564099934,102,860220456),(23298,1564099938,232,865612021),(23662,1564099942,0,869364329),(23308,1564099948,1564099948,876983143),(23309,1564099949,2146430976,877624275),(28534,1564099954,0,882429713),(23314,1564099954,1,886115379),(23316,1564099956,1729093632,885319047),(28249,1564099969,0,891614948);
/*!40000 ALTER TABLE `history_uint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_discovery`
--

DROP TABLE IF EXISTS `host_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_discovery` (
  `hostid` bigint(20) unsigned NOT NULL,
  `parent_hostid` bigint(20) unsigned DEFAULT NULL,
  `parent_itemid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`hostid`),
  KEY `c_host_discovery_2` (`parent_hostid`),
  KEY `c_host_discovery_3` (`parent_itemid`),
  CONSTRAINT `c_host_discovery_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_host_discovery_2` FOREIGN KEY (`parent_hostid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_host_discovery_3` FOREIGN KEY (`parent_itemid`) REFERENCES `items` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_discovery`
--

LOCK TABLES `host_discovery` WRITE;
/*!40000 ALTER TABLE `host_discovery` DISABLE KEYS */;
INSERT INTO `host_discovery` VALUES (10176,NULL,26988,'',0,0),(10177,NULL,26989,'',0,0);
/*!40000 ALTER TABLE `host_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_inventory`
--

DROP TABLE IF EXISTS `host_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_inventory` (
  `hostid` bigint(20) unsigned NOT NULL,
  `inventory_mode` int(11) NOT NULL DEFAULT '0',
  `type` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type_full` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `alias` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `os` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `os_full` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `os_short` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `serialno_a` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `serialno_b` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `tag` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `asset_tag` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `macaddress_a` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `macaddress_b` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `hardware` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `hardware_full` text COLLATE utf8_bin NOT NULL,
  `software` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `software_full` text COLLATE utf8_bin NOT NULL,
  `software_app_a` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `software_app_b` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `software_app_c` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `software_app_d` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `software_app_e` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `contact` text COLLATE utf8_bin NOT NULL,
  `location` text COLLATE utf8_bin NOT NULL,
  `location_lat` varchar(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `location_lon` varchar(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `notes` text COLLATE utf8_bin NOT NULL,
  `chassis` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `model` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `hw_arch` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `vendor` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `contract_number` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `installer_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `deployment_status` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `url_a` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `url_b` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `url_c` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `host_networks` text COLLATE utf8_bin NOT NULL,
  `host_netmask` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `host_router` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `oob_ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `oob_netmask` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `oob_router` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `date_hw_purchase` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `date_hw_install` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `date_hw_expiry` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `date_hw_decomm` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_address_a` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_address_b` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_address_c` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_city` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_state` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_country` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_zip` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_rack` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_notes` text COLLATE utf8_bin NOT NULL,
  `poc_1_name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_1_email` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_1_phone_a` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_1_phone_b` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_1_cell` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_1_screen` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_1_notes` text COLLATE utf8_bin NOT NULL,
  `poc_2_name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_2_email` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_2_phone_a` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_2_phone_b` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_2_cell` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_2_screen` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_2_notes` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`hostid`),
  CONSTRAINT `c_host_inventory_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_inventory`
--

LOCK TABLES `host_inventory` WRITE;
/*!40000 ALTER TABLE `host_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_tag`
--

DROP TABLE IF EXISTS `host_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_tag` (
  `hosttagid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`hosttagid`),
  KEY `host_tag_1` (`hostid`),
  CONSTRAINT `c_host_tag_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_tag`
--

LOCK TABLES `host_tag` WRITE;
/*!40000 ALTER TABLE `host_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostmacro`
--

DROP TABLE IF EXISTS `hostmacro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hostmacro` (
  `hostmacroid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `macro` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`hostmacroid`),
  UNIQUE KEY `hostmacro_1` (`hostid`,`macro`),
  CONSTRAINT `c_hostmacro_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostmacro`
--

LOCK TABLES `hostmacro` WRITE;
/*!40000 ALTER TABLE `hostmacro` DISABLE KEYS */;
INSERT INTO `hostmacro` VALUES (351,10184,'{$CPU_UTIL_MAX}','90'),(352,10184,'{$MEMORY_UTIL_MAX}','90'),(356,10184,'{$STORAGE_UTIL_CRIT}','90'),(357,10184,'{$STORAGE_UTIL_WARN}','80'),(358,10185,'{$CPU_UTIL_MAX}','90'),(359,10185,'{$MEMORY_UTIL_MAX}','90'),(363,10185,'{$STORAGE_UTIL_CRIT}','90'),(364,10185,'{$STORAGE_UTIL_WARN}','80'),(365,10186,'{$ICMP_LOSS_WARN}','20'),(366,10186,'{$ICMP_RESPONSE_TIME_WARN}','0.15'),(367,10187,'{$IFCONTROL}','1'),(368,10187,'{$IF_UTIL_MAX}','95'),(369,10187,'{$IF_ERRORS_WARN}','2'),(370,10188,'{$IFCONTROL}','1'),(371,10188,'{$IF_UTIL_MAX}','95'),(372,10188,'{$IF_ERRORS_WARN}','2'),(373,10189,'{$IFCONTROL}','1'),(374,10189,'{$IF_UTIL_MAX}','90'),(375,10189,'{$IF_ERRORS_WARN}','2'),(376,10190,'{$IFCONTROL}','1'),(377,10190,'{$IF_UTIL_MAX}','90'),(378,10190,'{$IF_ERRORS_WARN}','2'),(382,10192,'{$IFCONTROL}','1'),(383,10192,'{$IF_UTIL_MAX}','90'),(384,10192,'{$IF_ERRORS_WARN}','2'),(385,10203,'{$SNMP_TIMEOUT}','3m'),(386,10204,'{$SNMP_TIMEOUT}','3m'),(393,10207,'{$TEMP_CRIT}','75'),(394,10207,'{$TEMP_WARN}','65'),(395,10207,'{$PSU_CRIT_STATUS}','4'),(396,10207,'{$FAN_CRIT_STATUS}','4'),(397,10207,'{$CPU_UTIL_MAX}','90'),(398,10207,'{$MEMORY_UTIL_MAX}','90'),(399,10207,'{$TEMP_CRIT_LOW}','5'),(402,10208,'{$TEMP_CRIT}','75'),(403,10208,'{$TEMP_WARN}','65'),(404,10208,'{$HEALTH_CRIT_STATUS}','4'),(405,10208,'{$HEALTH_WARN_STATUS:\"offline\"}','2'),(406,10208,'{$HEALTH_WARN_STATUS:\"testing\"}','3'),(407,10208,'{$TEMP_WARN_STATUS}','5'),(408,10208,'{$PSU_CRIT_STATUS}','2'),(409,10208,'{$FAN_CRIT_STATUS}','2'),(410,10208,'{$PSU_OK_STATUS}','4'),(411,10208,'{$FAN_OK_STATUS}','4'),(412,10208,'{$CPU_UTIL_MAX}','90'),(413,10208,'{$MEMORY_UTIL_MAX}','90'),(414,10208,'{$TEMP_CRIT_LOW}','5'),(417,10210,'{$TEMP_CRIT}','75'),(418,10210,'{$TEMP_WARN}','65'),(419,10210,'{$PSU_CRIT_STATUS}','3'),(420,10210,'{$FAN_CRIT_STATUS}','3'),(421,10210,'{$PSU_OK_STATUS}','2'),(422,10210,'{$FAN_OK_STATUS}','2'),(425,10210,'{$TEMP_CRIT_LOW}','5'),(428,10211,'{$TEMP_CRIT}','75'),(429,10211,'{$TEMP_WARN}','65'),(430,10211,'{$PSU_CRIT_STATUS}','3'),(431,10211,'{$FAN_CRIT_STATUS}','3'),(432,10211,'{$PSU_OK_STATUS}','2'),(433,10211,'{$FAN_OK_STATUS}','2'),(436,10211,'{$TEMP_CRIT_LOW}','5'),(439,10217,'{$TEMP_CRIT:\"CPU\"}','75'),(440,10217,'{$TEMP_WARN:\"CPU\"}','70'),(441,10217,'{$TEMP_WARN_STATUS}','2'),(442,10217,'{$TEMP_CRIT_STATUS}','3'),(443,10217,'{$TEMP_DISASTER_STATUS}','4'),(469,10221,'{$TEMP_CRIT}','65'),(470,10221,'{$TEMP_WARN}','55'),(471,10221,'{$PSU_CRIT_STATUS}','2'),(472,10221,'{$FAN_CRIT_STATUS}','2'),(473,10221,'{$PSU_OK_STATUS}','1'),(474,10221,'{$FAN_OK_STATUS}','1'),(475,10221,'{$CPU_UTIL_MAX}','90'),(476,10221,'{$MEMORY_UTIL_MAX}','90'),(477,10221,'{$TEMP_CRIT_LOW}','5'),(480,10222,'{$TEMP_CRIT}','75'),(481,10222,'{$TEMP_WARN}','65'),(482,10222,'{$PSU_CRIT_STATUS}','5'),(483,10222,'{$FAN_CRIT_STATUS}','5'),(484,10222,'{$CPU_UTIL_MAX}','90'),(485,10222,'{$MEMORY_UTIL_MAX}','90'),(486,10222,'{$TEMP_CRIT_LOW}','5'),(489,10223,'{$TEMP_CRIT}','75'),(490,10223,'{$TEMP_WARN}','65'),(491,10223,'{$PSU_CRIT_STATUS}','4'),(492,10223,'{$FAN_CRIT_STATUS}','2'),(493,10223,'{$CPU_UTIL_MAX}','90'),(494,10223,'{$MEMORY_UTIL_MAX}','90'),(495,10223,'{$TEMP_CRIT_LOW}','5'),(498,10224,'{$TEMP_CRIT}','65'),(499,10224,'{$TEMP_WARN}','55'),(500,10224,'{$TEMP_CRIT_STATUS}','1'),(501,10224,'{$PSU_CRIT_STATUS}','3'),(502,10224,'{$FAN_CRIT_STATUS}','2'),(505,10224,'{$CPU_UTIL_MAX}','90'),(506,10224,'{$MEMORY_UTIL_MAX}','90'),(507,10224,'{$TEMP_CRIT_LOW}','5'),(510,10227,'{$FAN_CRIT_STATUS:\"fanError\"}','41'),(511,10227,'{$FAN_CRIT_STATUS:\"hardwareFaulty\"}','91'),(512,10227,'{$PSU_CRIT_STATUS:\"psuError\"}','51'),(513,10227,'{$PSU_CRIT_STATUS:\"rpsError\"}','61'),(514,10227,'{$PSU_CRIT_STATUS:\"hardwareFaulty\"}','91'),(515,10227,'{$CPU_UTIL_MAX}','90'),(516,10227,'{$MEMORY_UTIL_MAX}','90'),(517,10227,'{$TEMP_CRIT}','60'),(518,10227,'{$TEMP_WARN}','50'),(519,10227,'{$TEMP_CRIT_LOW}','5'),(533,10229,'{$FAN_CRIT_STATUS}','2'),(534,10229,'{$CPU_UTIL_MAX}','90'),(535,10229,'{$MEMORY_UTIL_MAX}','90'),(536,10229,'{$TEMP_CRIT}','60'),(537,10229,'{$TEMP_WARN}','50'),(538,10229,'{$TEMP_CRIT_LOW}','5'),(541,10230,'{$TEMP_CRIT_STATUS}','3'),(542,10230,'{$TEMP_WARN_STATUS}','2'),(543,10230,'{$PSU_CRIT_STATUS}','3'),(544,10230,'{$FAN_CRIT_STATUS}','3'),(547,10230,'{$TEMP_CRIT}','60'),(548,10230,'{$TEMP_WARN}','50'),(549,10230,'{$TEMP_CRIT_LOW}','5'),(552,10231,'{$TEMP_CRIT:\"Routing Engine\"}','80'),(553,10231,'{$TEMP_WARN:\"Routing Engine\"}','70'),(554,10231,'{$HEALTH_CRIT_STATUS}','3'),(555,10231,'{$FAN_CRIT_STATUS}','6'),(556,10231,'{$PSU_CRIT_STATUS}','6'),(557,10231,'{$CPU_UTIL_MAX}','90'),(558,10231,'{$MEMORY_UTIL_MAX}','90'),(559,10231,'{$TEMP_CRIT}','60'),(560,10231,'{$TEMP_WARN}','50'),(561,10231,'{$TEMP_CRIT_LOW}','5'),(572,10233,'{$TEMP_CRIT:\"CPU\"}','75'),(573,10233,'{$TEMP_WARN:\"CPU\"}','70'),(574,10233,'{$CPU_UTIL_MAX}','90'),(575,10233,'{$MEMORY_UTIL_MAX}','90'),(576,10233,'{$TEMP_CRIT}','60'),(577,10233,'{$TEMP_WARN}','50'),(578,10233,'{$TEMP_CRIT_LOW}','5'),(579,10233,'{$STORAGE_UTIL_CRIT}','90'),(580,10233,'{$STORAGE_UTIL_WARN}','80'),(581,10234,'{$TEMP_WARN_STATUS}','2'),(582,10234,'{$TEMP_CRIT_STATUS}','3'),(583,10234,'{$PSU_CRIT_STATUS:\"failed\"}','2'),(584,10234,'{$FAN_CRIT_STATUS:\"failed\"}','2'),(585,10234,'{$CPU_UTIL_MAX}','90'),(586,10234,'{$MEMORY_UTIL_MAX}','90'),(587,10234,'{$TEMP_CRIT}','60'),(588,10234,'{$TEMP_WARN}','50'),(589,10234,'{$TEMP_CRIT_LOW}','5'),(592,10235,'{$TEMP_CRIT}','75'),(593,10235,'{$TEMP_WARN}','65'),(594,10235,'{$PSU_CRIT_STATUS}','1'),(595,10235,'{$FAN_CRIT_STATUS}','1'),(596,10235,'{$CPU_UTIL_MAX}','90'),(597,10235,'{$MEMORY_UTIL_MAX}','90'),(601,10236,'{$CPU_UTIL_MAX}','90'),(602,10236,'{$MEMORY_UTIL_MAX}','90'),(603,10237,'{$CPU_UTIL_MAX}','90'),(604,10237,'{$MEMORY_UTIL_MAX}','90'),(619,10250,'{$FAN_CRIT_STATUS:\"bad\"}','2'),(620,10250,'{$PSU_CRIT_STATUS:\"bad\"}','2'),(621,10250,'{$TEMP_WARN_STATUS}','3'),(622,10250,'{$TEMP_CRIT_STATUS}','2'),(623,10250,'{$CPU_UTIL_MAX}','90'),(624,10250,'{$MEMORY_UTIL_MAX}','90'),(625,10250,'{$TEMP_CRIT}','60'),(626,10250,'{$TEMP_WARN}','50'),(627,10250,'{$TEMP_CRIT_LOW}','5'),(630,10251,'{$PSU_CRIT_STATUS}','2'),(631,10251,'{$FAN_CRIT_STATUS}','3'),(632,10251,'{$TEMP_WARN_STATUS}','3'),(635,10251,'{$TEMP_CRIT}','60'),(636,10251,'{$TEMP_WARN}','50'),(637,10251,'{$TEMP_CRIT_LOW}','5'),(647,10230,'{$PSU_WARN_STATUS}','4'),(648,10217,'{$PSU_CRIT_STATUS:\"critical\"}','3'),(649,10217,'{$PSU_CRIT_STATUS:\"shutdown\"}','4'),(650,10217,'{$PSU_WARN_STATUS:\"warning\"}','2'),(651,10217,'{$PSU_WARN_STATUS:\"notFunctioning\"}','6'),(652,10217,'{$FAN_CRIT_STATUS:\"critical\"}','3'),(653,10217,'{$FAN_CRIT_STATUS:\"shutdown\"}','4'),(654,10217,'{$FAN_WARN_STATUS:\"warning\"}','2'),(655,10217,'{$FAN_WARN_STATUS:\"notFunctioning\"}','6'),(656,10250,'{$FAN_WARN_STATUS:\"warning\"}','3'),(657,10250,'{$PSU_WARN_STATUS:\"warning\"}','3'),(658,10254,'{$CPU_UTIL_MAX}','90'),(659,10254,'{$FAN_CRIT_STATUS}','3'),(660,10254,'{$MEMORY_UTIL_MAX}','90'),(661,10254,'{$PSU_CRIT_STATUS}','2'),(662,10254,'{$STORAGE_UTIL_CRIT}','95'),(663,10254,'{$STORAGE_UTIL_WARN}','90'),(664,10254,'{$TEMP_CRIT_LOW}','5'),(665,10254,'{$TEMP_CRIT}','60'),(666,10254,'{$TEMP_WARN_STATUS}','3'),(667,10254,'{$TEMP_WARN}','50'),(668,10209,'{$CPU_UTIL_MAX}','90'),(669,10209,'{$MEMORY_UTIL_MAX}','90'),(670,10212,'{$MEMORY_UTIL_MAX}','90'),(671,10213,'{$CPU_UTIL_MAX}','90'),(672,10252,'{$CPU_UTIL_MAX}','90'),(673,10215,'{$CPU_UTIL_MAX}','90'),(674,10217,'{$TEMP_CRIT_LOW}','5'),(675,10217,'{$TEMP_CRIT}','60'),(676,10217,'{$TEMP_WARN}','50'),(677,10255,'{$DISK_ARRAY_CACHE_BATTERY_CRIT_STATUS}','3'),(678,10255,'{$DISK_ARRAY_CACHE_BATTERY_OK_STATUS}','2'),(679,10255,'{$DISK_ARRAY_CACHE_BATTERY_WARN_STATUS}','4'),(680,10255,'{$DISK_ARRAY_CRIT_STATUS:\"critical\"}','5'),(681,10255,'{$DISK_ARRAY_FAIL_STATUS:\"nonRecoverable\"}','6'),(682,10255,'{$DISK_ARRAY_WARN_STATUS:\"nonCritical\"}','4'),(683,10255,'{$DISK_FAIL_STATUS:\"critical\"}','5'),(684,10255,'{$DISK_FAIL_STATUS:\"nonRecoverable\"}','6'),(685,10255,'{$DISK_SMART_FAIL_STATUS}','1'),(686,10255,'{$DISK_WARN_STATUS:\"nonCritical\"}','4'),(687,10255,'{$FAN_CRIT_STATUS:\"criticalLower\"}','8'),(688,10255,'{$FAN_CRIT_STATUS:\"criticalUpper\"}','5'),(689,10255,'{$FAN_CRIT_STATUS:\"failed\"}','10'),(690,10255,'{$FAN_CRIT_STATUS:\"nonRecoverableLower\"}','9'),(691,10255,'{$FAN_CRIT_STATUS:\"nonRecoverableUpper\"}','6'),(692,10255,'{$FAN_WARN_STATUS:\"nonCriticalLower\"}','7'),(693,10255,'{$FAN_WARN_STATUS:\"nonCriticalUpper\"}','4'),(694,10255,'{$HEALTH_CRIT_STATUS}','5'),(695,10255,'{$HEALTH_DISASTER_STATUS}','6'),(696,10255,'{$HEALTH_WARN_STATUS}','4'),(697,10255,'{$PSU_CRIT_STATUS:\"critical\"}','5'),(698,10255,'{$PSU_CRIT_STATUS:\"nonRecoverable\"}','6'),(699,10255,'{$PSU_WARN_STATUS:\"nonCritical\"}','4'),(700,10255,'{$TEMP_CRIT:\"Ambient\"}','35'),(701,10255,'{$TEMP_CRIT:\"CPU\"}','75'),(702,10255,'{$TEMP_CRIT_LOW}','5'),(703,10255,'{$TEMP_CRIT_STATUS}','5'),(704,10255,'{$TEMP_CRIT}','60'),(705,10255,'{$TEMP_DISASTER_STATUS}','6'),(706,10255,'{$TEMP_WARN:\"Ambient\"}','30'),(707,10255,'{$TEMP_WARN:\"CPU\"}','70'),(708,10255,'{$TEMP_WARN_STATUS}','4'),(709,10255,'{$TEMP_WARN}','50'),(710,10255,'{$VDISK_CRIT_STATUS:\"failed\"}','3'),(711,10255,'{$VDISK_WARN_STATUS:\"degraded\"}','4'),(712,10256,'{$DISK_ARRAY_CACHE_BATTERY_CRIT_STATUS:\"capacitorFailed\"}','7'),(713,10256,'{$DISK_ARRAY_CACHE_BATTERY_CRIT_STATUS:\"failed\"}','4'),(714,10256,'{$DISK_ARRAY_CACHE_BATTERY_WARN_STATUS:\"degraded\"}','5'),(715,10256,'{$DISK_ARRAY_CACHE_BATTERY_WARN_STATUS:\"notPresent\"}','6'),(716,10256,'{$DISK_ARRAY_CACHE_CRIT_STATUS:\"cacheModCriticalFailure\"}','8'),(717,10256,'{$DISK_ARRAY_CACHE_OK_STATUS:\"enabled\"}','3'),(718,10256,'{$DISK_ARRAY_CACHE_WARN_STATUS:\"cacheModDegradedFailsafeSpeed\"}','7'),(719,10256,'{$DISK_ARRAY_CACHE_WARN_STATUS:\"cacheModFlashMemNotAttached\"}','6'),(720,10256,'{$DISK_ARRAY_CACHE_WARN_STATUS:\"cacheReadCacheNotMapped\"}','9'),(721,10256,'{$DISK_ARRAY_CACHE_WARN_STATUS:\"invalid\"}','2'),(722,10256,'{$DISK_ARRAY_CRIT_STATUS}','4'),(723,10256,'{$DISK_ARRAY_WARN_STATUS}','3'),(724,10256,'{$DISK_FAIL_STATUS}','3'),(725,10256,'{$DISK_SMART_FAIL_STATUS:\"replaceDrive\"}','3'),(726,10256,'{$DISK_SMART_FAIL_STATUS:\"replaceDriveSSDWearOut\"}','4'),(727,10256,'{$DISK_WARN_STATUS}','4'),(728,10256,'{$FAN_CRIT_STATUS}','4'),(729,10256,'{$FAN_WARN_STATUS}','3'),(730,10256,'{$HEALTH_CRIT_STATUS}','4'),(731,10256,'{$HEALTH_WARN_STATUS}','3'),(732,10256,'{$PSU_CRIT_STATUS}','4'),(733,10256,'{$PSU_WARN_STATUS}','3'),(734,10256,'{$TEMP_CRIT:\"Ambient\"}','35'),(735,10256,'{$TEMP_CRIT_LOW}','5'),(736,10256,'{$TEMP_CRIT}','60'),(737,10256,'{$TEMP_WARN:\"Ambient\"}','30'),(738,10256,'{$TEMP_WARN}','50'),(739,10256,'{$VDISK_CRIT_STATUS}','3'),(740,10256,'{$VDISK_OK_STATUS}','2'),(741,10257,'{$DISK_OK_STATUS}','Normal'),(742,10257,'{$FAN_OK_STATUS}','Normal'),(743,10257,'{$HEALTH_CRIT_STATUS}','2'),(744,10257,'{$HEALTH_DISASTER_STATUS}','0'),(745,10257,'{$HEALTH_WARN_STATUS}','4'),(746,10257,'{$PSU_OK_STATUS}','Normal'),(747,10257,'{$TEMP_CRIT:\"Ambient\"}','35'),(748,10257,'{$TEMP_CRIT_LOW}','5'),(749,10257,'{$TEMP_CRIT}','60'),(750,10257,'{$TEMP_WARN:\"Ambient\"}','30'),(751,10257,'{$TEMP_WARN}','50'),(752,10258,'{$DISK_OK_STATUS}','Normal'),(753,10258,'{$FAN_OK_STATUS}','Normal'),(754,10258,'{$HEALTH_CRIT_STATUS}','2'),(755,10258,'{$HEALTH_DISASTER_STATUS}','0'),(756,10258,'{$HEALTH_WARN_STATUS}','4'),(757,10258,'{$PSU_OK_STATUS}','Normal'),(758,10258,'{$TEMP_CRIT:\"Ambient\"}','35'),(759,10258,'{$TEMP_CRIT_LOW}','5'),(760,10258,'{$TEMP_CRIT}','60'),(761,10258,'{$TEMP_WARN:\"Ambient\"}','30'),(762,10258,'{$TEMP_WARN}','50'),(763,10259,'{$TEMP_CRIT_LOW}','5'),(764,10259,'{$TEMP_CRIT}','60'),(765,10259,'{$TEMP_WARN}','50'),(766,10260,'{$PROTOCOL_HANDLER_AJP}','ajp-nio-8009'),(767,10260,'{$PROTOCOL_HANDLER_HTTP}','http-nio-8080'),(768,10260,'{$PROTOCOL_HANDLER_HTTPS}','https-openssl-nio-8443'),(769,10261,'{$ADDRESS}',''),(770,10261,'{$PORT}',''),(771,10262,'{$ADDRESS}',''),(772,10262,'{$PORT}',''),(773,10175,'{$VMWARE_INTERVAL}','1m'),(774,10175,'{$VMWARE_INTERVAL:conf}','1h'),(775,10175,'{$VMWARE_PERF_INTERVAL}','1m'),(776,10175,'{$VMWARE_PERF_INTERVAL:datastore}','5m'),(777,10174,'{$VMWARE_INTERVAL}','1m'),(778,10174,'{$VMWARE_INTERVAL:conf}','1h'),(779,10174,'{$VMWARE_PERF_INTERVAL}','1m'),(780,10173,'{$VMWARE_PERF_INTERVAL}','1m'),(781,10173,'{$VMWARE_PERF_INTERVAL:datastore}','5m');
/*!40000 ALTER TABLE `hostmacro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts`
--

DROP TABLE IF EXISTS `hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts` (
  `hostid` bigint(20) unsigned NOT NULL,
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `disable_until` int(11) NOT NULL DEFAULT '0',
  `error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `available` int(11) NOT NULL DEFAULT '0',
  `errors_from` int(11) NOT NULL DEFAULT '0',
  `lastaccess` int(11) NOT NULL DEFAULT '0',
  `ipmi_authtype` int(11) NOT NULL DEFAULT '-1',
  `ipmi_privilege` int(11) NOT NULL DEFAULT '2',
  `ipmi_username` varchar(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ipmi_password` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ipmi_disable_until` int(11) NOT NULL DEFAULT '0',
  `ipmi_available` int(11) NOT NULL DEFAULT '0',
  `snmp_disable_until` int(11) NOT NULL DEFAULT '0',
  `snmp_available` int(11) NOT NULL DEFAULT '0',
  `maintenanceid` bigint(20) unsigned DEFAULT NULL,
  `maintenance_status` int(11) NOT NULL DEFAULT '0',
  `maintenance_type` int(11) NOT NULL DEFAULT '0',
  `maintenance_from` int(11) NOT NULL DEFAULT '0',
  `ipmi_errors_from` int(11) NOT NULL DEFAULT '0',
  `snmp_errors_from` int(11) NOT NULL DEFAULT '0',
  `ipmi_error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmp_error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `jmx_disable_until` int(11) NOT NULL DEFAULT '0',
  `jmx_available` int(11) NOT NULL DEFAULT '0',
  `jmx_errors_from` int(11) NOT NULL DEFAULT '0',
  `jmx_error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `flags` int(11) NOT NULL DEFAULT '0',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `description` text COLLATE utf8_bin NOT NULL,
  `tls_connect` int(11) NOT NULL DEFAULT '1',
  `tls_accept` int(11) NOT NULL DEFAULT '1',
  `tls_issuer` varchar(1024) COLLATE utf8_bin NOT NULL DEFAULT '',
  `tls_subject` varchar(1024) COLLATE utf8_bin NOT NULL DEFAULT '',
  `tls_psk_identity` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `tls_psk` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `proxy_address` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `auto_compress` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`hostid`),
  KEY `hosts_1` (`host`),
  KEY `hosts_2` (`status`),
  KEY `hosts_3` (`proxy_hostid`),
  KEY `hosts_4` (`name`),
  KEY `hosts_5` (`maintenanceid`),
  KEY `c_hosts_3` (`templateid`),
  CONSTRAINT `c_hosts_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_hosts_2` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`),
  CONSTRAINT `c_hosts_3` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts`
--

LOCK TABLES `hosts` WRITE;
/*!40000 ALTER TABLE `hosts` DISABLE KEYS */;
INSERT INTO `hosts` VALUES (10001,NULL,'Template OS Linux',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Linux',0,NULL,'',1,1,'','','','','',1),(10047,NULL,'Template App Zabbix Server',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Zabbix Server',0,NULL,'',1,1,'','','','','',1),(10048,NULL,'Template App Zabbix Proxy',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Zabbix Proxy',0,NULL,'',1,1,'','','','','',1),(10050,NULL,'Template App Zabbix Agent',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Zabbix Agent',0,NULL,'',1,1,'','','','','',1),(10074,NULL,'Template OS OpenBSD',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS OpenBSD',0,NULL,'',1,1,'','','','','',1),(10075,NULL,'Template OS FreeBSD',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS FreeBSD',0,NULL,'',1,1,'','','','','',1),(10076,NULL,'Template OS AIX',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS AIX',0,NULL,'',1,1,'','','','','',1),(10077,NULL,'Template OS HP-UX',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS HP-UX',0,NULL,'',1,1,'','','','','',1),(10078,NULL,'Template OS Solaris',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Solaris',0,NULL,'',1,1,'','','','','',1),(10079,NULL,'Template OS Mac OS X',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Mac OS X',0,NULL,'',1,1,'','','','','',1),(10081,NULL,'Template OS Windows',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Windows',0,NULL,'',1,1,'','','','','',1),(10084,NULL,'Zabbix server',0,0,'',1,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Zabbix server',0,NULL,'',1,1,'','','','','',1),(10093,NULL,'Template App FTP Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App FTP Service',0,NULL,'',1,1,'','','','','',1),(10094,NULL,'Template App HTTP Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App HTTP Service',0,NULL,'',1,1,'','','','','',1),(10095,NULL,'Template App HTTPS Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App HTTPS Service',0,NULL,'',1,1,'','','','','',1),(10096,NULL,'Template App IMAP Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App IMAP Service',0,NULL,'',1,1,'','','','','',1),(10097,NULL,'Template App LDAP Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App LDAP Service',0,NULL,'',1,1,'','','','','',1),(10098,NULL,'Template App NNTP Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App NNTP Service',0,NULL,'',1,1,'','','','','',1),(10099,NULL,'Template App NTP Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App NTP Service',0,NULL,'',1,1,'','','','','',1),(10100,NULL,'Template App POP Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App POP Service',0,NULL,'',1,1,'','','','','',1),(10101,NULL,'Template App SMTP Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App SMTP Service',0,NULL,'',1,1,'','','','','',1),(10102,NULL,'Template App SSH Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App SSH Service',0,NULL,'',1,1,'','','','','',1),(10103,NULL,'Template App Telnet Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Telnet Service',0,NULL,'',1,1,'','','','','',1),(10169,NULL,'Template App Generic Java JMX',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Generic Java JMX',0,NULL,'',1,1,'','','','','',1),(10170,NULL,'Template DB MySQL',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template DB MySQL',0,NULL,'',1,1,'','','','','',1),(10171,NULL,'Template Server Intel SR1530 IPMI',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Server Intel SR1530 IPMI',0,NULL,'',1,1,'','','','','',1),(10172,NULL,'Template Server Intel SR1630 IPMI',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Server Intel SR1630 IPMI',0,NULL,'',1,1,'','','','','',1),(10173,NULL,'Template VM VMware',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template VM VMware',0,NULL,'',1,1,'','','','','',1),(10174,NULL,'Template VM VMware Guest',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template VM VMware Guest',0,NULL,'',1,1,'','','','','',1),(10175,NULL,'Template VM VMware Hypervisor',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template VM VMware Hypervisor',0,NULL,'',1,1,'','','','','',1),(10176,NULL,'{#HV.UUID}',0,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','{#HV.NAME}',2,NULL,'',1,1,'','','','','',1),(10177,NULL,'{#VM.UUID}',0,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','{#VM.NAME}',2,NULL,'',1,1,'','','','','',1),(10182,NULL,'Template Module EtherLike-MIB SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module EtherLike-MIB SNMPv1',0,NULL,'Template EtherLike-MIB (duplex control only) version: 0.15\r\nMIBs used:\r\nEtherLike-MIB',1,1,'','','','','',1),(10183,NULL,'Template Module EtherLike-MIB SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module EtherLike-MIB SNMPv2',0,NULL,'Template EtherLike-MIB (duplex control only) version: 0.15\r\nMIBs used:\r\nEtherLike-MIB',1,1,'','','','','',1),(10184,NULL,'Template Module HOST-RESOURCES-MIB SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module HOST-RESOURCES-MIB SNMPv1',0,NULL,'HOST-RESOURCES-MIB: CPU, Memory and Storage version: 0.15\r\nMIBs used:\r\nHOST-RESOURCES-MIB',1,1,'','','','','',1),(10185,NULL,'Template Module HOST-RESOURCES-MIB SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module HOST-RESOURCES-MIB SNMPv2',0,NULL,'HOST-RESOURCES-MIB: CPU, Memory and Storage version: 0.15\r\nMIBs used:\r\nHOST-RESOURCES-MIB',1,1,'','','','','',1),(10186,NULL,'Template Module ICMP Ping',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module ICMP Ping',0,NULL,'Template Module ICMP Ping version: 0.15',1,1,'','','','','',1),(10187,NULL,'Template Module Interfaces Simple SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Interfaces Simple SNMPv1',0,NULL,'Template Interfaces Simple (no ifXTable) version: 0.15\r\nMIBs used:\r\nIF-MIB',1,1,'','','','','',1),(10188,NULL,'Template Module Interfaces Simple SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Interfaces Simple SNMPv2',0,NULL,'Template Interfaces Simple (no ifXTable) version: 0.15\r\nMIBs used:\r\nIF-MIB',1,1,'','','','','',1),(10189,NULL,'Template Module Interfaces SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Interfaces SNMPv1',0,NULL,'Template Interfaces version: 0.15\r\nMIBs used:\r\nIF-MIB',1,1,'','','','','',1),(10190,NULL,'Template Module Interfaces SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Interfaces SNMPv2',0,NULL,'Template Interfaces version: 0.15\r\nMIBs used:\r\nIF-MIB',1,1,'','','','','',1),(10192,NULL,'Template Module Interfaces Windows SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Interfaces Windows SNMPv2',0,NULL,'Template Interfaces Windows version: 0.15\r\nOverview: Special version of interfaces template that is required for Windows OS. Since MS doesn\'t support 64 bit counters but supports ifAlias and ifHighSpeed.\r\nMIBs used:\r\nIF-MIB',1,1,'','','','','',1),(10203,NULL,'Template Module Generic SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Generic SNMPv1',0,NULL,'Template Module Generic version: 0.15\r\nMIBs used:\r\nSNMPv2-MIB',1,1,'','','','','',1),(10204,NULL,'Template Module Generic SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Generic SNMPv2',0,NULL,'Template Module Generic version: 0.15\r\nMIBs used:\r\nSNMPv2-MIB',1,1,'','','','','',1),(10207,NULL,'Template Net Alcatel Timetra TiMOS SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Alcatel Timetra TiMOS SNMPv2',0,NULL,'Template Net Alcatel Timetra TiMOS version: 0.15\r\nMIBs used:\r\nTIMETRA-CHASSIS-MIB\r\nTIMETRA-SYSTEM-MIB\r\nSNMPv2-MIB',1,1,'','','','','',1),(10208,NULL,'Template Net Brocade FC SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Brocade FC SNMPv2',0,NULL,'Template Net Brocade FC version: 0.15\r\nOverview: https://community.brocade.com/dtscp75322/attachments/dtscp75322/fibre/25235/1/FOS_MIB_Reference_v740.pdf\r\nMIBs used:\r\nSW-MIB\r\nKnown Issues:\r\ndescription : no IF-MIB::ifAlias is available\r\nversion : v6.3.1c, v7.0.0c,  v7.4.1c\r\ndevice : all',1,1,'','','','','',1),(10209,NULL,'Template Module Brocade_Foundry Performance SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Brocade_Foundry Performance SNMPv2',0,NULL,'Template Module Brocade_Foundry Performance version: 0.15\r\nMIBs used:\r\nFOUNDRY-SN-AGENT-MIB',1,1,'','','','','',1),(10210,NULL,'Template Net Brocade_Foundry Nonstackable SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Brocade_Foundry Nonstackable SNMPv2',0,NULL,'Template Net Brocade_Foundry Nonstackable version: 0.15\r\nOverview: For devices(old Foundry devices, MLXe and so on) that doesn\'t support Stackable SNMP Tables: snChasFan2Table, snChasPwrSupply2Table,snAgentTemp2Table -\r\nFOUNDRY-SN-AGENT-MIB::snChasFanTable, snChasPwrSupplyTable,snAgentTempTable are used instead.\r\nFor example:\r\nThe objects in table snChasPwrSupply2Table is not supported on the NetIron and the FastIron SX devices.\r\nsnChasFan2Table is not supported on  on the NetIron devices.\r\nsnAgentTemp2Table is not supported on old versions of MLXe\r\nMIBs used:\r\nFOUNDRY-SN-AGENT-MIB',1,1,'','','','','',1),(10211,NULL,'Template Net Brocade_Foundry Stackable SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Brocade_Foundry Stackable SNMPv2',0,NULL,'Template Brocade_Foundry Stackable version: 0.15\r\nOverview: For devices(most of the IronWare Brocade devices) that support Stackable SNMP Tables in FOUNDRY-SN-AGENT-MIB: snChasFan2Table, snChasPwrSupply2Table,snAgentTemp2Table - so objects from all Stack members are provided.\r\nMIBs used:\r\nFOUNDRY-SN-AGENT-MIB\r\nFOUNDRY-SN-STACKING-MIB\r\nKnown Issues:\r\ndescription : Correct fan(returns fan status as \'other(1)\' and temperature (returns 0) for the non-master Switches are not available in SNMP\r\nversion : Version 08.0.40b and above\r\ndevice : ICX 7750 in stack',1,1,'','','','','',1),(10212,NULL,'Template Module Cisco CISCO-MEMORY-POOL-MIB SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Cisco CISCO-MEMORY-POOL-MIB SNMPv2',0,NULL,'Template Cisco CISCO-MEMORY-POOL-MIB version: 0.15\r\nMIBs used:\r\nCISCO-MEMORY-POOL-MIB',1,1,'','','','','',1),(10213,NULL,'Template Module Cisco CISCO-PROCESS-MIB SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Cisco CISCO-PROCESS-MIB SNMPv2',0,NULL,'Template Cisco CISCO-PROCESS-MIB version: 0.15\r\nMIBs used:\r\nCISCO-PROCESS-MIB',1,1,'','','','','',1),(10215,NULL,'Template Module Cisco OLD-CISCO-CPU-MIB SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Cisco OLD-CISCO-CPU-MIB SNMPv2',0,NULL,'Template Cisco OLD-CISCO-CPU-MIB version: 0.15\r\nMIBs used:\r\nOLD-CISCO-CPU-MIB',1,1,'','','','','',1),(10216,NULL,'Template Module Cisco Inventory SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Cisco Inventory SNMPv2',0,NULL,'Template Cisco Inventory version: 0.15\r\nMIBs used:\r\nENTITY-MIB\r\nSNMPv2-MIB',1,1,'','','','','',1),(10217,NULL,'Template Module Cisco CISCO-ENVMON-MIB SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Cisco CISCO-ENVMON-MIB SNMPv2',0,NULL,'Template Cisco CISCO-ENVMON-MIB version: 0.15\r\nMIBs used:\r\nCISCO-ENVMON-MIB',1,1,'','','','','',1),(10218,NULL,'Template Net Cisco IOS SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Cisco IOS SNMPv2',0,NULL,'Template Cisco IOS Software releases 12.2(3.5) or later version: 0.15\r\nKnown Issues:\r\ndescription : no if(in|out)(Errors|Discards) are available for vlan ifType\r\nversion : IOS for example: 12.1(22)EA11, 15.4(3)M2\r\ndevice : C2911, C7600',1,1,'','','','','',1),(10220,NULL,'Template Net Cisco IOS prior to 12.0_3_T SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Cisco IOS prior to 12.0_3_T SNMPv2',0,NULL,'Cisco IOS Software releases prior to 12.0(3)T version: 0.15',1,1,'','','','','',1),(10221,NULL,'Template Net Dell Force S-Series SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Dell Force S-Series SNMPv2',0,NULL,'Template Dell Force S-Series version: 0.15\r\nMIBs used:\r\nF10-S-SERIES-CHASSIS-MIB',1,1,'','','','','',1),(10222,NULL,'Template Net D-Link DES 7200 SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net D-Link DES 7200 SNMPv2',0,NULL,'Template D-Link DES 7200 version: 0.15\r\nMIBs used:\r\nMY-PROCESS-MIB\r\nSNMPv2-MIB\r\nMY-MEMORY-MIB\r\nENTITY-MIB\r\nMY-SYSTEM-MIB',1,1,'','','','','',1),(10223,NULL,'Template Net D-Link DES_DGS Switch SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net D-Link DES_DGS Switch SNMPv2',0,NULL,'Template D-Link DES_DGS Switch version: 0.15\r\nMIBs used:\r\nDLINK-AGENT-MIB\r\nSNMPv2-MIB\r\nENTITY-MIB\r\nEQUIPMENT-MIB\r\nKnown Issues:\r\ndescription : D-Link reports missing PSU as fail(4)\r\nversion : Firmware: 1.73R008,hardware revision: B1\r\ndevice : DGS-3420-26SC Gigabit Ethernet Switch',1,1,'','','','','',1),(10224,NULL,'Template Net Extreme EXOS SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Extreme EXOS SNMPv2',0,NULL,'Template Extreme EXOS version: 0.15\r\nMIBs used:\r\nEXTREME-SOFTWARE-MONITOR-MIB\r\nEXTREME-SYSTEM-MIB\r\nENTITY-MIB',1,1,'','','','','',1),(10225,NULL,'Template Net Network Generic Device SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Network Generic Device SNMPv1',0,NULL,'Template Net Network Generic Device version: 0.15\r\nOverview: Use this template if you can\'t find the template for specific vendor or device family.',1,1,'','','','','',1),(10226,NULL,'Template Net Network Generic Device SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Network Generic Device SNMPv2',0,NULL,'Template Net Network Generic Device version: 0.15\r\nOverview: Use this template if you can\'t find the template for specific vendor or device family.',1,1,'','','','','',1),(10227,NULL,'Template Net HP Comware HH3C SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net HP Comware HH3C SNMPv2',0,NULL,'Template Net HP Comware (HH3C) version: 0.15\r\nOverview: http://certifiedgeek.weebly.com/blog/hp-comware-snmp-mib-for-cpu-memory-and-temperature\r\nhttp://www.h3c.com.hk/products___solutions/technology/system_management/configuration_example/200912/656451_57_0.htm\r\nMIBs used:\r\nENTITY-MIB\r\nHH3C-ENTITY-EXT-MIB\r\nKnown Issues:\r\ndescription : No temperature sensors. All entities of them return 0 for HH3C-ENTITY-EXT-MIB::hh3cEntityExtTemperature\r\nversion : 1910-48 Switch Software Version 5.20.99, Release 1116 Copyright(c)2010-2016 Hewlett Packard Enterprise Development LP\r\ndevice : HP 1910-48',1,1,'','','','','',1),(10229,NULL,'Template Net Huawei VRP SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Huawei VRP SNMPv2',0,NULL,'Template Net Huawei VRP version: 0.15\r\nOverview: Reference: https://www.slideshare.net/Huanetwork/huawei-s5700-naming-conventions-and-port-numbering-conventions\r\nReference: http://support.huawei.com/enterprise/KnowledgebaseReadAction.action?contentId=KB1000090234\r\nMIBs used:\r\nHUAWEI-ENTITY-EXTENT-MIB\r\nENTITY-MIB',1,1,'','','','','',1),(10230,NULL,'Template Net Intel_Qlogic Infiniband SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Intel_Qlogic Infiniband SNMPv2',0,NULL,'Template Net Intel_Qlogic Infiniband version: 0.15\r\nMIBs used:\r\nICS-CHASSIS-MIB',1,1,'','','','','',1),(10231,NULL,'Template Net Juniper SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Juniper SNMPv2',0,NULL,'Template Net Juniper version: 0.15\r\nMIBs used:\r\nJUNIPER-ALARM-MIB\r\nJUNIPER-MIB\r\nSNMPv2-MIB',1,1,'','','','','',1),(10233,NULL,'Template Net Mikrotik SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Mikrotik SNMPv2',0,NULL,'Template Net Mikrotik version: 0.15\r\nMIBs used:\r\nHOST-RESOURCES-MIB\r\nMIKROTIK-MIB\r\nKnown Issues:\r\ndescription : Doesn\'t have ifHighSpeed filled. fixed in more recent versions\r\nversion : RotuerOS 6.28 or lower\r\ndevice : \r\ndescription : Doesn\'t have any temperature sensors\r\nversion : RotuerOS 6.38.5\r\ndevice : Mikrotik 941-2nD, Mikrotik 951G-2HnD',1,1,'','','','','',1),(10234,NULL,'Template Net Netgear Fastpath SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Netgear Fastpath SNMPv2',0,NULL,'Template Net Netgear Fastpath version: 0.15\r\nOverview: https://kb.netgear.com/24352/MIBs-for-Smart-switches\r\nMIBs used:\r\nFASTPATH-SWITCHING-MIB\r\nFASTPATH-BOXSERVICES-PRIVATE-MIB',1,1,'','','','','',1),(10235,NULL,'Template Net QTech QSW SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net QTech QSW SNMPv2',0,NULL,'Template Net QTech QSW version: 0.15\r\nMIBs used:\r\nQTECH-MIB\r\nENTITY-MIB',1,1,'','','','','',1),(10236,NULL,'Template Net TP-LINK SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net TP-LINK SNMPv2',0,NULL,'Template Net TP-LINK JetStream version: 0.15\r\nOverview: Link to MIBs: http://www.tp-linkru.com/download/T2600G-28TS.html#MIBs_Files\r\nSample device overview page: http://www.tp-linkru.com/products/details/cat-39_T2600G-28TS.html#overview\r\nemulation page(web): http://www.tp-linkru.com/resources/simulator/T2600G-28TS(UN)_1.0/Index.htm\r\nMIBs used:\r\nTPLINK-SYSINFO-MIB\r\nTPLINK-SYSMONITOR-MIB\r\nKnown Issues:\r\ndescription : default sysLocation, sysName and sysContact is not filled with proper data. Real hostname and location can be found only in private branch(TPLINK-SYSINFO-MIB). Please check whether this problem exists in the latest firware: http://www.tp-linkru.com/download/T2600G-28TS.html#Firmware\r\nversion : 2.0.0 Build 20170628 Rel.55184(Beta)\r\ndevice : T2600G-28TS 2.0\r\ndescription : The Serial number of the product(tpSysInfoSerialNum) is missing in HW versions prior to V2_170323\r\nversion : prior to version V2_170323\r\ndevice : T2600G-28TS 2.0',1,1,'','','','','',1),(10237,NULL,'Template Net Ubiquiti AirOS SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Ubiquiti AirOS SNMPv1',0,NULL,'Template Net Ubiquiti AirOS version: 0.15\r\nMIBs used:\r\nIEEE802dot11-MIB\r\nFROGFOOT-RESOURCES-MIB\r\nKnown Issues:\r\ndescription : UBNT unifi reports speed: like IF-MIB::ifSpeed.1 = Gauge32: 4294967295 for all interfaces\r\nversion : Firmware: BZ.ar7240.v3.7.51.6230.170322.1513\r\ndevice : UBNT UAP-LR\r\ndescription : UBNT AirMax(NanoStation, NanoBridge etc) reports ifSpeed: as 0 for VLAN and wireless(ath0) interfaces\r\nversion : Firmware: XW.ar934x.v5.6-beta4.22359.140521.1836\r\ndevice : NanoStation M5\r\ndescription : UBNT AirMax(NanoStation, NanoBridge etc) reports always return ifType: as ethernet(6) even for wifi,vlans and other types\r\nversion : Firmware: XW.ar934x.v5.6-beta4.22359.140521.1836\r\ndevice : NanoStation M5\r\ndescription : ifXTable is not provided in IF-MIB. So Interfaces Simple Template is used instead\r\nversion : all above\r\ndevice : NanoStation, UAP-LR',1,1,'','','','','',1),(10248,NULL,'Template OS Linux SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Linux SNMPv2',0,NULL,'Template OS Linux version: 0.15',1,1,'','','','','',1),(10249,NULL,'Template OS Windows SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Windows SNMPv2',0,NULL,'Template OS Windows version: 0.15\r\nKnown Issues:\r\ndescription : Doesn\'t support In/Out 64 bit counters even thoug1h IfxTable is present:\r\nCurrently, Windows gets it’s interface status from MIB-2. Since these 64bit SNMP counters (ifHCInOctets, ifHCOutOctets, etc.) are defined as an extension to IF-MIB, Microsoft has not implemented it.\r\nhttps://social.technet.microsoft.com/Forums/windowsserver/en-US/07b62ff0-94f6-40ca-a99d-d129c1b33d70/windows-2008-r2-snmp-64bit-counters-support?forum=winservergen\r\n\r\nversion : Win2008, Win2012R2\r\ndevice : \r\ndescription : Doesn\'t support ifXTable at all\r\nversion : WindowsXP\r\ndevice : \r\ndescription : EtherLike MIB is not supported\r\nversion : *\r\ndevice : *',1,1,'','','','','',1),(10250,NULL,'Template Net HP Enterprise Switch SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net HP Enterprise Switch SNMPv2',0,NULL,'Template Net HP Enterprise Switch version: 0.15\r\nMIBs used:\r\nSEMI-MIB\r\nNETSWITCH-MIB\r\nHP-ICF-CHASSIS\r\nENTITY-SENSORS-MIB\r\nENTITY-MIB\r\nSTATISTICS-MIB',1,1,'','','','','',1),(10251,NULL,'Template Net Mellanox SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Mellanox SNMPv2',0,NULL,'Template Net Mellanox version: 0.15\r\nMIBs used:\r\nENTITY-SENSORS-MIB\r\nENTITY-STATE-MIB\r\nENTITY-MIB',1,1,'','','','','',1),(10252,NULL,'Template Module Cisco CISCO-PROCESS-MIB IOS versions 12.0_3_T-12.2_3.5 SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Cisco CISCO-PROCESS-MIB IOS versions 12.0_3_T-12.2_3.5 SNMPv2',0,NULL,'Template Module Cisco CISCO-PROCESS-MIB IOS versions 12.0_3_T-12.2_3.5 version: 0.15\r\nMIBs used:\r\nCISCO-PROCESS-MIB',1,1,'','','','','',1),(10253,NULL,'Template Net Cisco IOS versions 12.0_3_T-12.2_3.5 SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Cisco IOS versions 12.0_3_T-12.2_3.5 SNMPv2',0,NULL,'Cisco IOS Software releases later to 12.0(3)T and prior to 12.2(3.5) version: 0.15',1,1,'','','','','',1),(10254,NULL,'Template Net Arista SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Arista SNMPv2',0,NULL,'Template Net Arista version: 0.15\r\nMIBs used:\r\nHOST-RESOURCES-MIB\r\nENTITY-SENSORS-MIB\r\nENTITY-STATE-MIB\r\nENTITY-MIB',1,1,'','','','','',1),(10255,NULL,'Template Server Dell iDRAC SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Server Dell iDRAC SNMPv2',0,NULL,'Template Server iDRAC version: 0.15\r\nOverview: for Dell servers with iDRAC controllers\r\nhttp://www.dell.com/support/manuals/us/en/19/dell-openmanage-server-administrator-v8.3/snmp_idrac8/idrac-mib?guid=guid-e686536d-bc8e-4e09-8e8b-de8eb052efee\r\nSupported systems: http://www.dell.com/support/manuals/us/en/04/dell-openmanage-server-administrator-v8.3/snmp_idrac8/supported-systems?guid=guid-f72b75ba-e686-4e8a-b8c5-ca11c7c21381\r\nMIBs used:\r\nIDRAC-MIB-SMIv2',1,1,'','','','','',1),(10256,NULL,'Template Server HP iLO SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Server HP iLO SNMPv2',0,NULL,'Template Server HP iLO version: 0.15\r\nOverview: for HP iLO adapters that support SNMP get. Or via operating system, using SNMP HP subagent\r\nMIBs used:\r\nCPQSINFO-MIB\r\nCPQHLTH-MIB\r\nCPQIDA-MIB',1,1,'','','','','',1),(10257,NULL,'Template Server IBM IMM SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Server IBM IMM SNMPv1',0,NULL,'Template Server IBM IMM version: 0.15\r\nOverview: for IMM2 and IMM1 IBM serverX hardware\r\nMIBs used:\r\nIMM-MIB\r\nKnown Issues:\r\ndescription : Some IMMs (IMM1) do not return disks\r\nversion : IMM1\r\ndevice : IBM x3250M3\r\ndescription : Some IMMs (IMM1) do not return fan status: fanHealthStatus\r\nversion : IMM1\r\ndevice : IBM x3250M3\r\ndescription : IMM1 servers (M2, M3 generations) sysObjectID is NET-SNMP-MIB::netSnmpAgentOIDs.10\r\nversion : IMM1\r\ndevice : IMM1 servers (M2,M3 generations)\r\ndescription : IMM1 servers (M2, M3 generations) only Ambient temperature sensor available\r\nversion : IMM1\r\ndevice : IMM1 servers (M2,M3 generations)',1,1,'','','','','',1),(10258,NULL,'Template Server IBM IMM SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Server IBM IMM SNMPv2',0,NULL,'Template Server IBM IMM version: 0.15\r\nOverview: for IMM2 and IMM1 IBM serverX hardware\r\nMIBs used:\r\nIMM-MIB\r\nKnown Issues:\r\ndescription : Some IMMs (IMM1) do not return disks\r\nversion : IMM1\r\ndevice : IBM x3250M3\r\ndescription : Some IMMs (IMM1) do not return fan status: fanHealthStatus\r\nversion : IMM1\r\ndevice : IBM x3250M3\r\ndescription : IMM1 servers (M2, M3 generations) sysObjectID is NET-SNMP-MIB::netSnmpAgentOIDs.10\r\nversion : IMM1\r\ndevice : IMM1 servers (M2,M3 generations)\r\ndescription : IMM1 servers (M2, M3 generations) only Ambient temperature sensor available\r\nversion : IMM1\r\ndevice : IMM1 servers (M2,M3 generations)',1,1,'','','','','',1),(10259,NULL,'Template Server Supermicro Aten SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Server Supermicro Aten SNMPv2',0,NULL,'Template Server Supermicro Aten version: 0.15\r\nOverview: for BMC ATEN IPMI controllers of Supermicro servers\r\nhttps://www.supermicro.com/solutions/IPMI.cfm\r\nMIBs used:\r\nATEN-IPMI-MIB',1,1,'','','','','',1),(10260,NULL,'Template App Apache Tomcat JMX',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Apache Tomcat JMX',0,NULL,'',1,1,'','','','','',1),(10261,NULL,'Template App Remote Zabbix server',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Remote Zabbix server',0,NULL,'',1,1,'','','','','',1),(10262,NULL,'Template App Remote Zabbix proxy',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Remote Zabbix proxy',0,NULL,'',1,1,'','','','','',1);
/*!40000 ALTER TABLE `hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts_groups`
--

DROP TABLE IF EXISTS `hosts_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts_groups` (
  `hostgroupid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`hostgroupid`),
  UNIQUE KEY `hosts_groups_1` (`hostid`,`groupid`),
  KEY `hosts_groups_2` (`groupid`),
  CONSTRAINT `c_hosts_groups_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_hosts_groups_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts_groups`
--

LOCK TABLES `hosts_groups` WRITE;
/*!40000 ALTER TABLE `hosts_groups` DISABLE KEYS */;
INSERT INTO `hosts_groups` VALUES (194,10001,10),(189,10047,12),(188,10048,12),(187,10050,8),(196,10074,10),(192,10075,10),(191,10076,10),(193,10077,10),(197,10078,10),(195,10079,10),(198,10081,10),(92,10084,4),(175,10093,8),(178,10094,8),(177,10095,8),(179,10096,8),(180,10097,8),(181,10098,8),(182,10099,8),(183,10100,8),(184,10101,8),(185,10102,8),(186,10103,8),(176,10169,12),(190,10170,13),(199,10171,11),(200,10172,11),(201,10173,14),(202,10174,14),(203,10175,14),(208,10182,8),(209,10183,8),(210,10184,8),(211,10185,8),(212,10186,8),(213,10187,8),(214,10188,8),(215,10189,8),(216,10190,8),(218,10192,8),(229,10203,8),(230,10204,8),(233,10207,9),(234,10208,9),(235,10209,8),(236,10210,9),(237,10211,9),(238,10212,8),(239,10213,8),(241,10215,8),(242,10216,8),(243,10217,8),(244,10218,9),(246,10220,9),(247,10221,9),(248,10222,9),(249,10223,9),(250,10224,9),(251,10225,9),(252,10226,9),(253,10227,9),(255,10229,9),(256,10230,9),(257,10231,9),(259,10233,9),(260,10234,9),(261,10235,9),(262,10236,9),(263,10237,9),(274,10248,10),(275,10249,10),(276,10250,9),(277,10251,9),(278,10252,8),(279,10253,9),(280,10254,9),(281,10255,11),(282,10256,11),(283,10257,11),(284,10258,11),(285,10259,11),(286,10260,12),(287,10261,12),(288,10262,12);
/*!40000 ALTER TABLE `hosts_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts_templates`
--

DROP TABLE IF EXISTS `hosts_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts_templates` (
  `hosttemplateid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`hosttemplateid`),
  UNIQUE KEY `hosts_templates_1` (`hostid`,`templateid`),
  KEY `hosts_templates_2` (`templateid`),
  CONSTRAINT `c_hosts_templates_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_hosts_templates_2` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts_templates`
--

LOCK TABLES `hosts_templates` WRITE;
/*!40000 ALTER TABLE `hosts_templates` DISABLE KEYS */;
INSERT INTO `hosts_templates` VALUES (4,10001,10050),(31,10074,10050),(32,10075,10050),(33,10076,10050),(34,10077,10050),(35,10078,10050),(36,10079,10050),(37,10081,10050),(39,10084,10001),(38,10084,10047),(131,10176,10175),(132,10177,10174),(133,10203,10186),(134,10204,10186),(136,10207,10183),(135,10207,10190),(137,10207,10204),(138,10208,10190),(139,10208,10204),(141,10210,10190),(142,10210,10204),(140,10210,10209),(144,10211,10190),(145,10211,10204),(143,10211,10209),(151,10218,10183),(150,10218,10190),(152,10218,10204),(149,10218,10212),(148,10218,10213),(146,10218,10216),(147,10218,10217),(163,10220,10204),(161,10220,10212),(162,10220,10215),(159,10220,10216),(160,10220,10217),(165,10221,10183),(164,10221,10190),(166,10221,10204),(167,10222,10190),(168,10222,10204),(170,10223,10183),(169,10223,10190),(171,10223,10204),(173,10224,10183),(172,10224,10190),(174,10224,10204),(176,10225,10182),(175,10225,10187),(177,10225,10203),(179,10226,10183),(178,10226,10188),(180,10226,10204),(182,10227,10183),(181,10227,10190),(183,10227,10204),(189,10229,10183),(188,10229,10190),(190,10229,10204),(191,10230,10190),(192,10230,10204),(194,10231,10183),(193,10231,10190),(195,10231,10204),(200,10233,10190),(201,10233,10204),(202,10234,10190),(203,10234,10204),(205,10235,10183),(204,10235,10190),(206,10235,10204),(207,10236,10188),(208,10236,10204),(209,10237,10187),(210,10237,10203),(213,10248,10183),(211,10248,10185),(212,10248,10190),(214,10248,10204),(215,10249,10185),(216,10249,10192),(217,10249,10204),(219,10250,10183),(218,10250,10190),(220,10250,10204),(221,10251,10185),(222,10251,10190),(223,10251,10204),(228,10253,10190),(229,10253,10204),(226,10253,10212),(224,10253,10216),(225,10253,10217),(227,10253,10252),(230,10254,10183),(232,10254,10190),(231,10254,10204),(233,10255,10204),(234,10256,10204),(235,10257,10203),(236,10258,10204),(237,10259,10204);
/*!40000 ALTER TABLE `hosts_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `housekeeper`
--

DROP TABLE IF EXISTS `housekeeper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `housekeeper` (
  `housekeeperid` bigint(20) unsigned NOT NULL,
  `tablename` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`housekeeperid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `housekeeper`
--

LOCK TABLES `housekeeper` WRITE;
/*!40000 ALTER TABLE `housekeeper` DISABLE KEYS */;
/*!40000 ALTER TABLE `housekeeper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hstgrp`
--

DROP TABLE IF EXISTS `hstgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hstgrp` (
  `groupid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `internal` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupid`),
  KEY `hstgrp_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hstgrp`
--

LOCK TABLES `hstgrp` WRITE;
/*!40000 ALTER TABLE `hstgrp` DISABLE KEYS */;
INSERT INTO `hstgrp` VALUES (1,'Templates',0,0),(2,'Linux servers',0,0),(4,'Zabbix servers',0,0),(5,'Discovered hosts',1,0),(6,'Virtual machines',0,0),(7,'Hypervisors',0,0),(8,'Templates/Modules',0,0),(9,'Templates/Network devices',0,0),(10,'Templates/Operating systems',0,0),(11,'Templates/Server hardware',0,0),(12,'Templates/Applications',0,0),(13,'Templates/Databases',0,0),(14,'Templates/Virtualization',0,0);
/*!40000 ALTER TABLE `hstgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httpstep`
--

DROP TABLE IF EXISTS `httpstep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httpstep` (
  `httpstepid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `no` int(11) NOT NULL DEFAULT '0',
  `url` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timeout` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '15s',
  `posts` text COLLATE utf8_bin NOT NULL,
  `required` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `status_codes` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `follow_redirects` int(11) NOT NULL DEFAULT '1',
  `retrieve_mode` int(11) NOT NULL DEFAULT '0',
  `post_type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`httpstepid`),
  KEY `httpstep_1` (`httptestid`),
  CONSTRAINT `c_httpstep_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httpstep`
--

LOCK TABLES `httpstep` WRITE;
/*!40000 ALTER TABLE `httpstep` DISABLE KEYS */;
/*!40000 ALTER TABLE `httpstep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httpstep_field`
--

DROP TABLE IF EXISTS `httpstep_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httpstep_field` (
  `httpstep_fieldid` bigint(20) unsigned NOT NULL,
  `httpstepid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`httpstep_fieldid`),
  KEY `httpstep_field_1` (`httpstepid`),
  CONSTRAINT `c_httpstep_field_1` FOREIGN KEY (`httpstepid`) REFERENCES `httpstep` (`httpstepid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httpstep_field`
--

LOCK TABLES `httpstep_field` WRITE;
/*!40000 ALTER TABLE `httpstep_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `httpstep_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httpstepitem`
--

DROP TABLE IF EXISTS `httpstepitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httpstepitem` (
  `httpstepitemid` bigint(20) unsigned NOT NULL,
  `httpstepid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`httpstepitemid`),
  UNIQUE KEY `httpstepitem_1` (`httpstepid`,`itemid`),
  KEY `httpstepitem_2` (`itemid`),
  CONSTRAINT `c_httpstepitem_1` FOREIGN KEY (`httpstepid`) REFERENCES `httpstep` (`httpstepid`) ON DELETE CASCADE,
  CONSTRAINT `c_httpstepitem_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httpstepitem`
--

LOCK TABLES `httpstepitem` WRITE;
/*!40000 ALTER TABLE `httpstepitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `httpstepitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httptest`
--

DROP TABLE IF EXISTS `httptest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httptest` (
  `httptestid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `applicationid` bigint(20) unsigned DEFAULT NULL,
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `delay` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '1m',
  `status` int(11) NOT NULL DEFAULT '0',
  `agent` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT 'Zabbix',
  `authentication` int(11) NOT NULL DEFAULT '0',
  `http_user` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `http_password` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `hostid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `http_proxy` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `retries` int(11) NOT NULL DEFAULT '1',
  `ssl_cert_file` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ssl_key_file` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ssl_key_password` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `verify_peer` int(11) NOT NULL DEFAULT '0',
  `verify_host` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`httptestid`),
  UNIQUE KEY `httptest_2` (`hostid`,`name`),
  KEY `httptest_1` (`applicationid`),
  KEY `httptest_3` (`status`),
  KEY `httptest_4` (`templateid`),
  CONSTRAINT `c_httptest_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`),
  CONSTRAINT `c_httptest_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_httptest_3` FOREIGN KEY (`templateid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptest`
--

LOCK TABLES `httptest` WRITE;
/*!40000 ALTER TABLE `httptest` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httptest_field`
--

DROP TABLE IF EXISTS `httptest_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httptest_field` (
  `httptest_fieldid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`httptest_fieldid`),
  KEY `httptest_field_1` (`httptestid`),
  CONSTRAINT `c_httptest_field_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptest_field`
--

LOCK TABLES `httptest_field` WRITE;
/*!40000 ALTER TABLE `httptest_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptest_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httptestitem`
--

DROP TABLE IF EXISTS `httptestitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httptestitem` (
  `httptestitemid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`httptestitemid`),
  UNIQUE KEY `httptestitem_1` (`httptestid`,`itemid`),
  KEY `httptestitem_2` (`itemid`),
  CONSTRAINT `c_httptestitem_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE,
  CONSTRAINT `c_httptestitem_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptestitem`
--

LOCK TABLES `httptestitem` WRITE;
/*!40000 ALTER TABLE `httptestitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptestitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icon_map`
--

DROP TABLE IF EXISTS `icon_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icon_map` (
  `iconmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `default_iconid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`iconmapid`),
  UNIQUE KEY `icon_map_1` (`name`),
  KEY `icon_map_2` (`default_iconid`),
  CONSTRAINT `c_icon_map_1` FOREIGN KEY (`default_iconid`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icon_map`
--

LOCK TABLES `icon_map` WRITE;
/*!40000 ALTER TABLE `icon_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `icon_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icon_mapping`
--

DROP TABLE IF EXISTS `icon_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icon_mapping` (
  `iconmappingid` bigint(20) unsigned NOT NULL,
  `iconmapid` bigint(20) unsigned NOT NULL,
  `iconid` bigint(20) unsigned NOT NULL,
  `inventory_link` int(11) NOT NULL DEFAULT '0',
  `expression` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `sortorder` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`iconmappingid`),
  KEY `icon_mapping_1` (`iconmapid`),
  KEY `icon_mapping_2` (`iconid`),
  CONSTRAINT `c_icon_mapping_1` FOREIGN KEY (`iconmapid`) REFERENCES `icon_map` (`iconmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_icon_mapping_2` FOREIGN KEY (`iconid`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icon_mapping`
--

LOCK TABLES `icon_mapping` WRITE;
/*!40000 ALTER TABLE `icon_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `icon_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ids`
--

DROP TABLE IF EXISTS `ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ids` (
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `field_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `nextid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`table_name`,`field_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ids`
--

LOCK TABLES `ids` WRITE;
/*!40000 ALTER TABLE `ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `imageid` bigint(20) unsigned NOT NULL,
  `imagetype` int(11) NOT NULL DEFAULT '0',
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `image` longblob NOT NULL,
  PRIMARY KEY (`imageid`),
  UNIQUE KEY `images_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interface`
--

DROP TABLE IF EXISTS `interface`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interface` (
  `interfaceid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `main` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `useip` int(11) NOT NULL DEFAULT '1',
  `ip` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '127.0.0.1',
  `dns` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `port` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '10050',
  `bulk` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`interfaceid`),
  KEY `interface_1` (`hostid`,`type`),
  KEY `interface_2` (`ip`,`dns`),
  CONSTRAINT `c_interface_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interface`
--

LOCK TABLES `interface` WRITE;
/*!40000 ALTER TABLE `interface` DISABLE KEYS */;
INSERT INTO `interface` VALUES (1,10084,1,1,1,'127.0.0.1','','10050',1);
/*!40000 ALTER TABLE `interface` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interface_discovery`
--

DROP TABLE IF EXISTS `interface_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interface_discovery` (
  `interfaceid` bigint(20) unsigned NOT NULL,
  `parent_interfaceid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`interfaceid`),
  KEY `c_interface_discovery_2` (`parent_interfaceid`),
  CONSTRAINT `c_interface_discovery_1` FOREIGN KEY (`interfaceid`) REFERENCES `interface` (`interfaceid`) ON DELETE CASCADE,
  CONSTRAINT `c_interface_discovery_2` FOREIGN KEY (`parent_interfaceid`) REFERENCES `interface` (`interfaceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interface_discovery`
--

LOCK TABLES `interface_discovery` WRITE;
/*!40000 ALTER TABLE `interface_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `interface_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_application_prototype`
--

DROP TABLE IF EXISTS `item_application_prototype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_application_prototype` (
  `item_application_prototypeid` bigint(20) unsigned NOT NULL,
  `application_prototypeid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`item_application_prototypeid`),
  UNIQUE KEY `item_application_prototype_1` (`application_prototypeid`,`itemid`),
  KEY `item_application_prototype_2` (`itemid`),
  CONSTRAINT `c_item_application_prototype_1` FOREIGN KEY (`application_prototypeid`) REFERENCES `application_prototype` (`application_prototypeid`) ON DELETE CASCADE,
  CONSTRAINT `c_item_application_prototype_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_application_prototype`
--

LOCK TABLES `item_application_prototype` WRITE;
/*!40000 ALTER TABLE `item_application_prototype` DISABLE KEYS */;
INSERT INTO `item_application_prototype` VALUES (1,1,23666);
/*!40000 ALTER TABLE `item_application_prototype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_condition`
--

DROP TABLE IF EXISTS `item_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_condition` (
  `item_conditionid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `operator` int(11) NOT NULL DEFAULT '8',
  `macro` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`item_conditionid`),
  KEY `item_condition_1` (`itemid`),
  CONSTRAINT `c_item_condition_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_condition`
--

LOCK TABLES `item_condition` WRITE;
/*!40000 ALTER TABLE `item_condition` DISABLE KEYS */;
INSERT INTO `item_condition` VALUES (1,22444,8,'{#IFNAME}','@Network interfaces for discovery'),(2,22450,8,'{#FSTYPE}','@File systems for discovery'),(4,22867,8,'{#FSTYPE}','@File systems for discovery'),(5,22907,8,'{#FSTYPE}','@File systems for discovery'),(6,22944,8,'{#IFNAME}','@Network interfaces for discovery'),(7,22947,8,'{#FSTYPE}','@File systems for discovery'),(8,22984,8,'{#IFNAME}','@Network interfaces for discovery'),(9,22987,8,'{#FSTYPE}','@File systems for discovery'),(10,23024,8,'{#IFNAME}','@Network interfaces for discovery'),(11,23027,8,'{#FSTYPE}','@File systems for discovery'),(12,23067,8,'{#FSTYPE}','@File systems for discovery'),(13,23162,8,'{#FSTYPE}','@File systems for discovery'),(14,23163,8,'{#IFNAME}','@Network interfaces for discovery'),(15,23329,8,'{#IFNAME}','@Network interfaces for discovery'),(16,23540,8,'{#IFNAME}','@Network interfaces for discovery'),(19,23278,8,'{#IFNAME}','@Network interfaces for discovery'),(20,23279,8,'{#FSTYPE}','@File systems for discovery'),(21,23665,8,'{#SERVICE.NAME}','@Windows service names for discovery'),(22,23665,8,'{#SERVICE.STARTUPNAME}','@Windows service startup states for discovery'),(215,27029,8,'{#IFOPERSTATUS}','1'),(216,27029,8,'{#SNMPVALUE}','(2|3)'),(217,27031,8,'{#IFOPERSTATUS}','1'),(218,27031,8,'{#SNMPVALUE}','(2|3)'),(219,27034,8,'{#STORAGE_TYPE}','.+2$'),(220,27034,8,'{#STORAGE_TYPE}','.+hrStorageRam'),(221,27035,8,'{#STORAGE_TYPE}','.+(4|9)'),(222,27035,8,'{#STORAGE_TYPE}','.+(hrStorageFixedDisk|hrStorageFlashMemory)'),(223,27050,8,'{#STORAGE_TYPE}','.+2$'),(224,27050,8,'{#STORAGE_TYPE}','.+hrStorageRam'),(225,27051,8,'{#STORAGE_TYPE}','.+(4|9)'),(226,27051,8,'{#STORAGE_TYPE}','.+(hrStorageFixedDisk|hrStorageFlashMemory)'),(227,27068,8,'{#IFADMINSTATUS}','(1|3)'),(228,27068,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(229,27078,8,'{#IFADMINSTATUS}','(1|3)'),(230,27078,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(231,27088,8,'{#IFADMINSTATUS}','(1|3)'),(232,27088,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(233,27098,8,'{#IFADMINSTATUS}','(1|3)'),(234,27098,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(237,27118,8,'{#IFADMINSTATUS}','(1|3)'),(238,27118,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(243,27180,8,'{#IFADMINSTATUS}','(1|3)'),(244,27180,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(245,27190,8,'{#IFOPERSTATUS}','1'),(246,27190,8,'{#SNMPVALUE}','(2|3)'),(247,27209,8,'{#TEMP_SENSOR}','1'),(248,27210,8,'{#SNMPVALUE}','[^1]'),(249,27211,8,'{#ENT_SN}','.+'),(250,27215,8,'{#IFADMINSTATUS}','(1|3)'),(251,27215,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(253,27242,8,'{#SENSOR_TYPE}','1'),(254,27243,8,'{#SENSOR_TYPE}','3'),(255,27244,8,'{#SENSOR_TYPE}','2'),(256,27251,8,'{#IFADMINSTATUS}','(1|3)'),(257,27251,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(258,27272,8,'{#IFADMINSTATUS}','(1|3)'),(259,27272,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(260,27321,8,'{#IFADMINSTATUS}','(1|3)'),(261,27321,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(262,27331,8,'{#IFOPERSTATUS}','1'),(263,27331,8,'{#SNMPVALUE}','(2|3)'),(266,27393,8,'{#ENT_SN}','.+'),(267,27393,8,'{#ENT_CLASS}','[^3]'),(268,27399,8,'{#ENT_SN}','.+'),(269,27399,8,'{#ENT_CLASS}','[^3]'),(272,27410,8,'{#ENT_SN}','.+'),(273,27410,8,'{#ENT_CLASS}','[^3]'),(274,27450,8,'{#IFADMINSTATUS}','(1|3)'),(275,27450,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(276,27460,8,'{#IFOPERSTATUS}','1'),(277,27460,8,'{#SNMPVALUE}','(2|3)'),(278,27486,8,'{#IFADMINSTATUS}','(1|3)'),(279,27486,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(280,27520,8,'{#IFADMINSTATUS}','(1|3)'),(281,27520,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(282,27530,8,'{#IFOPERSTATUS}','1'),(283,27530,8,'{#SNMPVALUE}','(2|3)'),(284,27550,8,'{#STATUS}','[^0]'),(285,27551,8,'{#STATUS}','[^0]'),(286,27556,8,'{#IFADMINSTATUS}','(1|3)'),(287,27556,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(288,27566,8,'{#IFOPERSTATUS}','1'),(289,27566,8,'{#SNMPVALUE}','(2|3)'),(290,27596,8,'{#IFADMINSTATUS}','(1|3)'),(291,27596,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(292,27606,8,'{#IFOPERSTATUS}','1'),(293,27606,8,'{#SNMPVALUE}','(2|3)'),(294,27619,8,'{#IFADMINSTATUS}','(1|3)'),(295,27619,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(296,27629,8,'{#IFOPERSTATUS}','1'),(297,27629,8,'{#SNMPVALUE}','(2|3)'),(298,27642,8,'{#IFADMINSTATUS}','(1|3)'),(299,27642,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(300,27652,8,'{#IFOPERSTATUS}','1'),(301,27652,8,'{#SNMPVALUE}','(2|3)'),(302,27665,8,'{#SNMPVALUE}','^(MODULE|Module) (LEVEL|level)1$'),(303,27665,8,'{#SNMPVALUE}','(Fabric|FABRIC) (.+) (Module|MODULE)'),(304,27666,8,'{#SNMPVALUE}','^(MODULE|Module) (LEVEL|level)1$'),(305,27666,8,'{#SNMPVALUE}','(Fabric|FABRIC) (.+) (Module|MODULE)'),(306,27666,8,'{#SNMPVALUE}','(T|t)emperature.*(s|S)ensor'),(307,27667,8,'{#ENT_CLASS}','7'),(308,27668,8,'{#ENT_CLASS}','6'),(309,27669,8,'{#ENT_CLASS}','3'),(323,27722,8,'{#IFADMINSTATUS}','(1|3)'),(324,27722,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(325,27732,8,'{#IFOPERSTATUS}','1'),(326,27732,8,'{#SNMPVALUE}','(2|3)'),(327,27745,8,'{#ENT_NAME}','MPU.*'),(328,27746,8,'{#ENT_CLASS}','3'),(329,27756,8,'{#IFADMINSTATUS}','(1|3)'),(330,27756,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(331,27779,8,'{#SENSOR_TYPE}','2'),(332,27780,8,'{#ENT_CLASS}','2'),(333,27788,8,'{#IFADMINSTATUS}','(1|3)'),(334,27788,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(335,27798,8,'{#IFOPERSTATUS}','1'),(336,27798,8,'{#SNMPVALUE}','(2|3)'),(337,27815,8,'{#SNMPVALUE}','Routing Engine.*'),(338,27816,8,'{#SNMPVALUE}','[^0]+'),(350,27872,8,'{#IFADMINSTATUS}','(1|3)'),(351,27872,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(352,27903,8,'{#STORAGE_TYPE}','.+4$'),(353,27903,8,'{#STORAGE_TYPE}','.+hrStorageFixedDisk'),(354,27909,8,'{#IFADMINSTATUS}','(1|3)'),(355,27909,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(356,27944,8,'{#IFADMINSTATUS}','(1|3)'),(357,27944,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(358,27954,8,'{#IFOPERSTATUS}','1'),(359,27954,8,'{#SNMPVALUE}','(2|3)'),(360,27976,8,'{#IFADMINSTATUS}','(1|3)'),(361,27976,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(362,28005,8,'{#IFADMINSTATUS}','(1|3)'),(363,28005,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(364,28043,8,'{#STORAGE_TYPE}','.+2$'),(365,28043,8,'{#STORAGE_TYPE}','.+hrStorageRam'),(366,28044,8,'{#STORAGE_TYPE}','.+(4|9)'),(367,28044,8,'{#STORAGE_TYPE}','.+(hrStorageFixedDisk|hrStorageFlashMemory)'),(368,28058,8,'{#IFADMINSTATUS}','(1|3)'),(369,28058,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(370,28068,8,'{#IFOPERSTATUS}','1'),(371,28068,8,'{#SNMPVALUE}','(2|3)'),(372,28082,8,'{#STORAGE_TYPE}','.+2$'),(373,28082,8,'{#STORAGE_TYPE}','.+hrStorageRam'),(374,28083,8,'{#STORAGE_TYPE}','.+(4|9)'),(375,28083,8,'{#STORAGE_TYPE}','.+(hrStorageFixedDisk|hrStorageFlashMemory)'),(376,28097,8,'{#IFADMINSTATUS}','(1|3)'),(377,28097,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(378,28118,8,'{#IFADMINSTATUS}','(1|3)'),(379,28118,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(380,28128,8,'{#IFOPERSTATUS}','1'),(381,28128,8,'{#SNMPVALUE}','(2|3)'),(382,28144,8,'{#SENSOR_TYPE}','8'),(383,28144,8,'{#SENSOR_PRECISION}','0'),(384,28146,8,'{#ENT_CLASS}','.+8.3.2$'),(385,28146,8,'{#ENT_STATUS}','(1|2|3|4)'),(386,28147,8,'{#ENT_CLASS}','.+8.3.1$'),(387,28147,8,'{#ENT_STATUS}','(1|2|3|4)'),(388,28148,8,'{#ENT_CLASS}','.+8.3.3$'),(389,28148,8,'{#ENT_STATUS}','(1|2|3|4)'),(390,28149,8,'{#ENT_CLASS}','3'),(391,28160,8,'{#STORAGE_TYPE}','.+2$'),(392,28160,8,'{#STORAGE_TYPE}','.+hrStorageRam'),(393,28161,8,'{#STORAGE_TYPE}','.+(4|9)'),(394,28161,8,'{#STORAGE_TYPE}','.+(hrStorageFixedDisk|hrStorageFlashMemory)'),(395,28175,8,'{#IFADMINSTATUS}','(1|3)'),(396,28175,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(397,28196,8,'{#SENSOR_TYPE}','8'),(398,28196,8,'{#SENSOR_PRECISION}','1'),(399,28197,8,'{#SNMPVALUE}','10'),(400,28198,8,'{#ENT_CLASS}','3'),(401,28199,8,'{#ENT_CLASS}','6'),(402,28207,8,'{#ENT_SN}','.+'),(403,28207,8,'{#ENT_CLASS}','[^3]'),(404,28223,8,'{#IFADMINSTATUS}','(1|3)'),(405,28223,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(406,27088,8,'{#IFNAME}','@Network interfaces for discovery'),(407,27098,8,'{#IFNAME}','@Network interfaces for discovery'),(408,27180,8,'{#IFNAME}','@Network interfaces for discovery'),(409,27215,8,'{#IFNAME}','@Network interfaces for discovery'),(410,27251,8,'{#IFNAME}','@Network interfaces for discovery'),(411,27272,8,'{#IFNAME}','@Network interfaces for discovery'),(412,27321,8,'{#IFNAME}','@Network interfaces for discovery'),(413,27450,8,'{#IFNAME}','@Network interfaces for discovery'),(414,27486,8,'{#IFNAME}','@Network interfaces for discovery'),(415,27520,8,'{#IFNAME}','@Network interfaces for discovery'),(416,27556,8,'{#IFNAME}','@Network interfaces for discovery'),(417,27642,8,'{#IFNAME}','@Network interfaces for discovery'),(418,27722,8,'{#IFNAME}','@Network interfaces for discovery'),(419,27756,8,'{#IFNAME}','@Network interfaces for discovery'),(420,27788,8,'{#IFNAME}','@Network interfaces for discovery'),(421,27872,8,'{#IFNAME}','@Network interfaces for discovery'),(422,27909,8,'{#IFNAME}','@Network interfaces for discovery'),(423,27944,8,'{#IFNAME}','@Network interfaces for discovery'),(424,28058,8,'{#IFNAME}','@Network interfaces for discovery'),(425,28118,8,'{#IFNAME}','@Network interfaces for discovery'),(426,28175,8,'{#IFNAME}','@Network interfaces for discovery'),(427,28223,8,'{#IFNAME}','@Network interfaces for discovery'),(428,27068,8,'{#IFNAME}','@Network interfaces for discovery'),(429,27596,8,'{#IFNAME}','@Network interfaces for discovery'),(430,28005,8,'{#IFNAME}','@Network interfaces for discovery'),(431,27078,8,'{#IFNAME}','@Network interfaces for discovery'),(432,27619,8,'{#IFNAME}','@Network interfaces for discovery'),(433,27976,8,'{#IFNAME}','@Network interfaces for discovery'),(434,27118,8,'{#IFNAME}','@Network interfaces for discovery'),(435,28097,8,'{#IFNAME}','@Network interfaces for discovery'),(436,28280,8,'{#IFOPERSTATUS}','1'),(437,28280,8,'{#SNMPVALUE}','(2|3)'),(438,28293,8,'{#IFADMINSTATUS}','(1|3)'),(439,28293,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(440,28293,8,'{#IFNAME}','@Network interfaces for discovery'),(441,28303,8,'{#DEVICE_TYPE}','.+3$'),(442,28303,8,'{#DEVICE_TYPE}','.+hrDeviceProcessor'),(443,28304,8,'{#STORAGE_TYPE}','.+2$'),(444,28304,8,'{#STORAGE_TYPE}','.+hrStorageRam'),(445,28304,8,'{#SNMPVALUE}','^RAM$'),(446,28305,8,'{#STORAGE_TYPE}','.+(4|9)$'),(447,28305,8,'{#STORAGE_TYPE}','.+(hrStorageFixedDisk|hrStorageFlashMemory)'),(448,28306,8,'{#SENSOR_TYPE}','8'),(449,28306,8,'{#SENSOR_PRECISION}','1'),(450,28307,8,'{#SNMPVALUE}','10'),(451,28308,8,'{#ENT_CLASS}','3'),(452,28309,8,'{#ENT_CLASS}','6'),(453,28346,8,'{#SENSOR_LOCALE}','.*CPU.*'),(454,28347,8,'{#SENSOR_LOCALE}','.*Inlet Temp.*'),(455,28349,8,'{#TYPE}','3'),(456,28392,8,'{#SENSOR_LOCALE}','(4|8|9|12|13)'),(457,28393,8,'{#SNMPINDEX}','0\\.1'),(458,28393,8,'{#SENSOR_LOCALE}','11'),(459,28394,8,'{#SENSOR_LOCALE}','6'),(460,28395,8,'{#SENSOR_LOCALE}','7'),(461,28396,8,'{#SENSOR_LOCALE}','10'),(462,28397,8,'{#SENSOR_LOCALE}','3'),(463,28440,8,'{#SNMPVALUE}','(DIMM|PSU|PCH|RAID|RR|PCI).*'),(464,28441,8,'{#SNMPVALUE}','Ambient.*'),(465,28442,8,'{#SNMPVALUE}','CPU [0-9]* Temp'),(466,28468,8,'{#SNMPVALUE}','(DIMM|PSU|PCH|RAID|RR|PCI).*'),(467,28469,8,'{#SNMPVALUE}','Ambient.*'),(468,28470,8,'{#SNMPVALUE}','CPU [0-9]* Temp'),(469,28493,8,'{#SNMPVALUE}','[1-9]+'),(470,28493,8,'{#SENSOR_DESCR}','.*Temp.*'),(471,28494,8,'{#SNMPVALUE}','[1-9]+'),(472,28494,8,'{#SENSOR_DESCR}','FAN.*');
/*!40000 ALTER TABLE `item_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_discovery`
--

DROP TABLE IF EXISTS `item_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_discovery` (
  `itemdiscoveryid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `parent_itemid` bigint(20) unsigned NOT NULL,
  `key_` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemdiscoveryid`),
  UNIQUE KEY `item_discovery_1` (`itemid`,`parent_itemid`),
  KEY `item_discovery_2` (`parent_itemid`),
  CONSTRAINT `c_item_discovery_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_item_discovery_2` FOREIGN KEY (`parent_itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_discovery`
--

LOCK TABLES `item_discovery` WRITE;
/*!40000 ALTER TABLE `item_discovery` DISABLE KEYS */;
INSERT INTO `item_discovery` VALUES (1,22446,22444,'',0,0),(3,22448,22444,'',0,0),(5,22452,22450,'',0,0),(7,22454,22450,'',0,0),(9,22456,22450,'',0,0),(11,22458,22450,'',0,0),(65,22686,22450,'',0,0),(135,22868,22867,'',0,0),(136,22869,22867,'',0,0),(137,22870,22867,'',0,0),(138,22871,22867,'',0,0),(139,22872,22867,'',0,0),(142,22908,22907,'',0,0),(143,22909,22907,'',0,0),(144,22910,22907,'',0,0),(145,22911,22907,'',0,0),(146,22912,22907,'',0,0),(147,22945,22944,'',0,0),(148,22946,22944,'',0,0),(149,22948,22947,'',0,0),(150,22949,22947,'',0,0),(151,22950,22947,'',0,0),(152,22951,22947,'',0,0),(153,22952,22947,'',0,0),(154,22985,22984,'',0,0),(155,22986,22984,'',0,0),(156,22988,22987,'',0,0),(157,22989,22987,'',0,0),(158,22990,22987,'',0,0),(159,22991,22987,'',0,0),(160,22992,22987,'',0,0),(161,23025,23024,'',0,0),(162,23026,23024,'',0,0),(163,23028,23027,'',0,0),(164,23029,23027,'',0,0),(165,23030,23027,'',0,0),(166,23031,23027,'',0,0),(167,23032,23027,'',0,0),(170,23068,23067,'',0,0),(171,23069,23067,'',0,0),(172,23070,23067,'',0,0),(173,23071,23067,'',0,0),(174,23072,23067,'',0,0),(175,23164,23162,'',0,0),(176,23165,23162,'',0,0),(178,23167,23162,'',0,0),(179,23168,23162,'',0,0),(180,23169,23163,'',0,0),(181,23170,23163,'',0,0),(182,23280,23278,'',0,0),(183,23281,23278,'',0,0),(184,23282,23279,'',0,0),(185,23283,23279,'',0,0),(186,23284,23279,'',0,0),(187,23285,23279,'',0,0),(188,23286,23279,'',0,0),(189,23073,23540,'',0,0),(190,23074,23540,'',0,0),(191,23075,23329,'',0,0),(192,23076,23329,'',0,0),(220,23666,23665,'',0,0),(746,26994,26987,'',0,0),(747,26995,26990,'',0,0),(748,26996,26990,'',0,0),(749,26997,26990,'',0,0),(750,26998,26990,'',0,0),(751,26999,26991,'',0,0),(752,27000,26991,'',0,0),(753,27001,26991,'',0,0),(754,27002,26991,'',0,0),(755,27003,26992,'',0,0),(756,27004,26992,'',0,0),(757,27005,26992,'',0,0),(758,27006,26992,'',0,0),(759,27007,26993,'',0,0),(760,27008,26993,'',0,0),(761,27009,26993,'',0,0),(762,27010,26993,'',0,0),(775,27030,27029,'',0,0),(776,27032,27031,'',0,0),(777,27036,27033,'',0,0),(778,27037,27034,'',0,0),(779,27038,27034,'',0,0),(780,27039,27034,'',0,0),(781,27040,27034,'',0,0),(782,27041,27034,'',0,0),(783,27042,27034,'',0,0),(784,27043,27035,'',0,0),(785,27044,27035,'',0,0),(786,27045,27035,'',0,0),(787,27046,27035,'',0,0),(788,27047,27035,'',0,0),(789,27048,27035,'',0,0),(790,27052,27049,'',0,0),(791,27053,27050,'',0,0),(792,27054,27050,'',0,0),(793,27055,27050,'',0,0),(794,27056,27050,'',0,0),(795,27057,27050,'',0,0),(796,27058,27050,'',0,0),(797,27059,27051,'',0,0),(798,27060,27051,'',0,0),(799,27061,27051,'',0,0),(800,27062,27051,'',0,0),(801,27063,27051,'',0,0),(802,27064,27051,'',0,0),(803,27069,27068,'',0,0),(804,27070,27068,'',0,0),(805,27071,27068,'',0,0),(806,27072,27068,'',0,0),(807,27073,27068,'',0,0),(808,27074,27068,'',0,0),(809,27075,27068,'',0,0),(810,27076,27068,'',0,0),(811,27077,27068,'',0,0),(812,27079,27078,'',0,0),(813,27080,27078,'',0,0),(814,27081,27078,'',0,0),(815,27082,27078,'',0,0),(816,27083,27078,'',0,0),(817,27084,27078,'',0,0),(818,27085,27078,'',0,0),(819,27086,27078,'',0,0),(820,27087,27078,'',0,0),(821,27089,27088,'',0,0),(822,27090,27088,'',0,0),(823,27091,27088,'',0,0),(824,27092,27088,'',0,0),(825,27093,27088,'',0,0),(826,27094,27088,'',0,0),(827,27095,27088,'',0,0),(828,27096,27088,'',0,0),(829,27097,27088,'',0,0),(830,27099,27098,'',0,0),(831,27100,27098,'',0,0),(832,27101,27098,'',0,0),(833,27102,27098,'',0,0),(834,27103,27098,'',0,0),(835,27104,27098,'',0,0),(836,27105,27098,'',0,0),(837,27106,27098,'',0,0),(838,27107,27098,'',0,0),(848,27119,27118,'',0,0),(849,27120,27118,'',0,0),(850,27121,27118,'',0,0),(851,27122,27118,'',0,0),(852,27123,27118,'',0,0),(853,27124,27118,'',0,0),(854,27125,27118,'',0,0),(855,27126,27118,'',0,0),(856,27127,27118,'',0,0),(875,27181,27180,'',0,0),(876,27182,27180,'',0,0),(877,27183,27180,'',0,0),(878,27184,27180,'',0,0),(879,27185,27180,'',0,0),(880,27186,27180,'',0,0),(881,27187,27180,'',0,0),(882,27188,27180,'',0,0),(883,27189,27180,'',0,0),(884,27191,27190,'',0,0),(885,27212,27209,'',0,0),(886,27213,27210,'',0,0),(887,27214,27211,'',0,0),(888,27216,27215,'',0,0),(889,27217,27215,'',0,0),(890,27218,27215,'',0,0),(891,27219,27215,'',0,0),(892,27220,27215,'',0,0),(893,27221,27215,'',0,0),(894,27222,27215,'',0,0),(895,27223,27215,'',0,0),(896,27224,27215,'',0,0),(898,27246,27242,'',0,0),(899,27247,27242,'',0,0),(900,27248,27243,'',0,0),(901,27249,27244,'',0,0),(902,27250,27244,'',0,0),(903,27252,27251,'',0,0),(904,27253,27251,'',0,0),(905,27254,27251,'',0,0),(906,27255,27251,'',0,0),(907,27256,27251,'',0,0),(908,27257,27251,'',0,0),(909,27258,27251,'',0,0),(910,27259,27251,'',0,0),(911,27260,27251,'',0,0),(912,27273,27272,'',0,0),(913,27274,27272,'',0,0),(914,27275,27272,'',0,0),(915,27276,27272,'',0,0),(916,27277,27272,'',0,0),(917,27278,27272,'',0,0),(918,27279,27272,'',0,0),(919,27280,27272,'',0,0),(920,27281,27272,'',0,0),(921,27312,27302,'',0,0),(922,27313,27303,'',0,0),(923,27314,27304,'',0,0),(924,27315,27306,'',0,0),(925,27316,27307,'',0,0),(926,27317,27308,'',0,0),(927,27318,27309,'',0,0),(928,27319,27310,'',0,0),(929,27320,27311,'',0,0),(930,27322,27321,'',0,0),(931,27323,27321,'',0,0),(932,27324,27321,'',0,0),(933,27325,27321,'',0,0),(934,27326,27321,'',0,0),(935,27327,27321,'',0,0),(936,27328,27321,'',0,0),(937,27329,27321,'',0,0),(938,27330,27321,'',0,0),(939,27332,27331,'',0,0),(949,27414,27390,'',0,0),(950,27415,27390,'',0,0),(951,27416,27390,'',0,0),(952,27417,27391,'',0,0),(954,27419,27393,'',0,0),(955,27420,27394,'',0,0),(956,27421,27394,'',0,0),(957,27422,27395,'',0,0),(958,27423,27396,'',0,0),(959,27424,27397,'',0,0),(960,27425,27397,'',0,0),(961,27426,27397,'',0,0),(962,27427,27398,'',0,0),(963,27428,27399,'',0,0),(964,27429,27400,'',0,0),(965,27430,27400,'',0,0),(966,27431,27401,'',0,0),(967,27432,27402,'',0,0),(977,27442,27409,'',0,0),(978,27443,27409,'',0,0),(979,27444,27409,'',0,0),(980,27445,27410,'',0,0),(981,27446,27411,'',0,0),(982,27447,27411,'',0,0),(983,27448,27412,'',0,0),(984,27449,27413,'',0,0),(985,27451,27450,'',0,0),(986,27452,27450,'',0,0),(987,27453,27450,'',0,0),(988,27454,27450,'',0,0),(989,27455,27450,'',0,0),(990,27456,27450,'',0,0),(991,27457,27450,'',0,0),(992,27458,27450,'',0,0),(993,27459,27450,'',0,0),(994,27461,27460,'',0,0),(995,27477,27473,'',0,0),(996,27478,27473,'',0,0),(997,27479,27474,'',0,0),(998,27480,27475,'',0,0),(999,27481,27476,'',0,0),(1000,27482,27476,'',0,0),(1001,27483,27476,'',0,0),(1002,27484,27476,'',0,0),(1003,27485,27476,'',0,0),(1004,27487,27486,'',0,0),(1005,27488,27486,'',0,0),(1006,27489,27486,'',0,0),(1007,27490,27486,'',0,0),(1008,27491,27486,'',0,0),(1009,27492,27486,'',0,0),(1010,27493,27486,'',0,0),(1011,27494,27486,'',0,0),(1012,27495,27486,'',0,0),(1013,27516,27512,'',0,0),(1014,27517,27513,'',0,0),(1015,27518,27514,'',0,0),(1016,27519,27515,'',0,0),(1017,27521,27520,'',0,0),(1018,27522,27520,'',0,0),(1019,27523,27520,'',0,0),(1020,27524,27520,'',0,0),(1021,27525,27520,'',0,0),(1022,27526,27520,'',0,0),(1023,27527,27520,'',0,0),(1024,27528,27520,'',0,0),(1025,27529,27520,'',0,0),(1026,27531,27530,'',0,0),(1027,27552,27548,'',0,0),(1028,27553,27549,'',0,0),(1029,27554,27550,'',0,0),(1030,27555,27551,'',0,0),(1031,27557,27556,'',0,0),(1032,27558,27556,'',0,0),(1033,27559,27556,'',0,0),(1034,27560,27556,'',0,0),(1035,27561,27556,'',0,0),(1036,27562,27556,'',0,0),(1037,27563,27556,'',0,0),(1038,27564,27556,'',0,0),(1039,27565,27556,'',0,0),(1040,27567,27566,'',0,0),(1041,27590,27587,'',0,0),(1042,27591,27587,'',0,0),(1043,27592,27587,'',0,0),(1044,27593,27588,'',0,0),(1045,27594,27589,'',0,0),(1046,27595,27589,'',0,0),(1047,27597,27596,'',0,0),(1048,27598,27596,'',0,0),(1049,27599,27596,'',0,0),(1050,27600,27596,'',0,0),(1051,27601,27596,'',0,0),(1052,27602,27596,'',0,0),(1053,27603,27596,'',0,0),(1054,27604,27596,'',0,0),(1055,27605,27596,'',0,0),(1056,27607,27606,'',0,0),(1057,27620,27619,'',0,0),(1058,27621,27619,'',0,0),(1059,27622,27619,'',0,0),(1060,27623,27619,'',0,0),(1061,27624,27619,'',0,0),(1062,27625,27619,'',0,0),(1063,27626,27619,'',0,0),(1064,27627,27619,'',0,0),(1065,27628,27619,'',0,0),(1066,27630,27629,'',0,0),(1067,27643,27642,'',0,0),(1068,27644,27642,'',0,0),(1069,27645,27642,'',0,0),(1070,27646,27642,'',0,0),(1071,27647,27642,'',0,0),(1072,27648,27642,'',0,0),(1073,27649,27642,'',0,0),(1074,27650,27642,'',0,0),(1075,27651,27642,'',0,0),(1076,27653,27652,'',0,0),(1077,27670,27665,'',0,0),(1078,27671,27665,'',0,0),(1079,27672,27666,'',0,0),(1080,27673,27667,'',0,0),(1081,27674,27668,'',0,0),(1082,27675,27669,'',0,0),(1083,27676,27669,'',0,0),(1084,27677,27669,'',0,0),(1085,27678,27669,'',0,0),(1086,27679,27669,'',0,0),(1107,27723,27722,'',0,0),(1108,27724,27722,'',0,0),(1109,27725,27722,'',0,0),(1110,27726,27722,'',0,0),(1111,27727,27722,'',0,0),(1112,27728,27722,'',0,0),(1113,27729,27722,'',0,0),(1114,27730,27722,'',0,0),(1115,27731,27722,'',0,0),(1116,27733,27732,'',0,0),(1117,27748,27745,'',0,0),(1118,27749,27745,'',0,0),(1119,27750,27745,'',0,0),(1120,27751,27745,'',0,0),(1121,27752,27745,'',0,0),(1122,27753,27745,'',0,0),(1123,27754,27746,'',0,0),(1124,27755,27747,'',0,0),(1125,27757,27756,'',0,0),(1126,27758,27756,'',0,0),(1127,27759,27756,'',0,0),(1128,27760,27756,'',0,0),(1129,27761,27756,'',0,0),(1130,27762,27756,'',0,0),(1131,27763,27756,'',0,0),(1132,27764,27756,'',0,0),(1133,27765,27756,'',0,0),(1134,27783,27779,'',0,0),(1135,27784,27779,'',0,0),(1136,27785,27780,'',0,0),(1137,27786,27781,'',0,0),(1138,27787,27782,'',0,0),(1139,27789,27788,'',0,0),(1140,27790,27788,'',0,0),(1141,27791,27788,'',0,0),(1142,27792,27788,'',0,0),(1143,27793,27788,'',0,0),(1144,27794,27788,'',0,0),(1145,27795,27788,'',0,0),(1146,27796,27788,'',0,0),(1147,27797,27788,'',0,0),(1148,27799,27798,'',0,0),(1149,27819,27815,'',0,0),(1150,27820,27815,'',0,0),(1151,27821,27816,'',0,0),(1152,27822,27817,'',0,0),(1153,27823,27818,'',0,0),(1183,27873,27872,'',0,0),(1184,27874,27872,'',0,0),(1185,27875,27872,'',0,0),(1186,27876,27872,'',0,0),(1187,27877,27872,'',0,0),(1188,27878,27872,'',0,0),(1189,27879,27872,'',0,0),(1190,27880,27872,'',0,0),(1191,27881,27872,'',0,0),(1192,27904,27901,'',0,0),(1193,27905,27902,'',0,0),(1194,27906,27903,'',0,0),(1195,27907,27903,'',0,0),(1196,27908,27903,'',0,0),(1197,27910,27909,'',0,0),(1198,27911,27909,'',0,0),(1199,27912,27909,'',0,0),(1200,27913,27909,'',0,0),(1201,27914,27909,'',0,0),(1202,27915,27909,'',0,0),(1203,27916,27909,'',0,0),(1204,27917,27909,'',0,0),(1205,27918,27909,'',0,0),(1206,27940,27937,'',0,0),(1207,27941,27937,'',0,0),(1208,27942,27938,'',0,0),(1209,27943,27939,'',0,0),(1210,27945,27944,'',0,0),(1211,27946,27944,'',0,0),(1212,27947,27944,'',0,0),(1213,27948,27944,'',0,0),(1214,27949,27944,'',0,0),(1215,27950,27944,'',0,0),(1216,27951,27944,'',0,0),(1217,27952,27944,'',0,0),(1218,27953,27944,'',0,0),(1219,27955,27954,'',0,0),(1220,27977,27976,'',0,0),(1221,27978,27976,'',0,0),(1222,27979,27976,'',0,0),(1223,27980,27976,'',0,0),(1224,27981,27976,'',0,0),(1225,27982,27976,'',0,0),(1226,27983,27976,'',0,0),(1227,27984,27976,'',0,0),(1228,27985,27976,'',0,0),(1229,28003,28001,'',0,0),(1230,28004,28002,'',0,0),(1231,28006,28005,'',0,0),(1232,28007,28005,'',0,0),(1233,28008,28005,'',0,0),(1234,28009,28005,'',0,0),(1235,28010,28005,'',0,0),(1236,28011,28005,'',0,0),(1237,28012,28005,'',0,0),(1238,28013,28005,'',0,0),(1239,28014,28005,'',0,0),(1240,28045,28042,'',0,0),(1241,28046,28044,'',0,0),(1242,28047,28044,'',0,0),(1243,28048,28044,'',0,0),(1244,28049,28044,'',0,0),(1245,28050,28044,'',0,0),(1246,28051,28044,'',0,0),(1247,28052,28043,'',0,0),(1248,28053,28043,'',0,0),(1249,28054,28043,'',0,0),(1250,28055,28043,'',0,0),(1251,28056,28043,'',0,0),(1252,28057,28043,'',0,0),(1253,28059,28058,'',0,0),(1254,28060,28058,'',0,0),(1255,28061,28058,'',0,0),(1256,28062,28058,'',0,0),(1257,28063,28058,'',0,0),(1258,28064,28058,'',0,0),(1259,28065,28058,'',0,0),(1260,28066,28058,'',0,0),(1261,28067,28058,'',0,0),(1262,28069,28068,'',0,0),(1263,28084,28081,'',0,0),(1264,28085,28083,'',0,0),(1265,28086,28083,'',0,0),(1266,28087,28083,'',0,0),(1267,28088,28083,'',0,0),(1268,28089,28083,'',0,0),(1269,28090,28083,'',0,0),(1270,28091,28082,'',0,0),(1271,28092,28082,'',0,0),(1272,28093,28082,'',0,0),(1273,28094,28082,'',0,0),(1274,28095,28082,'',0,0),(1275,28096,28082,'',0,0),(1276,28098,28097,'',0,0),(1277,28099,28097,'',0,0),(1278,28100,28097,'',0,0),(1279,28101,28097,'',0,0),(1280,28102,28097,'',0,0),(1281,28103,28097,'',0,0),(1282,28104,28097,'',0,0),(1283,28105,28097,'',0,0),(1284,28106,28097,'',0,0),(1285,28119,28118,'',0,0),(1286,28120,28118,'',0,0),(1287,28121,28118,'',0,0),(1288,28122,28118,'',0,0),(1289,28123,28118,'',0,0),(1290,28124,28118,'',0,0),(1291,28125,28118,'',0,0),(1292,28126,28118,'',0,0),(1293,28127,28118,'',0,0),(1294,28129,28128,'',0,0),(1295,28150,28144,'',0,0),(1296,28151,28145,'',0,0),(1297,28152,28145,'',0,0),(1298,28153,28145,'',0,0),(1299,28154,28146,'',0,0),(1300,28155,28147,'',0,0),(1301,28156,28148,'',0,0),(1302,28157,28149,'',0,0),(1303,28158,28149,'',0,0),(1304,28162,28159,'',0,0),(1305,28163,28161,'',0,0),(1306,28164,28161,'',0,0),(1307,28165,28161,'',0,0),(1308,28166,28161,'',0,0),(1309,28167,28161,'',0,0),(1310,28168,28161,'',0,0),(1311,28169,28160,'',0,0),(1312,28170,28160,'',0,0),(1313,28171,28160,'',0,0),(1314,28172,28160,'',0,0),(1315,28173,28160,'',0,0),(1316,28174,28160,'',0,0),(1317,28176,28175,'',0,0),(1318,28177,28175,'',0,0),(1319,28178,28175,'',0,0),(1320,28179,28175,'',0,0),(1321,28180,28175,'',0,0),(1322,28181,28175,'',0,0),(1323,28182,28175,'',0,0),(1324,28183,28175,'',0,0),(1325,28184,28175,'',0,0),(1326,28200,28196,'',0,0),(1327,28201,28196,'',0,0),(1328,28202,28197,'',0,0),(1329,28203,28197,'',0,0),(1330,28204,28198,'',0,0),(1331,28205,28198,'',0,0),(1332,28206,28199,'',0,0),(1333,28208,28207,'',0,0),(1334,28215,28212,'',0,0),(1335,28216,28213,'',0,0),(1336,28217,28214,'',0,0),(1337,28218,28214,'',0,0),(1338,28220,28219,'',0,0),(1339,28221,28219,'',0,0),(1340,28222,28219,'',0,0),(1341,28224,28223,'',0,0),(1342,28225,28223,'',0,0),(1343,28226,28223,'',0,0),(1344,28227,28223,'',0,0),(1345,28228,28223,'',0,0),(1346,28229,28223,'',0,0),(1347,28230,28223,'',0,0),(1348,28231,28223,'',0,0),(1349,28232,28223,'',0,0),(1350,28246,28244,'',0,0),(1351,28247,28245,'',0,0),(1352,28281,28280,'',0,0),(1353,28294,28293,'',0,0),(1354,28295,28293,'',0,0),(1355,28296,28293,'',0,0),(1356,28297,28293,'',0,0),(1357,28298,28293,'',0,0),(1358,28299,28293,'',0,0),(1359,28300,28293,'',0,0),(1360,28301,28293,'',0,0),(1361,28302,28293,'',0,0),(1362,28310,28303,'',0,0),(1363,28311,28304,'',0,0),(1364,28312,28304,'',0,0),(1365,28313,28304,'',0,0),(1366,28314,28304,'',0,0),(1367,28315,28304,'',0,0),(1368,28316,28304,'',0,0),(1369,28317,28305,'',0,0),(1370,28318,28305,'',0,0),(1371,28319,28305,'',0,0),(1372,28320,28305,'',0,0),(1373,28321,28305,'',0,0),(1374,28322,28305,'',0,0),(1375,28323,28306,'',0,0),(1376,28324,28306,'',0,0),(1377,28325,28307,'',0,0),(1378,28326,28307,'',0,0),(1379,28327,28308,'',0,0),(1380,28328,28308,'',0,0),(1381,28329,28309,'',0,0),(1382,28354,28346,'',0,0),(1383,28355,28346,'',0,0),(1384,28356,28347,'',0,0),(1385,28357,28347,'',0,0),(1386,28358,28348,'',0,0),(1387,28359,28349,'',0,0),(1388,28360,28349,'',0,0),(1389,28361,28350,'',0,0),(1390,28362,28350,'',0,0),(1391,28363,28350,'',0,0),(1392,28364,28350,'',0,0),(1393,28365,28350,'',0,0),(1394,28366,28350,'',0,0),(1395,28367,28350,'',0,0),(1396,28368,28351,'',0,0),(1397,28369,28351,'',0,0),(1398,28370,28351,'',0,0),(1399,28371,28351,'',0,0),(1400,28372,28351,'',0,0),(1401,28373,28351,'',0,0),(1402,28374,28352,'',0,0),(1403,28375,28352,'',0,0),(1404,28376,28353,'',0,0),(1405,28404,28392,'',0,0),(1406,28405,28392,'',0,0),(1407,28406,28393,'',0,0),(1408,28407,28394,'',0,0),(1409,28408,28395,'',0,0),(1410,28409,28396,'',0,0),(1411,28410,28397,'',0,0),(1412,28411,28398,'',0,0),(1413,28412,28399,'',0,0),(1414,28413,28400,'',0,0),(1415,28414,28400,'',0,0),(1416,28415,28401,'',0,0),(1417,28416,28401,'',0,0),(1418,28417,28402,'',0,0),(1419,28418,28402,'',0,0),(1420,28419,28402,'',0,0),(1421,28420,28402,'',0,0),(1422,28421,28402,'',0,0),(1423,28422,28402,'',0,0),(1424,28423,28403,'',0,0),(1425,28424,28403,'',0,0),(1426,28425,28403,'',0,0),(1427,28446,28440,'',0,0),(1428,28447,28441,'',0,0),(1429,28448,28442,'',0,0),(1430,28449,28443,'',0,0),(1431,28450,28444,'',0,0),(1432,28451,28444,'',0,0),(1433,28452,28445,'',0,0),(1434,28453,28445,'',0,0),(1435,28474,28468,'',0,0),(1436,28475,28469,'',0,0),(1437,28476,28470,'',0,0),(1438,28477,28471,'',0,0),(1439,28478,28472,'',0,0),(1440,28479,28472,'',0,0),(1441,28480,28473,'',0,0),(1442,28481,28473,'',0,0),(1443,28495,28493,'',0,0),(1444,28496,28494,'',0,0),(1445,28621,28620,'',0,0),(1446,28622,28620,'',0,0),(1447,28623,28620,'',0,0),(1448,28624,28620,'',0,0);
/*!40000 ALTER TABLE `item_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_preproc`
--

DROP TABLE IF EXISTS `item_preproc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_preproc` (
  `item_preprocid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `step` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `params` text COLLATE utf8_bin NOT NULL,
  `error_handler` int(11) NOT NULL DEFAULT '0',
  `error_handler_params` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`item_preprocid`),
  KEY `item_preproc_1` (`itemid`,`step`),
  CONSTRAINT `c_item_preproc_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_preproc`
--

LOCK TABLES `item_preproc` WRITE;
/*!40000 ALTER TABLE `item_preproc` DISABLE KEYS */;
INSERT INTO `item_preproc` VALUES (4950,28252,1,1,'0.01',0,''),(4951,28253,1,1,'0.01',0,''),(4952,28254,2,1,'0.01',0,''),(4953,28255,1,1,'0.01',0,''),(4954,28256,1,1,'0.01',0,''),(4955,28257,2,1,'0.01',0,''),(4956,28258,3,1,'0.01',0,''),(4957,28259,4,1,'0.01',0,''),(4958,28260,5,1,'0.01',0,''),(4959,28261,6,1,'0.01',0,''),(4960,28262,7,1,'0.01',0,''),(4961,28263,8,1,'0.01',0,''),(4962,28264,9,1,'0.01',0,''),(4963,28265,10,1,'0.01',0,''),(4964,28266,11,1,'0.01',0,''),(4965,28267,12,1,'0.01',0,''),(4966,28268,13,1,'0.01',0,''),(4967,28269,14,1,'0.01',0,''),(4968,28270,15,1,'0.01',0,''),(4969,28271,16,1,'0.01',0,''),(4970,28272,17,1,'0.01',0,''),(4971,28273,18,1,'0.01',0,''),(4972,28274,19,1,'0.01',0,''),(4973,28275,20,1,'0.01',0,''),(4974,28276,21,1,'0.01',0,''),(4975,28277,22,1,'0.01',0,''),(4976,28278,23,1,'0.01',0,''),(4977,28279,24,1,'0.01',0,''),(5242,27207,1,1,'1024',0,''),(5243,27206,2,1,'1024',0,''),(5244,27203,3,5,'^(\\w|-|\\.|/)+ (\\w|-|\\.|/)+ (.+) Copyright\n\\3',0,''),(5245,27204,4,5,'^((\\w|-|\\.|/)+)\n\\1',0,''),(5246,28291,1,1,'0.01',0,''),(5256,28323,1,1,'0.1',0,''),(5257,27314,1,1,'0.5',0,''),(5258,27315,2,1,'0.5',0,''),(5259,27318,3,1,'0.5',0,''),(5260,27377,1,5,'Version (.+), RELEASE\n\\1',0,''),(5261,27381,1,5,'Version (.+), RELEASE\n\\1',0,''),(5262,27384,2,5,'Version (.+), RELEASE\n\\1',0,''),(5263,28211,3,5,'Version (.+), RELEASE\n\\1',0,''),(5264,27592,1,1,'1024',0,''),(5265,27591,2,1,'1024',0,''),(5266,27778,1,5,'(.+) - Firmware\n\\1',0,''),(5267,27777,2,5,'Firmware Version: ([0-9.]+),\n\\1',0,''),(5268,27811,1,5,'kernel (JUNOS [0-9a-zA-Z\\.]+)\n\\1',0,''),(5269,28201,1,1,'0.1',0,''),(5270,27900,1,1,'1024',0,''),(5271,27898,2,1,'1024',0,''),(5272,27897,3,1,'0.1',0,''),(5273,27905,1,1,'0.1',0,''),(5274,27908,2,1,'1024',0,''),(5275,27907,3,1,'1024',0,''),(5276,27936,1,5,'60 Secs \\( ([0-9\\.]+)%\\).+300 Secs\n\\1',0,''),(5277,28030,1,1,'1024',0,''),(5278,28029,2,1,'1024',0,''),(5279,28339,1,1,'0.01',0,''),(5280,28354,1,1,'0.1',0,''),(5281,28356,2,1,'0.1',0,''),(5282,28367,3,1,'1048576',0,''),(5283,28372,4,1,'1048576',0,''),(5284,28386,1,1,'0.01',0,''),(5285,28422,1,1,'1048576',0,''),(5286,28425,2,1,'1048576',0,''),(5287,28435,1,1,'0.01',0,''),(5288,28451,1,5,'(\\d{1,3}) *%( of maximum)?\n\\1',0,''),(5289,28463,1,1,'0.01',0,''),(5290,28479,1,5,'(\\d{1,3}) *%( of maximum)?\n\\1',0,''),(5291,28491,1,1,'0.01',0,''),(5406,28501,1,10,'',0,''),(5407,28514,2,10,'',0,''),(5408,28517,3,10,'',0,''),(5409,28519,4,10,'',0,''),(5410,28520,5,1,'0.001',0,''),(5411,28521,6,10,'',0,''),(5412,28522,7,10,'',0,''),(5413,28523,8,10,'',0,''),(5414,28524,9,10,'',0,''),(5415,28525,10,1,'0.001',0,''),(5416,28526,11,10,'',0,''),(5417,28527,12,10,'',0,''),(5418,28528,13,10,'',0,''),(5419,28529,14,10,'',0,''),(5420,28530,15,1,'0.001',0,''),(5421,28531,16,10,'',0,''),(5422,26881,1,1,'100',0,''),(5423,26876,2,1,'0.001',0,''),(5424,26896,3,10,'',0,''),(5425,26894,4,1,'0.001',0,''),(5426,26895,5,10,'',0,''),(5427,26890,6,1,'0.001',0,''),(5428,26889,7,10,'',0,''),(5429,26885,8,1,'0.001',0,''),(5430,26884,9,10,'',0,''),(5431,26886,10,1,'0.001',0,''),(5432,26887,11,10,'',0,''),(5433,26888,12,1,'0.001',0,''),(5434,26897,13,1,'0.001',0,''),(5435,26906,14,10,'',0,''),(5436,26905,15,1,'0.001',0,''),(5444,22196,1,10,'',0,''),(5445,22199,2,10,'',0,''),(5446,10061,3,10,'',0,''),(5447,10063,4,10,'',0,''),(5448,10066,5,10,'',0,''),(5449,10062,6,10,'',0,''),(5450,10065,7,10,'',0,''),(5451,10064,8,10,'',0,''),(5452,22187,9,10,'',0,''),(5453,23625,1,10,'',0,''),(5454,23628,2,10,'',0,''),(5455,10073,3,10,'',0,''),(5456,10075,4,10,'',0,''),(5457,10078,5,10,'',0,''),(5458,10074,6,10,'',0,''),(5459,10077,7,10,'',0,''),(5460,10076,8,10,'',0,''),(5461,23277,9,10,'',0,''),(5462,26920,1,10,'',0,''),(5463,26919,2,10,'',0,''),(5464,26921,3,10,'',0,''),(5465,26922,4,10,'',0,''),(5466,26923,5,10,'',0,''),(5467,26918,6,10,'',0,''),(5468,26917,7,10,'',0,''),(5469,26912,8,10,'',0,''),(5470,26911,9,10,'',0,''),(5471,26913,10,10,'',0,''),(5472,22920,1,10,'',0,''),(5473,22924,2,10,'',0,''),(5474,22945,1,10,'',0,''),(5475,22945,2,1,'8',0,''),(5476,22946,3,10,'',0,''),(5477,22946,4,1,'8',0,''),(5478,22884,1,10,'',0,''),(5479,22880,2,10,'',0,''),(5480,23073,1,10,'',0,''),(5481,23073,2,1,'8',0,''),(5482,23074,3,10,'',0,''),(5483,23074,4,1,'8',0,''),(5484,22985,1,10,'',0,''),(5485,22985,2,1,'8',0,''),(5486,22986,3,10,'',0,''),(5487,22986,4,1,'8',0,''),(5488,22680,1,10,'',0,''),(5489,22683,2,10,'',0,''),(5490,23298,1,10,'',0,''),(5491,23294,2,10,'',0,''),(5492,22446,1,10,'',0,''),(5493,22446,2,1,'8',0,''),(5494,22448,3,10,'',0,''),(5495,22448,4,1,'8',0,''),(5496,23280,1,10,'',0,''),(5497,23280,2,1,'8',0,''),(5498,23281,3,10,'',0,''),(5499,23281,4,1,'8',0,''),(5500,23077,1,10,'',0,''),(5501,23077,2,1,'8',0,''),(5502,23078,3,10,'',0,''),(5503,23078,4,1,'8',0,''),(5504,22844,1,10,'',0,''),(5505,22840,2,10,'',0,''),(5506,23075,1,10,'',0,''),(5507,23075,2,1,'8',0,''),(5508,23076,3,10,'',0,''),(5509,23076,4,1,'8',0,''),(5510,23004,1,10,'',0,''),(5511,23000,2,10,'',0,''),(5512,23025,1,10,'',0,''),(5513,23025,2,1,'8',0,''),(5514,23026,3,10,'',0,''),(5515,23026,4,1,'8',0,''),(5516,23169,1,10,'',0,''),(5517,23169,2,1,'8',0,''),(5518,23170,3,10,'',0,''),(5519,23170,4,1,'8',0,''),(5599,10070,1,10,'',0,''),(5600,10071,1,10,'',0,''),(5601,10068,1,10,'',0,''),(5602,10072,1,10,'',0,''),(5603,10069,1,10,'',0,''),(5604,10067,1,10,'',0,''),(5605,23340,1,10,'',0,''),(5606,27074,1,10,'',0,''),(5607,27074,2,1,'8',0,''),(5608,27075,1,10,'',0,''),(5609,27075,2,1,'8',0,''),(5610,27076,1,10,'',0,''),(5611,27073,1,10,'',0,''),(5612,27072,1,10,'',0,''),(5613,27069,1,10,'',0,''),(5614,27599,1,10,'',0,''),(5615,27599,2,1,'8',0,''),(5616,27602,1,10,'',0,''),(5617,27602,2,1,'8',0,''),(5618,27598,1,10,'',0,''),(5619,27601,1,10,'',0,''),(5620,27600,1,10,'',0,''),(5621,27597,1,10,'',0,''),(5622,28008,1,10,'',0,''),(5623,28008,2,1,'8',0,''),(5624,28011,1,10,'',0,''),(5625,28011,2,1,'8',0,''),(5626,28007,1,10,'',0,''),(5627,28010,1,10,'',0,''),(5628,28009,1,10,'',0,''),(5629,28006,1,10,'',0,''),(5630,27084,1,10,'',0,''),(5631,27084,2,1,'8',0,''),(5632,27085,1,10,'',0,''),(5633,27085,2,1,'8',0,''),(5634,27086,1,10,'',0,''),(5635,27083,1,10,'',0,''),(5636,27082,1,10,'',0,''),(5637,27079,1,10,'',0,''),(5638,27622,1,10,'',0,''),(5639,27622,2,1,'8',0,''),(5640,27625,1,10,'',0,''),(5641,27625,2,1,'8',0,''),(5642,27621,1,10,'',0,''),(5643,27624,1,10,'',0,''),(5644,27623,1,10,'',0,''),(5645,27620,1,10,'',0,''),(5646,27979,1,10,'',0,''),(5647,27979,2,1,'8',0,''),(5648,27982,1,10,'',0,''),(5649,27982,2,1,'8',0,''),(5650,27978,1,10,'',0,''),(5651,27981,1,10,'',0,''),(5652,27980,1,10,'',0,''),(5653,27977,1,10,'',0,''),(5654,27094,1,10,'',0,''),(5655,27094,2,1,'8',0,''),(5656,27095,1,10,'',0,''),(5657,27095,2,1,'8',0,''),(5658,27096,1,10,'',0,''),(5659,27093,1,10,'',0,''),(5660,27092,1,10,'',0,''),(5661,27089,1,10,'',0,''),(5662,27091,1,1,'1000000',0,''),(5663,27104,1,10,'',0,''),(5664,27104,2,1,'8',0,''),(5665,27105,1,10,'',0,''),(5666,27105,2,1,'8',0,''),(5667,27106,1,10,'',0,''),(5668,27103,1,10,'',0,''),(5669,27102,1,10,'',0,''),(5670,27099,1,10,'',0,''),(5671,27101,1,1,'1000000',0,''),(5672,27183,1,10,'',0,''),(5673,27183,2,1,'8',0,''),(5674,27186,1,10,'',0,''),(5675,27186,2,1,'8',0,''),(5676,27182,1,10,'',0,''),(5677,27185,1,10,'',0,''),(5678,27184,1,10,'',0,''),(5679,27181,1,10,'',0,''),(5680,27187,1,1,'1000000',0,''),(5681,27218,1,10,'',0,''),(5682,27218,2,1,'8',0,''),(5683,27221,1,10,'',0,''),(5684,27221,2,1,'8',0,''),(5685,27217,1,10,'',0,''),(5686,27220,1,10,'',0,''),(5687,27219,1,10,'',0,''),(5688,27216,1,10,'',0,''),(5689,27222,1,1,'1000000',0,''),(5690,27254,1,10,'',0,''),(5691,27254,2,1,'8',0,''),(5692,27257,1,10,'',0,''),(5693,27257,2,1,'8',0,''),(5694,27253,1,10,'',0,''),(5695,27256,1,10,'',0,''),(5696,27255,1,10,'',0,''),(5697,27252,1,10,'',0,''),(5698,27258,1,1,'1000000',0,''),(5699,27275,1,10,'',0,''),(5700,27275,2,1,'8',0,''),(5701,27278,1,10,'',0,''),(5702,27278,2,1,'8',0,''),(5703,27274,1,10,'',0,''),(5704,27277,1,10,'',0,''),(5705,27276,1,10,'',0,''),(5706,27273,1,10,'',0,''),(5707,27279,1,1,'1000000',0,''),(5708,27324,1,10,'',0,''),(5709,27324,2,1,'8',0,''),(5710,27327,1,10,'',0,''),(5711,27327,2,1,'8',0,''),(5712,27323,1,10,'',0,''),(5713,27326,1,10,'',0,''),(5714,27325,1,10,'',0,''),(5715,27322,1,10,'',0,''),(5716,27328,1,1,'1000000',0,''),(5717,27453,1,10,'',0,''),(5718,27453,2,1,'8',0,''),(5719,27456,1,10,'',0,''),(5720,27456,2,1,'8',0,''),(5721,27452,1,10,'',0,''),(5722,27455,1,10,'',0,''),(5723,27454,1,10,'',0,''),(5724,27451,1,10,'',0,''),(5725,27457,1,1,'1000000',0,''),(5726,27489,1,10,'',0,''),(5727,27489,2,1,'8',0,''),(5728,27492,1,10,'',0,''),(5729,27492,2,1,'8',0,''),(5730,27488,1,10,'',0,''),(5731,27491,1,10,'',0,''),(5732,27490,1,10,'',0,''),(5733,27487,1,10,'',0,''),(5734,27493,1,1,'1000000',0,''),(5735,27523,1,10,'',0,''),(5736,27523,2,1,'8',0,''),(5737,27526,1,10,'',0,''),(5738,27526,2,1,'8',0,''),(5739,27522,1,10,'',0,''),(5740,27525,1,10,'',0,''),(5741,27524,1,10,'',0,''),(5742,27521,1,10,'',0,''),(5743,27527,1,1,'1000000',0,''),(5744,27559,1,10,'',0,''),(5745,27559,2,1,'8',0,''),(5746,27562,1,10,'',0,''),(5747,27562,2,1,'8',0,''),(5748,27558,1,10,'',0,''),(5749,27561,1,10,'',0,''),(5750,27560,1,10,'',0,''),(5751,27557,1,10,'',0,''),(5752,27563,1,1,'1000000',0,''),(5753,27645,1,10,'',0,''),(5754,27645,2,1,'8',0,''),(5755,27648,1,10,'',0,''),(5756,27648,2,1,'8',0,''),(5757,27644,1,10,'',0,''),(5758,27647,1,10,'',0,''),(5759,27646,1,10,'',0,''),(5760,27643,1,10,'',0,''),(5761,27649,1,1,'1000000',0,''),(5762,27725,1,10,'',0,''),(5763,27725,2,1,'8',0,''),(5764,27728,1,10,'',0,''),(5765,27728,2,1,'8',0,''),(5766,27724,1,10,'',0,''),(5767,27727,1,10,'',0,''),(5768,27726,1,10,'',0,''),(5769,27723,1,10,'',0,''),(5770,27729,1,1,'1000000',0,''),(5771,27759,1,10,'',0,''),(5772,27759,2,1,'8',0,''),(5773,27762,1,10,'',0,''),(5774,27762,2,1,'8',0,''),(5775,27758,1,10,'',0,''),(5776,27761,1,10,'',0,''),(5777,27760,1,10,'',0,''),(5778,27757,1,10,'',0,''),(5779,27763,1,1,'1000000',0,''),(5780,27791,1,10,'',0,''),(5781,27791,2,1,'8',0,''),(5782,27794,1,10,'',0,''),(5783,27794,2,1,'8',0,''),(5784,27790,1,10,'',0,''),(5785,27793,1,10,'',0,''),(5786,27792,1,10,'',0,''),(5787,27789,1,10,'',0,''),(5788,27795,1,1,'1000000',0,''),(5789,27875,1,10,'',0,''),(5790,27875,2,1,'8',0,''),(5791,27878,1,10,'',0,''),(5792,27878,2,1,'8',0,''),(5793,27874,1,10,'',0,''),(5794,27877,1,10,'',0,''),(5795,27876,1,10,'',0,''),(5796,27873,1,10,'',0,''),(5797,27879,1,1,'1000000',0,''),(5798,27912,1,10,'',0,''),(5799,27912,2,1,'8',0,''),(5800,27915,1,10,'',0,''),(5801,27915,2,1,'8',0,''),(5802,27911,1,10,'',0,''),(5803,27914,1,10,'',0,''),(5804,27913,1,10,'',0,''),(5805,27910,1,10,'',0,''),(5806,27916,1,1,'1000000',0,''),(5807,27947,1,10,'',0,''),(5808,27947,2,1,'8',0,''),(5809,27950,1,10,'',0,''),(5810,27950,2,1,'8',0,''),(5811,27946,1,10,'',0,''),(5812,27949,1,10,'',0,''),(5813,27948,1,10,'',0,''),(5814,27945,1,10,'',0,''),(5815,27951,1,1,'1000000',0,''),(5816,28061,1,10,'',0,''),(5817,28061,2,1,'8',0,''),(5818,28064,1,10,'',0,''),(5819,28064,2,1,'8',0,''),(5820,28060,1,10,'',0,''),(5821,28063,1,10,'',0,''),(5822,28062,1,10,'',0,''),(5823,28059,1,10,'',0,''),(5824,28065,1,1,'1000000',0,''),(5825,28121,1,10,'',0,''),(5826,28121,2,1,'8',0,''),(5827,28124,1,10,'',0,''),(5828,28124,2,1,'8',0,''),(5829,28120,1,10,'',0,''),(5830,28123,1,10,'',0,''),(5831,28122,1,10,'',0,''),(5832,28119,1,10,'',0,''),(5833,28125,1,1,'1000000',0,''),(5834,28178,1,10,'',0,''),(5835,28178,2,1,'8',0,''),(5836,28181,1,10,'',0,''),(5837,28181,2,1,'8',0,''),(5838,28177,1,10,'',0,''),(5839,28180,1,10,'',0,''),(5840,28179,1,10,'',0,''),(5841,28176,1,10,'',0,''),(5842,28182,1,1,'1000000',0,''),(5843,28226,1,10,'',0,''),(5844,28226,2,1,'8',0,''),(5845,28229,1,10,'',0,''),(5846,28229,2,1,'8',0,''),(5847,28225,1,10,'',0,''),(5848,28228,1,10,'',0,''),(5849,28227,1,10,'',0,''),(5850,28224,1,10,'',0,''),(5851,28230,1,1,'1000000',0,''),(5852,28296,1,10,'',0,''),(5853,28296,2,1,'8',0,''),(5854,28299,1,10,'',0,''),(5855,28299,2,1,'8',0,''),(5856,28295,1,10,'',0,''),(5857,28298,1,10,'',0,''),(5858,28297,1,10,'',0,''),(5859,28294,1,10,'',0,''),(5860,28300,1,1,'1000000',0,''),(5861,27124,1,10,'',0,''),(5862,27124,2,1,'8',0,''),(5863,27125,1,10,'',0,''),(5864,27125,2,1,'8',0,''),(5865,27126,1,10,'',0,''),(5866,27123,1,10,'',0,''),(5867,27122,1,10,'',0,''),(5868,27119,1,10,'',0,''),(5869,27121,1,1,'1000000',0,''),(5870,28100,1,10,'',0,''),(5871,28100,2,1,'8',0,''),(5872,28103,1,10,'',0,''),(5873,28103,2,1,'8',0,''),(5874,28099,1,10,'',0,''),(5875,28102,1,10,'',0,''),(5876,28101,1,10,'',0,''),(5877,28098,1,10,'',0,''),(5878,28104,1,1,'1000000',0,''),(5879,28540,1,12,'$.queue',0,''),(5880,28541,1,12,'$.queue',0,''),(5881,28542,1,12,'$.data.wcache.index.pused',0,''),(5882,28543,1,12,'$.data.rcache.pused',0,''),(5883,28544,1,12,'$.data.vcache.buffer.pused',0,''),(5884,28545,1,12,'$.data.vcache.cache.hits',0,''),(5885,28545,2,10,'',0,''),(5886,28546,1,12,'$.data.vcache.cache.misses',0,''),(5887,28546,2,10,'',0,''),(5888,28547,1,12,'$.data.vcache.cache.mode',0,''),(5889,28548,1,12,'$.data.vmware.pused',0,''),(5890,28549,1,12,'$.data.wcache.history.pused',0,''),(5891,28550,1,12,'$.data.wcache.values.all',0,''),(5892,28550,2,10,'',0,''),(5893,28551,1,12,'$.data.wcache.trend.pused',0,''),(5894,28552,1,12,'$.data.process[\'unreachable poller\'].busy.avg',0,''),(5895,28553,1,12,'$.data.wcache.values.float',0,''),(5896,28553,2,10,'',0,''),(5897,28554,1,12,'$.data.wcache.values.log',0,''),(5898,28554,2,10,'',0,''),(5899,28555,1,12,'$.data.wcache.values[\'not supported\']',0,''),(5900,28555,2,10,'',0,''),(5901,28556,1,12,'$.data.wcache.values.str',0,''),(5902,28556,2,10,'',0,''),(5903,28557,1,12,'$.data.wcache.values.text',0,''),(5904,28557,2,10,'',0,''),(5905,28558,1,12,'$.data.wcache.values.uint',0,''),(5906,28558,2,10,'',0,''),(5907,28559,1,12,'$.data.process[\'vmware collector\'].busy.avg',0,''),(5908,28560,1,12,'$.data.preprocessing_queue',0,''),(5909,28561,1,12,'$.data.process.alerter.busy.avg',0,''),(5910,28562,1,12,'$.data.process[\'ipmi manager\'].busy.avg',0,''),(5911,28563,1,12,'$.data.process[\'alert manager\'].busy.avg',0,''),(5912,28564,1,12,'$.data.process[\'configuration syncer\'].busy.avg',0,''),(5913,28565,1,12,'$.data.process.discoverer.busy.avg',0,''),(5914,28566,1,12,'$.data.process.escalator.busy.avg',0,''),(5915,28567,1,12,'$.data.process[\'history syncer\'].busy.avg',0,''),(5916,28568,1,12,'$.data.process.housekeeper.busy.avg',0,''),(5917,28569,1,12,'$.data.process[\'http poller\'].busy.avg',0,''),(5918,28570,1,12,'$.data.process[\'icmp pinger\'].busy.avg',0,''),(5919,28571,1,12,'$.data.process[\'ipmi poller\'].busy.avg',0,''),(5920,28572,1,12,'$.data.process.timer.busy.avg',0,''),(5921,28573,1,12,'$.data.process[\'java poller\'].busy.avg',0,''),(5922,28574,1,12,'$.data.process.poller.busy.avg',0,''),(5923,28575,1,12,'$.data.process[\'preprocessing manager\'].busy.avg',0,''),(5924,28576,1,12,'$.data.process[\'preprocessing worker\'].busy.avg',0,''),(5925,28577,1,12,'$.data.process[\'proxy poller\'].busy.avg',0,''),(5926,28578,1,12,'$.data.process[\'self-monitoring\'].busy.avg',0,''),(5927,28579,1,12,'$.data.process[\'snmp trapper\'].busy.avg',0,''),(5928,28580,1,12,'$.data.process[\'task manager\'].busy.avg',0,''),(5929,28581,1,12,'$.data.process.trapper.busy.avg',0,''),(5930,28582,1,12,'$.data.process[\'lld manager\'].busy.avg',0,''),(5931,28583,1,12,'$.data.process[\'lld worker\'].busy.avg',0,''),(5932,28584,1,12,'$.data.lld_queue',0,''),(5933,28586,1,12,'$.queue',0,''),(5934,28587,1,12,'$.queue',0,''),(5935,28588,1,12,'$.data.process[\'vmware collector\'].busy.avg',0,''),(5936,28589,1,12,'$.data.wcache.values.uint',0,''),(5937,28589,2,10,'',0,''),(5938,28590,1,12,'$.data.wcache.values.text',0,''),(5939,28590,2,10,'',0,''),(5940,28591,1,12,'$.data.wcache.values.str',0,''),(5941,28591,2,10,'',0,''),(5942,28592,1,12,'$.data.wcache.values[\'not supported\']',0,''),(5943,28592,2,10,'',0,''),(5944,28593,1,12,'$.data.wcache.values.log',0,''),(5945,28593,2,10,'',0,''),(5946,28594,1,12,'$.data.wcache.values.float',0,''),(5947,28594,2,10,'',0,''),(5948,28595,1,12,'$.data.wcache.values.all',0,''),(5949,28595,2,10,'',0,''),(5950,28596,1,12,'$.data.wcache.index.pused',0,''),(5951,28597,1,12,'$.data.wcache.history.pused',0,''),(5952,28598,1,12,'$.data.vmware.pused',0,''),(5953,28599,1,12,'$.data.rcache.pused',0,''),(5954,28600,1,12,'$.data.process[\'configuration syncer\'].busy.avg',0,''),(5955,28601,1,12,'$.data.process[\'data sender\'].busy.avg',0,''),(5956,28602,1,12,'$.data.process.trapper.busy.avg',0,''),(5957,28603,1,12,'$.data.process[\'task manager\'].busy.avg',0,''),(5958,28604,1,12,'$.data.process[\'snmp trapper\'].busy.avg',0,''),(5959,28605,1,12,'$.data.process[\'self-monitoring\'].busy.avg',0,''),(5960,28606,1,12,'$.data.process.poller.busy.avg',0,''),(5961,28607,1,12,'$.data.process[\'java poller\'].busy.avg',0,''),(5962,28608,1,12,'$.data.process[\'ipmi poller\'].busy.avg',0,''),(5963,28609,1,12,'$.data.process[\'ipmi manager\'].busy.avg',0,''),(5964,28610,1,12,'$.data.process[\'icmp pinger\'].busy.avg',0,''),(5965,28611,1,12,'$.data.process[\'http poller\'].busy.avg',0,''),(5966,28612,1,12,'$.data.process.housekeeper.busy.avg',0,''),(5967,28613,1,12,'$.data.process[\'history syncer\'].busy.avg',0,''),(5968,28614,1,12,'$.data.process[\'heartbeat sender\'].busy.avg',0,''),(5969,28615,1,12,'$.data.process.discoverer.busy.avg',0,''),(5970,28616,1,12,'$.data.process[\'unreachable poller\'].busy.avg',0,'');
/*!40000 ALTER TABLE `item_preproc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `snmp_community` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmp_oid` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `key_` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `delay` varchar(1024) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `history` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '90d',
  `trends` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '365d',
  `status` int(11) NOT NULL DEFAULT '0',
  `value_type` int(11) NOT NULL DEFAULT '0',
  `trapper_hosts` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `units` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmpv3_securityname` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmpv3_securitylevel` int(11) NOT NULL DEFAULT '0',
  `snmpv3_authpassphrase` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmpv3_privpassphrase` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `formula` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `lastlogsize` bigint(20) unsigned NOT NULL DEFAULT '0',
  `logtimefmt` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `valuemapid` bigint(20) unsigned DEFAULT NULL,
  `params` text COLLATE utf8_bin NOT NULL,
  `ipmi_sensor` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `authtype` int(11) NOT NULL DEFAULT '0',
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `password` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `publickey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `privatekey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  `interfaceid` bigint(20) unsigned DEFAULT NULL,
  `port` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` text COLLATE utf8_bin NOT NULL,
  `inventory_link` int(11) NOT NULL DEFAULT '0',
  `lifetime` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '30d',
  `snmpv3_authprotocol` int(11) NOT NULL DEFAULT '0',
  `snmpv3_privprotocol` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `snmpv3_contextname` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `evaltype` int(11) NOT NULL DEFAULT '0',
  `jmx_endpoint` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_itemid` bigint(20) unsigned DEFAULT NULL,
  `timeout` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '3s',
  `url` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `query_fields` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `posts` text COLLATE utf8_bin NOT NULL,
  `status_codes` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '200',
  `follow_redirects` int(11) NOT NULL DEFAULT '1',
  `post_type` int(11) NOT NULL DEFAULT '0',
  `http_proxy` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `headers` text COLLATE utf8_bin NOT NULL,
  `retrieve_mode` int(11) NOT NULL DEFAULT '0',
  `request_method` int(11) NOT NULL DEFAULT '0',
  `output_format` int(11) NOT NULL DEFAULT '0',
  `ssl_cert_file` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ssl_key_file` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ssl_key_password` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `verify_peer` int(11) NOT NULL DEFAULT '0',
  `verify_host` int(11) NOT NULL DEFAULT '0',
  `allow_traps` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemid`),
  UNIQUE KEY `items_1` (`hostid`,`key_`),
  KEY `items_3` (`status`),
  KEY `items_4` (`templateid`),
  KEY `items_5` (`valuemapid`),
  KEY `items_6` (`interfaceid`),
  KEY `items_7` (`master_itemid`),
  CONSTRAINT `c_items_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_2` FOREIGN KEY (`templateid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_3` FOREIGN KEY (`valuemapid`) REFERENCES `valuemaps` (`valuemapid`),
  CONSTRAINT `c_items_4` FOREIGN KEY (`interfaceid`) REFERENCES `interface` (`interfaceid`),
  CONSTRAINT `c_items_5` FOREIGN KEY (`master_itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_applications`
--

DROP TABLE IF EXISTS `items_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items_applications` (
  `itemappid` bigint(20) unsigned NOT NULL,
  `applicationid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`itemappid`),
  UNIQUE KEY `items_applications_1` (`applicationid`,`itemid`),
  KEY `items_applications_2` (`itemid`),
  CONSTRAINT `c_items_applications_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_applications_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_applications`
--

LOCK TABLES `items_applications` WRITE;
/*!40000 ALTER TABLE `items_applications` DISABLE KEYS */;
INSERT INTO `items_applications` VALUES (21474,1,10016),(21477,1,10025),(21495,1,10055),(21469,1,10056),(21486,1,10057),(21479,1,10058),(21517,1,17318),(21484,1,17352),(21576,5,22452),(21575,5,22454),(21578,5,22456),(21579,5,22458),(21577,5,22686),(21573,7,22446),(21574,7,22448),(21518,9,10009),(21519,9,10013),(21512,13,10010),(21500,13,17354),(21487,13,17356),(21493,13,17358),(21489,13,17360),(21496,13,17362),(21491,13,22665),(21470,13,22668),(21498,13,22671),(21510,13,22674),(21508,13,22677),(21506,13,22680),(21514,13,22683),(21504,13,28497),(21502,13,28499),(21482,15,10014),(21520,15,10026),(21480,15,10030),(21481,15,17350),(21472,15,22181),(21513,17,10010),(21501,17,17354),(21488,17,17356),(21494,17,17358),(21490,17,17360),(21497,17,17362),(21492,17,22665),(21471,17,22668),(21499,17,22671),(21511,17,22674),(21509,17,22677),(21507,17,22680),(21515,17,22683),(21505,17,28497),(21503,17,28499),(21476,21,10025),(21485,21,10057),(21478,21,10058),(21516,21,17318),(21483,21,17352),(21475,23,10016),(21473,23,10019),(21227,179,10061),(21230,179,10062),(21228,179,10063),(21232,179,10064),(21231,179,10065),(21229,179,10066),(21223,179,22183),(21226,179,22185),(21255,179,22187),(21218,179,22189),(21219,179,22191),(21220,179,22196),(21221,179,22199),(21216,179,22219),(21225,179,22396),(21248,179,22399),(21224,179,22400),(21233,179,22401),(21243,179,22402),(21234,179,22404),(21241,179,22406),(21242,179,22408),(21238,179,22412),(21252,179,22414),(21245,179,22416),(21244,179,22418),(21251,179,22420),(21240,179,22422),(21235,179,22424),(21246,179,22426),(21239,179,22430),(21247,179,22689),(21253,179,23171),(21217,179,23251),(21215,179,23634),(21222,179,23661),(21254,179,23663),(21236,179,25366),(21237,179,25370),(21249,179,25665),(21250,179,25666),(21214,179,28248),(21827,179,28533),(21829,179,28535),(21831,179,28537),(21155,206,22231),(21154,206,22232),(21153,206,23318),(21157,207,10020),(21158,207,10059),(21156,207,23319),(21160,252,22833),(21161,252,22834),(21159,252,23320),(21652,253,22840),(21646,253,22841),(21650,253,22842),(21648,253,22843),(21644,253,22844),(21642,253,22845),(21640,253,22846),(21638,253,22848),(21635,253,22851),(21618,253,22852),(21662,254,22868),(21661,254,22869),(21664,254,22870),(21665,254,22871),(21663,254,22872),(21654,255,22839),(21633,255,22853),(21631,255,22854),(21626,255,22858),(21624,255,22859),(21630,256,22855),(21629,256,22856),(21628,256,22857),(21620,256,22862),(21658,256,22863),(21659,257,23075),(21660,257,23076),(21617,258,22835),(21637,258,22836),(21655,258,22839),(21634,258,22853),(21632,258,22854),(21627,258,22858),(21625,258,22859),(21622,258,22860),(21653,259,22840),(21647,259,22841),(21651,259,22842),(21649,259,22843),(21645,259,22844),(21643,259,22845),(21641,259,22846),(21639,259,22848),(21636,259,22851),(21619,259,22852),(21657,260,22837),(21656,260,22838),(21623,261,22860),(21621,261,22861),(21163,262,22873),(21164,262,22874),(21162,262,23321),(21423,263,22880),(21417,263,22881),(21421,263,22882),(21419,263,22883),(21415,263,22884),(21413,263,22885),(21411,263,22886),(21409,263,22888),(21406,263,22891),(21389,263,22892),(21433,264,22908),(21432,264,22909),(21435,264,22910),(21436,264,22911),(21434,264,22912),(21425,265,22879),(21404,265,22893),(21402,265,22894),(21397,265,22898),(21395,265,22899),(21401,266,22895),(21400,266,22896),(21399,266,22897),(21391,266,22902),(21429,266,22903),(21430,267,23073),(21431,267,23074),(21388,268,22875),(21408,268,22876),(21426,268,22879),(21405,268,22893),(21403,268,22894),(21398,268,22898),(21396,268,22899),(21393,268,22900),(21424,269,22880),(21418,269,22881),(21422,269,22882),(21420,269,22883),(21416,269,22884),(21414,269,22885),(21412,269,22886),(21410,269,22888),(21407,269,22891),(21390,269,22892),(21428,270,22877),(21427,270,22878),(21394,271,22900),(21392,271,22901),(21166,272,22913),(21167,272,22914),(21165,272,23322),(21345,273,22920),(21351,273,22921),(21347,273,22922),(21349,273,22923),(21353,273,22924),(21342,273,23108),(21359,273,23109),(21364,273,23110),(21366,273,23111),(21369,273,23112),(21372,273,23113),(21374,273,23114),(21376,273,23115),(21339,273,23118),(21325,273,23119),(21337,273,23120),(21314,273,23121),(21318,273,23123),(21384,274,22948),(21383,274,22949),(21386,274,22950),(21387,274,22951),(21385,274,22952),(21378,274,23116),(21362,274,23117),(21355,275,22933),(21357,275,22934),(21329,275,22938),(21331,275,22939),(21336,276,22942),(21380,276,22943),(21316,276,23122),(21320,276,23124),(21321,276,23125),(21322,276,23126),(21323,276,23127),(21313,276,23128),(21324,276,23129),(21327,276,23130),(21328,276,23131),(21381,277,22945),(21382,277,22946),(21356,278,22933),(21358,278,22934),(21330,278,22938),(21332,278,22939),(21333,278,22940),(21346,279,22920),(21352,279,22921),(21348,279,22922),(21350,279,22923),(21354,279,22924),(21344,279,23108),(21361,279,23109),(21365,279,23110),(21368,279,23111),(21371,279,23112),(21373,279,23113),(21375,279,23114),(21377,279,23115),(21379,279,23116),(21363,279,23117),(21326,279,23119),(21338,279,23120),(21315,279,23121),(21317,279,23122),(21319,279,23123),(21312,280,22917),(21341,280,22918),(21334,281,22940),(21335,281,22941),(21169,282,22953),(21170,282,22954),(21168,282,23323),(21441,283,22961),(21437,283,22962),(21439,283,22963),(21443,283,22965),(21445,283,22968),(21447,283,22971),(21449,283,22972),(21465,284,22988),(21464,284,22989),(21467,284,22990),(21468,284,22991),(21466,284,22992),(21451,285,22973),(21453,285,22974),(21455,285,22978),(21460,286,22982),(21461,286,22983),(21462,287,22985),(21463,287,22986),(21452,288,22973),(21454,288,22974),(21456,288,22978),(21457,288,22980),(21442,289,22961),(21438,289,22962),(21440,289,22963),(21444,289,22965),(21446,289,22968),(21448,289,22971),(21450,289,22972),(21458,291,22980),(21459,291,22981),(21172,292,22993),(21173,292,22994),(21171,292,23324),(21699,293,23000),(21693,293,23001),(21697,293,23002),(21695,293,23003),(21691,293,23004),(21689,293,23005),(21687,293,23007),(21685,293,23011),(21682,293,23012),(21708,294,23028),(21707,294,23029),(21710,294,23030),(21711,294,23031),(21709,294,23032),(21701,295,22999),(21667,295,23013),(21680,295,23014),(21675,295,23018),(21673,295,23019),(21679,296,23015),(21678,296,23016),(21677,296,23017),(21669,296,23022),(21704,296,23023),(21705,297,23025),(21706,297,23026),(21666,298,22996),(21702,298,22999),(21668,298,23013),(21681,298,23014),(21676,298,23018),(21674,298,23019),(21671,298,23020),(21700,299,23000),(21694,299,23001),(21698,299,23002),(21696,299,23003),(21692,299,23004),(21690,299,23005),(21688,299,23007),(21686,299,23011),(21683,299,23012),(21684,300,22997),(21703,300,22998),(21672,301,23020),(21670,301,23021),(21175,302,23033),(21176,302,23034),(21174,302,23325),(21597,303,23041),(21593,303,23042),(21595,303,23043),(21613,304,23068),(21612,304,23069),(21615,304,23070),(21616,304,23071),(21614,304,23072),(21591,305,23039),(21599,305,23053),(21601,305,23054),(21603,305,23058),(21605,305,23059),(21610,306,23062),(21611,306,23063),(21589,307,23077),(21590,307,23078),(21587,308,23035),(21588,308,23036),(21592,308,23039),(21600,308,23053),(21602,308,23054),(21604,308,23058),(21606,308,23059),(21607,308,23060),(21598,309,23041),(21594,309,23042),(21596,309,23043),(21608,311,23060),(21609,311,23061),(21730,319,23149),(21732,319,23150),(21718,320,23134),(21720,320,23135),(21713,320,23136),(21715,320,23137),(21723,320,23143),(21727,320,23144),(21725,320,23145),(21738,321,23666),(21717,322,23134),(21719,322,23135),(21712,322,23136),(21714,322,23137),(21739,322,23164),(21740,322,23165),(21741,322,23167),(21742,322,23168),(21716,323,23138),(21731,323,23149),(21721,324,23140),(21722,325,23143),(21726,325,23144),(21724,325,23145),(21728,328,23147),(21729,328,23148),(21733,328,23158),(21734,328,23159),(21735,328,23668),(21178,329,23160),(21179,329,23161),(21177,329,23326),(21736,330,23169),(21737,330,23170),(21343,331,23108),(21360,331,23109),(21367,331,23111),(21370,331,23112),(21340,331,23118),(21269,345,10073),(21272,345,10074),(21270,345,10075),(21274,345,10076),(21273,345,10077),(21271,345,10078),(21277,345,23252),(21280,345,23253),(21281,345,23255),(21282,345,23256),(21283,345,23257),(21284,345,23258),(21285,345,23259),(21286,345,23260),(21287,345,23261),(21289,345,23262),(21290,345,23264),(21293,345,23265),(21294,345,23266),(21295,345,23267),(21288,345,23268),(21276,345,23269),(21266,345,23270),(21258,345,23271),(21259,345,23272),(21260,345,23273),(21265,345,23274),(21267,345,23275),(21268,345,23276),(21297,345,23277),(21275,345,23328),(21261,345,23620),(21262,345,23625),(21263,345,23628),(21257,345,23635),(21264,345,23662),(21296,345,23664),(21278,345,25367),(21279,345,25371),(21291,345,25667),(21292,345,25668),(21256,345,28249),(21828,345,28534),(21830,345,28536),(21832,345,28538),(21566,346,23294),(21560,346,23295),(21564,346,23296),(21562,346,23297),(21558,346,23298),(21552,346,23299),(21550,346,23300),(21548,346,23301),(21545,346,23302),(21522,346,23303),(21543,346,23304),(21541,346,23305),(21539,346,23306),(21556,346,28498),(21554,346,28500),(21582,347,23282),(21583,347,23283),(21584,347,23284),(21585,347,23285),(21586,347,23286),(21568,348,23293),(21537,348,23307),(21535,348,23308),(21530,348,23312),(21528,348,23313),(21534,349,23309),(21533,349,23310),(21532,349,23311),(21524,349,23316),(21572,349,23317),(21580,350,23280),(21581,350,23281),(21521,351,23289),(21547,351,23290),(21569,351,23293),(21538,351,23307),(21536,351,23308),(21531,351,23312),(21529,351,23313),(21526,351,23314),(21567,352,23294),(21561,352,23295),(21565,352,23296),(21563,352,23297),(21559,352,23298),(21553,352,23299),(21551,352,23300),(21549,352,23301),(21546,352,23302),(21523,352,23303),(21544,352,23304),(21542,352,23305),(21540,352,23306),(21557,352,28498),(21555,352,28500),(21571,353,23291),(21570,353,23292),(21527,354,23314),(21525,354,23315),(21181,355,23287),(21182,355,23288),(21180,355,23327),(21920,356,10067),(21917,356,10068),(21919,356,10069),(21915,356,10070),(21916,356,10071),(21918,356,10072),(21944,356,23340),(21921,356,23341),(21922,356,23342),(21943,356,23343),(21939,356,23344),(21914,356,23345),(21928,356,23346),(21930,356,23347),(21942,356,23348),(21941,356,23349),(21935,356,23350),(21934,356,23351),(21933,356,23352),(21936,356,23353),(21937,356,23354),(21940,356,23355),(21931,356,23356),(21924,356,23357),(21925,356,23358),(21926,356,23359),(21932,356,23360),(21938,356,25368),(21929,356,25369),(21927,356,28250),(21923,356,28251),(21911,356,28617),(21912,356,28618),(21913,356,28619),(21087,446,23644),(21143,447,23645),(21144,448,23646),(21145,449,23647),(21146,450,23648),(21147,451,23649),(21148,452,23650),(21149,453,23651),(21150,454,23652),(21151,455,23653),(21152,456,23654),(21118,732,26891),(21116,732,26892),(21088,732,26910),(21119,733,26893),(21120,733,26894),(21125,734,26884),(21124,734,26885),(21126,734,26886),(21127,734,26887),(21128,734,26888),(21123,734,26889),(21122,734,26890),(21121,734,26895),(21117,734,26896),(21129,734,26897),(21132,734,26905),(21131,734,26906),(21139,735,26898),(21138,735,26899),(21137,735,26903),(21136,735,26904),(21133,735,26907),(21134,735,26908),(21135,735,26909),(21097,736,26856),(21096,736,26857),(21098,736,26858),(21099,736,26859),(21100,736,26860),(21095,736,26861),(21094,736,26862),(21090,736,26863),(21114,736,26864),(21091,736,26865),(21092,736,26866),(21093,736,26867),(21089,736,26868),(21101,736,26869),(21104,736,26877),(21103,736,26878),(21102,736,26882),(21115,736,26883),(21140,736,26900),(21141,736,26901),(21130,736,26902),(21105,737,26879),(21106,737,26880),(21107,737,26881),(21110,738,26871),(21109,738,26875),(21108,738,26876),(21111,739,26870),(21112,739,26872),(21113,739,26873),(21142,739,26874),(21307,740,26911),(21306,740,26912),(21308,740,26913),(21309,740,26914),(21311,740,26915),(21310,740,26916),(21305,740,26917),(21304,740,26918),(21300,740,26919),(21299,740,26920),(21301,740,26921),(21302,740,26922),(21303,740,26923),(21298,740,26924),(21750,741,26927),(21747,742,26928),(21748,743,26925),(21749,743,26926),(21746,743,26929),(21744,743,26930),(21745,743,26931),(21743,743,26932),(21760,744,26935),(21761,744,26936),(21758,745,26933),(21751,745,26943),(21759,746,26934),(21757,746,26937),(21756,746,26938),(21752,746,26939),(21753,746,26940),(21754,746,26941),(21755,746,26942),(22354,747,26994),(22302,748,26944),(22303,748,26945),(22304,749,26946),(22315,750,26957),(22316,750,26958),(22317,750,26959),(22359,751,26999),(22360,751,27000),(22361,751,27001),(22362,751,27002),(22363,752,27003),(22364,752,27004),(22365,752,27005),(22366,752,27006),(22308,753,26950),(22310,753,26952),(22318,753,26960),(22319,753,26961),(22323,753,26965),(22355,754,26995),(22356,754,26996),(22357,754,26997),(22358,754,26998),(22305,755,26947),(22306,755,26948),(22307,755,26949),(22313,755,26955),(22314,755,26956),(22320,755,26962),(22321,755,26963),(22322,755,26964),(22309,757,26951),(22311,757,26953),(22312,757,26954),(22335,758,26977),(22339,758,26980),(22340,758,26981),(22342,758,26982),(22347,758,26985),(22367,759,27007),(22368,759,27008),(22369,759,27009),(22370,759,27010),(22328,760,26970),(22329,760,26971),(22330,760,26972),(22331,760,26973),(22332,760,26974),(22337,760,26978),(22338,760,26979),(22349,760,26986),(22333,761,26975),(22334,761,26976),(22336,761,26977),(22341,761,26981),(22343,761,26982),(22344,761,26983),(22345,761,26984),(22348,761,26985),(22326,762,26968),(22327,762,26969),(22346,762,26984),(22324,763,26966),(22325,763,26967),(19309,770,27030),(19311,771,27032),(19551,772,27040),(19550,772,27041),(19549,772,27042),(19557,772,27046),(19556,772,27047),(19555,772,27048),(19553,773,27037),(19554,773,27038),(19552,773,27039),(19559,774,27043),(19560,774,27044),(19558,774,27045),(19548,775,27036),(19564,776,27056),(19563,776,27057),(19562,776,27058),(19570,776,27062),(19569,776,27063),(19568,776,27064),(19566,777,27053),(19567,777,27054),(19565,777,27055),(19572,778,27059),(19573,778,27060),(19571,778,27061),(19561,779,27052),(19224,780,27065),(19223,780,27066),(19222,780,27067),(21951,781,27069),(21952,781,27070),(21953,781,27071),(21950,781,27072),(21949,781,27073),(21946,781,27074),(21947,781,27075),(21948,781,27076),(21945,781,27077),(21978,782,27079),(21979,782,27080),(21980,782,27081),(21977,782,27082),(21976,782,27083),(21973,782,27084),(21974,782,27085),(21975,782,27086),(21972,782,27087),(22005,783,27089),(22006,783,27090),(22007,783,27091),(22004,783,27092),(22003,783,27093),(22000,783,27094),(22001,783,27095),(22002,783,27096),(21999,783,27097),(22014,784,27099),(22015,784,27100),(22016,784,27101),(22013,784,27102),(22012,784,27103),(22009,784,27104),(22010,784,27105),(22011,784,27106),(22008,784,27107),(22212,786,27119),(22213,786,27120),(22214,786,27121),(22211,786,27122),(22210,786,27123),(22207,786,27124),(22208,786,27125),(22209,786,27126),(22206,786,27127),(19225,797,27138),(19226,797,27139),(19227,797,27140),(19333,797,27143),(19324,797,28252),(19331,798,27141),(19332,798,27142),(19330,798,27144),(19329,798,27145),(19327,798,27146),(19328,798,27147),(19228,799,27149),(19229,799,27150),(19230,799,27151),(19379,799,27154),(19348,799,28255),(19377,800,27152),(19378,800,27153),(19376,800,27155),(19375,800,27156),(19373,800,27157),(19374,800,27158),(22023,803,27181),(22020,803,27182),(22018,803,27183),(22022,803,27184),(22021,803,27185),(22019,803,27186),(22025,803,27187),(22017,803,27188),(22024,803,27189),(19312,803,27191),(19380,804,27195),(19382,804,27196),(19385,804,27197),(19381,804,27198),(19384,804,27199),(19383,804,27200),(19231,805,27192),(19232,805,27193),(19233,805,27194),(19386,805,27202),(19349,805,28256),(19883,806,27208),(19886,807,27205),(19885,807,27206),(19884,807,27207),(19889,808,27212),(19890,809,27213),(19887,810,27203),(19888,810,27204),(19891,810,27214),(22032,811,27216),(22029,811,27217),(22027,811,27218),(22031,811,27219),(22030,811,27220),(22028,811,27221),(22034,811,27222),(22026,811,27223),(22033,811,27224),(19387,812,27228),(19389,812,27229),(19392,812,27230),(19388,812,27231),(19391,812,27232),(19390,812,27233),(19234,813,27225),(19235,813,27226),(19236,813,27227),(19393,813,27235),(19935,813,27238),(19350,813,28257),(19933,814,27240),(19934,815,27239),(19939,816,27246),(19938,816,27247),(19940,817,27248),(19942,818,27249),(19941,818,27250),(19937,819,27236),(19936,819,27237),(22041,820,27252),(22038,820,27253),(22036,820,27254),(22040,820,27255),(22039,820,27256),(22037,820,27257),(22043,820,27258),(22035,820,27259),(22042,820,27260),(19394,821,27264),(19396,821,27265),(19399,821,27266),(19395,821,27267),(19398,821,27268),(19397,821,27269),(19237,822,27261),(19238,822,27262),(19239,822,27263),(19400,822,27271),(19351,822,28258),(22050,823,27273),(22047,823,27274),(22045,823,27275),(22049,823,27276),(22048,823,27277),(22046,823,27278),(22052,823,27279),(22044,823,27280),(22051,823,27281),(19401,824,27285),(19403,824,27286),(19406,824,27287),(19402,824,27288),(19405,824,27289),(19404,824,27290),(19240,825,27282),(19241,825,27283),(19242,825,27284),(19407,825,27292),(19352,825,28259),(19943,826,27294),(19944,827,27293),(19954,828,27314),(19955,828,27315),(19952,829,27312),(19953,830,27313),(19946,831,27295),(19945,831,27296),(19958,832,27318),(19956,833,27316),(19957,834,27317),(19947,835,27297),(19959,835,27319),(19960,835,27320),(19948,836,27299),(19949,837,27298),(19950,838,27301),(19951,839,27300),(22059,840,27322),(22056,840,27323),(22054,840,27324),(22058,840,27325),(22057,840,27326),(22055,840,27327),(22061,840,27328),(22053,840,27329),(22060,840,27330),(19313,840,27332),(19408,841,27336),(19410,841,27337),(19413,841,27338),(19409,841,27339),(19412,841,27340),(19411,841,27341),(19243,842,27333),(19244,842,27334),(19245,842,27335),(19414,842,27343),(19353,842,28260),(19415,846,27368),(19417,846,27369),(19420,846,27370),(19416,846,27371),(19419,846,27372),(19418,846,27373),(19246,847,27365),(19247,847,27366),(19248,847,27367),(19421,847,27375),(19354,847,28261),(19977,848,27414),(19976,848,27415),(19975,848,27416),(19978,849,27417),(19961,851,27376),(19964,852,27377),(19963,852,27378),(19962,852,27379),(19980,852,27419),(19982,853,27420),(19981,853,27421),(19983,854,27422),(19984,855,27423),(19987,856,27424),(19986,856,27425),(19985,856,27426),(19988,857,27427),(19971,858,27384),(19970,858,27385),(19969,858,27386),(19989,858,27428),(19991,859,27429),(19990,859,27430),(19992,860,27431),(19993,861,27432),(19996,868,27442),(19995,868,27443),(19994,868,27444),(19965,869,27380),(19968,870,27381),(19967,870,27382),(19966,870,27383),(19997,870,27445),(19999,871,27446),(19998,871,27447),(20000,872,27448),(20001,873,27449),(22068,874,27451),(22065,874,27452),(22063,874,27453),(22067,874,27454),(22066,874,27455),(22064,874,27456),(22070,874,27457),(22062,874,27458),(22069,874,27459),(19314,874,27461),(19422,875,27465),(19424,875,27466),(19427,875,27467),(19423,875,27468),(19426,875,27469),(19425,875,27470),(19249,876,27462),(19250,876,27463),(19251,876,27464),(19428,876,27472),(19355,876,28262),(20011,877,27478),(20012,878,27477),(20015,879,27485),(20013,880,27479),(20014,881,27480),(20019,882,27481),(20018,882,27482),(20017,882,27483),(20016,882,27484),(22077,883,27487),(22074,883,27488),(22072,883,27489),(22076,883,27490),(22075,883,27491),(22073,883,27492),(22079,883,27493),(22071,883,27494),(22078,883,27495),(19429,884,27499),(19431,884,27500),(19434,884,27501),(19430,884,27502),(19433,884,27503),(19432,884,27504),(19252,885,27496),(19253,885,27497),(19254,885,27498),(19435,885,27506),(19356,885,28263),(20020,886,27511),(20025,887,27516),(20026,888,27517),(20028,889,27519),(20027,890,27518),(20024,891,27507),(20023,891,27508),(20022,891,27509),(20021,891,27510),(22086,892,27521),(22083,892,27522),(22081,892,27523),(22085,892,27524),(22084,892,27525),(22082,892,27526),(22088,892,27527),(22080,892,27528),(22087,892,27529),(19315,892,27531),(19436,893,27535),(19438,893,27536),(19441,893,27537),(19437,893,27538),(19440,893,27539),(19439,893,27540),(19255,894,27532),(19256,894,27533),(19257,894,27534),(19442,894,27542),(19357,894,28264),(20029,895,27547),(20034,896,27552),(20035,897,27553),(20037,898,27555),(20036,899,27554),(20033,900,27543),(20032,900,27544),(20031,900,27545),(20030,900,27546),(22095,901,27557),(22092,901,27558),(22090,901,27559),(22094,901,27560),(22093,901,27561),(22091,901,27562),(22097,901,27563),(22089,901,27564),(22096,901,27565),(19316,901,27567),(19443,902,27571),(19445,902,27572),(19448,902,27573),(19444,902,27574),(19447,902,27575),(19446,902,27576),(19258,903,27568),(19259,903,27569),(19260,903,27570),(19449,903,27578),(19358,903,28265),(20038,904,27586),(20048,905,27590),(20047,905,27591),(20046,905,27592),(20039,906,27584),(20040,906,27585),(20049,907,27593),(20051,908,27594),(20050,908,27595),(20043,909,27579),(20044,909,27580),(20045,909,27581),(20042,909,27582),(20041,909,27583),(21960,910,27597),(21957,910,27598),(21955,910,27599),(21959,910,27600),(21958,910,27601),(21956,910,27602),(21962,910,27603),(21954,910,27604),(21961,910,27605),(19310,910,27607),(19334,911,27611),(19336,911,27612),(19339,911,27613),(19335,911,27614),(19338,911,27615),(19337,911,27616),(19261,912,27608),(19262,912,27609),(19263,912,27610),(19340,912,27618),(19325,912,28253),(21987,913,27620),(21984,913,27621),(21982,913,27622),(21986,913,27623),(21985,913,27624),(21983,913,27625),(21989,913,27626),(21981,913,27627),(21988,913,27628),(19317,913,27630),(19450,914,27634),(19452,914,27635),(19455,914,27636),(19451,914,27637),(19454,914,27638),(19453,914,27639),(19264,915,27631),(19265,915,27632),(19266,915,27633),(19456,915,27641),(19359,915,28266),(22104,916,27643),(22101,916,27644),(22099,916,27645),(22103,916,27646),(22102,916,27647),(22100,916,27648),(22106,916,27649),(22098,916,27650),(22105,916,27651),(19318,916,27653),(19457,917,27657),(19459,917,27658),(19462,917,27659),(19458,917,27660),(19461,917,27661),(19460,917,27662),(19267,918,27654),(19268,918,27655),(19269,918,27656),(19463,918,27664),(19360,918,28267),(20052,919,27671),(20053,920,27670),(20054,921,27672),(20055,922,27673),(20056,923,27674),(20061,924,27675),(20060,924,27676),(20059,924,27677),(20058,924,27678),(20057,924,27679),(22113,934,27723),(22110,934,27724),(22108,934,27725),(22112,934,27726),(22111,934,27727),(22109,934,27728),(22115,934,27729),(22107,934,27730),(22114,934,27731),(19319,934,27733),(19464,935,27737),(19466,935,27738),(19469,935,27739),(19465,935,27740),(19468,935,27741),(19467,935,27742),(19270,936,27734),(19271,936,27735),(19272,936,27736),(19470,936,27744),(19361,936,28268),(20074,937,27753),(20075,938,27752),(20076,939,27751),(20081,940,27755),(20078,941,27748),(20079,941,27749),(20077,941,27750),(20080,941,27754),(22122,942,27757),(22119,942,27758),(22117,942,27759),(22121,942,27760),(22120,942,27761),(22118,942,27762),(22124,942,27763),(22116,942,27764),(22123,942,27765),(19471,943,27769),(19473,943,27770),(19476,943,27771),(19472,943,27772),(19475,943,27773),(19474,943,27774),(19273,944,27766),(19274,944,27767),(19275,944,27768),(19477,944,27776),(19362,944,28269),(20085,945,27783),(20084,945,27784),(20087,946,27786),(20088,947,27787),(20083,948,27777),(20082,948,27778),(20086,948,27785),(22131,949,27789),(22128,949,27790),(22126,949,27791),(22130,949,27792),(22129,949,27793),(22127,949,27794),(22133,949,27795),(22125,949,27796),(22132,949,27797),(19320,949,27799),(19478,950,27803),(19480,950,27804),(19483,950,27805),(19479,950,27806),(19482,950,27807),(19481,950,27808),(19276,951,27800),(19277,951,27801),(19278,951,27802),(19484,951,27810),(20089,951,27814),(19363,951,28270),(20093,952,27820),(20094,953,27819),(20095,954,27821),(20097,955,27823),(20096,956,27822),(20092,957,27811),(20091,957,27812),(20090,957,27813),(22140,969,27873),(22137,969,27874),(22135,969,27875),(22139,969,27876),(22138,969,27877),(22136,969,27878),(22142,969,27879),(22134,969,27880),(22141,969,27881),(19485,970,27885),(19487,970,27886),(19490,970,27887),(19486,970,27888),(19489,970,27889),(19488,970,27890),(19279,971,27882),(19280,971,27883),(19281,971,27884),(19491,971,27892),(19364,971,28271),(20113,972,27904),(20106,973,27898),(20107,973,27899),(20105,973,27900),(20108,974,27897),(20114,974,27905),(20117,975,27906),(20116,975,27907),(20115,975,27908),(20110,976,27893),(20111,976,27894),(20112,976,27895),(20109,976,27896),(22149,977,27910),(22146,977,27911),(22144,977,27912),(22148,977,27913),(22147,977,27914),(22145,977,27915),(22151,977,27916),(22143,977,27917),(22150,977,27918),(19492,978,27922),(19494,978,27923),(19497,978,27924),(19493,978,27925),(19496,978,27926),(19495,978,27927),(19282,979,27919),(19283,979,27920),(19284,979,27921),(19498,979,27929),(19365,979,28272),(20118,980,27936),(20121,981,27933),(20119,981,27934),(20120,981,27935),(20126,982,27940),(20125,982,27941),(20128,983,27943),(20127,984,27942),(20123,985,27930),(20124,985,27931),(20122,985,27932),(22158,986,27945),(22155,986,27946),(22153,986,27947),(22157,986,27948),(22156,986,27949),(22154,986,27950),(22160,986,27951),(22152,986,27952),(22159,986,27953),(19321,986,27955),(19499,987,27959),(19501,987,27960),(19504,987,27961),(19500,987,27962),(19503,987,27963),(19502,987,27964),(19285,988,27956),(19286,988,27957),(19287,988,27958),(19505,988,27966),(19366,988,28273),(20129,989,27975),(20130,990,27972),(20131,990,27973),(20132,990,27974),(20135,991,27967),(20136,991,27968),(20137,991,27969),(20134,991,27970),(20133,991,27971),(21996,992,27977),(21993,992,27978),(21991,992,27979),(21995,992,27980),(21994,992,27981),(21992,992,27982),(21998,992,27983),(21990,992,27984),(21997,992,27985),(19506,993,27989),(19508,993,27990),(19511,993,27991),(19507,993,27992),(19510,993,27993),(19509,993,27994),(19288,994,27986),(19289,994,27987),(19290,994,27988),(19512,994,27996),(19367,994,28274),(20142,995,28003),(20143,996,28004),(20141,997,27997),(20140,997,27998),(20139,997,27999),(20138,997,28000),(21969,998,28006),(21966,998,28007),(21964,998,28008),(21968,998,28009),(21967,998,28010),(21965,998,28011),(21971,998,28012),(21963,998,28013),(21970,998,28014),(19341,999,28018),(19343,999,28019),(19346,999,28020),(19342,999,28021),(19345,999,28022),(19344,999,28023),(19291,1000,28015),(19292,1000,28016),(19293,1000,28017),(19347,1000,28025),(19326,1000,28254),(20144,1001,28031),(20147,1002,28028),(20146,1002,28029),(20145,1002,28030),(20148,1003,28026),(20149,1003,28027),(19574,1014,28045),(19583,1015,28048),(19582,1015,28049),(19581,1015,28050),(19577,1015,28054),(19576,1015,28055),(19575,1015,28056),(19580,1016,28052),(19579,1016,28053),(19578,1016,28057),(19586,1017,28046),(19585,1017,28047),(19584,1017,28051),(22167,1018,28059),(22164,1018,28060),(22162,1018,28061),(22166,1018,28062),(22165,1018,28063),(22163,1018,28064),(22169,1018,28065),(22161,1018,28066),(22168,1018,28067),(19322,1018,28069),(19513,1019,28073),(19515,1019,28074),(19518,1019,28075),(19514,1019,28076),(19517,1019,28077),(19516,1019,28078),(19294,1020,28070),(19295,1020,28071),(19296,1020,28072),(19519,1020,28080),(19368,1020,28275),(19587,1021,28084),(19596,1022,28087),(19595,1022,28088),(19594,1022,28089),(19590,1022,28093),(19589,1022,28094),(19588,1022,28095),(19593,1023,28091),(19592,1023,28092),(19591,1023,28096),(19599,1024,28085),(19598,1024,28086),(19597,1024,28090),(22221,1025,28098),(22218,1025,28099),(22216,1025,28100),(22220,1025,28101),(22219,1025,28102),(22217,1025,28103),(22223,1025,28104),(22215,1025,28105),(22222,1025,28106),(19520,1026,28110),(19522,1026,28111),(19525,1026,28112),(19521,1026,28113),(19524,1026,28114),(19523,1026,28115),(19297,1027,28107),(19298,1027,28108),(19299,1027,28109),(19526,1027,28117),(19369,1027,28276),(22176,1028,28119),(22173,1028,28120),(22171,1028,28121),(22175,1028,28122),(22174,1028,28123),(22172,1028,28124),(22178,1028,28125),(22170,1028,28126),(22177,1028,28127),(19323,1028,28129),(19527,1029,28133),(19529,1029,28134),(19532,1029,28135),(19528,1029,28136),(19531,1029,28137),(19530,1029,28138),(19300,1030,28130),(19301,1030,28131),(19302,1030,28132),(19533,1030,28140),(19370,1030,28277),(20062,1031,28143),(20068,1032,28151),(20067,1032,28152),(20066,1032,28153),(20065,1033,28150),(20071,1033,28156),(20069,1034,28154),(20070,1035,28155),(20064,1036,28141),(20063,1036,28142),(20073,1036,28157),(20072,1036,28158),(19600,1037,28162),(19609,1038,28165),(19608,1038,28166),(19607,1038,28167),(19603,1038,28171),(19602,1038,28172),(19601,1038,28173),(19606,1039,28169),(19605,1039,28170),(19604,1039,28174),(19612,1040,28163),(19611,1040,28164),(19610,1040,28168),(22185,1041,28176),(22182,1041,28177),(22180,1041,28178),(22184,1041,28179),(22183,1041,28180),(22181,1041,28181),(22187,1041,28182),(22179,1041,28183),(22186,1041,28184),(19534,1042,28188),(19536,1042,28189),(19539,1042,28190),(19535,1042,28191),(19538,1042,28192),(19537,1042,28193),(19303,1043,28185),(19304,1043,28186),(19305,1043,28187),(19540,1043,28195),(19371,1043,28278),(20099,1044,28200),(20098,1044,28201),(20101,1045,28202),(20100,1045,28203),(20104,1046,28206),(20103,1047,28204),(20102,1047,28205),(20005,1048,28208),(19972,1048,28209),(19973,1048,28210),(19974,1048,28211),(20009,1049,28215),(20008,1050,28216),(20007,1051,28217),(20006,1051,28218),(20003,1052,28220),(20004,1052,28221),(20002,1052,28222),(22194,1053,28224),(22191,1053,28225),(22189,1053,28226),(22193,1053,28227),(22192,1053,28228),(22190,1053,28229),(22196,1053,28230),(22188,1053,28231),(22195,1053,28232),(19541,1054,28236),(19543,1054,28237),(19546,1054,28238),(19542,1054,28239),(19545,1054,28240),(19544,1054,28241),(19306,1055,28233),(19307,1055,28234),(19308,1055,28235),(19547,1055,28243),(19372,1055,28279),(19979,1056,28246),(20010,1057,28247),(19892,1058,28281),(22203,1058,28294),(22200,1058,28295),(22198,1058,28296),(22202,1058,28297),(22201,1058,28298),(22199,1058,28299),(22205,1058,28300),(22197,1058,28301),(22204,1058,28302),(19896,1059,28285),(19897,1059,28286),(19898,1059,28287),(19899,1059,28288),(19900,1059,28289),(19901,1059,28290),(19893,1060,28282),(19894,1060,28283),(19895,1060,28284),(19902,1060,28291),(19903,1060,28292),(19913,1061,28310),(19928,1062,28325),(19929,1062,28326),(19914,1063,28311),(19915,1063,28312),(19916,1063,28313),(19920,1063,28317),(19921,1063,28318),(19922,1063,28319),(19930,1064,28327),(19931,1064,28328),(19917,1065,28314),(19918,1065,28315),(19919,1065,28316),(19932,1066,28329),(19923,1067,28320),(19924,1067,28321),(19925,1067,28322),(19926,1068,28323),(19927,1068,28324),(20153,1069,28333),(20154,1069,28334),(20155,1069,28335),(20156,1069,28336),(20157,1069,28337),(20158,1069,28338),(20150,1070,28330),(20151,1070,28331),(20152,1070,28332),(20159,1070,28339),(20160,1070,28340),(20161,1070,28341),(20186,1071,28374),(20187,1071,28375),(20188,1071,28376),(20171,1072,28359),(20172,1072,28360),(20162,1073,28342),(20163,1073,28343),(20164,1073,28344),(20165,1073,28345),(20173,1074,28361),(20174,1074,28362),(20175,1074,28363),(20176,1074,28364),(20177,1074,28365),(20178,1074,28366),(20179,1074,28367),(20170,1075,28358),(20166,1076,28354),(20167,1076,28355),(20168,1076,28356),(20169,1076,28357),(20180,1077,28368),(20181,1077,28369),(20182,1077,28370),(20183,1077,28371),(20184,1077,28372),(20185,1077,28373),(20192,1078,28380),(20193,1078,28381),(20194,1078,28382),(20195,1078,28383),(20196,1078,28384),(20197,1078,28385),(20189,1079,28377),(20190,1079,28378),(20191,1079,28379),(20198,1079,28386),(20199,1079,28387),(20201,1079,28389),(20213,1080,28413),(20214,1080,28414),(20215,1080,28415),(20216,1080,28416),(20212,1081,28412),(20202,1082,28390),(20203,1082,28391),(20217,1083,28417),(20218,1083,28418),(20219,1083,28419),(20220,1083,28420),(20221,1083,28421),(20222,1083,28422),(20211,1084,28411),(20200,1085,28388),(20204,1085,28404),(20205,1085,28405),(20206,1085,28406),(20207,1085,28407),(20208,1085,28408),(20209,1085,28409),(20210,1085,28410),(20223,1086,28423),(20224,1086,28424),(20225,1086,28425),(20229,1087,28429),(20230,1087,28430),(20231,1087,28431),(20232,1087,28432),(20233,1087,28433),(20234,1087,28434),(20226,1088,28426),(20227,1088,28427),(20228,1088,28428),(20235,1088,28435),(20236,1088,28436),(20237,1088,28437),(20244,1089,28450),(20245,1089,28451),(20238,1090,28438),(20239,1090,28439),(20246,1091,28452),(20247,1091,28453),(20243,1092,28449),(20240,1093,28446),(20241,1093,28447),(20242,1093,28448),(20251,1094,28457),(20252,1094,28458),(20253,1094,28459),(20254,1094,28460),(20255,1094,28461),(20256,1094,28462),(20248,1095,28454),(20249,1095,28455),(20250,1095,28456),(20257,1095,28463),(20258,1095,28464),(20259,1095,28465),(20266,1096,28478),(20267,1096,28479),(20260,1097,28466),(20261,1097,28467),(20268,1098,28480),(20269,1098,28481),(20265,1099,28477),(20262,1100,28474),(20263,1100,28475),(20264,1100,28476),(20273,1101,28485),(20274,1101,28486),(20275,1101,28487),(20276,1101,28488),(20277,1101,28489),(20278,1101,28490),(20270,1102,28482),(20271,1102,28483),(20272,1102,28484),(20279,1102,28491),(20280,1102,28492),(20282,1103,28496),(20281,1104,28495),(21057,1105,28503),(21058,1105,28504),(21067,1105,28513),(21073,1105,28519),(21074,1105,28520),(21075,1105,28521),(21076,1105,28522),(21077,1105,28523),(21086,1105,28532),(21059,1106,28505),(21060,1106,28506),(21061,1106,28507),(21066,1106,28512),(21078,1106,28524),(21079,1106,28525),(21080,1106,28526),(21081,1106,28527),(21082,1106,28528),(21055,1107,28501),(21062,1107,28508),(21063,1107,28509),(21064,1107,28510),(21071,1107,28517),(21083,1107,28529),(21084,1107,28530),(21085,1107,28531),(21056,1108,28502),(21068,1108,28514),(21069,1108,28515),(21070,1108,28516),(21072,1108,28518),(21065,1109,28511),(22224,1110,28539),(22225,1110,28540),(22226,1110,28541),(22227,1110,28542),(22228,1110,28543),(22229,1110,28544),(22230,1110,28545),(22231,1110,28546),(22232,1110,28547),(22233,1110,28548),(22234,1110,28549),(22235,1110,28550),(22236,1110,28551),(22237,1110,28552),(22238,1110,28553),(22239,1110,28554),(22240,1110,28555),(22241,1110,28556),(22242,1110,28557),(22243,1110,28558),(22244,1110,28559),(22245,1110,28560),(22246,1110,28561),(22247,1110,28562),(22248,1110,28563),(22249,1110,28564),(22250,1110,28565),(22251,1110,28566),(22252,1110,28567),(22253,1110,28568),(22254,1110,28569),(22255,1110,28570),(22256,1110,28571),(22257,1110,28572),(22258,1110,28573),(22259,1110,28574),(22260,1110,28575),(22261,1110,28576),(22262,1110,28577),(22263,1110,28578),(22264,1110,28579),(22265,1110,28580),(22266,1110,28581),(22267,1110,28582),(22268,1110,28583),(22269,1110,28584),(22270,1111,28585),(22271,1111,28586),(22272,1111,28587),(22273,1111,28588),(22274,1111,28589),(22275,1111,28590),(22276,1111,28591),(22277,1111,28592),(22278,1111,28593),(22279,1111,28594),(22280,1111,28595),(22281,1111,28596),(22282,1111,28597),(22283,1111,28598),(22284,1111,28599),(22285,1111,28600),(22286,1111,28601),(22287,1111,28602),(22288,1111,28603),(22289,1111,28604),(22290,1111,28605),(22291,1111,28606),(22292,1111,28607),(22293,1111,28608),(22294,1111,28609),(22295,1111,28610),(22296,1111,28611),(22297,1111,28612),(22298,1111,28613),(22299,1111,28614),(22300,1111,28615),(22301,1111,28616),(22350,1112,28621),(22351,1112,28622),(22352,1112,28623),(22353,1112,28624);
/*!40000 ALTER TABLE `items_applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lld_macro_path`
--

DROP TABLE IF EXISTS `lld_macro_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lld_macro_path` (
  `lld_macro_pathid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `lld_macro` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `path` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`lld_macro_pathid`),
  UNIQUE KEY `lld_macro_path_1` (`itemid`,`lld_macro`),
  CONSTRAINT `c_lld_macro_path_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lld_macro_path`
--

LOCK TABLES `lld_macro_path` WRITE;
/*!40000 ALTER TABLE `lld_macro_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `lld_macro_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_tag`
--

DROP TABLE IF EXISTS `maintenance_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenance_tag` (
  `maintenancetagid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `operator` int(11) NOT NULL DEFAULT '2',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`maintenancetagid`),
  KEY `maintenance_tag_1` (`maintenanceid`),
  CONSTRAINT `c_maintenance_tag_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_tag`
--

LOCK TABLES `maintenance_tag` WRITE;
/*!40000 ALTER TABLE `maintenance_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenance_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances`
--

DROP TABLE IF EXISTS `maintenances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances` (
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `maintenance_type` int(11) NOT NULL DEFAULT '0',
  `description` text COLLATE utf8_bin NOT NULL,
  `active_since` int(11) NOT NULL DEFAULT '0',
  `active_till` int(11) NOT NULL DEFAULT '0',
  `tags_evaltype` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`maintenanceid`),
  UNIQUE KEY `maintenances_2` (`name`),
  KEY `maintenances_1` (`active_since`,`active_till`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances`
--

LOCK TABLES `maintenances` WRITE;
/*!40000 ALTER TABLE `maintenances` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_groups`
--

DROP TABLE IF EXISTS `maintenances_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances_groups` (
  `maintenance_groupid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_groupid`),
  UNIQUE KEY `maintenances_groups_1` (`maintenanceid`,`groupid`),
  KEY `maintenances_groups_2` (`groupid`),
  CONSTRAINT `c_maintenances_groups_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_groups_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_groups`
--

LOCK TABLES `maintenances_groups` WRITE;
/*!40000 ALTER TABLE `maintenances_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_hosts`
--

DROP TABLE IF EXISTS `maintenances_hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances_hosts` (
  `maintenance_hostid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_hostid`),
  UNIQUE KEY `maintenances_hosts_1` (`maintenanceid`,`hostid`),
  KEY `maintenances_hosts_2` (`hostid`),
  CONSTRAINT `c_maintenances_hosts_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_hosts_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_hosts`
--

LOCK TABLES `maintenances_hosts` WRITE;
/*!40000 ALTER TABLE `maintenances_hosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_windows`
--

DROP TABLE IF EXISTS `maintenances_windows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances_windows` (
  `maintenance_timeperiodid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `timeperiodid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_timeperiodid`),
  UNIQUE KEY `maintenances_windows_1` (`maintenanceid`,`timeperiodid`),
  KEY `maintenances_windows_2` (`timeperiodid`),
  CONSTRAINT `c_maintenances_windows_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_windows_2` FOREIGN KEY (`timeperiodid`) REFERENCES `timeperiods` (`timeperiodid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_windows`
--

LOCK TABLES `maintenances_windows` WRITE;
/*!40000 ALTER TABLE `maintenances_windows` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_windows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mappings`
--

DROP TABLE IF EXISTS `mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mappings` (
  `mappingid` bigint(20) unsigned NOT NULL,
  `valuemapid` bigint(20) unsigned NOT NULL,
  `value` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `newvalue` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`mappingid`),
  KEY `mappings_1` (`valuemapid`),
  CONSTRAINT `c_mappings_1` FOREIGN KEY (`valuemapid`) REFERENCES `valuemaps` (`valuemapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mappings`
--

LOCK TABLES `mappings` WRITE;
/*!40000 ALTER TABLE `mappings` DISABLE KEYS */;
INSERT INTO `mappings` VALUES (1,1,'0','Down'),(2,1,'1','Up'),(3,2,'0','not available'),(4,2,'1','available'),(5,2,'2','unknown'),(13,6,'1','Other'),(14,6,'2','OK'),(15,6,'3','Degraded'),(17,7,'1','Other'),(18,7,'2','Unknown'),(19,7,'3','OK'),(20,7,'4','NonCritical'),(21,7,'5','Critical'),(22,7,'6','NonRecoverable'),(23,5,'1','unknown'),(24,5,'2','batteryNormal'),(25,5,'3','batteryLow'),(26,4,'1','unknown'),(27,4,'2','notInstalled'),(28,4,'3','ok'),(29,4,'4','failed'),(30,4,'5','highTemperature'),(31,4,'6','replaceImmediately'),(32,4,'7','lowCapacity'),(33,3,'0','Running'),(34,3,'1','Paused'),(35,3,'3','Pause pending'),(36,3,'4','Continue pending'),(37,3,'5','Stop pending'),(38,3,'6','Stopped'),(39,3,'7','Unknown'),(40,3,'255','No such service'),(41,3,'2','Start pending'),(49,9,'1','unknown'),(50,9,'2','running'),(51,9,'3','warning'),(52,9,'4','testing'),(53,9,'5','down'),(61,8,'1','up'),(62,8,'2','down'),(63,8,'3','testing'),(64,8,'4','unknown'),(65,8,'5','dormant'),(66,8,'6','notPresent'),(67,8,'7','lowerLayerDown'),(68,10,'1','Up'),(69,11,'1','up'),(70,11,'2','down'),(71,11,'3','testing'),(72,12,'0','poweredOff'),(73,12,'1','poweredOn'),(74,12,'2','suspended'),(75,13,'0','gray'),(76,13,'1','green'),(77,13,'2','yellow'),(78,13,'3','red'),(79,14,'0','normal'),(80,14,'1','in maintenance'),(81,14,'2','no data collection'),(82,15,'0','Normal'),(83,15,'1','Low memory'),(84,16,'0','Automatic'),(85,16,'1','Automatic delayed'),(86,16,'2','Manual'),(87,16,'3','Disabled'),(88,16,'4','Unknown'),(89,17,'100','Continue'),(90,17,'101','Switching Protocols'),(91,17,'102','Processing'),(92,17,'200','OK'),(93,17,'201','Created'),(94,17,'202','Accepted'),(95,17,'203','Non-Authoritative Information'),(96,17,'204','No Content'),(97,17,'205','Reset Content'),(98,17,'206','Partial Content'),(99,17,'207','Multi-Status'),(100,17,'208','Already Reported'),(101,17,'226','IM Used'),(102,17,'300','Multiple Choices'),(103,17,'301','Moved Permanently'),(104,17,'302','Found'),(105,17,'303','See Other'),(106,17,'304','Not Modified'),(107,17,'305','Use Proxy'),(108,17,'306','Switch Proxy'),(109,17,'307','Temporary Redirect'),(110,17,'308','Permanent Redirect/Resume Incomplete'),(111,17,'400','Bad Request'),(112,17,'401','Unauthorized'),(113,17,'402','Payment Required'),(114,17,'403','Forbidden'),(115,17,'404','Not Found'),(116,17,'405','Method Not Allowed'),(117,17,'406','Not Acceptable'),(118,17,'407','Proxy Authentication Required'),(119,17,'408','Request Timeout'),(120,17,'409','Conflict'),(121,17,'410','Gone'),(122,17,'411','Length Required'),(123,17,'412','Precondition Failed'),(124,17,'413','Payload Too Large'),(125,17,'414','Request-URI Too Long'),(126,17,'415','Unsupported Media Type'),(127,17,'416','Requested Range Not Satisfiable'),(128,17,'417','Expectation Failed'),(129,17,'418','I\'m a Teapot'),(130,17,'419','Authentication Timeout'),(131,17,'420','Method Failure/Enhance Your Calm'),(132,17,'421','Misdirected Request'),(133,17,'422','Unprocessable Entity'),(134,17,'423','Locked'),(135,17,'424','Failed Dependency'),(136,17,'426','Upgrade Required'),(137,17,'428','Precondition Required'),(138,17,'429','Too Many Requests'),(139,17,'431','Request Header Fields Too Large'),(140,17,'440','Login Timeout'),(141,17,'444','No Response'),(142,17,'449','Retry With'),(143,17,'450','Blocked by Windows Parental Controls'),(144,17,'451','Unavailable for Legal Reasons/Redirect'),(145,17,'494','Request Header Too Large'),(146,17,'495','Cert Error'),(147,17,'496','No Cert'),(148,17,'497','HTTP to HTTPS'),(149,17,'498','Token Expired/Invalid'),(150,17,'499','Client Closed Request/Token Required'),(151,17,'500','Internal Server Error'),(152,17,'501','Not Implemented'),(153,17,'502','Bad Gateway'),(154,17,'503','Service Unavailable'),(155,17,'504','Gateway Timeout'),(156,17,'505','HTTP Version Not Supported'),(157,17,'506','Variant Also Negotiates'),(158,17,'507','Insufficient Storage'),(159,17,'508','Loop Detected'),(160,17,'509','Bandwidth Limit Exceeded'),(161,17,'510','Not Extended'),(162,17,'511','Network Authentication Required'),(163,17,'520','Unknown Error'),(164,17,'598','Network Read Timeout Error'),(165,17,'599','Network Connect Timeout Error'),(166,18,'1','ok'),(167,18,'2','unavailable'),(168,18,'3','nonoperational'),(169,19,'1','unknown'),(170,19,'2','halfDuplex'),(171,19,'3','fullDuplex'),(172,20,'1','up'),(173,20,'2','down'),(174,20,'3','testing'),(175,20,'4','unknown'),(176,20,'5','dormant'),(177,20,'6','notPresent'),(178,20,'7','lowerLayerDown'),(179,21,'1','other'),(180,21,'2','regular1822'),(181,21,'3','hdh1822'),(182,21,'4','ddnX25'),(183,21,'5','rfc877x25'),(184,21,'6','ethernetCsmacd'),(185,21,'7','iso88023Csmacd'),(186,21,'8','iso88024TokenBus'),(187,21,'9','iso88025TokenRing'),(188,21,'10','iso88026Man'),(189,21,'11','starLan'),(190,21,'12','proteon10Mbit'),(191,21,'13','proteon80Mbit'),(192,21,'14','hyperchannel'),(193,21,'15','fddi'),(194,21,'16','lapb'),(195,21,'17','sdlc'),(196,21,'18','ds1'),(197,21,'19','e1'),(198,21,'20','basicISDN'),(199,21,'21','primaryISDN'),(200,21,'22','propPointToPointSerial'),(201,21,'23','ppp'),(202,21,'24','softwareLoopback'),(203,21,'25','eon'),(204,21,'26','ethernet3Mbit'),(205,21,'27','nsip'),(206,21,'28','slip'),(207,21,'29','ultra'),(208,21,'30','ds3'),(209,21,'31','sip'),(210,21,'32','frameRelay'),(211,21,'33','rs232'),(212,21,'34','para'),(213,21,'35','arcnet'),(214,21,'36','arcnetPlus'),(215,21,'37','atm'),(216,21,'38','miox25'),(217,21,'39','sonet'),(218,21,'40','x25ple'),(219,21,'41','iso88022llc'),(220,21,'42','localTalk'),(221,21,'43','smdsDxi'),(222,21,'44','frameRelayService'),(223,21,'45','v35'),(224,21,'46','hssi'),(225,21,'47','hippi'),(226,21,'48','modem'),(227,21,'49','aal5'),(228,21,'50','sonetPath'),(229,21,'51','sonetVT'),(230,21,'52','smdsIcip'),(231,21,'53','propVirtual'),(232,21,'54','propMultiplexor'),(233,21,'55','ieee80212'),(234,21,'56','fibreChannel'),(235,21,'57','hippiInterface'),(236,21,'58','frameRelayInterconnect'),(237,21,'59','aflane8023'),(238,21,'60','aflane8025'),(239,21,'61','cctEmul'),(240,21,'62','fastEther'),(241,21,'63','isdn'),(242,21,'64','v11'),(243,21,'65','v36'),(244,21,'66','g703at64k'),(245,21,'67','g703at2mb'),(246,21,'68','qllc'),(247,21,'69','fastEtherFX'),(248,21,'70','channel'),(249,21,'71','ieee80211'),(250,21,'72','ibm370parChan'),(251,21,'73','escon'),(252,21,'74','dlsw'),(253,21,'75','isdns'),(254,21,'76','isdnu'),(255,21,'77','lapd'),(256,21,'78','ipSwitch'),(257,21,'79','rsrb'),(258,21,'80','atmLogical'),(259,21,'81','ds0'),(260,21,'82','ds0Bundle'),(261,21,'83','bsc'),(262,21,'84','async'),(263,21,'85','cnr'),(264,21,'86','iso88025Dtr'),(265,21,'87','eplrs'),(266,21,'88','arap'),(267,21,'89','propCnls'),(268,21,'90','hostPad'),(269,21,'91','termPad'),(270,21,'92','frameRelayMPI'),(271,21,'93','x213'),(272,21,'94','adsl'),(273,21,'95','radsl'),(274,21,'96','sdsl'),(275,21,'97','vdsl'),(276,21,'98','iso88025CRFPInt'),(277,21,'99','myrinet'),(278,21,'100','voiceEM'),(279,21,'101','voiceFXO'),(280,21,'102','voiceFXS'),(281,21,'103','voiceEncap'),(282,21,'104','voiceOverIp'),(283,21,'105','atmDxi'),(284,21,'106','atmFuni'),(285,21,'107','atmIma'),(286,21,'108','pppMultilinkBundle'),(287,21,'109','ipOverCdlc'),(288,21,'110','ipOverClaw'),(289,21,'111','stackToStack'),(290,21,'112','virtualIpAddress'),(291,21,'113','mpc'),(292,21,'114','ipOverAtm'),(293,21,'115','iso88025Fiber'),(294,21,'116','tdlc'),(295,21,'117','gigabitEthernet'),(296,21,'118','hdlc'),(297,21,'119','lapf'),(298,21,'120','v37'),(299,21,'121','x25mlp'),(300,21,'122','x25huntGroup'),(301,21,'123','trasnpHdlc'),(302,21,'124','interleave'),(303,21,'125','fast'),(304,21,'126','ip'),(305,21,'127','docsCableMaclayer'),(306,21,'128','docsCableDownstream'),(307,21,'129','docsCableUpstream'),(308,21,'130','a12MppSwitch'),(309,21,'131','tunnel'),(310,21,'132','coffee'),(311,21,'133','ces'),(312,21,'134','atmSubInterface'),(313,21,'135','l2vlan'),(314,21,'136','l3ipvlan'),(315,21,'137','l3ipxvlan'),(316,21,'138','digitalPowerline'),(317,21,'139','mediaMailOverIp'),(318,21,'140','dtm'),(319,21,'141','dcn'),(320,21,'142','ipForward'),(321,21,'143','msdsl'),(322,21,'144','ieee1394'),(323,21,'145','if-gsn'),(324,21,'146','dvbRccMacLayer'),(325,21,'147','dvbRccDownstream'),(326,21,'148','dvbRccUpstream'),(327,21,'149','atmVirtual'),(328,21,'150','mplsTunnel'),(329,21,'151','srp'),(330,21,'152','voiceOverAtm'),(331,21,'153','voiceOverFrameRelay'),(332,21,'154','idsl'),(333,21,'155','compositeLink'),(334,21,'156','ss7SigLink'),(335,21,'157','propWirelessP2P'),(336,21,'158','frForward'),(337,21,'159','rfc1483'),(338,21,'160','usb'),(339,21,'161','ieee8023adLag'),(340,21,'162','bgppolicyaccounting'),(341,21,'163','frf16MfrBundle'),(342,21,'164','h323Gatekeeper'),(343,21,'165','h323Proxy'),(344,21,'166','mpls'),(345,21,'167','mfSigLink'),(346,21,'168','hdsl2'),(347,21,'169','shdsl'),(348,21,'170','ds1FDL'),(349,21,'171','pos'),(350,21,'172','dvbAsiIn'),(351,21,'173','dvbAsiOut'),(352,21,'174','plc'),(353,21,'175','nfas'),(354,21,'176','tr008'),(355,21,'177','gr303RDT'),(356,21,'178','gr303IDT'),(357,21,'179','isup'),(358,21,'180','propDocsWirelessMaclayer'),(359,21,'181','propDocsWirelessDownstream'),(360,21,'182','propDocsWirelessUpstream'),(361,21,'183','hiperlan2'),(362,21,'184','propBWAp2Mp'),(363,21,'185','sonetOverheadChannel'),(364,21,'186','digitalWrapperOverheadChannel'),(365,21,'187','aal2'),(366,21,'188','radioMAC'),(367,21,'189','atmRadio'),(368,21,'190','imt'),(369,21,'191','mvl'),(370,21,'192','reachDSL'),(371,21,'193','frDlciEndPt'),(372,21,'194','atmVciEndPt'),(373,21,'195','opticalChannel'),(374,21,'196','opticalTransport'),(375,21,'197','propAtm'),(376,21,'198','voiceOverCable'),(377,21,'199','infiniband'),(378,21,'200','teLink'),(379,21,'201','q2931'),(380,21,'202','virtualTg'),(381,21,'203','sipTg'),(382,21,'204','sipSig'),(383,21,'205','docsCableUpstreamChannel'),(384,21,'206','econet'),(385,21,'207','pon155'),(386,21,'208','pon622'),(387,21,'209','bridge'),(388,21,'210','linegroup'),(389,21,'211','voiceEMFGD'),(390,21,'212','voiceFGDEANA'),(391,21,'213','voiceDID'),(392,21,'214','mpegTransport'),(393,21,'215','sixToFour'),(394,21,'216','gtp'),(395,21,'217','pdnEtherLoop1'),(396,21,'218','pdnEtherLoop2'),(397,21,'219','opticalChannelGroup'),(398,21,'220','homepna'),(399,21,'221','gfp'),(400,21,'222','ciscoISLvlan'),(401,21,'223','actelisMetaLOOP'),(402,21,'224','fcipLink'),(403,21,'225','rpr'),(404,21,'226','qam'),(405,21,'227','lmp'),(406,21,'228','cblVectaStar'),(407,21,'229','docsCableMCmtsDownstream'),(408,21,'230','adsl2'),(409,21,'231','macSecControlledIF'),(410,21,'232','macSecUncontrolledIF'),(411,21,'233','aviciOpticalEther'),(412,21,'234','atmbond'),(413,21,'235','voiceFGDOS'),(414,21,'236','mocaVersion1'),(415,21,'237','ieee80216WMAN'),(416,21,'238','adsl2plus'),(417,21,'239','dvbRcsMacLayer'),(418,21,'240','dvbTdm'),(419,21,'241','dvbRcsTdma'),(420,21,'242','x86Laps'),(421,21,'243','wwanPP'),(422,21,'244','wwanPP2'),(423,21,'245','voiceEBS'),(424,21,'246','ifPwType'),(425,21,'247','ilan'),(426,21,'248','pip'),(427,21,'249','aluELP'),(428,21,'250','gpon'),(429,21,'251','vdsl2'),(430,21,'252','capwapDot11Profile'),(431,21,'253','capwapDot11Bss'),(432,21,'254','capwapWtpVirtualRadio'),(433,21,'255','bits'),(434,21,'256','docsCableUpstreamRfPort'),(435,21,'257','cableDownstreamRfPort'),(436,21,'258','vmwareVirtualNic'),(437,21,'259','ieee802154'),(438,21,'260','otnOdu'),(439,21,'261','otnOtu'),(440,21,'262','ifVfiType'),(441,21,'263','g9981'),(442,21,'264','g9982'),(443,21,'265','g9983'),(444,21,'266','aluEpon'),(445,21,'267','aluEponOnu'),(446,21,'268','aluEponPhysicalUni'),(447,21,'269','aluEponLogicalLink'),(448,21,'270','aluGponOnu'),(449,21,'271','aluGponPhysicalUni'),(450,21,'272','vmwareNicTeam'),(451,21,'277','docsOfdmDownstream'),(452,21,'278','docsOfdmaUpstream'),(453,21,'279','gfast'),(454,21,'280','sdci'),(455,21,'281','xboxWireless'),(456,21,'282','fastdsl'),(457,21,'283','docsCableScte55d1FwdOob'),(458,21,'284','docsCableScte55d1RetOob'),(459,21,'285','docsCableScte55d2DsOob'),(460,21,'286','docsCableScte55d2UsOob'),(461,21,'287','docsCableNdf'),(462,21,'288','docsCableNdr'),(463,21,'289','ptm'),(464,21,'290','ghn'),(465,22,'0','not available'),(466,22,'1','available'),(467,22,'2','unknown'),(468,23,'1','deviceStateUnknown'),(469,23,'2','deviceNotEquipped'),(470,23,'3','deviceStateOk'),(471,23,'4','deviceStateFailed'),(472,23,'5','deviceStateOutOfService'),(473,24,'1','unknown'),(474,24,'2','faulty'),(475,24,'3','below-min'),(476,24,'4','nominal'),(477,24,'5','above-max'),(478,24,'6','absent'),(479,25,'1','online'),(480,25,'2','offline'),(481,25,'3','testing'),(482,25,'4','faulty'),(483,26,'1','other'),(484,26,'2','normal'),(485,26,'3','failure'),(486,27,'1','other'),(487,27,'2','normal'),(488,27,'3','failure'),(489,28,'1','normal'),(490,28,'2','warning'),(491,28,'3','critical'),(492,28,'4','shutdown'),(493,28,'5','notPresent'),(494,28,'6','notFunctioning'),(495,29,'1','true - on'),(496,29,'2','false - off'),(497,30,'1','up'),(498,30,'2','down'),(499,30,'3','absent'),(500,31,'1','up'),(501,31,'2','down'),(502,31,'3','absent'),(503,32,'1','noexist'),(504,32,'2','existnopower'),(505,32,'3','existreadypower'),(506,32,'4','normal'),(507,32,'5','powerbutabnormal'),(508,32,'6','unknown'),(509,33,'0','other'),(510,33,'1','working'),(511,33,'2','fail'),(512,33,'3','speed-0'),(513,33,'4','speed-low'),(514,33,'5','speed-middle'),(515,33,'6','speed-high'),(516,34,'0','other'),(517,34,'1','lowVoltage'),(518,34,'2','overCurrent'),(519,34,'3','working'),(520,34,'4','fail'),(521,34,'5','connect'),(522,34,'6','disconnect'),(523,35,'1','true'),(524,35,'2','false'),(525,36,'1','true - on'),(526,36,'2','false - off'),(527,37,'1','alarm'),(528,37,'2','normal'),(529,38,'1','notPresent'),(530,38,'2','presentOK'),(531,38,'3','presentNotOK'),(532,38,'4','presentPowerOff'),(533,39,'1','notSupported'),(534,39,'2','normal'),(535,39,'3','postFailure'),(536,39,'4','entityAbsent'),(537,39,'5','poeError'),(538,39,'6','stackError'),(539,39,'7','stackPortBlocked'),(540,39,'8','stackPortFailed'),(541,39,'9','sfpRecvError'),(542,39,'10','sfpSendError'),(543,39,'11','sfpBothError'),(544,39,'12','fanError'),(545,39,'13','psuError'),(546,39,'14','rpsError'),(547,39,'15','moduleFaulty'),(548,39,'16','sensorError'),(549,39,'17','hardwareFaulty'),(550,40,'1','unknown'),(551,40,'2','bad'),(552,40,'3','warning'),(553,40,'4','good'),(554,40,'5','notPresent'),(555,41,'1','normal'),(556,41,'2','abnormal'),(557,42,'1','online'),(558,42,'2','operational'),(559,42,'3','failed'),(560,42,'4','offline'),(561,43,'1','invalid'),(562,43,'2','bad'),(563,43,'3','warning'),(564,43,'4','good'),(565,43,'5','disabled'),(566,44,'1','unknown'),(567,44,'2','disabled'),(568,44,'3','failed'),(569,44,'4','warning'),(570,44,'5','standby'),(571,44,'6','engaged'),(572,44,'7','redundant'),(573,44,'8','notPresent'),(574,45,'1','normal'),(575,45,'2','high'),(576,45,'3','excessivelyHigh'),(577,45,'4','low'),(578,45,'5','excessivelyLow'),(579,45,'6','noSensor'),(580,45,'7','unknown'),(581,46,'1','other'),(582,46,'2','off'),(583,46,'3','on - RedAlarm'),(584,47,'1','unknown'),(585,47,'2','running'),(586,47,'3','ready'),(587,47,'4','reset'),(588,47,'5','runningAtFullSpeed'),(589,47,'6','down or off'),(590,47,'7','standby'),(591,48,'1','unknown'),(592,48,'2','disabled'),(593,48,'3','enabled'),(594,48,'4','testing'),(595,49,'1','operational'),(596,49,'2','failed'),(597,49,'3','powering'),(598,49,'4','notpowering'),(599,49,'5','notpresent'),(600,50,'1','operational'),(601,50,'2','failed'),(602,50,'3','powering'),(603,50,'4','notpowering'),(604,50,'5','notpresent'),(605,51,'1','normal'),(606,51,'2','warning'),(607,51,'3','critical'),(608,51,'4','shutdown'),(609,51,'5','notpresent'),(610,51,'6','notoperational'),(611,52,'0','normal'),(612,52,'1','abnormal'),(613,53,'0','normal'),(614,53,'1','abnormal'),(615,53,'2','not available'),(616,54,'1','other'),(617,54,'2','ok'),(618,54,'3','degraded'),(619,54,'4','failed'),(620,55,'1','other'),(621,55,'2','unknown'),(622,55,'3','system'),(623,55,'4','systemBoard'),(624,55,'5','ioBoard'),(625,55,'6','cpu'),(626,55,'7','memory'),(627,55,'8','storage'),(628,55,'9','removableMedia'),(629,55,'10','powerSupply'),(630,55,'11','ambient'),(631,55,'12','chassis'),(632,55,'13','bridgeCard'),(633,56,'1','other'),(634,56,'2','ida'),(635,56,'3','idaExpansion'),(636,56,'4','ida-2'),(637,56,'5','smart'),(638,56,'6','smart-2e'),(639,56,'7','smart-2p'),(640,56,'8','smart-2sl'),(641,56,'9','smart-3100es'),(642,56,'10','smart-3200'),(643,56,'11','smart-2dh'),(644,56,'12','smart-221'),(645,56,'13','sa-4250es'),(646,56,'14','sa-4200'),(647,56,'15','sa-integrated'),(648,56,'16','sa-431'),(649,56,'17','sa-5300'),(650,56,'18','raidLc2'),(651,56,'19','sa-5i'),(652,56,'20','sa-532'),(653,56,'21','sa-5312'),(654,56,'22','sa-641'),(655,56,'23','sa-642'),(656,56,'24','sa-6400'),(657,56,'25','sa-6400em'),(658,56,'26','sa-6i'),(659,56,'27','sa-generic'),(660,56,'29','sa-p600'),(661,56,'30','sa-p400'),(662,56,'31','sa-e200'),(663,56,'32','sa-e200i'),(664,56,'33','sa-p400i'),(665,56,'34','sa-p800'),(666,56,'35','sa-e500'),(667,56,'36','sa-p700m'),(668,56,'37','sa-p212'),(669,56,'38','sa-p410'),(670,56,'39','sa-p410i'),(671,56,'40','sa-p411'),(672,56,'41','sa-b110i'),(673,56,'42','sa-p712m'),(674,56,'43','sa-p711m'),(675,56,'44','sa-p812'),(676,57,'1','other'),(677,57,'2','ok'),(678,57,'3','failed'),(679,57,'4','predictiveFailure'),(680,58,'0','nonRecoverable'),(681,58,'2','critical'),(682,58,'4','nonCritical'),(683,58,'255','normal'),(684,59,'1','other'),(685,59,'2','unknown'),(686,59,'3','ok'),(687,59,'4','nonCritical'),(688,59,'5','critical'),(689,59,'6','nonRecoverable'),(690,60,'1','other'),(691,60,'2','unknown'),(692,60,'3','ok'),(693,60,'4','nonCriticalUpper'),(694,60,'5','criticalUpper'),(695,60,'6','nonRecoverableUpper'),(696,60,'7','nonCriticalLower'),(697,60,'8','criticalLower'),(698,60,'9','nonRecoverableLower'),(699,60,'10','failed'),(700,61,'1','other'),(701,61,'2','unknown'),(702,61,'3','ok'),(703,61,'4','nonCritical'),(704,61,'5','critical'),(705,61,'6','nonRecoverable'),(706,62,'0','ok'),(707,62,'1','failed'),(708,63,'1','Unknown'),(709,63,'2','HDD'),(710,63,'3','SSD'),(711,64,'1','Unknown'),(712,64,'2','Ready'),(713,64,'3','Failed'),(714,64,'4','Degraded'),(715,64,'5','Missing'),(716,64,'6','Charging'),(717,64,'7','Below threshold'),(718,65,'1','Other'),(719,65,'2','RAID-0'),(720,65,'3','RAID-1'),(721,65,'4','RAID-5'),(722,65,'5','RAID-6'),(723,65,'6','RAID-10'),(724,65,'7','RAID-50'),(725,65,'8','RAID-60'),(726,65,'9','Concatenated RAID 1'),(727,65,'10','Concatenated RAID 5'),(728,66,'1','Not applicable'),(729,66,'2','Reconstructing'),(730,66,'3','Resynching'),(731,66,'4','Initializing'),(732,66,'5','Background init'),(733,67,'1','Write Through'),(734,67,'2','Write Back'),(735,67,'3','Force Write Back'),(736,68,'1','No Read Ahead'),(737,68,'2','Read Ahead'),(738,68,'3','Adaptive Read Ahead'),(739,69,'1','Unknown'),(740,69,'2','Online'),(741,69,'3','Failed'),(742,69,'4','Degraded'),(743,70,'1','other'),(744,70,'2','ok'),(745,70,'3','replaceDrive'),(746,70,'4','replaceDriveSSDWearOut'),(747,71,'1','other'),(748,71,'2','invalid'),(749,71,'3','enabled'),(750,71,'4','tmpDisabled'),(751,71,'5','permDisabled'),(752,71,'6','cacheModFlashMemNotAttached'),(753,71,'7','cacheModDegradedFailsafeSpeed'),(754,71,'8','cacheModCriticalFailure'),(755,71,'9','cacheReadCacheNotMapped'),(756,72,'1','Other'),(757,72,'2','Ok'),(758,72,'3','Recharging'),(759,72,'4','Failed'),(760,72,'5','Degraded'),(761,72,'6','Not Present'),(762,72,'7','Capacitor failed'),(763,73,'1','Other'),(764,73,'2','rotatingPlatters'),(765,73,'3','solidState'),(766,74,'0','other'),(767,74,'2','none'),(768,74,'3','RAID-1/RAID-10'),(769,74,'4','RAID-4'),(770,74,'5','RAID-5'),(771,74,'7','RAID-6'),(772,74,'8','RAID-50'),(773,74,'9','RAID-60'),(774,74,'10','RAID-1 ADM'),(775,74,'11','RAID-10 ADM'),(776,75,'1','other'),(777,75,'2','ok'),(778,75,'3','failed'),(779,75,'4','unconfigured'),(780,75,'5','recovering'),(781,75,'6','readyForRebuild'),(782,75,'7','rebuilding'),(783,75,'8','wrongDrive'),(784,75,'9','badConnect'),(785,75,'10','overheating'),(786,75,'11','shutdown'),(787,75,'12','expanding'),(788,75,'13','notAvailable'),(789,75,'14','queuedForExpansion'),(790,75,'15','multipathAccessDegraded'),(791,75,'16','erasing'),(792,75,'17','predictiveSpareRebuildReady'),(793,75,'18','rapidParityInitInProgress'),(794,75,'19','rapidParityInitPending'),(795,75,'20','noAccessEncryptedNoCntlrKey'),(796,75,'21','unencryptedToEncryptedInProgress'),(797,75,'22','newLogDrvKeyRekeyInProgress'),(798,75,'23','noAccessEncryptedCntlrEncryptnNotEnbld'),(799,75,'24','unencryptedToEncryptedNotStarted'),(800,75,'25','newLogDrvKeyRekeyRequestReceived'),(801,56,'45','sw-1210m'),(802,56,'46','sa-p220i'),(803,56,'47','sa-p222'),(804,56,'48','sa-p420'),(805,56,'49','sa-p420i'),(806,56,'50','sa-p421'),(807,56,'51','sa-b320i'),(808,56,'52','sa-p822'),(809,56,'53','sa-p721m'),(810,56,'54','sa-b120i'),(811,56,'55','hps-1224'),(812,56,'56','hps-1228'),(813,56,'57','hps-1228m'),(814,56,'58','sa-p822se'),(815,56,'59','hps-1224e'),(816,56,'60','hps-1228e'),(817,56,'61','hps-1228em'),(818,56,'62','sa-p230i'),(819,56,'63','sa-p430i'),(820,56,'64','sa-p430'),(821,56,'65','sa-p431'),(822,56,'66','sa-p731m'),(823,56,'67','sa-p830i'),(824,56,'68','sa-p830'),(825,56,'69','sa-p831'),(826,56,'70','sa-p530'),(827,56,'71','sa-p531'),(828,56,'72','sa-p244br'),(829,56,'73','sa-p246br'),(830,56,'74','sa-p440'),(831,56,'75','sa-p440ar'),(832,56,'76','sa-p441'),(833,56,'77','sa-p741m'),(834,56,'78','sa-p840'),(835,56,'79','sa-p841'),(836,56,'80','sh-h240ar'),(837,56,'81','sh-h244br'),(838,56,'82','sh-h240'),(839,56,'83','sh-h241'),(840,56,'84','sa-b140i'),(841,56,'85','sh-generic'),(842,56,'88','sa-p840ar');
/*!40000 ALTER TABLE `mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `mediaid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `mediatypeid` bigint(20) unsigned NOT NULL,
  `sendto` varchar(1024) COLLATE utf8_bin NOT NULL DEFAULT '',
  `active` int(11) NOT NULL DEFAULT '0',
  `severity` int(11) NOT NULL DEFAULT '63',
  `period` varchar(1024) COLLATE utf8_bin NOT NULL DEFAULT '1-7,00:00-24:00',
  PRIMARY KEY (`mediaid`),
  KEY `media_1` (`userid`),
  KEY `media_2` (`mediatypeid`),
  CONSTRAINT `c_media_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_media_2` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_type`
--

DROP TABLE IF EXISTS `media_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_type` (
  `mediatypeid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `description` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `smtp_server` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `smtp_helo` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `smtp_email` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `exec_path` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `gsm_modem` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `username` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `passwd` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `smtp_port` int(11) NOT NULL DEFAULT '25',
  `smtp_security` int(11) NOT NULL DEFAULT '0',
  `smtp_verify_peer` int(11) NOT NULL DEFAULT '0',
  `smtp_verify_host` int(11) NOT NULL DEFAULT '0',
  `smtp_authentication` int(11) NOT NULL DEFAULT '0',
  `exec_params` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `maxsessions` int(11) NOT NULL DEFAULT '1',
  `maxattempts` int(11) NOT NULL DEFAULT '3',
  `attempt_interval` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '10s',
  `content_type` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`mediatypeid`),
  UNIQUE KEY `media_type_1` (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_type`
--

LOCK TABLES `media_type` WRITE;
/*!40000 ALTER TABLE `media_type` DISABLE KEYS */;
INSERT INTO `media_type` VALUES (1,0,'Email','mail.example.com','example.com','zabbix@example.com','','','','',0,25,0,0,0,0,'',1,3,'10s',0),(2,3,'Jabber','','','','','','jabber@example.com','zabbix',0,25,0,0,0,0,'',1,3,'10s',0),(3,2,'SMS','','','','','/dev/ttyS0','','',0,25,0,0,0,0,'',1,3,'10s',0);
/*!40000 ALTER TABLE `media_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand`
--

DROP TABLE IF EXISTS `opcommand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcommand` (
  `operationid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `scriptid` bigint(20) unsigned DEFAULT NULL,
  `execute_on` int(11) NOT NULL DEFAULT '0',
  `port` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `authtype` int(11) NOT NULL DEFAULT '0',
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `password` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `publickey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `privatekey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `command` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`operationid`),
  KEY `opcommand_1` (`scriptid`),
  CONSTRAINT `c_opcommand_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opcommand_2` FOREIGN KEY (`scriptid`) REFERENCES `scripts` (`scriptid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand`
--

LOCK TABLES `opcommand` WRITE;
/*!40000 ALTER TABLE `opcommand` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand_grp`
--

DROP TABLE IF EXISTS `opcommand_grp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcommand_grp` (
  `opcommand_grpid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opcommand_grpid`),
  KEY `opcommand_grp_1` (`operationid`),
  KEY `opcommand_grp_2` (`groupid`),
  CONSTRAINT `c_opcommand_grp_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opcommand_grp_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand_grp`
--

LOCK TABLES `opcommand_grp` WRITE;
/*!40000 ALTER TABLE `opcommand_grp` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand_grp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand_hst`
--

DROP TABLE IF EXISTS `opcommand_hst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcommand_hst` (
  `opcommand_hstid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`opcommand_hstid`),
  KEY `opcommand_hst_1` (`operationid`),
  KEY `opcommand_hst_2` (`hostid`),
  CONSTRAINT `c_opcommand_hst_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opcommand_hst_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand_hst`
--

LOCK TABLES `opcommand_hst` WRITE;
/*!40000 ALTER TABLE `opcommand_hst` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand_hst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opconditions`
--

DROP TABLE IF EXISTS `opconditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opconditions` (
  `opconditionid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `conditiontype` int(11) NOT NULL DEFAULT '0',
  `operator` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`opconditionid`),
  KEY `opconditions_1` (`operationid`),
  CONSTRAINT `c_opconditions_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opconditions`
--

LOCK TABLES `opconditions` WRITE;
/*!40000 ALTER TABLE `opconditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `opconditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operations`
--

DROP TABLE IF EXISTS `operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operations` (
  `operationid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `operationtype` int(11) NOT NULL DEFAULT '0',
  `esc_period` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `esc_step_from` int(11) NOT NULL DEFAULT '1',
  `esc_step_to` int(11) NOT NULL DEFAULT '1',
  `evaltype` int(11) NOT NULL DEFAULT '0',
  `recovery` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`operationid`),
  KEY `operations_1` (`actionid`),
  CONSTRAINT `c_operations_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operations`
--

LOCK TABLES `operations` WRITE;
/*!40000 ALTER TABLE `operations` DISABLE KEYS */;
INSERT INTO `operations` VALUES (1,2,6,'0',1,1,0,0),(2,2,4,'0',1,1,0,0),(3,3,0,'0',1,1,0,0),(4,4,0,'0',1,1,0,0),(5,5,0,'0',1,1,0,0),(6,6,0,'0',1,1,0,0),(7,3,11,'0',1,1,0,1),(8,4,11,'0',1,1,0,1),(9,5,11,'0',1,1,0,1),(10,6,11,'0',1,1,0,1);
/*!40000 ALTER TABLE `operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opgroup`
--

DROP TABLE IF EXISTS `opgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opgroup` (
  `opgroupid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opgroupid`),
  UNIQUE KEY `opgroup_1` (`operationid`,`groupid`),
  KEY `opgroup_2` (`groupid`),
  CONSTRAINT `c_opgroup_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opgroup_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opgroup`
--

LOCK TABLES `opgroup` WRITE;
/*!40000 ALTER TABLE `opgroup` DISABLE KEYS */;
INSERT INTO `opgroup` VALUES (1,2,2);
/*!40000 ALTER TABLE `opgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opinventory`
--

DROP TABLE IF EXISTS `opinventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opinventory` (
  `operationid` bigint(20) unsigned NOT NULL,
  `inventory_mode` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`operationid`),
  CONSTRAINT `c_opinventory_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opinventory`
--

LOCK TABLES `opinventory` WRITE;
/*!40000 ALTER TABLE `opinventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `opinventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage`
--

DROP TABLE IF EXISTS `opmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opmessage` (
  `operationid` bigint(20) unsigned NOT NULL,
  `default_msg` int(11) NOT NULL DEFAULT '0',
  `subject` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `message` text COLLATE utf8_bin NOT NULL,
  `mediatypeid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`operationid`),
  KEY `opmessage_1` (`mediatypeid`),
  CONSTRAINT `c_opmessage_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opmessage_2` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage`
--

LOCK TABLES `opmessage` WRITE;
/*!40000 ALTER TABLE `opmessage` DISABLE KEYS */;
INSERT INTO `opmessage` VALUES (3,1,'Problem: {EVENT.NAME}','Problem started at {EVENT.TIME} on {EVENT.DATE}\r\nProblem name: {EVENT.NAME}\r\nHost: {HOST.NAME}\r\nSeverity: {EVENT.SEVERITY}\r\n\r\nOriginal problem ID: {EVENT.ID}\r\n{TRIGGER.URL}',NULL),(4,1,'','',NULL),(5,1,'','',NULL),(6,1,'','',NULL),(7,1,'Resolved: {EVENT.NAME}','Problem has been resolved at {EVENT.RECOVERY.TIME} on {EVENT.RECOVERY.DATE}\r\nProblem name: {EVENT.NAME}\r\nHost: {HOST.NAME}\r\nSeverity: {EVENT.SEVERITY}\r\n\r\nOriginal problem ID: {EVENT.ID}\r\n{TRIGGER.URL}',NULL),(8,1,'{ITEM.STATE}: {HOST.NAME}:{ITEM.NAME}','Host: {HOST.NAME}\r\nItem: {ITEM.NAME}\r\nKey: {ITEM.KEY}\r\nState: {ITEM.STATE}',NULL),(9,1,'{LLDRULE.STATE}: {HOST.NAME}:{LLDRULE.NAME}','Host: {HOST.NAME}\r\nLow level discovery rule: {LLDRULE.NAME}\r\nKey: {LLDRULE.KEY}\r\nState: {LLDRULE.STATE}',NULL),(10,1,'{TRIGGER.STATE}: {TRIGGER.NAME}','Trigger name: {TRIGGER.NAME}\r\nExpression: {TRIGGER.EXPRESSION}\r\nState: {TRIGGER.STATE}',NULL);
/*!40000 ALTER TABLE `opmessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage_grp`
--

DROP TABLE IF EXISTS `opmessage_grp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opmessage_grp` (
  `opmessage_grpid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opmessage_grpid`),
  UNIQUE KEY `opmessage_grp_1` (`operationid`,`usrgrpid`),
  KEY `opmessage_grp_2` (`usrgrpid`),
  CONSTRAINT `c_opmessage_grp_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opmessage_grp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage_grp`
--

LOCK TABLES `opmessage_grp` WRITE;
/*!40000 ALTER TABLE `opmessage_grp` DISABLE KEYS */;
INSERT INTO `opmessage_grp` VALUES (1,3,7),(2,4,7),(3,5,7),(4,6,7);
/*!40000 ALTER TABLE `opmessage_grp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage_usr`
--

DROP TABLE IF EXISTS `opmessage_usr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opmessage_usr` (
  `opmessage_usrid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opmessage_usrid`),
  UNIQUE KEY `opmessage_usr_1` (`operationid`,`userid`),
  KEY `opmessage_usr_2` (`userid`),
  CONSTRAINT `c_opmessage_usr_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opmessage_usr_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage_usr`
--

LOCK TABLES `opmessage_usr` WRITE;
/*!40000 ALTER TABLE `opmessage_usr` DISABLE KEYS */;
/*!40000 ALTER TABLE `opmessage_usr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `optemplate`
--

DROP TABLE IF EXISTS `optemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `optemplate` (
  `optemplateid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`optemplateid`),
  UNIQUE KEY `optemplate_1` (`operationid`,`templateid`),
  KEY `optemplate_2` (`templateid`),
  CONSTRAINT `c_optemplate_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_optemplate_2` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optemplate`
--

LOCK TABLES `optemplate` WRITE;
/*!40000 ALTER TABLE `optemplate` DISABLE KEYS */;
INSERT INTO `optemplate` VALUES (1,1,10001);
/*!40000 ALTER TABLE `optemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `problem`
--

DROP TABLE IF EXISTS `problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `problem` (
  `eventid` bigint(20) unsigned NOT NULL,
  `source` int(11) NOT NULL DEFAULT '0',
  `object` int(11) NOT NULL DEFAULT '0',
  `objectid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `clock` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  `r_eventid` bigint(20) unsigned DEFAULT NULL,
  `r_clock` int(11) NOT NULL DEFAULT '0',
  `r_ns` int(11) NOT NULL DEFAULT '0',
  `correlationid` bigint(20) unsigned DEFAULT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `acknowledged` int(11) NOT NULL DEFAULT '0',
  `severity` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`eventid`),
  KEY `problem_1` (`source`,`object`,`objectid`),
  KEY `problem_2` (`r_clock`),
  KEY `problem_3` (`r_eventid`),
  CONSTRAINT `c_problem_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_problem_2` FOREIGN KEY (`r_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `problem`
--

LOCK TABLES `problem` WRITE;
/*!40000 ALTER TABLE `problem` DISABLE KEYS */;
INSERT INTO `problem` VALUES (1,0,0,13560,1564099344,358210074,16,1564099404,410905444,NULL,0,'Zabbix task manager processes more than 75% busy',0,3),(2,3,4,23261,1564099361,375566706,NULL,0,0,NULL,NULL,'No \"ipmi poller\" processes started.',0,0),(3,3,0,13476,1564099361,375566706,NULL,0,0,NULL,NULL,'Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:zabbix[process,ipmi poller,avg,busy].avg(10m)\": item is not supported.\".',0,0),(4,3,4,23262,1564099362,376489509,NULL,0,0,NULL,NULL,'No \"java poller\" processes started.',0,0),(5,3,0,13477,1564099362,376489509,NULL,0,0,NULL,NULL,'Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:zabbix[process,java poller,avg,busy].avg(10m)\": item is not supported.\".',0,0),(6,3,4,25367,1564099367,378580249,NULL,0,0,NULL,NULL,'No \"ipmi manager\" processes started.',0,0),(7,3,4,23267,1564099367,378840805,NULL,0,0,NULL,NULL,'No \"snmp trapper\" processes started.',0,0),(8,3,0,13482,1564099367,378840805,NULL,0,0,NULL,NULL,'Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:zabbix[process,snmp trapper,avg,busy].avg(10m)\": item is not supported.\".',0,0),(9,3,0,13563,1564099367,378580249,NULL,0,0,NULL,NULL,'Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:zabbix[process,ipmi manager,avg,busy].avg(10m)\": item is not supported.\".',0,0),(10,3,4,23328,1564099368,379561635,NULL,0,0,NULL,NULL,'No \"vmware collector\" processes started.',0,0),(11,3,0,13436,1564099368,379561635,NULL,0,0,NULL,NULL,'Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:zabbix[process,vmware collector,avg,busy].avg(10m)\": item is not supported.\".',0,0),(12,3,0,13491,1564099371,327279252,15,1564099387,391568130,NULL,0,'Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:agent.ping.nodata(5m)\": item does not have enough data after server start or item creation.\".',0,0),(13,3,4,23635,1564099375,385552624,NULL,0,0,NULL,NULL,'No \"vmware collector\" processes started.',0,0),(14,3,0,13537,1564099375,385552624,NULL,0,0,NULL,NULL,'Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:zabbix[vmware,buffer,pused].max(10m)\": item is not supported.\".',0,0),(17,3,0,13502,1564099713,670363429,NULL,0,0,NULL,NULL,'Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:system.uptime.change(0)\": cannot get values from value cache.\".',0,0);
/*!40000 ALTER TABLE `problem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `problem_tag`
--

DROP TABLE IF EXISTS `problem_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `problem_tag` (
  `problemtagid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`problemtagid`),
  KEY `problem_tag_1` (`eventid`,`tag`,`value`),
  CONSTRAINT `c_problem_tag_1` FOREIGN KEY (`eventid`) REFERENCES `problem` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `problem_tag`
--

LOCK TABLES `problem_tag` WRITE;
/*!40000 ALTER TABLE `problem_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `problem_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `profileid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `idx` varchar(96) COLLATE utf8_bin NOT NULL DEFAULT '',
  `idx2` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_int` int(11) NOT NULL DEFAULT '0',
  `value_str` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `source` varchar(96) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`profileid`),
  KEY `profiles_1` (`userid`,`idx`,`idx2`),
  KEY `profiles_2` (`userid`,`profileid`),
  CONSTRAINT `c_profiles_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_autoreg_host`
--

DROP TABLE IF EXISTS `proxy_autoreg_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxy_autoreg_host` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clock` int(11) NOT NULL DEFAULT '0',
  `host` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `listen_ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `listen_port` int(11) NOT NULL DEFAULT '0',
  `listen_dns` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `host_metadata` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `proxy_autoreg_host_1` (`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_autoreg_host`
--

LOCK TABLES `proxy_autoreg_host` WRITE;
/*!40000 ALTER TABLE `proxy_autoreg_host` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_autoreg_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_dhistory`
--

DROP TABLE IF EXISTS `proxy_dhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxy_dhistory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clock` int(11) NOT NULL DEFAULT '0',
  `druleid` bigint(20) unsigned NOT NULL,
  `ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `dcheckid` bigint(20) unsigned DEFAULT NULL,
  `dns` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `proxy_dhistory_1` (`clock`),
  KEY `proxy_dhistory_2` (`druleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_dhistory`
--

LOCK TABLES `proxy_dhistory` WRITE;
/*!40000 ALTER TABLE `proxy_dhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_dhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_history`
--

DROP TABLE IF EXISTS `proxy_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxy_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `source` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT '0',
  `value` longtext COLLATE utf8_bin NOT NULL,
  `logeventid` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `lastlogsize` bigint(20) unsigned NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `proxy_history_1` (`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_history`
--

LOCK TABLES `proxy_history` WRITE;
/*!40000 ALTER TABLE `proxy_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regexps`
--

DROP TABLE IF EXISTS `regexps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regexps` (
  `regexpid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `test_string` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`regexpid`),
  UNIQUE KEY `regexps_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regexps`
--

LOCK TABLES `regexps` WRITE;
/*!40000 ALTER TABLE `regexps` DISABLE KEYS */;
INSERT INTO `regexps` VALUES (1,'File systems for discovery','ext3'),(2,'Network interfaces for discovery','eth0'),(3,'Storage devices for SNMP discovery','/boot'),(4,'Windows service names for discovery','SysmonLog'),(5,'Windows service startup states for discovery','automatic');
/*!40000 ALTER TABLE `regexps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rights`
--

DROP TABLE IF EXISTS `rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rights` (
  `rightid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '0',
  `id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`rightid`),
  KEY `rights_1` (`groupid`),
  KEY `rights_2` (`id`),
  CONSTRAINT `c_rights_1` FOREIGN KEY (`groupid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE,
  CONSTRAINT `c_rights_2` FOREIGN KEY (`id`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rights`
--

LOCK TABLES `rights` WRITE;
/*!40000 ALTER TABLE `rights` DISABLE KEYS */;
/*!40000 ALTER TABLE `rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screen_user`
--

DROP TABLE IF EXISTS `screen_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screen_user` (
  `screenuserid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`screenuserid`),
  UNIQUE KEY `screen_user_1` (`screenid`,`userid`),
  KEY `c_screen_user_2` (`userid`),
  CONSTRAINT `c_screen_user_1` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE,
  CONSTRAINT `c_screen_user_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screen_user`
--

LOCK TABLES `screen_user` WRITE;
/*!40000 ALTER TABLE `screen_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `screen_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screen_usrgrp`
--

DROP TABLE IF EXISTS `screen_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screen_usrgrp` (
  `screenusrgrpid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`screenusrgrpid`),
  UNIQUE KEY `screen_usrgrp_1` (`screenid`,`usrgrpid`),
  KEY `c_screen_usrgrp_2` (`usrgrpid`),
  CONSTRAINT `c_screen_usrgrp_1` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE,
  CONSTRAINT `c_screen_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screen_usrgrp`
--

LOCK TABLES `screen_usrgrp` WRITE;
/*!40000 ALTER TABLE `screen_usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `screen_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screens`
--

DROP TABLE IF EXISTS `screens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screens` (
  `screenid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `hsize` int(11) NOT NULL DEFAULT '1',
  `vsize` int(11) NOT NULL DEFAULT '1',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  `private` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`screenid`),
  KEY `screens_1` (`templateid`),
  KEY `c_screens_3` (`userid`),
  CONSTRAINT `c_screens_1` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_screens_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screens`
--

LOCK TABLES `screens` WRITE;
/*!40000 ALTER TABLE `screens` DISABLE KEYS */;
INSERT INTO `screens` VALUES (3,'System performance',2,3,10001,NULL,0),(4,'Zabbix server health',2,3,10047,NULL,0),(5,'System performance',2,2,10076,NULL,0),(6,'System performance',2,2,10077,NULL,0),(7,'System performance',2,2,10075,NULL,0),(9,'System performance',2,3,10074,NULL,0),(10,'System performance',2,3,10078,NULL,0),(16,'Zabbix server',2,2,NULL,1,0),(17,'Zabbix proxy health',2,2,10048,NULL,0),(18,'System performance',1,2,10079,NULL,0),(19,'System performance',2,2,10081,NULL,0),(20,'MySQL performance',2,1,10170,NULL,1),(21,'Zabbix server health',2,3,10261,NULL,1),(22,'Zabbix proxy health',2,2,10262,NULL,1);
/*!40000 ALTER TABLE `screens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screens_items`
--

DROP TABLE IF EXISTS `screens_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screens_items` (
  `screenitemid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `resourcetype` int(11) NOT NULL DEFAULT '0',
  `resourceid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `width` int(11) NOT NULL DEFAULT '320',
  `height` int(11) NOT NULL DEFAULT '200',
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `colspan` int(11) NOT NULL DEFAULT '1',
  `rowspan` int(11) NOT NULL DEFAULT '1',
  `elements` int(11) NOT NULL DEFAULT '25',
  `valign` int(11) NOT NULL DEFAULT '0',
  `halign` int(11) NOT NULL DEFAULT '0',
  `style` int(11) NOT NULL DEFAULT '0',
  `url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `dynamic` int(11) NOT NULL DEFAULT '0',
  `sort_triggers` int(11) NOT NULL DEFAULT '0',
  `application` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `max_columns` int(11) NOT NULL DEFAULT '3',
  PRIMARY KEY (`screenitemid`),
  KEY `screens_items_1` (`screenid`),
  CONSTRAINT `c_screens_items_1` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screens_items`
--

LOCK TABLES `screens_items` WRITE;
/*!40000 ALTER TABLE `screens_items` DISABLE KEYS */;
INSERT INTO `screens_items` VALUES (44,16,2,1,500,100,0,0,2,1,0,0,0,0,'',0,0,'',3),(45,16,0,524,400,156,0,1,1,1,0,0,0,0,'',0,0,'',3),(46,16,0,525,400,100,1,1,1,1,0,0,0,0,'',0,0,'',3),(179,4,0,392,500,212,0,0,1,1,0,1,0,0,'',0,0,'',3),(180,4,0,404,500,100,1,0,1,1,0,1,0,0,'',0,0,'',3),(181,4,0,406,555,114,0,1,1,1,0,1,0,0,'',0,0,'',3),(182,4,0,410,500,128,1,1,1,1,0,1,0,0,'',0,0,'',3),(183,4,0,527,500,160,0,2,1,1,0,0,0,0,'',0,0,'',3),(184,4,0,788,500,160,1,2,1,1,0,0,0,0,'',0,0,'',3),(185,20,0,650,500,200,0,0,1,1,0,1,0,0,'',0,0,'',3),(186,20,0,649,500,270,1,0,1,1,0,1,0,0,'',0,0,'',3),(187,5,0,469,500,148,0,0,1,1,0,1,0,0,'',0,0,'',3),(188,5,0,471,500,100,1,0,1,1,0,0,0,0,'',0,0,'',3),(189,5,0,498,500,100,0,1,1,1,0,0,0,0,'',0,0,'',3),(190,5,0,540,500,100,1,1,1,1,0,0,0,0,'',0,0,'',3),(191,7,0,463,500,120,0,0,1,1,0,1,0,0,'',0,0,'',3),(192,7,0,462,500,106,1,0,1,1,0,1,0,0,'',0,0,'',3),(193,7,0,541,500,100,0,1,1,1,0,0,0,0,'',0,0,'',3),(194,7,0,464,500,300,1,1,1,1,0,0,0,0,'',0,0,'',3),(195,6,0,475,500,114,0,0,1,1,0,1,0,0,'',0,0,'',3),(196,6,0,474,500,100,1,0,1,1,0,1,0,0,'',0,0,'',3),(197,6,0,542,500,100,0,1,1,1,0,0,0,0,'',0,0,'',3),(198,3,0,433,500,120,0,0,1,1,0,1,0,0,'',0,0,'',3),(199,3,0,387,500,148,1,0,1,1,0,1,0,0,'',0,0,'',3),(200,3,0,533,500,100,0,1,1,1,0,0,0,0,'',0,0,'',3),(201,3,0,436,500,300,1,1,1,1,0,0,0,0,'',0,0,'',3),(202,3,1,10009,500,100,0,2,1,1,0,0,0,0,'',0,0,'',3),(203,3,1,10013,500,100,1,2,1,1,0,0,0,0,'',0,0,'',3),(204,18,0,487,500,100,0,0,1,1,0,0,0,0,'',0,0,'',3),(205,18,0,543,500,100,0,1,1,1,0,0,0,0,'',0,0,'',3),(206,9,0,457,500,120,0,0,1,1,0,1,0,0,'',0,0,'',3),(207,9,0,456,500,106,1,0,1,1,0,1,0,0,'',0,0,'',3),(208,9,0,544,500,100,0,1,1,1,0,0,0,0,'',0,0,'',3),(209,9,0,458,500,300,1,1,1,1,0,0,0,0,'',0,0,'',3),(210,9,1,22838,500,100,0,2,1,1,0,0,0,0,'',0,0,'',3),(211,9,1,22837,500,100,1,2,1,1,0,0,0,0,'',0,0,'',3),(212,10,0,481,500,114,0,0,1,1,0,1,0,0,'',0,0,'',3),(213,10,0,480,500,100,1,0,1,1,0,1,0,0,'',0,0,'',3),(214,10,0,545,500,100,0,1,1,1,0,0,0,0,'',0,0,'',3),(215,10,0,482,500,300,1,1,1,1,0,0,0,0,'',0,0,'',3),(216,10,1,22998,500,100,0,2,1,1,0,0,0,0,'',0,0,'',3),(217,10,1,22997,500,100,1,2,1,1,0,0,0,0,'',0,0,'',3),(218,19,0,495,500,100,0,0,1,1,0,0,0,0,'',0,0,'',3),(219,19,0,546,500,100,1,0,1,1,0,0,0,0,'',0,0,'',3),(220,19,1,23140,500,100,0,1,1,1,0,0,0,0,'',0,0,'',3),(221,19,1,23138,500,100,1,1,1,1,0,0,0,0,'',0,0,'',3),(232,17,0,532,500,212,0,0,1,1,0,1,0,0,'',0,0,'',3),(233,17,0,530,500,100,1,0,1,1,0,1,0,0,'',0,0,'',3),(234,17,0,531,500,100,0,1,1,1,0,1,0,0,'',0,0,'',3),(235,17,0,529,500,128,1,1,1,1,0,1,0,0,'',0,0,'',3),(236,21,0,802,500,212,0,0,1,1,0,1,0,0,'',0,0,'',3),(237,21,0,799,500,100,1,0,1,1,0,0,0,0,'',0,0,'',3),(238,21,0,800,555,114,0,1,1,1,0,1,0,0,'',0,0,'',3),(239,21,0,798,500,128,1,1,1,1,0,1,0,0,'',0,0,'',3),(240,21,0,797,500,160,0,2,1,1,0,0,0,0,'',0,0,'',3),(241,21,0,801,500,160,1,2,1,1,0,0,0,0,'',0,0,'',3),(242,22,0,806,500,212,0,0,1,1,0,1,0,0,'',0,0,'',3),(243,22,0,804,500,100,1,0,1,1,0,1,0,0,'',0,0,'',3),(244,22,0,805,500,100,0,1,1,1,0,1,0,0,'',0,0,'',3),(245,22,0,803,500,128,1,1,1,1,0,1,0,0,'',0,0,'',3);
/*!40000 ALTER TABLE `screens_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scripts`
--

DROP TABLE IF EXISTS `scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scripts` (
  `scriptid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `command` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `host_access` int(11) NOT NULL DEFAULT '2',
  `usrgrpid` bigint(20) unsigned DEFAULT NULL,
  `groupid` bigint(20) unsigned DEFAULT NULL,
  `description` text COLLATE utf8_bin NOT NULL,
  `confirmation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT '0',
  `execute_on` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`scriptid`),
  UNIQUE KEY `scripts_3` (`name`),
  KEY `scripts_1` (`usrgrpid`),
  KEY `scripts_2` (`groupid`),
  CONSTRAINT `c_scripts_1` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`),
  CONSTRAINT `c_scripts_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scripts`
--

LOCK TABLES `scripts` WRITE;
/*!40000 ALTER TABLE `scripts` DISABLE KEYS */;
INSERT INTO `scripts` VALUES (1,'Ping','ping -c 3 {HOST.CONN}; case $? in [01]) true;; *) false;; esac',2,NULL,NULL,'','',0,2),(2,'Traceroute','/usr/bin/traceroute {HOST.CONN}',2,NULL,NULL,'','',0,2),(3,'Detect operating system','sudo /usr/bin/nmap -O {HOST.CONN}',2,7,NULL,'','',0,2);
/*!40000 ALTER TABLE `scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_alarms`
--

DROP TABLE IF EXISTS `service_alarms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_alarms` (
  `servicealarmid` bigint(20) unsigned NOT NULL,
  `serviceid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`servicealarmid`),
  KEY `service_alarms_1` (`serviceid`,`clock`),
  KEY `service_alarms_2` (`clock`),
  CONSTRAINT `c_service_alarms_1` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_alarms`
--

LOCK TABLES `service_alarms` WRITE;
/*!40000 ALTER TABLE `service_alarms` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_alarms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `serviceid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `algorithm` int(11) NOT NULL DEFAULT '0',
  `triggerid` bigint(20) unsigned DEFAULT NULL,
  `showsla` int(11) NOT NULL DEFAULT '0',
  `goodsla` double(16,4) NOT NULL DEFAULT '99.9000',
  `sortorder` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`serviceid`),
  KEY `services_1` (`triggerid`),
  CONSTRAINT `c_services_1` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_links`
--

DROP TABLE IF EXISTS `services_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_links` (
  `linkid` bigint(20) unsigned NOT NULL,
  `serviceupid` bigint(20) unsigned NOT NULL,
  `servicedownid` bigint(20) unsigned NOT NULL,
  `soft` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`linkid`),
  UNIQUE KEY `services_links_2` (`serviceupid`,`servicedownid`),
  KEY `services_links_1` (`servicedownid`),
  CONSTRAINT `c_services_links_1` FOREIGN KEY (`serviceupid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE,
  CONSTRAINT `c_services_links_2` FOREIGN KEY (`servicedownid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_links`
--

LOCK TABLES `services_links` WRITE;
/*!40000 ALTER TABLE `services_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `services_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_times`
--

DROP TABLE IF EXISTS `services_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_times` (
  `timeid` bigint(20) unsigned NOT NULL,
  `serviceid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `ts_from` int(11) NOT NULL DEFAULT '0',
  `ts_to` int(11) NOT NULL DEFAULT '0',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`timeid`),
  KEY `services_times_1` (`serviceid`,`type`,`ts_from`,`ts_to`),
  CONSTRAINT `c_services_times_1` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_times`
--

LOCK TABLES `services_times` WRITE;
/*!40000 ALTER TABLE `services_times` DISABLE KEYS */;
/*!40000 ALTER TABLE `services_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `sessionid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `userid` bigint(20) unsigned NOT NULL,
  `lastaccess` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sessionid`),
  KEY `sessions_1` (`userid`,`status`,`lastaccess`),
  CONSTRAINT `c_sessions_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slides`
--

DROP TABLE IF EXISTS `slides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slides` (
  `slideid` bigint(20) unsigned NOT NULL,
  `slideshowid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `step` int(11) NOT NULL DEFAULT '0',
  `delay` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`slideid`),
  KEY `slides_1` (`slideshowid`),
  KEY `slides_2` (`screenid`),
  CONSTRAINT `c_slides_1` FOREIGN KEY (`slideshowid`) REFERENCES `slideshows` (`slideshowid`) ON DELETE CASCADE,
  CONSTRAINT `c_slides_2` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slides`
--

LOCK TABLES `slides` WRITE;
/*!40000 ALTER TABLE `slides` DISABLE KEYS */;
/*!40000 ALTER TABLE `slides` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slideshow_user`
--

DROP TABLE IF EXISTS `slideshow_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slideshow_user` (
  `slideshowuserid` bigint(20) unsigned NOT NULL,
  `slideshowid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`slideshowuserid`),
  UNIQUE KEY `slideshow_user_1` (`slideshowid`,`userid`),
  KEY `c_slideshow_user_2` (`userid`),
  CONSTRAINT `c_slideshow_user_1` FOREIGN KEY (`slideshowid`) REFERENCES `slideshows` (`slideshowid`) ON DELETE CASCADE,
  CONSTRAINT `c_slideshow_user_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slideshow_user`
--

LOCK TABLES `slideshow_user` WRITE;
/*!40000 ALTER TABLE `slideshow_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `slideshow_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slideshow_usrgrp`
--

DROP TABLE IF EXISTS `slideshow_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slideshow_usrgrp` (
  `slideshowusrgrpid` bigint(20) unsigned NOT NULL,
  `slideshowid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`slideshowusrgrpid`),
  UNIQUE KEY `slideshow_usrgrp_1` (`slideshowid`,`usrgrpid`),
  KEY `c_slideshow_usrgrp_2` (`usrgrpid`),
  CONSTRAINT `c_slideshow_usrgrp_1` FOREIGN KEY (`slideshowid`) REFERENCES `slideshows` (`slideshowid`) ON DELETE CASCADE,
  CONSTRAINT `c_slideshow_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slideshow_usrgrp`
--

LOCK TABLES `slideshow_usrgrp` WRITE;
/*!40000 ALTER TABLE `slideshow_usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `slideshow_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slideshows`
--

DROP TABLE IF EXISTS `slideshows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slideshows` (
  `slideshowid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `delay` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '30s',
  `userid` bigint(20) unsigned NOT NULL,
  `private` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`slideshowid`),
  UNIQUE KEY `slideshows_1` (`name`),
  KEY `c_slideshows_3` (`userid`),
  CONSTRAINT `c_slideshows_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slideshows`
--

LOCK TABLES `slideshows` WRITE;
/*!40000 ALTER TABLE `slideshows` DISABLE KEYS */;
/*!40000 ALTER TABLE `slideshows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_element_trigger`
--

DROP TABLE IF EXISTS `sysmap_element_trigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_element_trigger` (
  `selement_triggerid` bigint(20) unsigned NOT NULL,
  `selementid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`selement_triggerid`),
  UNIQUE KEY `sysmap_element_trigger_1` (`selementid`,`triggerid`),
  KEY `c_sysmap_element_trigger_2` (`triggerid`),
  CONSTRAINT `c_sysmap_element_trigger_1` FOREIGN KEY (`selementid`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmap_element_trigger_2` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_element_trigger`
--

LOCK TABLES `sysmap_element_trigger` WRITE;
/*!40000 ALTER TABLE `sysmap_element_trigger` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_element_trigger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_element_url`
--

DROP TABLE IF EXISTS `sysmap_element_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_element_url` (
  `sysmapelementurlid` bigint(20) unsigned NOT NULL,
  `selementid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`sysmapelementurlid`),
  UNIQUE KEY `sysmap_element_url_1` (`selementid`,`name`),
  CONSTRAINT `c_sysmap_element_url_1` FOREIGN KEY (`selementid`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_element_url`
--

LOCK TABLES `sysmap_element_url` WRITE;
/*!40000 ALTER TABLE `sysmap_element_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_element_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_shape`
--

DROP TABLE IF EXISTS `sysmap_shape`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_shape` (
  `sysmap_shapeid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `width` int(11) NOT NULL DEFAULT '200',
  `height` int(11) NOT NULL DEFAULT '200',
  `text` text COLLATE utf8_bin NOT NULL,
  `font` int(11) NOT NULL DEFAULT '9',
  `font_size` int(11) NOT NULL DEFAULT '11',
  `font_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '000000',
  `text_halign` int(11) NOT NULL DEFAULT '0',
  `text_valign` int(11) NOT NULL DEFAULT '0',
  `border_type` int(11) NOT NULL DEFAULT '0',
  `border_width` int(11) NOT NULL DEFAULT '1',
  `border_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '000000',
  `background_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `zindex` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sysmap_shapeid`),
  KEY `sysmap_shape_1` (`sysmapid`),
  CONSTRAINT `c_sysmap_shape_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_shape`
--

LOCK TABLES `sysmap_shape` WRITE;
/*!40000 ALTER TABLE `sysmap_shape` DISABLE KEYS */;
INSERT INTO `sysmap_shape` VALUES (1,1,0,0,0,680,15,'{MAP.NAME}',9,11,'000000',0,0,0,0,'000000','',0);
/*!40000 ALTER TABLE `sysmap_shape` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_url`
--

DROP TABLE IF EXISTS `sysmap_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_url` (
  `sysmapurlid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `elementtype` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sysmapurlid`),
  UNIQUE KEY `sysmap_url_1` (`sysmapid`,`name`),
  CONSTRAINT `c_sysmap_url_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_url`
--

LOCK TABLES `sysmap_url` WRITE;
/*!40000 ALTER TABLE `sysmap_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_user`
--

DROP TABLE IF EXISTS `sysmap_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_user` (
  `sysmapuserid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`sysmapuserid`),
  UNIQUE KEY `sysmap_user_1` (`sysmapid`,`userid`),
  KEY `c_sysmap_user_2` (`userid`),
  CONSTRAINT `c_sysmap_user_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmap_user_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_user`
--

LOCK TABLES `sysmap_user` WRITE;
/*!40000 ALTER TABLE `sysmap_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_usrgrp`
--

DROP TABLE IF EXISTS `sysmap_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_usrgrp` (
  `sysmapusrgrpid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`sysmapusrgrpid`),
  UNIQUE KEY `sysmap_usrgrp_1` (`sysmapid`,`usrgrpid`),
  KEY `c_sysmap_usrgrp_2` (`usrgrpid`),
  CONSTRAINT `c_sysmap_usrgrp_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmap_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_usrgrp`
--

LOCK TABLES `sysmap_usrgrp` WRITE;
/*!40000 ALTER TABLE `sysmap_usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps`
--

DROP TABLE IF EXISTS `sysmaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps` (
  `sysmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `width` int(11) NOT NULL DEFAULT '600',
  `height` int(11) NOT NULL DEFAULT '400',
  `backgroundid` bigint(20) unsigned DEFAULT NULL,
  `label_type` int(11) NOT NULL DEFAULT '2',
  `label_location` int(11) NOT NULL DEFAULT '0',
  `highlight` int(11) NOT NULL DEFAULT '1',
  `expandproblem` int(11) NOT NULL DEFAULT '1',
  `markelements` int(11) NOT NULL DEFAULT '0',
  `show_unack` int(11) NOT NULL DEFAULT '0',
  `grid_size` int(11) NOT NULL DEFAULT '50',
  `grid_show` int(11) NOT NULL DEFAULT '1',
  `grid_align` int(11) NOT NULL DEFAULT '1',
  `label_format` int(11) NOT NULL DEFAULT '0',
  `label_type_host` int(11) NOT NULL DEFAULT '2',
  `label_type_hostgroup` int(11) NOT NULL DEFAULT '2',
  `label_type_trigger` int(11) NOT NULL DEFAULT '2',
  `label_type_map` int(11) NOT NULL DEFAULT '2',
  `label_type_image` int(11) NOT NULL DEFAULT '2',
  `label_string_host` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label_string_hostgroup` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label_string_trigger` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label_string_map` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label_string_image` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `iconmapid` bigint(20) unsigned DEFAULT NULL,
  `expand_macros` int(11) NOT NULL DEFAULT '0',
  `severity_min` int(11) NOT NULL DEFAULT '0',
  `userid` bigint(20) unsigned NOT NULL,
  `private` int(11) NOT NULL DEFAULT '1',
  `show_suppressed` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sysmapid`),
  UNIQUE KEY `sysmaps_1` (`name`),
  KEY `sysmaps_2` (`backgroundid`),
  KEY `sysmaps_3` (`iconmapid`),
  KEY `c_sysmaps_3` (`userid`),
  CONSTRAINT `c_sysmaps_1` FOREIGN KEY (`backgroundid`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_2` FOREIGN KEY (`iconmapid`) REFERENCES `icon_map` (`iconmapid`),
  CONSTRAINT `c_sysmaps_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps`
--

LOCK TABLES `sysmaps` WRITE;
/*!40000 ALTER TABLE `sysmaps` DISABLE KEYS */;
INSERT INTO `sysmaps` VALUES (1,'Local network',680,200,NULL,0,0,1,1,1,0,50,1,1,0,2,2,2,2,2,'','','','','',NULL,1,0,1,0,0);
/*!40000 ALTER TABLE `sysmaps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_elements`
--

DROP TABLE IF EXISTS `sysmaps_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps_elements` (
  `selementid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `elementid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `elementtype` int(11) NOT NULL DEFAULT '0',
  `iconid_off` bigint(20) unsigned DEFAULT NULL,
  `iconid_on` bigint(20) unsigned DEFAULT NULL,
  `label` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label_location` int(11) NOT NULL DEFAULT '-1',
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `iconid_disabled` bigint(20) unsigned DEFAULT NULL,
  `iconid_maintenance` bigint(20) unsigned DEFAULT NULL,
  `elementsubtype` int(11) NOT NULL DEFAULT '0',
  `areatype` int(11) NOT NULL DEFAULT '0',
  `width` int(11) NOT NULL DEFAULT '200',
  `height` int(11) NOT NULL DEFAULT '200',
  `viewtype` int(11) NOT NULL DEFAULT '0',
  `use_iconmap` int(11) NOT NULL DEFAULT '1',
  `application` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`selementid`),
  KEY `sysmaps_elements_1` (`sysmapid`),
  KEY `sysmaps_elements_2` (`iconid_off`),
  KEY `sysmaps_elements_3` (`iconid_on`),
  KEY `sysmaps_elements_4` (`iconid_disabled`),
  KEY `sysmaps_elements_5` (`iconid_maintenance`),
  CONSTRAINT `c_sysmaps_elements_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_elements_2` FOREIGN KEY (`iconid_off`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_3` FOREIGN KEY (`iconid_on`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_4` FOREIGN KEY (`iconid_disabled`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_5` FOREIGN KEY (`iconid_maintenance`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_elements`
--

LOCK TABLES `sysmaps_elements` WRITE;
/*!40000 ALTER TABLE `sysmaps_elements` DISABLE KEYS */;
INSERT INTO `sysmaps_elements` VALUES (1,1,10084,0,185,NULL,'{HOST.NAME}\r\n{HOST.CONN}',0,111,61,NULL,NULL,0,0,200,200,0,0,'');
/*!40000 ALTER TABLE `sysmaps_elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_link_triggers`
--

DROP TABLE IF EXISTS `sysmaps_link_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps_link_triggers` (
  `linktriggerid` bigint(20) unsigned NOT NULL,
  `linkid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT '0',
  `color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '000000',
  PRIMARY KEY (`linktriggerid`),
  UNIQUE KEY `sysmaps_link_triggers_1` (`linkid`,`triggerid`),
  KEY `sysmaps_link_triggers_2` (`triggerid`),
  CONSTRAINT `c_sysmaps_link_triggers_1` FOREIGN KEY (`linkid`) REFERENCES `sysmaps_links` (`linkid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_link_triggers_2` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_link_triggers`
--

LOCK TABLES `sysmaps_link_triggers` WRITE;
/*!40000 ALTER TABLE `sysmaps_link_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps_link_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_links`
--

DROP TABLE IF EXISTS `sysmaps_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps_links` (
  `linkid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `selementid1` bigint(20) unsigned NOT NULL,
  `selementid2` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT '0',
  `color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '000000',
  `label` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`linkid`),
  KEY `sysmaps_links_1` (`sysmapid`),
  KEY `sysmaps_links_2` (`selementid1`),
  KEY `sysmaps_links_3` (`selementid2`),
  CONSTRAINT `c_sysmaps_links_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_links_2` FOREIGN KEY (`selementid1`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_links_3` FOREIGN KEY (`selementid2`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_links`
--

LOCK TABLES `sysmaps_links` WRITE;
/*!40000 ALTER TABLE `sysmaps_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag_filter`
--

DROP TABLE IF EXISTS `tag_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_filter` (
  `tag_filterid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`tag_filterid`),
  KEY `c_tag_filter_1` (`usrgrpid`),
  KEY `c_tag_filter_2` (`groupid`),
  CONSTRAINT `c_tag_filter_1` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE,
  CONSTRAINT `c_tag_filter_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_filter`
--

LOCK TABLES `tag_filter` WRITE;
/*!40000 ALTER TABLE `tag_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `taskid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `clock` int(11) NOT NULL DEFAULT '0',
  `ttl` int(11) NOT NULL DEFAULT '0',
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`taskid`),
  KEY `task_1` (`status`,`proxy_hostid`),
  KEY `c_task_1` (`proxy_hostid`),
  CONSTRAINT `c_task_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_acknowledge`
--

DROP TABLE IF EXISTS `task_acknowledge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_acknowledge` (
  `taskid` bigint(20) unsigned NOT NULL,
  `acknowledgeid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_acknowledge_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_acknowledge`
--

LOCK TABLES `task_acknowledge` WRITE;
/*!40000 ALTER TABLE `task_acknowledge` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_acknowledge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_check_now`
--

DROP TABLE IF EXISTS `task_check_now`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_check_now` (
  `taskid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_check_now_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_check_now`
--

LOCK TABLES `task_check_now` WRITE;
/*!40000 ALTER TABLE `task_check_now` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_check_now` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_close_problem`
--

DROP TABLE IF EXISTS `task_close_problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_close_problem` (
  `taskid` bigint(20) unsigned NOT NULL,
  `acknowledgeid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_close_problem_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_close_problem`
--

LOCK TABLES `task_close_problem` WRITE;
/*!40000 ALTER TABLE `task_close_problem` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_close_problem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_remote_command`
--

DROP TABLE IF EXISTS `task_remote_command`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_remote_command` (
  `taskid` bigint(20) unsigned NOT NULL,
  `command_type` int(11) NOT NULL DEFAULT '0',
  `execute_on` int(11) NOT NULL DEFAULT '0',
  `port` int(11) NOT NULL DEFAULT '0',
  `authtype` int(11) NOT NULL DEFAULT '0',
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `password` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `publickey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `privatekey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `command` text COLLATE utf8_bin NOT NULL,
  `alertid` bigint(20) unsigned DEFAULT NULL,
  `parent_taskid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_remote_command_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_remote_command`
--

LOCK TABLES `task_remote_command` WRITE;
/*!40000 ALTER TABLE `task_remote_command` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_remote_command` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_remote_command_result`
--

DROP TABLE IF EXISTS `task_remote_command_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_remote_command_result` (
  `taskid` bigint(20) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `parent_taskid` bigint(20) unsigned NOT NULL,
  `info` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_remote_command_result_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_remote_command_result`
--

LOCK TABLES `task_remote_command_result` WRITE;
/*!40000 ALTER TABLE `task_remote_command_result` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_remote_command_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeperiods`
--

DROP TABLE IF EXISTS `timeperiods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeperiods` (
  `timeperiodid` bigint(20) unsigned NOT NULL,
  `timeperiod_type` int(11) NOT NULL DEFAULT '0',
  `every` int(11) NOT NULL DEFAULT '1',
  `month` int(11) NOT NULL DEFAULT '0',
  `dayofweek` int(11) NOT NULL DEFAULT '0',
  `day` int(11) NOT NULL DEFAULT '0',
  `start_time` int(11) NOT NULL DEFAULT '0',
  `period` int(11) NOT NULL DEFAULT '0',
  `start_date` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`timeperiodid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeperiods`
--

LOCK TABLES `timeperiods` WRITE;
/*!40000 ALTER TABLE `timeperiods` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeperiods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trends`
--

DROP TABLE IF EXISTS `trends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trends` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `num` int(11) NOT NULL DEFAULT '0',
  `value_min` double(16,4) NOT NULL DEFAULT '0.0000',
  `value_avg` double(16,4) NOT NULL DEFAULT '0.0000',
  `value_max` double(16,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trends`
--

LOCK TABLES `trends` WRITE;
/*!40000 ALTER TABLE `trends` DISABLE KEYS */;
/*!40000 ALTER TABLE `trends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trends_uint`
--

DROP TABLE IF EXISTS `trends_uint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trends_uint` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `num` int(11) NOT NULL DEFAULT '0',
  `value_min` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_avg` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_max` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trends_uint`
--

LOCK TABLES `trends_uint` WRITE;
/*!40000 ALTER TABLE `trends_uint` DISABLE KEYS */;
/*!40000 ALTER TABLE `trends_uint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_depends`
--

DROP TABLE IF EXISTS `trigger_depends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trigger_depends` (
  `triggerdepid` bigint(20) unsigned NOT NULL,
  `triggerid_down` bigint(20) unsigned NOT NULL,
  `triggerid_up` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`triggerdepid`),
  UNIQUE KEY `trigger_depends_1` (`triggerid_down`,`triggerid_up`),
  KEY `trigger_depends_2` (`triggerid_up`),
  CONSTRAINT `c_trigger_depends_1` FOREIGN KEY (`triggerid_down`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_trigger_depends_2` FOREIGN KEY (`triggerid_up`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_depends`
--

LOCK TABLES `trigger_depends` WRITE;
/*!40000 ALTER TABLE `trigger_depends` DISABLE KEYS */;
INSERT INTO `trigger_depends` VALUES (4422,14195,14205),(4423,14196,14195),(4424,14196,14205),(4425,14197,14205),(4426,14198,14197),(4427,14198,14205),(4428,14200,14199),(4429,14201,14205),(4430,14202,14201),(4431,14202,14205),(4432,14204,14203),(4433,14206,14222),(4434,14207,14206),(4435,14207,14222),(4436,14208,14222),(4437,14209,14208),(4438,14209,14222),(4439,14210,14222),(4440,14211,14210),(4441,14211,14222),(4442,14212,14222),(4443,14213,14212),(4444,14213,14222),(4445,14214,14222),(4446,14215,14214),(4447,14215,14222),(4448,14217,14216),(4449,14218,14222),(4450,14219,14218),(4451,14219,14222),(4452,14220,14222),(4453,14221,14220),(4454,14221,14222),(4455,14223,14222),(4456,14224,14222),(4457,14224,14223),(4458,14225,14222),(4459,14226,14222),(4460,14226,14225),(4164,14246,14245),(4165,14250,14249),(4021,14252,14251),(4079,14253,14251),(4050,14253,14252),(4022,14289,14288),(4080,14290,14288),(4051,14290,14289),(4025,14294,14293),(4083,14295,14293),(4054,14295,14294),(4026,14312,14311),(4084,14313,14311),(4055,14313,14312),(4259,14318,14319),(4027,14328,14327),(4085,14329,14327),(4056,14329,14328),(4028,14348,14347),(4086,14349,14347),(4057,14349,14348),(4029,14357,14356),(4087,14358,14356),(4058,14358,14357),(4276,14372,14373),(4277,14375,14376),(4280,14380,14381),(4030,14390,14389),(4088,14391,14389),(4059,14391,14390),(4031,14404,14403),(4089,14405,14403),(4060,14405,14404),(4032,14452,14451),(4090,14453,14451),(4061,14453,14452),(4295,14460,14461),(4033,14469,14468),(4091,14470,14468),(4062,14470,14469),(4296,14476,14477),(4034,14487,14486),(4092,14488,14486),(4063,14488,14487),(4297,14495,14496),(4035,14506,14505),(4093,14507,14505),(4064,14507,14506),(4298,14511,15368),(4023,14525,14524),(4081,14526,14524),(4052,14526,14525),(4036,14535,14534),(4094,14536,14534),(4065,14536,14535),(4037,14545,14544),(4095,14546,14544),(4066,14546,14545),(4299,14551,14552),(4038,14583,14582),(4096,14584,14582),(4067,14584,14583),(4303,14589,14590),(4039,14599,14598),(4097,14600,14598),(4068,14600,14599),(4040,14616,14615),(4098,14617,14615),(4069,14617,14616),(4306,14624,14625),(4041,14653,14652),(4099,14654,14652),(4070,14654,14653),(4308,14658,14659),(4309,14664,14665),(4310,14668,14667),(4042,14674,14673),(4100,14675,14673),(4071,14675,14674),(4043,14692,14691),(4101,14693,14691),(4072,14693,14692),(4044,14705,14704),(4102,14706,14704),(4073,14706,14705),(4024,14718,14717),(4082,14719,14717),(4053,14719,14718),(4166,14862,14861),(4045,14870,14869),(4103,14871,14869),(4074,14871,14870),(4167,14876,14875),(4046,14883,14882),(4104,14884,14882),(4075,14884,14883),(4047,14907,14906),(4105,14908,14906),(4076,14908,14907),(4300,14914,14915),(4168,14922,14921),(4048,14929,14928),(4106,14930,14928),(4077,14930,14929),(4111,15161,14288),(4112,15162,14524),(4113,15163,14717),(4139,15170,14293),(4140,15171,14311),(4141,15172,14327),(4142,15173,14347),(4143,15174,14356),(4144,15175,14389),(4145,15176,14403),(4146,15177,14451),(4147,15178,14468),(4148,15179,14486),(4149,15180,14505),(4150,15181,14534),(4151,15182,14544),(4152,15183,14582),(4153,15184,14598),(4154,15185,14615),(4155,15186,14652),(4156,15187,14673),(4157,15188,14691),(4158,15189,14704),(4159,15190,14869),(4160,15191,14882),(4161,15192,14906),(4162,15193,14928),(4049,15221,15220),(4107,15222,15220),(4078,15222,15221),(4163,15224,15220),(4293,15332,15331),(4294,15334,15333),(4304,15335,15336),(4305,15338,15337),(4281,15342,15343),(4282,15345,15344),(4283,15347,15346),(4284,15348,15351),(4285,15349,15352),(4286,15350,15353),(4287,15357,15354),(4288,15358,15355),(4289,15359,15356),(4290,15363,15360),(4291,15364,15361),(4292,15365,15362),(4301,15374,15373),(4302,15376,15375),(4274,15380,15379),(4275,15382,15381),(4278,15384,15383),(4279,15386,15385),(4307,15387,14934),(4271,15390,14339),(4272,15392,15391),(4273,15394,15393),(4311,15396,15397),(4461,15550,15490),(4462,15551,15490),(4464,15553,15492),(4465,15554,15493),(4466,15555,15492),(4467,15556,15493),(4470,15559,15496),(4471,15560,15496),(4473,15562,15498),(4474,15563,15499),(4475,15564,15498),(4476,15565,15499),(4548,15568,15502),(4549,15569,15502),(4551,15571,15504),(4552,15572,15504),(4479,15574,15506),(4480,15575,15506),(4482,15577,15508),(4483,15578,15508),(4485,15580,15510),(4486,15581,15511),(4487,15582,15512),(4488,15583,15513),(4489,15584,15514),(4490,15585,15515),(4491,15586,15516),(4492,15587,15517),(4493,15588,15518),(4494,15589,15519),(4495,15590,15520),(4496,15591,15521),(4497,15592,15522),(4498,15593,15523),(4499,15594,15524),(4500,15595,15525),(4501,15596,15526),(4502,15597,15527),(4503,15598,15528),(4504,15599,15529),(4506,15600,15510),(4507,15601,15511),(4508,15602,15512),(4509,15603,15513),(4510,15604,15514),(4511,15605,15515),(4512,15606,15516),(4513,15607,15517),(4514,15608,15518),(4515,15609,15519),(4516,15610,15520),(4517,15611,15521),(4518,15612,15522),(4519,15613,15523),(4520,15614,15524),(4521,15615,15525),(4522,15616,15526),(4523,15617,15527),(4524,15618,15528),(4525,15619,15529),(4108,15642,15161),(4109,15643,15162),(4110,15644,15163),(4114,15645,15170),(4115,15646,15171),(4116,15647,15172),(4117,15648,15173),(4118,15649,15174),(4119,15650,15175),(4120,15651,15176),(4121,15652,15177),(4122,15653,15178),(4123,15654,15179),(4124,15655,15180),(4125,15656,15181),(4126,15657,15182),(4127,15658,15183),(4128,15659,15184),(4129,15660,15185),(4130,15661,15186),(4131,15662,15187),(4132,15663,15188),(4133,15664,15189),(4134,15665,15190),(4135,15666,15191),(4136,15667,15192),(4137,15668,15193),(4138,15669,15224),(4481,15670,15506),(4484,15671,15508),(4527,15672,15510),(4528,15673,15511),(4529,15674,15512),(4530,15675,15513),(4531,15676,15514),(4532,15677,15515),(4533,15678,15516),(4534,15679,15517),(4535,15680,15518),(4536,15681,15519),(4537,15682,15520),(4538,15683,15521),(4539,15684,15522),(4540,15685,15523),(4541,15686,15524),(4542,15687,15525),(4543,15688,15526),(4544,15689,15527),(4545,15690,15528),(4546,15691,15529),(4463,15692,15490),(4468,15693,15492),(4469,15694,15493),(4472,15695,15496),(4477,15696,15498),(4478,15697,15499),(4550,15698,15502),(4553,15699,15504),(4260,15702,15701),(4261,15703,15701),(4262,15703,15702),(4263,15704,15705),(4264,15705,15701),(4526,15706,15709),(4505,15707,15709),(4547,15708,15709),(4268,15713,15712),(4269,15714,15715),(4270,15721,15720),(4312,15724,15723),(4313,15725,15723),(4314,15725,15724),(4315,15726,15727),(4316,15727,15723),(4317,15729,15728),(4318,15730,15728),(4319,15730,15729),(4320,15733,15734),(4321,15736,15737),(4322,15740,15739),(4323,15742,15741),(4324,15744,15743),(4325,15746,15743),(4326,15748,15747),(4327,15750,15749),(4329,15751,15749),(4328,15751,15750),(4330,15752,15754),(4332,15753,15752),(4331,15753,15754),(4333,15756,15755),(4334,15757,15755),(4335,15757,15756),(4336,15758,15759),(4337,15759,15755),(4338,15761,15760),(4339,15763,15764),(4340,15766,15767),(4341,15769,15770),(4342,15772,15773),(4343,15775,15776),(4344,15778,15779),(4345,15782,15781),(4346,15784,15783),(4347,15786,15785),(4348,15788,15787),(4349,15789,15787),(4350,15789,15788),(4351,15791,15790),(4352,15793,15792),(4353,15794,15792),(4354,15797,15796),(4355,15799,15798),(4356,15800,15798),(4357,15800,15799),(4359,15801,15802),(4358,15802,15798),(4360,15804,15803),(4361,15805,15803),(4362,15805,15804),(4363,15807,15808),(4364,15810,15811),(4365,15813,15814),(4366,15820,15819),(4367,15821,15819),(4368,15821,15820),(4369,15822,15823),(4370,15823,15819),(4371,15825,15824),(4372,15826,15824),(4373,15826,15825),(4374,15828,15829),(4375,15831,15832),(4376,15834,15835),(4377,15841,15840),(4378,15842,15840),(4379,15842,15841),(4380,15843,15844),(4381,15844,15840),(4382,15845,15846);
/*!40000 ALTER TABLE `trigger_depends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_discovery`
--

DROP TABLE IF EXISTS `trigger_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trigger_discovery` (
  `triggerid` bigint(20) unsigned NOT NULL,
  `parent_triggerid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`triggerid`),
  KEY `trigger_discovery_1` (`parent_triggerid`),
  CONSTRAINT `c_trigger_discovery_1` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_trigger_discovery_2` FOREIGN KEY (`parent_triggerid`) REFERENCES `triggers` (`triggerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_discovery`
--

LOCK TABLES `trigger_discovery` WRITE;
/*!40000 ALTER TABLE `trigger_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `trigger_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_tag`
--

DROP TABLE IF EXISTS `trigger_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trigger_tag` (
  `triggertagid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`triggertagid`),
  KEY `trigger_tag_1` (`triggerid`),
  CONSTRAINT `c_trigger_tag_1` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_tag`
--

LOCK TABLES `trigger_tag` WRITE;
/*!40000 ALTER TABLE `trigger_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `trigger_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `triggers`
--

DROP TABLE IF EXISTS `triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `triggers` (
  `triggerid` bigint(20) unsigned NOT NULL,
  `expression` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0',
  `lastchange` int(11) NOT NULL DEFAULT '0',
  `comments` text COLLATE utf8_bin NOT NULL,
  `error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  `recovery_mode` int(11) NOT NULL DEFAULT '0',
  `recovery_expression` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `correlation_mode` int(11) NOT NULL DEFAULT '0',
  `correlation_tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `manual_close` int(11) NOT NULL DEFAULT '0',
  `details` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`triggerid`),
  KEY `triggers_1` (`status`),
  KEY `triggers_2` (`value`,`lastchange`),
  KEY `triggers_3` (`templateid`),
  CONSTRAINT `c_triggers_1` FOREIGN KEY (`templateid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `triggers`
--

LOCK TABLES `triggers` WRITE;
/*!40000 ALTER TABLE `triggers` DISABLE KEYS */;
INSERT INTO `triggers` VALUES (10010,'{13078}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(10011,'{13084}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(10012,'{12580}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',NULL,0,0,0,0,'',0,'',0,''),(10016,'{10199}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(10021,'{12583}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(10041,'{10204}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(10042,'{12553}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(10043,'{10208}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(10044,'{10207}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(10045,'{12927}>0','Version of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0,0,'',0,'',0,''),(10047,'{12550}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0,0,'',0,'',0,''),(10190,'{13082}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13000,'{12144}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13015,'{12641}>75','More than 75% used in the configuration cache','',0,0,3,0,'Consider increasing CacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(13017,'{12651}>75','More than 75% used in the history index cache','',0,0,3,0,'Consider increasing HistoryIndexCacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(13019,'{12649}>75','More than 75% used in the trends cache','',0,0,3,0,'Consider increasing TrendCacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(13023,'{12653}>100','More than 100 items having missing data for more than 10 minutes','',0,0,2,0,'zabbix[queue,10m] item is collecting data about how many items are missing data for more than 10 minutes','',NULL,0,0,0,0,'',0,'',0,''),(13025,'{12549}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13026,'{12926}>0','Version of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13073,'{12645}>75','More than 75% used in the history cache','',0,0,3,0,'Consider increasing HistoryCacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(13074,'{12646}>95','More than 95% used in the value cache','',0,0,3,0,'Consider increasing ValueCacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(13075,'{12648}>95','More than 95% used in the value cache','',0,0,3,0,'Consider increasing ValueCacheSize in the zabbix_server.conf configuration file','',13074,0,0,0,0,'',0,'',0,''),(13080,'{13164}>75','Zabbix alerter processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13164}<65',0,'',0,''),(13081,'{13170}>75','Zabbix configuration syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13170}<65',0,'',0,''),(13083,'{13172}>75','Zabbix discoverer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13172}<65',0,'',0,''),(13084,'{13174}>75','Zabbix escalator processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13174}<65',0,'',0,''),(13085,'{13176}>75','Zabbix history syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13176}<65',0,'',0,''),(13086,'{13178}>75','Zabbix housekeeper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13178}<65',0,'',0,''),(13087,'{13180}>75','Zabbix http poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13180}<65',0,'',0,''),(13088,'{13182}>75','Zabbix icmp pinger processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13182}<65',0,'',0,''),(13089,'{13184}>75','Zabbix ipmi poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13184}<65',0,'',0,''),(13091,'{13188}>75','Zabbix poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13188}<65',0,'',0,''),(13092,'{13190}>75','Zabbix proxy poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13190}<65',0,'',0,''),(13093,'{13192}>75','Zabbix self-monitoring processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13192}<65',0,'',0,''),(13094,'{13198}>75','Zabbix timer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13198}<65',0,'',0,''),(13095,'{13200}>75','Zabbix trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13200}<65',0,'',0,''),(13096,'{13202}>75','Zabbix unreachable poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13202}<65',0,'',0,''),(13097,'{13204}>75','Zabbix vmware collector processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13204}<65',0,'',0,''),(13243,'{13080}>20','Disk I/O is overloaded on {HOST.NAME}','',0,0,2,0,'OS spends significant time waiting for I/O (input/output) operations. It could be indicator of performance issues with storage system.','',NULL,0,0,0,0,'',0,'',0,''),(13266,'{12592}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0,''),(13272,'{12598}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0,''),(13275,'{13186}>75','Zabbix java poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13186}<65',0,'',0,''),(13285,'{13159}=0','Telnet service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13328,'{12715}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0,0,'',0,'',0,''),(13329,'{12929}>0','Version of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0,0,'',0,'',0,''),(13330,'{12717}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13331,'{12718}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13332,'{13089}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13333,'{13088}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13334,'{13087}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13336,'{12723}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13337,'{12724}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',NULL,0,0,0,0,'',0,'',0,''),(13338,'{12725}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13339,'{12726}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13340,'{12727}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13341,'{12728}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13342,'{12729}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0,''),(13343,'{12730}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0,''),(13344,'{12731}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0,0,'',0,'',0,''),(13345,'{12930}>0','Version of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0,0,'',0,'',0,''),(13346,'{12733}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13347,'{12734}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13348,'{13074}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13349,'{13073}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13350,'{13072}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13352,'{12739}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13353,'{12740}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',NULL,0,0,0,0,'',0,'',0,''),(13354,'{12741}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13355,'{12742}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13356,'{12743}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13357,'{12744}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13358,'{12745}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0,''),(13359,'{12746}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0,''),(13360,'{12747}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0,0,'',0,'',0,''),(13361,'{12931}>0','Version of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0,0,'',0,'',0,''),(13364,'{13071}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13365,'{13070}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13366,'{13069}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13367,'{13068}>20','Disk I/O is overloaded on {HOST.NAME}','',0,0,2,0,'OS spends significant time waiting for I/O (input/output) operations. It could be indicator of performance issues with storage system.','',NULL,0,0,0,0,'',0,'',0,''),(13368,'{12755}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13370,'{12757}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13371,'{12758}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13372,'{12759}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13373,'{12760}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13374,'{12761}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0,''),(13375,'{12762}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0,''),(13376,'{12763}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0,0,'',0,'',0,''),(13377,'{12932}>0','Version of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0,0,'',0,'',0,''),(13382,'{13075}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13384,'{12771}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13386,'{12773}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13388,'{12775}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13389,'{12776}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13390,'{12777}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0,''),(13391,'{12778}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0,''),(13392,'{12779}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0,0,'',0,'',0,''),(13393,'{12933}>0','Version of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0,0,'',0,'',0,''),(13395,'{12782}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13396,'{13093}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13397,'{13092}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13398,'{13091}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13399,'{13090}>20','Disk I/O is overloaded on {HOST.NAME}','',0,0,2,0,'OS spends significant time waiting for I/O (input/output) operations. It could be indicator of performance issues with storage system.','',NULL,0,0,0,0,'',0,'',0,''),(13400,'{12787}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13401,'{12788}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',NULL,0,0,0,0,'',0,'',0,''),(13402,'{12789}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13403,'{12790}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13404,'{12791}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13405,'{12792}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13406,'{12793}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0,''),(13407,'{12794}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0,''),(13408,'{12795}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0,0,'',0,'',0,''),(13409,'{12934}>0','Version of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0,0,'',0,'',0,''),(13410,'{12797}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13411,'{12798}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13414,'{13086}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13416,'{12803}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13418,'{12805}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13419,'{12806}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13420,'{12807}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13421,'{12808}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13422,'{12809}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0,''),(13423,'{12810}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0,''),(13425,'{12812}>0','Host information was changed on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13428,'{12815}<0','{HOST.NAME} has just been restarted','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13430,'{13095}>300','Too many processes on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13431,'{12818}<10','Lack of available virtual memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,1,'{12818}>20',0,'',0,''),(13433,'{12820}<10000','Lack of free memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13435,'{13094}>5','Processor load is too high on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13436,'{13205}>75','Zabbix vmware collector processes more than 75% busy','',0,0,3,0,'','Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:zabbix[process,vmware collector,avg,busy].avg(10m)\": item is not supported.\".',13097,0,1,0,1,'{13205}<65',0,'',0,''),(13437,'{12824}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0,0,'',0,'',0,''),(13438,'{12935}>0','Version of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0,0,'',0,'',0,''),(13439,'{12826}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0,''),(13441,'{13194}>75','Zabbix snmp trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13194}<65',0,'',0,''),(13467,'{13165}>75','Zabbix alerter processes more than 75% busy','',0,0,3,0,'','',13080,0,0,0,1,'{13165}<65',0,'',0,''),(13468,'{13171}>75','Zabbix configuration syncer processes more than 75% busy','',0,0,3,0,'','',13081,0,0,0,1,'{13171}<65',0,'',0,''),(13470,'{13173}>75','Zabbix discoverer processes more than 75% busy','',0,0,3,0,'','',13083,0,0,0,1,'{13173}<65',0,'',0,''),(13471,'{13175}>75','Zabbix escalator processes more than 75% busy','',0,0,3,0,'','',13084,0,0,0,1,'{13175}<65',0,'',0,''),(13472,'{13177}>75','Zabbix history syncer processes more than 75% busy','',0,0,3,0,'','',13085,0,0,0,1,'{13177}<65',0,'',0,''),(13473,'{13179}>75','Zabbix housekeeper processes more than 75% busy','',0,0,3,0,'','',13086,0,0,0,1,'{13179}<65',0,'',0,''),(13474,'{13181}>75','Zabbix http poller processes more than 75% busy','',0,0,3,0,'','',13087,0,0,0,1,'{13181}<65',0,'',0,''),(13475,'{13183}>75','Zabbix icmp pinger processes more than 75% busy','',0,0,3,0,'','',13088,0,0,0,1,'{13183}<65',0,'',0,''),(13476,'{13185}>75','Zabbix ipmi poller processes more than 75% busy','',0,0,3,0,'','Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:zabbix[process,ipmi poller,avg,busy].avg(10m)\": item is not supported.\".',13089,0,1,0,1,'{13185}<65',0,'',0,''),(13477,'{13187}>75','Zabbix java poller processes more than 75% busy','',0,0,3,0,'','Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:zabbix[process,java poller,avg,busy].avg(10m)\": item is not supported.\".',13275,0,1,0,1,'{13187}<65',0,'',0,''),(13479,'{13189}>75','Zabbix poller processes more than 75% busy','',0,0,3,0,'','',13091,0,0,0,1,'{13189}<65',0,'',0,''),(13480,'{13191}>75','Zabbix proxy poller processes more than 75% busy','',0,0,3,0,'','',13092,0,0,0,1,'{13191}<65',0,'',0,''),(13481,'{13193}>75','Zabbix self-monitoring processes more than 75% busy','',0,0,3,0,'','',13093,0,0,0,1,'{13193}<65',0,'',0,''),(13482,'{13195}>75','Zabbix snmp trapper processes more than 75% busy','',0,0,3,0,'','Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:zabbix[process,snmp trapper,avg,busy].avg(10m)\": item is not supported.\".',13441,0,1,0,1,'{13195}<65',0,'',0,''),(13483,'{13199}>75','Zabbix timer processes more than 75% busy','',0,0,3,0,'','',13094,0,0,0,1,'{13199}<65',0,'',0,''),(13484,'{13201}>75','Zabbix trapper processes more than 75% busy','',0,0,3,0,'','',13095,0,0,0,1,'{13201}<65',0,'',0,''),(13485,'{13203}>75','Zabbix unreachable poller processes more than 75% busy','',0,0,3,0,'','',13096,0,0,0,1,'{13203}<65',0,'',0,''),(13486,'{12895}>100','More than 100 items having missing data for more than 10 minutes','',0,0,2,0,'zabbix[queue,10m] item is collecting data about how many items are missing data for more than 10 minutes','',13023,0,0,0,0,'',0,'',0,''),(13487,'{12896}>75','More than 75% used in the configuration cache','',0,0,3,0,'Consider increasing CacheSize in the zabbix_server.conf configuration file','',13015,0,0,0,0,'',0,'',0,''),(13488,'{12897}>75','More than 75% used in the history cache','',0,0,3,0,'Consider increasing HistoryCacheSize in the zabbix_server.conf configuration file','',13073,0,0,0,0,'',0,'',0,''),(13489,'{12898}>75','More than 75% used in the history index cache','',0,0,3,0,'Consider increasing HistoryIndexCacheSize in the zabbix_server.conf configuration file','',13017,0,0,0,0,'',0,'',0,''),(13490,'{12899}>75','More than 75% used in the trends cache','',0,0,3,0,'Consider increasing TrendCacheSize in the zabbix_server.conf configuration file','',13019,0,0,0,0,'',0,'',0,''),(13491,'{12900}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',10047,0,0,0,0,'',0,'',0,''),(13492,'{12928}>0','Version of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',10045,0,0,0,0,'',0,'',0,''),(13493,'{12902}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',10042,0,0,0,0,'',0,'',0,''),(13494,'{12903}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',10041,0,0,0,0,'',0,'',0,''),(13495,'{13085}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',10011,0,0,0,0,'',0,'',0,''),(13496,'{13083}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',10190,0,0,0,0,'',0,'',0,''),(13497,'{13079}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',10010,0,0,0,0,'',0,'',0,''),(13498,'{13081}>20','Disk I/O is overloaded on {HOST.NAME}','',0,0,2,0,'OS spends significant time waiting for I/O (input/output) operations. It could be indicator of performance issues with storage system.','',13243,0,0,0,0,'',0,'',0,''),(13499,'{12908}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',10043,0,0,0,0,'',0,'',0,''),(13500,'{12909}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',10012,0,0,0,0,'',0,'',0,''),(13501,'{12910}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',10044,0,0,0,0,'',0,'',0,''),(13502,'{12911}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:system.uptime.change(0)\": cannot get values from value cache.\".',10021,0,1,0,0,'',0,'',0,''),(13503,'{12912}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',10016,0,0,0,0,'',0,'',0,''),(13504,'{12913}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',13000,0,0,0,0,'',0,'',0,''),(13505,'{12914}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',13272,0,0,2,0,'',0,'',0,''),(13506,'{12915}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',13266,0,0,2,0,'',0,'',0,''),(13507,'{12936}>0','Host name of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13508,'{12937}>0','Host name of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0,0,'',0,'',0,''),(13509,'{12938}>0','Host name of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',13508,0,0,0,0,'',0,'',0,''),(13510,'{12939}>0','Host name of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0,0,'',0,'',0,''),(13511,'{12940}>0','Host name of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0,0,'',0,'',0,''),(13512,'{12941}>0','Host name of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0,0,'',0,'',0,''),(13513,'{12942}>0','Host name of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0,0,'',0,'',0,''),(13514,'{12943}>0','Host name of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0,0,'',0,'',0,''),(13515,'{12944}>0','Host name of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0,0,'',0,'',0,''),(13516,'{12945}>0','Host name of Zabbix agent was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0,0,'',0,'',0,''),(13517,'{12946}>75','More than 75% used in the configuration cache','',0,0,3,0,'Consider increasing CacheSize in the zabbix_proxy.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(13518,'{12947}>75','More than 75% used in the history cache','',0,0,3,0,'Consider increasing HistoryCacheSize in the zabbix_proxy.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(13519,'{12948}>75','More than 75% used in the history index cache','',0,0,3,0,'Consider increasing HistoryIndexCacheSize in the zabbix_proxy.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(13520,'{12949}>100','More than 100 items having missing data for more than 10 minutes','',0,0,2,0,'zabbix[queue,10m] item is collecting data about how many items are missing data for more than 10 minutes','',NULL,0,0,0,0,'',0,'',0,''),(13521,'{13206}>75','Zabbix configuration syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13206}<65',0,'',0,''),(13522,'{13208}>75','Zabbix discoverer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13208}<65',0,'',0,''),(13523,'{13210}>75','Zabbix history syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13210}<65',0,'',0,''),(13524,'{13211}>75','Zabbix housekeeper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13211}<65',0,'',0,''),(13525,'{13212}>75','Zabbix http poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13212}<65',0,'',0,''),(13526,'{13213}>75','Zabbix icmp pinger processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13213}<65',0,'',0,''),(13527,'{13214}>75','Zabbix ipmi poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13214}<65',0,'',0,''),(13528,'{13215}>75','Zabbix java poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13215}<65',0,'',0,''),(13529,'{13216}>75','Zabbix poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13216}<65',0,'',0,''),(13530,'{13217}>75','Zabbix self-monitoring processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13217}<65',0,'',0,''),(13531,'{13218}>75','Zabbix snmp trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13218}<65',0,'',0,''),(13532,'{13219}>75','Zabbix trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13219}<65',0,'',0,''),(13533,'{13220}>75','Zabbix unreachable poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13220}<65',0,'',0,''),(13534,'{13207}>75','Zabbix data sender processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13207}<65',0,'',0,''),(13535,'{13209}>75','Zabbix heartbeat sender processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13209}<65',0,'',0,''),(13536,'{12965}>75','More than 75% used in the vmware cache','',0,0,3,0,'Consider increasing VMwareCacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(13537,'{12966}>75','More than 75% used in the vmware cache','',0,0,3,0,'Consider increasing VMwareCacheSize in the zabbix_server.conf configuration file','Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:zabbix[vmware,buffer,pused].max(10m)\": item is not supported.\".',13536,0,1,0,0,'',0,'',0,''),(13544,'{12994}=0','FTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13545,'{12995}=0','HTTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13546,'{12996}=0','HTTPS service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13547,'{12997}=0','IMAP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13548,'{12998}=0','LDAP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13549,'{13154}=0','NNTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13550,'{13156}=0','NTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13551,'{13152}=0','POP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13552,'{13157}=0','SMTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13553,'{13158}=0','SSH service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13557,'{13160}=1','Zabbix value cache working in low memory mode','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0,''),(13558,'{13161}=1','Zabbix value cache working in low memory mode','',0,0,4,0,'','',13557,0,0,0,0,'',0,'',0,''),(13559,'{13196}>75','Zabbix task manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13196}<65',0,'',0,''),(13560,'{13197}>75','Zabbix task manager processes more than 75% busy','',0,0,3,1564099404,'','',13559,0,0,0,1,'{13197}<65',0,'',0,''),(13561,'{13221}<>0','Service \"{#SERVICE.NAME}\" ({#SERVICE.DISPLAYNAME}) is not running (startup type {#SERVICE.STARTUPNAME})','',0,0,3,0,'','',NULL,0,0,2,0,'',0,'',0,''),(13562,'{13222}>75','Zabbix ipmi manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13222}<65',0,'',0,''),(13563,'{13223}>75','Zabbix ipmi manager processes more than 75% busy','',0,0,3,0,'','Cannot evaluate expression: \"Cannot evaluate function \"Zabbix server:zabbix[process,ipmi manager,avg,busy].avg(10m)\": item is not supported.\".',13562,0,1,0,1,'{13223}<65',0,'',0,''),(13564,'{13224}>75','Zabbix ipmi manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13224}<65',0,'',0,''),(13565,'{13225}>75','Zabbix task manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13225}<65',0,'',0,''),(13566,'{13226}>75','Zabbix alert manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13226}<65',0,'',0,''),(13567,'{13227}>75','Zabbix alert manager processes more than 75% busy','',0,0,3,0,'','',13566,0,0,0,1,'{13227}<65',0,'',0,''),(13568,'{13228}>75','Zabbix preprocessing manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13228}<65',0,'',0,''),(13569,'{13229}>75','Zabbix preprocessing worker processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13229}<65',0,'',0,''),(13570,'{13230}>75','Zabbix preprocessing manager processes more than 75% busy','',0,0,3,0,'','',13568,0,0,0,1,'{13230}<65',0,'',0,''),(13571,'{13231}>75','Zabbix preprocessing worker processes more than 75% busy','',0,0,3,0,'','',13569,0,0,0,1,'{13231}<65',0,'',0,''),(14168,'{14257}>({14258}*0.7)','70% mem Heap Memory used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14169,'{14259}>({14260}*0.7)','70% mem Non-Heap Memory used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14170,'{14261}>({14262}*0.7)','70% mp CMS Old Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14171,'{14263}>({14264}*0.7)','70% mp CMS Perm Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14172,'{14265}>({14266}*0.7)','70% mp Code Cache used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14173,'{14267}>({14268}*0.7)','70% mp Perm Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14174,'{14269}>({14270}*0.7)','70% mp PS Old Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14175,'{14271}>({14272}*0.7)','70% mp PS Perm Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14176,'{14273}>({14274}*0.7)','70% mp Tenured Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14177,'{14275}>({14276}*0.7)','70% os Opened File Descriptor Count used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14178,'{14277}>70','70% os Process CPU Load on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14179,'{14278}<{14279}','gc Concurrent Mark Sweep in fire fighting mode on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14180,'{14280}<{14281}','gc Mark Sweep Compact in fire fighting mode on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14181,'{14282}<{14283}','gc PS Mark Sweep in fire fighting mode on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14182,'{14284}={14285}','mem Heap Memory fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14183,'{14286}={14287}','mem Non-Heap Memory fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14184,'{14288}={14289}','mp CMS Old Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14185,'{14290}={14291}','mp CMS Perm Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14186,'{14292}={14293}','mp Code Cache fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14187,'{14294}={14295}','mp Perm Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14188,'{14296}={14297}','mp PS Old Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14189,'{14298}={14299}','mp PS Perm Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14190,'{14300}={14301}','mp Tenured Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14191,'{14302}=1','{HOST.NAME} is not reachable','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14192,'{14303}<>1','{HOST.NAME} runs suboptimal VM type','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14193,'{14304}=1','{HOST.NAME} uses suboptimal JIT compiler','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14194,'{14305}=0','MySQL is down','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14195,'{14306}<1.597 or {14306}>2.019','BB +1.8V SM Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14196,'{14307}<1.646 or {14307}>1.960','BB +1.8V SM Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14197,'{14308}<2.876 or {14308}>3.729','BB +3.3V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14198,'{14309}<2.970 or {14309}>3.618','BB +3.3V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14199,'{14310}<2.876 or {14310}>3.729','BB +3.3V STBY Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14200,'{14311}<2.970 or {14311}>3.618','BB +3.3V STBY Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14201,'{14312}<4.362 or {14312}>5.663','BB +5.0V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14202,'{14313}<4.483 or {14313}>5.495','BB +5.0V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14203,'{14314}<5 or {14314}>66','BB Ambient Temp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14204,'{14315}<10 or {14315}>61','BB Ambient Temp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14205,'{14316}=0','Power','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14206,'{14317}<5 or {14317}>90','Baseboard Temp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14207,'{14318}<10 or {14318}>83','Baseboard Temp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14208,'{14319}<0.953 or {14319}>1.149','BB +1.05V PCH Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14209,'{14320}<0.985 or {14320}>1.117','BB +1.05V PCH Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14210,'{14321}<0.683 or {14321}>1.543','BB +1.1V P1 Vccp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14211,'{14322}<0.708 or {14322}>1.501','BB +1.1V P1 Vccp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14212,'{14323}<1.362 or {14323}>1.635','BB +1.5V P1 DDR3 Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14213,'{14324}<1.401 or {14324}>1.589','BB +1.5V P1 DDR3 Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14214,'{14325}<2.982 or {14325}>3.625','BB +3.3V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14215,'{14326}<3.067 or {14326}>3.525','BB +3.3V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14216,'{14327}<2.982 or {14327}>3.625','BB +3.3V STBY Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14217,'{14328}<3.067 or {14328}>3.525','BB +3.3V STBY Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14218,'{14329}<4.471 or {14329}>5.538','BB +5.0V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14219,'{14330}<4.630 or {14330}>5.380','BB +5.0V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14220,'{14331}<0 or {14331}>48','Front Panel Temp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14221,'{14332}<5 or {14332}>44','Front Panel Temp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14222,'{14333}=0','Power','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14223,'{14334}<324','System Fan 2 Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14224,'{14335}<378','System Fan 2 Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14225,'{14336}<324','System Fan 3 Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14226,'{14337}<378','System Fan 3 Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0,''),(14243,'{14370}>{$CPU_UTIL_MAX}','#{#SNMPINDEX}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14245,'{14372}>{$STORAGE_UTIL_CRIT}','{#SNMPVALUE}: Disk space is critically low','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14246,'{14373}>{$STORAGE_UTIL_WARN}','{#SNMPVALUE}: Disk space is low','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14247,'{14374}>{$CPU_UTIL_MAX}','#{#SNMPINDEX}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14249,'{14376}>{$STORAGE_UTIL_CRIT}','{#SNMPVALUE}: Disk space is critically low','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14250,'{14377}>{$STORAGE_UTIL_WARN}','{#SNMPVALUE}: Disk space is low','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14251,'{14378}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',NULL,0,0,0,0,'',0,'',0,''),(14252,'{14379}>{$ICMP_LOSS_WARN} and {14379}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14253,'{14380}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14288,'{14463}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14251,0,0,0,0,'',0,'',0,''),(14289,'{14464}>{$ICMP_LOSS_WARN} and {14464}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14252,0,0,0,0,'',0,'',0,''),(14290,'{14465}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14253,0,0,0,0,'',0,'',0,''),(14293,'{14468}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14251,0,0,0,0,'',0,'',0,''),(14294,'{14469}>{$ICMP_LOSS_WARN} and {14469}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14252,0,0,0,0,'',0,'',0,''),(14295,'{14470}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14253,0,0,0,0,'',0,'',0,''),(14311,'{14508}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14312,'{14509}>{$ICMP_LOSS_WARN} and {14509}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14313,'{14510}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14316,'{14513}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14317,'{14514}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14318,'{14515}>{$TEMP_WARN:\"\"}','{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14516}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(14319,'{14517}>{$TEMP_CRIT:\"\"}','{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14518}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(14320,'{14519}<{$TEMP_CRIT_LOW:\"\"}','{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14520}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14322,'{14522}=1 and {14523}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1,''),(14327,'{14536}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14328,'{14537}>{$ICMP_LOSS_WARN} and {14537}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14329,'{14538}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14332,'{14541}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14333,'{14542}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14336,'{14545}=1 and {14546}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14337,'{14547}=1 and {14548}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14339,'{14552}>{$TEMP_CRIT:\"\"}','{#SENSOR_INFO}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14553}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(14340,'{14554}<{$TEMP_CRIT_LOW:\"\"}','{#SENSOR_INFO}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14555}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14347,'{14570}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14348,'{14571}>{$ICMP_LOSS_WARN} and {14571}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14349,'{14572}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14356,'{14587}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14357,'{14588}>{$ICMP_LOSS_WARN} and {14588}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14358,'{14589}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14361,'{14592}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14362,'{14593}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14363,'{14594}=1 and {14595}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14364,'{14596}=1 and {14597}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14365,'{14598}=1 and {14599}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14366,'{14600}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14361,0,0,0,0,'',0,'',0,''),(14367,'{14601}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14361,0,0,0,0,'',0,'',0,''),(14368,'{14602}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14362,0,0,0,0,'',0,'',0,''),(14369,'{14603}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14362,0,0,0,0,'',0,'',0,''),(14372,'{14606}>{$TEMP_WARN:\"\"}','{#SENSOR_DESCR}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14607}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(14373,'{14608}>{$TEMP_CRIT:\"\"}','{#SENSOR_DESCR}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14609}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(14374,'{14610}<{$TEMP_CRIT_LOW:\"\"}','{#SENSOR_DESCR}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14611}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14375,'{14612}>{$TEMP_WARN:\"\"}','Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14613}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(14376,'{14614}>{$TEMP_CRIT:\"\"}','Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14615}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(14377,'{14616}<{$TEMP_CRIT_LOW:\"\"}','Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14617}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14380,'{14620}>{$TEMP_WARN:\"\"}','{#SENSOR_DESCR}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14621}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(14381,'{14622}>{$TEMP_CRIT:\"\"}','{#SENSOR_DESCR}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14623}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(14382,'{14624}<{$TEMP_CRIT_LOW:\"\"}','{#SENSOR_DESCR}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14625}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14383,'{14626}=1 and {14627}>0','Unit {#SNMPVALUE}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1,''),(14389,'{14641}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14390,'{14642}>{$ICMP_LOSS_WARN} and {14642}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14391,'{14643}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14403,'{14663}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14404,'{14664}>{$ICMP_LOSS_WARN} and {14664}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14405,'{14665}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14408,'{14668}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14409,'{14669}=1 and {14670}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14410,'{14671}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14408,0,0,0,0,'',0,'',0,''),(14411,'{14672}=1 and {14673}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',14409,0,0,0,2,'',0,'',1,''),(14413,'{14676}=1 and {14677}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',14409,0,0,0,2,'',0,'',1,''),(14414,'{14678}>{$MEMORY_UTIL_MAX}','{#SNMPVALUE}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14415,'{14679}>{$CPU_UTIL_MAX}','#{#SNMPINDEX}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14417,'{14681}=1 and {14682}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1,''),(14420,'{14689}<{$TEMP_CRIT_LOW:\"\"}','{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14690}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14423,'{14693}>{$MEMORY_UTIL_MAX}','{#SNMPVALUE}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14414,0,0,2,0,'',0,'',0,''),(14425,'{14695}>{$MEMORY_UTIL_MAX}','{#SNMPVALUE}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14414,0,0,2,0,'',0,'',0,''),(14426,'{14696}>{$CPU_UTIL_MAX}','#{#SNMPINDEX}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14415,0,0,2,0,'',0,'',0,''),(14428,'{14698}=1 and {14699}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',14417,0,0,2,2,'',0,'',1,''),(14430,'{14702}=1 and {14703}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',14417,0,0,2,2,'',0,'',1,''),(14437,'{14722}<{$TEMP_CRIT_LOW:\"\"}','{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14420,0,0,2,1,'{14723}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14439,'{14726}<{$TEMP_CRIT_LOW:\"\"}','{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14420,0,0,2,1,'{14727}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14451,'{14747}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14452,'{14748}>{$ICMP_LOSS_WARN} and {14748}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14453,'{14749}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14456,'{14752}>{$CPU_UTIL_MAX}','#{#SNMPINDEX}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14457,'{14753}>{$MEMORY_UTIL_MAX}','#{#SNMPINDEX}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14460,'{14756}>{$TEMP_WARN:\"\"}','Device {#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14757}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(14461,'{14758}>{$TEMP_CRIT:\"\"}','Device {#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14759}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(14462,'{14760}<{$TEMP_CRIT_LOW:\"\"}','Device {#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14761}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14463,'{14762}=1 and {14763}>0','#{#SNMPVALUE}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1,''),(14468,'{14776}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14469,'{14777}>{$ICMP_LOSS_WARN} and {14777}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14470,'{14778}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14473,'{14781}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14474,'{14782}=1 and {14783}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14475,'{14784}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14476,'{14785}>{$TEMP_WARN:\"\"}','{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14786}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(14477,'{14787}>{$TEMP_CRIT:\"\"}','{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14788}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(14478,'{14789}<{$TEMP_CRIT_LOW:\"\"}','{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14790}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14486,'{14806}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14487,'{14807}>{$ICMP_LOSS_WARN} and {14807}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14488,'{14808}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14491,'{14811}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14492,'{14812}=1 and {14813}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14493,'{14814}=1 and {14815}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14494,'{14816}>{$MEMORY_UTIL_MAX}','#{#SNMPVALUE}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14495,'{14817}>{$TEMP_WARN:\"\"}','#{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14818}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(14496,'{14819}>{$TEMP_CRIT:\"\"}','#{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14820}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(14497,'{14821}<{$TEMP_CRIT_LOW:\"\"}','#{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14822}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14505,'{14838}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14506,'{14839}>{$ICMP_LOSS_WARN} and {14839}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14507,'{14840}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14510,'{14843}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14511,'{14844}>{$TEMP_WARN:\"\"}','Device: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,0,1,'{14845}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(14513,'{14849}<{$TEMP_CRIT_LOW:\"\"}','Device: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,1,'{14850}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14514,'{14851}=1 and {14852}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14515,'{14853}=1 and {14854}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14516,'{14855}>{$MEMORY_UTIL_MAX}','#{#SNMPVALUE}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14524,'{14871}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14288,0,0,0,0,'',0,'',0,''),(14525,'{14872}>{$ICMP_LOSS_WARN} and {14872}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14289,0,0,0,0,'',0,'',0,''),(14526,'{14873}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14290,0,0,0,0,'',0,'',0,''),(14534,'{14889}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14535,'{14890}>{$ICMP_LOSS_WARN} and {14890}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14536,'{14891}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14544,'{14907}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14545,'{14908}>{$ICMP_LOSS_WARN} and {14908}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14546,'{14909}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14549,'{14912}>{$CPU_UTIL_MAX}','{#MODULE_NAME}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14550,'{14913}>{$MEMORY_UTIL_MAX}','{#MODULE_NAME}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14551,'{14914}>{$TEMP_WARN:\"\"}','{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14915}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(14552,'{14916}>{$TEMP_CRIT:\"\"}','{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14917}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(14553,'{14918}<{$TEMP_CRIT_LOW:\"\"}','{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14919}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14556,'{14922}=1 and {14923}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1,''),(14557,'{14924}=1 and {14925}>0','{#ENT_NAME}: Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1,''),(14582,'{14972}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14583,'{14973}>{$ICMP_LOSS_WARN} and {14973}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14584,'{14974}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14587,'{14977}>{$CPU_UTIL_MAX}','{#ENT_NAME}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14588,'{14978}>{$MEMORY_UTIL_MAX}','{#ENT_NAME}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14589,'{14979}>{$TEMP_WARN:\"\"}','{#ENT_NAME}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14980}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(14590,'{14981}>{$TEMP_CRIT:\"\"}','{#ENT_NAME}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14982}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(14591,'{14983}<{$TEMP_CRIT_LOW:\"\"}','{#ENT_NAME}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14984}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14592,'{14985}=1 and {14986}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1,''),(14598,'{15000}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14599,'{15001}>{$ICMP_LOSS_WARN} and {15001}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14600,'{15002}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14603,'{15005}=1 and {15006}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14606,'{15013}<{$TEMP_CRIT_LOW:\"\"}','{#SENSOR_INFO}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{15014}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14607,'{15015}=1 and {15016}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1,''),(14615,'{15032}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14616,'{15033}>{$ICMP_LOSS_WARN} and {15033}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14617,'{15034}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14621,'{15038}=1 and {15039}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14622,'{15040}>{$CPU_UTIL_MAX}','{#SNMPVALUE}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14623,'{15041}>{$MEMORY_UTIL_MAX}','{#SNMPVALUE}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14624,'{15042}>{$TEMP_WARN:\"\"}','{#SENSOR_INFO}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{15043}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(14625,'{15044}>{$TEMP_CRIT:\"\"}','{#SENSOR_INFO}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{15045}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(14626,'{15046}<{$TEMP_CRIT_LOW:\"\"}','{#SENSOR_INFO}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{15047}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14652,'{15094}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14653,'{15095}>{$ICMP_LOSS_WARN} and {15095}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14654,'{15096}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14657,'{15099}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14658,'{15100}>{$TEMP_WARN:\"Device\"}','Device: Temperature is above warning threshold: >{$TEMP_WARN:\"Device\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,0,1,'{15101}<{$TEMP_WARN:\"Device\"}-3',0,'',0,''),(14659,'{15102}>{$TEMP_CRIT:\"Device\"}','Device: Temperature is above critical threshold: >{$TEMP_CRIT:\"Device\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,0,1,'{15103}<{$TEMP_CRIT:\"Device\"}-3',0,'',0,''),(14660,'{15104}<{$TEMP_CRIT_LOW:\"Device\"}','Device: Temperature is too low: <{$TEMP_CRIT_LOW:\"Device\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,1,'{15105}>{$TEMP_CRIT_LOW:\"Device\"}+3',0,'',0,''),(14661,'{15106}=1 and {15107}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14662,'{15108}=1 and {15109}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14663,'{15110}>{$CPU_UTIL_MAX}','#{#SNMPINDEX}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14664,'{15111}>{$TEMP_WARN:\"CPU\"}','CPU: Temperature is above warning threshold: >{$TEMP_WARN:\"CPU\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{15112}<{$TEMP_WARN:\"CPU\"}-3',0,'',0,''),(14665,'{15113}>{$TEMP_CRIT:\"CPU\"}','CPU: Temperature is above critical threshold: >{$TEMP_CRIT:\"CPU\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{15114}<{$TEMP_CRIT:\"CPU\"}-3',0,'',0,''),(14666,'{15115}<{$TEMP_CRIT_LOW:\"CPU\"}','CPU: Temperature is too low: <{$TEMP_CRIT_LOW:\"CPU\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{15116}>{$TEMP_CRIT_LOW:\"CPU\"}+3',0,'',0,''),(14667,'{15117}>{$STORAGE_UTIL_CRIT}','Disk-{#SNMPINDEX}: Disk space is critically low','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14668,'{15118}>{$STORAGE_UTIL_WARN}','Disk-{#SNMPINDEX}: Disk space is low','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14673,'{15131}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14674,'{15132}>{$ICMP_LOSS_WARN} and {15132}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14675,'{15133}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14678,'{15136}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14679,'{15137}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14680,'{15138}=1 and {15139}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14683,'{15146}<{$TEMP_CRIT_LOW:\"\"}','#{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{15147}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14691,'{15163}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14692,'{15164}>{$ICMP_LOSS_WARN} and {15164}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14693,'{15165}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14696,'{15168}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14697,'{15169}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14698,'{15170}=1 and {15171}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14699,'{15172}=1 and {15173}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14704,'{15186}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14705,'{15187}>{$ICMP_LOSS_WARN} and {15187}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14706,'{15188}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14709,'{15191}=1 and {15192}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14710,'{15193}=1 and {15194}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14711,'{15195}>{$CPU_UTIL_MAX}','#{#SNMPVALUE}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14712,'{15196}>{$MEMORY_UTIL_MAX}','#{#SNMPVALUE}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14717,'{15209}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14288,0,0,0,0,'',0,'',0,''),(14718,'{15210}>{$ICMP_LOSS_WARN} and {15210}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14289,0,0,0,0,'',0,'',0,''),(14719,'{15211}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14290,0,0,0,0,'',0,'',0,''),(14722,'{15214}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14723,'{15215}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14724,'{15216}=1 and {15217}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14860,'{15580}>{$CPU_UTIL_MAX}','#{#SNMPINDEX}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14247,0,0,2,0,'',0,'',0,''),(14861,'{15581}>{$STORAGE_UTIL_CRIT}','{#SNMPVALUE}: Disk space is critically low','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14249,0,0,2,0,'',0,'',0,''),(14862,'{15582}>{$STORAGE_UTIL_WARN}','{#SNMPVALUE}: Disk space is low','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14250,0,0,2,0,'',0,'',0,''),(14869,'{15597}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14870,'{15598}>{$ICMP_LOSS_WARN} and {15598}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14871,'{15599}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14874,'{15602}>{$CPU_UTIL_MAX}','#{#SNMPINDEX}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14247,0,0,2,0,'',0,'',0,''),(14875,'{15603}>{$STORAGE_UTIL_CRIT}','{#SNMPVALUE}: Disk space is critically low','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14249,0,0,2,0,'',0,'',0,''),(14876,'{15604}>{$STORAGE_UTIL_WARN}','{#SNMPVALUE}: Disk space is low','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14250,0,0,2,0,'',0,'',0,''),(14882,'{15618}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14883,'{15619}>{$ICMP_LOSS_WARN} and {15619}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14884,'{15620}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14906,'{15678}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14907,'{15679}>{$ICMP_LOSS_WARN} and {15679}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14908,'{15680}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14911,'{15683}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0,''),(14912,'{15684}=1 and {15685}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14913,'{15686}=1 and {15687}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(14914,'{15688}>{$TEMP_WARN:\"\"}','{#SENSOR_INFO}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{15689}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(14915,'{15690}>{$TEMP_CRIT:\"\"}','{#SENSOR_INFO}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{15691}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(14916,'{15692}<{$TEMP_CRIT_LOW:\"\"}','{#SENSOR_INFO}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{15693}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14917,'{15694}>{$MEMORY_UTIL_MAX}','#{#SNMPVALUE}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14920,'{15697}>{$CPU_UTIL_MAX}','#{#SNMPINDEX}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14247,0,0,2,0,'',0,'',0,''),(14921,'{15698}>{$STORAGE_UTIL_CRIT}','{#SNMPVALUE}: Disk space is critically low','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14249,0,0,2,0,'',0,'',0,''),(14922,'{15699}>{$STORAGE_UTIL_WARN}','{#SNMPVALUE}: Disk space is low','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14250,0,0,2,0,'',0,'',0,''),(14928,'{15713}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(14929,'{15714}>{$ICMP_LOSS_WARN} and {15714}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(14930,'{15715}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(14934,'{15721}>{$TEMP_CRIT:\"\"}','{#SENSOR_INFO}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{15722}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(14935,'{15723}<{$TEMP_CRIT_LOW:\"\"}','{#SENSOR_INFO}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{15724}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(14937,'{15726}=1 and {15727}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1,''),(14939,'{15729}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',NULL,0,0,2,0,'',0,'',1,''),(14940,'{15730}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14939,0,0,2,0,'',0,'',1,''),(14941,'{15731}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',NULL,0,0,2,0,'',0,'',1,''),(14942,'{15732}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1,''),(14943,'{15733}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1,''),(14944,'{15734}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1,''),(14945,'{15735}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1,''),(14946,'{15736}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1,''),(14947,'{15737}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1,''),(14948,'{15738}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1,''),(14949,'{15739}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1,''),(14950,'{15740}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1,''),(14951,'{15741}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1,''),(14952,'{15742}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1,''),(14953,'{15743}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1,''),(14954,'{15744}>{$MEMORY_UTIL_MAX}','#{#SNMPINDEX}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14955,'{15745}>{$MEMORY_UTIL_MAX}','#{#SNMPINDEX}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(14956,'{15746}>{$MEMORY_UTIL_MAX}','#{#SNMPINDEX}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14955,0,0,2,0,'',0,'',0,''),(14957,'{15747}>{$MEMORY_UTIL_MAX}','#{#SNMPINDEX}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14955,0,0,2,0,'',0,'',0,''),(14958,'{15748}>{$MEMORY_UTIL_MAX}','#{#SNMPINDEX}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14955,0,0,2,0,'',0,'',0,''),(15161,'{16352}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',NULL,0,0,0,0,'',0,'',0,''),(15162,'{16353}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15161,0,0,0,0,'',0,'',0,''),(15163,'{16354}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15161,0,0,0,0,'',0,'',0,''),(15170,'{16375}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',NULL,0,0,0,0,'',0,'',0,''),(15171,'{16376}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15172,'{16377}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15173,'{16378}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15174,'{16379}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15175,'{16380}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15176,'{16381}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15177,'{16382}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15178,'{16383}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15179,'{16384}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15180,'{16385}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15181,'{16386}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15182,'{16387}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15183,'{16388}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15184,'{16389}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15185,'{16390}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15186,'{16391}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15187,'{16392}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15188,'{16393}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15189,'{16394}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15190,'{16395}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15191,'{16396}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15192,'{16397}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15193,'{16398}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15208,'{16445}=1 and {16446}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',14409,0,0,0,2,'',0,'',1,''),(15209,'{16447}=1 and {16448}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',14417,0,0,2,2,'',0,'',1,''),(15214,'{16457}<{$TEMP_CRIT_LOW:\"\"}','{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14420,0,0,2,1,'{16458}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(15215,'{16459}>{$MEMORY_UTIL_MAX}','{#SNMPVALUE}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14414,0,0,2,0,'',0,'',0,''),(15220,'{16472}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(15221,'{16473}>{$ICMP_LOSS_WARN} and {16473}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(15222,'{16474}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(15224,'{16476}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15225,'{16477}>{$CPU_UTIL_MAX}','{#SNMPVALUE}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(15228,'{16484}>{$CPU_UTIL_MAX}','{#SNMPVALUE}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',15225,0,0,2,0,'',0,'',0,''),(15330,'{16818}=1','#{#SNMPINDEX}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15331,'{16819}=1','PSU {#SNMPVALUE}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15332,'{16820}=1','PSU {#SNMPVALUE}: Power supply is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15333,'{16821}=1','Fan {#SNMPVALUE}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15334,'{16822}=1','Fan {#SNMPVALUE}: Fan is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15335,'{16823}>{$TEMP_WARN:\"\"}\r\nor\r\n{16824}={$TEMP_WARN_STATUS}','{#SENSOR_INFO}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{16825}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(15336,'{16826}>{$TEMP_CRIT:\"\"}\r\nor\r\n{16827}={$TEMP_CRIT_STATUS}','{#SENSOR_INFO}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{16828}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(15337,'{16829}=1','{#SNMPVALUE}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15338,'{16830}=1','{#SNMPVALUE}: Power supply is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15339,'{16831}=1','{#SNMPVALUE}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15340,'{16832}=1','#{#SNMPVALUE}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15341,'{16833}=1','#{#SNMPVALUE}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15342,'{16834}>{$TEMP_WARN:\"\"}\r\nor\r\n{16835}={$TEMP_WARN_STATUS}','{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{16836}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(15343,'{16837}>{$TEMP_CRIT:\"\"}\r\nor\r\n{16838}={$TEMP_CRIT_STATUS}\r\nor\r\n{16838}={$TEMP_DISASTER_STATUS}','{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{16839}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(15344,'{16840}=1 or {16841}=1','{#SENSOR_INFO}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15345,'{16842}=1 or {16843}=1','{#SENSOR_INFO}: Power supply is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15346,'{16844}=1 or {16845}=1','{#SENSOR_INFO}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15347,'{16846}=1 or {16847}=1','{#SENSOR_INFO}: Fan is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15348,'{16848}>{$TEMP_WARN:\"\"}\r\nor\r\n{16849}={$TEMP_WARN_STATUS}','{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',15342,0,0,2,1,'{16850}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(15349,'{16851}>{$TEMP_WARN:\"\"}\r\nor\r\n{16852}={$TEMP_WARN_STATUS}','{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',15342,0,0,2,1,'{16853}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(15350,'{16854}>{$TEMP_WARN:\"\"}\r\nor\r\n{16855}={$TEMP_WARN_STATUS}','{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',15342,0,0,2,1,'{16856}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(15351,'{16857}>{$TEMP_CRIT:\"\"}\r\nor\r\n{16858}={$TEMP_CRIT_STATUS}\r\nor\r\n{16858}={$TEMP_DISASTER_STATUS}','{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',15343,0,0,2,1,'{16859}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(15352,'{16860}>{$TEMP_CRIT:\"\"}\r\nor\r\n{16861}={$TEMP_CRIT_STATUS}\r\nor\r\n{16861}={$TEMP_DISASTER_STATUS}','{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',15343,0,0,2,1,'{16862}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(15353,'{16863}>{$TEMP_CRIT:\"\"}\r\nor\r\n{16864}={$TEMP_CRIT_STATUS}\r\nor\r\n{16864}={$TEMP_DISASTER_STATUS}','{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',15343,0,0,2,1,'{16865}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(15354,'{16866}=1 or {16867}=1','{#SENSOR_INFO}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',15344,0,0,2,0,'',0,'',0,''),(15355,'{16868}=1 or {16869}=1','{#SENSOR_INFO}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',15344,0,0,2,0,'',0,'',0,''),(15356,'{16870}=1 or {16871}=1','{#SENSOR_INFO}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',15344,0,0,2,0,'',0,'',0,''),(15357,'{16872}=1 or {16873}=1','{#SENSOR_INFO}: Power supply is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',15345,0,0,2,0,'',0,'',0,''),(15358,'{16874}=1 or {16875}=1','{#SENSOR_INFO}: Power supply is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',15345,0,0,2,0,'',0,'',0,''),(15359,'{16876}=1 or {16877}=1','{#SENSOR_INFO}: Power supply is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',15345,0,0,2,0,'',0,'',0,''),(15360,'{16878}=1 or {16879}=1','{#SENSOR_INFO}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',15346,0,0,2,0,'',0,'',0,''),(15361,'{16880}=1 or {16881}=1','{#SENSOR_INFO}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',15346,0,0,2,0,'',0,'',0,''),(15362,'{16882}=1 or {16883}=1','{#SENSOR_INFO}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',15346,0,0,2,0,'',0,'',0,''),(15363,'{16884}=1 or {16885}=1','{#SENSOR_INFO}: Fan is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',15347,0,0,2,0,'',0,'',0,''),(15364,'{16886}=1 or {16887}=1','{#SENSOR_INFO}: Fan is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',15347,0,0,2,0,'',0,'',0,''),(15365,'{16888}=1 or {16889}=1','{#SENSOR_INFO}: Fan is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',15347,0,0,2,0,'',0,'',0,''),(15366,'{16890}=1','{#SNMPVALUE}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15367,'{16891}=1','{#SNMPVALUE}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15368,'{16892}>{$TEMP_CRIT:\"\"}\r\nor\r\n{16893}={$TEMP_CRIT_STATUS}','Device: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,0,1,'{16894}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(15369,'{16895}=1','PSU {#SNMPVALUE}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15370,'{16896}=1','Fan {#SNMPVALUE}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15371,'{16897}=1 or {16898}=1','{#ENT_NAME}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15372,'{16899}=1 or {16900}=1 or {16901}=1','{#ENT_NAME}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15373,'{16902}=1','{#ENT_DESCR}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15374,'{16903}=1','{#ENT_DESCR}: Fan is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15375,'{16904}=1','{#ENT_DESCR}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15376,'{16905}=1','{#ENT_DESCR}: Power supply is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15377,'{16906}=1','{#SNMPVALUE}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15378,'{16907}=1','{#SNMPVALUE}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15379,'{16908}=1','PSU {#PSU_INDEX}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15380,'{16909}=1','PSU {#PSU_INDEX}: Power supply is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15381,'{16910}=1','Fan {#FAN_INDEX}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15382,'{16911}=1','Fan {#FAN_INDEX}: Fan is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15383,'{16912}=1','Unit {#PSU_UNIT} PSU {#PSU_INDEX}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15384,'{16913}=1','Unit {#PSU_UNIT} PSU {#PSU_INDEX}: Power supply is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15385,'{16914}=1','Unit {#FAN_UNIT} Fan {#FAN_INDEX}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15386,'{16915}=1','Unit {#FAN_UNIT} Fan {#FAN_INDEX}: Fan is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15387,'{16916}>{$TEMP_WARN:\"\"}\r\nor\r\n{16917}={$TEMP_WARN_STATUS}','{#SENSOR_INFO}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{16918}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(15388,'{16919}=1','{#SENSOR_INFO}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15389,'{16920}=1','{#ENT_NAME}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15390,'{16921}>{$TEMP_WARN:\"\"}\r\nor\r\n{16922}={$TEMP_WARN_STATUS}','{#SENSOR_INFO}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{16923}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(15391,'{16924}=1','{#SENSOR_INFO}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15392,'{16925}=1','{#SENSOR_INFO}: Power supply is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15393,'{16926}=1','{#SENSOR_INFO}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15394,'{16927}=1','{#SENSOR_INFO}: Fan is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15395,'{16928}=1','#{#SNMPVALUE}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15396,'{16929}>{$TEMP_WARN:\"\"}\r\nor\r\n{16930}={$TEMP_WARN_STATUS}','#{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{16931}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(15397,'{16932}>{$TEMP_CRIT:\"\"}\r\nor\r\n{16933}={$TEMP_CRIT_STATUS}','#{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{16934}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(15398,'{16935}=1','#{#SNMPVALUE}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15399,'{16936}=1','#{#SNMPVALUE}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15490,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17237}=2 and {17238}=1)','Interface {#IFDESCR}: Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',NULL,0,0,2,1,'{17237}<>2',0,'',0,''),(15492,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17241}=2 and {17242}=1)','Interface {#IFDESCR}: Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15490,0,0,2,1,'{17241}<>2',0,'',0,''),(15493,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17243}=2 and {17244}=1)','Interface {#IFDESCR}: Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15490,0,0,2,1,'{17243}<>2',0,'',0,''),(15496,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17249}=2 and {17250}=1)','Interface {#IFDESCR}: Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',NULL,0,0,2,1,'{17249}<>2',0,'',0,''),(15498,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17253}=2 and {17254}=1)','Interface {#IFDESCR}: Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15496,0,0,2,1,'{17253}<>2',0,'',0,''),(15499,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17255}=2 and {17256}=1)','Interface {#IFDESCR}: Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15496,0,0,2,1,'{17255}<>2',0,'',0,''),(15502,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17261}=2 and {17262}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',NULL,0,0,2,1,'{17261}<>2',0,'',0,''),(15504,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17265}=2 and {17266}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15502,0,0,2,1,'{17265}<>2',0,'',0,''),(15506,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17269}=2 and {17270}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',NULL,0,0,2,1,'{17269}<>2',0,'',0,''),(15508,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17273}=2 and {17274}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',NULL,0,0,2,1,'{17273}<>2',0,'',0,''),(15510,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17277}=2 and {17278}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17277}<>2',0,'',0,''),(15511,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17279}=2 and {17280}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17279}<>2',0,'',0,''),(15512,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17281}=2 and {17282}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17281}<>2',0,'',0,''),(15513,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17283}=2 and {17284}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17283}<>2',0,'',0,''),(15514,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17285}=2 and {17286}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17285}<>2',0,'',0,''),(15515,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17287}=2 and {17288}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17287}<>2',0,'',0,''),(15516,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17289}=2 and {17290}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17289}<>2',0,'',0,''),(15517,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17291}=2 and {17292}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17291}<>2',0,'',0,''),(15518,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17293}=2 and {17294}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17293}<>2',0,'',0,''),(15519,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17295}=2 and {17296}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17295}<>2',0,'',0,''),(15520,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17297}=2 and {17298}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17297}<>2',0,'',0,''),(15521,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17299}=2 and {17300}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17299}<>2',0,'',0,''),(15522,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17301}=2 and {17302}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17301}<>2',0,'',0,''),(15523,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17303}=2 and {17304}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17303}<>2',0,'',0,''),(15524,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17305}=2 and {17306}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17305}<>2',0,'',0,''),(15525,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17307}=2 and {17308}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17307}<>2',0,'',0,''),(15526,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17309}=2 and {17310}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17309}<>2',0,'',0,''),(15527,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17311}=2 and {17312}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17311}<>2',0,'',0,''),(15528,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17313}=2 and {17314}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17313}<>2',0,'',0,''),(15529,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17315}=2 and {17316}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17315}<>2',0,'',0,''),(15550,'({17357}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17358} or\r\n{17359}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17358}) and\r\n{17358}>0','Interface {#IFDESCR}: High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17357}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17358} and\r\n{17359}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17358}',0,'',1,''),(15551,'{17360}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17361}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFDESCR}: High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',NULL,0,0,2,1,'{17360}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17361}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15553,'({17367}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17368} or\r\n{17369}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17368}) and\r\n{17368}>0','Interface {#IFDESCR}: High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15550,0,0,2,1,'{17367}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17368} and\r\n{17369}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17368}',0,'',1,''),(15554,'({17370}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17371} or\r\n{17372}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17371}) and\r\n{17371}>0','Interface {#IFDESCR}: High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15550,0,0,2,1,'{17370}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17371} and\r\n{17372}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17371}',0,'',1,''),(15555,'{17373}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17374}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFDESCR}: High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15551,0,0,2,1,'{17373}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17374}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15556,'{17375}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17376}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFDESCR}: High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15551,0,0,2,1,'{17375}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17376}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15559,'({17387}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17388} or\r\n{17389}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17388}) and\r\n{17388}>0','Interface {#IFDESCR}: High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17387}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17388} and\r\n{17389}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17388}',0,'',1,''),(15560,'{17390}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17391}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFDESCR}: High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',NULL,0,0,2,1,'{17390}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17391}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15562,'({17397}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17398} or\r\n{17399}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17398}) and\r\n{17398}>0','Interface {#IFDESCR}: High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15559,0,0,2,1,'{17397}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17398} and\r\n{17399}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17398}',0,'',1,''),(15563,'({17400}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17401} or\r\n{17402}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17401}) and\r\n{17401}>0','Interface {#IFDESCR}: High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15559,0,0,2,1,'{17400}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17401} and\r\n{17402}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17401}',0,'',1,''),(15564,'{17403}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17404}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFDESCR}: High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15560,0,0,2,1,'{17403}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17404}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15565,'{17405}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17406}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFDESCR}: High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15560,0,0,2,1,'{17405}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17406}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15568,'({17417}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17418} or\r\n{17419}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17418}) and\r\n{17418}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17417}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17418} and\r\n{17419}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17418}',0,'',1,''),(15569,'{17420}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17421}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',NULL,0,0,2,1,'{17420}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17421}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15571,'({17427}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17428} or\r\n{17429}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17428}) and\r\n{17428}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15568,0,0,2,1,'{17427}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17428} and\r\n{17429}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17428}',0,'',1,''),(15572,'{17430}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17431}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15569,0,0,2,1,'{17430}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17431}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15574,'({17437}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17438} or\r\n{17439}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17438}) and\r\n{17438}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17437}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17438} and\r\n{17439}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17438}',0,'',1,''),(15575,'{17440}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17441}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',NULL,0,0,2,1,'{17440}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17441}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15577,'({17447}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17448} or\r\n{17449}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17448}) and\r\n{17448}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17447}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17448} and\r\n{17449}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17448}',0,'',1,''),(15578,'{17450}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17451}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',NULL,0,0,2,1,'{17450}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17451}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15580,'({17457}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17458} or\r\n{17459}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17458}) and\r\n{17458}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17457}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17458} and\r\n{17459}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17458}',0,'',1,''),(15581,'({17460}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17461} or\r\n{17462}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17461}) and\r\n{17461}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17460}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17461} and\r\n{17462}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17461}',0,'',1,''),(15582,'({17463}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17464} or\r\n{17465}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17464}) and\r\n{17464}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17463}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17464} and\r\n{17465}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17464}',0,'',1,''),(15583,'({17466}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17467} or\r\n{17468}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17467}) and\r\n{17467}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17466}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17467} and\r\n{17468}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17467}',0,'',1,''),(15584,'({17469}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17470} or\r\n{17471}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17470}) and\r\n{17470}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17469}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17470} and\r\n{17471}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17470}',0,'',1,''),(15585,'({17472}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17473} or\r\n{17474}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17473}) and\r\n{17473}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17472}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17473} and\r\n{17474}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17473}',0,'',1,''),(15586,'({17475}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17476} or\r\n{17477}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17476}) and\r\n{17476}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17475}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17476} and\r\n{17477}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17476}',0,'',1,''),(15587,'({17478}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17479} or\r\n{17480}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17479}) and\r\n{17479}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17478}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17479} and\r\n{17480}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17479}',0,'',1,''),(15588,'({17481}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17482} or\r\n{17483}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17482}) and\r\n{17482}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17481}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17482} and\r\n{17483}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17482}',0,'',1,''),(15589,'({17484}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17485} or\r\n{17486}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17485}) and\r\n{17485}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17484}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17485} and\r\n{17486}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17485}',0,'',1,''),(15590,'({17487}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17488} or\r\n{17489}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17488}) and\r\n{17488}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17487}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17488} and\r\n{17489}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17488}',0,'',1,''),(15591,'({17490}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17491} or\r\n{17492}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17491}) and\r\n{17491}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17490}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17491} and\r\n{17492}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17491}',0,'',1,''),(15592,'({17493}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17494} or\r\n{17495}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17494}) and\r\n{17494}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17493}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17494} and\r\n{17495}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17494}',0,'',1,''),(15593,'({17496}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17497} or\r\n{17498}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17497}) and\r\n{17497}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17496}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17497} and\r\n{17498}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17497}',0,'',1,''),(15594,'({17499}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17500} or\r\n{17501}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17500}) and\r\n{17500}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17499}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17500} and\r\n{17501}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17500}',0,'',1,''),(15595,'({17502}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17503} or\r\n{17504}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17503}) and\r\n{17503}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17502}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17503} and\r\n{17504}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17503}',0,'',1,''),(15596,'({17505}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17506} or\r\n{17507}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17506}) and\r\n{17506}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17505}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17506} and\r\n{17507}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17506}',0,'',1,''),(15597,'({17508}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17509} or\r\n{17510}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17509}) and\r\n{17509}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17508}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17509} and\r\n{17510}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17509}',0,'',1,''),(15598,'({17511}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17512} or\r\n{17513}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17512}) and\r\n{17512}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17511}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17512} and\r\n{17513}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17512}',0,'',1,''),(15599,'({17514}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17515} or\r\n{17516}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17515}) and\r\n{17515}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17514}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17515} and\r\n{17516}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17515}',0,'',1,''),(15600,'{17517}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17518}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17517}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17518}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15601,'{17519}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17520}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17519}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17520}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15602,'{17521}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17522}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17521}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17522}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15603,'{17523}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17524}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17523}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17524}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15604,'{17525}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17526}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17525}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17526}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15605,'{17527}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17528}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17527}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17528}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15606,'{17529}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17530}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17529}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17530}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15607,'{17531}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17532}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17531}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17532}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15608,'{17533}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17534}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17533}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17534}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15609,'{17535}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17536}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17535}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17536}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15610,'{17537}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17538}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17537}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17538}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15611,'{17539}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17540}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17539}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17540}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15612,'{17541}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17542}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17541}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17542}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15613,'{17543}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17544}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17543}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17544}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15614,'{17545}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17546}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17545}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17546}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15615,'{17547}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17548}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17547}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17548}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15616,'{17549}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17550}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17549}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17550}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15617,'{17551}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17552}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17551}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17552}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15618,'{17553}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17554}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17553}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17554}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15619,'{17555}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17556}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17555}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17556}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15640,'{17657}>75','More than 75% used in the vmware cache','',0,0,3,0,'Consider increasing VMwareCacheSize in the zabbix_proxy.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(15641,'{17658}>75','Zabbix vmware collector processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{17658}<65',0,'',0,''),(15642,'{17659}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',NULL,0,0,0,0,'',0,'',1,''),(15643,'{17660}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15642,0,0,0,0,'',0,'',1,''),(15644,'{17661}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15642,0,0,0,0,'',0,'',1,''),(15645,'{17662}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',NULL,0,0,0,0,'',0,'',1,''),(15646,'{17663}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15647,'{17664}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15648,'{17665}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15649,'{17666}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15650,'{17667}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15651,'{17668}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15652,'{17669}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15653,'{17670}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15654,'{17671}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15655,'{17672}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15656,'{17673}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15657,'{17674}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15658,'{17675}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15659,'{17676}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15660,'{17677}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15661,'{17678}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15662,'{17679}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15663,'{17680}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15664,'{17681}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15665,'{17682}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15666,'{17683}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15667,'{17684}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15668,'{17685}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15669,'{17686}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15670,'{17687}<0 and {17688}>0\r\nand (\r\n{17689}=6 or\r\n{17689}=7 or\r\n{17689}=11 or\r\n{17689}=62 or\r\n{17689}=69 or\r\n{17689}=117\r\n)\r\nand\r\n({17690}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',NULL,0,0,2,1,'({17687}>0 and {17691}>0) or\r\n({17690}=2)',0,'',1,''),(15671,'{17692}<0 and {17693}>0\r\nand (\r\n{17694}=6 or\r\n{17694}=7 or\r\n{17694}=11 or\r\n{17694}=62 or\r\n{17694}=69 or\r\n{17694}=117\r\n)\r\nand\r\n({17695}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',NULL,0,0,2,1,'({17692}>0 and {17696}>0) or\r\n({17695}=2)',0,'',1,''),(15672,'{17697}<0 and {17698}>0\r\nand (\r\n{17699}=6 or\r\n{17699}=7 or\r\n{17699}=11 or\r\n{17699}=62 or\r\n{17699}=69 or\r\n{17699}=117\r\n)\r\nand\r\n({17700}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17697}>0 and {17701}>0) or\r\n({17700}=2)',0,'',1,''),(15673,'{17702}<0 and {17703}>0\r\nand (\r\n{17704}=6 or\r\n{17704}=7 or\r\n{17704}=11 or\r\n{17704}=62 or\r\n{17704}=69 or\r\n{17704}=117\r\n)\r\nand\r\n({17705}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17702}>0 and {17706}>0) or\r\n({17705}=2)',0,'',1,''),(15674,'{17707}<0 and {17708}>0\r\nand (\r\n{17709}=6 or\r\n{17709}=7 or\r\n{17709}=11 or\r\n{17709}=62 or\r\n{17709}=69 or\r\n{17709}=117\r\n)\r\nand\r\n({17710}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17707}>0 and {17711}>0) or\r\n({17710}=2)',0,'',1,''),(15675,'{17712}<0 and {17713}>0\r\nand (\r\n{17714}=6 or\r\n{17714}=7 or\r\n{17714}=11 or\r\n{17714}=62 or\r\n{17714}=69 or\r\n{17714}=117\r\n)\r\nand\r\n({17715}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17712}>0 and {17716}>0) or\r\n({17715}=2)',0,'',1,''),(15676,'{17717}<0 and {17718}>0\r\nand (\r\n{17719}=6 or\r\n{17719}=7 or\r\n{17719}=11 or\r\n{17719}=62 or\r\n{17719}=69 or\r\n{17719}=117\r\n)\r\nand\r\n({17720}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17717}>0 and {17721}>0) or\r\n({17720}=2)',0,'',1,''),(15677,'{17722}<0 and {17723}>0\r\nand (\r\n{17724}=6 or\r\n{17724}=7 or\r\n{17724}=11 or\r\n{17724}=62 or\r\n{17724}=69 or\r\n{17724}=117\r\n)\r\nand\r\n({17725}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17722}>0 and {17726}>0) or\r\n({17725}=2)',0,'',1,''),(15678,'{17727}<0 and {17728}>0\r\nand (\r\n{17729}=6 or\r\n{17729}=7 or\r\n{17729}=11 or\r\n{17729}=62 or\r\n{17729}=69 or\r\n{17729}=117\r\n)\r\nand\r\n({17730}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17727}>0 and {17731}>0) or\r\n({17730}=2)',0,'',1,''),(15679,'{17732}<0 and {17733}>0\r\nand (\r\n{17734}=6 or\r\n{17734}=7 or\r\n{17734}=11 or\r\n{17734}=62 or\r\n{17734}=69 or\r\n{17734}=117\r\n)\r\nand\r\n({17735}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17732}>0 and {17736}>0) or\r\n({17735}=2)',0,'',1,''),(15680,'{17737}<0 and {17738}>0\r\nand (\r\n{17739}=6 or\r\n{17739}=7 or\r\n{17739}=11 or\r\n{17739}=62 or\r\n{17739}=69 or\r\n{17739}=117\r\n)\r\nand\r\n({17740}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17737}>0 and {17741}>0) or\r\n({17740}=2)',0,'',1,''),(15681,'{17742}<0 and {17743}>0\r\nand (\r\n{17744}=6 or\r\n{17744}=7 or\r\n{17744}=11 or\r\n{17744}=62 or\r\n{17744}=69 or\r\n{17744}=117\r\n)\r\nand\r\n({17745}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17742}>0 and {17746}>0) or\r\n({17745}=2)',0,'',1,''),(15682,'{17747}<0 and {17748}>0\r\nand (\r\n{17749}=6 or\r\n{17749}=7 or\r\n{17749}=11 or\r\n{17749}=62 or\r\n{17749}=69 or\r\n{17749}=117\r\n)\r\nand\r\n({17750}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17747}>0 and {17751}>0) or\r\n({17750}=2)',0,'',1,''),(15683,'{17752}<0 and {17753}>0\r\nand (\r\n{17754}=6 or\r\n{17754}=7 or\r\n{17754}=11 or\r\n{17754}=62 or\r\n{17754}=69 or\r\n{17754}=117\r\n)\r\nand\r\n({17755}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17752}>0 and {17756}>0) or\r\n({17755}=2)',0,'',1,''),(15684,'{17757}<0 and {17758}>0\r\nand (\r\n{17759}=6 or\r\n{17759}=7 or\r\n{17759}=11 or\r\n{17759}=62 or\r\n{17759}=69 or\r\n{17759}=117\r\n)\r\nand\r\n({17760}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17757}>0 and {17761}>0) or\r\n({17760}=2)',0,'',1,''),(15685,'{17762}<0 and {17763}>0\r\nand (\r\n{17764}=6 or\r\n{17764}=7 or\r\n{17764}=11 or\r\n{17764}=62 or\r\n{17764}=69 or\r\n{17764}=117\r\n)\r\nand\r\n({17765}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17762}>0 and {17766}>0) or\r\n({17765}=2)',0,'',1,''),(15686,'{17767}<0 and {17768}>0\r\nand (\r\n{17769}=6 or\r\n{17769}=7 or\r\n{17769}=11 or\r\n{17769}=62 or\r\n{17769}=69 or\r\n{17769}=117\r\n)\r\nand\r\n({17770}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17767}>0 and {17771}>0) or\r\n({17770}=2)',0,'',1,''),(15687,'{17772}<0 and {17773}>0\r\nand (\r\n{17774}=6 or\r\n{17774}=7 or\r\n{17774}=11 or\r\n{17774}=62 or\r\n{17774}=69 or\r\n{17774}=117\r\n)\r\nand\r\n({17775}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17772}>0 and {17776}>0) or\r\n({17775}=2)',0,'',1,''),(15688,'{17777}<0 and {17778}>0\r\nand (\r\n{17779}=6 or\r\n{17779}=7 or\r\n{17779}=11 or\r\n{17779}=62 or\r\n{17779}=69 or\r\n{17779}=117\r\n)\r\nand\r\n({17780}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17777}>0 and {17781}>0) or\r\n({17780}=2)',0,'',1,''),(15689,'{17782}<0 and {17783}>0\r\nand (\r\n{17784}=6 or\r\n{17784}=7 or\r\n{17784}=11 or\r\n{17784}=62 or\r\n{17784}=69 or\r\n{17784}=117\r\n)\r\nand\r\n({17785}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17782}>0 and {17786}>0) or\r\n({17785}=2)',0,'',1,''),(15690,'{17787}<0 and {17788}>0\r\nand (\r\n{17789}=6 or\r\n{17789}=7 or\r\n{17789}=11 or\r\n{17789}=62 or\r\n{17789}=69 or\r\n{17789}=117\r\n)\r\nand\r\n({17790}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17787}>0 and {17791}>0) or\r\n({17790}=2)',0,'',1,''),(15691,'{17792}<0 and {17793}>0\r\nand (\r\n{17794}=6 or\r\n{17794}=7 or\r\n{17794}=11 or\r\n{17794}=62 or\r\n{17794}=69 or\r\n{17794}=117\r\n)\r\nand\r\n({17795}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17792}>0 and {17796}>0) or\r\n({17795}=2)',0,'',1,''),(15692,'{17797}<0 and {17798}>0\r\nand (\r\n{17799}=6 or\r\n{17799}=7 or\r\n{17799}=11 or\r\n{17799}=62 or\r\n{17799}=69 or\r\n{17799}=117\r\n)\r\nand\r\n({17800}<>2)','Interface {#IFDESCR}: Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',NULL,0,0,2,1,'({17797}>0 and {17801}>0) or\r\n({17800}=2)',0,'',1,''),(15693,'{17802}<0 and {17803}>0\r\nand (\r\n{17804}=6 or\r\n{17804}=7 or\r\n{17804}=11 or\r\n{17804}=62 or\r\n{17804}=69 or\r\n{17804}=117\r\n)\r\nand\r\n({17805}<>2)','Interface {#IFDESCR}: Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15692,0,0,2,1,'({17802}>0 and {17806}>0) or\r\n({17805}=2)',0,'',1,''),(15694,'{17807}<0 and {17808}>0\r\nand (\r\n{17809}=6 or\r\n{17809}=7 or\r\n{17809}=11 or\r\n{17809}=62 or\r\n{17809}=69 or\r\n{17809}=117\r\n)\r\nand\r\n({17810}<>2)','Interface {#IFDESCR}: Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15692,0,0,2,1,'({17807}>0 and {17811}>0) or\r\n({17810}=2)',0,'',1,''),(15695,'{17812}<0 and {17813}>0\r\nand (\r\n{17814}=6 or\r\n{17814}=7 or\r\n{17814}=11 or\r\n{17814}=62 or\r\n{17814}=69 or\r\n{17814}=117\r\n)\r\nand\r\n({17815}<>2)','Interface {#IFDESCR}: Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',NULL,0,0,2,1,'({17812}>0 and {17816}>0) or\r\n({17815}=2)',0,'',1,''),(15696,'{17817}<0 and {17818}>0\r\nand (\r\n{17819}=6 or\r\n{17819}=7 or\r\n{17819}=11 or\r\n{17819}=62 or\r\n{17819}=69 or\r\n{17819}=117\r\n)\r\nand\r\n({17820}<>2)','Interface {#IFDESCR}: Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15695,0,0,2,1,'({17817}>0 and {17821}>0) or\r\n({17820}=2)',0,'',1,''),(15697,'{17822}<0 and {17823}>0\r\nand (\r\n{17824}=6 or\r\n{17824}=7 or\r\n{17824}=11 or\r\n{17824}=62 or\r\n{17824}=69 or\r\n{17824}=117\r\n)\r\nand\r\n({17825}<>2)','Interface {#IFDESCR}: Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15695,0,0,2,1,'({17822}>0 and {17826}>0) or\r\n({17825}=2)',0,'',1,''),(15698,'{17827}<0 and {17828}>0\r\nand (\r\n{17829}=6 or\r\n{17829}=7 or\r\n{17829}=11 or\r\n{17829}=62 or\r\n{17829}=69 or\r\n{17829}=117\r\n)\r\nand\r\n({17830}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',NULL,0,0,2,1,'({17827}>0 and {17831}>0) or\r\n({17830}=2)',0,'',1,''),(15699,'{17832}<0 and {17833}>0\r\nand (\r\n{17834}=6 or\r\n{17834}=7 or\r\n{17834}=11 or\r\n{17834}=62 or\r\n{17834}=69 or\r\n{17834}=117\r\n)\r\nand\r\n({17835}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15698,0,0,2,1,'({17832}>0 and {17836}>0) or\r\n({17835}=2)',0,'',1,''),(15700,'{17837}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1,''),(15701,'{17838}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(15702,'{17839}>{$ICMP_LOSS_WARN} and {17839}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(15703,'{17840}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(15704,'{17841}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15705,'{17842}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15706,'{17843}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17844}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17843}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17844}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1,''),(15707,'({17845}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17846} or\r\n{17847}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17846}) and\r\n{17846}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17845}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17846} and\r\n{17847}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17846}',0,'',1,''),(15708,'{17848}<0 and {17849}>0\r\nand (\r\n{17850}=6 or\r\n{17850}=7 or\r\n{17850}=11 or\r\n{17850}=62 or\r\n{17850}=69 or\r\n{17850}=117\r\n)\r\nand\r\n({17851}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17848}>0 and {17852}>0) or\r\n({17851}=2)',0,'',1,''),(15709,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17853}=2 and {17854}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17853}<>2',0,'',0,''),(15710,'{17855}>{$CPU_UTIL_MAX}','{#DEVICE_DESCR}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(15711,'{17856}>{$MEMORY_UTIL_MAX}','#{#SNMPINDEX}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(15712,'{17857}>{$STORAGE_UTIL_CRIT}','{#SNMPVALUE}: Disk space is critically low','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(15713,'{17858}>{$STORAGE_UTIL_WARN}','{#SNMPVALUE}: Disk space is low','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0,''),(15714,'{17859}>{$TEMP_WARN:\"\"}\r\nor\r\n{17860}={$TEMP_WARN_STATUS}','{#SENSOR_INFO}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17861}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(15715,'{17862}>{$TEMP_CRIT:\"\"}','{#SENSOR_INFO}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17863}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(15716,'{17864}<{$TEMP_CRIT_LOW:\"\"}','{#SENSOR_INFO}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17865}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(15717,'{17866}=1','{#SENSOR_INFO}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15718,'{17867}=1 and {17868}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1,''),(15719,'{17869}=1','{#ENT_NAME}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15720,'{17870}=1','System status is in critical state','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for errors','',NULL,0,0,0,0,'',0,'',0,''),(15721,'{17871}=1 or {17872}=1','System status is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for warnings','',NULL,0,0,0,0,'',0,'',0,''),(15722,'{17873}=1','System status is in critical state','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for errors','',NULL,0,0,0,0,'',0,'',0,''),(15723,'{17874}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(15724,'{17875}>{$ICMP_LOSS_WARN} and {17875}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(15725,'{17876}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(15726,'{17877}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15727,'{17878}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15728,'{17879}=1','System is in unrecoverable state!','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,0,0,'',0,'',0,''),(15729,'{17880}=1','System status is in critical state','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for errors','',NULL,0,0,0,0,'',0,'',0,''),(15730,'{17881}=1','System status is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for warnings','',NULL,0,0,0,0,'',0,'',0,''),(15731,'{17882}=1 and {17883}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(15732,'{17884}=1 and {17885}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(15733,'{17886}>{$TEMP_WARN:\"CPU\"}\r\nor\r\n{17887}={$TEMP_WARN_STATUS}','{#SENSOR_LOCALE}: Temperature is above warning threshold: >{$TEMP_WARN:\"CPU\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17888}<{$TEMP_WARN:\"CPU\"}-3',0,'',0,''),(15734,'{17889}>{$TEMP_CRIT:\"CPU\"}\r\nor\r\n{17890}={$TEMP_CRIT_STATUS}\r\nor\r\n{17890}={$TEMP_DISASTER_STATUS}','{#SENSOR_LOCALE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"CPU\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17891}<{$TEMP_CRIT:\"CPU\"}-3',0,'',0,''),(15735,'{17892}<{$TEMP_CRIT_LOW:\"CPU\"}','{#SENSOR_LOCALE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"CPU\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17893}>{$TEMP_CRIT_LOW:\"CPU\"}+3',0,'',0,''),(15736,'{17894}>{$TEMP_WARN:\"Ambient\"}\r\nor\r\n{17895}={$TEMP_WARN_STATUS}','{#SENSOR_LOCALE}: Temperature is above warning threshold: >{$TEMP_WARN:\"Ambient\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17896}<{$TEMP_WARN:\"Ambient\"}-3',0,'',0,''),(15737,'{17897}>{$TEMP_CRIT:\"Ambient\"}\r\nor\r\n{17898}={$TEMP_CRIT_STATUS}\r\nor\r\n{17898}={$TEMP_DISASTER_STATUS}','{#SENSOR_LOCALE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"Ambient\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17899}<{$TEMP_CRIT:\"Ambient\"}-3',0,'',0,''),(15738,'{17900}<{$TEMP_CRIT_LOW:\"Ambient\"}','{#SENSOR_LOCALE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"Ambient\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17901}>{$TEMP_CRIT_LOW:\"Ambient\"}+3',0,'',0,''),(15739,'{17902}=1 or {17903}=1','{#PSU_DESCR}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15740,'{17904}=1','{#PSU_DESCR}: Power supply is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15741,'{17905}=1 or {17906}=1 or {17907}=1 or {17908}=1 or {17909}=1','{#FAN_DESCR}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15742,'{17910}=1 or {17911}=1','{#FAN_DESCR}: Fan is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15743,'{17912}=1 or {17913}=1','{#DISK_NAME}: Physical disk failed','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check physical disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0,''),(15744,'{17914}=1','{#DISK_NAME}: Physical disk is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check physical disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0,''),(15745,'{17915}=1 and {17916}>0','{#DISK_NAME}: Disk has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDisk serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1,''),(15746,'{17917}=1','{#DISK_NAME}: Physical disk S.M.A.R.T. failed','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nDisk probably requires replacement.','',NULL,0,0,2,0,'',0,'',0,''),(15747,'{17918}=1','Disk {#SNMPVALUE}({#DISK_NAME}): Virtual disk failed','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check virtual disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0,''),(15748,'{17919}=1','Disk {#SNMPVALUE}({#DISK_NAME}): Virtual disk is in warning state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check virtual disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0,''),(15749,'{17920}=1','{#CNTLR_NAME}: Disk array controller is in unrecoverable state!','',0,0,5,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0,''),(15750,'{17921}=1','{#CNTLR_NAME}: Disk array controller is in critical state','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0,''),(15751,'{17922}=1','{#CNTLR_NAME}: Disk array controller is in warning state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0,''),(15752,'{17923}=1','Battery {#BATTERY_NUM}: Disk array cache controller battery is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0,''),(15753,'{17924}=1','Battery {#BATTERY_NUM}: Disk array cache controller battery is not in optimal state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0,''),(15754,'{17925}=1','Battery {#BATTERY_NUM}: Disk array cache controller battery is in critical state!','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0,''),(15755,'{17926}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(15756,'{17927}>{$ICMP_LOSS_WARN} and {17927}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(15757,'{17928}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(15758,'{17929}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15759,'{17930}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15760,'{17931}=1','System status is in critical state','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for errors','',NULL,0,0,0,0,'',0,'',0,''),(15761,'{17932}=1','System status is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for warnings','',NULL,0,0,0,0,'',0,'',0,''),(15762,'{17933}=1 and {17934}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(15763,'{17935}>{$TEMP_WARN:\"{#SNMPINDEX}\"}','{#SNMPINDEX}: Temperature is above warning threshold: >{$TEMP_WARN:\"{#SNMPINDEX}\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17936}<{$TEMP_WARN:\"{#SNMPINDEX}\"}-3',0,'',0,''),(15764,'{17937}>{$TEMP_CRIT:\"{#SNMPINDEX}\"}','{#SNMPINDEX}: Temperature is above critical threshold: >{$TEMP_CRIT:\"{#SNMPINDEX}\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17938}<{$TEMP_CRIT:\"{#SNMPINDEX}\"}-3',0,'',0,''),(15765,'{17939}<{$TEMP_CRIT_LOW:\"{#SNMPINDEX}\"}','{#SNMPINDEX}: Temperature is too low: <{$TEMP_CRIT_LOW:\"{#SNMPINDEX}\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17940}>{$TEMP_CRIT_LOW:\"{#SNMPINDEX}\"}+3',0,'',0,''),(15766,'{17941}>{$TEMP_WARN:\"Ambient\"}','Ambient: Temperature is above warning threshold: >{$TEMP_WARN:\"Ambient\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17942}<{$TEMP_WARN:\"Ambient\"}-3',0,'',0,''),(15767,'{17943}>{$TEMP_CRIT:\"Ambient\"}','Ambient: Temperature is above critical threshold: >{$TEMP_CRIT:\"Ambient\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17944}<{$TEMP_CRIT:\"Ambient\"}-3',0,'',0,''),(15768,'{17945}<{$TEMP_CRIT_LOW:\"Ambient\"}','Ambient: Temperature is too low: <{$TEMP_CRIT_LOW:\"Ambient\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17946}>{$TEMP_CRIT_LOW:\"Ambient\"}+3',0,'',0,''),(15769,'{17947}>{$TEMP_WARN:\"CPU\"}','CPU-{#SNMPINDEX}: Temperature is above warning threshold: >{$TEMP_WARN:\"CPU\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17948}<{$TEMP_WARN:\"CPU\"}-3',0,'',0,''),(15770,'{17949}>{$TEMP_CRIT:\"CPU\"}','CPU-{#SNMPINDEX}: Temperature is above critical threshold: >{$TEMP_CRIT:\"CPU\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17950}<{$TEMP_CRIT:\"CPU\"}-3',0,'',0,''),(15771,'{17951}<{$TEMP_CRIT_LOW:\"CPU\"}','CPU-{#SNMPINDEX}: Temperature is too low: <{$TEMP_CRIT_LOW:\"CPU\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17952}>{$TEMP_CRIT_LOW:\"CPU\"}+3',0,'',0,''),(15772,'{17953}>{$TEMP_WARN:\"Memory\"}','Memory-{#SNMPINDEX}: Temperature is above warning threshold: >{$TEMP_WARN:\"Memory\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17954}<{$TEMP_WARN:\"Memory\"}-3',0,'',0,''),(15773,'{17955}>{$TEMP_CRIT:\"Memory\"}','Memory-{#SNMPINDEX}: Temperature is above critical threshold: >{$TEMP_CRIT:\"Memory\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17956}<{$TEMP_CRIT:\"Memory\"}-3',0,'',0,''),(15774,'{17957}<{$TEMP_CRIT_LOW:\"Memory\"}','Memory-{#SNMPINDEX}: Temperature is too low: <{$TEMP_CRIT_LOW:\"Memory\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17958}>{$TEMP_CRIT_LOW:\"Memory\"}+3',0,'',0,''),(15775,'{17959}>{$TEMP_WARN:\"PSU\"}','PSU-{#SNMPINDEX}: Temperature is above warning threshold: >{$TEMP_WARN:\"PSU\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17960}<{$TEMP_WARN:\"PSU\"}-3',0,'',0,''),(15776,'{17961}>{$TEMP_CRIT:\"PSU\"}','PSU-{#SNMPINDEX}: Temperature is above critical threshold: >{$TEMP_CRIT:\"PSU\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17962}<{$TEMP_CRIT:\"PSU\"}-3',0,'',0,''),(15777,'{17963}<{$TEMP_CRIT_LOW:\"PSU\"}','PSU-{#SNMPINDEX}: Temperature is too low: <{$TEMP_CRIT_LOW:\"PSU\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17964}>{$TEMP_CRIT_LOW:\"PSU\"}+3',0,'',0,''),(15778,'{17965}>{$TEMP_WARN:\"Device\"}','System-{#SNMPINDEX}: Temperature is above warning threshold: >{$TEMP_WARN:\"Device\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17966}<{$TEMP_WARN:\"Device\"}-3',0,'',0,''),(15779,'{17967}>{$TEMP_CRIT:\"Device\"}','System-{#SNMPINDEX}: Temperature is above critical threshold: >{$TEMP_CRIT:\"Device\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17968}<{$TEMP_CRIT:\"Device\"}-3',0,'',0,''),(15780,'{17969}<{$TEMP_CRIT_LOW:\"Device\"}','System-{#SNMPINDEX}: Temperature is too low: <{$TEMP_CRIT_LOW:\"Device\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17970}>{$TEMP_CRIT_LOW:\"Device\"}+3',0,'',0,''),(15781,'{17971}=1','Chassis {#CHASSIS_NUM}, bay {#BAY_NUM}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15782,'{17972}=1','Chassis {#CHASSIS_NUM}, bay {#BAY_NUM}: Power supply is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15783,'{17973}=1','Fan {#SNMPINDEX}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15784,'{17974}=1','Fan {#SNMPINDEX}: Fan is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15785,'{17975}=1','{#CNTLR_LOCATION}: Disk array controller is in critical state','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0,''),(15786,'{17976}=1','{#CNTLR_LOCATION}: Disk array controller is in warning state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0,''),(15787,'{17977}=1','#{#CACHE_CNTRL_INDEX}: Disk array cache controller is in critical state!','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0,''),(15788,'{17978}=1 or {17979}=1 or {17980}=1 or {17981}=1','#{#CACHE_CNTRL_INDEX}: Disk array cache controller is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0,''),(15789,'{17982}=1','#{#CACHE_CNTRL_INDEX}: Disk array cache controller is not in optimal state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0,''),(15790,'{17983}=1 or {17984}=1','#{#CACHE_CNTRL_INDEX}: Disk array cache controller battery is in critical state!','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0,''),(15791,'{17985}=1 or {17986}=1','#{#CACHE_CNTRL_INDEX}: Disk array cache controller battery is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0,''),(15792,'{17987}=1','{#DISK_LOCATION}: Physical disk failed','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check physical disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0,''),(15793,'{17988}=1','{#DISK_LOCATION}: Physical disk is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check physical disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0,''),(15794,'{17989}=1 or {17990}=1','{#DISK_LOCATION}: Physical disk S.M.A.R.T. failed','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nDisk probably requires replacement.','',NULL,0,0,2,0,'',0,'',0,''),(15795,'{17991}=1 and {17992}>0','{#DISK_LOCATION}: Disk has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDisk serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1,''),(15796,'{17993}=1','Disk {#SNMPINDEX}({#DISK_NAME}): Virtual disk failed','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check virtual disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0,''),(15797,'{17994}=1','Disk {#SNMPINDEX}({#DISK_NAME}): Virtual disk is not in OK state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check virtual disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0,''),(15798,'{17995}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14288,0,0,0,0,'',0,'',0,''),(15799,'{17996}>{$ICMP_LOSS_WARN} and {17996}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14289,0,0,0,0,'',0,'',0,''),(15800,'{17997}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14290,0,0,0,0,'',0,'',0,''),(15801,'{17998}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15642,0,0,0,0,'',0,'',1,''),(15802,'{17999}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15161,0,0,0,0,'',0,'',0,''),(15803,'{18000}=1','System is in unrecoverable state!','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,0,0,'',0,'',0,''),(15804,'{18001}=1','System status is in critical state','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for errors','',NULL,0,0,0,0,'',0,'',0,''),(15805,'{18002}=1','System status is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for warnings','',NULL,0,0,0,0,'',0,'',0,''),(15806,'{18003}=1 and {18004}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(15807,'{18005}>{$TEMP_WARN:\"\"}','{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18006}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(15808,'{18007}>{$TEMP_CRIT:\"\"}','{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18008}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(15809,'{18009}<{$TEMP_CRIT_LOW:\"\"}','{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18010}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(15810,'{18011}>{$TEMP_WARN:\"Ambient\"}','Ambient: Temperature is above warning threshold: >{$TEMP_WARN:\"Ambient\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18012}<{$TEMP_WARN:\"Ambient\"}-3',0,'',0,''),(15811,'{18013}>{$TEMP_CRIT:\"Ambient\"}','Ambient: Temperature is above critical threshold: >{$TEMP_CRIT:\"Ambient\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18014}<{$TEMP_CRIT:\"Ambient\"}-3',0,'',0,''),(15812,'{18015}<{$TEMP_CRIT_LOW:\"Ambient\"}','Ambient: Temperature is too low: <{$TEMP_CRIT_LOW:\"Ambient\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18016}>{$TEMP_CRIT_LOW:\"Ambient\"}+3',0,'',0,''),(15813,'{18017}>{$TEMP_WARN:\"CPU\"}','CPU: Temperature is above warning threshold: >{$TEMP_WARN:\"CPU\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18018}<{$TEMP_WARN:\"CPU\"}-3',0,'',0,''),(15814,'{18019}>{$TEMP_CRIT:\"CPU\"}','CPU: Temperature is above critical threshold: >{$TEMP_CRIT:\"CPU\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18020}<{$TEMP_CRIT:\"CPU\"}-3',0,'',0,''),(15815,'{18021}<{$TEMP_CRIT_LOW:\"CPU\"}','CPU: Temperature is too low: <{$TEMP_CRIT_LOW:\"CPU\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18022}>{$TEMP_CRIT_LOW:\"CPU\"}+3',0,'',0,''),(15816,'{18023}=1','{#PSU_DESCR}: Power supply is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15817,'{18024}=1','{#FAN_DESCR}: Fan is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15818,'{18025}=1','{#SNMPINDEX}: Physical disk is not in OK state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check physical disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0,''),(15819,'{18026}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(15820,'{18027}>{$ICMP_LOSS_WARN} and {18027}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(15821,'{18028}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(15822,'{18029}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15823,'{18030}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15824,'{18031}=1','System is in unrecoverable state!','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,0,0,'',0,'',0,''),(15825,'{18032}=1','System status is in critical state','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for errors','',NULL,0,0,0,0,'',0,'',0,''),(15826,'{18033}=1','System status is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for warnings','',NULL,0,0,0,0,'',0,'',0,''),(15827,'{18034}=1 and {18035}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1,''),(15828,'{18036}>{$TEMP_WARN:\"\"}','{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18037}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(15829,'{18038}>{$TEMP_CRIT:\"\"}','{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18039}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(15830,'{18040}<{$TEMP_CRIT_LOW:\"\"}','{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18041}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(15831,'{18042}>{$TEMP_WARN:\"Ambient\"}','Ambient: Temperature is above warning threshold: >{$TEMP_WARN:\"Ambient\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18043}<{$TEMP_WARN:\"Ambient\"}-3',0,'',0,''),(15832,'{18044}>{$TEMP_CRIT:\"Ambient\"}','Ambient: Temperature is above critical threshold: >{$TEMP_CRIT:\"Ambient\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18045}<{$TEMP_CRIT:\"Ambient\"}-3',0,'',0,''),(15833,'{18046}<{$TEMP_CRIT_LOW:\"Ambient\"}','Ambient: Temperature is too low: <{$TEMP_CRIT_LOW:\"Ambient\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18047}>{$TEMP_CRIT_LOW:\"Ambient\"}+3',0,'',0,''),(15834,'{18048}>{$TEMP_WARN:\"CPU\"}','CPU: Temperature is above warning threshold: >{$TEMP_WARN:\"CPU\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18049}<{$TEMP_WARN:\"CPU\"}-3',0,'',0,''),(15835,'{18050}>{$TEMP_CRIT:\"CPU\"}','CPU: Temperature is above critical threshold: >{$TEMP_CRIT:\"CPU\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18051}<{$TEMP_CRIT:\"CPU\"}-3',0,'',0,''),(15836,'{18052}<{$TEMP_CRIT_LOW:\"CPU\"}','CPU: Temperature is too low: <{$TEMP_CRIT_LOW:\"CPU\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18053}>{$TEMP_CRIT_LOW:\"CPU\"}+3',0,'',0,''),(15837,'{18054}=1','{#PSU_DESCR}: Power supply is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0,''),(15838,'{18055}=1','{#FAN_DESCR}: Fan is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0,''),(15839,'{18056}=1','{#SNMPINDEX}: Physical disk is not in OK state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check physical disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0,''),(15840,'{18057}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0,''),(15841,'{18058}>{$ICMP_LOSS_WARN} and {18058}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0,''),(15842,'{18059}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0,''),(15843,'{18060}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1,''),(15844,'{18061}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0,''),(15845,'{18062}>{$TEMP_WARN:\"\"}','{#SENSOR_DESCR}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18063}<{$TEMP_WARN:\"\"}-3',0,'',0,''),(15846,'{18064}>{$TEMP_CRIT:\"\"}','{#SENSOR_DESCR}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18065}<{$TEMP_CRIT:\"\"}-3',0,'',0,''),(15847,'{18066}<{$TEMP_CRIT_LOW:\"\"}','{#SENSOR_DESCR}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18067}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0,''),(15848,'{18068} > ({18069} * 0.7)','70% http-8080 worker threads busy on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(15849,'{18070} > ({18071} * 0.7)','70% http-8443 worker threads busy on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(15850,'{18072} > ({18073}  *0.7)','70% jk-8009 worker threads busy on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0,''),(15851,'{18074} = 1','gzip compression is off for connector http-8080 on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(15852,'{18075} = 1','gzip compression is off for connector http-8443 on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0,''),(15853,'{18076}>75','Zabbix LLD manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18076}<65',0,'',0,''),(15854,'{18077}>75','Zabbix LLD manager processes more than 75% busy','',0,0,3,0,'','',15853,0,0,0,1,'{18077}<65',0,'',0,''),(15855,'{18078}>75','Zabbix LLD worker processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18078}<65',0,'',0,''),(15856,'{18079}>75','Zabbix LLD worker processes more than 75% busy','',0,0,3,0,'','',15855,0,0,0,1,'{18079}<65',0,'',0,''),(15857,'{18080}>75','More than 75% used in the configuration cache','',0,0,3,0,'Consider increasing CacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(15858,'{18081}>75','More than 75% used in the history cache','',0,0,3,0,'Consider increasing HistoryCacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(15859,'{18082}>75','More than 75% used in the history index cache','',0,0,3,0,'Consider increasing HistoryIndexCacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(15860,'{18083}>75','More than 75% used in the trends cache','',0,0,3,0,'Consider increasing TrendCacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(15861,'{18084}>75','More than 75% used in the vmware cache','',0,0,3,0,'Consider increasing VMwareCacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(15862,'{18085}>95','More than 95% used in the value cache','',0,0,3,0,'Consider increasing ValueCacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(15863,'{18086}>100','More than 100 items having missing data for more than 10 minutes','',0,0,2,0,'zabbix[stats,{$IP},{$PORT},queue,10m] item is collecting data about how many items are missing data for more than 10 minutes','',NULL,0,0,0,0,'',0,'',0,''),(15864,'{18087}>75','Zabbix alerter processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18087}<65',0,'',0,''),(15865,'{18088}>75','Zabbix alert manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18088}<65',0,'',0,''),(15866,'{18089}>75','Zabbix configuration syncer processes more than 75% busy','',0,0,3,0,'Zabbix configuration syncer processes more than 75% busy','',NULL,0,0,0,1,'{18089}<65',0,'',0,''),(15867,'{18090}>75','Zabbix discoverer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18090}<65',0,'',0,''),(15868,'{18091}>75','Zabbix escalator processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18091}<65',0,'',0,''),(15869,'{18092}>75','Zabbix history syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18092}<65',0,'',0,''),(15870,'{18093}>75','Zabbix housekeeper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18093}<65',0,'',0,''),(15871,'{18094}>75','Zabbix http poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18094}<65',0,'',0,''),(15872,'{18095}>75','Zabbix icmp pinger processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18095}<65',0,'',0,''),(15873,'{18096}>75','Zabbix ipmi manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18096}<65',0,'',0,''),(15874,'{18097}>75','Zabbix ipmi poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18097}<65',0,'',0,''),(15875,'{18098}>75','Zabbix java poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18098}<65',0,'',0,''),(15876,'{18099}>75','Zabbix poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18099}<65',0,'',0,''),(15877,'{18100}>75','Zabbix preprocessing manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18100}<65',0,'',0,''),(15878,'{18101}>75','Zabbix preprocessing worker processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18101}<65',0,'',0,''),(15879,'{18102}>75','Zabbix proxy poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18102}<65',0,'',0,''),(15880,'{18103}>75','Zabbix self-monitoring processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18103}<65',0,'',0,''),(15881,'{18104}>75','Zabbix snmp trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18104}<65',0,'',0,''),(15882,'{18105}>75','Zabbix task manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18105}<65',0,'',0,''),(15883,'{18106}>75','Zabbix timer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18106}<65',0,'',0,''),(15884,'{18107}>75','Zabbix trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18107}<65',0,'',0,''),(15885,'{18108}>75','Zabbix unreachable poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18108}<65',0,'',0,''),(15886,'{18109}=1','Zabbix value cache working in low memory mode','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0,''),(15887,'{18110}>75','Zabbix vmware collector processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18110}<65',0,'',0,''),(15888,'{18111}>75','Zabbix LLD manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18111}<65',0,'',0,''),(15889,'{18112}>75','Zabbix LLD worker processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18112}<65',0,'',0,''),(15890,'{18113}>75','More than 75% used in the configuration cache','',0,0,3,0,'Consider increasing CacheSize in the zabbix_proxy.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(15891,'{18114}>75','More than 75% used in the history cache','',0,0,3,0,'Consider increasing HistoryCacheSize in the zabbix_proxy.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(15892,'{18115}>75','More than 75% used in the history index cache','',0,0,3,0,'Consider increasing HistoryIndexCacheSize in the zabbix_proxy.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(15893,'{18116}>75','More than 75% used in the vmware cache','',0,0,3,0,'Consider increasing VMwareCacheSize in the zabbix_proxy.conf configuration file','',NULL,0,0,0,0,'',0,'',0,''),(15894,'{18117}>100','More than 100 items having missing data for more than 10 minutes','',0,0,2,0,'zabbix[stats,{$IP},{$PORT},queue,10m] item is collecting data about how many items are missing data for more than 10 minutes','',NULL,0,0,0,0,'',0,'',0,''),(15895,'{18118}>75','Zabbix configuration syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18118}<65',0,'',0,''),(15896,'{18119}>75','Zabbix data sender processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18119}<65',0,'',0,''),(15897,'{18120}>75','Zabbix discoverer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18120}<65',0,'',0,''),(15898,'{18121}>75','Zabbix heartbeat sender processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18121}<65',0,'',0,''),(15899,'{18122}>75','Zabbix history syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18122}<65',0,'',0,''),(15900,'{18123}>75','Zabbix housekeeper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18123}<65',0,'',0,''),(15901,'{18124}>75','Zabbix http poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18124}<65',0,'',0,''),(15902,'{18125}>75','Zabbix icmp pinger processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18125}<65',0,'',0,''),(15903,'{18126}>75','Zabbix ipmi manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18126}<65',0,'',0,''),(15904,'{18127}>75','Zabbix ipmi poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18127}<65',0,'',0,''),(15905,'{18128}>75','Zabbix java poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18128}<65',0,'',0,''),(15906,'{18129}>75','Zabbix poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18129}<65',0,'',0,''),(15907,'{18130}>75','Zabbix self-monitoring processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18130}<65',0,'',0,''),(15908,'{18131}>75','Zabbix snmp trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18131}<65',0,'',0,''),(15909,'{18132}>75','Zabbix task manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18132}<65',0,'',0,''),(15910,'{18133}>75','Zabbix trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18133}<65',0,'',0,''),(15911,'{18134}>75','Zabbix unreachable poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18134}<65',0,'',0,''),(15912,'{18135}>75','Zabbix vmware collector processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18135}<65',0,'',0,''),(15913,'{18136}>75','Zabbix preprocessing manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18136}<65',0,'',0,''),(15914,'{18137}>75','Zabbix preprocessing worker processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18137}<65',0,'',0,'');
/*!40000 ALTER TABLE `triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `userid` bigint(20) unsigned NOT NULL,
  `alias` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `surname` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `passwd` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `autologin` int(11) NOT NULL DEFAULT '0',
  `autologout` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '15m',
  `lang` varchar(5) COLLATE utf8_bin NOT NULL DEFAULT 'en_GB',
  `refresh` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '30s',
  `type` int(11) NOT NULL DEFAULT '1',
  `theme` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT 'default',
  `attempt_failed` int(11) NOT NULL DEFAULT '0',
  `attempt_ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `attempt_clock` int(11) NOT NULL DEFAULT '0',
  `rows_per_page` int(11) NOT NULL DEFAULT '50',
  PRIMARY KEY (`userid`),
  UNIQUE KEY `users_1` (`alias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','Zabbix','Administrator','5fce1b3e34b520afeffb37ce08c7cd66','',1,'0','en_GB','30s',3,'default',0,'',0,50),(2,'guest','','','d41d8cd98f00b204e9800998ecf8427e','',0,'15m','en_GB','30s',1,'default',0,'',0,50);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_groups` (
  `id` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_groups_1` (`usrgrpid`,`userid`),
  KEY `users_groups_2` (`userid`),
  CONSTRAINT `c_users_groups_1` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE,
  CONSTRAINT `c_users_groups_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
INSERT INTO `users_groups` VALUES (4,7,1),(2,8,2);
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usrgrp`
--

DROP TABLE IF EXISTS `usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usrgrp` (
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `gui_access` int(11) NOT NULL DEFAULT '0',
  `users_status` int(11) NOT NULL DEFAULT '0',
  `debug_mode` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`usrgrpid`),
  UNIQUE KEY `usrgrp_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usrgrp`
--

LOCK TABLES `usrgrp` WRITE;
/*!40000 ALTER TABLE `usrgrp` DISABLE KEYS */;
INSERT INTO `usrgrp` VALUES (7,'Zabbix administrators',0,0,0),(8,'Guests',1,0,0),(9,'Disabled',0,1,0),(11,'Enabled debug mode',0,0,1),(12,'No access to the frontend',3,0,0);
/*!40000 ALTER TABLE `usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `valuemaps`
--

DROP TABLE IF EXISTS `valuemaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valuemaps` (
  `valuemapid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`valuemapid`),
  UNIQUE KEY `valuemaps_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valuemaps`
--

LOCK TABLES `valuemaps` WRITE;
/*!40000 ALTER TABLE `valuemaps` DISABLE KEYS */;
INSERT INTO `valuemaps` VALUES (4,'APC Battery Replacement Status'),(5,'APC Battery Status'),(28,'CISCO-ENVMON-MIB::CiscoEnvMonState'),(55,'CPQHLTH-MIB::cpqHeTemperatureLocale'),(72,'CPQIDA-MIB::cpqDaAccelBattery'),(71,'CPQIDA-MIB::cpqDaAccelStatus'),(56,'CPQIDA-MIB::cpqDaCntlrModel'),(74,'CPQIDA-MIB::cpqDaLogDrvFaultTol'),(75,'CPQIDA-MIB::cpqDaLogDrvStatus'),(73,'CPQIDA-MIB::cpqDaPhyDrvMediaType'),(70,'CPQIDA-MIB::cpqDaPhyDrvSmartStatus'),(57,'CPQIDA-MIB::cpqDaPhyDrvStatus'),(54,'CPQSINFO-MIB::status'),(7,'Dell Open Manage System Status'),(18,'ENTITY-SENSORS-MIB::EntitySensorStatus'),(48,'ENTITY-STATE-MIB::EntityOperState'),(33,'EQUIPMENT-MIB::swFanStatus'),(34,'EQUIPMENT-MIB::swPowerStatus'),(36,'EXTREME-SYSTEM-MIB::extremeFanOperational'),(37,'EXTREME-SYSTEM-MIB::extremeOverTemperatureAlarm'),(38,'EXTREME-SYSTEM-MIB::extremePowerSupplyStatus'),(19,'EtherLike-MIB::dot3StatsDuplexStatus'),(30,'F10-S-SERIES-CHASSIS-MIB::chSysFanTrayOperStatus'),(31,'F10-S-SERIES-CHASSIS-MIB::chSysPowerSupplyOperStatus'),(29,'F10-S-SERIES-CHASSIS-MIB::extremeFanOperational'),(50,'FASTPATH-BOXSERVICES-PRIVATE-MIB::boxServicesFanItemState'),(49,'FASTPATH-BOXSERVICES-PRIVATE-MIB::boxServicesPowSupplyItemState'),(51,'FASTPATH-BOXSERVICES-PRIVATE-MIB::boxServicesTempSensorState'),(27,'FOUNDRY-SN-AGENT-MIB::snChasFanOperStatus'),(26,'FOUNDRY-SN-AGENT-MIB::snChasPwrSupplyOperStatus'),(39,'HH3C-ENTITY-EXT-MIB::hh3cEntityExtErrorStatus'),(6,'HP Insight System Status'),(40,'HP-ICF-CHASSIS::hpicfSensorStatus'),(17,'HTTP response status code'),(41,'HUAWEI-ENTITY-EXTENT-MIB::hwEntityFanState'),(2,'Host availability'),(42,'ICS-CHASSIS-MIB::icsChassisFanOperStatus'),(44,'ICS-CHASSIS-MIB::icsChassisPowerSupplyOperStatus'),(43,'ICS-CHASSIS-MIB::icsChassisSensorSlotOperStatus'),(45,'ICS-CHASSIS-MIB::icsChassisTemperatureStatus'),(62,'IDRAC-MIB-SMIv2::BooleanType'),(59,'IDRAC-MIB-SMIv2::ObjectStatusEnum'),(60,'IDRAC-MIB-SMIv2::StatusProbeEnum'),(64,'IDRAC-MIB-SMIv2::batteryState'),(61,'IDRAC-MIB-SMIv2::physicalDiskComponentStatus'),(63,'IDRAC-MIB-SMIv2::physicalDiskMediaType'),(65,'IDRAC-MIB-SMIv2::virtualDiskLayout'),(66,'IDRAC-MIB-SMIv2::virtualDiskOperationalState'),(68,'IDRAC-MIB-SMIv2::virtualDiskReadPolicy'),(69,'IDRAC-MIB-SMIv2::virtualDiskState'),(67,'IDRAC-MIB-SMIv2::virtualDiskWritePolicy'),(20,'IF-MIB::ifOperStatus'),(21,'IF-MIB::ifType'),(58,'IMM-MIB::systemHealthStat'),(47,'JUNIPER-ALARM-MIB::jnxOperatingState'),(46,'JUNIPER-ALARM-MIB::jnxRedAlarmState'),(32,'MY-SYSTEM-MIB::mySystemFanIsNormal'),(14,'Maintenance status'),(52,'QTECH-MIB::sysFanStatus'),(53,'QTECH-MIB::sysPowerStatus'),(9,'SNMP device status (hrDeviceStatus)'),(11,'SNMP interface status (ifAdminStatus)'),(8,'SNMP interface status (ifOperStatus)'),(25,'SW-MIB::swOperStatus'),(24,'SW-MIB::swSensorStatus'),(1,'Service state'),(23,'TIMETRA-CHASSIS-MIB::TmnxDeviceState'),(35,'TruthValue'),(12,'VMware VirtualMachinePowerState'),(13,'VMware status'),(15,'Value cache operating mode'),(16,'Windows service startup type'),(3,'Windows service state'),(10,'Zabbix agent ping status'),(22,'zabbix.host.available');
/*!40000 ALTER TABLE `valuemaps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widget`
--

DROP TABLE IF EXISTS `widget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widget` (
  `widgetid` bigint(20) unsigned NOT NULL,
  `dashboardid` bigint(20) unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `width` int(11) NOT NULL DEFAULT '1',
  `height` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`widgetid`),
  KEY `widget_1` (`dashboardid`),
  CONSTRAINT `c_widget_1` FOREIGN KEY (`dashboardid`) REFERENCES `dashboard` (`dashboardid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widget`
--

LOCK TABLES `widget` WRITE;
/*!40000 ALTER TABLE `widget` DISABLE KEYS */;
INSERT INTO `widget` VALUES (1,1,'systeminfo','',0,0,4,4),(2,1,'problemsbysv','',4,0,6,4),(3,1,'clock','',10,0,2,4),(4,1,'problems','',0,4,10,10),(5,1,'favmaps','',10,4,2,5),(6,1,'favgraphs','',10,9,2,5),(7,2,'problems','Zabbix server problems',0,0,10,4),(8,2,'clock','Local time',10,0,2,4),(9,2,'svggraph','Values processed per second',0,4,4,5),(10,2,'svggraph','Utilization of data collectors',4,4,4,5),(11,2,'svggraph','Utilization of internal processes',8,4,4,5),(12,2,'svggraph','Cache usage',0,9,4,5),(13,2,'svggraph','Value cache effectiveness',4,9,4,5),(14,2,'svggraph','Queue size',8,9,4,5);
/*!40000 ALTER TABLE `widget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widget_field`
--

DROP TABLE IF EXISTS `widget_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widget_field` (
  `widget_fieldid` bigint(20) unsigned NOT NULL,
  `widgetid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value_int` int(11) NOT NULL DEFAULT '0',
  `value_str` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value_groupid` bigint(20) unsigned DEFAULT NULL,
  `value_hostid` bigint(20) unsigned DEFAULT NULL,
  `value_itemid` bigint(20) unsigned DEFAULT NULL,
  `value_graphid` bigint(20) unsigned DEFAULT NULL,
  `value_sysmapid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`widget_fieldid`),
  KEY `widget_field_1` (`widgetid`),
  KEY `widget_field_2` (`value_groupid`),
  KEY `widget_field_3` (`value_hostid`),
  KEY `widget_field_4` (`value_itemid`),
  KEY `widget_field_5` (`value_graphid`),
  KEY `widget_field_6` (`value_sysmapid`),
  CONSTRAINT `c_widget_field_1` FOREIGN KEY (`widgetid`) REFERENCES `widget` (`widgetid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_2` FOREIGN KEY (`value_groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_3` FOREIGN KEY (`value_hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_4` FOREIGN KEY (`value_itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_5` FOREIGN KEY (`value_graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_6` FOREIGN KEY (`value_sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widget_field`
--

LOCK TABLES `widget_field` WRITE;
/*!40000 ALTER TABLE `widget_field` DISABLE KEYS */;
INSERT INTO `widget_field` VALUES (1,2,0,'hide_empty_groups',1,'',NULL,NULL,NULL,NULL,NULL),(2,4,0,'show',3,'',NULL,NULL,NULL,NULL,NULL),(3,4,0,'show_tags',3,'',NULL,NULL,NULL,NULL,NULL),(4,7,3,'hostids',0,'',NULL,10084,NULL,NULL,NULL),(5,9,0,'ds.axisy.0',0,'',NULL,NULL,NULL,NULL,NULL),(6,9,0,'ds.fill.0',3,'',NULL,NULL,NULL,NULL,NULL),(7,9,0,'ds.missingdatafunc.0',0,'',NULL,NULL,NULL,NULL,NULL),(8,9,0,'ds.transparency.0',0,'',NULL,NULL,NULL,NULL,NULL),(9,9,0,'ds.type.0',0,'',NULL,NULL,NULL,NULL,NULL),(10,9,0,'ds.width.0',1,'',NULL,NULL,NULL,NULL,NULL),(11,9,0,'graph_item_problems',0,'',NULL,NULL,NULL,NULL,NULL),(12,9,0,'legend',0,'',NULL,NULL,NULL,NULL,NULL),(13,9,0,'righty',0,'',NULL,NULL,NULL,NULL,NULL),(14,9,0,'show_problems',1,'',NULL,NULL,NULL,NULL,NULL),(15,9,1,'ds.color.0',0,'00BFFF',NULL,NULL,NULL,NULL,NULL),(16,9,1,'ds.hosts.0.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(17,9,1,'ds.items.0.0',0,'Number of processed *values per second',NULL,NULL,NULL,NULL,NULL),(18,9,1,'ds.timeshift.0',0,'',NULL,NULL,NULL,NULL,NULL),(19,9,1,'lefty_min',0,'0',NULL,NULL,NULL,NULL,NULL),(20,9,1,'problemhosts.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(21,10,0,'ds.axisy.0',0,'',NULL,NULL,NULL,NULL,NULL),(22,10,0,'ds.fill.0',3,'',NULL,NULL,NULL,NULL,NULL),(23,10,0,'ds.missingdatafunc.0',0,'',NULL,NULL,NULL,NULL,NULL),(24,10,0,'ds.transparency.0',0,'',NULL,NULL,NULL,NULL,NULL),(25,10,0,'ds.type.0',0,'',NULL,NULL,NULL,NULL,NULL),(26,10,0,'ds.width.0',1,'',NULL,NULL,NULL,NULL,NULL),(27,10,0,'graph_item_problems',0,'',NULL,NULL,NULL,NULL,NULL),(28,10,0,'legend',0,'',NULL,NULL,NULL,NULL,NULL),(29,10,0,'righty',0,'',NULL,NULL,NULL,NULL,NULL),(30,10,0,'show_problems',1,'',NULL,NULL,NULL,NULL,NULL),(31,10,1,'ds.color.0',0,'E57373',NULL,NULL,NULL,NULL,NULL),(32,10,1,'ds.hosts.0.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(33,10,1,'ds.items.0.0',0,'Utilization of * data collector *',NULL,NULL,NULL,NULL,NULL),(34,10,1,'ds.timeshift.0',0,'',NULL,NULL,NULL,NULL,NULL),(35,10,1,'lefty_max',0,'100',NULL,NULL,NULL,NULL,NULL),(36,10,1,'lefty_min',0,'0',NULL,NULL,NULL,NULL,NULL),(37,10,1,'problemhosts.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(38,11,0,'ds.axisy.0',0,'',NULL,NULL,NULL,NULL,NULL),(39,11,0,'ds.fill.0',3,'',NULL,NULL,NULL,NULL,NULL),(40,11,0,'ds.missingdatafunc.0',0,'',NULL,NULL,NULL,NULL,NULL),(41,11,0,'ds.transparency.0',0,'',NULL,NULL,NULL,NULL,NULL),(42,11,0,'ds.type.0',0,'',NULL,NULL,NULL,NULL,NULL),(43,11,0,'ds.width.0',1,'',NULL,NULL,NULL,NULL,NULL),(44,11,0,'graph_item_problems',0,'',NULL,NULL,NULL,NULL,NULL),(45,11,0,'legend',0,'',NULL,NULL,NULL,NULL,NULL),(46,11,0,'righty',0,'',NULL,NULL,NULL,NULL,NULL),(47,11,0,'show_problems',1,'',NULL,NULL,NULL,NULL,NULL),(48,11,1,'ds.color.0',0,'E57373',NULL,NULL,NULL,NULL,NULL),(49,11,1,'ds.hosts.0.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(50,11,1,'ds.items.0.0',0,'Utilization of * internal *',NULL,NULL,NULL,NULL,NULL),(51,11,1,'ds.timeshift.0',0,'',NULL,NULL,NULL,NULL,NULL),(52,11,1,'lefty_max',0,'100',NULL,NULL,NULL,NULL,NULL),(53,11,1,'lefty_min',0,'0',NULL,NULL,NULL,NULL,NULL),(54,11,1,'problemhosts.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(55,12,0,'ds.axisy.0',0,'',NULL,NULL,NULL,NULL,NULL),(56,12,0,'ds.fill.0',0,'',NULL,NULL,NULL,NULL,NULL),(57,12,0,'ds.missingdatafunc.0',0,'',NULL,NULL,NULL,NULL,NULL),(58,12,0,'ds.transparency.0',0,'',NULL,NULL,NULL,NULL,NULL),(59,12,0,'ds.type.0',0,'',NULL,NULL,NULL,NULL,NULL),(60,12,0,'ds.width.0',2,'',NULL,NULL,NULL,NULL,NULL),(61,12,0,'graph_item_problems',0,'',NULL,NULL,NULL,NULL,NULL),(62,12,0,'legend',0,'',NULL,NULL,NULL,NULL,NULL),(63,12,0,'righty',0,'',NULL,NULL,NULL,NULL,NULL),(64,12,0,'show_problems',1,'',NULL,NULL,NULL,NULL,NULL),(65,12,1,'ds.color.0',0,'4DB6AC',NULL,NULL,NULL,NULL,NULL),(66,12,1,'ds.hosts.0.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(67,12,1,'ds.items.0.0',0,'Zabbix*cache*% used',NULL,NULL,NULL,NULL,NULL),(68,12,1,'ds.timeshift.0',0,'',NULL,NULL,NULL,NULL,NULL),(69,12,1,'lefty_max',0,'100',NULL,NULL,NULL,NULL,NULL),(70,12,1,'lefty_min',0,'0',NULL,NULL,NULL,NULL,NULL),(71,12,1,'problemhosts.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(72,13,0,'ds.axisy.0',0,'',NULL,NULL,NULL,NULL,NULL),(73,13,0,'ds.axisy.1',0,'',NULL,NULL,NULL,NULL,NULL),(74,13,0,'ds.fill.0',3,'',NULL,NULL,NULL,NULL,NULL),(75,13,0,'ds.fill.1',3,'',NULL,NULL,NULL,NULL,NULL),(76,13,0,'ds.missingdatafunc.0',0,'',NULL,NULL,NULL,NULL,NULL),(77,13,0,'ds.missingdatafunc.1',0,'',NULL,NULL,NULL,NULL,NULL),(78,13,0,'ds.transparency.0',0,'',NULL,NULL,NULL,NULL,NULL),(79,13,0,'ds.transparency.1',0,'',NULL,NULL,NULL,NULL,NULL),(80,13,0,'ds.type.0',0,'',NULL,NULL,NULL,NULL,NULL),(81,13,0,'ds.type.1',0,'',NULL,NULL,NULL,NULL,NULL),(82,13,0,'ds.width.0',2,'',NULL,NULL,NULL,NULL,NULL),(83,13,0,'ds.width.1',2,'',NULL,NULL,NULL,NULL,NULL),(84,13,0,'graph_item_problems',0,'',NULL,NULL,NULL,NULL,NULL),(85,13,0,'legend',0,'',NULL,NULL,NULL,NULL,NULL),(86,13,0,'righty',0,'',NULL,NULL,NULL,NULL,NULL),(87,13,0,'show_problems',1,'',NULL,NULL,NULL,NULL,NULL),(88,13,1,'ds.color.0',0,'9CCC65',NULL,NULL,NULL,NULL,NULL),(89,13,1,'ds.color.1',0,'FF465C',NULL,NULL,NULL,NULL,NULL),(90,13,1,'ds.hosts.0.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(91,13,1,'ds.hosts.1.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(92,13,1,'ds.items.0.0',0,'Zabbix value cache hits',NULL,NULL,NULL,NULL,NULL),(93,13,1,'ds.items.1.0',0,'Zabbix value cache misses',NULL,NULL,NULL,NULL,NULL),(94,13,1,'ds.timeshift.0',0,'',NULL,NULL,NULL,NULL,NULL),(95,13,1,'ds.timeshift.1',0,'',NULL,NULL,NULL,NULL,NULL),(96,13,1,'lefty_min',0,'0',NULL,NULL,NULL,NULL,NULL),(97,13,1,'problemhosts.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(98,14,0,'ds.axisy.0',0,'',NULL,NULL,NULL,NULL,NULL),(99,14,0,'ds.axisy.1',0,'',NULL,NULL,NULL,NULL,NULL),(100,14,0,'ds.axisy.2',0,'',NULL,NULL,NULL,NULL,NULL),(101,14,0,'ds.fill.0',0,'',NULL,NULL,NULL,NULL,NULL),(102,14,0,'ds.fill.1',0,'',NULL,NULL,NULL,NULL,NULL),(103,14,0,'ds.fill.2',0,'',NULL,NULL,NULL,NULL,NULL),(104,14,0,'ds.missingdatafunc.0',0,'',NULL,NULL,NULL,NULL,NULL),(105,14,0,'ds.missingdatafunc.1',0,'',NULL,NULL,NULL,NULL,NULL),(106,14,0,'ds.missingdatafunc.2',0,'',NULL,NULL,NULL,NULL,NULL),(107,14,0,'ds.transparency.0',0,'',NULL,NULL,NULL,NULL,NULL),(108,14,0,'ds.transparency.1',0,'',NULL,NULL,NULL,NULL,NULL),(109,14,0,'ds.transparency.2',0,'',NULL,NULL,NULL,NULL,NULL),(110,14,0,'ds.type.0',0,'',NULL,NULL,NULL,NULL,NULL),(111,14,0,'ds.type.1',0,'',NULL,NULL,NULL,NULL,NULL),(112,14,0,'ds.type.2',0,'',NULL,NULL,NULL,NULL,NULL),(113,14,0,'ds.width.0',2,'',NULL,NULL,NULL,NULL,NULL),(114,14,0,'ds.width.1',2,'',NULL,NULL,NULL,NULL,NULL),(115,14,0,'ds.width.2',2,'',NULL,NULL,NULL,NULL,NULL),(116,14,0,'graph_item_problems',0,'',NULL,NULL,NULL,NULL,NULL),(117,14,0,'legend',0,'',NULL,NULL,NULL,NULL,NULL),(118,14,0,'righty',0,'',NULL,NULL,NULL,NULL,NULL),(119,14,0,'show_problems',1,'',NULL,NULL,NULL,NULL,NULL),(120,14,1,'ds.color.0',0,'B0AF07',NULL,NULL,NULL,NULL,NULL),(121,14,1,'ds.color.1',0,'E53935',NULL,NULL,NULL,NULL,NULL),(122,14,1,'ds.color.2',0,'0275B8',NULL,NULL,NULL,NULL,NULL),(123,14,1,'ds.hosts.0.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(124,14,1,'ds.hosts.1.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(125,14,1,'ds.hosts.2.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(126,14,1,'ds.items.0.0',0,'Zabbix queue',NULL,NULL,NULL,NULL,NULL),(127,14,1,'ds.items.1.0',0,'Zabbix queue over 10 minutes',NULL,NULL,NULL,NULL,NULL),(128,14,1,'ds.items.2.0',0,'Zabbix preprocessing queue',NULL,NULL,NULL,NULL,NULL),(129,14,1,'ds.timeshift.0',0,'',NULL,NULL,NULL,NULL,NULL),(130,14,1,'ds.timeshift.1',0,'',NULL,NULL,NULL,NULL,NULL),(131,14,1,'ds.timeshift.2',0,'',NULL,NULL,NULL,NULL,NULL),(132,14,1,'lefty_min',0,'0',NULL,NULL,NULL,NULL,NULL),(133,14,1,'problemhosts.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `widget_field` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-07-25 21:12:53