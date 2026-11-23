<?php
include "incl/lib/connection.php";
require_once "incl/lib/mainLib.php";
require_once "incl/lib/admin2209.php";
$gs = new mainLib();
$modID = Admin2209::authMod($db, $gs, "actionDeleteComment");

$idsRaw = ExploitPatch::remove($_POST["commentIDs"] ?? "");
$ids = array_filter(array_map('intval', explode(',', $idsRaw)));
if (empty($ids)) exit("-1");

$placeholders = implode(',', array_fill(0, count($ids), '?'));
$stmt = $db->prepare("DELETE FROM comments WHERE commentID IN ($placeholders)");
$stmt->execute($ids);

$db->prepare("INSERT INTO modactions (type, value, timestamp, value2, value3, account) VALUES (26, 'bulkDeleteComments', :ts, :ids, :cnt, :mod)")
   ->execute([':ts' => time(), ':ids' => substr($idsRaw, 0, 250), ':cnt' => count($ids), ':mod' => $modID]);

echo "1";
