<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: PUT, GET, POST, DELETE");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
//header('Content-Type: application/json; charset=utf-8');

function connect(){
  $username="c##ESHOP_USER";
  $password="eshop";
  $connection_string="localhost/ORCL.UNICE.FR";
  $conn=oci_connect($username, $password, $connection_string);

  return $conn;
}

$con = connect();

/*
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
*/
?>
