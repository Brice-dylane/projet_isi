<?php
include "config.php";
$messageJson= new StdClass();
//$messageJson->status=200;
//$messageJson->error=null;
$messageJson->data=null;
// Web service liste des contacts
if (isset($_GET["action"]))
{
	//  and $_GET["action"] == "list")
	if ($_GET["action"] == "list")
	{
	include "list.php";	
	}
	elseif ($_GET["action"] == "view")
	{
	include "view.php";	
	}
	elseif ($_GET["action"] == "connect")
	{
	include "connexion.php";	
	}
	elseif ($_GET["action"] == "add")
	{
	include "add.php";	
	}
	elseif ($_GET["action"] == "edit")
	{
	include "edit.php";	
	}
	elseif ($_GET["action"] == "formlist")
	{
	include "formation.php";	
	}
	
	
}

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
echo json_encode($messageJson);  
?>