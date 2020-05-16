<?php
/////////////////////////////////////////////
// Castle Tree Engine
// Author: 	2009 ConnecT
// Module:	Profile (server listing)
// Item:	
// Version:	0.0.4	06.10.2009
/////////////////////////////////////////////

if (!defined("CASTLE_TREE")) die();

//
// Render "Create Server" button
//
$template->load_template('mod_home'); // template from Home

$MARKERS = Array
	(
		"GTW_LOGIC"	=> ($_SESSION['me']['login'] != $null) ? (true) : (false),
		"PSID"		=> $_SESSION['me']['psid'],
	);
	
$template->assign_variables($MARKERS);
$TEMPLATE_logged2 = $template->build('if_logged_createsrv') or die("error building: home\if_logged_createSrv");

$template->load_template('mod_profile_summary'); 

//
// Server List
//
$res = $db->select('*','serverList','where ttl >= NOW()');

foreach ($res as $row)
{

	$MARKERS = Array
	(
		"MATCH_ID"		=> $row['serverID'],
		"MY_ID"			=> $_SESSION['me']['id'],
		"MAP_NAME"		=> $row['mapName'],
		
		"THEME_ROOT"		=> $CFG['root']."themes/".$CFG['theme'],
		
		"CITY"					=> $row['hostname'],
		"SERVER_IP"				=> $row['serverIP'],
		"PSID"					=> $_SESSION['me']['psid'],
		"GAMETYPE"				=> GameType($row['gameType']),
		"GAMETYPE_SHORT"		=> GameTypeShort($row['gameType']),
		"PLAYERCOUNT"			=> $row['playerCount'],
		"PLAYERMAX"				=> $row['playerMax'],
		"COUNTRY_CC3"			=> strtolower( ip2country('cc3',$row['serverIP']) ),
	);
	
	$template->assign_variables($MARKERS);

	$match_rows .= $template->build('match_row') or die("error building: home\match_row");
}

//
// Brief Stats
//

// get clan
$clan = $db->select('clanTag','clanList','WHERE clanID = '.$_SESSION['me']['clanID']);

// get stats
$stats = $db->select('*','playerStats','WHERE playerID = '.$_SESSION['me']['id']);
$stats = $stats[0];

// get awards
//
$awards = $db->select('medalID','playerRewards','WHERE playerID = '.$_SESSION['me']['id'].' ORDER BY `rewardTime` DESC LIMIT 6');

$award_n = 0; // awards in a row counter
foreach ($awards as $award)
{	
	// build single row
	$award_n++;
	$this_award = $db->select('*','medals','WHERE medalID = '.$award['medalID']);
	$this_award = $this_award[0];
			
	$MARKERS = Array
		(
			"AWARD_NAME"		=> $this_award['medalName'],
			"AWARD_NAME_FILE"	=> strtolower( str_replace(' ','_',$this_award['medalName']) ),
			"AWARD_DESCRIPTION"	=> $this_award['medalDescription'],
			"AWARD_ID"			=> $this_award['medalID'],
		);
	$template->assign_variables($MARKERS);
	$award_row .= $template->build('award_row') or die("error building: home\award_row");

	
	// build rows block (by 3)
	if ($award_n >= 3)
	{
		$MARKERS = Array
		(
			"AWARD_ROWS"	=> $award_row,
			"THEME_ROOT"			=> $CFG['root']."themes/".$CFG['theme'],
		);
		
		$template->assign_variables($MARKERS);

		$award_rows .= $template->build('awards') or die("error building: home\awards");
		
		$award_n = 0;
		$award_row = '';
	}
}

// build last award block
if ($award_n > 0)
{
	$MARKERS = Array
	(
		"AWARD_ROWS"	=> $award_row,
		"THEME_ROOT"			=> $CFG['root']."themes/".$CFG['theme'],
	);
		
	$template->assign_variables($MARKERS);
	$award_rows .= $template->build('awards') or die("error building: home\awards");
}

// buld fav_weapon
$MARKERS = Array
	(
		"WEAPON_SHORTNAME"	=> 	weaponShortName($stats['favWeapon']),
		"WEAPON_FULLNAME"	=> 	weaponFullName($stats['favWeapon']),
	);
		
$template->assign_variables($MARKERS);
$fav_weapon = $template->build('fav_weap') or die("error building: home\fav_weap");

// buld fav_gametype
$MARKERS = Array
	(
		"GAMETYPE_SHORT"	=> 	GameTypeShort($stats['favGameType']),
		"GAMETYPE_FULL"		=> 	GameType($stats['favGameType']),
	);
		
$template->assign_variables($MARKERS);
$fav_gametype = $template->build('fav_gametype') or die("error building: home\fav_gametype");

// get model name
$model_name = explode('_',$_SESSION['me']['model']); // split model from skin by '_'
$model_name = ucfirst($model_name[0]); // first letter is uppercase

// build quickstats
$MARKERS = Array
	(
		"GTW_LOGIC"		=> ($_SESSION['me']['login'] != $null) ? (true) : (false),
		"MY_ID"			=> $_SESSION['me']['id'],
		
		"FRAGS"					=> $stats['frags'],
		"GAMES"					=> $stats['games'],
		"TIME_FULL"				=> $stats['time'],
		"TIME_DAYS"				=> calcHourDays($stats['time']),
		"LASTGAME_FULL"			=> ago_(strtotime($stats['lastGame'])),
		"LASTGAME_DAYHOURS"		=> ago_(strtotime($stats['lastGame'])),
		
		"ACCURACY"				=> ($stats['shots'] != 0) ? ( round($stats['hits'] * 100 / $stats['shots']) ) : (0),
		"HITS"					=> $stats['hits'],
		"FIRE"					=> $stats['shots'],
		
		"WINS"					=> $stats['wins'],
		"LOSSES"				=> $stats['losses_quits'],
		"WIN_RATIO"				=> ($stats['wins'] != 0) ? (round($stats['losses_quits'] / $stats['wins'], 2)) : (0),
		
		"DEATHS"				=> $stats['deaths'],
		"FRAG_RATIO"			=> ($stats['deaths'] != 0) ? (round($stats['frags'] / $stats['deaths'],2)) : (0),
		
		"AWARDS"				=> $award_rows,
		"FAV_WEAPON"			=> $fav_weapon,
		"FAV_GAMETYPE"			=> $fav_gametype,
		"FAV_MAP"				=> '',
		
		"MODELSKIN_LOW"			=> $_SESSION['me']['model'],
		"MODEL_NAME"			=> $model_name,
		
		"THEME_ROOT"			=> $CFG['root']."themes/".$CFG['theme'],
		"NICK_NOCOLOR"			=> stripNameColor($_SESSION['me']['full_name']),
		"CLANTAG_NOCOLOR"		=> stripNameColor($clan[0]['clanTag']),
	);
	
$template->assign_variables($MARKERS);

$brief_stats = $template->build('if_logged') or die("error building: home\if_logged");

//
// Build Main
//
$MARKERS = Array
	(
		"MATCH_ROWS"		=> $match_rows,
		"BRIEF_STATS"		=> $brief_stats,
		"MY_ID"				=> $_SESSION['me']['id'],
		"THEME_ROOT"		=> $CFG['root']."themes/".$CFG['theme'],
	);
	
$template->assign_variables($MARKERS);

$content_data .= $template->build('main') or die("error building: home\main");

?>