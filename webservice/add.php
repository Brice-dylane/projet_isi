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
$i=1;
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
							$sql1 = $pdo->prepare("INSERT INTO jhi_user(login,password_hash,first_name,last_name,email,activated,lang_key,created_by,created_date,last_modified_by,last_modified_date) 
					     VALUES(:login,:mdp,:prenom,:nom,:email,:activated,:lang_key,:created_by,:created_date,:last_modified_by,:last_modified_date)");

					               $stm1 = $sql1->execute(array(
				                                    ':login' => $email,
				                                    ':mdp' => $mdp,
				                                    ':prenom' => $prenom,
				                                    ':nom' => $nom,
				                                    ':email' => $email,
				                                    ':activated' => $i,
				                                    ':lang_key' => 'fr',
				                                    ':created_by' => 'system',
				                                    ':created_date' => $update,
				                                    ':last_modified_by' => 'system',
				                                    ':last_modified_date' => $update
				                                ));

					//$stm1 = $pdo->exec($sql1);

					if ($stm1) {
						$stmt = $pdo->prepare("SELECT id FROM jhi_user WHERE login=:email");
						if ($stmt->execute(array(':email'=>$email))) {
						  	$row = $stmt->fetchAll();
						  	foreach ($row as $subsubarray) {
						  		$id_user = $subsubarray['id'];
						  	}
						    	
						}

						$sql2 = $pdo->prepare("INSERT INTO user_extra(sexe,civilite,matricule,nom_etablissement,date_of_bird,numero_cni,date_delivrance,date_expiration,phone_number,internal_user_id) 
					     VALUES(:sexe,:civilite,:matricule,:etablissement,:dateNais,:cni,:delivrance,:expiration,:tel,:id_user)");

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
				                                    ':id_user' => $id_user
				                                ));

					    if ($stm2)
						{
							if ($profil=='Etudiant') {
								$profil = 'ROLE_ETUDIANT';
							}
							elseif($profil=='Eleve'){
								$profil = 'ROLE_ELEVE';
							}
							else{
								$profil = 'ROLE_PROF';
							}
							$sql3 = $pdo->prepare("INSERT INTO jhi_user_authority(user_id,authority_name) VALUES(:id,:authority_name)");
							$stm3 = $sql3->execute(array(':id'=>$id_user, ':authority_name'=> $profil));

							if($stm3){
								$messageJson->data = array('status' => 1, "message" => "Success");
							}
							else{
								$messageJson->data = array('status' => 0, "message" => "Fail1 insert other information");
							}

						}
						else
						{
						$messageJson->data = array('status' => 0, "message" => "Fail1 insert other information");

						}
						
					}
					else
					{
					$messageJson->data = array('status' => 0, "message" => "Fail change login");
					}

	}
	
	}
	catch (Exception $e)
	{
	$messageJson->status=300;
	$messageJson->error=$e->getMessage();
	}


?>