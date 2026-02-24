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

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isLightNotifier,
      builder: (context, isLight, _) {
        return Scaffold(
          backgroundColor: isLight
              ? Color.fromARGB(255, 255, 255, 255)
              : Color.fromARGB(255, 34, 34, 34),
          appBar: AppBar(
            leading: Image.asset('assets/Mindease.jpg', fit: BoxFit.cover),
            title: const Text(
              'MindEase',
              style: TextStyle(
                color: Color.fromARGB(255, 211, 224, 217),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),

            backgroundColor: Color.fromRGBO(0, 152, 139, 1),
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  isLight ? 'assets/wm.jpg' : 'assets/dm.jpg',
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

                              Text(
                                'Hello, Raiyan!',
                                style: TextStyle(
                                  color: isLight
                                      ? Color.fromRGBO(
                                          0,
                                          152,
                                          139,
                                          1,
                                        ).withOpacity(
                                          0.8 +
                                              (math.Random().nextDouble() *
                                                  0.2),
                                        )
                                      : Color.fromARGB(
                                          255,
                                          184,
                                          220,
                                          193,
                                        ).withOpacity(
                                          0.8 +
                                              (math.Random().nextDouble() *
                                                  0.2),
                                        ),
                                  fontFamily: 'Titillium Web',
                                  textBaseline: TextBaseline.ideographic,
                                  fontSize: 25,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  decorationStyle: TextDecorationStyle.wavy,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'How are you feeling today?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isLight
                                      ? Color.fromRGBO(
                                          0,
                                          152,
                                          139,
                                          1,
                                        ).withOpacity(
                                          0.8 +
                                              (math.Random().nextDouble() *
                                                  0.2),
                                        )
                                      : Color.fromARGB(
                                          255,
                                          184,
                                          220,
                                          193,
                                        ).withOpacity(
                                          0.8 +
                                              (math.Random().nextDouble() *
                                                  0.2),
                                        ),
                                  fontFamily: 'Nunito',
                                  textBaseline: TextBaseline.alphabetic,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  decorationStyle: TextDecorationStyle.wavy,
                                ),
                              ),
                              const SizedBox(height: 25),
                              Container(
                                width: 300,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: isLight
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : Color.fromARGB(255, 3, 2, 2),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: isLight
                                        ? Color.fromRGBO(0, 152, 139, 1)
                                        : Color.fromARGB(255, 184, 220, 193),
                                    width: 2,
                                  ),
                                ),
                                child: DropdownButton<String>(
                                  value: selectedFeeling,
                                  hint: Text(
                                    'Dive into your feelings',
                                    style: TextStyle(
                                      color: isLight
                                          ? Color.fromRGBO(
                                              0,
                                              152,
                                              139,
                                              1,
                                            ).withOpacity(
                                              0.8 +
                                                  (math.Random().nextDouble() *
                                                      0.2),
                                            )
                                          : Color.fromARGB(
                                              255,
                                              184,
                                              220,
                                              193,
                                            ).withOpacity(
                                              0.8 +
                                                  (math.Random().nextDouble() *
                                                      0.2),
                                            ),
                                      fontFamily: 'Titillium Web',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  iconDisabledColor: isLight
                                      ? Color.fromARGB(255, 16, 100, 56)
                                      : Color.fromARGB(255, 184, 220, 193),
                                  dropdownColor: isLight
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : Color.fromARGB(255, 3, 2, 2),
                                  iconEnabledColor: isLight
                                      ? Color.fromARGB(255, 16, 100, 56)
                                      : Color.fromARGB(255, 184, 220, 193),
                                  underline: SizedBox.shrink(),
                                  borderRadius: BorderRadius.circular(15),
                                  items:
                                      <String>[
                                        'Sad',
                                        'Depressed',
                                        'Anxious',
                                        'Frustrated',
                                        'Angry',
                                        ' Hopeless',
                                      ].map<DropdownMenuItem<String>>((
                                        String value,
                                      ) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              color: isLight
                                                  ? Color.fromRGBO(
                                                      0,
                                                      152,
                                                      139,
                                                      1,
                                                    )
                                                  : Color.fromARGB(
                                                      255,
                                                      184,
                                                      220,
                                                      193,
                                                    ),
                                              fontFamily: 'Titillium Web',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                  onChanged: (String? newValue) async {
                                    setState(() {
                                      selectedFeeling = newValue;
                                    });
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SecondPage(
                                          feeling: selectedFeeling!,
                                          isLightNotifier:
                                              widget.isLightNotifier,
                                          onThemeChanged: widget.onThemeChanged,
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      selectedFeeling = null;
                                    });
                                  },
                                  isExpanded: true,
                                ),
                              ),

                              const Spacer(),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 20),
                                  Text(
                                    '"Even in the darkest moments, light exists\n if you have faith to see it" - Dean Koontz',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: isLight
                                          ? Color.fromRGBO(0, 152, 139, 1)
                                          : Color.fromARGB(255, 184, 220, 193),
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
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
          endDrawer: Drawer(
            width: 250,
            elevation: 30,
            backgroundColor: isLight
                ? Color.fromARGB(255, 255, 255, 255)
                : Color.fromARGB(255, 19, 19, 19),
            shadowColor: isLight
                ? Color.fromARGB(255, 4, 13, 9)
                : Color.fromARGB(255, 184, 220, 193),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: isLight
                          ? Color.fromARGB(255, 255, 255, 255)
                          : Color.fromARGB(255, 19, 19, 19),
                    ),
                    icon: Icon(
                      Icons.person,
                      color: isLight
                          ? Color.fromARGB(255, 16, 100, 56)
                          : Color.fromARGB(255, 184, 220, 193),
                      size: 25,
                    ),
                    label: Text(
                      'Profile',
                      style: TextStyle(
                        color: isLight
                            ? Color.fromARGB(255, 16, 100, 56)
                            : Color.fromARGB(255, 184, 220, 193),
                        fontFamily: 'Nunito',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '-------------------------',
                    style: TextStyle(
                      color: isLight
                          ? Color.fromARGB(255, 16, 100, 56)
                          : Color.fromARGB(255, 184, 220, 193),
                      fontFamily: 'Nunito',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isLight
                                ? Color.fromARGB(255, 16, 100, 56)
                                : Color.fromARGB(255, 184, 220, 193),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget.onThemeChanged(true);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isLight
                                      ? Color.fromARGB(255, 16, 100, 56)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Icon(
                                  Icons.light_mode,
                                  color: isLight
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : Color.fromARGB(255, 184, 220, 193),
                                  size: 24,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.onThemeChanged(false);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: !isLight
                                      ? Color.fromARGB(255, 184, 220, 193)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  Icons.dark_mode,
                                  color: !isLight
                                      ? Color.fromARGB(255, 42, 42, 42)
                                      : Color.fromARGB(255, 16, 100, 56),
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '-------------------------',
                    style: TextStyle(
                      color: isLight
                          ? Color.fromARGB(255, 16, 100, 56)
                          : Color.fromARGB(255, 184, 220, 193),
                      fontFamily: 'Nunito',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
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
