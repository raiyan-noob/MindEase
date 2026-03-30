import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:splash_design/2ndpage.dart';
import 'profile/profile_screen_main.dart';

class MyAppFirst extends StatefulWidget {
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;

  const MyAppFirst({
    super.key,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<MyAppFirst> createState() => _MyAppState();
}

class _MyAppState extends State<MyAppFirst> with TickerProviderStateMixin {
  String? selectedFeeling;

  // ✅ Default to index 0 since this is the Home/1st page
  int _selectedIndex = 0;

  late AnimationController _navAnimController;
  late Animation<double> _navBounceAnimation;

  final Map<String, Map<String, dynamic>> feelingOptions = {
    'Sad': {
      'icon': Icons.cloud_outlined,
      'color': Color.fromARGB(255, 100, 140, 200),
      'bgColor': Color.fromARGB(255, 220, 232, 250),
    },
    'Depressed': {
      'icon': Icons.water_drop_outlined,
      'color': Color.fromARGB(255, 80, 120, 200),
      'bgColor': Color.fromARGB(255, 215, 228, 250),
    },
    'Anxious': {
      'icon': Icons.psychology_outlined,
      'color': Color.fromARGB(255, 150, 100, 180),
      'bgColor': Color.fromARGB(255, 235, 220, 245),
    },
    'Frustrated': {
      'icon': Icons.flash_on_rounded,
      'color': Color.fromARGB(255, 220, 150, 50),
      'bgColor': Color.fromARGB(255, 250, 235, 210),
    },
    'Angry': {
      'icon': Icons.local_fire_department_outlined,
      'color': Color.fromARGB(255, 210, 90, 70),
      'bgColor': Color.fromARGB(255, 250, 225, 220),
    },
    'Hopeless': {
      'icon': Icons.sentiment_dissatisfied_outlined,
      'color': Color.fromARGB(255, 100, 160, 140),
      'bgColor': Color.fromARGB(255, 215, 240, 230),
    },
  };

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
        // Already on Home
        break;
      case 1:
        // Heal page — show the feeling bottom sheet
        final isLight = widget.isLightNotifier.value;
        _showFeelingBottomSheet(isLight);
        // Reset back to home after bottom sheet
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) setState(() => _selectedIndex = 0);
        });
        break;
      case 2:
        // Timer page placeholder
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
          if (mounted) setState(() => _selectedIndex = 0);
        });
        break;
    }
  }

  void _showFeelingBottomSheet(bool isLight) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Color.fromRGBO(0, 0, 0, 0.4),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: BoxDecoration(
            color: isLight ? Colors.white : Color.fromARGB(255, 30, 30, 30),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isLight ? Colors.grey.shade300 : Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Your Mood',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isLight
                            ? Color.fromARGB(255, 40, 40, 40)
                            : Color.fromARGB(255, 230, 230, 230),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isLight
                              ? Colors.grey.shade200
                              : Colors.grey.shade800,
                        ),
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: isLight
                              ? Colors.grey.shade600
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: feelingOptions.entries.map((entry) {
                    final String label = entry.key;
                    final IconData icon = entry.value['icon'];
                    final Color color = entry.value['color'];
                    final Color bgColor = entry.value['bgColor'];

                    return GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        setState(() {
                          selectedFeeling = label;
                        });
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SecondPage(
                              feeling: label,
                              isLightNotifier: widget.isLightNotifier,
                              onThemeChanged: widget.onThemeChanged,
                            ),
                          ),
                        );
                        setState(() {
                          selectedFeeling = null;
                          _selectedIndex = 0;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: isLight
                              ? Color.fromARGB(255, 255, 255, 255)
                              : Color.fromARGB(255, 3, 2, 2),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: isLight
                                ? Color.fromRGBO(
                                    (bgColor.r * 255.0).round().clamp(0, 255),
                                    (bgColor.g * 255.0).round().clamp(0, 255),
                                    (bgColor.b * 255.0).round().clamp(0, 255),
                                    0.3,
                                  )
                                : Colors.grey.shade700,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isLight
                                    ? bgColor
                                    : Color.fromRGBO(
                                        (color.r * 255.0).round().clamp(0, 255),
                                        (color.g * 255.0).round().clamp(0, 255),
                                        (color.b * 255.0).round().clamp(0, 255),
                                        0.15,
                                      ),
                              ),
                              child: Icon(icon, color: color, size: 22),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              label,
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: isLight
                                    ? Color.fromARGB(255, 60, 60, 60)
                                    : Color.fromARGB(255, 200, 200, 200),
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: isLight
                                  ? Color.fromRGBO(
                                      (color.r * 255.0).round().clamp(0, 255),
                                      (color.g * 255.0).round().clamp(0, 255),
                                      (color.b * 255.0).round().clamp(0, 255),
                                      0.5,
                                    )
                                  : Colors.grey.shade600,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isLightNotifier,
      builder: (context, isLight, _) {
        final Color accent = isLight
            ? Color.fromARGB(255, 16, 100, 56)
            : Color.fromARGB(255, 184, 220, 193);

        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/newLogoremovebg.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'MindEase',
                            style: TextStyle(
                              color: isLight
                                  ? Color.fromARGB(255, 16, 100, 56)
                                  : Color.fromARGB(255, 184, 220, 193),
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
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
                                RotationTransition(
                                  turns: animation,
                                  child: child,
                                ),
                            child: Icon(
                              isLight ? Icons.light_mode : Icons.dark_mode,
                              key: ValueKey(isLight),
                              color: isLight
                                  ? Color.fromRGBO(0, 152, 139, 1)
                                  : Color.fromARGB(255, 184, 220, 193),
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  isLight ? 'assets/1wbg.jpg' : 'assets/1bbg.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: LayoutBuilder(
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
                              const SizedBox(height: 40),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'Hello, Raiyan!',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: accent.withOpacity(
                                        0.8 +
                                            (math.Random().nextDouble() * 0.2),
                                      ),
                                      fontFamily: 'Titillium Web',
                                      fontSize: 25,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Text(
                                  'How are you feeling today?',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: accent.withOpacity(
                                      0.8 + (math.Random().nextDouble() * 0.2),
                                    ),
                                    fontFamily: 'Nunito',
                                    textBaseline: TextBaseline.alphabetic,
                                    fontSize: 39,
                                    fontWeight: FontWeight.bold,
                                    decorationStyle: TextDecorationStyle.wavy,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              GestureDetector(
                                onTap: () => _showFeelingBottomSheet(isLight),
                                child: Container(
                                  width: 340,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isLight
                                        ? Color.fromARGB(255, 255, 255, 255)
                                        : Color.fromARGB(255, 3, 2, 2),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(
                                          (accent.r * 255.0).round().clamp(
                                            0,
                                            255,
                                          ),
                                          (accent.g * 255.0).round().clamp(
                                            0,
                                            255,
                                          ),
                                          (accent.b * 255.0).round().clamp(
                                            0,
                                            255,
                                          ),
                                          0.5,
                                        ),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Dive into your feelings',
                                        style: TextStyle(
                                          color: Color.fromRGBO(
                                            (accent.r * 255.0).round().clamp(
                                              0,
                                              255,
                                            ),
                                            (accent.g * 255.0).round().clamp(
                                              0,
                                              255,
                                            ),
                                            (accent.b * 255.0).round().clamp(
                                              0,
                                              255,
                                            ),
                                            0.8 +
                                                (math.Random().nextDouble() *
                                                    0.2),
                                          ),
                                          fontFamily: 'Titillium Web',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_up_rounded,
                                        color: accent,
                                        size: 28,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 35),
                                  Text(
                                    '"Even in the darkest moments, light exists\nif you have faith to see it" - Dean Koontz',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isLight
                                          ? Color.fromARGB(255, 16, 100, 56)
                                          : Color.fromARGB(255, 184, 220, 193),
                                      fontFamily: 'Nunito',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                              // ✅ Extra space so content doesn't hide behind nav
                              const SizedBox(height: 90),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // ===== ✅ ANIMATED BOTTOM NAVIGATION BAR =====
          extendBody: true,
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
                      label: "",
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
                      label: "",
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
            // Animated icon with scale
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
            // Animated label that slides in/out
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
