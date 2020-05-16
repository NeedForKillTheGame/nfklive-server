<?php
/////////////////////////////////////////////
// Castle Tree Engine
// Author: 	2009 ConnecT
// Module:	News
// Item:	
// Version:	0.0.2	24.04.2009
/////////////////////////////////////////////

if (!defined("CASTLE_TREE")) die();

$template->load_template('mod_news');

$res = $db->select('*','mod_news',"order by `posted` DESC limit 5");
$i = 1;
foreach ($res as $row)
{

	$MARKERS = Array
	(
		"IF_EVEN"		=> (($i%2) == 0) ? ('even') : ('odd'),
		"IF_MODER3"		=> $if_moder3,
		"MY_ID"			=> $_SESSION['me']['id'],
		"NEWS_POSTED"		=> $row['posted'],
		"THEME_ROOT"		=> $CFG['root']."themes/".$CFG['theme'],
		
		"L_EDIT_FORM"		=> $dict->data['edit_form'],
		
		"NEWS_TOPIC"		=> $row['news_topic'],
		"POSTER_ID"		=> $row['poster_id'],
		"NEWS_BODY"		=> $row['news_body'],
		"NEWS_TYPE"		=> $row['news_type'],
	);
	
	$template->assign_variables($MARKERS);

	$news_rows .= $template->build('news_row') or die("error building: news\main");
	$i++;
}

$MARKERS = Array
	(
		"NEWS_ROWS"			=> $news_rows,
		"IF_MODER3"			=> $if_moder3,
		"MY_ID"				=> $_SESSION['me']['id'],
		"THEME_ROOT"		=> $CFG['root']."themes/".$CFG['theme'],
	);
	
$template->assign_variables($MARKERS);

$content_data .= $template->build('main') or die("error building: news\main");

?>