-- phpMyAdmin SQL Dump
-- version 3.1.3.1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Окт 13 2009 г., 10:41
-- Версия сервера: 5.0.77
-- Версия PHP: 5.2.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `nfkLive`
--

-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_clanList`
--

CREATE TABLE IF NOT EXISTS `nfkLive_clanList` (
  `clanID` int(5) NOT NULL auto_increment,
  `clanTag` varchar(15) collate utf8_unicode_ci NOT NULL,
  `clanName` varchar(50) collate utf8_unicode_ci NOT NULL,
  `clanLeaderID` int(5) NOT NULL,
  PRIMARY KEY  (`clanID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `nfkLive_clanList`
--

INSERT INTO `nfkLive_clanList` (`clanID`, `clanTag`, `clanName`, `clanLeaderID`) VALUES
(1, '^1[^7KoD^1]', 'Kill or Die', 1),
(0, '', 'No Clan', 0),
(2, '<PFF>', 'PFF', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_dictionary`
--

CREATE TABLE IF NOT EXISTS `nfkLive_dictionary` (
  `id` int(5) NOT NULL auto_increment,
  `ident` varchar(255) collate utf8_unicode_ci NOT NULL,
  `language` varchar(3) collate utf8_unicode_ci NOT NULL,
  `translation` varchar(255) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Dictionary' AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `nfkLive_dictionary`
--

INSERT INTO `nfkLive_dictionary` (`id`, `ident`, `language`, `translation`) VALUES
(1, 'news', 'rus', 'Новости'),
(2, 'news', 'eng', 'News');

-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_geoipDB`
--

CREATE TABLE IF NOT EXISTS `nfkLive_geoipDB` (
  `ip_from` double NOT NULL,
  `ip_to` double NOT NULL,
  `cc2` varchar(2) collate utf8_unicode_ci NOT NULL,
  `cc3` varchar(3) collate utf8_unicode_ci NOT NULL,
  `c_name` varchar(50) collate utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Структура таблицы `nfkLive_groups`
--

CREATE TABLE IF NOT EXISTS `nfkLive_groups` (
  `id` int(5) NOT NULL auto_increment,
  `label` varchar(255) collate utf8_unicode_ci NOT NULL,
  `comment` varchar(255) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `nfkLive_groups`
--

INSERT INTO `nfkLive_groups` (`id`, `label`, `comment`) VALUES
(0, 'Anonymous', ''),
(1, 'Administrator', ''),
(2, 'Moderator', ''),
(3, 'Player', '');

-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_mapList`
--

CREATE TABLE IF NOT EXISTS `nfkLive_mapList` (
  `mapID` int(3) NOT NULL auto_increment,
  `mapName` varchar(50) collate utf8_unicode_ci NOT NULL,
  `authorName` varchar(50) collate utf8_unicode_ci NOT NULL,
  `timesPlayed` int(5) NOT NULL,
  UNIQUE KEY `mapID` (`mapID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `nfkLive_mapList`
--

INSERT INTO `nfkLive_mapList` (`mapID`, `mapName`, `authorName`, `timesPlayed`) VALUES
(1, 'dm0', '-', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_matchData`
--

CREATE TABLE IF NOT EXISTS `nfkLive_matchData` (
  `statID` int(5) NOT NULL auto_increment,
  `deaths` int(4) NOT NULL default '0',
  `dmggiven` int(5) NOT NULL default '0',
  `frags` int(4) NOT NULL default '0',
  `matchID` int(5) NOT NULL,
  `playerID` int(5) NOT NULL,
  `suisides` int(4) NOT NULL default '0',
  `dmgrecvd` int(4) NOT NULL default '0',
  `impressives` int(3) NOT NULL default '0',
  `excellents` int(3) NOT NULL default '0',
  `humiliations` int(3) NOT NULL default '0',
  `gaun_hits` int(5) NOT NULL default '0',
  `mach_hits` int(5) NOT NULL default '0',
  `shot_hits` int(5) NOT NULL default '0',
  `gren_hits` int(5) NOT NULL default '0',
  `rocket_hits` int(5) NOT NULL default '0',
  `shaft_hits` int(5) NOT NULL default '0',
  `plasma_hits` int(5) NOT NULL default '0',
  `rail_hits` int(5) NOT NULL default '0',
  `bfg_hits` int(5) NOT NULL default '0',
  `mach_fire` int(5) NOT NULL default '0',
  `shot_fire` int(5) NOT NULL default '0',
  `gren_fire` int(5) NOT NULL default '0',
  `rocket_fire` int(5) NOT NULL default '0',
  `shaft_fire` int(5) NOT NULL default '0',
  `plasma_fire` int(5) NOT NULL default '0',
  `rail_fire` int(5) NOT NULL default '0',
  `bfg_fire` int(5) NOT NULL default '0',
  UNIQUE KEY `statID` (`statID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Дамп данных таблицы `nfkLive_matchData`
--


-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_matchList`
--

CREATE TABLE IF NOT EXISTS `nfkLive_matchList` (
  `matchID` int(5) NOT NULL auto_increment,
  `serverID` int(5) NOT NULL,
  `gameType` int(1) NOT NULL,
  `gameTime` int(3) NOT NULL,
  `playerCount` int(2) NOT NULL,
  `mapID` int(5) NOT NULL,
  `dateTime` datetime NOT NULL,
  PRIMARY KEY  (`matchID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Дамп данных таблицы `nfkLive_matchList`
--


-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_medals`
--

CREATE TABLE IF NOT EXISTS `nfkLive_medals` (
  `medalID` int(3) NOT NULL auto_increment,
  `medalName` varchar(50) collate utf8_unicode_ci NOT NULL,
  `medalDescription` mediumtext collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`medalID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `nfkLive_medals`
--

INSERT INTO `nfkLive_medals` (`medalID`, `medalName`, `medalDescription`) VALUES
(1, 'Crash Dummy', 'Awarded to some portion of our beta testers.');

-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_modules`
--

CREATE TABLE IF NOT EXISTS `nfkLive_modules` (
  `id` int(5) NOT NULL auto_increment,
  `name` varchar(100) collate utf8_unicode_ci NOT NULL,
  `comment` varchar(255) character set utf8 NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Modules' AUTO_INCREMENT=1 ;

--
-- Дамп данных таблицы `nfkLive_modules`
--


-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_mod_news`
--

CREATE TABLE IF NOT EXISTS `nfkLive_mod_news` (
  `id` int(10) NOT NULL auto_increment,
  `news_type` int(2) NOT NULL,
  `news_topic` varchar(255) collate utf8_unicode_ci NOT NULL,
  `news_body` text collate utf8_unicode_ci NOT NULL,
  `poster_id` int(5) NOT NULL,
  `posted` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `nfkLive_mod_news`
--

INSERT INTO `nfkLive_mod_news` (`id`, `news_type`, `news_topic`, `news_body`, `poster_id`, `posted`) VALUES
(2, 1, 'test topic', 'test\r\nbody', 1, '2009-04-21 00:00:00');

-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_mod_news_types`
--

CREATE TABLE IF NOT EXISTS `nfkLive_mod_news_types` (
  `id` int(5) NOT NULL auto_increment,
  `alias` varchar(255) collate utf8_unicode_ci NOT NULL default 'undefined',
  `icon` varchar(255) collate utf8_unicode_ci NOT NULL default 'undefined',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `nfkLive_mod_news_types`
--

INSERT INTO `nfkLive_mod_news_types` (`id`, `alias`, `icon`) VALUES
(1, 'Site news', 'undefined');

-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_nodes`
--

CREATE TABLE IF NOT EXISTS `nfkLive_nodes` (
  `id` int(10) NOT NULL auto_increment,
  `alias` varchar(255) collate utf8_unicode_ci NOT NULL,
  `language` varchar(5) collate utf8_unicode_ci NOT NULL default 'rus',
  `title` varchar(255) collate utf8_unicode_ci NOT NULL,
  `body` longtext collate utf8_unicode_ci NOT NULL,
  `poster_id` int(5) NOT NULL,
  `posted` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `nfkLive_nodes`
--

INSERT INTO `nfkLive_nodes` (`id`, `alias`, `language`, `title`, `body`, `poster_id`, `posted`) VALUES
(1, 'test', 'rus', 'the TEST', 'this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line this isvery long line ', 1, '2009-04-24 00:00:00'),
(2, 'under-construction', 'rus', 'Sorry', '<br><br><br><br>\r\n<span valign=top style="font-family: ''Impact''; font-size: 24pt; color: #f2f2f2"><center>\r\nS I T E &nbsp; I S &nbsp; U N D E R &nbsp; C O <font color=red>N N</font> S T R U C T I O N\r\n</center>\r\n</span>', 1, '2009-04-24 11:57:30');

-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_permissions`
--

CREATE TABLE IF NOT EXISTS `nfkLive_permissions` (
  `id` int(11) NOT NULL auto_increment,
  `label` varchar(100) character set utf8 NOT NULL,
  `group_id` int(5) NOT NULL,
  `state` varchar(255) character set utf8 NOT NULL,
  `default` varchar(255) character set utf8 NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Permissions' AUTO_INCREMENT=1 ;

--
-- Дамп данных таблицы `nfkLive_permissions`
--


-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_playerRewards`
--

CREATE TABLE IF NOT EXISTS `nfkLive_playerRewards` (
  `statRewardID` int(10) NOT NULL auto_increment,
  `playerID` int(5) NOT NULL,
  `medalID` int(3) NOT NULL,
  `rewardTime` datetime NOT NULL,
  UNIQUE KEY `statRewardID` (`statRewardID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `nfkLive_playerRewards`
--

INSERT INTO `nfkLive_playerRewards` (`statRewardID`, `playerID`, `medalID`, `rewardTime`) VALUES
(1, 105, 1, '2009-10-05 14:49:03'),
(2, 2, 1, '2009-10-07 10:57:06'),
(3, 1, 1, '2009-10-08 00:21:51');

-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_playerStats`
--

CREATE TABLE IF NOT EXISTS `nfkLive_playerStats` (
  `statTableID` int(5) NOT NULL auto_increment,
  `playerID` int(5) NOT NULL,
  `games` int(10) NOT NULL default '0',
  `time` int(10) NOT NULL default '0',
  `lastGame` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `frags` int(10) NOT NULL default '0',
  `deaths` int(10) NOT NULL default '0',
  `wins` int(10) NOT NULL default '0',
  `losses_quits` int(10) NOT NULL default '0',
  `hits` int(10) NOT NULL default '0',
  `shots` int(10) NOT NULL default '0',
  `favWeapon` int(2) NOT NULL default '0',
  `favGameType` int(2) NOT NULL default '0',
  `gaun_hits` int(10) NOT NULL default '0',
  `gaun_fire` int(10) NOT NULL default '0',
  `gaun_kills` int(10) NOT NULL default '0',
  `mach_hits` int(10) NOT NULL default '0',
  `mach_fire` int(10) NOT NULL default '0',
  `mach_kills` int(10) NOT NULL default '0',
  `shot_hits` int(10) NOT NULL default '0',
  `shot_fire` int(10) NOT NULL default '0',
  `shot_kills` int(10) NOT NULL default '0',
  `gren_hits` int(10) NOT NULL default '0',
  `gren_fire` int(10) NOT NULL default '0',
  `gren_kills` int(10) NOT NULL default '0',
  `rocket_hits` int(10) NOT NULL default '0',
  `rocket_fire` int(10) NOT NULL default '0',
  `rocket_kills` int(10) NOT NULL default '0',
  `shaft_hits` int(10) NOT NULL default '0',
  `shaft_fire` int(10) NOT NULL default '0',
  `shaft_kills` int(10) NOT NULL default '0',
  `plasma_hits` int(10) NOT NULL default '0',
  `plasma_fire` int(10) NOT NULL default '0',
  `plasma_kills` int(10) NOT NULL default '0',
  `rail_hits` int(10) NOT NULL default '0',
  `rail_fire` int(10) NOT NULL default '0',
  `rail_kills` int(10) NOT NULL default '0',
  `bfg_hits` int(10) NOT NULL default '0',
  `bfg_fire` int(10) NOT NULL default '0',
  `bfg_kills` int(10) NOT NULL default '0',
  `tefrags` int(10) NOT NULL default '0',
  `humiliations` int(10) NOT NULL default '0',
  `impressives` int(10) NOT NULL default '0',
  `excellents` int(10) NOT NULL default '0',
  `dm` int(10) NOT NULL default '0',
  `duel` int(10) NOT NULL default '0',
  `tdm` int(10) NOT NULL default '0',
  `ctf` int(10) NOT NULL default '0',
  `trx` int(10) NOT NULL default '0',
  `tren` int(10) NOT NULL default '0',
  `rail` int(10) NOT NULL default '0',
  `dom` int(10) NOT NULL default '0',
  UNIQUE KEY `statTableID` (`statTableID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `nfkLive_playerStats`
--

INSERT INTO `nfkLive_playerStats` (`statTableID`, `playerID`, `games`, `time`, `lastGame`, `frags`, `deaths`, `wins`, `losses_quits`, `hits`, `shots`, `favWeapon`, `favGameType`, `gaun_hits`, `gaun_fire`, `gaun_kills`, `mach_hits`, `mach_fire`, `mach_kills`, `shot_hits`, `shot_fire`, `shot_kills`, `gren_hits`, `gren_fire`, `gren_kills`, `rocket_hits`, `rocket_fire`, `rocket_kills`, `shaft_hits`, `shaft_fire`, `shaft_kills`, `plasma_hits`, `plasma_fire`, `plasma_kills`, `rail_hits`, `rail_fire`, `rail_kills`, `bfg_hits`, `bfg_fire`, `bfg_kills`, `tefrags`, `humiliations`, `impressives`, `excellents`, `dm`, `duel`, `tdm`, `ctf`, `trx`, `tren`, `rail`, `dom`) VALUES
(1, 1, 13, 0, '2009-10-08 21:56:14', 57, 121, 0, 0, 632, 2038, 4, 0, 41, 0, 9, 127, 480, 0, 19, 38, 0, 10, 26, 0, 47, 84, 0, 337, 1332, 0, 28, 61, 0, 14, 17, 0, 0, 0, 0, 0, 9, 3, 5, 5, 0, 1, 5, 0, 0, 0, 0),
(2, 2, 15, 0, '2009-10-08 16:19:45', 411, 50, 0, 0, 2638, 5830, 7, 0, 30, 0, 12, 238, 564, 0, 134, 170, 0, 13, 41, 0, 353, 737, 0, 1008, 2567, 0, 627, 1417, 0, 220, 334, 0, 0, 0, 0, 0, 15, 31, 101, 10, 0, 3, 0, 0, 0, 0, 0),
(3, 105, 10, 200, '2009-10-05 13:57:10', 32, 30, 6, 4, 600, 700, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 105, 0, 0, '2009-10-08 16:38:01', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_serverList`
--

CREATE TABLE IF NOT EXISTS `nfkLive_serverList` (
  `serverID` int(5) NOT NULL auto_increment,
  `ssid` varchar(16) collate utf8_unicode_ci NOT NULL,
  `dedicated` tinyint(1) NOT NULL,
  `ttl` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `serverIP` varchar(15) collate utf8_unicode_ci NOT NULL,
  `port` int(5) NOT NULL,
  `hostname` varchar(50) collate utf8_unicode_ci NOT NULL,
  `gameType` int(1) NOT NULL,
  `mapName` varchar(50) collate utf8_unicode_ci NOT NULL,
  `timeLimit` int(2) NOT NULL,
  `timeLeft` int(3) NOT NULL,
  `playerCount` int(2) NOT NULL,
  `playerMax` int(2) NOT NULL,
  PRIMARY KEY  (`serverID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=174 ;

--
-- Дамп данных таблицы `nfkLive_serverList`
--

INSERT INTO `nfkLive_serverList` (`serverID`, `ssid`, `dedicated`, `ttl`, `serverIP`, `port`, `hostname`, `gameType`, `mapName`, `timeLimit`, `timeLeft`, `playerCount`, `playerMax`) VALUES
(29, '3245234532453245', 1, '2010-10-04 23:00:00', '85.29.238.50', 29991, 'demo1', 3, 'ctf1', 99, 99, 0, 8),
(30, '1LLFBMTB==JS5AY2', 1, '2010-12-02 21:21:50', '92.127.35.77', 29991, 'demo2', 0, 'tourney4', 10, 10, 0, 6),
(59, 'D7240TJH3OR853FL', 0, '2009-09-30 15:02:20', '92.127.35.77', 29991, 'coolant', 0, 'dm0', 1, 1, 1, 5),
(153, 'L468I16JQ85TRI15', 0, '2009-10-08 09:47:41', '92.127.60.139', 29991, 'welcome', 2, 'tdm1', 10, 10, 2, 4),
(150, 'A0Y7W0F252X6SK8S', 0, '2009-10-08 09:39:34', '92.127.60.139', 29991, 'welcome', 0, 'large1', 10, 10, 2, 4),
(122, '73NBW4YJA8U7UHAT', 0, '2009-10-07 10:31:38', '92.127.52.36', 29991, 'welcome', 0, 'dm2', 1, 1, 0, 4),
(147, '3UN3N86BN3RT6563', 0, '2009-10-08 08:51:25', '92.127.60.139', 29991, 'welcome', 0, 'dm2', 1, 1, 2, 4),
(115, 'CXRA0122C48DFT76', 0, '2009-10-07 09:56:38', '92.127.52.36', 29991, 'welcome', 0, 'dm0', 1, 1, 2, 4),
(97, 'ES6K38X6WRWI61J7', 0, '2009-10-05 09:44:12', '92.127.50.16', 29991, 'asdsa', 0, 'dm0', 1, 1, 1, 4),
(152, 'HXIA3O3N2308Q488', 0, '2009-10-08 09:42:48', '92.127.60.139', 29991, 'welcome', 0, 'tdm1', 10, 10, 2, 4),
(156, '2KV12JXPE172OXY5', 0, '2009-10-08 10:31:19', '92.127.63.102', 29991, 'welcome', 2, 'tdm1', 10, 10, 1, 4),
(155, 'FYHA556RP87VVQ40', 0, '2009-10-08 10:24:28', '92.127.63.102', 29991, 'welcome', 2, 'tdm1', 10, 10, 2, 4),
(160, '0E3Q145I173557E1', 0, '2009-10-08 11:05:36', '92.127.63.102', 29991, 'welcome', 2, 'tdm1', 10, 10, 4, 4),
(159, '57OE26KQ7U72NTSY', 0, '2009-10-08 10:53:35', '92.127.63.102', 29991, 'welcome', 0, 'dm0', 10, 10, 0, 4),
(169, 'S2XO04156L635UFS', 0, '2009-10-09 09:29:20', '92.127.53.143', 29991, 'welcome', 0, 'dm0', 5, 5, 0, 4),
(164, '8UXFBGNC38V1Q3PV', 0, '2009-10-08 13:56:33', '92.127.61.58', 29991, 'welcome', 0, 'dm0', 10, 10, 2, 4),
(172, '106U2RJQD7V85A01', 0, '2009-10-13 07:45:20', '92.127.53.49', 29991, 'tBots', 0, 'dm0', 1, 1, 1, 8);

-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_sessions`
--

CREATE TABLE IF NOT EXISTS `nfkLive_sessions` (
  `psid` varchar(16) collate utf8_unicode_ci NOT NULL,
  `playerID` int(5) NOT NULL,
  `sessionIP` varchar(15) collate utf8_unicode_ci NOT NULL,
  `ttl` datetime NOT NULL,
  UNIQUE KEY `ssID` (`psid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `nfkLive_sessions`
--

INSERT INTO `nfkLive_sessions` (`psid`, `playerID`, `sessionIP`, `ttl`) VALUES
('w9iqg7yj6Mvy0YUh', 2, '92.127.52.36', '2009-10-07 15:06:27'),
('lG9c0GTgfL2p8z9e', 1, '88.196.112.154', '2009-10-07 14:58:17'),
('S5Ie8ibd9FN8wRRf', 1, '88.196.112.154', '2009-10-07 14:01:45'),
('5U40v76WTVZPT6Lt', 105, '62.182.64.54', '2009-10-07 09:11:59'),
('j1k86ipOZ8kna96g', 2, '92.127.52.36', '2009-10-07 09:03:27'),
('zHw5eE3KUGsVVb2C', 105, '89.41.66.73', '2009-10-07 09:02:35'),
('5W0RmlvN16zx5axF', 1, '88.196.112.154', '2009-10-07 08:54:24'),
('1J6939vtP0q135Vu', 2, '92.127.60.139', '2009-10-08 09:43:01'),
('10Iky7Yai83GL7q8', 1, '85.29.238.50', '2009-10-07 19:25:09'),
('cc31a7XOm4D64363', 1, '85.29.238.50', '2009-10-07 19:46:14'),
('Pcjqx97g42aMKtJa', 1, '85.29.238.50', '2009-10-07 21:13:13'),
('i3674wD4ZBt8NUx5', 1, '85.29.238.50', '2009-10-07 23:51:53'),
('n02XDO5yH9NK4LG3', 2, '92.127.55.92', '2009-10-08 10:02:13'),
('73dXqO2gWO51pmK4', 2, '92.127.63.102', '2009-10-08 10:30:23'),
('2Cy0g5guRi136Ip7', 2, '92.127.63.102', '2009-10-08 10:31:29'),
('Bws8woWJl7lDr04O', 1, '84.50.0.16', '2009-10-08 10:44:04'),
('Y3vAn2lfWmcd6Y9o', 2, '92.127.63.102', '2009-10-08 10:49:10'),
('amVsJZddhjxfG6Y4', 2, '92.127.63.102', '2009-10-08 11:05:33'),
('Gq0hGvt18d78QtO3', 1, '84.50.0.16', '2009-10-08 12:39:52'),
('7hA8dFu4S4uv7wJp', 2, '92.127.61.58', '2009-10-08 13:46:44'),
('9t8tuCd13O8jOYYN', 1, '84.50.0.16', '2009-10-08 15:03:53'),
('MkO9qiOayzw6zz5z', 2, '92.127.51.103', '2009-10-08 15:39:53'),
('44jvb8ojNC517OBP', 2, '92.127.51.103', '2009-10-08 15:41:58'),
('2NFsM5JK4n9Li84h', 2, '92.127.53.143', '2009-10-09 09:56:33'),
('mdtj8o3kuemQuB5B', 2, '92.127.53.143', '2009-10-09 12:14:14'),
('aJUwLQcKHYYo2hbW', 2, '92.127.50.218', '2009-10-09 18:19:12'),
('NDfyzzun3b4vwt6V', 1, '85.29.238.50', '2009-10-09 23:59:01'),
('Mr33E5Vkpyo5kIB8', 2, '92.127.38.253', '2009-10-10 17:04:17'),
('8pt9cy57w329CF9E', 2, '92.127.51.129', '2009-10-12 08:13:06'),
('gm0Y3ly8h0G0Q4WG', 2, '92.127.53.49', '2009-10-13 06:21:49');

-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_settings`
--

CREATE TABLE IF NOT EXISTS `nfkLive_settings` (
  `id` int(5) NOT NULL auto_increment,
  `variable` varchar(50) character set utf8 NOT NULL,
  `value` varchar(255) character set utf8 NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Дамп данных таблицы `nfkLive_settings`
--


-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_usergroups`
--

CREATE TABLE IF NOT EXISTS `nfkLive_usergroups` (
  `id` int(10) NOT NULL auto_increment,
  `group_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Дамп данных таблицы `nfkLive_usergroups`
--

INSERT INTO `nfkLive_usergroups` (`id`, `group_id`, `user_id`) VALUES
(10, 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `nfkLive_users`
--

CREATE TABLE IF NOT EXISTS `nfkLive_users` (
  `id` int(5) NOT NULL auto_increment,
  `clanID` int(5) NOT NULL default '0',
  `login` varchar(100) collate utf8_unicode_ci NOT NULL,
  `password` varchar(255) collate utf8_unicode_ci NOT NULL,
  `full_name` varchar(255) collate utf8_unicode_ci NOT NULL,
  `cfg` text collate utf8_unicode_ci NOT NULL,
  `model` varchar(50) collate utf8_unicode_ci NOT NULL default 'sarge_default',
  `registered` datetime NOT NULL,
  `email` varchar(255) collate utf8_unicode_ci NOT NULL,
  `lastactive` datetime NOT NULL,
  `disabled` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='User Accounts' AUTO_INCREMENT=107 ;

--
-- Дамп данных таблицы `nfkLive_users`
--

INSERT INTO `nfkLive_users` (`id`, `clanID`, `login`, `password`, `full_name`, `cfg`, `model`, `registered`, `email`, `lastactive`, `disabled`) VALUES
(1, 1, 'connect', 'somepass', '^7co^1nn^7ect', '', 'doom_default', '2009-04-21 12:52:07', 'kod.connect@gmail.com', '2009-04-21 12:52:18', 0),
(2, 2, 'coolant', 'valuable', 'coolant', '', 'sarge_red', '2009-10-07 08:57:03', '', '2009-10-07 08:57:05', 0),
(105, 0, 'demo', 'demo', '^1D^2e^3m^4o^5U^7s^8e^9r', '', 'sarge_blue', '2009-10-05 13:53:29', 'i@have.no', '2009-10-05 13:53:31', 0),
(106, 2, 'XBitnik', 'tribes4eva', 'XBitnik', '', 'uriel_default', '2009-10-06 15:13:10', '', '2009-10-06 15:13:13', 0);
