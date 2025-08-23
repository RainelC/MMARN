import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mmarn/core/storage/secure_storage_service.dart';
import 'package:mmarn/features/about_team/about_team_screen.dart';
import 'package:mmarn/features/about_us/presentation/screens/about_us_screen.dart';
import 'package:mmarn/features/areas/presentation/screens/areas_screen.dart';
import 'package:mmarn/features/home/presentation/screens/home_screen.dart';
import 'package:mmarn/features/measures/presentation/screens/measures_screen.dart';
import 'package:mmarn/features/news/presentation/screens/news_screen.dart';
import 'package:mmarn/features/normatives/presentation/screens/normative_screen.dart';
import 'package:mmarn/features/reports/presentation/screens/report_damage_screen.dart';
import 'package:mmarn/features/reports/presentation/screens/report_map_screen.dart';
import 'package:mmarn/features/reports/presentation/screens/reports_screen.dart';
import 'package:mmarn/features/services/presentation/pages/services_screen.dart';
import 'package:mmarn/features/team/presentation/screens/team_screen.dart';
import 'package:mmarn/features/users/data/repositories/auth_repository_impl.dart';
import 'package:mmarn/features/users/presentation/screens/change_password_screen.dart';
import 'package:mmarn/features/users/presentation/screens/login_screen.dart';
import 'package:mmarn/features/videos/presentation/screens/videos_screen.dart';
import 'package:mmarn/features/volunteering/data/datasources/voluntario_remote_source.dart';
import 'package:mmarn/features/volunteering/domain/usecases/enviar_voluntario.dart';
import 'package:mmarn/features/volunteering/presentation/screens/volunteering_screen.dart';
import 'package:mmarn/shared/widgets/bottom_navbar.dart';

import '../features/volunteering/data/repositories/voluntario_repository.dart';

class AppRouter {
  static final AuthRepositoryImpl authRepository = AuthRepositoryImpl(SecureStorageService());
  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/about',
            name: 'about us',
            builder: (BuildContext context, GoRouterState state) {
              return const AboutUsScreen();
            },
          ),
          GoRoute(
            path: '/team',
            name: 'team',
            builder: (BuildContext context, GoRouterState state) {
              return const TeamScreen();
            },
          ),
          GoRoute(
            path: '/about_team',
            name: 'about team',
            builder: (BuildContext context, GoRouterState state) {
              return const AboutTeamScreen();
            },
          ),
          GoRoute(
            path: '/login',
            name: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return LoginScreen();
            },
          ),
        ]
      ),
      GoRoute(
        path: '/services',
        name: 'services',
        builder: (BuildContext context, GoRouterState state) {
          return const ServicesScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/measures',
            name: 'measures',
            builder: (BuildContext context, GoRouterState state) {
            return const MeasuresScreen();
            },
          )
        ]
      ),
      GoRoute(
        path: '/news',
        name: 'news',
        builder: (BuildContext context, GoRouterState state) {
          return const NewsScreen();
        },
          routes: <RouteBase>[
            GoRoute(
              path: '/videos',
              name: 'videos',
              builder: (BuildContext context, GoRouterState state) {
                return const VideosScreen();
              },
            )
          ]
      ),
     GoRoute(
        path: '/protected',
        name: 'areas',
        builder: (BuildContext context, GoRouterState state) {
          return const AreasScreen();
        },
      ),
      GoRoute(
        path: '/volunteering',
        name: 'volunteering',
        builder: (BuildContext context, GoRouterState state) {
          final repository = VoluntarioRepositoryImpl(
            remoteDataSource: VoluntarioRemoteDataSource(),
          );
          final enviarUseCase = EnviarVoluntario(repository);

          return VolunteeringScreen(enviarVoluntarioUseCase: enviarUseCase);
        },
      ),
      GoRoute(
        path: '/logout',
        name: 'logout',
        redirect: (BuildContext context, GoRouterState state) async {
          await authRepository.logout();
          return '/home';
        },
      ),
      GoRoute(
        path: '/normative',
        name: 'normative',
        builder: (BuildContext context, GoRouterState state) {
          return const NormativesScreen();
        },
      ),
      GoRoute(
        path: '/my_reports',
        name: 'my_reports',
        builder: (BuildContext context, GoRouterState state) {
          return const ReportsScreen();
        },
      ),
      GoRoute(
        path: '/report',
        name: 'report',
        builder: (BuildContext context, GoRouterState state) {
          return const ReportDamageScreen();
        },
      ),
      GoRoute(
        path: '/map_report',
        name: 'map_report',
        builder: (BuildContext context, GoRouterState state) {
          return const ReportMapScreen();
        },
      ),
      GoRoute(
        path: '/change_password',
        name: 'change_password',
        builder: (BuildContext context, GoRouterState state) {
          return const ChangePasswordScreen();
        },
      ),
    ],
    redirect: (context, state) async {
      final isLoggedIn = await authRepository.isLoggedIn();

      final privateRoutes = ['/normatives', '/report', '/my_reports', '/map_report', '/change_password'];
      if (!isLoggedIn && privateRoutes.contains(state.uri.toString())) {
        return '/home/login';
      }
      return null;
    },
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Text(
          'Oops! La ruta ${state.uri} no fue encontrada.\nError: ${state.error}',
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentRoute: state.uri.toString()),
    ),
  );
}
