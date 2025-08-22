import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mmarn/core/constants/app_colors.dart';
import 'package:mmarn/features/services/data/repositories/service_repository.dart';
import 'package:mmarn/features/services/domain/entities/service_entity.dart';
import 'package:mmarn/features/services/presentation/widgets/service_card.dart';
import 'package:mmarn/shared/widgets/bottom_navbar.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  late Future<List<ServiceEntity>> _servicesFuture;
  final _repository = ServicesRepository();

  @override
  void initState() {
    super.initState();
    _servicesFuture = _repository.fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    final GoRouterState state = GoRouterState.of(context);
    final String currentRoute = state.uri.toString();

    return Scaffold(
      appBar: AppBar(title: const Text("Servicios", style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 25, ),)),
      body: FutureBuilder<List<ServiceEntity>>(
        future: _servicesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay servicios disponibles"));
          } else {
            final services = snapshot.data!;
            return ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                return ServiceCard(service: services[index]);
              },
            );
          }
        },

      ),
      bottomNavigationBar: BottomNavBar(currentRoute: currentRoute),
    floatingActionButton:   ElevatedButton.icon(
        onPressed: () => context.go("/services/measures"),
        icon: const Icon(Icons.eco, color: AppColors.primaryColor, size: 25,),
        label: const Text("Medidas Ambientales",style: TextStyle(color: AppColors.primaryColor, fontSize: 18)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
