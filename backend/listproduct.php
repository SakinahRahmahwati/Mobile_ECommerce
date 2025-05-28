<?php
include_once'dbconnect_sakinah.php';
$stat = $conn->prepare("SELECT id, name, price, promo, description, images, stok, vendors  FROM product_items;");
$stat -> execute();
$stat -> bind_result($id, $name, $price, $promo, $description, $images, $stok, $vendors);
$arrayproduct = array();
while ($stat -> fetch()){
    $dataproduct = array();
    $dataproduct ['id']= $id;
    $dataproduct ['name']= $name;
    $dataproduct ['price']= $price;
    $dataproduct ['promo']= $promo;
    $dataproduct ['description']= $description;
    $dataproduct ['images']= $images;
    $dataproduct ['stok']= $stok;
    $dataproduct ['vendors']= $vendors;
    array_push($arrayproduct, $dataproduct);
}
echo json_encode($arrayproduct);