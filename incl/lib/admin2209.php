<?php
class Admin2209 {
    public static function authMod($db, $gs, $perm = "admin2209View") {
        require_once dirname(__FILE__) . "/exploitPatch.php";

        $accountID = isset($_POST["accountID"]) ? (int)$_POST["accountID"] : 0;
        $gjp2 = isset($_POST["gjp2"]) ? ExploitPatch::remove($_POST["gjp2"]) : "";
        $secret = isset($_POST["secret"]) ? $_POST["secret"] : "";

        if (!in_array($secret, array("Wmfd2893gb7", "Wmfp3879gc3", "Wmfx2878gb9"))) {
            exit("-1");
        }

        $st = $db->prepare("SELECT gjp2, isAdmin FROM accounts WHERE accountID = :acc LIMIT 1");
        $st->execute(array(':acc' => $accountID));
        $row = $st->fetch(PDO::FETCH_ASSOC);

        if (!$row || empty($gjp2)) exit("-1");

        $valid = password_verify($gjp2, $row['gjp2']) || hash_equals((string)$row['gjp2'], (string)$gjp2);
        if (!$valid) exit("-1");

        if ((int)$row['isAdmin'] === 1) return $accountID;

        if (!$gs->checkPermission($accountID, $perm) && !$gs->checkPermission($accountID, "dashboardModTools")) {
            exit("-1");
        }

        return $accountID;
    }

    public static function applyRestriction($db, $gs, $modID, $column, $isUnban = false) {
        $targetID = isset($_POST["targetAccountID"]) ? (int)$_POST["targetAccountID"] : 0;
        if ($targetID <= 0) exit("-1");

        $mode = isset($_POST["mode"]) ? $_POST["mode"] : "temp";
        $mins = isset($_POST["durationMinutes"]) ? (int)$_POST["durationMinutes"] : 1440;
        $durationSec = ($mode === "perm") ? (86400 * 3650) : ($mins * 60);
        $reason = isset($_POST["reason"]) ? ExploitPatch::remove($_POST["reason"]) : "Banned by moderator";
        $now = time();
        $until = $isUnban ? 0 : ($now + max(60, $durationSec));

        if ($isUnban) {
            $val = 0;
        } elseif ($column === "isFrozen" || $column === "isNameLocked") {
            $val = 1;
        } else {
            $val = $until;
        }

        $stmt = $db->prepare("INSERT INTO user_restrictions (accountID, `$column`, reason)
                VALUES (:target, :val, :reason)
                ON DUPLICATE KEY UPDATE `$column` = :val, reason = :reason");
        $stmt->execute(array(':target' => $targetID, ':val' => $val, ':reason' => $reason));

        if ($column === "isFrozen") {
            $db->prepare("UPDATE user_restrictions SET commentBanUntil = :u, uploadBanUntil = :u, messageBanUntil = :u WHERE accountID = :target")
               ->execute(array(':u' => $until, ':target' => $targetID));
            $db->prepare("UPDATE users SET isBanned = :b WHERE extID = :acc")
               ->execute(array(':b' => ($isUnban ? 0 : 1), ':acc' => (string)$targetID));
        } elseif ($column === "uploadBanUntil") {
            $db->prepare("UPDATE users SET isCreatorBanned = :b WHERE extID = :acc")
               ->execute(array(':b' => ($isUnban ? 0 : 1), ':acc' => (string)$targetID));
        }

        // Синхронизация со штатной таблицей `bans` твоего ядра MegaSa1nt (personType = 0 -> accountID)
        // banType: 1 = уровни, 2 = лидерборды, 3 = комментарии, 4 = сообщения
        $banTypes = array();
        if ($column === "uploadBanUntil") $banTypes = array(1);
        elseif ($column === "commentBanUntil") $banTypes = array(3);
        elseif ($column === "messageBanUntil") $banTypes = array(4);
        elseif ($column === "isFrozen") $banTypes = array(1, 3, 4);

        foreach ($banTypes as $bType) {
            $db->prepare("UPDATE bans SET isActive = 0 WHERE person = :p AND personType = 0 AND banType = :bt AND isActive = 1")
               ->execute(array(':p' => (string)$targetID, ':bt' => $bType));

            if (!$isUnban) {
                $bIns = $db->prepare("INSERT INTO bans (modID, person, personType, reason, expires, banType, timestamp, isActive)
                                      VALUES (:mod, :p, 0, :reason, :exp, :bt, :ts, 1)");
                $bIns->execute(array(
                    ':mod' => $modID,
                    ':p' => (string)$targetID,
                    ':reason' => base64_encode($reason),
                    ':exp' => $until,
                    ':bt' => $bType,
                    ':ts' => $now
                ));
            }
        }

        $actionName = ($isUnban ? "unban_" : "ban_") . $column;
        $log = $db->prepare("INSERT INTO modactions (type, value, timestamp, value2, value3, value4, account)
                             VALUES (25, :val, :ts, :target, :dur, :reason, :mod)");
        $log->execute(array(
            ':val' => $actionName,
            ':ts' => $now,
            ':target' => (string)$targetID,
            ':dur' => $durationSec,
            ':reason' => $reason,
            ':mod' => $modID
        ));

        exit("1");
    }
    public static function debugLog($tag, $data) {
        $logPath = dirname(__FILE__) . "/../../2209_debug.log";
        $str = is_string($data) ? $data : json_encode($data, JSON_UNESCAPED_UNICODE);
        @file_put_contents($logPath, "[" . date("Y-m-d H:i:s") . "] [$tag] $str" . PHP_EOL, FILE_APPEND);
    }

}