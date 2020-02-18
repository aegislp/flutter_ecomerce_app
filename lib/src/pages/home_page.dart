import 'package:flutter/material.dart';
import 'package:loginuser/src/bloc/provider.dart';


class HomePage extends StatelessWidget {

  static final routeName = 'home';
  
  @override
  Widget build(BuildContext context) {
    
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page")
      ),
      body: Center(
        child: Text("${bloc.email} - ${bloc.pass}"),
      ),
    );
  }
}