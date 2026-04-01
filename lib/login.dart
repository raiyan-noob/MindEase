import 'package:firebase_auth/firebase_auth.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _setLight(bool value) {
    isLight.value = value;
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String message = "";
  bool isLoading = false;

  Future<void> login() async {
    final String email = emailController.text.trim();
    final String pass = passwordController.text.trim();

    if (email.isEmpty || pass.isEmpty) {
      setState(() {
        message = "Please fill all fields";
      });
      return;
    }

    setState(() {
      isLoading = true;
      message = "";
    });

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: pass);
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MyAppFirst(isLightNotifier: isLight, onThemeChanged: _setLight),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorText = "Login failed";
      if (e.code == 'user-not-found') {
        errorText = "No user found with this email";
      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        errorText = "Wrong email or password";
      } else if (e.code == 'invalid-email') {
        errorText = "Please enter a valid email";
      }

      setState(() {
        message = errorText;
      });
    } catch (_) {
      setState(() {
        message = "Something went wrong. Please try again";
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              //Email field
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Enter your email (eg. abc@gmail.com)",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide
                        .none, // Remove visible border but keep radius
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

              //pass field
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Enter your password.",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide
                        .none, // Remove visible border but keep radius
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
                  onPressed: isLoading ? null : login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(0, 152, 139, 1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    isLoading ? "Please wait..." : "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              if (message.isNotEmpty)
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (message.isNotEmpty) const SizedBox(height: 6),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
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
