
import 'package:flutter/material.dart';

class ViewProfilePage extends StatelessWidget {
  const ViewProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 152, 139, 1),
        centerTitle: true,
        title: const Text(
          "View Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Name",
                hintText: "rejwanul islam",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Rejwanulrakib23@gmail.com",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Phone Number",
                hintText: "01799236603",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: "DOB",
                hintText: "2004-10-23",
                suffixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              readOnly: true,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Address",
                hintText: "uttara",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(0, 152, 139, 1),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Go Back",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
