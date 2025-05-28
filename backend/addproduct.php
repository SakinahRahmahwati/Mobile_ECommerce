<?php
include_once 'dbconnect_sakinah.php';
$name = $_POST['name'];
$price = $_POST['price'];
$promo = $_POST['promo'];
$description = $_POST['description'];
$images = $_POST['images'];
$stok = $_POST['stok'];
$vendors = $_POST['vendors'];
// if(!$name || !$price || !$promo || !$description || !$images){
if(!$name || !$price || !$promo || !$description || !$images || !$stok || !$vendors){
    echo json_encode(array('message'=>'required field is empty'));
}else{
    $query = "INSERT INTO product_items(name, price, promo, description, images, stok, vendors) VALUES('$name', '$price', '$promo', '$description', '$images', '$stok', '$vendors')";
    $exec = mysqli_query($conn, $query);
    if($exec){
        echo json_encode(array('message'=>'new product successfully to add'));
    }else{
        echo json_encode(array('message'=>'new product failed to add'));
    }
}


?>

