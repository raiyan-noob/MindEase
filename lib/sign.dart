import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splash_design/login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController =  TextEditingController();
  final TextEditingController passwordController =  TextEditingController();
  final TextEditingController confirmPasswordController =  TextEditingController();

  String message = "";

  void signup() {
    String fullName = fullNameController.text;
    String phoneNumber = phoneNumberController.text;
    String email = emailController.text;
    String age = ageController.text;
    String gender = genderController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if(fullName.isEmpty || phoneNumber.isEmpty || email.isEmpty
        || age.isEmpty || gender.isEmpty || password.isEmpty || confirmPassword.isEmpty){
      setState((){
        message = "Please fill all fields";
      });
    }else if(email == "admin@gmail.com" ){
      if(password != confirmPassword){
        setState(() {
          message = "Passwords do not match";
        });
      }else {
      setState(() {
        message = "Signup Successful!";
      });
    }
  } else {
      setState(() {
        message = "Email already exists";
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Full name field
          TextField(
            controller: fullNameController,
            decoration: const InputDecoration(
                labelText: "Enter your full name",
                border: OutlineInputBorder()
            ),
          ),

          const SizedBox(height: 20),

          //Phone number field
          TextField(
            controller: phoneNumberController,
            decoration: const InputDecoration(
                labelText: "Enter your phone number",
                border: OutlineInputBorder()
            ),
          ),

          const SizedBox(height: 20),

          //Email field
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
                labelText: "Enter your email (eg. abc@gmail.com)",
                border: OutlineInputBorder()
            ),
          ),

          const SizedBox(height: 20),

          //Age field
          TextField(
            controller: ageController,
            decoration: const InputDecoration(
                labelText: "Enter your age",
                border: OutlineInputBorder()
            ),
          ),

          const SizedBox(height: 20),
          //Gender field
          TextField(
            controller: genderController,
            decoration: const InputDecoration(
                labelText: "Enter your gender",
                border: OutlineInputBorder()
            ),
          ),


          const SizedBox(height: 20),

          //Password field
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
                labelText: "Enter your password",
                border: OutlineInputBorder()
            ),
          ),

          const SizedBox(height: 20),

          //Confirm password field
          TextField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
                labelText: "Confirm your password",
                border: OutlineInputBorder()
            ),
          ),

          const SizedBox(height: 20),

          //Signup button
          ElevatedButton(
              onPressed: signup,
              child: const Text("Signup")
          ),

          const SizedBox(height: 20),

          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                const SizedBox(width: 5),

              TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

              },
              child: const Text("login."))
              ]),
          ]
      )
      )
    );
  }


}