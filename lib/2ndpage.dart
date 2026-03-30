import 'package:flutter/material.dart';
import 'package:splash_design/1stpage.dart';
import 'package:splash_design/Literature.dart';
import 'religionpage.dart';
import 'entertainement.dart';
import 'article.dart';
import 'profile/profile_screen_main.dart';

class SecondPage extends StatefulWidget {
  final String feeling;
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;

  const SecondPage({
    super.key,
    required this.feeling,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> with TickerProviderStateMixin {
  // ✅ Default to index 1 since this is the 2nd screen
  int _selectedIndex = 1;

  // Animation controller for bottom nav indicator
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

    // Navigate based on index
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
        );
        break;
      case 1:
        // Already on this page
        break;
      case 2:
        // Timer page placeholder — add your page here
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
        );
        break;
    }
  }

  void _goTo(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

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

        return Scaffold(
          backgroundColor: bg,

          // ===== BODY =====
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
                              color: textMain,
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: card,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: border),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, isLight ? 0.06 : 0.25),
                          blurRadius: 18,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: isLight
                                    ? const Color(0xFFEAF7EF)
                                    : const Color(0xFF193022),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.self_improvement,
                                color: textMain,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 16,
                                    height: 1.35,
                                    color: subtle,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "It's okay to feel this way,\n",
                                      style: TextStyle(
                                        color: textMain,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const TextSpan(text: "Raiyan.\n"),
                                    const TextSpan(
                                      text:
                                          "You are your own biggest healer.\n",
                                    ),
                                    const TextSpan(text: "Take a deep breath."),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    "Choose how you want to\nheal yourself today",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: textMain,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: _HealOptionCard(
                          isLight: isLight,
                          title: "Religion",
                          icon: Icons.mosque,
                          iconBg: isLight
                              ? const Color(0xFFEAF7EF)
                              : const Color(0xFF193022),
                          iconColor: isLight
                              ? const Color(0xFF0F5132)
                              : const Color(0xFFB8DCC1),
                          onTap: () => _goTo(
                            ReligionPage(
                              feeling: widget.feeling,
                              isLightNotifier: widget.isLightNotifier,
                              onThemeChanged: widget.onThemeChanged,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _HealOptionCard(
                          isLight: isLight,
                          title: "Entertainment",
                          icon: Icons.movie_filter_outlined,
                          iconBg: isLight
                              ? const Color(0xFFEFF6FF)
                              : const Color(0xFF182033),
                          iconColor: isLight
                              ? const Color(0xFF2563EB)
                              : const Color(0xFF93C5FD),
                          onTap: () => _goTo(
                            EntertainmentPage(
                              feeling: widget.feeling,
                              isLightNotifier: widget.isLightNotifier,
                              onThemeChanged: widget.onThemeChanged,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _HealOptionCard(
                          isLight: isLight,
                          title: "Articles  & Documentaries",
                          icon: Icons.article_outlined,
                          iconBg: isLight
                              ? const Color(0xFFFFF7ED)
                              : const Color(0xFF2A1D12),
                          iconColor: isLight
                              ? const Color(0xFFEA580C)
                              : const Color(0xFFFBBF24),
                          onTap: () => _goTo(
                            ArticlePage(
                              feeling: widget.feeling,
                              isLightNotifier: widget.isLightNotifier,
                              onThemeChanged: widget.onThemeChanged,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _HealOptionCard(
                          isLight: isLight,
                          title: "Literature",
                          icon: Icons.menu_book_outlined,
                          iconBg: isLight
                              ? const Color(0xFFF5F3FF)
                              : const Color(0xFF221A33),
                          iconColor: isLight
                              ? const Color(0xFF7C3AED)
                              : const Color(0xFFC4B5FD),
                          onTap: () => _goTo(
                            LitPage(
                              feeling: widget.feeling,
                              isLightNotifier: widget.isLightNotifier,
                              onThemeChanged: widget.onThemeChanged,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Text(
                    '"Healing takes time, and asking for help\nis a courageous step"- Mariska Hargitay',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 13.5,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w800,
                      color: isLight
                          ? const Color(0xFF6B7280)
                          : const Color(0xFFA7B0A9),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ===== ✅ REDESIGNED ANIMATED BOTTOM NAV =====
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: isLight ? Colors.white : const Color(0xFF1C1C1C),
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
      child: AnimatedBuilder(
        animation: bounceAnimation,
        isSelected: isSelected,
        builder: (context, isSelected) {
          return AnimatedContainer(
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
          );
        },
      ),
    );
  }
}

// ===== ✅ HELPER: AnimatedBuilder that passes isSelected =====
class AnimatedBuilder extends StatelessWidget {
  final Animation<double> animation;
  final bool isSelected;
  final Widget Function(BuildContext context, bool isSelected) builder;

  const AnimatedBuilder({
    super.key,
    required this.animation,
    required this.isSelected,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder2(
      animation: animation,
      builder: (context, _) => builder(context, isSelected),
    );
  }
}

class AnimatedBuilder2 extends AnimatedWidget {
  final Widget Function(BuildContext context, Widget? child) builder;

  const AnimatedBuilder2({
    super.key,
    required Animation<double> animation,
    required this.builder,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return builder(context, null);
  }
}

// ===== HEAL OPTION CARD (unchanged) =====
class _HealOptionCard extends StatelessWidget {
  final bool isLight;
  final String title;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final VoidCallback onTap;

  const _HealOptionCard({
    required this.isLight,
    required this.title,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = isLight ? Colors.white : const Color(0xFF1E1E1E);
    final border = isLight ? const Color(0xFFE7F3EC) : const Color(0xFF2A2A2A);
    final text = isLight ? const Color(0xFF0F5132) : const Color(0xFFB8DCC1);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        height: 140,
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: border),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, isLight ? 0.06 : 0.22),
              blurRadius: 14,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 13.5,
                fontWeight: FontWeight.w900,
                color: text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
