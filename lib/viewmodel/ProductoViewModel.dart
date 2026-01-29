import '../model/Pedido.dart';
import '../model/Producto.dart';

class ProductoViewModel {
  
  Pedido pedido;
  
  ProductoViewModel(String mesa): pedido= Pedido(listaProducto: [], mesa:mesa);
  
  void agregarProducto(Producto producto){
    pedido.agregarProducto(producto);
  }

  double get calcularTotal => pedido.calcularTotal();

  int totalProductos() => pedido.totalProductos();

  List<Producto> obtenerProductos() => pedido.listaProducto;

}