import 'dart:developer';
import 'package:flash/locator.dart';
import 'package:flash/models/flash_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/services/databaseservice.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseService database = DatabaseService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String> signInwithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await auth.signInWithCredential(credential);
      if (auth.currentUser != null) {
        User _user = auth.currentUser;
        await database.createUser(
          FlashUser(
              uId: _user.uid,
              userAvatar: _user.photoURL,
              userEmail: _user.email,
              createdAt: DateTime.now().toLocal(),
              online: true,
              userName: _user.displayName),
        );
        await locator.get<DatabaseService>().changeUserOnlineStatus(true);
      }
      return "Logged In";
    } on PlatformException catch (e) {
      return e.message;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  FlashUser _userFromFireBaseUser(User _user) {
    return _user != null ? FlashUser(uId: _user.uid) : null;
  }

  Stream<FlashUser> get userStatus {
    return auth.authStateChanges().map(_userFromFireBaseUser);
  }

  Future<String> signInEmailPass(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      await locator.get<DatabaseService>().changeUserOnlineStatus(true);
      return "Logged In";
    } on PlatformException catch (e) {
      if (e.code == 'user-not-found') {
        return "User not found.";
      }
      return e.message;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "User not found.";
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signUp(
      {String email,
      String password,
      String userName,
      bool online,
      String userAvatar}) async {
    try {
      UserCredential _result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User _user = _result.user;
      await database.createUser(
        FlashUser(
            uId: _user.uid,
            userAvatar: "avatar1.png",
            userEmail: email,
            createdAt: DateTime.now().toLocal(),
            online: true,
            userName: userName),
      );
      await locator.get<DatabaseService>().changeUserOnlineStatus(true);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> signOut() async {
    try {
      await locator
          .get<DatabaseService>()
          .changeUserOnlineStatus(false)
          .then((value) async {
        await auth.signOut();
        await _googleSignIn.signOut();
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> forgotPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return 'Reset link sent to mail';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "User not found.";
      }
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }
}
