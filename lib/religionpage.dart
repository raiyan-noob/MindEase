import 'package:flutter/material.dart';

class ReligionPage extends StatefulWidget {
  final String feeling;
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;

  const ReligionPage({
    Key? key,
    required this.feeling,
    required this.isLightNotifier,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  State<ReligionPage> createState() => _ReligionPageState();
}

class _ReligionPageState extends State<ReligionPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isLightNotifier,
      builder: (context, isLight, _) {
        final bgColor = isLight
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
          ),
          body: Stack(
            children: [
              // Background image covering entire body
              Positioned.fill(
                child: Image.asset(
                  isLight ? 'assets/relbg.jpg' : 'assets/reld.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              // Body content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 230),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      width: 250,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: accent, width: 3),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: accent.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        color: isLight
                            ? Color.fromRGBO(254, 254, 254, 1.0)
                            : Color.fromRGBO(34, 34, 34, 1.0),
                      ),
                      child: Text(
                        'Sometimes religion can be the best way to heal yourself, go through how you want to heal yourself.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w800,
                          color: textPrimary,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
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
                            vertical: 35,
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
                                    : Color.fromRGBO(200, 200, 200, 1.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
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
                            vertical: 35,
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
                                    : Color.fromRGBO(200, 200, 200, 1.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 105),

                    Text(
                      '"Surely with hardship comes ease"\n- Al-Qur\'an 94:5',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textPrimary,
                        fontFamily: 'Nunito',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          endDrawer: Drawer(
            width: 250,
            elevation: 30,
            backgroundColor: bgColor,
            shadowColor: isLight ? Color.fromRGBO(4, 13, 9, 1.0) : accent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: bgColor,
                    ),
                    icon: Icon(Icons.person, color: accent, size: 25),
                    label: Text(
                      'Profile',
                      style: TextStyle(
                        color: accent,
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(thickness: 1, height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: accent, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => widget.onThemeChanged(true),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isLight
                                        ? accent
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Icon(
                                    Icons.light_mode,
                                    color: isLight ? Colors.white : accent,
                                    size: 24,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => widget.onThemeChanged(false),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: !isLight
                                        ? accent
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Icon(
                                    Icons.dark_mode,
                                    color: !isLight
                                        ? Color.fromRGBO(42, 42, 42, 1.0)
                                        : accent,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
