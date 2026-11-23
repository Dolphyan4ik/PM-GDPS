<?php
include "incl/lib/connection.php";
require_once "incl/lib/mainLib.php";
require_once "incl/lib/admin2209.php";
$gs = new mainLib();
$modID = Admin2209::authMod($db, $gs, "admin2209Ban");
Admin2209::applyRestriction($db, $gs, $modID, "uploadBanUntil", false);
