<?php
include "incl/lib/connection.php";
require_once "incl/lib/mainLib.php";
require_once "incl/lib/admin2209.php";
$gs = new mainLib();
$modID = Admin2209::authMod($db, $gs, "admin2209Ban");

$threadID = (int)ExploitPatch::number($_POST["threadID"] ?? 0);
$action = (int)ExploitPatch::number($_POST["actionType"] ?? 1);

if ($threadID <= 0) exit("-1");

if ($action === 1) {
    $db->prepare("DELETE FROM threads WHERE threadID = :tid")->execute([':tid' => $threadID]);
    $db->prepare("DELETE FROM thread_messages WHERE threadID = :tid")->execute([':tid' => $threadID]);
    $db->prepare("DELETE FROM thread_members WHERE threadID = :tid")->execute([':tid' => $threadID]);
} elseif ($action === 2) {
    $db->prepare("UPDATE threads SET isPrivate = 2 WHERE threadID = :tid")->execute([':tid' => $threadID]);
}

$db->prepare("INSERT INTO modactions (type, value, timestamp, value2, value3, account) VALUES (27, 'threadAction', :ts, :tid, :act, :mod)")
   ->execute([':ts' => time(), ':tid' => (string)$threadID, ':act' => $action, ':mod' => $modID]);

echo "1";
