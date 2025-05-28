import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_sakinah/addproduct.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({super.key});

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  @override
  void initState() {
    super.initState();
    getAllProduct();
  }

  final TextEditingController searchController = TextEditingController();
  List allProductList = [];

  Future<void> getAllProduct() async {
    String urlAllProduct = "http://10.0.3.2/backend_ecommerce/listproduct.php";
    var response = await http.get(Uri.parse(urlAllProduct));
    try {
      setState(() {
        allProductList = jsonDecode(response.body);
      });
    } catch (exc) {
      if (kDebugMode) {
        print(exc);
      }
    }
  }

  Future<void> searchProduct() async {
    String urlSearchProduct =
        "http://10.0.3.2/backend_ecommerce/searchproduct.php?query=${searchController.text}";
    try {
      var responseSearch = await http.get(Uri.parse(urlSearchProduct));
      final List bodySearch = json.decode(responseSearch.body);
      setState(() {
        allProductList = bodySearch;
      });
    } catch (exc) {
      if (kDebugMode) {
        print(exc);
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    String urlDeleteProduct =
        "http://10.0.3.2/backend_ecommerce/deleteproduct.php";
    try {
      var resDeleteProduct =
          await http.post(Uri.parse(urlDeleteProduct), body: {"id": id});
      var bodyDelete = json.decode(resDeleteProduct.body);
      if (bodyDelete['Success'] == "true") {
        if (kDebugMode) {
          print("Delete Product Successful");
        }
      } else {
        if (kDebugMode) {
          print("Delete Product Failed");
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
        leading: const Icon(
          Icons.menu,
          size: 20,
          color: Colors.white,
        ),
        title: const Text(
          "E COMMERCE",
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
              Icons.notifications_none,
              size: 22,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(3, 10, 3, 0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Cari Produk",
                hintText: "Masukkan nama produk",
                hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                labelStyle: const TextStyle(
                    color: Colors.orange,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.orange),
                  onPressed: () {
                    searchProduct();
                  },
                ),
                filled: true,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 2, style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allProductList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(3),
                    child: ListTile(
                      leading: ClipOval(
                        child: Image.network(
                          height: 130.0,
                          width: 70.0,
                          '${allProductList[index]['images']}',
                          fit: BoxFit.fill,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              );
                            }
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Text(
                                "Error Loading product images from server",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.justify);
                          },
                        ),
                      ),
                      title: Text(
                        allProductList[index]['name'],
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              allProductList[index]['description'],
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Vendor :' '${allProductList[index]['vendors']}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Text(
                                  'Harga Rp :'
                                  '${allProductList[index]['price']}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Stok: ${allProductList[index]['stok']}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      trailing: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              deleteProduct(
                                  allProductList[index]['id'].toString());
                              getAllProduct();
                            },
                            child: const Icon(
                              CupertinoIcons.delete_solid,
                              size: 18,
                              color: Colors.orangeAccent,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const InkWell(
                            onTap: null,
                            child: Icon(
                              CupertinoIcons.upload_circle,
                              size: 18,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const AddNewProduct()));
        },
        mini: true,
        splashColor: Colors.orangeAccent.shade200,
        backgroundColor: Colors.orangeAccent.shade400,
        child: const Icon(
          Icons.add,
          size: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}
