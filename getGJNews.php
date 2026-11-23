<?php
chdir(dirname(__FILE__));
include "../lib/connection.php";
require_once "../lib/exploitPatch.php";
require_once "../lib/mainLib.php";
$gs = new mainLib();

$page = isset($_POST["page"]) ? ExploitPatch::number($_POST["page"]) : 0;
$limit = 10;
$offset = $page * $limit;

// Получаем общее количество новостей для пагинации
$countQuery = $db->prepare("SELECT COUNT(*) FROM news");
$countQuery->execute();
$total = (int)$countQuery->fetchColumn();

if ($total === 0) {
    exit("-1");
}

// Выбираем новости от свежих к старым
$query = $db->prepare("
    SELECT entryID, entryTitle, UNIX_TIMESTAMP(entryDate) AS timestamp, entryElements 
    FROM news 
    ORDER BY entryDate DESC, entryID DESC 
    LIMIT :limit OFFSET :offset
");
$query->bindValue(':limit', $limit, PDO::PARAM_INT);
$query->bindValue(':offset', $offset, PDO::PARAM_INT);
$query->execute();
$rows = $query->fetchAll(PDO::FETCH_ASSOC);

$entries = [];
foreach ($rows as $row) {
    $timeStr = $gs->makeTime($row['timestamp']);
    
    // Очищаем символы-разделители протокола в заголовке, чтобы не сломать парсер клиента
    $title = str_replace([':', '|', '#', '~'], '', $row['entryTitle']);
    
    // Формат записи: 1:entryID:2:entryTitle:3:entryDate:4:entryElements
    $entries[] = implode(":", [
        1, $row['entryID'],
        2, $title,
        3, $timeStr,
        4, $row['entryElements']
    ]);
}

// Формат ответа: запись1|запись2#всего:смещение:лимит
echo implode("|", $entries) . "#" . $total . ":" . $offset . ":" . $limit;
?>