import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:projet_isi/ui_utilisateur/mainPage.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'accueil.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  dynamic token = await FlutterSession().get('token');
  runApp(MaterialApp(home: token!=''? MainPage() : AcceuilPage(), debugShowCheckedModeBanner: false));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AcceuilPage(),
    );
  }
}


