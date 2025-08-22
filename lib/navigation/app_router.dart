import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mmarn/features/about_team/about_team_screen.dart';
import 'package:mmarn/features/about_us/presentation/screens/about_us_screen.dart';
import 'package:mmarn/features/areas/presentation/screens/areas_screen.dart';
import 'package:mmarn/features/home/presentation/screens/home_screen.dart';
import 'package:mmarn/features/measures/presentation/screens/measures_screen.dart';
import 'package:mmarn/features/news/presentation/screens/news_screen.dart';
import 'package:mmarn/features/services/presentation/pages/services_screen.dart';
import 'package:mmarn/features/team/presentation/screens/team_screen.dart';
import 'package:mmarn/features/users/presentation/screens/login_screen.dart';
import 'package:mmarn/features/videos/presentation/screens/videos_screen.dart';
import 'package:mmarn/features/volunteering/data/datasources/voluntario_remote_source.dart';
import 'package:mmarn/features/volunteering/domain/usecases/enviar_voluntario.dart';
import 'package:mmarn/features/volunteering/presentation/screens/volunteering_screen.dart';
import 'package:mmarn/shared/widgets/bottom_navbar.dart';

import '../features/volunteering/data/repositories/voluntario_repository.dart';

class AppRouter {
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
          )
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
        path: '/login',
        name: 'login',
        builder: (BuildContext context, GoRouterState state) {
          return LoginScreen();
        },
      ),
    ],
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
