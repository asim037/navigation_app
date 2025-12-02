import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_app/presentation/screens/screen_a.dart';
import 'package:navigation_app/presentation/screens/screen_b.dart';
import 'package:navigation_app/presentation/screens/screen_c.dart';
import 'package:navigation_app/utils/constants/app_constants.dart';
import 'package:navigation_app/utils/styles/app_colors.dart';

class AppRoutes {
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: AppConstants.routeScreenA,
    routes: [
      GoRoute(
        path: AppConstants.routeScreenA,
        name: 'screenA',
        builder: (context, state) => const ScreenA(),
      ),
      GoRoute(
        path: AppConstants.routeScreenB,
        name: 'screenB',
        builder: (context, state) {
          final phrase = state.uri.queryParameters['phrase'] ?? '';
          final hashtags = state.uri.queryParameters['hashtags'] ?? '';
          final colorValue = state.uri.queryParameters['color'];
          Color? hashtagColor;
          if (colorValue != null) {
            try {
              hashtagColor = Color(int.parse(colorValue));
            } catch (e) {
              hashtagColor = AppColors.defaultHashtagColor;
            }
          } else {
            hashtagColor = AppColors.defaultHashtagColor;
          }
          return ScreenB(
            phrase: phrase,
            hashtags: hashtags,
            hashtagColor: hashtagColor,
          );
        },
      ),
      GoRoute(
        path: AppConstants.routeScreenC,
        name: 'screenC',
        builder: (context, state) => const ScreenC(),
      ),
    ],
  );
}
