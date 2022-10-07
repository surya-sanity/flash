import 'package:flash/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor: !lightMode
          ? Color(0xe1f5fe).withOpacity(1.0)
          : Colors.black.withOpacity(1.0),
      body: Center(
        child: Container(
            height: SizeConfig.longside / 5,
            width: SizeConfig.longside / 5,
            child: SvgPicture.asset('assets/images/flash.svg')),
      ),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
