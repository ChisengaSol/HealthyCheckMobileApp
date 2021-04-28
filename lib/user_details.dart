import 'package:flutter/material.dart';
import 'package:healthycheck/auth.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  body: ChangeNotifier(
      //    create: (context) => GoogleSignInProvider(),
      //    child: SignUpWidget(),
      //  ),
      body: Center(
      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginButton(),
            UserProfile(),
            
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
          padding: EdgeInsets.all(20),
          child: Text(_profile.toString()),
        ),
        Text(_loading.toString()),
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
          
          return MaterialButton(
            onPressed: () => authService.signOut(),
            color: Colors.red,
            child: Text("Log out"),
          );
        } else {
          return MaterialButton(
            onPressed: () => authService.googleSignIn(),
            child: Text("Login with google account"),
            color: Colors.black12,
          );
          
        }
      },
    );
  }
}
