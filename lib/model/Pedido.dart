import 'package:t4_2/model/Producto.dart';

class Pedido {
  List<Producto> listaProducto;
  String mesa;

  Pedido(
    {required this.listaProducto, required this.mesa}
  ); 

  void agregarProducto(Producto p){
    listaProducto.add(p);
  }

  double calcularTotal(){
    double total=0;

    for(var producto in listaProducto){
      total+=producto.precio;
    }
    return total;
  }

  int totalProductos(){
    return listaProducto.length;
  }
  
}
