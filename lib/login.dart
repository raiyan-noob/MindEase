import 'package:flutter/material.dart';
import 'package:splash_design/1stpage.dart';
import 'package:splash_design/sign.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ValueNotifier<bool> isLight = ValueNotifier<bool>(true);

  void _setLight(bool value) {
    isLight.value = value;
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String message = "";

  void login() {
    String email = emailController.text;
    String pass = passwordController.text;

    if (email.isEmpty || pass.isEmpty) {
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
        message =
            "Login Successful!"; //for development purposes no checking of email and pass
      });
      email = "";
      pass = "";
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MyAppFirst(isLightNotifier: isLight, onThemeChanged: _setLight),
        ),
      );
      message = "";
    }
    // else {
    //   setState(() {
    //     message = "Invalid email or password";
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              //image here
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/loginbanner.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "Your safe space is waiting.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              //Email field
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Enter your email (eg. abc@gmail.com)",
                  labelStyle: TextStyle(
                      color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none, // Remove visible border but keep radius
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xFFF0F0F0),
                ),
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              //pass field
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Enter your password.",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none, // Remove visible border but keep radius
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xFFF0F0F0),
                ),
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 20),

              //login button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00988B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      "Don't have an account?",
                  style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 5),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xFF00988B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              //
              // const SizedBox(height: 10),
              //
              // //message box
              // Text(
              //   message,
              //   style: const TextStyle(color: Colors.deepOrange, fontSize: 16),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
