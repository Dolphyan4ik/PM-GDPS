<?php
include "incl/lib/connection.php";
require_once "incl/lib/mainLib.php";
require_once "incl/lib/admin2209.php";
$gs = new mainLib();
Admin2209::authMod($db, $gs, "admin2209View");

$page = isset($_POST["page"]) ? max(0, (int)$_POST["page"]) : 0;
$sort = isset($_POST["sort"]) ? (int)$_POST["sort"] : 0;
$offset = $page * 20;

$total = (int)$db->query("SELECT COUNT(DISTINCT targetAccountID) FROM content_reports WHERE status = 0")->fetchColumn();
if ($total === 0) exit("#0:0:20");

$orderBy = ($sort === 1) ? "lastTs DESC" : "totalPts DESC, lastTs DESC";

$st = $db->query("
    SELECT 
        r.targetAccountID, 
        COUNT(*) as cnt, 
        COALESCE(SUM(r.pts), 0) as totalPts, 
        MAX(r.timestamp) as lastTs, 
        a.userName
    FROM content_reports r
    LEFT JOIN accounts a ON a.accountID = r.targetAccountID
    WHERE r.status = 0
    GROUP BY r.targetAccountID
    ORDER BY $orderBy
    LIMIT $offset, 20
");
$rows = $st->fetchAll(PDO::FETCH_ASSOC);

$out = array();
foreach ($rows as $row) {
    $name = $row['userName'] ? $row['userName'] : "Unknown";
    $pts = (int)$row['totalPts'];
    if ($pts === 0) $pts = (int)$row['cnt'] * 10;
    $ago = $gs->makeTime((int)$row['lastTs']);

    // Ровно 15 полей: FLAGGED отключён, проверяем слот 3 на правый верхний PTS
    $out[] = implode(":", array(
        (int)$row['targetAccountID'], // 0: accountID
        base64_encode($name),         // 1: userName
        (int)$row['cnt'],             // 2: items
        $pts,                         // 3: проверяем, сюда ли клиент смотрит для правого PTS
        0,                            // 4: anonymous
        0,                            // 5: top reason
        0,                            // 6: unk
        $ago,                         // 7: time ago
        (int)$row['cnt'],             // 8: reported directly
        0,                            // 9: viewed by
        0,                            // 10: unk
        0,                            // 11: viewed ago
        $pts,                         // 12: score X
        0,                            // 13: unk
        0                             // 14: unk
    ));
}

$resp = implode("|", $out) . "#{$total}:{$offset}:20";
echo $resp;