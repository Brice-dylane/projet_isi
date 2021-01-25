<?php
if (isset($_GET["map"]) && isset($_GET["search"]))
{
	$login = $_GET["map"];
	$mdp = $_GET["search"];
try {
$pdo=new PDO(URI_BASE_DONNEES, UTILISATEUR, MOT_DE_PASSE);
//$stm = $pdo->exec("select login from jhi_user where login='".$login."';");

$sql1 = $pdo->prepare("select login from jhi_user where login=:login and password_hash=:mdp and activated=1");
$stm1 = $sql1->execute(array(':login' => $login, ':mdp' => $mdp));
$rows = $sql1->fetchAll();
if ($stm1)
{
	foreach ($rows as $subsubarray) {
		  	$response = $subsubarray['login'];
	}
	if (!empty($response)) {
		$messageJson->data = array('status' => 1, "message" => "Success");
	}
	else{
		$messageJson->data = array('status' => 0, "message" => "Fail");
	}
	
}
else
{
	$messageJson->data = array('status' => 0, "message" => "Fail");
}

}
catch (Exception $e)
{
$messageJson->status=300;
$messageJson->error=$e->getMessage();
}
}
else
{
$messageJson->data = array('status' => 0, "message" => "Fail Le paramêtre ID est obligatoire");
}
?>