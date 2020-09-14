<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: PUT, GET, POST, DELETE");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Content-Type: application/json; charset=utf-8');

function connect(){
  $username="c##ESHOP_USER";
  $password="eshop";
  $connection_string="localhost/ORCL.UNICE.FR";
  $conn=oci_connect($username, $password, $connection_string);

  return $conn;
}

$con = connect();
?>
