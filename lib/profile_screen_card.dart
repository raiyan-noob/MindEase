import 'package:flutter/material.dart';

class ProfileScreenItem extends StatelessWidget {
  final String title;
  final IconData icon1;
  final IconData icon2;
  final VoidCallback onTap;
  final bool isLight;
  const ProfileScreenItem({
    super.key,
    required this.title,
    required this.icon1,
    required this.icon2,
    required this.onTap,
    required this.isLight,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = isLight ? Colors.white : const Color(0xFF1E1E1E);
    final textColor = isLight ? const Color(0xFF0F5132) : const Color(0xFFB8DCC1);
    final iconColor = isLight ? const Color.fromRGBO(0, 152, 139, 1) : const Color(0xFFB8DCC1);
    final shadowColor = isLight ? const Color.fromRGBO(0, 152, 139, 0.15) : const Color(0xFF2A2A2A);
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5,
        color: cardColor,
        shadowColor: shadowColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon1, size: 30, color: iconColor),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isLight ? const Color.fromRGBO(0, 152, 139, 0.15) : const Color(0xFF2A2A2A),
                ),
                child: Icon(
                  icon2,
                  size: 16,
                  color: iconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
