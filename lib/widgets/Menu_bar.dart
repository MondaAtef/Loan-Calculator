import 'package:flutter/material.dart';
import '../Screens/info_screen.dart';

class AppMenuBar extends StatelessWidget implements PreferredSizeWidget {
  final String appTitle;
  final VoidCallback onMenuPressed;

  const AppMenuBar({
    Key? key,
    required this.appTitle,
    required this.onMenuPressed,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  // دالة لفتح صفحة عن التطبيق
  void _showAboutPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => calculatePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        appTitle,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      backgroundColor: Color(0xFF3C467B),
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu_rounded, color: Colors.white, size: 28),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      elevation: 4,

    );
  }
}