import 'package:flutter/material.dart';
import '../viewmodel/ProductoViewModel.dart';
import '../model/Producto.dart';
import '../view/ListaProducto.dart';

/// Página para crear un nuevo pedido, permitiendo seleccionar productos y ver un resumen provisional. 
/// Utiliza el ViewModel ProductoViewModel para gestionar la lógica del pedido.
/// Permite navegar a la página de resumen del pedido y guardar el pedido.
class CrearPedido extends StatefulWidget {
  /// Constructor de la clase CrearPedido.
  /// @param key Clave opcional para el widget.
  const CrearPedido({super.key});

  @override
  State<CrearPedido> createState() => _CrearPedidoPageState();
}

/// Estado de la página CrearPedido.
/// Gestiona la entrada del usuario, la selección de productos y la visualización del resumen provisional
/// del pedido.
class _CrearPedidoPageState extends State<CrearPedido> {
  final TextEditingController _mesaController = TextEditingController();
  ProductoViewModel? viewModel;

  /// Liberar recursos al desechar el widget.
  @override
  void dispose(){
    _mesaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    /// Retorna el Scaffold que contiene la interfaz de usuario para crear un pedido.
    return Scaffold(
      appBar: AppBar(title: Text("Crear pedido")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: [
            /// Campo de texto para introducir el nombre o número de la mesa.
            /// Incluye validación para asegurar que no esté vacío.
            /// Si es válido, permite navegar a la página de selección de productos.
            TextField(
              controller: _mesaController,
              decoration: InputDecoration(
                labelText: "Mesa/ Nombre",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Tooltip(
              message: "Pulsa para añadir productos al pedido, una vez introducido el nombre o número de mesa.",
              child: ElevatedButton(
                onPressed: () async {
                  if (_mesaController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Introduce un nombre o número de mesa válido"),
                      ),
                    );
                    return;
                  }

                  /// Inicializar el ViewModel si es nulo
                  viewModel ??= ProductoViewModel(_mesaController.text.trim());

                  /// Navegar a la página de selección de productos
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SeleccionarProductosPage(),
                    ),
                  );

                  if (!mounted) return;

                  /// Procesar el resultado
                  if (result != null && result is List<Map<String, dynamic>>) {
                    for (var item in result) {
                      Producto p = item["producto"];
                      int cant = item["cantidad"];

                      for (int i = 0; i < cant; i++) {
                        viewModel?.agregarProducto(p);
                      }
                    }
                    setState(() {}); /// Refresca la UI con los nuevos productos
                  }
                },
                child: const Text("Añadir productos"),
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Resumen provisional",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            /// Lista de productos añadidos al pedido y total provisional.
            /// Si no hay productos, muestra un mensaje indicándolo.
            Expanded(
              child: ListView.builder(
                itemCount: viewModel?.totalProductos() ??0,
                itemBuilder: (_, index){
                  final p = viewModel!.obtenerProductos()[index];
                  return ListTile(
                    title: Text(p.nombre),
                    trailing: Text("${p.precio.toStringAsFixed(2)} €"),
                  );
                },
              ),
            ),
            Text(
              "Total: ${viewModel?.calcularTotal.toStringAsFixed(2) ?? '0.00'} €",
              style: const TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Tooltip(
              message: "Ver el resumen completo del pedido antes de guardarlo.",
              child: ElevatedButton(
              
                /// Navegar a la página de resumen del pedido.
                /// Valida que haya productos y un nombre de mesa antes de navegar.
                onPressed: () {
                  if (viewModel == null ||
                      viewModel!.totalProductos() == 0 ||
                      _mesaController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Introduzca valores válidos por favor.")),
                    );
                    return;
                  }

                  Navigator.pushNamed(
                    context,
                    "/resumen",
                    arguments: {
                      "mesa": _mesaController.text.trim(),
                      "productos": viewModel!.obtenerProductos(),
                      "total": viewModel!.calcularTotal,
                    },
                  );
                },
                child: const Text("Ver resumen"),
              ),
            ),

            SizedBox(height: 10),

            Tooltip(
              message: " Guardar el pedido y volver a la pantalla principal.",
              child:ElevatedButton(
                /// Guardar el pedido y volver a la pantalla principal.
                /// Valida que haya productos y un nombre de mesa antes de guardar.
                onPressed: () {
                  if (viewModel == null ||
                      viewModel!.totalProductos() == 0 ||
                      _mesaController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Datos incompletos")),
                    );
                    return;
                  }

                  Navigator.pop(context, viewModel!.pedido);
                },
                child: const Text("Guardar pedido"),
              ),
            ),

            SizedBox(height: 10),

            Tooltip(
              message: "Cancelar la creación del pedido y volver a la pantalla principal.",
              child:TextButton(
                /// Cancelar la creación del pedido y volver a la pantalla principal.
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}