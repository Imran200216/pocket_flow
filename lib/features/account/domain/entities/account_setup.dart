import 'package:pocket_flow/core/enums/app_language.dart';

class AccountSetup {
  const AccountSetup({
    required this.username,
    required this.language,
    required this.currencyCode,
  });

  final String username;
  final AppLanguage language;
  final String currencyCode;
}
