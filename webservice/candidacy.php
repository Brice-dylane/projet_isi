<?php
include "config.php";
$return["error"] = false;
$return["msg"] = "";
$return["success"] = false;
$created = $_POST["created"];
$email = $_POST["email"];
$formation = $_POST["formation"];
$code = $_POST["code"];
$id_user = 0;
$id_formation = 0;
$id_file = 0;
//array to return

if(isset($_FILES["file"])){
    //directory to upload file
    $target_dir = "candidatures/"; //create folder files/ to save file
    $filename = $_FILES["file"]["name"]; 
    //name of file
    //$_FILES["file"]["size"] get the size of file
    $fileSize = $_FILES['file']['size'];

    if ($fileSize) {
        # code...
    }

    $savefile = "$target_dir/$filename";
    //complete path to save file

    if(move_uploaded_file($_FILES["file"]["tmp_name"], $savefile)) {
        $return["error"] = false;
        //upload successful
        $pdo=new PDO(URI_BASE_DONNEES, UTILISATEUR, MOT_DE_PASSE);
        $blob = fopen($savefile, 'rb');
//----------------------------------------------Insert File-----------------------------------------------------------------------------------------
        $sql = "INSERT INTO file(file_data,file_data_content_type,create_time,update_time) VALUES(:fileData,:fileDataContent,:create,:updateTime)";
        $stmt = $pdo->prepare($sql);

        $stmt->bindParam(':fileData', $blob, PDO::PARAM_LOB);
        $stmt->bindParam(':fileDataContent', $target_dir);
        $stmt->bindParam(':create', $created);
        $stmt->bindParam(':updateTime', $created);

        $stmt->execute();

//---------------------------------------------Insert candidancy----------------------------------------------------------------------------------

        $stmt1 = $pdo->prepare("SELECT id FROM file WHERE create_time=:createTime");
                        if ($stmt1->execute(array(':createTime'=>$created))) {
                            $row = $stmt1->fetchAll();
                            foreach ($row as $subsubarray) {
                                $id_file = $subsubarray['id'];
                            }
                                
                        }

        $stmt2 = $pdo->prepare("SELECT id FROM jhi_user WHERE login=:email");
                        if ($stmt2->execute(array(':email'=>$email))) {
                            $row = $stmt2->fetchAll();
                            foreach ($row as $subsubarray) {
                                $id_user = $subsubarray['id'];
                            }
                                
                        }

        $stmt3 = $pdo->prepare("SELECT id FROM formation WHERE formation_name=:nom");
                        if ($stmt3->execute(array(':nom'=>$formation))) {
                            $row = $stmt3->fetchAll();
                            foreach ($row as $subsubarray) {
                                $id_formation = $subsubarray['id'];
                            }
                                
                        }

        $sql2 = $pdo->prepare("INSERT INTO candidacy(candidacy_code,candidacy_state,create_time,update_time,file_id,user_id,formation_id) 
                         VALUES(:candidacy_code,:candidacy_state,:create_time,:update_time,:file_id,:user_id,:formation_id)");

                                   $stm2 = $sql2->execute(array(
                                                    ':candidacy_code' => $code,
                                                    ':candidacy_state' => 'LOAD',
                                                    ':create_time' => $created,
                                                    ':update_time' => $created,
                                                    ':file_id' => $id_file,
                                                    ':user_id' => $id_user,
                                                    ':formation_id' => $id_formation
                                                ));

                if ($stm2)
                        {
                            $return["error"] = true;
                            $return["msg"] =  "Error during saving candidacy.";
                        }
//--------------------------------------------------------------------------------------------------------------------------------------------

    }else{
        $return["error"] = true;
        $return["msg"] =  "Error during saving file.";
    }
}else{
    $return["error"] = true;
    $return["msg"] =  "No file is sublitted.";
}

header('Content-Type: application/json');
// tell browser that its a json data
echo json_encode($return);
//converting array to JSON string
?>