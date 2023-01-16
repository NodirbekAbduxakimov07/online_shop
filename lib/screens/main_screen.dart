
import 'package:flutter/material.dart';
import 'package:online_shop/screens/favorite_screen.dart';
import 'package:online_shop/screens/home_screen.dart';
import 'package:online_shop/screens/map_screen.dart';
import 'package:online_shop/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

int _currentIndex = 0;

  final tabs = [
    HomeScreen(),
    FavoriteScreen(),
    MapScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  elevation: 0,
  title: Text("Shop"),
),
body: tabs[_currentIndex],
bottomNavigationBar: BottomNavigationBar(
  currentIndex: _currentIndex,
  showUnselectedLabels: true,
  type: BottomNavigationBarType.fixed,
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home",backgroundColor: Colors.lightBlue),
    BottomNavigationBarItem(icon: Icon(Icons.favorite_outline),label: "Favorite",backgroundColor: Colors.lightBlue),
    BottomNavigationBarItem(icon: Icon(Icons.map_outlined),label: "Location",backgroundColor: Colors.lightBlue),
    BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile",backgroundColor: Colors.lightBlue),
  ],
  onTap: ((index) => setState(() {
    _currentIndex = index;
  })),
  ),
    );
  }
}