import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:splash_design/2ndpage.dart';

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

class _MyAppState extends State<MyAppFirst> {
  String? selectedFeeling;

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
                                ? Color.fromRGBO((bgColor.r * 255.0).round().clamp(0, 255), (bgColor.g * 255.0).round().clamp(0, 255), (bgColor.b * 255.0).round().clamp(0, 255), 0.3)
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
                                    : Color.fromRGBO((color.r * 255.0).round().clamp(0, 255), (color.g * 255.0).round().clamp(0, 255), (color.b * 255.0).round().clamp(0, 255), 0.15),
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
                                  ? Color.fromRGBO((color.r * 255.0).round().clamp(0, 255), (color.g * 255.0).round().clamp(0, 255), (color.b * 255.0).round().clamp(0, 255), 0.5)
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
          appBar: AppBar(
            toolbarHeight: 90, // Increase AppBar height
            backgroundColor: Colors.transparent,
            elevation: 0,

            leading: Image.asset(
              'assets/newLogoremovebg.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),

            title: Text(
              'MindEase',
              style: TextStyle(
                color: isLight
                    ? Color.fromARGB(255, 16, 100, 56)
                    : Color.fromARGB(255, 184, 220, 193),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
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
                            ? Color.fromRGBO(0, 152, 139, 1)
                            : Color.fromARGB(255, 184, 220, 193),
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

                                child: Text(
                                  'Hello, Raiyan!',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: accent.withOpacity(
                                      0.8 + (math.Random().nextDouble() * 0.2),
                                    ),
                                    fontFamily: 'Titillium Web',
                                    textBaseline: TextBaseline.alphabetic,
                                    fontSize: 25,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    decorationStyle: TextDecorationStyle.wavy,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
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
                                  width: 300,
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
                                        color: accent.withOpacity(0.5),
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
                                          color: Color.fromRGBO((accent.r * 255.0).round().clamp(0, 255), (accent.g * 255.0).round().clamp(0, 255), (accent.b * 255.0).round().clamp(0, 255), 0.8 + (math.Random().nextDouble() * 0.2)),
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
                                  const SizedBox(width: 20),
                                  Text(
                                    '       "Even in the darkest moments, light exists\n        if you have faith to see it" - Dean Koontz',
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
                              const SizedBox(height: 20),
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

          // endDrawer: Drawer(
          //   width: 250,
          //   elevation: 30,
          //   backgroundColor: isLight
          //       ? Color.fromARGB(255, 255, 255, 255)
          //       : Color.fromARGB(255, 19, 19, 19),
          //   shadowColor: isLight
          //       ? Color.fromARGB(255, 4, 13, 9)
          //       : Color.fromARGB(255, 184, 220, 193),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(20),
          //       bottomLeft: Radius.circular(20),
          //     ),
          //   ),
          //   child: Container(
          //     child: Column(
          //       children: [
          //         SizedBox(height: 100),
          //         ElevatedButton.icon(
          //           onPressed: () {},
          //           style: ElevatedButton.styleFrom(
          //             elevation: 0,
          //             backgroundColor: isLight
          //                 ? Color.fromARGB(255, 255, 255, 255)
          //                 : Color.fromARGB(255, 19, 19, 19),
          //           ),
          //           icon: Icon(
          //             Icons.person,
          //             color: isLight
          //                 ? Color.fromARGB(255, 16, 100, 56)
          //                 : Color.fromARGB(255, 184, 220, 193),
          //             size: 25,
          //           ),
          //           label: Text(
          //             'Profile',
          //             style: TextStyle(
          //               color: isLight
          //                   ? Color.fromARGB(255, 16, 100, 56)
          //                   : Color.fromARGB(255, 184, 220, 193),
          //               fontFamily: 'Nunito',
          //               fontSize: 25,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //         Text(
          //           '-------------------------',
          //           style: TextStyle(
          //             color: isLight
          //                 ? Color.fromARGB(255, 16, 100, 56)
          //                 : Color.fromARGB(255, 184, 220, 193),
          //             fontFamily: 'Nunito',
          //             fontSize: 20,
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //         SizedBox(height: 20),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Container(
          //               decoration: BoxDecoration(
          //                 border: Border.all(
          //                   color: isLight
          //                       ? Color.fromARGB(255, 16, 100, 56)
          //                       : Color.fromARGB(255, 184, 220, 193),
          //                   width: 2,
          //                 ),
          //                 borderRadius: BorderRadius.circular(20),
          //               ),
          //               child: Row(
          //                 children: [
          //                   GestureDetector(
          //                     onTap: () {
          //                       widget.onThemeChanged(true);
          //                     },
          //                     child: Container(
          //                       padding: EdgeInsets.symmetric(
          //                         horizontal: 20,
          //                         vertical: 12,
          //                       ),
          //                       decoration: BoxDecoration(
          //                         color: isLight
          //                             ? Color.fromARGB(255, 16, 100, 56)
          //                             : Colors.transparent,
          //                         borderRadius: BorderRadius.circular(13),
          //                       ),
          //                       child: Icon(
          //                         Icons.light_mode,
          //                         color: isLight
          //                             ? Color.fromARGB(255, 255, 255, 255)
          //                             : Color.fromARGB(255, 184, 220, 193),
          //                         size: 24,
          //                       ),
          //                     ),
          //                   ),
          //                   GestureDetector(
          //                     onTap: () {
          //                       widget.onThemeChanged(false);
          //                     },
          //                     child: Container(
          //                       padding: EdgeInsets.symmetric(
          //                         horizontal: 20,
          //                         vertical: 12,
          //                       ),
          //                       decoration: BoxDecoration(
          //                         color: !isLight
          //                             ? Color.fromARGB(255, 184, 220, 193)
          //                             : Colors.transparent,
          //                         borderRadius: BorderRadius.circular(16),
          //                       ),
          //                       child: Icon(
          //                         Icons.dark_mode,
          //                         color: !isLight
          //                             ? Color.fromARGB(255, 42, 42, 42)
          //                             : Color.fromARGB(255, 16, 100, 56),
          //                         size: 24,
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //         const SizedBox(height: 20),
          //         Text(
          //           '-------------------------',
          //           style: TextStyle(
          //             color: isLight
          //                 ? Color.fromARGB(255, 16, 100, 56)
          //                 : Color.fromARGB(255, 184, 220, 193),
          //             fontFamily: 'Nunito',
          //             fontSize: 20,
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        );
      },
    );
  }
}
