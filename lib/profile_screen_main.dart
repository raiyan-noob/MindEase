import 'package:flutter/material.dart';
import 'package:splash_design/login.dart';
import 'profile_screen_card.dart';
import 'profile_screen_item_page.dart';

class ProfileScreen extends StatefulWidget {
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;
  const ProfileScreen({
    super.key,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isLightNotifier,
      builder: (context, isLight, _) {
        final bg = isLight ? const Color(0xFFF7FAF8) : const Color(0xFF121212);
        final card = isLight ? Colors.white : const Color(0xFF1E1E1E);
        final textMain = isLight
            ? const Color(0xFF0F5132)
            : const Color(0xFFB8DCC1);
        final subtle = isLight
            ? const Color(0xFF6B7280)
            : const Color(0xFF9CA3AF);
        final border = isLight
            ? const Color(0xFFE7F3EC)
            : const Color(0xFF2A2A2A);
        // Set deep green color for all text in profile pages
        final deepGreen = isLight ? const Color(0xFF0F5132) : const Color(0xFFB8DCC1);
        return Scaffold(
          backgroundColor: bg,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  color: isLight
                      ? deepGreen
                      : const Color(0xFF193022),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 35,
                          color: Color(0xFF0F5132),
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Profile header
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
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isLight
                              ? const Color(0xFF0F5132)
                              : const Color(0xFF193022),
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
                        child: Text(
                          'View',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
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
                          // ProfileScreenItem usage
                          ProfileScreenItem(
                            title: 'Mood History',
                            icon1: Icons.history,
                            icon2: Icons.arrow_forward_ios,

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => History(
                                    isLightNotifier: widget.isLightNotifier,
                                    onThemeChanged: widget.onThemeChanged,
                                  ),
                                ),
                              );
                            },
                            isLight: isLight,
                          ),

                          const SizedBox(height: 10),

                          ProfileScreenItem(
                            title: 'Security ',
                            icon1: Icons.security,
                            icon2: Icons.arrow_forward_ios,

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Security(
                                    isLightNotifier: widget.isLightNotifier,
                                    onThemeChanged: widget.onThemeChanged,
                                  ),
                                ),
                              );
                            },
                            isLight: isLight,
                          ),

                          const SizedBox(height: 10),

                          ProfileScreenItem(
                            title: 'Activities',
                            icon1: Icons.local_activity,
                            icon2: Icons.arrow_forward_ios,

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Announcements(
                                    isLightNotifier: widget.isLightNotifier,
                                    onThemeChanged: widget.onThemeChanged,
                                  ),
                                ),
                              );
                            },
                            isLight: isLight,
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
                                  builder: (_) => SocialAndExtras(
                                    isLightNotifier: widget.isLightNotifier,
                                    onThemeChanged: widget.onThemeChanged,
                                  ),
                                ),
                              );
                            },
                            isLight: isLight,
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
                                  builder: (_) => InviteFriends(
                                    isLightNotifier: widget.isLightNotifier,
                                    onThemeChanged: widget.onThemeChanged,
                                  ),
                                ),
                              );
                            },
                            isLight: isLight,
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
                                  builder: (_) => PrivacyPolicy(
                                    isLightNotifier: widget.isLightNotifier,
                                    onThemeChanged: widget.onThemeChanged,
                                  ),
                                ),
                              );
                            },
                            isLight: isLight,
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
                                  builder: (_) => ContactUs(
                                    isLightNotifier: widget.isLightNotifier,
                                    onThemeChanged: widget.onThemeChanged,
                                  ),
                                ),
                              );
                            },
                            isLight: isLight,
                          ),

                          const SizedBox(height: 10),

                          ProfileScreenItem(
                            title: 'Log Out',
                            icon1: Icons.logout,
                            icon2: Icons.arrow_forward_ios,

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => LoginPage()),
                              );
                            },
                            isLight: isLight,
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
      },
    );
  }
}
