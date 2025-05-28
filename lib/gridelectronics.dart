import 'dart:convert';

import 'package:ecommerce_sakinah/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GridElectronic extends StatefulWidget {
  const GridElectronic({super.key});

  @override
  State<GridElectronic> createState() => _GridElectronicState();
}

class _GridElectronicState extends State<GridElectronic> {
  List<dynamic> electronicList = [];

  Future<void> getElectronic() async {
    String urlElectronis =
        'http://10.0.3.2/backend_ecommerce/electronicCategory.php';
    var response = await http.get(Uri.parse(urlElectronis));
    try {
      electronicList = jsonDecode(response.body);
      setState(() {
        electronicList = jsonDecode(response.body);
      });
    } catch (exc) {
      if (kDebugMode) {
        print(exc);
      }
    }
  }

  void onItemTap(int index) {
    final item = electronicList[index];
    if (kDebugMode) {
      print("Product Name ${item['name']}");
    }
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailElectronics(item: item)));
  }

  @override
  void initState() {
    super.initState();
    getElectronic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const HomeScreen()));
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 20,
              color: Colors.white,
            )),
        title: const Text(
          "Electronic Product",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
            itemCount: (electronicList.length),
            itemBuilder: (context, index) {
              final data = electronicList[index];
              return GestureDetector(
                onTap: () {
                  onItemTap(index);
                },
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                        data['images'],
                        height: 125,
                        width: 150,
                        // fit: BoxFit.fill,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            );
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Text(
                            "Error Loading Product Images",
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 12),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                        child: Text(
                          data['name'],
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Rp${data['price'].toString()}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Rp${data['promo'].toString()}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 255, 230, 0),
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class DetailElectronics extends StatelessWidget {
  final dynamic item;
  const DetailElectronics({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const GridElectronic()));
          },
        ),
        title: const Text(
          "Product Item",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Icon(
            CupertinoIcons.shopping_cart,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 5, 0),
            child: Image.network(
              item['images'],
              height: 400,
              width: 350,
              fit: BoxFit.fill,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  );
                }
              },
              errorBuilder: (context, error, stackTrace) {
                return const Text("Error Loading product images from server",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify);
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              "Product Description",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 20, 15),
            child: Text(
              item['description'],
              style: const TextStyle(
                  color: Color.fromARGB(199, 0, 0, 0),
                  fontSize: 13,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 15),
                child: Text(
                  'Rp${item['price'].toString()}',
                  style: const TextStyle(
                      color: Color.fromARGB(198, 4, 87, 25),
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 0, 15),
                child: Image.asset(
                  './lib/assets/bintang.jpg',
                  width: 20,
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 10, 15),
                child: Text(
                  'Rp${item['promo'].toString()}',
                  style: const TextStyle(
                      color: Color.fromARGB(197, 253, 0, 0),
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 40, 0, 0),
            child: SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "ADD TO CART",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
