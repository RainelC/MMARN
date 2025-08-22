import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoBanner extends StatelessWidget {
  final String imageUrl;
  final double height;

  const LogoBanner({
    super.key,
    required this.imageUrl,
    this.height = 150.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      color: Colors.grey[200],
      child: Center(
        child: SvgPicture.network(
        imageUrl,
        fit: BoxFit.contain,
        placeholderBuilder: (BuildContext context) =>
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              ),
            ),
        semanticsLabel: 'Imagen del logo del Medio Ambiente y Recursos Naturales', // Para accesibilidad
      ),
      ),
    );
  }
}