<?php
/////////////////////////////////////////////
// Castle Tree Engine
// Author: 	2009 ConnecT
// Module:	Core
// Item:	Functions
// Version:	0.0.5	07.10.2009
/////////////////////////////////////////////

//
// Get permission state for current user
//
function check_rules($rule)
{
	$xdata = $_SESSION['me'];
	
	if ($xdata['login'] == "") return false;
	
	$q = mysql_query("select `group_id` from `ct_usergroups` where `user_id` = $xdata[id]");
		$group_id = mysql_result($q,0);
	
	$q = mysql_query("select `state` from `ct_permissions` where `label` = '$rule' and `group_id` = $group_id");
	
	return @mysql_result($q,0);
}

function get_user($user_id)
{	
	global $db_link;
	$q = mysql_query("select * from `ct_users` where `id` = $user_id",$db_link);
	return mysql_fetch_array($q);
}

//
// Clean input values
//
function clean($type,$variable)
{
	$type = strtolower($type);
	
	// common cleaning
		$result = $variable;
		$result = strip_tags($result);  // strip HTML tags
		$result = trim($result);		// remove spaces at the beginnig and at the end
		$result = htmlspecialchars(stripslashes($result), ENT_QUOTES);
		$result = str_replace(chr(39), '&#39;', $result);
	// ---
	
	if ($type == "int") 
	{
		/*
		if (!is_int($result))
		{
			// doesn't look like integer for me
			return null;
		}
		*/
	}
	elseif ($type == "date")
	{
		// To check if it's right date format, we need to count ':' and '.' chars 
		// fitting template 'HH:MM:nn dd-mm-yyyy'
		
		//$count = 
		//if ()
	}
	elseif ($type == "str")
	{
		
	}
	elseif ($type == "arr")
	{
	
	
	}
	
	return $result;	
}


/**
 * Return unicode char by its code
 *
 * @param int $u
 * @return char
 */
function unichr($u) {
    return mb_convert_encoding('&#' . intval($u) . ';', 'UTF-8', 'HTML-ENTITIES');
}


/**
 * Convert x.x.x.x to 000000000000
 */
function flatIP($dotIP)
{
	$dotIP = explode('.',$dotIP);
	
	foreach ($dotIP as $ip)
	{
		while (strlen($ip) < 3) { $ip = '0' . $ip; } // 2 > 002
		$result .= $ip;
	}

	return $result;
} 

/**
 *
 */
function win2utf($s)
{
	for($i=0, $m=strlen($s); $i<$m; $i++)
	{
		$c=ord($s[$i]);
		if ($c<=127)
		{$t.=chr($c); continue; }
		if ($c>=192 && $c<=207)
		{$t.=chr(208).chr($c-48); continue; }
		if ($c>=208 && $c<=239)
		{$t.=chr(208).chr($c-48); continue; }
		if ($c>=240 && $c<=255)
		{$t.=chr(209).chr($c-112); continue; }
		if ($c==184) { $t.=chr(209).chr(209);
			continue; };
		if ($c==168) { $t.=chr(208).chr(129);
			continue; };
	}
	return $t;
}


/**
 * 
 *
 */
function ip2russia($ip)
{
	$data = '<ipquery><fields><city/></fields><ip-list><ip>'.$ip.'</ip></ip-list></ipquery>';
	$url = "http://194.85.91.253:8090/geo/geo.html";
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL,$url); // set url to post to
	curl_setopt($ch, CURLOPT_FAILONERROR, 1);
	curl_setopt($ch, CURLOPT_HEADER, false);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);// allow redirects
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1); // return into a variable
	curl_setopt($ch, CURLOPT_TIMEOUT, 3); // times out after 4s
	curl_setopt($ch, CURLOPT_POST, 1); // set POST method
	curl_setopt($ch, CURLOPT_POSTFIELDS, $data ); // add POST fields
	$result = curl_exec($ch); // run the whole process
	curl_close($ch); 
	
	$result = win2utf(strip_tags($result));
	
	if ($result != '')
	return 'rus';
}

/**
 * Get country by ip
 * @par {'cc2';'cc3'}
 * @return str
 */
function ip2country($par,$ip)
{
	//global $db;
	
	$par = (strtolower($par) == 'cc2') ? ('cc2') : ('cc3');
	
	// make flat if needed
	if (strpos($ip,'.') > 0) $flat_ip = flatIP($ip);
	
	//$res = $db->select('*','geoipDB','WHERE ip_from <= $ip and ip_to >= $ip');
	$res = mysql_query("select $par from nfkLive_geoipDB WHERE `ip_from` <= $flat_ip and ip_to >= $flat_ip");
	$res = mysql_fetch_assoc($res);
	
	if ($res == '')
	{
		return ip2russia($ip);
	}
	else
		return implode($res);
} 

