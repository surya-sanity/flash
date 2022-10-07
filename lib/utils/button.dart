import 'package:flash/utils/color_palette.dart';
import 'package:flash/utils/size_config.dart';
import 'package:flash/utils/textstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Button extends StatelessWidget {
  const Button({
    this.height,
    this.width,
    this.borderRadius,
    @required this.onTap,
    this.color,
    this.isBusy = false,
    this.isDisabled,
    @required this.btnText,
    this.textColor,
    this.btnTextStyle,
    this.isBordered = false,
    this.borderColor,
    this.borderWidth,
  });
  final double height;
  final String btnText;
  final double width;
  final double borderRadius;
  final Function onTap;
  final Color color;
  final bool isBusy;
  final bool isDisabled;
  final Color textColor;
  final TextStyle btnTextStyle;
  final bool isBordered;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact().then((_) => onTap());
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: height ?? SizeConfig.longside / 16,
        width: isBusy
            ? (SizeConfig.longside / 16)
            : (width ?? SizeConfig.longside / 4),
        decoration: BoxDecoration(
            color: color ?? primary,
            borderRadius: BorderRadius.circular(borderRadius ?? 50),
            border: isBordered
                ? Border.all(color: borderColor ?? Colors.grey[300], width: 1)
                : Border.all(color: Colors.transparent)),
        child: Center(
          child: isBusy
              ? SizedBox(
                  height: SizeConfig.longside / 50,
                  width: SizeConfig.longside / 50,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 1.3,
                  ))
              : Text(
                  btnText ?? "",
                  style: btnTextStyle ??
                      h4Medium.copyWith(color: textColor ?? Colors.white),
                ),
        ),
      ),
    );
  }
}
