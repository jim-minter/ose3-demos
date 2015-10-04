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
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Appearance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `event_id` bigint(20) NOT NULL,
  `venue_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_b2ol0eoqtadvfoxhsnqcajgqa` (`event_id`,`venue_id`),
  KEY `FK_8s2lbwy173deq6xhtap48djlb` (`event_id`),
  KEY `FK_5xl8g6pwd699frupjk2bp03ks` (`venue_id`),
  CONSTRAINT `FK_5xl8g6pwd699frupjk2bp03ks` FOREIGN KEY (`venue_id`) REFERENCES `Venue` (`id`),
  CONSTRAINT `FK_8s2lbwy173deq6xhtap48djlb` FOREIGN KEY (`event_id`) REFERENCES `Event` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `Appearance` WRITE;
/*!40000 ALTER TABLE `Appearance` DISABLE KEYS */;
INSERT INTO `Appearance` VALUES (1,1,1),(2,1,2),(6,1,5),(3,2,1),(4,2,2),(5,3,3);
/*!40000 ALTER TABLE `Appearance` ENABLE KEYS */;
UNLOCK TABLES;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Booking` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cancellationCode` varchar(255) NOT NULL,
  `contactEmail` varchar(255) NOT NULL,
  `createdOn` datetime NOT NULL,
  `performance_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_leaf9xapkf0xcql0rj1ju6a3r` (`performance_id`),
  CONSTRAINT `FK_leaf9xapkf0xcql0rj1ju6a3r` FOREIGN KEY (`performance_id`) REFERENCES `Performance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `Booking` WRITE;
/*!40000 ALTER TABLE `Booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `Booking` ENABLE KEYS */;
UNLOCK TABLES;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Event` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(1000) NOT NULL,
  `name` varchar(50) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `mediaItem_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_ij7n685n8qbung3jvhw3rifm7` (`name`),
  KEY `FK_5nymmio04sew5y7o7wvtv82na` (`category_id`),
  KEY `FK_cck2yno71efp1ghlfme4ophux` (`mediaItem_id`),
  CONSTRAINT `FK_cck2yno71efp1ghlfme4ophux` FOREIGN KEY (`mediaItem_id`) REFERENCES `MediaItem` (`id`),
  CONSTRAINT `FK_5nymmio04sew5y7o7wvtv82na` FOREIGN KEY (`category_id`) REFERENCES `EventCategory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `Event` WRITE;
