import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:pocket_flow/l10n/app_localizations.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(body: Center(child: Text(l10n.splashTitle)));
  }
}
