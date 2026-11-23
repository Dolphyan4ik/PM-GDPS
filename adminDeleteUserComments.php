<?php
include "incl/lib/connection.php";
require_once "incl/lib/mainLib.php";
require_once "incl/lib/admin2209.php";
$gs = new mainLib();
$modID = Admin2209::authMod($db, $gs, "actionDeleteComment");

$targetID = (int)ExploitPatch::number($_POST["targetAccountID"] ?? 0);
$userID = $gs->getUserID($targetID);
if ($userID <= 0) exit("-1");

$db->prepare("DELETE FROM comments WHERE userID = :uid")->execute([':uid' => $userID]);
$db->prepare("DELETE FROM acccomments WHERE userID = :uid")->execute([':uid' => $userID]);

$db->prepare("INSERT INTO modactions (type, value, timestamp, value2, account) VALUES (26, 'deleteAllUserComments', :ts, :target, :mod)")
   ->execute([':ts' => time(), ':target' => (string)$targetID, ':mod' => $modID]);

echo "1";
