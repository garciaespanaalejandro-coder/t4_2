import 'package:t4_2/model/Producto.dart';

/// Modelo Pedido que contiene una lista de productos y la mesa asociada a dicho pedido.
class Pedido {
  List<Producto> listaProducto;
  String mesa;

  /// Constructor de la clase Pedido. 
  /// @param listaProducto Lista de productos en el pedido.
  /// @param mesa Nombre o número de la mesa.
  Pedido(
    {required this.listaProducto, required this.mesa}
  ); 

  /// Método para agregar un producto al pedido.
  void agregarProducto(Producto p){
    listaProducto.add(p);
  }

  /// Método para calcular el total del pedido.
  double calcularTotal(){
    double total=0;

    for(var producto in listaProducto){
      total+=producto.precio;
    }
    return total;
  }

  /// Método para obtener el número total de productos en el pedido.
  int totalProductos(){
    return listaProducto.length;
  }
  
}
