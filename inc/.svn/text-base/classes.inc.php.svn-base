<?php
/////////////////////////////////////////////
// Castle Tree Engine
// Author: 	2009 ConnecT
// Item:	Classes library
// Version:	0.0.15	05.10.2009
/////////////////////////////////////////////

if (!defined("CASTLE_TREE")) die();

//
// Debug class
//
class watch
{
	public $vars = Array();
	
	public function add($var)
	{
		array_push($this->vars,$var);
	}
	
	public function clear()
	{
		$this->vars = Array();
	}
	
	public function flush()
	{
		$vars = $this->vars;
		foreach ($vars as $var)
		{
			print $var."<br>";
		}
		$this->clear();
	}
	
	public function show()
	{
		foreach ($this->vars as $var)
		{
			print $var."<br>";
		}
	}
}

//
// Database class
//
class db 
{
    private $link	="";
    public $prefix	="";
		
	public function connect($db_host, $db_login, $db_pass, $db_name, $db_prefix)
	{
		$this->prefix = $db_prefix;
		$this->link = mysql_connect($db_host, $db_login, $db_pass);
		mysql_select_db($db_name, $this->link);
		
		mysql_query("SET CHARACTER_SET_CLIENT=utf8");
		mysql_query("SET CHARACTER_SET_RESULTS=utf8");
		
		return $this->link;
	}
	
	public function close()
	{
		mysql_close($this->link);
		$this->link = "";
	}
	
	public function select($a,$b,$c)
	{
		// clean input
		//$a = clean('str', $a);
		//$b = clean('str', $b);
		//$c = clean('str', $c);
		
		$result = Array();
		
		$q = mysql_query("select ".$a." from `".$this->prefix."_$b` $c", $this->link);
		
		
		if ($q != '')
		while ($row = mysql_fetch_assoc($q))
		{
			array_push($result,$row);
		}
		
		unset($a);
		unset($b);
		unset($c);
		unset($q);
				
		return $result;
	}
	
	public function insert($table,$cell_array)
	{
		global $db;
		// clean input
		$table = $this->prefix."_".$table;
		//$cell_array = clean('arr', $cell_array);
		//$value_array = clean('arr', $value_array);
		
		foreach ($cell_array as $key => $value )
		{
			$keys[] = $key;
			$values[] = $value;
		}
		
		$keys = implode(",",$keys);
		$values = implode(",",$values);
		
		$q = mysql_query("insert into $table ($keys) values ($values)");
		if ($q)
		{
			return true;
		}
		else 
			print mysql_error();
			// return false;
	}
	
	public function update($table, $cell_array, $condition)
	{
		global $db;
		
		$items = Array();
		
		// clean input
		$table = $this->prefix."_".$table;
		
		foreach ($cell_array as $key => $value )
		{
			$items[] = "$key = $value";
		}
		
		$items = implode(",",$items);
		
		$q = mysql_query("update $table SET $items $condition");
		
		if ($q)
		{
			return true;
		}
		else 
			return false;
	}
	
	public function delete($table,$condition)
	{
		global $db;
		// clean input
		$table = $this->prefix."_".$table;
		//$cell_array = clean('arr', $cell_array);
		//$value_array = clean('arr', $value_array);
		
		$q = mysql_query("delete from $table WHERE $condition");
		if ($q)
		{
			return true;
		}
		else 
			print mysql_error();
			// return false;
	}
}

//
// Templated class
//

class skin
{
	private $MARKERS		= Array();
	private $TEMPLATE		= Array();
	private $excluded_tags	= Array
	(
		"else",
		" "
	);
	
