import 'package:flutter/material.dart';

class AppRoutes {
  static Future push(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static Future replace(BuildContext context, Widget page) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  static Future makeFirst(BuildContext context, Widget page) {
    Navigator.of(context).popUntil((predicate) => predicate.isFirst);
    return Navigator.of(context).pushReplacement(
      new MaterialPageRoute(builder: (context) => page),
    );
  }

  static pop(BuildContext context, {bool popWith}) {
    if (popWith == null) {
      return Navigator.of(context).pop();
    }
    return Navigator.of(context).pop(popWith);
  }
}
