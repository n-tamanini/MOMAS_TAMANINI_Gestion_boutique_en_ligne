<?php

require '../database.php';

$declinaisons = [];
$sql = "SELECT * FROM declinaison_vetement";
$stid = oci_parse($con, $sql);

oci_execute($stid);
if ($stid){
  while(($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)))
  {
    $declinaison=new stdClass();

    $declinaison->id_declinaison = $row['ID_DECLINAISON'];

    $sql_couleur = "SELECT id_couleur, nom_couleur FROM couleur WHERE ID_COULEUR={$row['ID_COULEUR']}";
    $stid_couleur = oci_parse($con, $sql_couleur);
    oci_execute($stid_couleur);
    if ($stid_couleur){
      while(($row_couleur = oci_fetch_array($stid_couleur, OCI_ASSOC+OCI_RETURN_NULLS)))
      {
        $declinaison->couleur = new stdClass();
        $declinaison->couleur->id_couleur = $row_couleur['ID_COULEUR'];
        $declinaison->couleur->nom_couleur = $row_couleur['NOM_COULEUR'];
      }
    }

    $sql_vetement = "SELECT id_vetement,id_categorie,nom_vetement,description_vetement FROM vetement WHERE ID_VETEMENT={$row['ID_VETEMENT']}";
    $stid_vetement = oci_parse($con, $sql_vetement);
    oci_execute($stid_vetement);
    
    if ($stid_vetement){
      while(($row_vetement = oci_fetch_array($stid_vetement, OCI_ASSOC+OCI_RETURN_NULLS)))
      {
        $declinaison->vetement = new stdClass();
        $declinaison->vetement->id_vetement = $row_vetement['ID_VETEMENT'];
        $declinaison->vetement->id_categorie = $row_vetement['ID_CATEGORIE'];
       /* $declinaison->vetement->nom_vetement = htmlentities($row_vetement['NOM_VETEMENT']);
        $declinaison->vetement->description_vetement = htmlentities($row_vetement['DESCRIPTION_VETEMENT']);*/
      }
    }

    $declinaison->id_taille = $row['ID_TAILLE'];
    $declinaison->prix_declinaison = $row['PRIX_DECLINAISON'];
    $declinaison->quantite_declinaison = $row['QUANTITE_DECLINAISON'];

    $declinaisons[] = $declinaison;
  }

  echo json_encode($declinaisons);


} else
{
  http_response_code(404);
}

?>