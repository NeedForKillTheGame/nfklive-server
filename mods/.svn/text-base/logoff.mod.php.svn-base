<?php
/////////////////////////////////////////////
// Castle Tree Engine
// Author: 	2009 ConnecT
// Module:	Core
// Item:	Logoff
// Version:	0.0.2	05.10.2009
/////////////////////////////////////////////


if (!defined("CASTLE_TREE")) die();


//
// Logoff
//
$null_array = Array();

$db->delete('sessions', "psid = '".$_SESSION['me']['psid']."'");

$me->assign($null_array);
$_SESSION['me'] = $null_array;
	
header('Location: '.$PHP_SELF.'?/'.$CFG['default_page']); 

?>