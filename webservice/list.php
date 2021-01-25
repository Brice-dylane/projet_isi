<?php
$login = $_GET['map'];
try {
$pdo=new PDO(URI_BASE_DONNEES, UTILISATEUR, MOT_DE_PASSE);
$stm = $pdo->query("select j.first_name,j.last_name,u.sexe,r.authority_name,u.civilite,u.date_of_bird,u.matricule,u.numero_cni,u.date_delivrance,u.date_expiration,u.nom_etablissement,j.email,u.phone_number 
from jhi_user j inner join user_extra u on(j.id=u.internal_user_id) inner join jhi_user_authority r on(r.user_id=j.id) where j.email='".$login."';");

if ($stm)
{
$user= $stm->fetchAll();
$messageJson->data=$user[0];
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