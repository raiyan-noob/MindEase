import 'package:flutter/material.dart';
import 'package:splash_design/1stpage.dart';
import 'package:splash_design/profile_screen_main.dart';
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
        // Timer placeholder
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
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: isLight ? Colors.black : accent,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 8),
                child: GestureDetector(
                  onTap: () {
                    widget.onThemeChanged(!isLight);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isLight
                          ? Color.fromRGBO(255, 255, 255, 0.9)
                          : Color.fromRGBO(0, 0, 0, 0.6),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
                          RotationTransition(turns: animation, child: child),
                      child: Icon(
                        isLight ? Icons.light_mode : Icons.dark_mode,
                        key: ValueKey(isLight),
                        color: isLight
                            ? Color.fromRGBO(16, 100, 56, 1)
                            : Color.fromRGBO(184, 220, 193, 1),
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  isLight ? 'assets/relbg.jpg' : 'assets/reld.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 260),
                            Text(
                              'Sometimes religion can be\n the best way to be healed,\n go through how you want to heal\n yourself.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold,
                                color: textPrimary,
                                shadows:
                                    textPrimary.withOpacity(0.7) !=
                                        const Color.fromARGB(0, 47, 81, 54)
                                    ? [
                                        Shadow(
                                          offset: const Offset(0, 1),
                                          blurRadius: 2,
                                          color: textPrimary.withOpacity(0.7),
                                        ),
                                      ]
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 8,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
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
                                style: ElevatedButton.styleFrom(
                                  elevation: 20,
                                  side: BorderSide(
                                    color: isLight
                                        ? Color.fromARGB(255, 16, 100, 56)
                                        : Color.fromARGB(255, 184, 220, 193),
                                    width: 2,
                                  ),
                                  backgroundColor: isLight
                                      ? Color.fromARGB(255, 240, 240, 240)
                                      : Color.fromARGB(255, 41, 46, 42),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '▶ Watch or Listen',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        color: textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Connect your inner self by watching or listening to spiritual contents that resonates with you.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w500,
                                        color: isLight
                                            ? Color.fromRGBO(50, 50, 50, 1.0)
                                            : Color.fromRGBO(
                                                200,
                                                200,
                                                200,
                                                1.0,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 12,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
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
                                style: ElevatedButton.styleFrom(
                                  elevation: 20,
                                  side: BorderSide(
                                    color: isLight
                                        ? Color.fromARGB(255, 16, 100, 56)
                                        : Color.fromARGB(255, 184, 220, 193),
                                    width: 2,
                                  ),
                                  backgroundColor: isLight
                                      ? Color.fromARGB(255, 240, 240, 240)
                                      : Color.fromARGB(255, 41, 46, 42),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '📖 Read',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        color: textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Find your answer through the verses of spiritual books',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w500,
                                        color: isLight
                                            ? Color.fromRGBO(50, 50, 50, 1.0)
                                            : Color.fromRGBO(
                                                200,
                                                200,
                                                200,
                                                1.0,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 90),
                              child: Text(
                                '"Surely with hardship comes ease"\n- Al-Qur\'an 94:5',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: textPrimary,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  shadows:
                                      textPrimary.withOpacity(0.5) !=
                                          const Color.fromARGB(0, 47, 81, 54)
                                      ? [
                                          Shadow(
                                            offset: const Offset(0, 1),
                                            blurRadius: 2,
                                            color: textPrimary.withOpacity(0.5),
                                          ),
                                        ]
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
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
