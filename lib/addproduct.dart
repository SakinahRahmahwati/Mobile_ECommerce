import 'dart:convert';
// import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'allproduct.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final _name = TextEditingController();
  final _price = TextEditingController();
  final _description = TextEditingController();
  final _promo = TextEditingController();
  final _images = TextEditingController();
  final _stock = TextEditingController();
  final _vendor = TextEditingController();

  Future<void> addNewProduct() async {
    String urlAddPoduct = 'http://10.0.3.2/backend_ecommerce/addproduct.php';
    try {
      var responseAddProduct = await http.post(Uri.parse(urlAddPoduct), body: {
        "name": _name.text.toString(),
        "price": _price.text.toString(),
        "promo": _promo.text.toString(),
        "description": _description.text.toString(),
        "images": _images.text.toString(),
        "stok": _stock.text.toString(),
        "vendors": _vendor.text.toString(),
      });
      var bodyAdd = json.decode(responseAddProduct.body);
      if (bodyAdd == "true") {
        if (kDebugMode) {
          print("New Product Succesfully Added");
        }
      } else {
        if (kDebugMode) {
          print("New Product Failed to Added");
        }
      }
    } catch (exc) {
      if (kDebugMode) {
        print(exc);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const AllProduct()));
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 20,
              color: Colors.white,
            )),
        title: const Text(
          "Add New Product",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined,
                size: 20, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.home,
              size: 22,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(


                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: TextField(
                  controller: _name,
                  decoration: InputDecoration(
                    labelText: "Entri Nama Barang",
                    hintText: "entri nama barang",
                    hintStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    labelStyle: const TextStyle(
                        color: Colors.orange,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    prefixIcon: const Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Icon(Icons.add_box_outlined, color: Colors.orange),
                    ),
                    filled: true,
                    fillColor: Colors.orange.shade50,
                    border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  controller: _vendor,
                  decoration: InputDecoration(
                    labelText: "Entri Vendor Barang",
                    hintText: "entri vendor",
                    hintStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    labelStyle: const TextStyle(
                        color: Colors.orange,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    prefixIcon: const Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Icon(Icons.add_box_outlined,
                          size: 20, color: Colors.orange),
                    ),
                    filled: true,
                    fillColor: Colors.orange.shade50,
                    border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  controller: _stock,
                  decoration: InputDecoration(
                    labelText: "Entri Stok Barang",
                    hintText: "entri stok",
                    hintStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    labelStyle: const TextStyle(
                        color: Colors.orange,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    prefixIcon: const Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Icon(Icons.add_box_outlined,
                          size: 20, color: Colors.orange),
                    ),
                    filled: true,
                    fillColor: Colors.orange.shade50,
                    border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  controller: _price,
                  decoration: InputDecoration(
                    labelText: "Entri Harga Barang",
                    hintText: "entri harga",
                    hintStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    labelStyle: const TextStyle(
                        color: Colors.orange,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    prefixIcon: const Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Icon(Icons.price_change_outlined,
                          size: 20, color: Colors.orange),
                    ),
                    filled: true,
                    fillColor: Colors.orange.shade50,
                    border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  controller: _promo,
                  decoration: InputDecoration(
                    labelText: "Entri Promo Harga",
                    hintText: "entri promo",
                    hintStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    labelStyle: const TextStyle(
                        color: Colors.orange,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    prefixIcon: const Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Icon(Icons.add_box_outlined,
                          size: 20, color: Colors.orange),
                    ),
                    filled: true,
                    fillColor: Colors.orange.shade50,
                    border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  controller: _description,
                  decoration: InputDecoration(
                    labelText: "Entri Deskripsi Barang",
                    hintText: "entri deskripsi",
                    hintStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    labelStyle: const TextStyle(
                        color: Colors.orange,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    prefixIcon: const Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Icon(Icons.add_box_outlined,
                          size: 20, color: Colors.orange),
                    ),
                    filled: true,
                    fillColor: Colors.orange.shade50,
                    border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: TextField(
                  controller: _images,
                  decoration: InputDecoration(
                    labelText: "Entri URL Gambar",
                    hintText: "entri url gambar",
                    hintStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    labelStyle: const TextStyle(
                        color: Colors.orange,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    prefixIcon: const Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Icon(Icons.image_outlined,
                          size: 20, color: Colors.orange),
                    ),
                    filled: true,
                    fillColor: Colors.orange.shade50,
                    border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    addNewProduct();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllProduct()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Add Product",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
