import 'package:flutter/material.dart';

class SafetyAdvice extends StatelessWidget {
  const SafetyAdvice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline,
                  color: Colors.blue[700], size: 20),
              const SizedBox(width: 8),
              Text(
                'Consejos de seguridad',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '• Usa una combinación de letras, números y símbolos\n'
                '• Evita usar información personal\n'
                '• No compartas tu contraseña con nadie\n'
                '• Cambia tu contraseña regularmente',
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue[600],
            ),
          ),
        ],
      ),
    );
  }
}
