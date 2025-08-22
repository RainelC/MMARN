import 'package:flutter/material.dart';
import 'package:mmarn/core/constants/app_colors.dart';
import '../../domain/entities/voluntario_entity.dart';

class VoluntarioForm extends StatefulWidget {
  final Function(VoluntarioEntity) onSubmit;

  const VoluntarioForm({required this.onSubmit, super.key});

  @override
  State<VoluntarioForm> createState() => _VoluntarioFormState();
}

class _VoluntarioFormState extends State<VoluntarioForm> {
  final _formKey = GlobalKey<FormState>();

  final _cedulaController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _correoController = TextEditingController();
  final _passwordController = TextEditingController();
  final _telefonoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _cedulaController,
            decoration: const InputDecoration(labelText: 'Cédula'),
            validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
          ),
          TextFormField(
            controller: _nombreController,
            decoration: const InputDecoration(labelText: 'Nombre'),
            validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
          ),
          TextFormField(
            controller: _apellidoController,
            decoration: const InputDecoration(labelText: 'Apellido'),
            validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
          ),
          TextFormField(
            controller: _correoController,
            decoration: const InputDecoration(labelText: 'Correo'),
            validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
            validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
          ),
          TextFormField(
            controller: _telefonoController,
            decoration: const InputDecoration(labelText: 'Teléfono'),
            validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final voluntario = VoluntarioEntity(
                  cedula: _cedulaController.text,
                  nombre: _nombreController.text,
                  apellido: _apellidoController.text,
                  correo: _correoController.text,
                  password: _passwordController.text,
                  telefono: _telefonoController.text,
                );
                widget.onSubmit(voluntario);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
            child: const Text('Enviar' ,style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
