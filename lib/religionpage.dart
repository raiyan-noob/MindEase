import 'package:flutter/material.dart';
import 'package:splash_design/1stpage.dart';
import 'package:splash_design/breathing_page.dart';
import 'package:splash_design/profile/profile_screen_main.dart';
import 'package:splash_design/readrel.dart';
import '2ndpage.dart';
import 'videorel.dart';

Route<dynamic> _fadePageRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero);
      final curveTween = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );

      return FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curveTween),
        child: SlideTransition(
          position: tween.animate(curveTween),
          child: child,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 1000),
    reverseTransitionDuration: const Duration(milliseconds: 1000),
  );
}

class ReligionPage extends StatefulWidget {
  final String feeling;
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;

  const ReligionPage({
    super.key,
    required this.feeling,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<ReligionPage> createState() => _ReligionPageState();
}

class _ReligionPageState extends State<ReligionPage>
    with TickerProviderStateMixin {
  int _selectedIndex = 1;

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
                        begin: const Offset(-0.15, 0),
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
        ).then((_) {
          if (mounted) setState(() => _selectedIndex = -1);
        });
        break;
      case 1:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => SecondPage(
              feeling: widget.feeling,
              isLightNotifier: widget.isLightNotifier,
              onThemeChanged: widget.onThemeChanged,
            ),
            transitionsBuilder: (_, anim, __, child) {
              return FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position:
                      Tween<Offset>(
                        begin: const Offset(-0.15, 0),
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
        ).then((_) {
          if (mounted) setState(() => _selectedIndex = -1);
        });
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
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => ProfileScreen(
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
        ).then((_) {
          if (mounted) setState(() => _selectedIndex = -1);
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isLightNotifier,
      builder: (context, isLight, _) {
        isLight
            ? Color.fromRGBO(255, 255, 255, 1.0)
            : Color.fromRGBO(19, 19, 19, 1.0);
        final accent = isLight
            ? Color.fromRGBO(16, 100, 56, 1.0)
            : Color.fromRGBO(184, 220, 193, 1.0);
        final textPrimary = isLight
            ? Color.fromRGBO(16, 62, 40, 1.0)
            : Color.fromRGBO(192, 226, 201, 1.0);

        return Scaffold(
          backgroundColor: isLight
              ? Color.fromRGBO(255, 255, 255, 1.0)
              : Color.fromRGBO(19, 19, 19, 1.0),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/newLogoremovebg.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "MindEase",
                            style: TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: textPrimary,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.onThemeChanged(!isLight);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isLight
                                ? const Color(0xFFEAF7EF)
                                : const Color(0xFF2A2A2A),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromRGBO(0, 0, 0, 0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) =>
                                RotationTransition(
                                  turns: animation,
                                  child: child,
                                ),
                            child: Icon(
                              isLight ? Icons.light_mode : Icons.dark_mode,
                              key: ValueKey(isLight),
                              color: isLight
                                  ? const Color(0xFF0F5132)
                                  : const Color(0xFFB8DCC1),
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  //physics: const BouncingScrollPhysics(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 120, // clears bottom nav
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 24),

                        // ── Heading ────────────────────────────────
                        Text(
                          'Sometimes religion can be\nthe best way to be healed,\ngo through how you want to heal yourself.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            color: textPrimary,
                            height: 1.55,
                            shadows: [
                              Shadow(
                                offset: const Offset(0, 1),
                                blurRadius: 2,
                                color: textPrimary.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // ── Watch or Listen Card ───────────────────
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              _fadePageRoute(
                                VideoRelPage(
                                  selection: 'Video',
                                  feeling: widget.feeling,
                                  isLightNotifier: widget.isLightNotifier,
                                  onThemeChanged: widget.onThemeChanged,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color: isLight
                                  ? Colors.white.withOpacity(0.93)
                                  : const Color.fromARGB(238, 41, 46, 42),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.09),
                                  blurRadius: 20,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Orange play icon circle
                                Container(
                                  width: 66,
                                  height: 66,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 220, 200),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 42,
                                      height: 42,
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 218, 90, 22),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.play_arrow_rounded,
                                        color: Colors.white,
                                        size: 26,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Text content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Watch or Listen',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w800,
                                          color: textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'Connect your inner self by watching or listening to spiritual contents that resonates with you.',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w500,
                                          height: 1.45,
                                          color: isLight
                                              ? const Color.fromRGBO(
                                                  70,
                                                  70,
                                                  70,
                                                  1,
                                                )
                                              : const Color.fromRGBO(
                                                  190,
                                                  190,
                                                  190,
                                                  1,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Chevron circle
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isLight
                                          ? const Color.fromARGB(
                                              255,
                                              160,
                                              200,
                                              175,
                                            )
                                          : const Color.fromARGB(
                                              255,
                                              90,
                                              120,
                                              100,
                                            ),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.chevron_right_rounded,
                                    size: 18,
                                    color: isLight
                                        ? const Color.fromARGB(255, 16, 100, 56)
                                        : const Color.fromARGB(
                                            255,
                                            184,
                                            220,
                                            193,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ── Read Card ──────────────────────────────
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              _fadePageRoute(
                                ReadRelPage(
                                  selection: 'Read',
                                  feeling: widget.feeling,
                                  isLightNotifier: widget.isLightNotifier,
                                  onThemeChanged: widget.onThemeChanged,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color: isLight
                                  ? Colors.white.withOpacity(0.93)
                                  : const Color.fromARGB(238, 41, 46, 42),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.09),
                                  blurRadius: 20,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Green book icon circle
                                Container(
                                  width: 66,
                                  height: 66,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 200, 232, 212),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.menu_book_rounded,
                                      color: Color.fromARGB(255, 180, 50, 30),
                                      size: 34,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Text content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Read',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w800,
                                          color: textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'Find your answer through the verses of spiritual books',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w500,
                                          height: 1.45,
                                          color: isLight
                                              ? const Color.fromRGBO(
                                                  70,
                                                  70,
                                                  70,
                                                  1,
                                                )
                                              : const Color.fromRGBO(
                                                  190,
                                                  190,
                                                  190,
                                                  1,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Chevron circle
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isLight
                                          ? const Color.fromARGB(
                                              255,
                                              160,
                                              200,
                                              175,
                                            )
                                          : const Color.fromARGB(
                                              255,
                                              90,
                                              120,
                                              100,
                                            ),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.chevron_right_rounded,
                                    size: 20,
                                    color: isLight
                                        ? const Color.fromARGB(255, 16, 100, 56)
                                        : const Color.fromARGB(
                                            255,
                                            184,
                                            220,
                                            193,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),

                        // ── Quote Section ──────────────────────────
                        Column(
                          children: [
                            // Large opening quote mark
                            Text(
                              '\u275D',
                              style: TextStyle(
                                fontSize: 36,
                                height: 1,
                                color: isLight
                                    ? const Color.fromARGB(80, 16, 100, 56)
                                    : const Color.fromARGB(80, 184, 220, 193),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '"Surely with hardship comes ease"',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: textPrimary,
                                fontFamily: 'Nunito',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(0, 1),
                                    blurRadius: 2,
                                    color: textPrimary.withOpacity(0.3),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "- Al-Qur'an 94:5",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: textPrimary,
                                fontFamily: 'Nunito',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 14),
                            // Decorative divider
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 52,
                                  height: 1,
                                  color: isLight
                                      ? const Color.fromARGB(60, 16, 100, 56)
                                      : const Color.fromARGB(60, 184, 220, 193),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Icon(
                                    Icons.spa_outlined,
                                    size: 16,
                                    color: isLight
                                        ? const Color.fromARGB(140, 16, 100, 56)
                                        : const Color.fromARGB(
                                            140,
                                            184,
                                            220,
                                            193,
                                          ),
                                  ),
                                ),
                                Container(
                                  width: 52,
                                  height: 1,
                                  color: isLight
                                      ? const Color.fromARGB(60, 16, 100, 56)
                                      : const Color.fromARGB(60, 184, 220, 193),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

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
                      label: "",
                      index: 1,
                      selectedIndex: _selectedIndex,
                      isLight: isLight,
                      bounceAnimation: _navBounceAnimation,
                      onTap: () => _onNavTap(1),
                    ),
                    _AnimatedNavItem(
                      icon: Icons.timer_outlined,
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
