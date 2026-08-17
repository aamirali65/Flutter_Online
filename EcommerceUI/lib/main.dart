import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Shop',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B5FEF),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Wireless Headphones',
      'price': '\$49.99',
      'image':
      'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800',
    },
    {
      'name': 'Smart Watch',
      'price': '\$79.99',
      'image':
      'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800',
    },
    {
      'name': 'Running Shoes',
      'price': '\$64.99',
      'image':
      'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800',
    },
    {
      'name': 'Backpack',
      'price': '\$39.99',
      'image':
      'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800',
    },
    {
      'name': 'Sunglasses',
      'price': '\$29.99',
      'image':
      'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=800',
    },
    {
      'name': 'Sneakers',
      'price': '\$59.99',
      'image':
      'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

      // APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,

        title: const Text(
          'Online Shop',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.black87,
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.black87,
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person_outline_rounded,
              color: Colors.black87,
            ),
          ),

          const SizedBox(width: 8),
        ],
      ),

      // BODY
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

                   Icon(
                     Icons.grid_view_rounded
                   )
                  ],
                ),

                const SizedBox(height: 14),

                // PRODUCT GRID
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

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

                          // PRODUCT IMAGE
                          Expanded(
                            child: Image.network(
                              product['image'],
                              width: double.infinity,
                              fit: BoxFit.cover,

                              errorBuilder:
                                  (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade100,
                                  child: const Center(
                                    child: Icon(
                                      Icons
                                          .image_not_supported_outlined,
                                      size: 40,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // PRODUCT DETAILS
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              12,
                              11,
                              10,
                              12,
                            ),

                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [

                                // NAME
                                Text(
                                  product['name'],
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
                                        product['price'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 34,

                                      child: ElevatedButton(
                                        onPressed: () {},

                                        style:
                                        ElevatedButton.styleFrom(
                                          elevation: 0,

                                          padding:
                                          const EdgeInsets
                                              .symmetric(
                                            horizontal: 12,
                                          ),

                                          shape:
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),

                                        child: const Text(
                                          'Buy',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight:
                                            FontWeight.w700,
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

      // BOTTOM NAVIGATION
      bottomNavigationBar: NavigationBar(
        height: 72,
        backgroundColor: Colors.white,

        indicatorColor: Theme.of(context)
            .colorScheme
            .primary
            .withOpacity(0.12),

        selectedIndex: selectedIndex,

        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart_rounded),
            label: 'Cart list',
          ),

          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}