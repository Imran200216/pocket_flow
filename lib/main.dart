import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pocket_flow/core/providers/app_bloc_providers.dart';
import 'package:pocket_flow/core/router/app_router.dart';
import 'package:pocket_flow/core/themes/app_theme.dart';
import 'package:pocket_flow/l10n/app_localizations.dart';

void main() {
  runApp(AppBlocProviders.wrap(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.light,
      routerConfig: AppRouter().config(),
    );
  }
}
