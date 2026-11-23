<?php
include "incl/lib/connection.php";
require_once "incl/lib/mainLib.php";
require_once "incl/lib/admin2209.php";
$gs = new mainLib();
Admin2209::authMod($db, $gs, "admin2209View");

$targetID = isset($_POST["targetAccountID"]) ? (int)$_POST["targetAccountID"] : 0;
$ctype = isset($_POST["ctype"]) ? (int)$_POST["ctype"] : 0;
$page = isset($_POST["page"]) ? max(0, (int)$_POST["page"]) : 0;
$offset = $page * 20;

$where = "WHERE targetAccountID = :target AND status = 0";
$params = array(':target' => $targetID);
if ($ctype > 0) {
    $where .= " AND contentType = :ctype";
    $params[':ctype'] = $ctype;
}

$cntSt = $db->prepare("SELECT COUNT(*) FROM content_reports $where");
$cntSt->execute($params);
$total = (int)$cntSt->fetchColumn();

if ($total === 0) exit("###0:0:20");

$uSt = $db->prepare("SELECT userID, userName FROM users WHERE extID = :acc LIMIT 1");
$uSt->execute(array(':acc' => (string)$targetID));
$u = $uSt->fetch(PDO::FETCH_ASSOC);
$uid = $u ? (int)$u['userID'] : 0;
$uname = $u ? $u['userName'] : "Unknown";

$st = $db->prepare("SELECT * FROM content_reports $where ORDER BY timestamp DESC LIMIT $offset, 20");
$st->execute($params);
$rows = $st->fetchAll(PDO::FETCH_ASSOC);

$items = array();
$levelsData = array();

foreach ($rows as $r) {
    $type = (int)$r['contentType'];
    $cid = (int)$r['contentID'];
    $pts = (int)$r['pts'];
    $contentText = "Profile: " . $uname;

    if ($type === 1) {
        $q = $db->prepare("SELECT * FROM levels WHERE levelID = :id LIMIT 1");
        $q->execute([':id' => $cid]);
        $lvl = $q->fetch(PDO::FETCH_ASSOC);
        if ($lvl) {
            $contentText = $lvl['levelName'];
            $desc = !empty($lvl['levelDesc']) ? $lvl['levelDesc'] : "IA==";
            $levelsData[] = "1:{$lvl['levelID']}:2:{$lvl['levelName']}:3:{$desc}:5:{$lvl['levelVersion']}:6:{$lvl['userID']}:8:0:9:{$lvl['starDifficulty']}:10:{$lvl['downloads']}:12:{$lvl['audioTrack']}:13:{$lvl['gameVersion']}:14:{$lvl['likes']}:17:{$lvl['starDemon']}:18:{$lvl['starStars']}:19:{$lvl['starFeatured']}:25:{$lvl['starAuto']}:30:{$lvl['original']}:31:{$lvl['twoPlayer']}:35:{$lvl['songID']}:37:{$lvl['coins']}:38:{$lvl['starCoins']}:39:{$lvl['requestedStars']}:42:{$lvl['starEpic']}:43:{$lvl['starDemonDiff']}:45:{$lvl['objects']}:46:1:47:2";
        } else {
            $contentText = "Level #{$cid}";
        }
    } elseif ($type === 2) {
        $q = $db->prepare("SELECT comment FROM comments WHERE commentID = :id LIMIT 1");
        $q->execute([':id' => $cid]);
        $cmt = $q->fetchColumn();
        if ($cmt) $contentText = base64_decode($cmt);
    } elseif ($type === 3) {
        $q = $db->prepare("SELECT comment FROM acccomments WHERE commentID = :id LIMIT 1");
        $q->execute([':id' => $cid]);
        $cmt = $q->fetchColumn();
        if ($cmt) $contentText = base64_decode($cmt);
    }

    $ago = $gs->makeTime((int)$r['timestamp']);

    if ($type === 0) {
        $items[] = implode(":", array(
            1, 0,
            2, 1,
            3, 0,
            4, 0,
            5, 1,
            6, base64_encode($contentText),
            7, $ago,
            8, 1,
            9, 1
        ));
    } else {
        $items[] = implode(":", array(
            1, $type,
            2, $cid,
            3, 0,
            4, 1,
            5, $targetID,
            6, base64_encode($contentText),
            7, $ago,
            8, $pts
        ));
    }
}

$levelsStr = implode("|", $levelsData);
$authors = "{$uid}:{$uname}:{$targetID}";
$resp = implode("|", $items) . "#{$levelsStr}#{$authors}#{$total}:{$offset}:20";
echo $resp;