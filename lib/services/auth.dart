import 'package:firebase_auth/firebase_auth.dart';
import 'package:reservationapp/models/user.dart';
import 'package:reservationapp/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseuser(FirebaseUser user) {
    return user != null
        ? User(uid: user.uid, displayName: user.displayName)
        : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseuser);
    // .map((FirebaseUser user) => _userFromFirebaseuser(user));
  }

  Future signUpwithEmail(String email, String password, String name) async {
    try {
      print(email);
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email.toString().trim(), password: password.toString().trim());
      FirebaseUser user = result.user;
      await nameUpdateAfterRegister(name);
      print("Name Updated");
//      print(await DataBaseService(uid: user.uid).updateUserData('personal', 'Go Home', '232342445'));
      return _userFromFirebaseuser(user);
    } catch (e) {
      return null;
    }
  }

  // Future getCurrentUser() async {
  //   FirebaseUser user = await FirebaseAuth.instance.currentUser();
  //   if(user != null){
  //     return user;
  //   }else{
  //     print('null');
  //   }
  // }

  Future signInwithEmail(String email, String password) async {
    try {
      print(email);
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email.toString().trim(), password: password.toString().trim());
      FirebaseUser user = result.user;

      return _userFromFirebaseuser(user);
    } catch (e) {
      return null;
    }
  }

  Future nameUpdateAfterRegister(String name) async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();

      UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
      userUpdateInfo.displayName = name;

      user.updateProfile(userUpdateInfo);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signInAnom() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseuser(user);
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  // Sign Out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
