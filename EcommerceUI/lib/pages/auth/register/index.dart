import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/pages/auth/login/index.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //input controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var hidePass = true;



  //user ko register karna ka function
  void registerUser()async{
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if(name.isEmpty || email.isEmpty || password.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Kindly Fill all the inputs"))
      );

      return;
    }




    final session = await SharedPreferences.getInstance();
    await session.setString('name', name);
    await session.setString('email', email);
    await session.setString('pass', password);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("User Register Successfully"))
    );

    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

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
              controller: nameController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "Write your name",
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 20,),
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
              controller: passwordController,
              obscureText: hidePass,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {

                      if(hidePass == true){
                        hidePass= false;
                      }else{
                        hidePass = true;
                      }

                    });
                  }, icon: Icon(Icons.remove_red_eye_outlined)),
                  labelText: "Write your password",
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: registerUser,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 20),),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: .center,
              children: [
                Text("already have an account? "),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    },
                    child: Text("Sign in",style: TextStyle(color: Colors.deepOrange),))
              ],
            )
          ],
        ),
      ),
    );
  }
}
