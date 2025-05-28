<?php
include_once 'dbconnect_sakinah.php';
$query = $_GET['query'];

$sql = "SELECT * FROM product_items WHERE name LIKE '%$query%' OR description LIKE '%$query%' OR vendors LIKE '%$query%' OR kategori LIKE '%$query%' ";
$execute = mysqli_query($conn, $sql);

$searchProduct = array();
while($rows = $execute ->fetch_assoc()){
    $searchProduct[] = $rows;
}
echo json_encode($searchProduct);

?>