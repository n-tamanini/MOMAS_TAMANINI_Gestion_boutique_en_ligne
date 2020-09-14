<?php

require '../database.php';

$categories = [];
$sql = "SELECT * FROM categorie";
$stid = oci_parse($con, $sql);

oci_execute($stid);
if ($stid){
  while(($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)))
  {
    $categorie=new stdClass();
    $categorie->id_categorie = $row['ID_CATEGORIE'];
    $categorie->nom_categorie = $row['NOM_CATEGORIE'];
    $categories[] = $categorie;
  }
  echo json_encode($categories);

} else
{
  http_response_code(404);
}

?>