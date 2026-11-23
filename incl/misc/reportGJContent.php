<?php
include "incl/lib/connection.php";
require_once "incl/lib/mainLib.php";
require_once "incl/lib/exploitPatch.php";
require_once "incl/lib/admin2209.php";
$gs = new mainLib();

Admin2209::debugLog("REPORT_IN", $_POST);

$reporterID = isset($_POST["accountID"]) ? (int)$_POST["accountID"] : 0;
$gjp2 = isset($_POST["gjp2"]) ? ExploitPatch::remove($_POST["gjp2"]) : "";
$secret = isset($_POST["secret"]) ? $_POST["secret"] : "";

if ($secret !== "Wmfd2893gb7" || $reporterID <= 0 || empty($gjp2)) exit("-1");

$st = $db->prepare("SELECT gjp2 FROM accounts WHERE accountID = :acc LIMIT 1");
$st->execute([':acc' => $reporterID]);
$hash = $st->fetchColumn();
if (!$hash || (!password_verify($gjp2, $hash) && !hash_equals((string)$hash, (string)$gjp2))) {
    exit("-1");
}

$targetID = isset($_POST["targetID"]) ? (int)$_POST["targetID"] : 0;
$ctype = isset($_POST["type"]) ? (int)$_POST["type"] : 0;
$cid = isset($_POST["special"]) ? (int)$_POST["special"] : 0;
$reasonCode = isset($_POST["reasons"]) ? ExploitPatch::remove($_POST["reasons"]) : "0";

if ($targetID <= 0) exit("-1");

$targetAccountID = 0;

switch ($ctype) {
    case 0: // Профиль
        $cid = $targetID;
        $targetAccountID = $targetID;
        break;
    case 1: // Уровень (в 2.209 клиент шлёт type=1 для уровней)
        $cid = $targetID;
        $q = $db->prepare("SELECT extID FROM levels WHERE levelID = :id LIMIT 1");
        $q->execute([':id' => $targetID]);
        $extID = $q->fetchColumn();
        if (is_numeric($extID)) $targetAccountID = (int)$extID;
        break;
    case 2: // Комментарий к уровню
        $cid = $targetID;
        $q = $db->prepare("SELECT u.extID FROM comments c JOIN users u ON c.userID = u.userID WHERE c.commentID = :id LIMIT 1");
        $q->execute([':id' => $targetID]);
        $extID = $q->fetchColumn();
        if (is_numeric($extID)) $targetAccountID = (int)$extID;
        break;
    case 3: // Пост в профиле
        $cid = $targetID;
        $q = $db->prepare("SELECT u.extID FROM acccomments c JOIN users u ON c.userID = u.userID WHERE c.commentID = :id LIMIT 1");
        $q->execute([':id' => $targetID]);
        $extID = $q->fetchColumn();
        if (is_numeric($extID)) $targetAccountID = (int)$extID;
        break;
}

if ($targetAccountID <= 0) exit("-1");

$reasonWeights = [
    1 => 10,
    2 => 50,
    3 => 25,
    4 => 15,
    0 => 5
];

$pts = 0;
foreach (explode(",", $reasonCode) as $r) {
    $rInt = (int)trim($r);
    $pts += $reasonWeights[$rInt] ?? 5;
}

try {
    $db->query("SELECT pts FROM content_reports LIMIT 1");
} catch (Exception $e) {
    $db->exec("ALTER TABLE content_reports ADD pts INT(11) NOT NULL DEFAULT 0 AFTER reason");
}

$dup = $db->prepare("SELECT reportID FROM content_reports WHERE reporterAccountID = :rep AND contentType = :ctype AND contentID = :cid AND status = 0 LIMIT 1");
$dup->execute([':rep' => $reporterID, ':ctype' => $ctype, ':cid' => $cid]);

if (!$dup->fetch()) {
    $ins = $db->prepare("INSERT INTO content_reports (reporterAccountID, targetAccountID, contentType, contentID, reason, pts, status, timestamp)
                         VALUES (:rep, :target, :ctype, :cid, :reason, :pts, 0, :ts)");
    $ins->execute([
        ':rep' => $reporterID,
        ':target' => $targetAccountID,
        ':ctype' => $ctype,
        ':cid' => $cid,
        ':reason' => "Reason #" . $reasonCode,
        ':pts' => $pts,
        ':ts' => time()
    ]);
}

echo "1";