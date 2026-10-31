import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:pocket_flow/core/router/app_router.gr.dart';
import 'package:pocket_flow/l10n/app_localizations.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: Center(
        child: FilledButton(
          onPressed: () => context.router.push(const SettingsRoute()),
          child: const Text('Settings'),
        ),
      ),
    );
  }
}
