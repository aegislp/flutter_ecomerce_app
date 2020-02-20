import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loginuser/src/bloc/provider.dart';
import 'package:loginuser/src/pages/home_page.dart';
import 'package:loginuser/src/pages/login_page.dart';
import 'package:loginuser/src/pages/producto_page.dart';
import 'package:loginuser/src/pages/signup_page.dart';
import 'package:loginuser/src/shared_pref/prefeencias_usuario.dart';
 
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp()); 
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white
    ));
    return Provider(
      child: MaterialApp(
        title: 'Login App',
        initialRoute: LoginPage.routeName,
        
        routes: {
          LoginPage.routeName: (BuildContext context)=> LoginPage(),
          HomePage.routeName: (BuildContext context)=> HomePage(),
          ProductoPage.routeName: (BuildContext context)=> ProductoPage(),
          SignupPage.routeName: (BuildContext context)=> SignupPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      ),
      
    );
  }
}