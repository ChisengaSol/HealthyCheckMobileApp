import 'dart:io';

import 'package:flutter/foundation.dart';
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
       //home: Home(),
      //home: ProfileScreen(),
      home: Navigation(),
     // home: WelcomeScreen(),
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

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/health.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "HEALTHY",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: "CHECK",
                        //style: Theme.of(context).textTheme.display1,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return UserDetails();
                        },
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 25),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.lightBlue,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "START LEARNING",
                            style: Theme.of(context).textTheme.button.copyWith(
                                  color: Colors.black,
                                ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
