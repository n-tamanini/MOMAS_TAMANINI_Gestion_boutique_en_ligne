<?php

function connect(){
  $username="c##ESHOP_USER";
  $password="eshop";
  $connection_string="localhost/ORCL.UNICE.FR";
  $conn=oci_connect($username, $password, $connection_string);

  if($conn){
    echo "Connecté";
  } else {
    echo "Erreur de connexion";
  }
  return $conn;
}

$con = connect();

$stid = oci_parse($con, 'SELECT * FROM categorie');
oci_execute($stid);
echo "<h1>Tableau</h1>";
echo "<table>";
echo "<tr><th>ID_CATEGORIE</th><th>NOM_CATEGORIE</th></tr>";
while (($categorie = oci_fetch_array($stid, OCI_BOTH)) != false) {
  echo "<tr>";  
  echo "<td>".$categorie['ID_CATEGORIE']."</td>";
  echo "<td>".$categorie['NOM_CATEGORIE']."</td>";
  echo "</tr>";
}
echo "</table>";

?>
