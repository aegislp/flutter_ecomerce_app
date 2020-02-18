import 'package:flutter/material.dart';
import 'package:loginuser/src/bloc/login_bloc.dart';
export 'package:loginuser/src/bloc/login_bloc.dart';



/**
 * Mi InheritedWidget
 */
class Provider extends InheritedWidget{
  
  //el recurso al cual todos en el arbol van a tener acceso a travez de mi.
  static Provider _instancia;
  final loginBloc = LoginBloc();

  factory Provider({Key key, Widget child }){

    if(_instancia == null){
      _instancia = Provider._(key: key, child:child);
    }

    return _instancia;
  }

  //estrucutra de constructor tipica de estos caso
  Provider._({Key key, Widget child }) : super(key:key,child:child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true; // determina si deben ser noticados los hijos

  //metodo para devolver la instancia de lo tengo.
  static LoginBloc of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
    
  }
}