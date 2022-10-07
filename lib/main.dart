import 'dart:developer';
import 'package:flash/locator.dart';
import 'package:flash/models/flash_user.dart';
import 'package:flash/screens/screens.dart';
import 'package:flash/services/auth_service.dart';
import 'package:flash/services/databaseservice.dart';
import 'package:flash/utils/utils.dart';
import 'package:flash/viewmodels/storageviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setup();
  // await DatabaseService().addRandomUsers(SampleUsers.initUsers);
  await locator.get<DatabaseService>().getUserAvatars();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(Chat()));
}

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (locator.get<AuthService>().auth.currentUser != null) {
      if (state == AppLifecycleState.resumed) {
        locator.get<DatabaseService>().changeUserOnlineStatus(true);
      } else if (state == AppLifecycleState.detached ||
          state == AppLifecycleState.inactive ||
          state == AppLifecycleState.paused) {
        locator.get<DatabaseService>().changeUserOnlineStatus(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(debugShowCheckedModeBanner: false, home: Splash());
        } else
        return ViewModelBuilder<StorageViewModel>.reactive(
            viewModelBuilder: () => locator.get<StorageViewModel>(),
            disposeViewModel: false,
            builder: (context, model, child) {
              return MaterialApp(
                theme: model.getTheme(),
                debugShowCheckedModeBanner: false,
                home: Wrapper(),
                builder: (context, widget) {
                  return ScrollConfiguration(
                    behavior: DefaultScrollBehavior(),
                    child: widget,
                  );
                },
              );
            });
      },
    );
  }
}
