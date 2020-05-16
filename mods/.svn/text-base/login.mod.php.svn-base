<?php
/////////////////////////////////////////////
// Castle Tree Engine
// Author: 	2009 ConnecT
// Module:	Core
// Item:	Login
// Version:	0.0.4	05.10.2009
/////////////////////////////////////////////


if (!defined("CASTLE_TREE")) die();

if ($_POST['f_action'] == 'login')
{
	//
	// Login
	//

	$temp_user['login'] = $_POST["f_login"];
	$temp_user['password'] = $_POST["f_password"];

	if ($this_user = $user->fetchName($temp_user['login']))
	{
		if ($this_user["password"] == $temp_user["password"])
		{
			// login/pass accepted
			// 
			$me->assign($this_user);
			$_SESSION['me'] = $me->data;
			
			$_SESSION['me']['psid'] = newSID();
			
			$db->insert('sessions', Array(
				'sessionIP'	=> "'".$_SERVER['REMOTE_ADDR']."'",
				'playerID'	=> $_SESSION['me']['id'],
				'ttl'		=> "'".date("Y-m-d H:i:s",strtotime('+30 seconds'))."'",
				'psid'		=> "'".$_SESSION['me']['psid']."'",
			));
			
			// redirect
			header('Location: '.$PHP_SELF.'?/'.$CFG['default_page']);
			
		}
		else 
		{
			// handle exception
		}
	}
}

// TODO: redirect 

?>