import 'dart:async';
import 'dart:convert';

import 'package:ecommerce_sakinah/gridbajupria.dart';
import 'package:ecommerce_sakinah/gridbajuwanita.dart';
import 'package:ecommerce_sakinah/gridelectronics.dart';
import 'package:ecommerce_sakinah/gridsepatupria.dart';
import 'package:ecommerce_sakinah/gridsepatuwanita.dart';
import 'package:ecommerce_sakinah/onboardingscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  PageController bannerController = PageController();
  Timer? timer;
  int indexBanner = 0;
  List listAllProduct = [];

  Future<void> getAllProduct() async {
    String urlAllProduct = "http://10.0.3.2/backend_ecommerce/listproduct.php";
    try {
      var response = await http.get(Uri.parse(urlAllProduct));
      listAllProduct = jsonDecode(response.body);
      setState(() {
        listAllProduct = jsonDecode(response.body);
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
        listAllProduct = bodySearch;
      });
    } catch (exc) {
      if (kDebugMode) {
        print(exc);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    bannerController.addListener(() {
      setState(() {
        indexBanner = bannerController.page?.round() ?? 0;
      });
    });
    onboardBanner();
    getAllProduct();
  }

  void onboardBanner() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (indexBanner < 3) {
        indexBanner++;
      } else {
        indexBanner = 0;
      }
      bannerController.animateToPage(indexBanner,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> bannerList = [
      './lib/assets/onboard1.jpg',
      './lib/assets/onboard2.jpg',
      './lib/assets/onboard3.jpg',
      './lib/assets/onboard4.jpg',
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const OnboardingScreen()));
          },
        ),
        title: const Text(
          "Home Screen ",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search Product",
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    searchProduct();
                  },
                ),
                suffixIcon: const Icon(Icons.filter_list),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 239, 206),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 130,
              child: PageView.builder(
                controller: bannerController,
                itemCount: bannerList.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    bannerList[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const GridElectronic()));
                        },
                        child: SizedBox(
                          width: 50,
                          height: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('./lib/assets/responsive.png',
                                  width: 40, height: 40, fit: BoxFit.cover),
                              const SizedBox(height: 5),
                              const Text(
                                'Elektronik',
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const GridBajuWanita()));
                        },
                        child: SizedBox(
                          width: 50,
                          height: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('./lib/assets/dress.png',
                                  width: 40, height: 40, fit: BoxFit.cover),
                              const SizedBox(height: 5),
                              const Text(
                                'Baju Wanita',
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const GridSepatuPria()));
                        },
                        child: SizedBox(
                          width: 50,
                          height: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('./lib/assets/smart-shoe.png',
                                  width: 40, height: 40, fit: BoxFit.cover),
                              const SizedBox(height: 5),
                              const Text(
                                'Sepatu Pria',
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const GridBajuPria()));
                        },
                        child: SizedBox(
                          width: 50,
                          height: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('./lib/assets/tshirt.png',
                                  width: 40, height: 40, fit: BoxFit.cover),
                              const SizedBox(height: 5),
                              const Text(
                                'Baju Pria',
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const GridSepatuWanita()));
                        },
                        child: SizedBox(
                          width: 50,
                          height: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('./lib/assets/high-heels.png',
                                  width: 40, height: 40, fit: BoxFit.cover),
                              const SizedBox(height: 5),
                              const Text(
                                'Sepatu Wanita',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "All Product List",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 600,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0),
                  itemCount: listAllProduct.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = listAllProduct[index];
                    return GestureDetector(
                      onTap: () {},
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              item['images'],
                              height: 100,
                              width: 120,
                              // fit: BoxFit.fill,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
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
                                item['name'],
                                style: const TextStyle(
                                    fontSize: 11,
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
                                    'Rp${item['price'].toString()}',
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Rp${item['promo'].toString()}',
                                    style: const TextStyle(
                                        fontSize: 10,
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
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
