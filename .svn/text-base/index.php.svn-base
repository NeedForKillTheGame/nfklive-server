<?php
/////////////////////////////////////////////
// Castle Tree Engine
// Author: 	2009 ConnecT
// Module:	CORE
// Item:	Index
// Version:	0.0.12	07.10.2009
/////////////////////////////////////////////

if (!defined("CASTLE_TREE")) define("CASTLE_TREE", true);
if (!session_id()) session_start();

//
// Configuration
//
require_once("inc/config.inc.php");

// Functions
//
require_once("inc/functions.inc.php");

//
// Classes
//
require_once("inc/classes.inc.php");

// skin
$template = new skin();

// db connect
$db = new db();
$db->connect
(
    $CFG['db_host'],
    $CFG['db_login'],
    $CFG['db_pass'],
    $CFG['db_name'],
    $CFG['db_prefix']
);

// dictionary
$dict = new dictionary();
$dict->pick_language($CFG['language']);

// user
$me = new user();
$user = new user();

// mini calendar
//$minical = new mini_calendar();

//
// Default Values
//

date_default_timezone_set('Europe/Tallinn');



//
// Settings
//

// merge with config form db
$DBCFG = $db->select("*","settings","");
$CFG = array_merge($CFG,$DBCFG);

//
// Main input
//


$PARAMSTR = split('[/]', $_SERVER['QUERY_STRING']);

// paramstr[0] is always null
// paramstr[1] module or node alias
// paramstr[2] module parameter


//
// Module
//

$module = ($PARAMSTR[0] != '') ? ($PARAMSTR[0]) : ($PARAMSTR[1]);
$module = clean('str', $module);

// default module
if ($module == '') $module = $CFG['default_page'];

if (file_exists("./mods/".$module.".mod.php"))
{
    // this is module
    require_once("./mods/".$module.".mod.php");
}
else
{
    // it could be node then, check it
    $res = $db->select("id","nodes","where `alias` = '$module'");
    
    if ($res[0]['id'] != '')
    {
	// ok it's a node, push alias as a parameter
	$PARAMSTR[2] = $module;
	require_once("./mods/node.mod.php");   
    }
    else
    {
	// nope, so show this instead of error
	$PARAMSTR[2] = "under-construction";
	require_once("./mods/node.mod.php");
    }
}

//
// For Logged On Users
//

$template->load_template('overall');

// wtf?
if ($_SESSION['me'] != "") $me->assign($_SESSION['me']);
$xdata = $_SESSION['me'];

$MARKERS = Array
	(
		"GTW_LOGIC"			=> ($xdata['login'] != $null) ? (true) : (false),
		"FULL_NAME"			=> $xdata['full_name'],
		"L_ENTER"			=> $dict->data['enter'],
		"L_LOGOFF"			=> $dict->data['logoff'],
		"L_LOGIN"			=> $dict->data['login'],
		"L_PASSWORD"		=> $dict->data['password'],
		"SELF"				=> $PHP_SELF,
		"NICK_NOCOLOR"		=> stripNameColor($xdata['full_name']),
		"MODELSKIN_LOW"		=> $_SESSION['me']['model'],
		"DATE_REGISTERED"	=> date("F j,Y",strtotime($xdata['registered'])),
	);

$template->assign_variables($MARKERS);

$TEMPLATE_login = $template->build('if_login') or die("error building: if_login");


//
// Build main
//



$MARKERS = Array
(
	"THEME_ROOT"	=> $CFG['root']."themes/".$CFG['theme'],
	"L_VALUE"	=> "Value",
	"L_BOOL"	=> "Boolean",
	"C_DATA_ROW"	=> $o_data_row,
	"IF_TEST"	=> $if_test,
	"CONTENT"	=> $content_data,
	"SUBMENU"	=> $TEMPLATE_submenu,
	"FORM_LOGIN"	=> $TEMPLATE_login,
	"IF_LOGGED2"	=> $TEMPLATE_logged2,
	"IF_LOGGED3"	=> $TEMPLATE_logged3,
	"SELF"		=> $PHP_SELF,
);

$template->assign_variables($MARKERS);

$res = $template->build('main') or die("error building: main");

$SITE .= $res;

print $SITE;


?>