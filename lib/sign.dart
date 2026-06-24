import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splash_design/login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String message = "";
  bool isLoading = false;

  Future<void> signup() async {
    final String fullName = fullNameController.text.trim();
    final String phoneNumber = phoneNumberController.text.trim();
    final String email = emailController.text.trim();
    final String age = ageController.text.trim();
    final String gender = genderController.text.trim();
    final String password = passwordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();

    if (fullName.isEmpty ||
        phoneNumber.isEmpty ||
        email.isEmpty ||
        age.isEmpty ||
        gender.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      setState(() {
        message = "Please fill all fields";
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        message = "Passwords do not match";
      });
      return;
    }

    if (password.length < 6) {
      setState(() {
        message = "Password must be at least 6 characters";
      });
      return;
    }

    setState(() {
      isLoading = true;
      message = "";
    });

    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final User? user = userCredential.user;
      if (user != null) {
        try {
          await _firestore.collection('users').doc(user.uid).set({
            'uid': user.uid,
            'fullName': fullName,
            'phoneNumber': phoneNumber,
            'email': email,
            'age': age,
            'gender': gender,
            'createdAt': FieldValue.serverTimestamp(),
          });
        } on FirebaseException catch (e) {
          debugPrint('Firestore profile save error: ${e.code} ${e.message}');
          String detail = "Account created, but profile save failed";
          if (e.code == 'permission-denied') {
            detail = "Account created, but Firestore rules blocked the save";
          } else if (e.code == 'unavailable') {
            detail = "Account created, but no internet to save profile";
          } else if (e.code == 'network-request-failed') {
            detail = "Account created, but no internet to save profile";
          }
          setState(() {
            message = detail;
          });
          return;
        }
      }

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint('Signup auth error: ${e.code} ${e.message}');
      String errorText = e.toString();
      if (e.code == 'email-already-in-use') {
        errorText = "This email is already registered";
      } else if (e.code == 'invalid-email') {
        errorText = "Please enter a valid email";
      } else if (e.code == 'weak-password') {
        errorText = "Password is too weak";
      } else if (e.code == 'operation-not-allowed') {
        errorText = "Enable Email/Password in Firebase Auth";
      } else if (e.code == 'network-request-failed') {
        errorText = "No internet connection";
      } else if (e.code == 'too-many-requests') {
        errorText = "Too many attempts. Try again later";
      }

      setState(() {
        message = errorText;
      });
    } catch (e) {
      debugPrint('Signup unknown error: $e');
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
    fullNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    ageController.dispose();
    genderController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
              const SizedBox(height: 30),
              //image here
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/newLogoremovebg.png',
                  width: 220,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "MindEase",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "Where you become your own healer",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              //Full name field
              TextField(
                controller: fullNameController,
                decoration: const InputDecoration(
                  labelText: "Enter your full name",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
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
              //Phone number field
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  labelText: "Enter your phone number",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
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
              //Email field
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Enter your email (eg. abc@gmail.com)",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
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
              //Age field
              TextField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: "Enter your age",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
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
              //Gender field
              TextField(
                controller: genderController,
                decoration: const InputDecoration(
                  labelText: "Enter your gender",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
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
              //Password field
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Enter your password",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
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
              //Confirm password field
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Confirm your password",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
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
              //Signup button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00988B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    isLoading ? "Please wait..." : "Signup",
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
                    "Already have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Text(
                      "login.",
                      style: TextStyle(
                        color: Color(0xFF00988B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
