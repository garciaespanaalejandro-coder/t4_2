import 'package:flutter/material.dart';
import '../view/HomePage.dart';
import '../view/Resumen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
