import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../product/detail/product_detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List products = [];

  bool isLoading = true;

  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products/'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          products = data;
          isLoading = false;
          errorMessage = null;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load products';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // HEADER
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

                  const Icon(
                    Icons.grid_view_rounded,
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // PRODUCTS
              Expanded(
                child: buildProducts(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProducts() {
    // LOADING
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // ERROR
    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Icon(
              Icons.error_outline,
              size: 50,
              color: Colors.red,
            ),

            const SizedBox(height: 12),

            const Text(
              'Could not load products',

              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              errorMessage!,

              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                  errorMessage = null;
                });

                fetchProduct();
              },

              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    // EMPTY
    if (products.isEmpty) {
      return const Center(
        child: Text(
          'No products found',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
    }

    // PRODUCT GRID
    return GridView.builder(
      itemCount: products.length,

      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
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
              // IMAGE
              Expanded(
                child: Image.network(
                  product['image'],

                  width: double.infinity,

                  fit: BoxFit.contain,

                  loadingBuilder: (
                      context,
                      child,
                      loadingProgress,
                      ) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },

                  errorBuilder: (
                      context,
                      error,
                      stackTrace,
                      ) {
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

              // DETAILS
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  12,
                  11,
                  10,
                  12,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // TITLE
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

                    // PRICE + VIEW
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Rs ${product['price']}',

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
                                      ProductDetailPage(
                                        productsDetail: product,
                                      ),
                                ),
                              );
                            },

                            style: ElevatedButton.styleFrom(
                              elevation: 0,

                              backgroundColor:
                              Colors.deepOrange,

                              foregroundColor: Colors.white,

                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),

                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                            ),

                            child: const Text(
                              'View',

                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
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
    );
  }
}