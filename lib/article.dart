import 'package:flutter/material.dart';
import 'package:splash_design/profile_screen_main.dart';
import '1stpage.dart';
import '2ndpage.dart';
import 'blogart.dart';
import 'vlogart.dart';

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

class ArticlePage extends StatefulWidget {
  final String feeling;
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;

  const ArticlePage({
    super.key,
    required this.feeling,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
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
                        )
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
                  isLight ? 'assets/artwbg.jpg' : 'assets/artbbg.jpg',
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
                            const SizedBox(height: 160),
                            Text(
                              'Articles, Blogs & Stories\n can be a source of inspiration,\n offering perspectives that\n resonate with your feelings.',
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

                            const SizedBox(height: 20),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 45,
                                vertical: 6,
                              ),
                              margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    _fadePageRoute(
                                      BlogPage(
                                        selection: 'Blog',
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
                                      '📝 Articles & Blogs',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        color: textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Discover insightful articles and blogs that offer comfort and guidance.',
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

                            const SizedBox(height: 25),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 55,
                                vertical: 6,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    _fadePageRoute(
                                      VlogPage(
                                        selection: 'Vlog',
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
                                      '🎥 Vlogs & Documentaries',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        color: textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Explore vlogs and documentaries that offer comfort and inspiration.',
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
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                '"There is hope, even when your brain\n tells you there isn\'t" - John Green',
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

          // Add bottom navigation bar (copied from SecondPage)
          bottomNavigationBar: BottomAppBar(
            color: isLight ? Colors.white : const Color(0xFF1C1C1C),
            elevation: 18,
            child: SizedBox(
              height: 64,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _BottomIcon(
                    isLight: isLight,
                    icon: Icons.home_filled,
                    selected: false,
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SecondPage(
                          feeling: widget.feeling,
                          isLightNotifier: widget.isLightNotifier,
                          onThemeChanged: widget.onThemeChanged,
                        ),
                      ),
                    ),
                  ),
                  _BottomIcon(
                    isLight: isLight,
                    icon: Icons.bookmark_border,
                    selected: false,
                    onTap: () {},
                  ),
                  _BottomIcon(
                    isLight: isLight,
                    icon: Icons.timer_outlined,
                    selected: false,
                    onTap: () {},
                  ),
                  _BottomIcon(
                    isLight: isLight,
                    icon: Icons.person_outline,
                    selected: false,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MyAppFirst(
                          // feeling: widget.feeling,
                          isLightNotifier: widget.isLightNotifier,
                          onThemeChanged: widget.onThemeChanged,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Add _BottomIcon widget if not present
class _BottomIcon extends StatelessWidget {
  final bool isLight;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _BottomIcon({
    required this.isLight,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final active = isLight ? const Color(0xFF0F5132) : const Color(0xFFB8DCC1);
    final inactive = isLight ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

    return InkResponse(
      onTap: onTap,
      radius: 26,
      child: Icon(
        icon,
        size: 26,
        color: selected ? active : inactive,
      ),
    );
  }
}