/*!40000 ALTER TABLE `Event` DISABLE KEYS */;
INSERT INTO `Event` VALUES (1,'Get ready to rock your night away with this megaconcert extravaganza from 10 of the biggest rock stars of the 80\'s','Rock concert of the decade',1,1),(2,'This critically acclaimed masterpiece will take you on an emotional rollercoaster the likes of which you\'ve never experienced.','Shane\'s Sock Puppets',2,2),(3,'A friendly replay of the famous World Cup final.','Brazil vs. Italy',4,6),(4,'Show your colors in Friday Night Lights! Come see the Red Hot Scorpions put the sting on the winners of Sunday\'s Coastal Quarterfinals for all state bragging rights. Fans entering the stadium in team color face paint will receive a $5 voucher redeemable with any on-site vendor. Body paint in lieu of clothing will not be permitted for this family friendly event.','All State Football Championship',4,7),(5,'Every tennis enthusiast will want to see Wimbledon legend Chris Lewis as he meets archrival Deuce Wild in the quarterfinals of one of the top U.S. tournaments. Finals are already sold out, so do not miss your chance to see the real action in play on the eve of the big day!','Chris Lewis Quarterfinals',4,11),(6,'Join your fellow crew junkies and snarky, self-important collegiate know-it-alls from the nations snobbiest schools to see which team is in fact the fastest show on oars. (Or, if you like, just purchase a ticket and sport a t-shirt from your local community college just to tick them off -- this event promises to be SO much fun!)','Crew You',4,12),(7,'What else is there to say? There\'s snow and sun and the bravest (or craziest) guys ever to strap two feet to a board and fly off a four-story ramp of ice and snow. Who would not want to see how aerial acrobatics are being redefined by the world\'s top adrenaline junkies?','Extreme Snowboarding Finals',4,13),(8,'Hear the sounds that have the critics abuzz. Be one of the first American audiences to experience Portuguese phenomenon Arrhythmia play all the tracks from their recently-released \'Graffiti\' -- the show includes a cameo with world-famous activist and graffiti artist Bansky.','Arrhythmia: Graffiti',1,8),(9,'That\'s right -- they\'ve blown into town! Join the annual tri-state Battle of the Brass Bands and watch them \'gild\' the winning band\'s Most Valuable Blower (MVB) -- don\'t worry (and don\'t inhale!); it\'s only spray paint!  Vote for your best band and revel in a day of high-energy rhythms!','Battle of the Brass Bands',1,9),(10,'Sit center stage as Harlequin Ayes gives another groundbreaking theater performance in the critically acclaimed Carnival Comes to Town, a monologue re-enactment of one-woman\'s despair at not being chosen to join the carnival she\'s spent her entire life preparing for.','Carnival Comes to Town',2,10),(11,'Get in touch with the stunning staccato and your inner Andalusian -- and put on your dancing shoes even if you\'re just in the audience! It\'s down to this one night of competition for the eight mesmerizing couples from around the globe that made it this far. Purchase VIP tickets to experience the competition and revel in the after-hours cabaret party with the world\'s most alluring dancers!','Flamenco Finale',2,14),(12,'It\'s one night only for this once-in-a-lifetime concert-in-the-round with Grammy winning folk and blues legend Jesse Lewis. Entirely stripped of elaborate recording production, Lewis\' music stands entirely on its own and has audiences raving it\'s his best work ever. With limited seating this final concert, don\'t dare to miss this classic you can tell your grandkids about when they develop some real taste in music.','Jesse Lewis Unplugged',1,15),(13,'Make way for Puccini\'s opera in three acts and wear waterproof mascara for the dramatic tearjerker of the season. Let the voice of renowned soprano Rosino Storchio and tenor Giovanni Zenatello envelop you under the stars while you sob quietly into your handkerchief! Wine and hard liquor will be available during intermission and after the show for those seeking to drown their sorrows.','Madame Butterfly',2,16),(14,'Join in the region\'s largest and most revered demonstration of one of the most mocked arts forms of all time. Stand in stunned silence while the masters of Mime Mania thrill with dramatic gestures that far surpass the now pass \"Woman in a Glass Box.\" See the famous, \"I have 10 fingers, don\'t make me give you one!\" and other favorites and be sure to enjoy the post-show silent auction.','Mime Mania!',2,17),(15,'This show is for all those who traded in Hemingway for the poetry of the Doors, but really can\'t remember why.  Come see a dead ringer for Jim Morrison and let the despair envelop your soul as he quotes from his tragic mentor, \"I believe in a prolonged derangement of the senses in order to obtain the unknown.\" But be advised: Leave your ganja at home, or leave with the Po-Po','Almost (Mostly) Morrison',1,18),(16,'Join your fellow ballet enthusiasts for the National Ballet Company\'s presentation of Tutu Tchai, a tribute to Pyotr Tchaikovsky\'s and the expressive intensity revealed in his three most famous ballets: The Nutcracker, Swan Lake, and The Sleeping Beauty.','Tutu Tchai',2,19),(17,'They\'re out to prove it\'s not all about the fights! Join your favorite members of the Canadian Women\'s Hockey League as they compete for the title \"Queen of the Slap Shot.\" Commonly believed to be hockey\'s toughest shot to execute, the speed and accuracy of slap shots will be measured on the ice. Fan participation and response will determine any ties. Proceeds will benefit local area domestic violence shelters.','Slap Shot',4,20),(18,'Your votes are in and the teams are assembled and coming to a stadium near you! Join Brendan \'Biceps\' Owen and the rest of the NBA\'s leading players for this blockbuster East versus West all-star game. Who will join the rarefied air with past MVP greats like Shaquille O\'Neal, LeBron James, and Kobe Bryant? Don\'t wait to see the highlights when you can experience it live!','Giants of the Game',4,21),(19,'You may not be at a British seaside but you heard right! Bring your family to witness a new twist on this traditional classic dating back to the 1600s ... only this time, Mr. Punch (and his stick) have met \"The 1%.\" Cheer (or jeer) from the crowd when you think Punch should use his stick on Mr. 1%. Fans agree, \"It\'s the best way to release your outrage at the wealthiest 1% without  being arrested!\".','Punch and Judy (with a Twist)',2,22);
/*!40000 ALTER TABLE `Event` ENABLE KEYS */;
UNLOCK TABLES;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EventCategory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_pcd6hbptlq9jx8t5l135k2mev` (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `EventCategory` WRITE;
/*!40000 ALTER TABLE `EventCategory` DISABLE KEYS */;
INSERT INTO `EventCategory` VALUES (5,'Comedy'),(1,'Concert'),(3,'Musical'),(4,'Sporting'),(2,'Theatre');
/*!40000 ALTER TABLE `EventCategory` ENABLE KEYS */;
UNLOCK TABLES;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MediaItem` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mediaType` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_4hr5wsvx6wqc3x7f62hi4icwk` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `MediaItem` WRITE;
/*!40000 ALTER TABLE `MediaItem` DISABLE KEYS */;
INSERT INTO `MediaItem` VALUES (1,'IMAGE','https://dl.dropbox.com/u/65660684/640px-Weir%2C_Bob_(2007)_2.jpg'),(2,'IMAGE','https://dl.dropbox.com/u/65660684/640px-Carnival_Puppets.jpg'),(3,'IMAGE','https://dl.dropbox.com/u/65660684/640px-Opera_House_with_Sydney.jpg'),(4,'IMAGE','https://dl.dropbox.com/u/65660684/640px-Roy_Thomson_Hall_Toronto.jpg'),(5,'IMAGE','https://dl.dropbox.com/u/65660684/640px-West-stand-bmo-field.jpg'),(6,'IMAGE','https://dl.dropbox.com/u/65660684/640px-Brazil_national_football_team_training_at_Dobsonville_Stadium_2010-06-03_13.jpg'),(7,'IMAGE','https://dl.dropbox.com/u/8625587/ticketmonster/AllStateFootballChampionship.png'),(8,'IMAGE','https://dl.dropbox.com/u/8625587/ticketmonster/ARhythmia.png'),(9,'IMAGE','https://dl.dropbox.com/u/8625587/ticketmonster/BattleoftheBrassBands.png'),(10,'IMAGE','https://dl.dropbox.com/u/8625587/ticketmonster/CarnivalComestoTown.png'),(11,'IMAGE','https://dl.dropbox.com/u/8625587/ticketmonster/ChrisLewisQuarterfinals.png'),(12,'IMAGE','https://dl.dropbox.com/u/8625587/ticketmonster/CrewYou.png'),(13,'IMAGE','https://dl.dropbox.com/u/8625587/ticketmonster/ExtremeSnowboardingFinals.png'),(14,'IMAGE','https://dl.dropbox.com/u/8625587/ticketmonster/FlamencoFinale.png'),(15,'IMAGE','https://dl.dropbox.com/u/8625587/ticketmonster/JesseLewisUnplugged.png'),(16,'IMAGE','https://dl.dropbox.com/u/8625587/ticketmonster/MadameButterfly.png'),(17,'IMAGE','https://dl.dropbox.com/u/8625587/ticketmonster/MimeMania.png'),(18,'IMAGE','https://dl.dropbox.com/u/8625587/ticketmonster/MorrisonCover.png'),(19,'IMAGE','https://dl.dropbox.com/u/8625587/ticketmonster/TutuTchai.png'),(20,'IMAGE','https://dl.dropbox.com/u/8625587/ticketmonster/SlapShot.png'),(21,'IMAGE','https://dl.dropbox.com/u/8625587/ticketmonster/Giantsofthegame.png'),(22,'IMAGE','https://dl.dropbox.com/u/8625587/ticketmonster/Punch%26Judy.png'),(23,'IMAGE','https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Paris_Opera_full_frontal_architecture%2C_May_2009.jpg/800px-Paris_Opera_full_frontal_architecture%2C_May_2009.jpg'),(24,'IMAGE','https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Boston_Symphony_Hall_from_the_south.jpg/800px-Boston_Symphony_Hall_from_the_south.jpg');
/*!40000 ALTER TABLE `MediaItem` ENABLE KEYS */;
UNLOCK TABLES;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Performance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `show_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_o9uuea91geqwv8cnwi1uq625w` (`date`,`show_id`),
  KEY `FK_2ad0jk30a6hi0twn2xxso6g71` (`show_id`),
  CONSTRAINT `FK_2ad0jk30a6hi0twn2xxso6g71` FOREIGN KEY (`show_id`) REFERENCES `Appearance` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `Performance` WRITE;
