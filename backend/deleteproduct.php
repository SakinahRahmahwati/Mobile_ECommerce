<?php
include_once 'dbconnect_sakinah.php';

if (isset($_POST["id"])){
    $id = $_POST["id"];
}else{
    return;
}

$query = "DELETE FROM product_items WHERE id= '$id'";
$execute = mysqli_query($conn, $query);
$arrproduct = [];

if ($execute){
    $arrproduct ["Success"] = true;
}else{
    $arrproduct["Success"] = false;
}

echo json_encode($arrproduct);

?>