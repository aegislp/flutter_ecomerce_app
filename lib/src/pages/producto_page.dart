
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginuser/src/models/producto_model.dart';
import 'package:loginuser/src/providers/productos_provider.dart';
import 'package:loginuser/src/utils/utils.dart' as utils;


class ProductoPage extends StatefulWidget {
  static final routeName = 'producto';

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final fromKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProductoModel producto = new ProductoModel();

  final ProductosProvider productosProvider = new ProductosProvider();

  bool _guardando =  false;

  File file;

  @override
  Widget build(BuildContext context) {

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;

    if(prodData != null){
      producto = prodData;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Producto Page"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.image), onPressed: _seleccionarFoto),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: _tomarFoto), 
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child:Form( 
            key: fromKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _createNombre(),
                _createPrecio(),
                _createDisponible(),
                _createBoton()
              ],
            )
          ),
        ),
      ),
    );
  }

  Widget _createNombre(){
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: "Producto",
      ),
      onSaved: (valor)=> producto.titulo = valor,
      validator: (valor) => valor.length < 3 ? 'Ingrese nombre del producto': null,
    );
  }

  Widget _createPrecio(){
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true) ,
      decoration: InputDecoration(
        labelText: "Precio",
      ),
      onSaved: (valor)=> producto.valor = double.parse(valor),
      validator: (valor) => !utils.isNumeric(valor) ? 'Ingrese un valor numerico': null ,
    );
  }

  Widget _createDisponible(){
    return SwitchListTile(
      value: producto.disponible,
      title: Text("Disponible"),
      activeColor: Colors.deepPurple,
      onChanged: (valor) {
        producto.disponible = valor;
        setState(() {
          
        });
      } ,
    );
  }
  Widget _createBoton(){
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      textColor: Colors.white,
      color: Colors.deepPurple,
      icon: Icon(Icons.save),
      label: Text("Guardar"),
      onPressed: (_guardando) ? null : (){ _submit(context);} ,
    );
  }

  void _submit(BuildContext context) async{
    print("sva");
    if(!fromKey.currentState.validate()) return;

    fromKey.currentState.save();
    print("saved");
    print(producto.titulo);
    print(producto.valor);

    setState(() { _guardando =  true;});

    if(file!=null){
      producto.fotoUrl = await productosProvider.subirImage(file);
    }
    if(producto.id == null ){
      productosProvider.crearProdcuto(producto);
      mostrarSnakBar("Producto Creado");
    }else{
      productosProvider.editarProdcuto(producto);
      mostrarSnakBar("Producto Actualizado");
    }

    Navigator.of(context).pop(); 

  }

  void mostrarSnakBar(String mensaje){
    final snackbar = SnackBar(
       content: Text(mensaje),
       duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _mostrarFoto(){
    
    if(producto.fotoUrl != null){
      return FadeInImage(
        placeholder: AssetImage('assets/no-image.png'), 
        image: NetworkImage(producto.fotoUrl),
        height: 300,
        width: double.infinity,
        fit: BoxFit.cover
      );
    }else{
      return Image(
        image:  file != null ? FileImage(file) :  AssetImage( 'assets/no-image.png'),
        height: 300,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }
  void _seleccionarFoto() async{
    _procesarImagen(ImageSource.gallery);
  }

  void _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  void _procesarImagen(ImageSource source) async{
    file = await ImagePicker.pickImage(source:source);

    if(file != null){
 
    }
    setState(() {
      
    });
  }
}