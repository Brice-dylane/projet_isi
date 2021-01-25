<?php
$login = $_GET['login'];
$civilite = $_GET['civilite'];
$matricule = $_GET['matricule'];
$cni = $_GET['cni'];
$delivrance = $_GET['delivrance'];
$expiration = $_GET['expiration'];
$tel = $_GET['tel'];

$nom = $_GET['nom'];
$prenom = $_GET['prenom'];
$sexe = $_GET['sexe'];
$dateNais = $_GET['dateNais'];
$profil = $_GET['profil'];
$etablissement = $_GET['etablissement'];
$email = $_GET['email'];
$mdp = $_GET['mdp'];
$update = $_GET['update'];
$id_user = 0;
$other_id=0;

try {
$pdo=new PDO(URI_BASE_DONNEES, UTILISATEUR, MOT_DE_PASSE);

$st = $pdo->prepare("SELECT id FROM user_extra WHERE matricule=:matricule AND numero_cni=:cni AND phone_number=:tel LIMIT 1;");
		if ($st->execute(array(':matricule'=>$matricule, ':cni'=>$cni, ':tel'=>$tel))) {
		  	$rows = $st->fetchAll();
		  	if (!empty($rows)) {
		  		foreach ($rows as $subsubarray) {
		  			$other_id = $subsubarray['id'];		  		
		  	}
		  	}	
		}


		if ($other_id!=0) {
			$messageJson->data = array('status' => 0, "message" => "Fail to insert first informations");
		}
		else{
					$sql1 = $pdo->prepare("UPDATE jhi_user SET password_hash=:mdp,first_name=:nom,last_name=:prenom,last_modified_by='system',last_modified_date=:date_modify WHERE login=:log");

					$stm1 = $sql1->execute(array(
					      ':mdp' => $mdp,
					      ':prenom' => $prenom,
					      ':nom' => $nom,
					      ':date_modify' => $update,
					      ':log' => $email                              
					));


					if ($stm1)
					{

						$stmt = $pdo->prepare("SELECT id FROM jhi_user WHERE login=:email");
							if ($stmt->execute(array(':email'=>$email))) {
							  	$row = $stmt->fetchAll();
							  	foreach ($row as $subsubarray) {
							  		$id_user = $subsubarray['id'];
							  	}
							    	
							}

						$sql2 = $pdo->prepare("UPDATE user_extra SET sexe=:sexe,civilite=:civilite,matricule=:matricule,nom_etablissement=:etablissement,date_of_bird=:dateNais,numero_cni=:cni,date_delivrance=:delivrance,date_expiration=:expiration,phone_number=:tel WHERE internal_user_id=:id");

						$stm2 = $sql2->execute(array(
					                                    ':sexe' => $sexe,
					                                    ':civilite' => $civilite,
					                                    ':matricule' => $matricule,
					                                    ':etablissement' => $etablissement,
					                                    ':dateNais' => $dateNais,
					                                    ':cni' => $cni,
					                                    ':delivrance' => $delivrance,
					                                    ':expiration' => $expiration,
					                                    ':tel' => $tel,
					                                    ':id' => $id_user
					                                ));

						if ($stm2) {
							$messageJson->data = array('status' => 1, "message" => "Success");
						}
						else{
							$messageJson->data = array('status' => 0, "message" => "Fail1 insert other information");
						}

					}
					else
					{
					$messageJson->data = array('status' => 0, "message" => "Fail2 insert other information");
					}
		}


}
catch (Exception $e)
{
$messageJson->status=300;
$messageJson->error=$e->getMessage();
}

?>