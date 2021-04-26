import 'package:flutter/material.dart';
import 'package:healthycheck/ui/pages/profile_screen.dart';
import 'package:healthycheck/views/home.dart';

import '../user_details.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthyCheck Recipes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     // home: Home(),
     //home: ProfileScreen(),
     home: Navigation(),
    );
  }
}

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;
  final List<Widget> _list = [
    ProfileScreen(),
    //SearchScreen(),
    Home(),
    UserDetails(),
    //UserProfile(),
    
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _list[_currentIndex],

      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        child: BottomNavigationBar(
          iconSize: 40,
          selectedIconTheme: IconThemeData(color: const Color(0xff200bb7)),
          unselectedIconTheme: IconThemeData(color: Colors.black12),
          currentIndex: _currentIndex,
          onTap: onTappedBar,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Icon(Icons.home)),
              title: Text(
                "Home",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Icon(Icons.search)),
              title: Text(
                "Search",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Icon(Icons.person)),
              title: Text(
                "Profile",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}



