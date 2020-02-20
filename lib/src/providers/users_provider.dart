import 'dart:convert';
import 'package:http/http.dart' as http;


import 'package:loginuser/src/shared_pref/prefeencias_usuario.dart';


class UserProvider{

  final firebaseApiKey = 'AIzaSyAl9eP9HVZqjLl6EUWzKLOrjcZwAoL6yCA';
  final _prefs =  new PreferenciasUsuario();

  Future<Map<String,dynamic>> login(String email, String pass) async{

    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$firebaseApiKey';

    final authData = {
      'email': email,
      'password': pass,
      'returnSecureToken': true
    };


    final response =  await http.post(url,body: json.encode(authData));

    Map<String, dynamic> decoResponse = json.decode(response.body);

    print(decoResponse);

    if(decoResponse.containsKey('idToken')){
      _prefs.token = decoResponse['idToken'];
      return {'ok':true ,'token': decoResponse['idToken'] };

    }else{
      return {'ok': false,'error': decoResponse['error']['message']};
    }

  }
  Future<Map<String,dynamic>> nuevoUsuario( String email, String pass) async{

    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$firebaseApiKey';

    final authData = {
      'email': email,
      'password': pass,
      'returnSecureToken': true
    };


    final response =  await http.post(url,body: json.encode(authData));

    Map<String, dynamic> decoResponse = json.decode(response.body);

    print(decoResponse);

    if(decoResponse.containsKey('idToken')){
       _prefs.token = decoResponse['idToken'];
      return {'ok':true ,'token': decoResponse['idToken'] };
    }else{
      return {'ok': false,'error': decoResponse['error']['message']};
    }


      

    

  }
}