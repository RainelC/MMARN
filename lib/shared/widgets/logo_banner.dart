import 'package:flutter/material.dart';

class LogoBanner extends StatelessWidget {
  final String imageUrl;
  final double height;

  const LogoBanner({
    super.key,
    required this.imageUrl,
    this.height = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(20),
      child: Container(
        width: double.infinity,
        height: height,
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          alignment: Alignment.centerLeft,
          semanticLabel: 'Imagen del logo del Medio Ambiente y Recursos Naturales', // Para accesibilidad
        ),
        ),
    );
  }
}