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
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    String mesa = args["mesa"];
    List<Producto> productos = args["productos"];
    double total = args["total"];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resumen detallado"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
