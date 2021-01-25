<?php
try {
$pdo=new PDO(URI_BASE_DONNEES, UTILISATEUR, MOT_DE_PASSE);
$stm = $pdo->query("SELECT id,formation_name,formation_specialite,description,duration,start_date,end_date FROM formation;");

if ($stm)
{
$contacts= $stm->fetchAll();
$messageJson->data=$contacts;
}
else
{
$messageJson->status=400;
$messageJson->error="Erreur dans la requête SQL";
}

}
catch (Exception $e)
{
$messageJson->status=300;
$messageJson->error=$e->getMessage();
}
?>