import 'package:loginuser/src/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario{

  static final _preferenciasUsuario = new PreferenciasUsuario.internal();

  factory PreferenciasUsuario(){
    return _preferenciasUsuario;
  }

  PreferenciasUsuario.internal();

  SharedPreferences _pref;

  initPrefs() async{
    _pref = await SharedPreferences.getInstance(); 
  }

  
 

  get email{
    return this._pref.getString('email') ?? '' ;
  }
  set email(String email){
    this._pref.setString('email', email);
  }

  get token{
    return this._pref.getString('token') ?? '' ;
  }
  set token(String token){
    this._pref.setString('token', token);
  }

  get ultimaPagina{
    return this._pref.getString('pagina') ?? HomePage.routeName ;
  }
  set ultimaPagina(String pagina){
    this._pref.setString('pagina', pagina);
  }

}