import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 152, 139, 1),
        title: const Text(' History', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: const Center(child: Text('History Page')),
    );
  }
}

class Security extends StatelessWidget {
  const Security({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 152, 139, 1),
        title: const Text(' Security', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: const Center(child: Text('Security Page')),
    );
  }
}

class Announcements extends StatelessWidget {
  const Announcements({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 152, 139, 1),
        title: const Text(
          ' Announcements',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const Center(child: Text('Announcements Page')),
    );
  }
}

class SocialAndExtras extends StatelessWidget {
  const SocialAndExtras({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 152, 139, 1),
        title: const Text(
          ' Social & Extras',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const Center(child: Text('Social & Extras Page')),
    );
  }
}

class InviteFriends extends StatelessWidget {
  const InviteFriends({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 152, 139, 1),
        title: const Text(
          ' Invite Friends',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const Center(child: Text('Invite Friends Page')),
    );
  }
}

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 152, 139, 1),
        title: const Text(
          ' Privacy Policy',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const Center(child: Text('Privacy Policy Page')),
    );
  }
}

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 152, 139, 1),
        title: const Text(' Contact Us', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: const Center(child: Text('Contact Us Page')),
    );
  }
}

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 152, 139, 1),
        title: const Text(' Logout', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: const Center(child: Text('Logout Page')),
    );
  }
}

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
                  "Back To Home",
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
