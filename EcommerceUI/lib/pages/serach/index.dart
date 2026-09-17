import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../product/detail/product_detail.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List products = [];

  //this is search data vraiable
  List allProducts = [];

  final TextEditingController searchController = TextEditingController();

  bool isLoading = true;

  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  //this is search function
  void searchProduct(String searchValue){
    setState(() {


      if(searchValue.isEmpty){
        products = allProducts;
      }else{

        products = allProducts.where((product){


          final title = product["title"].toString().toLowerCase();
          return title.contains(searchValue.toLowerCase());

        }).toList();

      }


    });
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
          allProducts = data;
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
      appBar: AppBar(
        title: Text("Search",style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
      ),
      body: Padding(padding: EdgeInsetsGeometry.all(20),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: searchProduct,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search_outlined),
              hintText: "Search for ...",
              border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 20,),
         Expanded(child:  GridView.builder(
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
         ))
        ],
      ),


      ),
    );
  }

}




