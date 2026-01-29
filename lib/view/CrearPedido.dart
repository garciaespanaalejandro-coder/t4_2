import 'package:flutter/material.dart';
import '../viewmodel/ProductoViewModel.dart';
import '../model/Producto.dart';
import '../view/ListaProducto.dart';


class CrearPedido extends StatefulWidget {
  const CrearPedido({super.key});

  @override
  State<CrearPedido> createState() => _CrearPedidoPageState();
}

class _CrearPedidoPageState extends State<CrearPedido> {
  final TextEditingController _mesaController = TextEditingController();
  ProductoViewModel? viewModel;

  @override
  void dispose(){
    _mesaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Crear pedido")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _mesaController,
              decoration: InputDecoration(
                labelText: "Mesa/ Nombre",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:() async {
                if(_mesaController.text.trim().isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Introduce un nombre o número de mesa válido"),
                    ),
                  );
                  return;
                }

                if(viewModel == null){
                  viewModel = ProductoViewModel(_mesaController.text.trim());
                }
                final result=await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SeleccionarProductosPage(),
                  ),
                );

                if(!mounted) return;

                if (result != null && result is List<Map<String, dynamic>>) {
                  for (var item in result) {
                    Producto p = item["producto"];
                    int cant = item["cantidad"];

                    for (int i = 0; i < cant; i++) {
                      viewModel?.agregarProducto(p);
                    }
                  }
                  setState(() {});
                }
              },
              child: Text("Añadir productos"),
            ),

            SizedBox(height: 20),

            Text(
              "Resumen provisional",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

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

            ElevatedButton(
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

            SizedBox(height: 10),

            ElevatedButton(
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

            // Cancelar
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}