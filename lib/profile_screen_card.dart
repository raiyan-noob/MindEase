import 'package:flutter/material.dart';

class ProfileScreenItem extends StatefulWidget {
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
  State<ProfileScreenItem> createState() => _ProfileScreenItemState();
}

class _ProfileScreenItemState extends State<ProfileScreenItem> {
  @override
  Widget build(BuildContext context) {
    final cardColor = widget.isLight ? Colors.white : const Color(0xFF1E1E1E);
    final deepGreen = widget.isLight ? const Color(0xFF0F5132) : const Color(0xFFB8DCC1);
    final shadowColor = widget.isLight ? const Color.fromRGBO(0, 152, 139, 0.15) : const Color(0xFF2A2A2A);
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        elevation: 5,
        color: cardColor,
        shadowColor: shadowColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(widget.icon1, size: 30, color: deepGreen),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: deepGreen,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.isLight ? const Color.fromRGBO(0, 152, 139, 0.15) : const Color(0xFF2A2A2A),
                ),
                child: Icon(
                  widget.icon2,
                  size: 16,
                  color: deepGreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
