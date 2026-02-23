import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splash_design/1stpage.dart';
import 'package:splash_design/sign.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final ValueNotifier<bool> isLight = ValueNotifier<bool>(true);

  void _setLight(bool value) {
    isLight.value = value;
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String message = "";

  void login(){
    String email = emailController.text;
    String pass = passwordController.text;

    if(email.isEmpty || pass.isEmpty){
      setState(() {
        message = "Please fill all fields";
      });
    }
    // else if (email == "admin@gmail.com" && pass == "1234") {
    //   setState(() {
    //     message = "Login Successful!";
    //   });
    //
    //     Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppFirst(isLightNotifier: isLight, onThemeChanged: _setLight)));
    // }
    else {
      setState(() {
        message = "Login Successful!"; //for development purposes no checking of email and pass
      });
      email = "";
      pass = "";
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppFirst(isLightNotifier: isLight, onThemeChanged: _setLight)));
      message = "";
    }
    // else {
    //   setState(() {
    //     message = "Invalid email or password";
    //   });
    // }
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Email field
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Enter your email (eg. abc@gmail.com)",
                border: OutlineInputBorder()
              ),
            ),

            const SizedBox(height: 20),

            //pass field
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Enter your password.",
                border: OutlineInputBorder()
              ),
            ),

            const SizedBox(height: 20),

            //login button

            ElevatedButton(
                onPressed: login,
                child: const Text("Login")
            ),

            const SizedBox(height: 20),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                const SizedBox(width: 5),
                TextButton(
                    onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                }, child: const Text("Sign Up")
                )
              ],
            ),


            const SizedBox(height: 20),

            //message box

            Text(
              message,
              style: const TextStyle(
                color: Colors.deepOrange,
                fontSize: 16,
              ),
            ),


          ],
        ),
      ),
    );
  }
}