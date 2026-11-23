<?php
include "incl/lib/connection.php";
require_once "incl/lib/mainLib.php";
require_once "incl/lib/admin2209.php";
$gs = new mainLib();
$modID = Admin2209::authMod($db, $gs, "admin2209Ban");

$targetID = isset($_POST["targetAccountID"]) ? (int)$_POST["targetAccountID"] : 0;
$outcome = isset($_POST["outcome"]) ? (int)$_POST["outcome"] : 0;

$db->prepare("UPDATE content_reports SET status = 1, closedBy = :mod WHERE targetAccountID = :tid AND status = 0")
   ->execute(array(':mod' => $modID, ':tid' => $targetID));

$db->prepare("INSERT INTO modactions (type, value, timestamp, value2, value3, account) VALUES (28, 'closeCase', :ts, :tid, :out, :mod)")
   ->execute(array(':ts' => time(), ':tid' => (string)$targetID, ':out' => $outcome, ':mod' => $modID));

echo "1";
