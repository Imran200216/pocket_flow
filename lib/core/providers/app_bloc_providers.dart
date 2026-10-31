import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Every app-wide bloc/cubit. Add new ones to [providers]; `main.dart`
/// provides them above the app via [wrap] (a `MultiBlocProvider`).
abstract final class AppBlocProviders {
  static List<BlocProvider> get providers => [];

  /// `MultiBlocProvider` asserts on an empty list, so skip it until the first
  /// bloc is registered.
  static Widget wrap({required Widget child}) {
    final registeredProviders = providers;
    if (registeredProviders.isEmpty) return child;
    return MultiBlocProvider(providers: registeredProviders, child: child);
  }
}