	//
	// Loading template and splitting to blocks
	//
	public function load_template($template_name)
	{
		global $CONFIG_root,$CFG;
		$filename = $CONFIG_root.'themes/'.$CFG['theme'].'/'.$template_name.'.tmpl.html';
		$handle = fopen($filename, "rt");
		$buffer = fread($handle, filesize($filename));
		fclose($handle);
		
		
		$i = 1; 	// start search from the second symbol
		$block = Array();
		
		$x = 0; // detecting level
		$y = 0;
		
		// search for block markers and remember positions
		while (stripos($buffer, "<!-- GTW: ",$i) !== false )
		{
			$a = stripos($buffer, "<!-- GTW: ",$i);
			$b = stripos($buffer, " -->", $a);
			
			// extract block name
			$block_name = substr($buffer,$a+10,$b-$a-10);
			$block_name = trim($block_name); // to be sure
			
			$excluded_tag = false;
			foreach ($this->excluded_tags as $tag)
			{
				if ($block_name == $tag)
				{
					$excluded_tag = true;
					break;
				}
			}
					
			if (!$excluded_tag)
			{				
				// insert block's marker begin/end
				$block[ $block_name ]['index'] = Array ($a-1,$b+4); // marker begins, marker ends			
				$block_indx[ $block_name ] = Array ($a-1,$b+4); // marker begins, marker ends
	
				// detect end of block
				if ($block_name[0] == "/")
				{
					// sub block are ending here
					$parent = $block[$parent]['parent'];
				}
				else
				{	
					// There are could be multiply includings, so we need an array
					// sub block are starting here						
					$block[ $parent ]['sub'][] = $block_name;
					$block[ $block_name ]['parent'] = $parent;
					$parent = $block_name;
				}
			}
			
			$i = $a+1; // to search next marker
		}
	
		//
		// cut to blocks
		//
		$block_name = "";
		foreach ($block_indx as $block_name => $index)
		{
			$block_name = strtolower($block_name);
			
			if ($block_name[0] != "/")
			{
				$block_begin	= $index[1];
				$block_end		= $block[ "/".$block_name ]['index'][1];				
				
				// Cut includings
				//
												
				if ($block[$block_name]['sub'][0] != "")
				{						
					// There are could be multiply includings
					$exsub = ""; // there were no subs yet
					foreach ($block[$block_name][sub] as $sub)
					{					
						$sub_begin 	= $block[ $sub ]['index'][0];
						$sub_end 	= $block[ "/".$sub ]['index'][1];
	
						if ($exsub == "")
						{
							// first sub / block_begin to sub_begin
							$buffer2 =
								substr($buffer,$block_begin,$sub_begin-$block_begin);
						}
						else
						{
							// never goes here o_O but it's working
							
							// exsub_end to sub_begin
							$buffer2 .=
								substr($buffer,$exsub_end,$sub_begin-$exsub_end);	
						}
							
						// we need to remember previous subblock					
						$exsub 			= $sub;
						$exsub_begin 	= $sub_begin;
						$exsub_end 		= $sub_end;
					}
					// 
					$buffer2 .= substr($buffer, $sub_end, $block_end - $sub_end - strlen("<!-- GTW: /".$block_name." -->"));
				}
				else
				{
					// Get whole block with possible includings
					// Block has no includings
					$buffer2 = substr($buffer,$index[1], $block_end - $block_begin - strlen("<!-- GTW: /".$block_name." -->"));
				}
				
			}
			
			// finalize block
			$skin_blocks[$block_name] = $buffer2;
		}
		
		// validate template, 'main' block must exist
		if ($skin_blocks['main'] == '') return false;
		
		$this->TEMPLATE = $skin_blocks;
		
		// should we clean $VARIABLES and $MARKERS now?
		$this->MARKERS		= "";
	}
	
	//
	// Assign variables
	//
	public function assign_variables($input)
	{
		$this->MARKERS = $input;
	}
	
	//
	// Replace template markers with values
	//
	public function build($block)
	{
		
		// if block exists
		if ($this->TEMPLATE[$block] == '') return false;
		
		// logical if
		if (stripos(" ".$block,'if_') == 1)
			{
				$logical = split('<!-- GTW: else -->',$this->TEMPLATE[$block]);
				$TEMPLATE_formed = ($this->MARKERS['GTW_LOGIC'] == true) ? ($logical[0]) : ($logical[1]);
			}
		else
			$TEMPLATE_formed = $this->TEMPLATE[$block]; 
		
		// markers workout
		if (count($this->MARKERS) > 1)
		{			
			foreach ($this->MARKERS as $marker => $marker_value) 
			{
				$TEMPLATE_formed = str_replace("{".$marker."}",$marker_value,$TEMPLATE_formed);
			}
		}
		elseif (count($this->MARKERS) == 1)
		{
			// !!! still not working
			// one marker is not suitable for foreach cycle
			$marker = array_keys($this->MARKERS);
			$marker_value = $this->MARKERS[$marker];
			 
			$TEMPLATE_formed = str_replace("{".$marker."}",$marker_value,$TEMPLATE_formed);
		}
		else return false;
		
		return $TEMPLATE_formed;
	}	
}

//
// User class
//
class user
{
	public $data = Array();
	
