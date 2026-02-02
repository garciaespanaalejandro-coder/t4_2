import '../model/Pedido.dart';
import '../model/Producto.dart';
/// ViewModel para gestionar la lógica de productos y pedidos.
/// Proporciona métodos para agregar productos, calcular totales y obtener la lista de productos en el pedido.
/// Utiliza la clase Pedido para manejar la lógica del pedido.
class ProductoViewModel {
  
  Pedido pedido;
  /// Constructor que inicializa el ViewModel con una mesa específica.
  /// @param mesa El nombre o número de la mesa para el pedido.
  ProductoViewModel(String mesa): pedido= Pedido(listaProducto: [], mesa:mesa);
  
  /// Agrega un producto al pedido.
  void agregarProducto(Producto producto){
    pedido.agregarProducto(producto);
  }

  /// Calcula el total del pedido.
  double get calcularTotal => pedido.calcularTotal();

  /// Obtiene el número total de productos en el pedido.
  int totalProductos() => pedido.totalProductos();

  /// Obtiene la lista de productos en el pedido.
  List<Producto> obtenerProductos() => pedido.listaProducto;

}