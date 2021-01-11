import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/helpers/functions.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_app/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  List<String> adminsList = [
    '6MfFEExg2VgiC9F8aGKUARKzfSG2',
    'Tdg5GNZuyAbKYrHi51RZ1p1roCI3'
  ];

  @override
  void initState() {
    checkUserLoggedInStatus();
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('USER SINGED OUT');
        HelperFunctions.saveUserLoggedDetails(isLoggedin: false);
        HelperFunctions.setAdminIsLoggedIn(isAdmin: false);
        HelperFunctions.setUserEmail(email: null);
      } else {
        HelperFunctions.saveUserLoggedDetails(isLoggedin: true);
        print("USER IS HERE !");
        authService
            .getUserTokenId()
            .then((val) => HelperFunctions.setUserToken(token: val));
        HelperFunctions.setUserEmail(email: user.email);
        if (adminsList.contains(user.uid)) {
          print('ADMIN IS HERE');
          HelperFunctions.setAdminIsLoggedIn(isAdmin: true);
        }
      }
    });
  }

  checkUserLoggedInStatus() async {
    HelperFunctions.getUserLoggedInDetails().then((value) {
      setState(() {
        _isLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizzApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (_isLoggedIn ?? false) ? Home() : SignIn(),
    );
  }
}
