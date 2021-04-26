import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Rx<FirebaseUser> userebaseUser user =
  Observable<User> user;
  Observable<Map<String, dynamic>> profile;
  PublishSubject loading = PublishSubject();

  //constructor
  AuthService() {
    user = Observable(_auth.authStateChanges());

    profile = user.switchMap((User u) {
      if (u != null) {
        return _db
            .collection('users')
            .doc(u.uid)
            .snapshots()
            .map((event) => event.data());
      } else {
        return Observable.just({});
      }
    });
  }

  Future<User> googleSignIn() async {
    loading.add(true);
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // User user = await _auth.signInWithGoogle(
    //   accessToken: googleAuth.accessToken,
    //   idToken: googleAuth.idToken,
    // );
    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    updateUserData(user);
    print("signed in " + user.displayName);
    loading.add(false);
    return user;
  }

  void updateUserData(User user) async {
    DocumentReference ref = _db.collection('users').doc(user.uid);

    return ref.set(
      {
        'uid': user.uid,
        'email': user.email,
        'photoUrl': user.photoURL,
        'displayName': user.displayName,
        'lastSeen': DateTime.now(),
      },
      SetOptions(merge: true),
    );
  }

  void signOut() {
    _auth.signOut();
  }
}

final AuthService authService = AuthService();
