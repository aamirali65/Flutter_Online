import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../product_detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //array variable where api data store
    List products = [];

    //api function
    void fetchProduct() async {
      final response = await http.get(
        Uri.parse("https://fakestoreapi.com/products/"),
      );

      setState(() {
        products = jsonDecode(response.body);
      });
    }

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      fetchProduct();
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // POPULAR PRODUCTS HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recommendation',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    Icon(Icons.grid_view_rounded),
                  ],
                ),

                const SizedBox(height: 14),

                // PRODUCT GRID
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: products.length,

                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.67,
                  ),

                  itemBuilder: (context, index) {
                    final product = products[index];

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),

                      clipBehavior: Clip.antiAlias,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // PRODUCT IMAGE
                          Expanded(
                            child: Image.network(
                              product['image'],
                              width: double.infinity,
                              fit: BoxFit.contain,

                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade100,
                                  child: const Center(
                                    child: Icon(
                                      Icons.image_not_supported_outlined,
                                      size: 40,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // PRODUCT DETAILS
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 11, 10, 12),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                // NAME
                                Text(
                                  product['title'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,

                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                const SizedBox(height: 9),

                                // PRICE + BUY BUTTON
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Rs ${product['price']}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 34,

                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailPage(productsDetail: product,),
                                            ),
                                          );
                                        },

                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,

                                          backgroundColor: Colors.deepOrange,

                                          foregroundColor: Colors.white,

                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),

                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),

                                        child: const Text(
                                          'View',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
