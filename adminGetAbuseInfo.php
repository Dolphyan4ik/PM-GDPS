<?php
include "incl/lib/connection.php";
require_once "incl/lib/mainLib.php";
require_once "incl/lib/admin2209.php";
$gs = new mainLib();
Admin2209::authMod($db, $gs, "admin2209View");

echo "##0:0:20";
