import 'package:flutter/material.dart';
import '../model/Producto.dart';

class ResumenPedidoPage extends StatelessWidget {
  const ResumenPedidoPage({super.key});

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
