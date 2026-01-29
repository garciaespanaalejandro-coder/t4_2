import 'package:flutter/material.dart';
import '../model/Producto.dart';

class SeleccionarProductosPage extends StatefulWidget {
  const SeleccionarProductosPage({super.key});

  @override
  State<SeleccionarProductosPage> createState() =>
      _SeleccionarProductosPageState();
}

class _SeleccionarProductosPageState extends State<SeleccionarProductosPage> {
  List<Producto> carta = [
    Producto(id: 1, nombre: "Café", precio: 1.20),
    Producto(id: 2, nombre: "Té", precio: 1.10),
    Producto(id: 3, nombre: "Agua", precio: 2.00),
    Producto(id: 4, nombre: "Zumo", precio: 2.00),
    Producto(id: 5, nombre: "Colacao", precio: 2.00),
    Producto(id: 6, nombre: "Cocacola", precio: 2.00),
    Producto(id: 7, nombre: "Pizza", precio: 7.50),
    Producto(id: 8, nombre: "Patatas", precio: 3.50),

  ];

  Map<int, int> cantidades= {};
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Seleccionar Productos")),
      body: ListView.builder(
        itemCount: carta.length,
        itemBuilder: (context, index){
          final p= carta[index];
          cantidades.putIfAbsent(p.id, ()=>0);

          return ListTile(
            title: Text(p.nombre),
            subtitle: Text("${p.precio} €"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (cantidades[p.id]! > 0) {
                        cantidades[p.id] = cantidades[p.id]! - 1;
                      }
                    });
                  },
                ),
                Text("${cantidades[p.id]}"),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      cantidades[p.id] = cantidades[p.id]! + 1;
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancelar"),
              ),
            ),
            SizedBox(height: 10),

            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  List<Map<String, dynamic>> seleccion = [];

                  cantidades.forEach((id, cant) {
                    if (cant > 0) {
                      final p = carta.firstWhere((e) => e.id == id);
                      seleccion.add({"producto": p, "cantidad": cant});
                    }
                  });

                  Navigator.pop(context, seleccion);
                },
                child: const Text("Confirmar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}