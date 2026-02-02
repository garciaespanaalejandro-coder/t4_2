
import 'package:flutter/material.dart';
import 'package:t4_2/model/Pedido.dart';
import '../view/CrearPedido.dart';

/// Página principal que muestra la lista de pedidos y permite crear nuevos pedidos.
class HomePage extends StatefulWidget {
  final List<Pedido> pedidos; 

  /// Constructor de la clase HomePage.
  /// @param key Clave opcional para el widget.
  /// @param pedidos Lista de pedidos existentes.
  const HomePage({super.key, required this.pedidos});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// Estado de la página HomePage.
/// Gestiona la visualización de la lista de pedidos y la navegación para crear nuevos pedidos.
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de pedidos"),
      ),
      body:
          widget.pedidos.isEmpty? 
            const Center(child: Text("No hay pedidos todavía"))
          :ListView.builder(
              itemCount: widget.pedidos.length,
              itemBuilder: (context, index) {
                final pedido = widget.pedidos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Pedido: ${pedido.mesa}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
            ),
      
      /// Botón para crear un nuevo pedido.
      floatingActionButton: FloatingActionButton(
        onPressed:() async {
          final nuevoPedido = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CrearPedido(),
            ),
          );
          if (!mounted) return;

          if (nuevoPedido != null) {
            setState(() {
              widget.pedidos.add(nuevoPedido);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
