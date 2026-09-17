import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/main.dart';
import 'package:testing/pages/auth/login/index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {








  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   checkLogin();
  }



  void checkLogin()async{
    final session = await SharedPreferences.getInstance();

    final checkLogin = session.getBool('checkLogin') ?? false;
    Timer(Duration(seconds: 4), (){

      if(!mounted) return;

      if(checkLogin == true){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }


    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Row(
            mainAxisAlignment: .center,
            children: [
              Text("FACI",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
              Text("O",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),
            ],
          ),
        ),
      ),
    );
  }
}

