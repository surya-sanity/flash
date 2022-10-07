import 'package:flutter/material.dart';

unfocusKeyboard() {
  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
}
