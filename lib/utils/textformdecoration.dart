import 'package:flash/utils/utils.dart';
import 'package:flutter/material.dart';

textFormDecoration({String labelText, String hint, suffixIcon, prefixIcon}) =>
    InputDecoration(
      fillColor: Colors.transparent,
      filled: true,
      counterText: "",
      focusColor: Colors.grey,
      hoverColor: Colors.grey,
      labelText: labelText,
      errorMaxLines: 2,
      errorStyle: h5.copyWith(color: Colors.red),
      hintText: hint,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      hintStyle: h5.copyWith(color: Colors.grey),
      labelStyle: h5.copyWith(color: Colors.grey),
      contentPadding: EdgeInsets.all(15),
      focusedBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: new BorderSide(color: Colors.grey[300], width: 0.7),
      ),
      enabledBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: new BorderSide(color: Colors.grey[300], width: 0.7),
      ),
      errorBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: new BorderSide(color: Colors.grey[300], width: 0.7),
      ),
      focusedErrorBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: new BorderSide(color: Colors.grey[300], width: 0.7),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: new BorderSide(color: Colors.grey[300], width: 0.7),
      ),
    );
