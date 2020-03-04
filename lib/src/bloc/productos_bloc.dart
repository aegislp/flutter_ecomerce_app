import 'dart:async';
import 'dart:io';

import 'package:loginuser/src/providers/productos_provider.dart';
import 'package:rxdart/subjects.dart';

class ProductosBloc{


  final _productosController = BehaviorSubject<List<ProductoModel>>();
  final _cargandoController = BehaviorSubject<bool>();

  final _productosProvider = ProductosProvider();

  Stream<List<ProductoModel>> get productosStream => _productosController.stream;
  Stream<bool> get cargandoStream => _cargandoController.stream;


  void cargarProductos() async{
    final productos = await _productosProvider.cargarProductos();  
    _productosController.sink.add(productos);
  }

  void agregarProducto(ProductoModel productoNuevo) async {

    _cargandoController.sink.add(true);
    
     await _productosProvider.crearProdcuto(productoNuevo);

     _cargandoController.sink.add(false);

  }

  Future<String> subirFoto(File image) async{
    
     _cargandoController.sink.add(true);
     
     final url = await _productosProvider.subirImage(image);

     _cargandoController.sink.add(false);

     return url;

  }

  void editarProducto(ProductoModel productoNuevo) async {

    _cargandoController.sink.add(true);
    
     await _productosProvider.editarProdcuto(productoNuevo);

     _cargandoController.sink.add(false);

  }


  void borrarProducto(String id) async {

    await _productosProvider.borrarProducto(id); 

  }



  disponse(){
    _productosController?.close();
    _cargandoController?.close();
  }



}