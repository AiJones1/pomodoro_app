import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Pomodoro App'),
      
      backgroundColor: const Color(0xFF4B0082),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); 
}