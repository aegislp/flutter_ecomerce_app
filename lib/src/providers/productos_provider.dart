import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:loginuser/src/models/producto_model.dart';
import 'package:mime_type/mime_type.dart';
export 'package:loginuser/src/models/producto_model.dart';

class ProductosProvider{

  final String urlBase = 'https://flutter-ecomerce-bf829.firebaseio.com';

  Future<bool> crearProdcuto(ProductoModel producto) async{

    final url = '$urlBase/productos.json';

    final response = await http.post(url, body: productoModelToJson(producto));

    final decodeData = json.decode(response.body);

    return true;

  }


  Future<bool> editarProdcuto(ProductoModel producto) async{

    final url = '$urlBase/productos/${producto.id}.json';

    final response = await http.put(url, body: productoModelToJson(producto));

    final decodeData = json.decode(response.body);

    return true;

  }

  Future<List<ProductoModel>> cargarProductos() async{
    final url = '$urlBase/productos.json';

    final response = await http.get(url);

    final Map<String,dynamic> decodeData = json.decode(response.body);

    if(decodeData == null) return [];

    
    List<ProductoModel> productos = new List(); 
    
    decodeData.forEach((id,registro){

      final producto = ProductoModel.fromJson(registro);
      producto.id = id;
      productos.add(producto);
    
    });

    return productos;
  }


  Future<bool> borrarProducto(String id) async {

    final url = '$urlBase/productos/$id.json';

    final response = await http.delete(url);
  }

 Future<String> subirImage(File imageFile) async {   

  final uri = Uri.parse('https://us-central1-flutter-ecomerce-bf829.cloudfunctions.net/uploadFile');
  final mimeType = mime(imageFile.path).split("/");

  final request = http.MultipartRequest('POST', uri);

  final file = await http.MultipartFile.fromPath(
    'file', 
    imageFile.path,
    contentType: MediaType(mimeType[0], mimeType[1]));
  
  request.fields['imagename'] = 'image';
  request.files.add(file);
  final stremResponse = await request.send();

  final response = await http.Response.fromStream(stremResponse);

  
  if (response.statusCode != 200) print('Error');
  
  
  final decodeData = json.decode(response.body);

  return decodeData['url'];

}


}