/*!40000 ALTER TABLE `Performance` DISABLE KEYS */;
INSERT INTO `Performance` VALUES (1,'2015-09-21 19:00:00',1),(10,'2015-09-21 19:00:00',6),(2,'2015-09-22 19:00:00',1),(11,'2015-09-22 19:00:00',6),(3,'2015-09-23 19:30:00',2),(4,'2015-09-24 19:30:00',2),(5,'2015-09-25 17:00:00',3),(6,'2015-09-25 19:30:00',3),(7,'2015-09-27 17:00:00',4),(8,'2015-09-27 19:30:00',4),(9,'2015-11-01 21:00:00',5);
/*!40000 ALTER TABLE `Performance` ENABLE KEYS */;
UNLOCK TABLES;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Section` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `numberOfRows` int(11) NOT NULL,
  `rowCapacity` int(11) NOT NULL,
  `venue_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_ruosqireipse41rdsuvhqj050` (`name`,`venue_id`),
  KEY `FK_bpuwo340e2jxwlwyf8qai3gql` (`venue_id`),
  CONSTRAINT `FK_bpuwo340e2jxwlwyf8qai3gql` FOREIGN KEY (`venue_id`) REFERENCES `Venue` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `Section` WRITE;
/*!40000 ALTER TABLE `Section` DISABLE KEYS */;
INSERT INTO `Section` VALUES (1,'Premier platinum reserve','A',20,100,1),(2,'Premier gold reserve','B',20,100,1),(3,'Premier silver reserve','C',30,100,1),(4,'General','D',40,100,1),(5,'Front left','S1',50,50,2),(6,'Front centre','S2',50,50,2),(7,'Front right','S3',50,50,2),(8,'Rear left','S4',50,50,2),(9,'Rear centre','S5',50,50,2),(10,'Rear right','S6',50,50,2),(11,'Balcony','S7',1,30,2),(12,'Premier platinum reserve','A',40,100,3),(13,'Premier gold reserve','B',40,100,3),(14,'Premier silver reserve','C',30,200,3),(15,'General','D',80,200,3),(16,'Center','A',10,60,4),(17,'Left','B',10,41,4),(18,'Right','C',10,41,4),(19,'Balcony','D',6,92,4),(20,'Center','A',10,60,5),(21,'Left','B',10,41,5),(22,'Right','C',10,41,5),(23,'Balcony','D',6,92,5);
/*!40000 ALTER TABLE `Section` ENABLE KEYS */;
UNLOCK TABLES;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SectionAllocation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `allocated` longblob,
  `occupiedCount` int(11) NOT NULL,
  `version` bigint(20) NOT NULL,
  `performance_id` bigint(20) NOT NULL,
  `section_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_25wlm457x8dmc00we5uw7an3s` (`performance_id`,`section_id`),
  KEY `FK_5dwueehoc18d429a6ma2e7t6` (`performance_id`),
  KEY `FK_ds4sl29sqh0snk7hw733p3fx0` (`section_id`),
  CONSTRAINT `FK_ds4sl29sqh0snk7hw733p3fx0` FOREIGN KEY (`section_id`) REFERENCES `Section` (`id`),
  CONSTRAINT `FK_5dwueehoc18d429a6ma2e7t6` FOREIGN KEY (`performance_id`) REFERENCES `Performance` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `SectionAllocation` WRITE;
/*!40000 ALTER TABLE `SectionAllocation` DISABLE KEYS */;
INSERT INTO `SectionAllocation` VALUES (1,NULL,0,1,1,1),(2,NULL,0,1,1,2),(3,NULL,0,1,1,3),(4,NULL,0,1,1,4),(5,NULL,0,1,2,1),(6,NULL,0,1,2,2),(7,NULL,0,1,2,3),(8,NULL,0,1,2,4),(9,NULL,0,1,3,5),(10,NULL,0,1,3,6),(11,NULL,0,1,3,7),(12,NULL,0,1,3,8),(13,NULL,0,1,3,9),(14,NULL,0,1,3,10),(15,NULL,0,1,3,11),(16,NULL,0,1,4,5),(17,NULL,0,1,4,6),(18,NULL,0,1,4,7),(19,NULL,0,1,4,8),(20,NULL,0,1,4,9),(21,NULL,0,1,4,10),(22,NULL,0,1,4,11),(23,NULL,0,1,5,1),(24,NULL,0,1,5,2),(25,NULL,0,1,5,3),(26,NULL,0,1,5,4),(27,NULL,0,1,6,1),(28,NULL,0,1,6,2),(29,NULL,0,1,6,3),(30,NULL,0,1,6,4),(31,NULL,0,1,7,5),(32,NULL,0,1,7,6),(33,NULL,0,1,7,7),(34,NULL,0,1,7,8),(35,NULL,0,1,7,9),(36,NULL,0,1,7,10),(37,NULL,0,1,7,11),(38,NULL,0,1,8,5),(39,NULL,0,1,8,6),(40,NULL,0,1,8,7),(41,NULL,0,1,8,8),(42,NULL,0,1,8,9),(43,NULL,0,1,8,10),(44,NULL,0,1,8,11),(45,NULL,0,1,9,12),(46,NULL,0,1,9,13),(47,NULL,0,1,9,14),(48,NULL,0,1,9,15),(49,NULL,0,1,10,20),(50,NULL,0,1,10,21),(51,NULL,0,1,10,22),(52,NULL,0,1,10,23),(53,NULL,0,1,11,20),(54,NULL,0,1,11,21),(55,NULL,0,1,11,22),(56,NULL,0,1,11,23);
/*!40000 ALTER TABLE `SectionAllocation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ticket` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `price` float NOT NULL,
  `number` int(11) NOT NULL,
  `rowNumber` int(11) NOT NULL,
  `section_id` bigint(20) DEFAULT NULL,
  `ticketCategory_id` bigint(20) NOT NULL,
  `tickets_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_pdk8eed2puqot8lx8c90ledjn` (`section_id`),
  KEY `FK_jvudijc5qlti0547g3fuoctis` (`ticketCategory_id`),
  KEY `FK_fphjem4g2orlpfeabeuxkhycx` (`tickets_id`),
  CONSTRAINT `FK_fphjem4g2orlpfeabeuxkhycx` FOREIGN KEY (`tickets_id`) REFERENCES `Booking` (`id`),
  CONSTRAINT `FK_jvudijc5qlti0547g3fuoctis` FOREIGN KEY (`ticketCategory_id`) REFERENCES `TicketCategory` (`id`),
  CONSTRAINT `FK_pdk8eed2puqot8lx8c90ledjn` FOREIGN KEY (`section_id`) REFERENCES `Section` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `Ticket` WRITE;
/*!40000 ALTER TABLE `Ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `Ticket` ENABLE KEYS */;
UNLOCK TABLES;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TicketCategory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_43455ipnchbn6r4bg8pviai3g` (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `TicketCategory` WRITE;
/*!40000 ALTER TABLE `TicketCategory` DISABLE KEYS */;
INSERT INTO `TicketCategory` VALUES (1,'Adult'),(2,'Child 0-14yrs');
/*!40000 ALTER TABLE `TicketCategory` ENABLE KEYS */;
UNLOCK TABLES;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TicketPrice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `price` float NOT NULL,
  `section_id` bigint(20) NOT NULL,
  `show_id` bigint(20) NOT NULL,
  `ticketCategory_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_rvx1s1nf4ihydinnk09u2udu5` (`section_id`,`show_id`,`ticketCategory_id`),
  KEY `FK_b4y5fuevgavs3drls31ni6wd3` (`section_id`),
  KEY `FK_ntne1lqkfmtmke809budx5itq` (`show_id`),
  KEY `FK_7o36hepy47tlyk1ta3ksix9fv` (`ticketCategory_id`),
  CONSTRAINT `FK_7o36hepy47tlyk1ta3ksix9fv` FOREIGN KEY (`ticketCategory_id`) REFERENCES `TicketCategory` (`id`),
  CONSTRAINT `FK_b4y5fuevgavs3drls31ni6wd3` FOREIGN KEY (`section_id`) REFERENCES `Section` (`id`),
  CONSTRAINT `FK_ntne1lqkfmtmke809budx5itq` FOREIGN KEY (`show_id`) REFERENCES `Appearance` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `TicketPrice` WRITE;
/*!40000 ALTER TABLE `TicketPrice` DISABLE KEYS */;
INSERT INTO `TicketPrice` VALUES (1,219.5,1,1,1),(2,199.5,2,1,1),(3,179.5,3,1,1),(4,149.5,4,1,1),(5,167.75,5,2,1),(6,197.75,6,2,1),(7,167.75,7,2,1),(8,155,8,2,1),(9,155,9,2,1),(10,155,10,2,1),(11,122.5,11,2,1),(12,157.5,5,2,2),(13,187.5,6,2,2),(14,157.5,7,2,2),(15,145,8,2,2),(16,145,9,2,2),(17,145,10,2,2),(18,112.5,11,2,2),(19,219.5,1,3,1),(20,199.5,2,3,1),(21,179.5,3,3,1),(22,149.5,4,3,1),(23,167.75,5,4,1),(24,197.75,6,4,1),(25,167.75,7,4,1),(26,155,8,4,1),(27,155,9,4,1),(28,155,10,4,1),(29,122.5,11,4,1),(30,219.5,12,5,1),(31,199.5,13,5,1),(32,179.5,14,5,1),(33,149.5,15,5,1),(34,219.5,20,6,1),(35,199.5,21,6,1),(36,110,22,6,1),(37,55,23,6,1);
/*!40000 ALTER TABLE `TicketPrice` ENABLE KEYS */;
UNLOCK TABLES;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Venue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `capacity` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `mediaItem_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_k049njfy1fdk2svm5m54ulorx` (`name`),
  KEY `FK_2c9wphvw1mi32yr614p4u7cuf` (`mediaItem_id`),
  CONSTRAINT `FK_2c9wphvw1mi32yr614p4u7cuf` FOREIGN KEY (`mediaItem_id`) REFERENCES `MediaItem` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `Venue` WRITE;
/*!40000 ALTER TABLE `Venue` DISABLE KEYS */;
INSERT INTO `Venue` VALUES (1,'Toronto','Canada','60 Simcoe Street',11000,'Roy Thomson Hall is the home of the Toronto Symphony Orchestra and the Toronto Mendelssohn Choir.','Roy Thomson Hall',4),(2,'Sydney','Australia','Bennelong point',15030,'The Sydney Opera House is a multi-venue performing arts centre in Sydney, New South Wales, Australia','Sydney Opera House',3),(3,'Toronto','Canada','170 Princes Boulevard',30000,'BMO Field is a Canadian soccer stadium located in Exhibition Place in the city of Toronto.','BMO Field',5),(4,'Paris','France','8 Rue Scribe',1972,'The Palais Garnier is a 1,979-seat opera house, which was built from 1861 to 1875 for the Paris Opera.','Opera Garnier',23),(5,'Boston','USA','301 Massachusetts Avenue',1972,'Designed by McKim, Mead and White, it was built in 1900 for the Boston Symphony Orchestra, which continues to make the hall its home. The hall was designated a U.S. National Historic Landmark in 1999.','Boston Symphony Hall',24);
/*!40000 ALTER TABLE `Venue` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
