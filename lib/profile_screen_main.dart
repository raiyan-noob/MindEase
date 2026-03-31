import 'package:flutter/material.dart';
import 'package:splash_design/breathing_page.dart';
import 'package:splash_design/login.dart';
import 'package:splash_design/1stpage.dart';
import 'profile/profile_screen_card.dart';
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

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 3;

  late AnimationController _navAnimController;
  late Animation<double> _navBounceAnimation;

  @override
  void initState() {
    super.initState();
    _navAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _navBounceAnimation = CurvedAnimation(
      parent: _navAnimController,
      curve: Curves.elasticOut,
    );
    _navAnimController.forward();
  }

  @override
  void dispose() {
    _navAnimController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
    _navAnimController.reset();
    _navAnimController.forward();

    switch (index) {
      case 0:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => MyAppFirst(
              isLightNotifier: widget.isLightNotifier,
              onThemeChanged: widget.onThemeChanged,
            ),
            transitionsBuilder: (_, anim, __, child) {
              return FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position:
                      Tween<Offset>(
                        begin: const Offset(0.15, 0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(parent: anim, curve: Curves.easeOut),
                      ),
                  child: child,
                ),
              );
            },
            transitionDuration: const Duration(milliseconds: 350),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => MyAppFirst(
              isLightNotifier: widget.isLightNotifier,
              onThemeChanged: widget.onThemeChanged,
            ),
            transitionsBuilder: (_, anim, __, child) {
              return FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position:
                      Tween<Offset>(
                        begin: const Offset(0.15, 0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(parent: anim, curve: Curves.easeOut),
                      ),
                  child: child,
                ),
              );
            },
            transitionDuration: const Duration(milliseconds: 350),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => BreathingPage(
              isLightNotifier: widget.isLightNotifier,
              onThemeChanged: widget.onThemeChanged,
            ),
            transitionsBuilder: (_, anim, __, child) {
              return FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position:
                      Tween<Offset>(
                        begin: const Offset(0.15, 0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(parent: anim, curve: Curves.easeOut),
                      ),
                  child: child,
                ),
              );
            },
            transitionDuration: const Duration(milliseconds: 350),
          ),
        );
        break;
      case 3:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isLightNotifier,
      builder: (context, isLight, _) {
        final bg = isLight ? const Color(0xFFF7FAF8) : const Color(0xFF121212);
        final deepGreen = isLight
            ? const Color(0xFF0F5132)
            : const Color(0xFFB8DCC1);

        return Scaffold(
          backgroundColor: bg,
          body: SafeArea(
            child: Column(
              children: [
                // ===== PROFILE HEADER =====
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  color: isLight ? deepGreen : const Color(0xFF193022),
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

                // ===== PROFILE ITEMS =====
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
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
                          // ✅ Extra bottom space so items don't hide behind nav
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ===== ✅ REDESIGNED ANIMATED BOTTOM NAV =====
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: isLight
                  ? Colors.white.withOpacity(0.95)
                  : const Color(0xFF1C1C1C).withOpacity(0.95),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, isLight ? 0.08 : 0.35),
                  blurRadius: 24,
                  offset: const Offset(0, -6),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _AnimatedNavItem(
                      icon: Icons.home_filled,
                      label: "Home",
                      index: 0,
                      selectedIndex: _selectedIndex,
                      isLight: isLight,
                      bounceAnimation: _navBounceAnimation,
                      onTap: () => _onNavTap(0),
                    ),
                    _AnimatedNavItem(
                      icon: Icons.spa_outlined,
                      label: "Heal",
                      index: 1,
                      selectedIndex: _selectedIndex,
                      isLight: isLight,
                      bounceAnimation: _navBounceAnimation,
                      onTap: () => _onNavTap(1),
                    ),
                    _AnimatedNavItem(
                      icon: Icons.self_improvement_outlined,
                      label: "Timer",
                      index: 2,
                      selectedIndex: _selectedIndex,
                      isLight: isLight,
                      bounceAnimation: _navBounceAnimation,
                      onTap: () => _onNavTap(2),
                    ),
                    _AnimatedNavItem(
                      icon: Icons.person_outline,
                      label: "Profile",
                      index: 3,
                      selectedIndex: _selectedIndex,
                      isLight: isLight,
                      bounceAnimation: _navBounceAnimation,
                      onTap: () => _onNavTap(3),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ===== ✅ ANIMATED NAV ITEM WIDGET =====
class _AnimatedNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int selectedIndex;
  final bool isLight;
  final Animation<double> bounceAnimation;
  final VoidCallback onTap;

  const _AnimatedNavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.isLight,
    required this.bounceAnimation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == selectedIndex;

    final Color activeColor = isLight
        ? const Color(0xFF0F5132)
        : const Color(0xFFB8DCC1);
    final Color inactiveColor = isLight
        ? const Color(0xFF9CA3AF)
        : const Color(0xFF6B7280);
    final Color activeBg = isLight
        ? const Color(0xFFEAF7EF)
        : const Color(0xFF193022);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? activeBg : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(
                begin: isSelected ? 0.8 : 1.0,
                end: isSelected ? 1.15 : 1.0,
              ),
              duration: const Duration(milliseconds: 350),
              curve: Curves.elasticOut,
              builder: (context, scale, child) {
                return Transform.scale(scale: scale, child: child);
              },
              child: Icon(
                icon,
                size: 24,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              child: isSelected
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: AnimatedOpacity(
                        opacity: isSelected ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 250),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: activeColor,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
