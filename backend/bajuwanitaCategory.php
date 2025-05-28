<?php
include_once'dbconnect_sakinah.php';
$stat = $conn->prepare("SELECT id, name, price, promo, description, images, stok, vendors, kategori  FROM product_items WHERE kategori = 'Baju Wanita';");
$stat -> execute();
$stat -> bind_result($id, $name, $price, $promo, $description, $images, $stok, $vendors, $kategori);
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
    $dataproduct ['kategori']= $kategori;
    array_push($arrayproduct, $dataproduct);
}
echo json_encode($arrayproduct);