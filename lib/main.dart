import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loginuser/src/bloc/provider.dart';
import 'package:loginuser/src/pages/home_page.dart';
import 'package:loginuser/src/pages/login_page.dart';
 
void main() => runApp(MyApp());
 
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
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      ),
      
    );
  }
}