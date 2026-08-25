import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            spacing: 50,
            children: [
              Row(
                spacing: 20,
                crossAxisAlignment: .end,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(10),
                      child: Image.network(
                        fit: BoxFit.cover,
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxaIL4nwmeazsAV7eW2moBeG86clAn8Qg0DDmFLIOPj0VWD3Q7KsH7XaPf&s=10",
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text("Mens Watch",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                      Text("Mens Watch",style: TextStyle(
                          fontSize: 15,
                      ),),
                      SizedBox(height: 50,),
                      Text("Rs. 200",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(100)
                        ),
                        child: Center(
                          child: Text("-",style: TextStyle(fontSize: 20),),
                        ),
                      ),
                      Text("1",style: TextStyle(
                        color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold
                      ),),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Center(
                          child: Text("+",style: TextStyle(fontSize: 20),),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                spacing: 20,
                crossAxisAlignment: .end,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(10),
                      child: Image.network(
                        fit: BoxFit.cover,
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxaIL4nwmeazsAV7eW2moBeG86clAn8Qg0DDmFLIOPj0VWD3Q7KsH7XaPf&s=10",
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text("Mens Watch",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                      Text("Mens Watch",style: TextStyle(
                        fontSize: 15,
                      ),),
                      SizedBox(height: 50,),
                      Text("Rs. 200",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Center(
                          child: Text("-",style: TextStyle(fontSize: 20),),
                        ),
                      ),
                      Text("1",style: TextStyle(
                          color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold
                      ),),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Center(
                          child: Text("+",style: TextStyle(fontSize: 20),),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
