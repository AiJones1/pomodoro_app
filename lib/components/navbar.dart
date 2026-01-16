import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final Function(String) onNavigate;
  
  const Navbar({
    super.key,
    required this.onNavigate,
  });
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF4B0082),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.purple[200],
      onTap: (index) {
        if (index == 0) {
          onNavigate('timer-screen');
        } else if (index == 1) {
          onNavigate('settings-screen');
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.timer),
          label: 'Timer',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}