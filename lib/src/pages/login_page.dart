import 'package:flutter/material.dart';
import 'package:loginuser/src/bloc/provider.dart';
import 'package:loginuser/src/pages/home_page.dart';


class LoginPage extends StatelessWidget {

  static final routeName = 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createBackground(context),
          _createLoginForm(context),
          Text("Olvido la contraseña?"),
                SizedBox(height: 100.0,)
        ],
      )
    );
  }

  Widget _createLoginForm(BuildContext context){
    final screSize = MediaQuery.of(context).size;
    final bloc = Provider.of(context);

    return SingleChildScrollView(
      
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: screSize.width * 0.85,
            margin: EdgeInsets.only(top: 30.0,bottom: 10.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 0.5),
                  spreadRadius: 3.0
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Text("Ingreso",style: TextStyle(fontSize: 20.0),),
                _createEmailIput(bloc),
                _createPassInput(bloc),
                _createButton(bloc),
                
              ]
            ),
          ),
        ],
      ),
    );
  }
  Widget _createEmailIput(LoginBloc bloc){
    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.all(20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              icon: Icon(Icons.alternate_email,color: Colors.deepPurple),
              counterText: snapshot.data,
              errorText: snapshot.error 
            ),
            onChanged: (valor){
              bloc.changeEmail(valor);
            },
          ),
        );
      },
    );
  }

  Widget _createPassInput(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.passStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
         return Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                icon: Icon(Icons.lock,color: Colors.deepPurple),
                counterText: snapshot.data,
                errorText: snapshot.error
              ),
              onChanged: (valor){
                bloc.changePass(valor);
              },
              
            ),
          );
      },
    );
     
  }

  Widget _createBackground(BuildContext context){

    final screeSize = MediaQuery.of(context).size;

    final fondoMorado = Container(
      width: double.infinity,
      height: screeSize.height * 0.4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0),
          ]
        )
      ),
    );

    final ciruclo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned( top: 90.0,left: 30.0,child: ciruclo),
        Positioned( top: -40.0,right: -30.0,child: ciruclo),
        Positioned( bottom: -50.0,right: -10.0,child: ciruclo),
        Positioned( bottom: 120.0,right: 20.0,child: ciruclo),
        Positioned( bottom: -50.0,left: -20.0,child: ciruclo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.person_pin_circle,color: Colors.white,size: 100.0,),
              SizedBox(height: 10.0,width: double.infinity,),
              Text("Luis Alberto Melo",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 32.0),)
            ],
          ),
        )
      ],
    );
  }

  Widget _createButton(LoginBloc bloc){
    return StreamBuilder(
      stream: bloc.formValidoStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
            child: Text("Ingresar"),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          ),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? ()=>_login(bloc,context) : null,
        );
      },
    );
    
    
    
  }

  _login(LoginBloc bloc, BuildContext context){
    
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);

  }
}