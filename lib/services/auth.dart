import 'package:escapers_app/models/models.dart';
import 'package:escapers_app/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/services.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getCurrentUser() {
    final User user = _auth.currentUser;
    final uid = user.uid;

    print(uid);
    return uid;
  }

  // create user obj based on firebase user
  TheUser _userFromFirebaseUser(User user) {
    return user != null ? TheUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<TheUser> get user {
    return _auth
        .authStateChanges()
        // .map((User user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

// register with email and password
  Future registerWithEmailAndPassword(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).addUserData(name,email,'Not Set', 'null');

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<User> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          Get.snackbar(
            'Error',
            'Something is not right. try again',
            duration: Duration(seconds: 3),
            backgroundColor: kPrimaryColor,
            colorText: kWhite,
            snackPosition: SnackPosition.BOTTOM,
            borderRadius: 0,
          );
        } else if (e.code == 'invalid-credential') {
          Get.snackbar(
            'Error',
            'Something is not right. try again',
            duration: Duration(seconds: 3),
            backgroundColor: kPrimaryColor,
            colorText: kWhite,
            snackPosition: SnackPosition.BOTTOM,
            borderRadius: 0,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Something is not right. try again',
          duration: Duration(seconds: 3),
          backgroundColor: kPrimaryColor,
          colorText: kWhite,
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 0,
        );
      }
    }
    //create a new document for the user with the uid
      await DatabaseService(uid: user.uid)
          .addUserData(user.displayName, user.email, 'Not set', user.photoURL);
    return null;
  }

// sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
