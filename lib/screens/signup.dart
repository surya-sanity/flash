import 'package:flash/locator.dart';
import 'package:flash/utils/approutes.dart';
import 'package:flash/utils/utils.dart';
import 'package:flash/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class SignUp extends StatefulWidget {
  static final signUpKey = GlobalKey<FormState>();

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<Authviewmodel>.reactive(
        viewModelBuilder: () => locator.get<Authviewmodel>(),
        disposeViewModel: false,
        builder: (context, model, child) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                SizeConfig.longside / 10,
              ),
              child: SafeArea(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.sidePadding,
                        left: SizeConfig.sidePadding,
                        right: SizeConfig.sidePadding),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: SizeConfig.longside / 12,
                        width: SizeConfig.longside / 12,
                        child: SvgPicture.asset(
                          'assets/images/flash.svg',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.sidePadding + 10.0,
                  vertical: SizeConfig.sidePadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Form(
                        key: SignUp.signUpKey,
                        child: ListView(
                          children: [
                            SizedBox(height: SizeConfig.longside / 40),
                            Text(
                              'Create a Flash Account',
                              style: h2Medium,
                            ),
                            SizedBox(height: SizeConfig.longside / 40),
                            Text.rich(
                              TextSpan(
                                style: h5.copyWith(height: 1.5),
                                children: [
                                  TextSpan(
                                      text: "By Signing Up, you agree to our "),
                                  TextSpan(
                                      text: "User Agreement ",
                                      style: h5.copyWith(
                                          color: primary,
                                          decoration:
                                              TextDecoration.underline)),
                                  TextSpan(text: "and "),
                                  TextSpan(
                                      text: "Privacy Policy.",
                                      style: h5.copyWith(
                                          color: primary,
                                          decoration:
                                              TextDecoration.underline)),
                                ],
                              ),
                            ),
                            SizedBox(height: SizeConfig.longside / 40),
                            TextFormField(
                              decoration: textFormDecoration(labelText: "Name"),
                              maxLength: 45,
                              keyboardType: TextInputType.name,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: model.signUpNameController,
                              validator: (value) {
                                if (value.trim().isEmpty || value.isEmpty)
                                  return "Required";
                                return null;
                              },
                            ),
                            SizedBox(height: SizeConfig.longside / 40),
                            TextFormField(
                              decoration:
                                  textFormDecoration(labelText: "Email"),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                              controller: model.signUpEmailController,
                              validator: (value) {
                                if (value.trim().isEmpty || value.isEmpty)
                                  return "Required";
                                if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value))
                                  return 'Enter a valid e-mail';
                                return null;
                              },
                            ),
                            SizedBox(height: SizeConfig.longside / 40),
                            TextFormField(
                              decoration:
                                  textFormDecoration(labelText: "Password"),
                              maxLength: 15,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: true,
                              controller: model.signUpPasswordController,
                              validator: (value) {
                                if (value.trim().isEmpty || value.isEmpty)
                                  return "Required";
                                return null;
                              },
                            ),
                            SizedBox(height: SizeConfig.longside / 40),
                            GestureDetector(
                              onTap: () {
                                AppRoutes.pop(context);
                              },
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Having an Account?  ",
                                      style: h5,
                                    ),
                                    TextSpan(
                                      text: "Log in",
                                      style: h4Medium.copyWith(color: primary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: SizeConfig.longside / 40),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Button(
                        isBusy: model.busy(isSigningUp),
                        height: SizeConfig.longside / 20,
                        width: SizeConfig.longside / 5,
                        onTap: () {
                          if (SignUp.signUpKey.currentState.validate()) {
                            model.signUpWithEmailPass(context);
                          }
                        },
                        btnText: "Continue",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget socialLogin({
    BuildContext context,
    String iconPath,
    Function onTap,
    String socialName,
  }) {
    return Align(
      child: Container(
        height: SizeConfig.longside / 15,
        width: SizeConfig.screenWidth / 1.2,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[300],
            ),
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                height: SizeConfig.longside / 28,
                width: SizeConfig.longside / 28,
                child: SvgPicture.asset(iconPath),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                'Continue with $socialName',
                style: h5Medium,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
