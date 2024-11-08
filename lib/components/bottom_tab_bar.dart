import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomTabBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;

  const BottomTabBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabTapped,
  }) : super(key: key);

  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return CurvedNavigationBar(
      index: widget.selectedIndex,
      height: 60.0,
      backgroundColor: Colors.blueAccent,
      color: isDarkMode ? Colors.grey[850]! : Colors.white,
      buttonBackgroundColor: isDarkMode ? Colors.grey[850]! : Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      items: const <Widget>[
        Icon(Icons.home, size: 30, color: Colors.blueAccent),
        Icon(Icons.person, size: 30, color: Colors.blueAccent),
      ],
      onTap: widget.onTabTapped,
    );
  }
}
