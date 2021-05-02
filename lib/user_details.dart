import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthycheck/auth.dart';
import 'package:healthycheck/health_condition.dart';
import 'package:healthycheck/ui/pages/health_details.dart';
import 'package:healthycheck/update_profile_pic.dart';
import 'package:healthycheck/water_reminder.dart';
import 'package:healthycheck/weight_screen.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uemail = user.email;

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      //  body: ChangeNotifier(
      //    create: (context) => GoogleSignInProvider(),
      //    child: SignUpWidget(),
      //  ),
      appBar: AppBar(
        title: Text("Options"),
        backgroundColor: const Color(0xff200bb7),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            UserProfile(),
            SizedBox(
              height: 5.0,
            ),
            LoginButton(),
          ],
        ),
      ),
    );
  }
}

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Map<String, dynamic> _profile;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    authService.profile.listen((state) => setState(() => _profile = state));
    authService.loading.listen((state) => setState(() => _loading = state));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          // child: Text(_profile.toString()),
        ),
        // Text(_loading.toString()),
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // return MaterialButton(
          //   onPressed: () => authService.signOut(),
          //   color: Colors.red,
          //   child: Text("Log out"),
          // );
          return Column(
            children: <Widget>[
              // MaterialButton(
              //   onPressed: () => authService.signOut(),
              //   color: Colors.red,
              //   child: Text("Log out"),
              // ),
              // Text("My Health options"),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.person, size: 50),
                      title: Text('Update profile picture'),
                      //subtitle: Text('TWICE'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateProfilePic(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.book_online, size: 50),
                      title: Text('My Weight today'),
                      //subtitle: Text('TWICE'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeightsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.book, size: 50),
                      title: Text('My Health Condition'),
                      //subtitle: Text('TWICE'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHealthCondition(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.local_drink, size: 50),
                      title: Text('Drink water'),
                      //subtitle: Text('TWICE'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DrinkWaterReminder(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.0)),
            elevation: 18.0,
            color: Colors.grey,
            clipBehavior: Clip.antiAlias, // Add Th
            child: MaterialButton(
              minWidth: 200.0,
              height: 35,
              padding: EdgeInsets.only(),
              onPressed: () => authService.googleSignIn(),
              child: Text("Login with google account"),
              // color: Colors.black12,
            ),
          );
        }
      },
    );
  }
}
