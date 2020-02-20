import 'package:flutter/material.dart';

bool isNumeric(String valor){
  
  return !valor.isEmpty && ( num.tryParse(valor) != null); 
}

void mostrarAlert(BuildContext context, String message){
  showDialog(
    context: context,
    builder: (cotnext){
      return AlertDialog(
        title: Text("Informacion"),
        content: Text(message),
        actions: <Widget>[
          RaisedButton(
            child: Text("ok"),
            onPressed: ()=>Navigator.of(context).pop(),
          ),
        ],
      );
    }
    
  );
}