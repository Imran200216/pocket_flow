import 'package:pocket_flow/core/enums/app_language.dart';
import 'package:pocket_flow/features/account/domain/entities/account_setup.dart';

class AccountSetupState {
  const AccountSetupState({this.language, this.currencyCode, this.completed});

  final AppLanguage? language;
  final String? currencyCode;

  /// Set once the user submits a valid form.
  final AccountSetup? completed;

  AccountSetupState copyWith({
    AppLanguage? language,
    String? currencyCode,
    AccountSetup? completed,
  }) {
    return AccountSetupState(
      language: language ?? this.language,
      currencyCode: currencyCode ?? this.currencyCode,
      completed: completed ?? this.completed,
    );
  }
}
