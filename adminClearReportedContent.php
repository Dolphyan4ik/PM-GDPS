<?php
include "incl/lib/connection.php";
require_once "incl/lib/mainLib.php";
require_once "incl/lib/admin2209.php";
$gs = new mainLib();
Admin2209::authMod($db, $gs, "admin2209View");

$type = (int)ExploitPatch::number($_POST["contentType"] ?? 0);
$cid = (int)ExploitPatch::number($_POST["contentID"] ?? 0);

if ($type === 1) {
    $st = $db->prepare("SELECT comment, userID, timestamp FROM comments WHERE commentID = :id");
} elseif ($type === 3) {
    $st = $db->prepare("SELECT body AS comment, accountID AS userID, timestamp FROM thread_messages WHERE messageID = :id");
} else {
    exit("-1");
}

$st->execute([':id' => $cid]);
$item = $st->fetch(PDO::FETCH_ASSOC);
if (!$item) exit("-2");

echo "1:{$cid}~2:{$item['userID']}~3:{$item['comment']}~4:{$item['timestamp']}";
