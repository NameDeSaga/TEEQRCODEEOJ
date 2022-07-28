import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teeqrcodeoj/states/authen.dart';
import 'package:teeqrcodeoj/states/main_home.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (context) => const Authen(),
  '/mainHome': (context) => const MainHome(),
};

String? firstState;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        firstState = '/authen';
        runApp(const MyApp());
      } else {
        firstState = '/mainHome';
        runApp(const MyApp());
      }
    });
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: map,
      initialRoute: firstState ?? '/authen',
    );
  }
}
