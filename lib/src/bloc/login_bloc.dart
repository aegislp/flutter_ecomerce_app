import 'dart:async';

import 'package:loginuser/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

/*

    Contola los stream para los inputs de email y contraseña.
    En este caso se usa stream para la validacion de los campos
*/
class LoginBloc with Validators{

  //dtermino los contorles, siempre el mismo paso y casi siempre como broadcast
  //final _emailController = StreamController<String>.broadcast();
  //final _passController = StreamController<String>.broadcast();

  //2 -en rxdart no existen los streamcontroller, los cambios por BehaviorSubject que a su vez son broadcast
  final _emailController = BehaviorSubject<String>();
  final _passController = BehaviorSubject<String>();

  //para no expoener el controller creo getters para cada stream
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passStream => _passController.stream.transform(validarPass);

  //2 -combino BehaviorSubject para deteminar si es correcto el form
  Stream<bool> get formValidoStream => 
            CombineLatestStream.combine2( emailStream,passStream, (e,p)=>true );

  //para no exponer el sink creo funciones getters
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePass => _passController.sink.add;
  
  //siempre me obliga a hacer close.
  dispose(){
    _emailController?.close();
    _passController?.close();
  }

  //obtener el ultimo valor ingresado en lso strem
  String get email => _emailController.value;
  String get pass => _passController.value;
  
}