import 'package:flutter/material.dart';
import 'package:loginuser/src/bloc/productos_bloc.dart';
import 'package:loginuser/src/bloc/provider.dart';
import 'package:loginuser/src/pages/producto_page.dart';
import 'package:loginuser/src/providers/productos_provider.dart';
import 'package:loginuser/src/widgets/slide_left_bg_widget.dart';
import 'package:loginuser/src/widgets/slide_right_bg_widget.dart';


class HomePage extends StatelessWidget {

  static final routeName = 'home';
  @override
  Widget build(BuildContext context) {
    
    final productosBloc = Provider.productosBlock(context);
    productosBloc.cargarProductos();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page")
      ),
      body: _createListadoProductos(context, productosBloc),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,),
        onPressed: () {_agregarItem(context);},
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

 Widget _createListadoProductos(BuildContext context, ProductosBloc productosBloc) {
   return StreamBuilder(
     stream: productosBloc.productosStream,
     builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>>  snapshot){

      if(!snapshot.hasData) return Container(child: CircularProgressIndicator());

      final productos = snapshot.data;

      return ListView.builder(
        itemCount: productos.length,
        itemBuilder: (BuildContext context, int index) => _crearItem(productos[index],context,productosBloc),
      );

     },
   );
 }
 Widget _crearItem(ProductoModel producto, BuildContext context, ProductosBloc productosBloc){

    return Dismissible(
      key: ValueKey(producto.id), 
      background: SlideRightBackgroundWidget(color: Colors.deepPurple, icon: Icons.delete,),
      secondaryBackground:SlideLeftBackgroundWidget(color: Colors.deepPurple, icon: Icons.delete,),

      child: Card(
        child: Column(
          children: <Widget>[
            _showProductoImage(producto),
            ListTile(
              title: Text('${producto.titulo} - ${producto.valor}'),
              subtitle: Text(producto.id),
              onTap: (){
                Navigator.of(context).pushNamed(ProductoPage.routeName,arguments: producto);
            }),
            
          ],
        ),
      ),
      onDismissed: (direction){
        productosBloc.borrarProducto(producto.id);
      },
    );
 }

 void _agregarItem(BuildContext context){
   Navigator.of(context).pushNamed(ProductoPage.routeName);
 }

 Widget _showProductoImage(ProductoModel producto){

   if(producto.fotoUrl == null){
     return Image( image:AssetImage('assets/no-image.png'));
   }else{
     return FadeInImage(
      placeholder: AssetImage('assets/jar-loading.gif'), 
      image: NetworkImage(producto.fotoUrl),
      height: 300,
      width: double.infinity,
      fit: BoxFit.cover,

    );
   }
 }
}
 