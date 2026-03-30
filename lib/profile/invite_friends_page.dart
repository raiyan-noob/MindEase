
import 'package:flutter/material.dart';

class InviteFriends extends StatelessWidget {
  final ValueNotifier<bool> isLightNotifier;
  final ValueChanged<bool> onThemeChanged;
  const InviteFriends({
    super.key,
    required this.isLightNotifier,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isLightNotifier,
      builder: (context, isLight, _) {
        final bg = isLight ? Colors.white : const Color(0xFF121212);
        final textColor = isLight
            ? const Color(0xFF0F5132)
            : const Color(0xFFB8DCC1);
        return Scaffold(
          backgroundColor: bg,
          appBar: AppBar(
            backgroundColor: isLight
                ?// const Color.fromRGBO(0, 152, 139, 1)
                  const Color(0xFF0F5132)
                :// const Color(0xFF193022),
                  const Color(0xFFB8DCC1),
            title: Text(
              'Invite Friends',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Text(
              'Invite Friends Page',
              style: TextStyle(color: textColor),
            ),
          ),
        );
      },
    );
  }
}