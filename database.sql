-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 148.251.91.145:3307
-- Время создания: Ноя 23 2026 г., 01:00
-- Версия сервера: 11.8.8-MariaDB-ubu2404
-- Версия PHP: 8.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `template_empty`
--

-- --------------------------------------------------------

--
-- Структура таблицы `acccomments`
--

CREATE TABLE `acccomments` (
  `userID` int(11) NOT NULL,
  `userName` varchar(50) NOT NULL,
  `comment` longtext NOT NULL,
  `secret` varchar(10) NOT NULL DEFAULT 'unused',
  `commentID` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `isSpam` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `accounts`
--

CREATE TABLE `accounts` (
  `userName` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `gjp2` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `accountID` int(11) NOT NULL,
  `isAdmin` int(11) NOT NULL DEFAULT 0,
  `mS` int(11) NOT NULL DEFAULT 0,
  `frS` int(11) NOT NULL DEFAULT 0,
  `cS` int(11) NOT NULL DEFAULT 0,
  `gF` int(11) NOT NULL DEFAULT 1,
  `gO` int(11) NOT NULL DEFAULT 2,
  `youtubeurl` varchar(255) NOT NULL DEFAULT '',
  `twitter` varchar(255) NOT NULL DEFAULT '',
  `twitch` varchar(255) NOT NULL DEFAULT '',
  `instagram` varchar(255) NOT NULL DEFAULT '',
  `tiktok` varchar(255) NOT NULL DEFAULT '',
  `discord` varchar(255) NOT NULL DEFAULT '',
  `custom` varchar(255) NOT NULL DEFAULT '',
  `salt` varchar(255) NOT NULL DEFAULT '',
  `registerDate` int(11) NOT NULL DEFAULT 0,
  `friendsCount` int(11) NOT NULL DEFAULT 0,
  `followersCount` int(11) NOT NULL DEFAULT 0,
  `discordID` bigint(20) NOT NULL DEFAULT 0,
  `discordLinkReq` bigint(20) NOT NULL DEFAULT 0,
  `isActive` tinyint(1) NOT NULL DEFAULT 0,
  `auth` varchar(16) NOT NULL DEFAULT 'none',
  `mail` varchar(255) NOT NULL DEFAULT '',
  `passCode` varchar(255) NOT NULL DEFAULT '',
  `timezone` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `actions`
--

CREATE TABLE `actions` (
  `ID` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `value` varchar(255) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL DEFAULT 0,
  `value2` varchar(255) NOT NULL DEFAULT '0',
  `value3` varchar(255) NOT NULL DEFAULT '',
  `value4` varchar(255) NOT NULL DEFAULT '',
  `value5` varchar(255) NOT NULL DEFAULT '',
  `value6` varchar(255) NOT NULL DEFAULT '',
  `account` varchar(255) NOT NULL DEFAULT '',
  `IP` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `actions_downloads`
--

CREATE TABLE `actions_downloads` (
  `id` int(11) NOT NULL,
  `levelID` int(11) NOT NULL,
  `ip` varbinary(16) NOT NULL,
  `uploadDate` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `actions_likes`
--

CREATE TABLE `actions_likes` (
  `id` int(11) NOT NULL,
  `itemID` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `isLike` tinyint(4) NOT NULL,
  `ip` varbinary(16) NOT NULL,
  `uploadDate` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `automod`
--

CREATE TABLE `automod` (
  `ID` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `value1` varchar(255) NOT NULL DEFAULT '',
  `value2` varchar(255) NOT NULL DEFAULT '',
  `value3` varchar(255) NOT NULL DEFAULT '',
  `value4` varchar(255) NOT NULL DEFAULT '',
  `value5` varchar(255) NOT NULL DEFAULT '',
  `value6` varchar(255) NOT NULL DEFAULT '',
  `timestamp` int(11) NOT NULL DEFAULT 0,
  `resolved` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `bannedips`
--

CREATE TABLE `bannedips` (
  `IP` varchar(255) NOT NULL DEFAULT '127.0.0.1',
  `ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `bans`
--

CREATE TABLE `bans` (
  `banID` int(11) NOT NULL,
  `modID` varchar(255) NOT NULL DEFAULT '',
  `person` varchar(50) NOT NULL DEFAULT '',
  `reason` varchar(2048) NOT NULL DEFAULT '',
  `banType` int(11) NOT NULL DEFAULT 0,
  `personType` int(11) NOT NULL DEFAULT 0,
  `expires` int(11) NOT NULL DEFAULT 0,
  `isActive` int(11) NOT NULL DEFAULT 1,
  `timestamp` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `blocks`
--

CREATE TABLE `blocks` (
  `ID` int(11) NOT NULL,
  `person1` int(11) NOT NULL,
  `person2` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `clanrequests`
--

CREATE TABLE `clanrequests` (
  `ID` int(11) NOT NULL,
  `accountID` int(11) NOT NULL DEFAULT 0,
  `clanID` int(11) NOT NULL DEFAULT 0,
  `timestamp` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `clans`
--

CREATE TABLE `clans` (
  `ID` int(11) NOT NULL,
  `clan` varchar(255) NOT NULL DEFAULT '',
  `tag` varchar(15) NOT NULL DEFAULT '',
  `desc` varchar(2048) NOT NULL DEFAULT '',
  `clanOwner` int(11) NOT NULL DEFAULT 0,
  `color` varchar(6) NOT NULL DEFAULT 'FFFFFF',
  `isClosed` int(11) NOT NULL DEFAULT 0,
  `creationDate` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `comments`
--

CREATE TABLE `comments` (
  `userID` int(11) NOT NULL,
  `userName` varchar(50) NOT NULL,
  `comment` longtext NOT NULL,
  `secret` varchar(10) NOT NULL DEFAULT 'none',
  `levelID` int(11) NOT NULL,
  `commentID` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `percent` int(11) NOT NULL DEFAULT 0,
  `isSpam` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `content_reports`
--

CREATE TABLE `content_reports` (
  `reportID` int(11) NOT NULL,
  `reporterAccountID` int(11) NOT NULL,
  `targetAccountID` int(11) NOT NULL,
  `contentType` int(11) NOT NULL,
  `contentID` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL DEFAULT '',
  `pts` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `closedBy` int(11) NOT NULL DEFAULT 0,
  `timestamp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `cpshares`
--

CREATE TABLE `cpshares` (
  `shareID` int(11) NOT NULL,
  `levelID` int(11) NOT NULL,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `dailyfeatures`
--

CREATE TABLE `dailyfeatures` (
  `feaID` int(11) NOT NULL,
  `levelID` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `webhookSent` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `events`
--

CREATE TABLE `events` (
  `feaID` int(11) NOT NULL,
  `levelID` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `duration` int(11) NOT NULL,
  `rewards` varchar(2048) NOT NULL DEFAULT '',
  `webhookSent` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `favsongs`
--

CREATE TABLE `favsongs` (
  `ID` int(20) NOT NULL,
  `songID` int(20) NOT NULL DEFAULT 0,
  `accountID` int(20) NOT NULL DEFAULT 0,
  `timestamp` int(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `follows`
--

CREATE TABLE `follows` (
  `ID` int(11) NOT NULL,
  `person1` int(11) NOT NULL DEFAULT 0,
  `person2` int(11) NOT NULL DEFAULT 0,
  `timestamp` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `friendreqs`
--

CREATE TABLE `friendreqs` (
  `accountID` int(11) NOT NULL,
  `toAccountID` int(11) NOT NULL,
  `comment` varchar(1000) NOT NULL,
  `uploadDate` int(11) NOT NULL,
  `ID` int(11) NOT NULL,
  `isNew` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `friendships`
--

CREATE TABLE `friendships` (
  `ID` int(11) NOT NULL,
  `person1` int(11) NOT NULL,
  `person2` int(11) NOT NULL,
  `isNew1` int(11) NOT NULL,
  `isNew2` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `gauntlets`
--

CREATE TABLE `gauntlets` (
  `ID` int(11) NOT NULL,
  `level1` int(11) NOT NULL,
  `level2` int(11) NOT NULL,
  `level3` int(11) NOT NULL,
  `level4` int(11) NOT NULL,
  `level5` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `levels`
--

CREATE TABLE `levels` (
  `gameVersion` int(11) NOT NULL,
  `binaryVersion` int(11) NOT NULL DEFAULT 0,
  `userName` mediumtext NOT NULL,
  `levelID` int(11) NOT NULL,
  `levelName` varchar(255) NOT NULL,
  `levelDesc` mediumtext NOT NULL,
  `levelVersion` int(11) NOT NULL,
  `levelLength` int(11) NOT NULL DEFAULT 0,
  `audioTrack` int(11) NOT NULL,
  `auto` int(11) NOT NULL,
  `password` int(11) NOT NULL,
  `original` int(11) NOT NULL,
  `twoPlayer` int(11) NOT NULL DEFAULT 0,
  `songID` int(11) NOT NULL DEFAULT 0,
  `songIDs` varchar(2048) DEFAULT '',
  `sfxIDs` varchar(2048) DEFAULT '',
  `objects` int(11) NOT NULL DEFAULT 0,
  `coins` int(11) NOT NULL DEFAULT 0,
  `requestedStars` int(11) NOT NULL DEFAULT 0,
  `extraString` mediumtext NOT NULL,
  `levelString` longtext DEFAULT NULL,
  `levelInfo` mediumtext NOT NULL,
  `secret` mediumtext NOT NULL,
  `starDifficulty` int(11) NOT NULL DEFAULT 0 COMMENT '0=N/A 10=EASY 20=NORMAL 30=HARD 40=HARDER 50=INSANE 50=AUTO 50=DEMON',
  `downloads` int(11) NOT NULL DEFAULT 300,
  `likes` int(11) NOT NULL DEFAULT 100,
  `starDemon` int(1) NOT NULL DEFAULT 0,
  `starAuto` tinyint(4) NOT NULL DEFAULT 0,
  `starStars` int(11) NOT NULL DEFAULT 0,
  `uploadDate` bigint(20) NOT NULL,
  `updateDate` bigint(20) NOT NULL,
  `rateDate` bigint(20) NOT NULL DEFAULT 0,
  `starCoins` int(11) NOT NULL DEFAULT 0,
  `starFeatured` int(11) NOT NULL DEFAULT 0,
  `starHall` int(11) NOT NULL DEFAULT 0,
  `starEpic` int(11) NOT NULL DEFAULT 0,
  `starDemonDiff` int(11) NOT NULL DEFAULT 0,
  `userID` int(11) NOT NULL,
  `extID` varchar(255) NOT NULL,
  `unlisted` int(11) NOT NULL,
  `originalReup` int(11) NOT NULL DEFAULT 0 COMMENT 'used for levelReupload.php',
  `originalServer` varchar(255) NOT NULL DEFAULT '',
  `hostname` varchar(255) NOT NULL,
  `isCPShared` int(11) NOT NULL DEFAULT 0,
  `isDeleted` int(11) NOT NULL DEFAULT 0,
  `isLDM` int(11) NOT NULL DEFAULT 0,
  `unlisted2` int(11) NOT NULL DEFAULT 0,
  `wt` int(11) NOT NULL DEFAULT 0,
  `wt2` int(11) NOT NULL DEFAULT 0,
  `ts` int(11) NOT NULL DEFAULT 0,
  `settingsString` mediumtext NOT NULL DEFAULT '',
  `updateLocked` int(11) NOT NULL DEFAULT 0,
  `commentLocked` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `levelscores`
--

CREATE TABLE `levelscores` (
  `scoreID` int(11) NOT NULL,
  `accountID` int(11) NOT NULL,
  `levelID` int(11) NOT NULL,
  `percent` int(11) NOT NULL,
  `uploadDate` int(11) NOT NULL,
  `attempts` int(11) NOT NULL DEFAULT 0,
  `coins` int(11) NOT NULL DEFAULT 0,
  `clicks` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `progresses` text NOT NULL,
  `dailyID` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `links`
--

CREATE TABLE `links` (
  `ID` int(11) NOT NULL,
  `accountID` int(11) NOT NULL,
  `targetAccountID` int(11) NOT NULL,
  `server` varchar(255) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `targetUserID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `lists`
--

CREATE TABLE `lists` (
  `listID` int(11) NOT NULL,
  `listName` varchar(2048) CHARACTER SET utf8mb3 COLLATE utf8mb3_uca1400_ai_ci NOT NULL,
  `listDesc` varchar(2048) CHARACTER SET utf8mb3 COLLATE utf8mb3_uca1400_ai_ci NOT NULL,
  `listVersion` int(11) NOT NULL DEFAULT 1,
  `accountID` int(11) NOT NULL,
  `downloads` int(11) NOT NULL DEFAULT 0,
  `starDifficulty` int(11) NOT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `starFeatured` int(11) NOT NULL DEFAULT 0,
  `starStars` int(11) NOT NULL DEFAULT 0,
  `listlevels` varchar(2048) CHARACTER SET utf8mb3 COLLATE utf8mb3_uca1400_ai_ci NOT NULL,
  `countForReward` int(11) NOT NULL DEFAULT 0,
  `uploadDate` int(11) NOT NULL DEFAULT 0,
  `updateDate` int(11) NOT NULL DEFAULT 0,
  `original` int(11) NOT NULL DEFAULT 0,
  `unlisted` int(11) NOT NULL DEFAULT 0,
  `commentLocked` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `mappacks`
--

CREATE TABLE `mappacks` (
  `ID` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `levels` varchar(512) NOT NULL COMMENT 'entered as "ID of level 1, ID of level 2, ID of level 3" for example "13,14,15" (without the "s)',
  `stars` int(11) NOT NULL,
  `coins` int(11) NOT NULL,
  `difficulty` int(11) NOT NULL,
  `rgbcolors` varchar(11) NOT NULL COMMENT 'entered as R,G,B',
  `colors2` varchar(11) NOT NULL DEFAULT 'none',
  `timestamp` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `messages`
--

CREATE TABLE `messages` (
  `userID` int(11) NOT NULL,
  `userName` varchar(50) NOT NULL,
  `body` longtext NOT NULL,
  `subject` longtext NOT NULL,
  `accID` int(11) NOT NULL,
  `messageID` int(11) NOT NULL,
  `toAccountID` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `secret` varchar(25) NOT NULL DEFAULT 'unused',
  `isNew` int(11) NOT NULL DEFAULT 0,
  `readTime` int(11) NOT NULL DEFAULT 0,
  `isThreadMessage` int(11) NOT NULL DEFAULT 0,
  `isDeleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `modactions`
--

CREATE TABLE `modactions` (
  `ID` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `value` varchar(255) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL DEFAULT 0,
  `value2` varchar(255) NOT NULL DEFAULT '0',
  `value3` int(11) NOT NULL DEFAULT 0,
  `value4` varchar(255) NOT NULL DEFAULT '0',
  `value5` int(11) NOT NULL DEFAULT 0,
  `value6` int(11) NOT NULL DEFAULT 0,
  `account` int(11) NOT NULL DEFAULT 0,
  `value7` varchar(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `modipperms`
--

CREATE TABLE `modipperms` (
  `categoryID` int(11) NOT NULL,
  `actionFreeCopy` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `modips`
--

CREATE TABLE `modips` (
  `ID` int(11) NOT NULL,
  `IP` varchar(69) NOT NULL,
  `isMod` int(11) NOT NULL,
  `accountID` int(11) NOT NULL,
  `modipCategory` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `mutes`
--

CREATE TABLE `mutes` (
  `ID` int(11) NOT NULL,
  `person1` int(11) NOT NULL DEFAULT 0,
  `person2` int(11) NOT NULL DEFAULT 0,
  `isThread` int(11) NOT NULL DEFAULT 0,
  `timestamp` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `news`
--

CREATE TABLE `news` (
  `entryID` int(11) NOT NULL,
  `entryTitle` varchar(255) NOT NULL,
  `entryTag` varchar(50) NOT NULL DEFAULT '',
  `entryDate` datetime NOT NULL DEFAULT current_timestamp(),
  `entryElements` text NOT NULL,
  `entryIcon` varchar(255) NOT NULL DEFAULT '',
  `entryAction` varchar(255) NOT NULL DEFAULT '',
  `isPinned` tinyint(1) NOT NULL DEFAULT 0,
  `isHidden` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `platscores`
--

CREATE TABLE `platscores` (
  `ID` int(11) NOT NULL,
  `accountID` int(11) NOT NULL DEFAULT 0,
  `levelID` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `points` int(11) NOT NULL DEFAULT 0,
  `timestamp` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `quests`
--

CREATE TABLE `quests` (
  `ID` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `reward` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `replies`
--

CREATE TABLE `replies` (
  `replyID` int(11) NOT NULL,
  `commentID` int(11) NOT NULL,
  `accountID` int(11) NOT NULL,
  `body` varchar(255) NOT NULL,
  `timestamp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `reports`
--

CREATE TABLE `reports` (
  `ID` int(11) NOT NULL,
  `targetID` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 1,
  `reasons` varchar(255) NOT NULL DEFAULT '0',
  `extraID` int(11) NOT NULL DEFAULT 0,
  `hostname` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `roleassign`
--

CREATE TABLE `roleassign` (
  `assignID` bigint(20) NOT NULL,
  `roleID` bigint(20) NOT NULL,
  `accountID` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `roles`
--

CREATE TABLE `roles` (
  `roleID` bigint(11) NOT NULL,
  `priority` int(11) NOT NULL DEFAULT 0,
  `roleName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_uca1400_ai_ci NOT NULL,
  `commandRate` int(11) NOT NULL DEFAULT 0,
  `commandFeature` int(11) NOT NULL DEFAULT 0,
  `commandEpic` int(11) NOT NULL DEFAULT 0,
  `commandUnepic` int(11) NOT NULL DEFAULT 0,
  `commandVerifycoins` int(11) NOT NULL DEFAULT 0,
  `commandDaily` int(11) NOT NULL DEFAULT 0,
  `commandWeekly` int(11) NOT NULL DEFAULT 0,
  `commandEvent` int(11) NOT NULL DEFAULT 0,
  `commandDelete` int(11) NOT NULL DEFAULT 0,
  `commandSetacc` int(11) NOT NULL DEFAULT 0,
  `commandRenameOwn` int(11) NOT NULL DEFAULT 1,
  `commandRenameAll` int(11) NOT NULL DEFAULT 0,
  `commandPassOwn` int(11) NOT NULL DEFAULT 1,
  `commandPassAll` int(11) NOT NULL DEFAULT 0,
  `commandDescriptionOwn` int(11) NOT NULL DEFAULT 1,
  `commandDescriptionAll` int(11) NOT NULL DEFAULT 0,
  `commandPublicOwn` int(11) NOT NULL DEFAULT 1,
  `commandPublicAll` int(11) NOT NULL DEFAULT 0,
  `commandUnlistOwn` int(11) NOT NULL DEFAULT 1,
  `commandUnlistAll` int(11) NOT NULL DEFAULT 0,
  `commandSharecpOwn` int(11) NOT NULL DEFAULT 1,
  `commandSharecpAll` int(11) NOT NULL DEFAULT 0,
  `commandSongOwn` int(11) NOT NULL DEFAULT 1,
  `commandSongAll` int(11) NOT NULL DEFAULT 0,
  `commandLockCommentsOwn` int(11) NOT NULL DEFAULT 1,
  `commandLockCommentsAll` int(11) NOT NULL DEFAULT 0,
  `commandLockUpdating` int(11) NOT NULL DEFAULT 0,
  `actionRateDemon` int(11) NOT NULL DEFAULT 0,
  `actionRateStars` int(11) NOT NULL DEFAULT 0,
  `actionRateDifficulty` int(11) NOT NULL DEFAULT 0,
  `actionRequestMod` int(11) NOT NULL DEFAULT 0,
  `actionSuggestRating` int(11) NOT NULL DEFAULT 0,
  `actionDeleteComment` int(11) NOT NULL DEFAULT 0,
  `toolLeaderboardsban` int(11) NOT NULL DEFAULT 0,
  `dashboardGauntletCreate` int(11) NOT NULL DEFAULT 0,
  `toolQuestsCreate` int(11) NOT NULL DEFAULT 0,
  `toolModactions` int(11) NOT NULL DEFAULT 0,
  `toolSuggestlist` int(11) NOT NULL DEFAULT 0,
  `gameAddMembersWithoutInvite` int(11) NOT NULL DEFAULT 0,
  `dashboardModTools` int(11) NOT NULL DEFAULT 0,
  `dashboardLevelPackCreate` int(11) NOT NULL DEFAULT 0,
  `dashboardAddMod` int(11) NOT NULL DEFAULT 0,
  `dashboardManageSongs` int(11) NOT NULL DEFAULT 0,
  `dashboardForceChangePassNick` int(11) NOT NULL DEFAULT 0,
  `dashboardDeleteLeaderboards` int(11) NOT NULL DEFAULT 0,
  `dashboardManageLevels` int(11) NOT NULL DEFAULT 0,
  `dashboardManageAutomod` int(11) NOT NULL DEFAULT 0,
  `dashboardVaultCodesManage` int(11) NOT NULL DEFAULT 0,
  `demonlistAdd` int(11) NOT NULL DEFAULT 0,
  `demonlistApprove` int(11) NOT NULL DEFAULT 0,
  `modipCategory` int(11) NOT NULL DEFAULT 0,
  `isDefault` int(11) NOT NULL DEFAULT 0,
  `commentColor` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_uca1400_ai_ci NOT NULL DEFAULT '000,000,000',
  `modBadgeLevel` int(11) NOT NULL DEFAULT 0,
  `admin2209View` int(11) NOT NULL DEFAULT 0,
  `admin2209Ban` int(11) NOT NULL DEFAULT 0,
  `admin2209Freeze` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `sfxs`
--

CREATE TABLE `sfxs` (
  `ID` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `authorName` varchar(100) NOT NULL,
  `download` varchar(255) DEFAULT '',
  `milliseconds` int(11) NOT NULL DEFAULT 0,
  `size` varchar(100) NOT NULL,
  `isDisabled` int(11) NOT NULL DEFAULT 0,
  `levelsCount` int(11) NOT NULL DEFAULT 0,
  `reuploadID` int(11) NOT NULL DEFAULT 0,
  `reuploadTime` int(11) NOT NULL DEFAULT 0,
  `token` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `songs`
--

CREATE TABLE `songs` (
  `ID` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `authorID` int(11) NOT NULL,
  `authorName` varchar(100) NOT NULL,
  `size` varchar(100) NOT NULL,
  `duration` int(11) NOT NULL DEFAULT 0,
  `download` varchar(1337) NOT NULL,
  `hash` varchar(256) NOT NULL DEFAULT '',
  `isDisabled` int(11) NOT NULL DEFAULT 0,
  `levelsCount` int(11) NOT NULL DEFAULT 0,
  `reuploadTime` int(11) NOT NULL DEFAULT 0,
  `reuploadID` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `suggest`
--

CREATE TABLE `suggest` (
  `ID` int(11) NOT NULL,
  `suggestBy` int(11) NOT NULL DEFAULT 0,
  `suggestLevelId` int(11) NOT NULL DEFAULT 0,
  `suggestDifficulty` int(11) NOT NULL DEFAULT 0 COMMENT '0 - NA 10 - Easy 20 - Normal 30 - Hard 40 - Harder 50 - Insane/Demon/Auto',
  `suggestStars` int(11) NOT NULL DEFAULT 0,
  `suggestFeatured` int(11) NOT NULL DEFAULT 0,
  `suggestAuto` int(11) NOT NULL DEFAULT 0,
  `suggestDemon` int(11) NOT NULL DEFAULT 0,
  `timestamp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `threadevents`
--

CREATE TABLE `threadevents` (
  `eventID` int(11) NOT NULL,
  `threadID` int(11) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `value` int(11) NOT NULL DEFAULT 0,
  `accountID` int(11) NOT NULL DEFAULT 0,
  `timestamp` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `threadinvites`
--

CREATE TABLE `threadinvites` (
  `inviteID` int(11) NOT NULL,
  `threadID` int(11) NOT NULL DEFAULT 0,
  `accountID` int(11) NOT NULL DEFAULT 0,
  `toAccountID` int(11) NOT NULL DEFAULT 0,
  `isIgnored` int(11) NOT NULL DEFAULT 0,
  `timestamp` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `threads`
--

CREATE TABLE `threads` (
  `threadID` int(11) NOT NULL,
  `threadName` varchar(255) NOT NULL DEFAULT '',
  `threadDesc` varchar(2048) NOT NULL DEFAULT '',
  `threadIcon` varchar(50) NOT NULL DEFAULT '',
  `threadOwner` int(11) NOT NULL DEFAULT 0,
  `threadMembers` text NOT NULL DEFAULT '',
  `invitedUsers` text NOT NULL DEFAULT '',
  `formerMembers` text NOT NULL DEFAULT '',
  `isDMThread` int(11) NOT NULL DEFAULT 0,
  `isLocked` int(11) NOT NULL DEFAULT 0,
  `isInviteLocked` int(11) NOT NULL DEFAULT 1,
  `lastMessageID` int(11) NOT NULL DEFAULT 0,
  `timestamp` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `isRegistered` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `extID` varchar(100) NOT NULL,
  `userName` varchar(69) NOT NULL DEFAULT 'undefined',
  `clan` int(11) NOT NULL DEFAULT 0,
  `joinedAt` int(11) NOT NULL DEFAULT 0,
  `dlPoints` int(11) NOT NULL DEFAULT 0,
  `stars` int(11) NOT NULL DEFAULT 0,
  `demons` int(11) NOT NULL DEFAULT 0,
  `icon` int(11) NOT NULL DEFAULT 0,
  `color1` int(11) NOT NULL DEFAULT 0,
  `color2` int(11) NOT NULL DEFAULT 3,
  `color3` int(11) NOT NULL DEFAULT 0,
  `iconType` int(11) NOT NULL DEFAULT 0,
  `coins` int(11) NOT NULL DEFAULT 0,
  `userCoins` int(11) NOT NULL DEFAULT 0,
  `special` int(11) NOT NULL DEFAULT 0,
  `gameVersion` int(11) NOT NULL DEFAULT 0,
  `secret` varchar(69) NOT NULL DEFAULT 'none',
  `accIcon` int(11) NOT NULL DEFAULT 0,
  `accShip` int(11) NOT NULL DEFAULT 0,
  `accBall` int(11) NOT NULL DEFAULT 0,
  `accBird` int(11) NOT NULL DEFAULT 0,
  `accDart` int(11) NOT NULL DEFAULT 0,
  `accRobot` int(11) DEFAULT 0,
  `accGlow` int(11) NOT NULL DEFAULT 0,
  `accSwing` int(11) NOT NULL DEFAULT 0,
  `accJetpack` int(11) NOT NULL DEFAULT 0,
  `dinfo` varchar(100) DEFAULT '',
  `sinfo` varchar(100) DEFAULT '',
  `pinfo` varchar(100) DEFAULT '',
  `creatorPoints` double NOT NULL DEFAULT 0,
  `IP` varchar(69) NOT NULL DEFAULT '127.0.0.1',
  `lastPlayed` int(11) NOT NULL DEFAULT 0,
  `diamonds` int(11) NOT NULL DEFAULT 0,
  `moons` int(11) NOT NULL DEFAULT 0,
  `orbs` int(11) NOT NULL DEFAULT 0,
  `completedLvls` int(11) NOT NULL DEFAULT 0,
  `accSpider` int(11) NOT NULL DEFAULT 0,
  `accExplosion` int(11) NOT NULL DEFAULT 0,
  `chest1time` int(11) NOT NULL DEFAULT 0,
  `chest2time` int(11) NOT NULL DEFAULT 0,
  `chest1count` int(11) NOT NULL DEFAULT 0,
  `chest2count` int(11) NOT NULL DEFAULT 0,
  `isBanned` int(11) NOT NULL DEFAULT 0,
  `isCreatorBanned` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `user_restrictions`
--

CREATE TABLE `user_restrictions` (
  `accountID` int(11) NOT NULL,
  `commentBanUntil` int(11) NOT NULL DEFAULT 0,
  `uploadBanUntil` int(11) NOT NULL DEFAULT 0,
  `messageBanUntil` int(11) NOT NULL DEFAULT 0,
  `trendingBanUntil` int(11) NOT NULL DEFAULT 0,
  `isFrozen` tinyint(1) NOT NULL DEFAULT 0,
  `isNameLocked` tinyint(1) NOT NULL DEFAULT 0,
  `reason` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `vaultcodes`
--

CREATE TABLE `vaultcodes` (
  `rewardID` int(11) NOT NULL,
  `code` varchar(255) NOT NULL DEFAULT '',
  `rewards` varchar(2048) NOT NULL DEFAULT '',
  `duration` int(11) NOT NULL DEFAULT 0,
  `uses` int(11) NOT NULL DEFAULT -1,
  `timestamp` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `acccomments`
--
ALTER TABLE `acccomments`
  ADD PRIMARY KEY (`commentID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `timestamp` (`timestamp`);

--
-- Индексы таблицы `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`accountID`),
  ADD UNIQUE KEY `userName` (`userName`),
  ADD KEY `isAdmin` (`isAdmin`),
  ADD KEY `frS` (`frS`),
  ADD KEY `discordID` (`discordID`),
  ADD KEY `discordLinkReq` (`discordLinkReq`),
  ADD KEY `friendsCount` (`friendsCount`),
  ADD KEY `isActive` (`isActive`);

--
-- Индексы таблицы `actions`
--
ALTER TABLE `actions`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `type` (`type`),
  ADD KEY `value` (`value`),
  ADD KEY `value2` (`value2`),
  ADD KEY `timestamp` (`timestamp`);

--
-- Индексы таблицы `actions_downloads`
--
ALTER TABLE `actions_downloads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `levelID` (`levelID`,`ip`,`uploadDate`) USING BTREE;

--
-- Индексы таблицы `actions_likes`
--
ALTER TABLE `actions_likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `levelID` (`itemID`,`type`,`isLike`,`ip`,`uploadDate`) USING BTREE;

--
-- Индексы таблицы `automod`
--
ALTER TABLE `automod`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `bannedips`
--
ALTER TABLE `bannedips`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`banID`);

--
-- Индексы таблицы `blocks`
--
ALTER TABLE `blocks`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID` (`ID`),
  ADD KEY `person1` (`person1`),
  ADD KEY `person2` (`person2`);

--
-- Индексы таблицы `clanrequests`
--
ALTER TABLE `clanrequests`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `clans`
--
ALTER TABLE `clans`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`commentID`),
  ADD KEY `levelID` (`levelID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `likes` (`likes`);

--
-- Индексы таблицы `content_reports`
--
ALTER TABLE `content_reports`
  ADD PRIMARY KEY (`reportID`),
  ADD KEY `status` (`status`),
  ADD KEY `targetAccountID` (`targetAccountID`);

--
-- Индексы таблицы `cpshares`
--
ALTER TABLE `cpshares`
  ADD PRIMARY KEY (`shareID`),
  ADD KEY `levelID` (`levelID`);

--
-- Индексы таблицы `dailyfeatures`
--
ALTER TABLE `dailyfeatures`
  ADD PRIMARY KEY (`feaID`),
  ADD KEY `type` (`type`),
  ADD KEY `timestamp` (`timestamp`);

--
-- Индексы таблицы `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`feaID`);

--
-- Индексы таблицы `favsongs`
--
ALTER TABLE `favsongs`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `follows`
--
ALTER TABLE `follows`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `friendreqs`
--
ALTER TABLE `friendreqs`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `toAccountID` (`toAccountID`),
  ADD KEY `accountID` (`accountID`),
  ADD KEY `uploadDate` (`uploadDate`);

--
-- Индексы таблицы `friendships`
--
ALTER TABLE `friendships`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `person1` (`person1`),
  ADD KEY `person2` (`person2`),
  ADD KEY `isNew1` (`isNew1`),
  ADD KEY `isNew2` (`isNew2`);

--
-- Индексы таблицы `gauntlets`
--
ALTER TABLE `gauntlets`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `level5` (`level5`);

--
-- Индексы таблицы `levels`
--
ALTER TABLE `levels`
  ADD PRIMARY KEY (`levelID`),
  ADD KEY `levelID` (`levelID`),
  ADD KEY `levelName` (`levelName`),
  ADD KEY `starDifficulty` (`starDifficulty`),
  ADD KEY `starFeatured` (`starFeatured`),
  ADD KEY `starEpic` (`starEpic`),
  ADD KEY `starDemonDiff` (`starDemonDiff`),
  ADD KEY `userID` (`userID`),
  ADD KEY `likes` (`likes`),
  ADD KEY `downloads` (`downloads`),
  ADD KEY `starStars` (`starStars`),
  ADD KEY `songID` (`songID`),
  ADD KEY `audioTrack` (`audioTrack`),
  ADD KEY `levelLength` (`levelLength`),
  ADD KEY `twoPlayer` (`twoPlayer`),
  ADD KEY `starDemon` (`starDemon`),
  ADD KEY `starAuto` (`starAuto`),
  ADD KEY `extID` (`extID`),
  ADD KEY `uploadDate` (`uploadDate`),
  ADD KEY `updateDate` (`updateDate`),
  ADD KEY `starCoins` (`starCoins`),
  ADD KEY `coins` (`coins`),
  ADD KEY `password` (`password`),
  ADD KEY `originalReup` (`originalReup`),
  ADD KEY `original` (`original`),
  ADD KEY `unlisted` (`unlisted`),
  ADD KEY `isCPShared` (`isCPShared`),
  ADD KEY `gameVersion` (`gameVersion`),
  ADD KEY `rateDate` (`rateDate`),
  ADD KEY `objects` (`objects`),
  ADD KEY `unlisted2` (`unlisted2`);

--
-- Индексы таблицы `levelscores`
--
ALTER TABLE `levelscores`
  ADD PRIMARY KEY (`scoreID`),
  ADD KEY `levelID` (`levelID`),
  ADD KEY `accountID` (`accountID`);

--
-- Индексы таблицы `links`
--
ALTER TABLE `links`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `targetUserID` (`targetUserID`),
  ADD KEY `targetAccountID` (`targetAccountID`),
  ADD KEY `server` (`server`);

--
-- Индексы таблицы `lists`
--
ALTER TABLE `lists`
  ADD PRIMARY KEY (`listID`);

--
-- Индексы таблицы `mappacks`
--
ALTER TABLE `mappacks`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`messageID`),
  ADD KEY `toAccountID` (`toAccountID`),
  ADD KEY `accID` (`accID`);

--
-- Индексы таблицы `modactions`
--
ALTER TABLE `modactions`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `account` (`account`),
  ADD KEY `type` (`type`),
  ADD KEY `value3` (`value3`);

--
-- Индексы таблицы `modipperms`
--
ALTER TABLE `modipperms`
  ADD PRIMARY KEY (`categoryID`);

--
-- Индексы таблицы `modips`
--
ALTER TABLE `modips`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `accountID` (`accountID`),
  ADD KEY `IP` (`IP`);

--
-- Индексы таблицы `mutes`
--
ALTER TABLE `mutes`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`entryID`),
  ADD KEY `idx_pinned_date` (`isPinned`,`entryDate`);

--
-- Индексы таблицы `platscores`
--
ALTER TABLE `platscores`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `quests`
--
ALTER TABLE `quests`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `replies`
--
ALTER TABLE `replies`
  ADD PRIMARY KEY (`replyID`);

--
-- Индексы таблицы `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `levelID` (`targetID`),
  ADD KEY `hostname` (`hostname`);

--
-- Индексы таблицы `roleassign`
--
ALTER TABLE `roleassign`
  ADD PRIMARY KEY (`assignID`),
  ADD KEY `roleID` (`roleID`),
  ADD KEY `accountID` (`accountID`);

--
-- Индексы таблицы `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`roleID`),
  ADD KEY `priority` (`priority`),
  ADD KEY `toolModactions` (`toolModactions`);

--
-- Индексы таблицы `sfxs`
--
ALTER TABLE `sfxs`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `name` (`name`),
  ADD KEY `authorName` (`authorName`);

--
-- Индексы таблицы `songs`
--
ALTER TABLE `songs`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `name` (`name`),
  ADD KEY `authorName` (`authorName`);

--
-- Индексы таблицы `suggest`
--
ALTER TABLE `suggest`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `timestamp` (`timestamp`);

--
-- Индексы таблицы `threadevents`
--
ALTER TABLE `threadevents`
  ADD PRIMARY KEY (`eventID`);

--
-- Индексы таблицы `threadinvites`
--
ALTER TABLE `threadinvites`
  ADD PRIMARY KEY (`inviteID`);

--
-- Индексы таблицы `threads`
--
ALTER TABLE `threads`
  ADD PRIMARY KEY (`threadID`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `userName` (`userName`),
  ADD KEY `stars` (`stars`),
  ADD KEY `demons` (`demons`),
  ADD KEY `coins` (`coins`),
  ADD KEY `userCoins` (`userCoins`),
  ADD KEY `gameVersion` (`gameVersion`),
  ADD KEY `creatorPoints` (`creatorPoints`),
  ADD KEY `diamonds` (`diamonds`),
  ADD KEY `orbs` (`orbs`),
  ADD KEY `completedLvls` (`completedLvls`),
  ADD KEY `isBanned` (`isBanned`),
  ADD KEY `isCreatorBanned` (`isCreatorBanned`),
  ADD KEY `extID` (`extID`),
  ADD KEY `IP` (`IP`),
  ADD KEY `isRegistered` (`isRegistered`);

--
-- Индексы таблицы `user_restrictions`
--
ALTER TABLE `user_restrictions`
  ADD PRIMARY KEY (`accountID`);

--
-- Индексы таблицы `vaultcodes`
--
ALTER TABLE `vaultcodes`
  ADD PRIMARY KEY (`rewardID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `acccomments`
--
ALTER TABLE `acccomments`
  MODIFY `commentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `accounts`
--
ALTER TABLE `accounts`
  MODIFY `accountID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `actions`
--
ALTER TABLE `actions`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `actions_downloads`
--
ALTER TABLE `actions_downloads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `actions_likes`
--
ALTER TABLE `actions_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `automod`
--
ALTER TABLE `automod`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `bannedips`
--
ALTER TABLE `bannedips`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `bans`
--
ALTER TABLE `bans`
  MODIFY `banID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `blocks`
--
ALTER TABLE `blocks`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `clanrequests`
--
ALTER TABLE `clanrequests`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `clans`
--
ALTER TABLE `clans`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `comments`
--
ALTER TABLE `comments`
  MODIFY `commentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `content_reports`
--
ALTER TABLE `content_reports`
  MODIFY `reportID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `cpshares`
--
ALTER TABLE `cpshares`
  MODIFY `shareID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `dailyfeatures`
--
ALTER TABLE `dailyfeatures`
  MODIFY `feaID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `events`
--
ALTER TABLE `events`
  MODIFY `feaID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `favsongs`
--
ALTER TABLE `favsongs`
  MODIFY `ID` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `follows`
--
ALTER TABLE `follows`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `friendreqs`
--
ALTER TABLE `friendreqs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `friendships`
--
ALTER TABLE `friendships`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `gauntlets`
--
ALTER TABLE `gauntlets`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `levels`
--
ALTER TABLE `levels`
  MODIFY `levelID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `levelscores`
--
ALTER TABLE `levelscores`
  MODIFY `scoreID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `links`
--
ALTER TABLE `links`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `lists`
--
ALTER TABLE `lists`
  MODIFY `listID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `mappacks`
--
ALTER TABLE `mappacks`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `messages`
--
ALTER TABLE `messages`
  MODIFY `messageID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `modactions`
--
ALTER TABLE `modactions`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `modipperms`
--
ALTER TABLE `modipperms`
  MODIFY `categoryID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `modips`
--
ALTER TABLE `modips`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `mutes`
--
ALTER TABLE `mutes`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `news`
--
ALTER TABLE `news`
  MODIFY `entryID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `platscores`
--
ALTER TABLE `platscores`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `quests`
--
ALTER TABLE `quests`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `replies`
--
ALTER TABLE `replies`
  MODIFY `replyID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `reports`
--
ALTER TABLE `reports`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `roleassign`
--
ALTER TABLE `roleassign`
  MODIFY `assignID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `roles`
--
ALTER TABLE `roles`
  MODIFY `roleID` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `sfxs`
--
ALTER TABLE `sfxs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `songs`
--
ALTER TABLE `songs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `suggest`
--
ALTER TABLE `suggest`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `threadevents`
--
ALTER TABLE `threadevents`
  MODIFY `eventID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `threadinvites`
--
ALTER TABLE `threadinvites`
  MODIFY `inviteID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `threads`
--
ALTER TABLE `threads`
  MODIFY `threadID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `vaultcodes`
--
ALTER TABLE `vaultcodes`
  MODIFY `rewardID` int(11) NOT NULL AUTO_INCREMENT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
