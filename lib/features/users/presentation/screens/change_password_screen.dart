import 'package:flutter/material.dart';
import 'package:mmarn/features/users/presentation/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import '../providers/change_password_provider.dart';
import '../widgets/password_strength_indicator.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    // Reset del estado cuando se abre la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChangePasswordProvider>().resetState();
    });
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 64,
        ),
        title: const Text('¡Contraseña Actualizada!'),
        content: const Text(
          'Tu contraseña ha sido cambiada exitosamente. Por seguridad, te recomendamos cerrar sesión e iniciar nuevamente.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cerrar diálogo
              Navigator.pop(context); // Volver a la pantalla anterior
            },
            child: const Text('Continuar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Aquí podrías llamar al logout del AuthProvider
              Navigator.pop(context);
              Navigator.pop(context);
              // context.read<AuthProvider>().logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar Contraseña'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Información de seguridad
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.security, color: Colors.blue[600]),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Por tu seguridad, necesitas ingresar tu contraseña actual para confirmar los cambios.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Contraseña actual
              CustomTextField(
                controller: _currentPasswordController,
                label: 'Contraseña Actual',
                prefixIcon: Icons.lock_outline,
                obscureText: _obscureCurrentPassword,
                suffixIcon: IconButton(
                  icon: Icon(_obscureCurrentPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureCurrentPassword = !_obscureCurrentPassword;
                    });
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La contraseña actual es requerida';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Nueva contraseña
              CustomTextField(
                controller: _newPasswordController,
                label: 'Nueva Contraseña',
                prefixIcon: Icons.lock,
                obscureText: _obscureNewPassword,
                suffixIcon: IconButton(
                  icon: Icon(_obscureNewPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureNewPassword = !_obscureNewPassword;
                    });
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La nueva contraseña es requerida';
                  }
                  if (value == _currentPasswordController.text) {
                    return 'La nueva contraseña debe ser diferente a la actual';
                  }
                  if (value.length < 8) {
                    return 'La contraseña debe tener al menos 8 caracteres';
                  }
                  return null;
                },
                // onChanged: (value) => setState(() {}), // Para actualizar el indicador
              ),

              const SizedBox(height: 16),

              // Indicador de fortaleza
              if (_newPasswordController.text.isNotEmpty)
                PasswordStrengthIndicator(password: _newPasswordController.text),

              const SizedBox(height: 24),

              // Confirmar contraseña
              CustomTextField(
                controller: _confirmPasswordController,
                label: 'Confirmar Nueva Contraseña',
                prefixIcon: Icons.lock_clock,
                obscureText: _obscureConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirma tu nueva contraseña';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),

              // Botón de cambiar contraseña
              Consumer<ChangePasswordProvider>(
                builder: (context, provider, child) {
                  // Mostrar diálogo de éxito si la contraseña cambió
                  if (provider.passwordChanged) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _showSuccessDialog();
                    });
                  }

                  return ElevatedButton(
                    onPressed: provider.isLoading
                        ? null
                        : () async {
                      if (_formKey.currentState!.validate()) {
                        final success = await provider.cambiarPassword(
                          currentPassword: _currentPasswordController.text,
                          newPassword: _newPasswordController.text,
                          confirmPassword: _confirmPasswordController.text,
                        );

                        if (!success) {
                          // El error se mostrará abajo automáticamente
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(provider.error ?? 'Error desconocido'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: provider.isLoading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                        : const Text(
                      'Cambiar Contraseña',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Mostrar errores
              Consumer<ChangePasswordProvider>(
                builder: (context, provider, child) {
                  if (provider.error != null) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error, color: Colors.red[600]),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              provider.error!,
                              style: TextStyle(color: Colors.red[700]),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: provider.limpiarError,
                            iconSize: 18,
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 24),

              // Consejos de seguridad
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb, color: Colors.amber[600]),
                        const SizedBox(width: 8),
                        const Text(
                          'Consejos de Seguridad',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Usa una combinación de letras, números y símbolos\n'
                          '• No uses información personal como fechas de nacimiento\n'
                          '• Cambia tu contraseña regularmente\n'
                          '• No compartas tu contraseña con nadie',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}