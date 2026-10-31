import 'package:auto_route/auto_route.dart';

import 'package:pocket_flow/core/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // Splash is registered but not shown first for now.
    AutoRoute(page: SplashRoute.page, path: '/splash'),
    AutoRoute(page: OnBoardingRoute.page, path: '/', initial: true),
    AutoRoute(page: AccountSetupRoute.page, path: '/account-setup'),
    AutoRoute(page: HomeRoute.page, path: '/home'),
    AutoRoute(page: SettingsRoute.page, path: '/settings'),
  ];
}
