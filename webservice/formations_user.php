<?php
if (isset($_GET["email"]))
{

$email = $_GET['email'];
$id_user = 0;
try {

$pdo=new PDO(URI_BASE_DONNEES, UTILISATEUR, MOT_DE_PASSE);
	$stmt2 = $pdo->prepare("SELECT id FROM jhi_user WHERE login=:email");
                        if ($stmt2->execute(array(':email'=>$email))) {
                            $row = $stmt2->fetchAll();
                            foreach ($row as $subsubarray) {
                                $id_user = $subsubarray['id'];
                            }
                                
                        }

$stm = $pdo->query("select f.id,f.formation_name,f.formation_specialite,f.description,f.duration,f.start_date,f.end_date,f.create_time,c.candidacy_state from candidacy c inner join formation f on f.id=c.formation_id where c.user_id='".$id_user."';");

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


}

?>