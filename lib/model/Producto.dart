/// Modelo Producto que representa un producto con id, nombre y precio.
class Producto{
  final int id;
  final String nombre;
  double precio;

  /// Constructor de la clase Producto.
  /// @param id Identificador único del producto.
  /// @param nombre Nombre del producto.
  /// @param precio Precio del producto.
  Producto({required this.id, required this.nombre, required this.precio});

}