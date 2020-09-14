<?php

require '../database.php';

$couleurs = [];
$sql = "SELECT * FROM couleur";
$stid = oci_parse($con, $sql);

oci_execute($stid);
if ($stid){
  while(($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)))
  {
    $couleur=new stdClass();

    $couleur->id_couleur = $row['ID_COULEUR'];
    $couleur->nom_couleur = $row['NOM_COULEUR'];

    $couleurs[] = $couleur;
  }

  echo json_encode($couleurs);

} else
{
  http_response_code(404);
}

?>