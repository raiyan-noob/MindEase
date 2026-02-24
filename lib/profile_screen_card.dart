import 'package:flutter/material.dart';

class ProfileScreenItem extends StatelessWidget {
  final String title;
  final IconData icon1;
  final IconData icon2;
  final VoidCallback onTap;
  const ProfileScreenItem({
    super.key,
    required this.title,
    required this.icon1,
    required this.icon2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5,
        color: Colors.white,
        shadowColor: const Color.fromRGBO(0, 152, 139, 0.15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon1, size: 30, color: Color.fromRGBO(0, 152, 139, 1)),
      
              const SizedBox(width: 16),
      
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 152, 139, 1),
                  ),
                ),
              ),
      
              //const Spacer(),
      
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(0, 152, 139, 0.15),
                ),
                child: Icon(
                  icon2,
                  size: 16,
                  color: Color.fromRGBO(0, 152, 139, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
