import 'package:ecommerce_sakinah/homescreen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController onboardingController = PageController();
  int indexPage = 0;
  List<Map<String, String>> onboardPageData = [
    {
      "title": "Sakinah Store",
      "image":
          "https://assets.bmdstatic.com/web/image?model=product.product&field=image_1024&id=128847&unique=123ef24",
      "subtitle": "Welcome to our online shop"
    },
    {
      "title": "Products Up To Date",
      "image":
          "https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/e3cc2305-65bb-4824-b4bd-9474386f6656/WMNS+NIKE+P-6000.png",
      "subtitle": "Products with the latest models"
    },
    {
      "title": "Lots of Promotions",
      "image":
          "https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/49f0723a-abfe-4e31-b5a5-26c09ee0afe9/NIKE+ZOOMX+VAPORFLY+NEXT%25+3.png",
      "subtitle": "Look forward to attractive promos every day"
    },
    {
      "title": "Cheap Prices",
      "image":
          "https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/952db200-8bfc-467c-b5f4-24cb1eae0dfb/AS+W+NSW+NK+CHLL+KNT++MRIB+LS.png",
      "subtitle": "Cheap prices with quality products"
    },
    {
      "title": "Get Started",
      "image":
          "https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/2c88a2a6-615b-4eed-ba06-a460410287b3/AS+M+NK+TCH+FLC+FZ+WR+HOODIE.png",
      "subtitle": "Let's get started shopping product with our store"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: onboardingController,
              onPageChanged: (page) {
                setState(() {
                  indexPage = page;
                });
              },
              itemCount: onboardPageData.length,
              itemBuilder: (context, index) {
                return OnboardingData(
                  title: onboardPageData[index]['title']!,
                  image: onboardPageData[index]['image']!,
                  subtitle: onboardPageData[index]['subtitle']!,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                indexPage == onboardPageData.length - 1
                    ? TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        },
                        child: const Text(
                          "Get Started",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ))
                    : const Text(''),
                Row(
                  children: List.generate(
                    onboardPageData.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: indexPage == index ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 20,
                  ),
                  onPressed: () {
                    if (indexPage == onboardPageData.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    } else {
                      onboardingController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingData extends StatelessWidget {
  final String title;
  final String image;
  final String subtitle;
  const OnboardingData(
      {super.key,
      required this.title,
      required this.image,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.network(
          image,
          height: 350,
          width: 300,
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
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 17,
                color: Colors.grey,
                fontWeight: FontWeight.normal),
          ),
        )
      ],
    );
  }
}
