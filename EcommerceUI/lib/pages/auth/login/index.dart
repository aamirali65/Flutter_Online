import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/main.dart';
import 'package:testing/pages/auth/register/index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //controllers
  final emailController = TextEditingController();
  final passController = TextEditingController();


  void loginUser()async{

    //this is input email
    final localEmail = emailController.text.trim();
    final localPass = passController.text.trim();

    //this is session email
    final Session = await SharedPreferences.getInstance();
    final sessionEmail = Session.getString('email');
    final sessionPass = Session.getString('pass');



    //empty input check
    if(localEmail.isEmpty || localEmail.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Kindly Fill All the Fields!"))
      );
      return;
    }



    //condition

    if(localEmail == sessionEmail && localPass == sessionPass){
      await Session.setBool('checkLogin', true);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }else{

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email and Password is Incorrect!"))
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              "FACIO",
              style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50,),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: "Write your email",
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: passController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  labelText: "Write your password",
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: .end,
              children: [
                Text("Forget password?",style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.w500),)
              ],
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: loginUser,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 20),),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: .center,
              children: [
                Text("Don't have an account? "),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                    },
                    child: Text("Sign up",style: TextStyle(color: Colors.deepOrange),))
              ],
            )
          ],
        ),
      ),
    );
  }
}
