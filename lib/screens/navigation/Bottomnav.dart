import 'package:continents_app/screens/MainScreen/home.dart';
import 'package:continents_app/screens/navigation/profile.dart';
import 'package:continents_app/screens/navigation/wishlistnav.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MyHomePage(),
    const WishListPge(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.indigo,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              color: _selectedIndex == 0 ? Colors.white : Colors.grey,
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: const Icon(Icons.favorite),
              color: _selectedIndex == 1 ? Colors.white : Colors.grey,
              onPressed: () => _onItemTapped(1),
            ),
            IconButton(
              icon: const Icon(Icons.person),
              color: _selectedIndex == 2 ? Colors.white : Colors.grey,
              onPressed: () => _onItemTapped(2),
            ),
          ],
        ),
      ),
    );
  }
}
