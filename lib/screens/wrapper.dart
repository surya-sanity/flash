import 'package:flash/locator.dart';
import 'package:flash/screens/screens.dart';
import 'package:flash/services/auth_service.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (locator.get<AuthService>().auth.currentUser == null) {
      return Login();
    }
    return Home();
  }
}
