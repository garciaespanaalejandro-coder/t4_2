import 'package:flutter/material.dart';
import '../model/Producto.dart';

/// Página para seleccionar productos de la carta y sus cantidades. 
class SeleccionarProductosPage extends StatefulWidget {

  /// Constructor de la clase SeleccionarProductosPage.
  /// @param key Clave opcional para el widget.
  const SeleccionarProductosPage({super.key});

  @override
  State<SeleccionarProductosPage> createState() =>
      _SeleccionarProductosPageState();
}

/// Estado de la página SeleccionarProductosPage. 
class _SeleccionarProductosPageState extends State<SeleccionarProductosPage> {

  /// Lista de productos disponibles en la carta. 
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
  

  /// Construcción de la interfaz de usuario.
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
                /// Cantidad seleccionada
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
      /// Barra inferior con botones de cancelar y confirmar.
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Tooltip(
              message: "Pulsa para cancelar la selección de productos y volver atrás.",
              /// Botón para cancelar la selección y volver atrás.
              /// Navega de vuelta sin devolver ningún dato.
              child:ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar"),
              ),
            ),
            
            SizedBox(height: 10),

            Tooltip(
              message: "Pulsa para confirmar la selección de productos y sus cantidades.",
              child: Expanded(
                /// Botón para confirmar la selección de productos.
                /// Devuelve la lista de productos seleccionados y sus cantidades.
                child: ElevatedButton(
                  onPressed: () {
                    List<Map<String, dynamic>> seleccion = [];

                    /// Construir la lista de productos seleccionados con sus cantidades.
                    /// Solo se incluyen los productos con cantidad mayor que cero.
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
            ),
          ],
        ),
      ),
    );
  }
}