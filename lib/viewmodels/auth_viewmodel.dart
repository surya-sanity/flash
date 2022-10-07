import 'package:flash/screens/wrapper.dart';
import 'package:flash/services/auth_service.dart';
import 'package:flash/utils/approutes.dart';
import 'package:flash/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

var isLogginIn;
var isSigningUp;
var sendingReset;
var isGoogleLogin;
var isFacebookLogin;

class Authviewmodel extends BaseViewModel {
  //login controllers and keys
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();

  //signup controllers and keys
  var signUpNameController = TextEditingController();
  var signUpEmailController = TextEditingController();
  var signUpPasswordController = TextEditingController();
  var signUpConfirmPasswordController = TextEditingController();

  //forgotpassword controllers and keys
  var resetEmailController = TextEditingController();

  //login with email and password
  Future loginWithEmailPass(BuildContext context) async {
    setBusyForObject(isLogginIn, true);
    await AuthService()
        .signInEmailPass(
            loginEmailController.text, loginPasswordController.text)
        .then((value) {
      loginEmailController.clear();
      loginPasswordController.clear();
      showSnackBar(context, SnackBar(content: Text(value ?? "")));
      AppRoutes.makeFirst(context, Wrapper());
    });
    setBusyForObject(isLogginIn, false);
  }

  //googlesignin
  Future loginWithGoogle(BuildContext context) async {
    setBusyForObject(isGoogleLogin, true);
    await AuthService().signInwithGoogle().then((value) {
      if (value != null) {
        loginEmailController.clear();
        loginPasswordController.clear();
        showSnackBar(context, SnackBar(content: Text(value ?? "")));
        AppRoutes.makeFirst(context, Wrapper());
      }
    });
    setBusyForObject(isGoogleLogin, false);
  }

  //forgotpassword
  Future sendResetPassLink(BuildContext context) async {
    setBusyForObject(sendingReset, true);
    await AuthService().forgotPassword(resetEmailController.text).then((value) {
      resetEmailController.clear();
      AppRoutes.pop(context);
      showSnackBar(context, SnackBar(content: Text(value ?? "")));
    });
    setBusyForObject(sendingReset, false);
    return;
  }

  //Signupwith email and pass
  Future signUpWithEmailPass(BuildContext context) async {
    setBusyForObject(isSigningUp, true);
    await AuthService()
        .signUp(
      email: signUpEmailController.text,
      online: true,
      password: signUpPasswordController.text,
      userAvatar: 'avatar1.png',
      userName: signUpNameController.text,
    )
        .then((value) {
      signUpNameController.clear();
      signUpEmailController.clear();
      signUpPasswordController.clear();
      showSnackBar(context, SnackBar(content: Text(value ?? "")));
      AppRoutes.makeFirst(context, Wrapper());
    });
    setBusyForObject(isSigningUp, false);
  }

  Future signOut(BuildContext context) async {
    await AuthService().signOut().then((value) {
      showSnackBar(
          context,
          SnackBar(
            content: Text(value ? 'Logged out' : 'Logout Failed'),
          ));
      AppRoutes.makeFirst(context, Wrapper());
    });
  }
}
