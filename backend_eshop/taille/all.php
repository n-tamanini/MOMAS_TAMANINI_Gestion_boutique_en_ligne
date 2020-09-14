<?php

require '../database.php';

$tailles = [];
$sql = "SELECT * FROM taille";
$stid = oci_parse($con, $sql);

oci_execute($stid);
if ($stid){
  while(($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)))
  {
    $taille=new stdClass();

    $taille->id_taille = $row['ID_TAILLE'];
    $taille->nom_taille = $row['NOM_TAILLE'];

    $tailles[] = $taille;
  }

  echo json_encode($tailles);

} else
{
  http_response_code(404);
}

?>