/**
 *
 */
function GameType($gt)
{
	$gameType[0] = "Deathmatch";
	$gameType[1] = "Duel";
	$gameType[2] = "Team Deathmatch";
	$gameType[3] = "Capture The Flag";
	$gameType[4] = "Rail Arena";
	$gameType[5] = "Trix Arena";
	$gameType[6] = "Practice";
	$gameTyme[7] = "Domination";
	
	return $gameType[$gt];
}
/**
 *
 */
function GameTypeShort($gt)
{
	$gameType[0] = "dm";
	$gameType[1] = "duel";
	$gameType[2] = "tdm";
	$gameType[3] = "ctf";
	$gameType[4] = "gib";
	$gameType[5] = "trx";
	$gameType[6] = "tren";
	$gameTyme[7] = "dom";
	
	return $gameType[$gt];
}

/**
 * Strip name colors
 */
function stripNameColor($nick)
{
	for ($i = 0; $i<=strlen($nick); $i++ )
	{
		if (($nick[$i] != '^') and (!is_numeric($nick[$i+1])) )
		if (($nick[$i-1] != '^') and (!is_numeric($nick[$i])) )
		$pure .= $nick[$i];
	}
	
	return $pure;
}

/**
 * Parse name colors
 */
function parseNameColor($nick)  
{
	global $COLORS;
	for ($i = 1; $i<=strlen(utf8_decode($nick)); $i++ )
	{
		if (($nick[$i] == '^') and (is_numeric($nick[$i+1])) )
		{
			$colorized .= "</font><font color='".$COLORS[$nick[$i+1]]."'>";
		}
		elseif ( ($nick[$i-1] == '^') and (is_numeric($nick[$i])) ) { /* skip color code */ }
		else $colorized .= $nick[$i]; 
	}
	
	return $colorized . '</font>';
}

/**
 *
 */
function _ago($tm,$rcs = 0) 
{
    $cur_tm = time(); $dif = $cur_tm-$tm;
    $pds = array('second','minute','hour','day','week','month','year','decade');
    $lngh = array(1,60,3600,86400,604800,2630880,31570560,315705600);
    for($v = sizeof($lngh)-1; ($v >= 0)&&(($no = $dif/$lngh[$v])<=1); $v--); if($v < 0) $v = 0; $_tm = $cur_tm-($dif%$lngh[$v]);
   
    $no = floor($no); if($no <> 1) $pds[$v] .='s'; $x=sprintf("%d %s ",$no,$pds[$v]);
    if(($rcs == 1)&&($v >= 1)&&(($cur_tm-$_tm) > 0)) $x .= time_ago($_tm);
    return $x;
}
 
/**
 *
 */
function calcHourDays($mins)
{
	$days = floor($mins / (24*60));
		$mins = $mins - ($days * 24 * 60);
	
	if ($mins > 0)
	$hours = floor($mins / 60);
		$mins = $mins - ($hours * 60);
	
	if ($days > 0) $result = $days. 'd';
	if ($hours > 0) $result .= ' '.$hours.' h';
	if ($mins > 0) $result .= ' '.round($mins).' m';
	
	return $result;
} 

/**
 *
 */
function weaponShortName($id)
{
	$weapon[0] ='gauntlet';
	$weapon[1] ='machinegun';
	$weapon[2] ='shotgun';
	$weapon[3] ='grenade';
	$weapon[4] ='rocket';
	$weapon[5] ='lightning';
	$weapon[6] ='plasma';
	$weapon[7] ='railgun';
	$weapon[8] ='bfg';
	
	return $weapon[$id];
}

/**
 *
 */
function weaponFullName($id)
{
	$weapon[0] ='Gauntlet';
	$weapon[1] ='Machinegun';
	$weapon[2] ='Shotgun';
	$weapon[3] ='Grenade Launcher';
	$weapon[4] ='Rocket Launcher';
	$weapon[5] ='Shaft';
	$weapon[6] ='Plasmagun';
	$weapon[7] ='Railgun';
	$weapon[8] ='BFG';
	
	return $weapon[$id];
}

function newSID()
{
	for ($i=0;$i<16;$i++)
	{
		$way = rand(1,3);
		if ($way == 1) { $result .= chr(rand(48,57)); }
		elseif ($way == 2) { $result .= chr(rand(65,90)); }
		else $result .= chr(rand(97,122));
	}
	return $result;
}
?>