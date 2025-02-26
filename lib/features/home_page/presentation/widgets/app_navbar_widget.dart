import 'package:flutter/material.dart';

class AppNavbarWidget extends StatelessWidget {
  const AppNavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFFFAFAFA),
      selectedItemColor: Color(0xFF2B9794),
      unselectedItemColor: Color(0xFFA1A5B7),
      showUnselectedLabels: true,
      unselectedFontSize: 12,
      elevation: 5,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'My Orders'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.face), label: 'Profile'),
      ],
    );
  }
}
