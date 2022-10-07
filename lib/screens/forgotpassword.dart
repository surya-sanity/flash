import 'package:flash/utils/approutes.dart';
import 'package:flash/utils/size_config.dart';
import 'package:flash/utils/utils.dart';
import 'package:flash/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

class ForgotPassword extends StatefulWidget {
  static final resetKey = GlobalKey<FormState>();

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<Authviewmodel>.reactive(
      viewModelBuilder: () => Authviewmodel(),
      builder: (context, model, child) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SafeArea(
                child: Form(
                  key: ForgotPassword.resetKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.sidePadding,
                        vertical: SizeConfig.sidePadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Forgot your password ?',
                          style: h3Medium,
                        ),
                        SizedBox(height: SizeConfig.longside / 40),
                        TextFormField(
                          decoration: textFormDecoration(
                              labelText: "Your registered email"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.trim().isEmpty || value.isEmpty)
                              return "Required";
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) return 'Enter a valid e-mail';
                            return null;
                          },
                          controller: model.resetEmailController,
                        ),
                        SizedBox(height: SizeConfig.longside / 40),
                        Text(
                          "Unfortunately, If you have never given us your email, we will not be able to reset your password.",
                          style: h5Medium,
                        ),
                        SizedBox(height: SizeConfig.longside / 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                HapticFeedback.mediumImpact().then(
                                  (_) {
                                    AppRoutes.pop(context);
                                  },
                                );
                              },
                              child: Text(
                                "CANCEL",
                                style: h4Medium.copyWith(
                                  color: primary,
                                ),
                              ),
                            ),
                            SizedBox(width: SizeConfig.longside / 40),
                            GestureDetector(
                              onTap: () {
                                if (ForgotPassword.resetKey.currentState
                                    .validate()) {
                                  unfocusKeyboard();
                                  HapticFeedback.mediumImpact().then(
                                    (_) {
                                      model.sendResetPassLink(context);
                                    },
                                  );
                                }
                              },
                              child: model.busy(sendingReset)
                                  ? SizedBox(
                                      height: SizeConfig.longside / 50,
                                      width: SizeConfig.longside / 50,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          primary,
                                        ),
                                        strokeWidth: 1.3,
                                      ),
                                    )
                                  : Text(
                                      "SEND LINK",
                                      style: h4Medium.copyWith(
                                        color: primary,
                                      ),
                                    ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
