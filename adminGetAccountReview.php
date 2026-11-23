<?php
include "incl/lib/connection.php";
require_once "incl/lib/mainLib.php";
require_once "incl/lib/admin2209.php";
$gs = new mainLib();
Admin2209::authMod($db, $gs, "admin2209View");

$targetID = isset($_POST["targetAccountID"]) ? (int)$_POST["targetAccountID"] : 0;

$aSt = $db->prepare("SELECT userName, registerDate FROM accounts WHERE accountID = :acc LIMIT 1");
$aSt->execute(array(':acc' => $targetID));
$acc = $aSt->fetch(PDO::FETCH_ASSOC);

$regDate = ($acc && (int)$acc['registerDate'] > 0) ? (int)$acc['registerDate'] : 0;
if ($regDate === 0) {
    $lvlSt = $db->prepare("SELECT MIN(uploadDate) FROM levels WHERE extID = :acc AND uploadDate > 0");
    $lvlSt->execute(array(':acc' => (string)$targetID));
    $firstLvlDate = (int)$lvlSt->fetchColumn();
    $regDate = ($firstLvlDate > 0) ? $firstLvlDate : time();
}

$repSt = $db->prepare("
    SELECT 
        COUNT(*) as totalReports,
        COALESCE(SUM(pts), 0) as totalPts,
        COUNT(DISTINCT reporterAccountID) as uniqueReporters,
        MIN(timestamp) as firstReportTs
    FROM content_reports 
    WHERE targetAccountID = :acc AND status = 0
");
$repSt->execute(array(':acc' => $targetID));
$repStats = $repSt->fetch(PDO::FETCH_ASSOC);

$totalReports = (int)$repStats['totalReports'];
$totalPts = (int)$repStats['totalPts'];
$uniqueReporters = (int)$repStats['uniqueReporters'];
$sinceAgo = ((int)$repStats['firstReportTs'] > 0) ? $gs->makeTime((int)$repStats['firstReportTs']) : "0m";

$rSt = $db->prepare("SELECT * FROM user_restrictions WHERE accountID = :acc LIMIT 1");
$rSt->execute(array(':acc' => $targetID));
$r = $rSt->fetch(PDO::FETCH_ASSOC);

$noteKey = -100000000 - $targetID;
$nSt = $db->prepare("SELECT COUNT(*) FROM comments WHERE levelID = :nk");
$nSt->execute(array(':nk' => $noteKey));
$notesCount = (int)$nSt->fetchColumn();

$now = time();
$cBan = ($r && (int)$r['commentBanUntil'] > $now) ? ((int)$r['commentBanUntil'] - $now) : 0;
$uBan = ($r && (int)$r['uploadBanUntil'] > $now) ? ((int)$r['uploadBanUntil'] - $now) : 0;
$mBan = ($r && (int)$r['messageBanUntil'] > $now) ? ((int)$r['messageBanUntil'] - $now) : 0;
$tBan = ($r && (int)$r['trendingBanUntil'] > $now) ? 1 : 0;
$qMute = ($r && (int)$r['isNameLocked'] > 0) ? 1 : 0;

$fields = array(
    0,                // 0: 0 = открытый CASE (убирает Reviewed 0 ago: Nothing Needed!)
    $regDate,         // 1: Joined
    $totalReports,    // 2: REPORTED X
    0,                // 3: FILTER X
    $totalPts,        // 4: score X
    $uniqueReporters, // 5: 1 reporter (вместо 0 reporters!)
    0,                // 6: unk
    0,                // 7: anonymous
    0,                // 8: unk
    $totalReports,    // 9: reported directly
    0,                // 10: unk
    0,                // 11: top reason
    $sinceAgo,        // 12: since X ago
    0,                // 13: unk
    $cBan,            // 14: commentBan
    $uBan,            // 15: uploadBan
    $mBan,            // 16: messageBan
    0,                // 17: blockedUsersCount
    $notesCount,      // 18: NOTES X
    0,                // 19: lastViewerID (0 = убирает Last action: 0 0 ago!)
    "",               // 20: lastViewerName
    $tBan,            // 21: trendingBan
    $qMute,           // 22: queueMute
    0, 0, 0, 0, 0, 0, 0, 0, 0
);

echo implode(":", $fields) . "###";