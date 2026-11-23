<?php
chdir(dirname(__FILE__));
require "../lib/connection.php";
require_once "../lib/GJPCheck.php";
require_once "../lib/exploitPatch.php";
require_once "../lib/mainLib.php";
require_once "../lib/commands.php";
require_once "../lib/automod.php";
require_once "../../config/misc.php";
$gs = new mainLib();
if(Automod::isAccountsDisabled(1)) exit(($_POST['gameVersion'] > 20 ? 'temp_0_Account posting is currently disabled!' : '-1'));
$userName = isset($_POST["userName"]) ? ExploitPatch::remove($_POST["userName"]) : "";
$comment = isset($_POST["comment"]) ? ExploitPatch::remove($_POST["comment"]) : "";
$gameVersion = isset($_POST["gameVersion"]) ? (int)$_POST["gameVersion"] : 0;
$commentLength = ($gameVersion >= 20) ? mb_strlen(ExploitPatch::url_base64_decode($comment)) : mb_strlen($comment);
if($enableCommentLengthLimiter && $commentLength > $maxAccountCommentLength) exit("temp_0_You cannot post account comments above $maxAccountCommentLength characters! (Your's ".$commentLength.")");
$accountID = GJPCheck::getAccountIDOrDie();

// Поддержка модераторских заметок 2.209 (кнопка NOTES в окне Review)
$targetAccountID = isset($_POST["targetAccountID"]) ? (int)$_POST["targetAccountID"] : 0;
$isModNote = ($targetAccountID > 0 && $targetAccountID != $accountID);

if ($isModNote) {
	// Проверяем права модератора/админа
	$st = $db->prepare("SELECT isAdmin FROM accounts WHERE accountID = :acc");
	$st->execute([':acc' => $accountID]);
	if ((int)$st->fetchColumn() !== 1 && !$gs->checkPermission($accountID, "dashboardModTools")) {
		exit("-1");
	}
	$targetUserID = $gs->getUserID($targetAccountID);
	if ($targetUserID <= 0 || $comment == "") exit("-1");

	// Берём ник модератора, чтобы в списке заметок было видно, кто оставил заметку
	$modName = $gs->getAccountName($accountID);
	$query = $db->prepare("INSERT INTO acccomments (userName, comment, userID, timeStamp, isSpam) VALUES (:userName, :comment, :userID, :uploadDate, 2)");
	$query->execute([':userName' => $modName, ':comment' => $comment, ':userID' => $targetUserID, ':uploadDate' => time()]);
	echo 1;
	exit();
}

$userID = $gs->getUserID($accountID, $userName);
$uploadDate = time();
//usercheck
if($accountID != "" AND $comment != "") {
	$decodecomment = ExploitPatch::url_base64_decode($comment);
	if(Commands::doProfileCommands($accountID, $decodecomment)) exit("-1");
	$checkCommentBan = $gs->getPersonBan($accountID, $userID, 3);
	if($checkCommentBan) {
		if($_POST['gameVersion'] < 21) exit('-10');
		
		$returnText = ExploitPatch::gd_escape(ExploitPatch::url_base64_decode($checkCommentBan['reason']));
		if($_POST['binaryVersion'] < 51) $returnText = ExploitPatch::translit($returnText);
		
		exit("temp_".($checkCommentBan['expires'] - time())."_".$returnText);
	}
	$query = $db->prepare("INSERT INTO acccomments (userName, comment, userID, timeStamp) VALUES (:userName, :comment, :userID, :uploadDate)");
	$query->execute([':userName' => $userName, ':comment' => $comment, ':userID' => $userID, ':uploadDate' => $uploadDate]);
	Automod::checkAccountPostsSpamming($userID);
	$gs->logAction($accountID, 14, $userName, $comment, $db->lastInsertId());
	echo 1;
} else echo -1;