	// find user by id
	public function fetchId($user_id)
	{
		global $db;
		
		$user_id = clean('int',$user_id);
		
		$table_users = $db->prefix . "_users";
		$q = mysql_query("select * from `$table_users` where `id` = $user_id");
		return mysql_fetch_assoc($q);
	}
	
	// find user by name
	public function fetchName($user_name)
	{
		global $db;
		
		$user_id = clean('str',$user_name);
		
		$table_users = $db->prefix . "_users";
		$q = mysql_query("select * from `$table_users` where `login` = '$user_name'");
		return mysql_fetch_assoc($q);
	}
	
	// check user permission
	public function can($rule)
	{
		
	}
	
	// catch userdata from array
	public function assign($userdata)
	{
		$this->data = $userdata;
	}
	
	public function xdata()
	{
		return $this->data;
	}
}

//
// Session
//


//
// Dictionary
//
class dictionary
{
	public $data = Array();
	
	// load language
	public function pick_language($lang)
	{
		$this->data = Array();
		// here we need dictionary loading
		include("./langs/$lang/dictionary.inc.php");
	}

}

//
// Mini calendar
//

class mini_calendar
{
	private $events = Array();
	
	public function draw($date)
	{
		global $db, $dict;
		
		$template = new skin();
		$date_time = strtotime($date);
		$cmd = $_GET["cmd"];
		
		// return events
		$events = $db->select('created','modules_orders',
			' where `created` > "'.
			date("Y-m-01 00:00:00", $date_time).
			'" and `created` < "'.
			date("Y-m-t 23:59:59", $date_time).
			'" and `state` < 99'.
			' order by `created`');
			

		// attach events
		foreach ($events as $event)
		{
			$that_day = date("d", strtotime($event['created']));
			$this->events[$that_day]++;
		}
		
		//
		// Build template
		//
		$template->load_template('mini_calendar');
		
		// Prepare days before month		
		$first_weekday_of_month = date( "w", mktime(0, 0, 0, substr($date,6,2), 01, substr($date,1,4)) );
		
		if ($first_weekday_of_month == 0)
		{
			$wmax = 7;
		}
		else
		{
			$wmax = $first_weekday_of_month;
		}
		
		for ($w = 1; $w < $wmax; $w++)
		{
			$MARKERS = Array
			(
				"x"			=> "",
				"y"			=> "",
			);
			$template->assign_variables($MARKERS);
			$days .= $template->build('day_null') or die("error building: mini_calendar/day_null");
		}
		
		// Prepare weeks
		for ($d = 1; $d <= date("t", $date_time); $d++)
		{		
			// probe date
			$newdate = date("Y-m-X 00:00:00", $date_time);
			$newdate = str_replace("X", $d, $newdate);
			
			// Prepare days
			$w = date("w", strtotime($newdate)) ; // weekday
			$events = ($this->events[$d]!= "") ? ($this->events[$d]) : ("&nbsp;"); 
			
			$MARKERS = Array
			(
				"GTW_LOGIC"	=> ($events != "&nbsp;") ? (true) : (false),
				"CMD"		=> $cmd,
				"LINK_DAY"	=> date("Y-m-d",strtotime($newdate)),
				"DAY_N"		=> $d,
				"EVENTS" 	=> $events,
			);
			$template->assign_variables($MARKERS);
			$days .= $template->build('if_day') or die("error building: mini_calendar/if_day");
			
			if ($w == 0) 
			{
				$MARKERS = Array
				(
					"IF_DAY" 	=> $days,
					"DAY_NULL"	=> "",
				);
				$days = "";
				$template->assign_variables($MARKERS);
				$weeks .= $template->build('week') or die("error building: mini_calendar/week");
			}	
		}
		
		$MARKERS = Array
		(
			"IF_DAY" 	=> $days,
			"DAY_NULL"	=> "",
		);
		$days = "";
		$template->assign_variables($MARKERS);
		$weeks .= $template->build('week') or die("error building: mini_calendar/week");
		
		$this_month = date("M", $date_time);
		
		$MARKERS = Array
		(
			"WEEK" 				=> $weeks,
			"THIS_MONTH"		=> $dict->data[$this_month],
			"CMD"				=> $cmd,
			"LINK_NEXT_MONTH"	=>	date("Y-m-d",strtotime("next month", $date_time)),
			"LINK_PREV_MONTH"	=>	date("Y-m-d",strtotime("previous month", $date_time)),
			
		);
		$template->assign_variables($MARKERS);
		$result = $template->build('main') or die("error building: mini_calendar/main");
		
		return $result;
	}

}

?>