import 'package:flutter/material.dart';
import '../model/Producto.dart';

/// Página para mostrar el resumen detallado de un pedido. 
/// Muestra la mesa, los productos seleccionados y el total del pedido.
/// Recibe los datos a través de los argumentos de la ruta.
class ResumenPedidoPage extends StatelessWidget {
  /// Constructor de la clase ResumenPedidoPage.
  /// @param key Clave opcional para el widget.
  const ResumenPedidoPage({super.key});

  /// Construye la interfaz de usuario de la página de resumen del pedido.
  @override
  Widget build(BuildContext context) {

    /// Obtiene los argumentos pasados a la ruta.
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    /// Extrae los datos del pedido de los argumentos.
    String mesa = args["mesa"];

    /// Extrae la lista de productos en el pedido.
    List<Producto> productos = args["productos"];

    /// Extrae el total del pedido.
    double total = args["total"];

    /// Retorna el Scaffold que contiene la interfaz de usuario del resumen del pedido.
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resumen detallado"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      /// Cuerpo de la página que muestra los detalles del pedido.
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Mesa: $mesa", style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 20),

            const Text(
              "Productos",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            /// Lista de productos en el pedido.
            /// Cada producto se muestra con su nombre y precio.
            Expanded(
              child: ListView.builder(
                itemCount: productos.length,
                itemBuilder: (_, index) {
                  final p = productos[index];
                  return ListTile(
                    title: Text(p.nombre),
                    trailing: Text("${p.precio} €"),
                  );
                },
              ),
            ),

            Text(
              "Total: ${total.toStringAsFixed(2)} €",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
