import 'package:flutter/material.dart';
import '../view/HomePage.dart';
import '../view/Resumen.dart';

void main() {
  runApp(const MyApp());
}

/// Clase principal de la aplicación Flutter.
/// Configura las rutas y la página de inicio.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

 /// Construye la aplicación Flutter.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/resumen": (_) => ResumenPedidoPage(),
      },
      home: HomePage(pedidos: []),
    );
  }
}
