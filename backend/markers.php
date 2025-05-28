<?php
include_once'dbconnect_sakinah.php';
$stat = $conn->prepare("SELECT id, latitude, longitude, title, snippet FROM markers;");
$stat -> execute();
$stat -> bind_result($id, $latitude, $longitude, $title, $snippet);
$arrayproduct = array();
while ($stat -> fetch()){
    $dataproduct = array();
    $dataproduct ['id']= $id;
    $dataproduct ['latitude']= $latitude;
    $dataproduct ['longitude']= $longitude;
    $dataproduct ['title']= $title;
    $dataproduct ['snippet']= $snippet;
    array_push($arrayproduct, $dataproduct);
}
echo json_encode($arrayproduct);