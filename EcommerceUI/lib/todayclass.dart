import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodayClass extends StatefulWidget {
  const TodayClass({super.key});

  @override
  State<TodayClass> createState() => _TodayClassState();
}

class _TodayClassState extends State<TodayClass> {

  String name = "";
  int age = 0;
  int phone = 0;

  storeValue()async{
    final storeValue = await SharedPreferences.getInstance();
    storeValue.setString("name", "Aamir");
    storeValue.setInt("age", 20);
    storeValue.setInt("phone", 0312345678);
  }


  showValue()async{
    final getValue = await SharedPreferences.getInstance();
    setState(() {
      name = getValue.getString("name") ?? "No user found";
      age = getValue.getInt("age") ?? 0;
      phone = getValue.getInt("phone") ?? 0;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Session Or Cache Memory"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Text("Your name is : $name",style: TextStyle(
              fontSize: 30
            ),),
            Text("Your age is : $age",style: TextStyle(
                fontSize: 30
            ),),
            Text("Your phone is : $phone",style: TextStyle(
                fontSize: 30
            ),),
            SizedBox(height: 30,),
            TextButton(onPressed: (){
              showValue();
            }, child: Text("Get Data",style: TextStyle(fontSize: 25),)),
            TextButton(onPressed: (){
              storeValue();
            }, child: Text("Set Data",style: TextStyle(fontSize: 25)))
          ],
        ),
      ),
    );
  }
}
