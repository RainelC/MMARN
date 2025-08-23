import 'package:flutter/material.dart';
import 'package:mmarn/core/constants/app_colors.dart';
import 'package:mmarn/core/storage/secure_storage_service.dart';
import 'package:mmarn/features/home/presentation/widgets/home_btns.dart';
import 'package:mmarn/features/users/data/repositories/auth_repository_impl.dart';
import 'package:mmarn/shared/widgets/logo_banner.dart';
import 'package:mmarn/shared/widgets/bottom_navbar.dart';
import 'package:go_router/go_router.dart';
import '../widgets/home_slider.dart';
import '../../domain/entities/message.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouterState state = GoRouterState.of(context);
    final String currentRoute = state.uri.toString();

    final messages = [
      Message(
        imageUrl: 'https://picsum.photos/800/400?image=10',
        text: 'Protege nuestros bosques y ríos',
      ),
      Message(
        imageUrl: 'https://picsum.photos/800/400?image=20',
        text: 'El Ministerio trabaja por un ambiente sostenible',
      ),
      Message(
        imageUrl: 'https://picsum.photos/800/400?image=30',
        text: 'Reciclar es un acto de amor por la Tierra',
      ),
    ];

    return FutureBuilder<bool>(
        future: AuthRepositoryImpl(SecureStorageService()).isLoggedIn(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(height: 70); // o un loader
          }

          final isLoggedIn = snapshot.data!;
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  LogoBanner(
                      imageUrl: 'https://ambiente.gob.do/app/uploads/2023/06/LogoMMA-02-1.png'),
                  HomeSlider(messages: messages, porcentaje: isLoggedIn ? 0.7 : 0.65),
                  const SizedBox(height: 20),
                  if (!isLoggedIn) HomeBtns()
                ],
              ),
            ),
            floatingActionButton: ElevatedButton.icon(
                icon: Icon(isLoggedIn ? Icons.logout : Icons.login, color: AppColors.primaryColor, size: 25,),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
                label: Text(isLoggedIn ? "Logout" : "Login", style: TextStyle(
                    color: AppColors.primaryColor, fontSize: 18)),
                onPressed: () {
                  isLoggedIn ? context.go("/logout") : context.go("/home/login");
                }
            ),
            bottomNavigationBar: BottomNavBar(currentRoute: currentRoute),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            persistentFooterButtons: [ElevatedButton.icon(
                icon: Icon(Icons.password, color: AppColors.primaryColor, size: 25,),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor),
                label: Text("Cambiar contraseña", style: TextStyle(
                    color: Colors.white, fontSize: 18)),
                onPressed: () {
                  context.go("/change_password");
                }
            ),],
          );
        }
    );
  }
}
