import 'package:flutter/material.dart';
import 'package:mmarn/core/constants/app_colors.dart';
import 'package:mmarn/shared/widgets/bottom_navbar.dart';
import '../../domain/entities/voluntario_entity.dart';
import '../../domain/usecases/enviar_voluntario.dart';
import '../widgets/vvolunteering_form.dart';

class VolunteeringScreen extends StatefulWidget {
  final EnviarVoluntario enviarVoluntarioUseCase;

  const VolunteeringScreen({required this.enviarVoluntarioUseCase, super.key});

  @override
  State<VolunteeringScreen> createState() => _VolunteeringScreenState();
}

class _VolunteeringScreenState extends State<VolunteeringScreen> {
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Voluntariado", style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 25, ),)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Solicitar ser voluntario",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Para ser voluntario necesitas cumplir con los siguientes requisitos:\n"
                  "• Ser mayor de 18 años\n"
                  "• Tener interés en el cuidado del medio ambiente\n"
                  "• Comprometerte a participar activamente en las actividades\n",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              "Formulario de solicitud de voluntariado",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            VoluntarioForm(
              onSubmit: (VoluntarioEntity voluntario) async {
                setState(() => _isSubmitting = true);

                try {
                  await widget.enviarVoluntarioUseCase.call(voluntario);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Solicitud enviada con éxito")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error al enviar la solicitud: $e")),
                  );
                } finally {
                  setState(() => _isSubmitting = false);
                }
              },
            ),

            if (_isSubmitting)
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentRoute: '/volunteering'),
    );
  }
}
