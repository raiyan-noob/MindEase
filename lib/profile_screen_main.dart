import 'package:flutter/material.dart';
import 'package:flutter_self/profile_screen_card.dart';
import 'profile_screen_item_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              color: const Color.fromRGBO(0, 152, 139, 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 35, color: Color.fromRGBO(0, 152, 139, 1)),
                  ),

                  const SizedBox(width: 15),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rejwanul Islam",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "ID: xxxxxxxxxx",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 152, 139, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ViewProfilePage(),
                        ),
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.visibility, size: 18, color: Colors.white),
                        SizedBox(width: 6),
                        Text(
                          "View Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileScreenItem(
                        title: 'History',
                        icon1: Icons.history,
                        icon2: Icons.arrow_forward_ios,

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const History()),
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      ProfileScreenItem(
                        title: 'Security ',
                        icon1: Icons.security,
                        icon2: Icons.arrow_forward_ios,

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Security()),
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      ProfileScreenItem(
                        title: 'Announcements',
                        icon1: Icons.campaign_sharp,
                        icon2: Icons.arrow_forward_ios,

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const Announcements(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      ProfileScreenItem(
                        title: 'Social & Extras',
                        icon1: Icons.public,
                        icon2: Icons.arrow_forward_ios,

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SocialAndExtras(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      ProfileScreenItem(
                        title: 'Invite Friends',
                        icon1: Icons.person_add,
                        icon2: Icons.arrow_forward_ios,

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const InviteFriends(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      ProfileScreenItem(
                        title: 'Privacy Policy',
                        icon1: Icons.privacy_tip,
                        icon2: Icons.arrow_forward_ios,

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PrivacyPolicy(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      ProfileScreenItem(
                        title: 'Contact Us',
                        icon1: Icons.support_agent,
                        icon2: Icons.arrow_forward_ios,

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ContactUs(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      ProfileScreenItem(
                        title: 'Log Out',
                        icon1: Icons.logout,
                        icon2: Icons.arrow_forward_ios,

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Logout()),
                          );
                        },
                      ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
