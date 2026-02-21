import 'package:flutter/material.dart';

class ThirdPage extends StatefulWidget {
  final String selection;
  final String feeling;
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;

  ThirdPage({
    required this.selection,
    required this.feeling,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isLightNotifier,
      builder: (context, isLight, _) {
        return Scaffold(
          backgroundColor: isLight
              ? Color.fromARGB(255, 255, 255, 255)
              : Color.fromARGB(255, 19, 19, 19),
          appBar: AppBar(
            backgroundColor: isLight
                ? Color.fromARGB(255, 255, 255, 255)
                : Color.fromARGB(255, 19, 19, 19),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: isLight
                    ? Color.fromARGB(255, 6, 6, 6)
                    : Color.fromARGB(255, 194, 226, 202),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 50),
                  width: 400,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: isLight
                          ? Color.fromARGB(255, 16, 100, 56)
                          : Color.fromARGB(255, 184, 220, 193),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: isLight
                            ? Color.fromARGB(255, 184, 220, 193)
                            : Color.fromARGB(255, 16, 100, 56),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                    color: isLight
                        ? Color.fromARGB(255, 254, 254, 254)
                        : Color.fromARGB(255, 34, 34, 34),
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    'It'
                    's okay to feel ${widget.feeling} sometimes, Raiyan. Remember, you know yourself best and you can be your biggest healer.',
                    style: TextStyle(
                      fontSize: 23,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w900,
                      color: isLight
                          ? Color.fromARGB(255, 16, 100, 56)
                          : Color.fromARGB(255, 192, 226, 201),
                    ),
                  ),
                ),
              ],
            ),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
