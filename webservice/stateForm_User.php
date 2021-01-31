<?php
if (isset($_GET["email"]))
{
$email = $_GET["email"];
$id_user=0;
$load_form=0;
$succed_form=0;
$faild_form=0;

try{
	$pdo=new PDO(URI_BASE_DONNEES, UTILISATEUR, MOT_DE_PASSE);
	$stmt2 = $pdo->prepare("SELECT id FROM jhi_user WHERE login=:email");
                        if ($stmt2->execute(array(':email'=>$email))) {
                            $row = $stmt2->fetchAll();
                            foreach ($row as $subsubarray) {
                                $id_user = $subsubarray['id'];
                            }
                                
                        }

	$stmt1 = $pdo->prepare("select count(formation_id) as nload from candidacy where candidacy_state='LOAD' and user_id=:id;");
                        if ($stmt1->execute(array(':id'=>$id_user))) {
                            $row = $stmt1->fetchAll();
                            foreach ($row as $subsubarray) {
                                $load_form = $subsubarray['nload'];
                            }
                                
                        }


	$stmt3 = $pdo->prepare("select count(formation_id) as nsuccess from candidacy where candidacy_state='SUCCESS' and user_id=:id;");
                        if ($stmt3->execute(array(':id'=>$id_user))) {
                            $row = $stmt3->fetchAll();
                            foreach ($row as $subsubarray) {
                                $succed_form = $subsubarray['nsuccess'];
                            }
                                
                        }

    $stmt4 = $pdo->prepare("select count(formation_id) as nfaild from candidacy where candidacy_state='FAILD' and user_id=:id;");
                        if ($stmt4->execute(array(':id'=>$id_user))) {
                            $row = $stmt4->fetchAll();
                            foreach ($row as $subsubarray) {
                                $faild_form = $subsubarray['nfaild'];
                            }
                                
                        }

     if($stmt1 && $stmt2 && $stmt3 && $stmt4){
     	$messageJson->data = array('status' => 1,'faild' => $faild_form, "success" => $succed_form, "load" => $load_form);
     }
     else{
     	$messageJson->data = array('status' => 0,'faild' => $faild_form, "success" => $succed_form, "load" => $load_form);
     }

     

}
catch (Exception $e)
{
$messageJson->status=300;
$messageJson->error=$e->getMessage();
}

}
else{
	$messageJson->data = array('status' => 0,'faild' => $faild_form, "success" => $succed_form, "load" => $load_form);
}

?>