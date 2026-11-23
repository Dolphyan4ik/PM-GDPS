<?php
include "incl/lib/connection.php";
require_once "incl/lib/mainLib.php";
require_once "incl/lib/admin2209.php";
$gs = new mainLib();
Admin2209::authMod($db, $gs, "admin2209View");

$targetID = isset($_POST["targetAccountID"]) ? (int)$_POST["targetAccountID"] : 0;
$page = isset($_POST["page"]) ? max(0, (int)$_POST["page"]) : 0;
$offset = $page * 20;

$cntSt = $db->prepare("SELECT COUNT(*) FROM modactions WHERE value2 = :target");
$cntSt->execute(array(':target' => (string)$targetID));
$total = (int)$cntSt->fetchColumn();

if ($total === 0) {
    exit("#0:0:20");
}

$stmt = $db->prepare("
    SELECT m.*, a.userName AS modName
    FROM modactions m
    LEFT JOIN accounts a ON a.accountID = m.account
    WHERE m.value2 = :target
    ORDER BY m.timestamp DESC
    LIMIT $offset, 20
");
$stmt->execute(array(':target' => (string)$targetID));
$logs = $stmt->fetchAll(PDO::FETCH_ASSOC);

$out = array();
foreach ($logs as $row) {
    $mins = max(1, (int)round($row['value3'] / 60));
    $modName = $row['modName'] ? $row['modName'] : "Mod";
    $out[] = implode(":", array(
        $row['value'],
        "temp",
        $mins,
        0,
        base64_encode($row['value4']),
        base64_encode($modName),
        (int)$row['timestamp'],
        1,
        ""
    ));
}

echo implode("|", $out) . "#{$total}:{$offset}:20";