// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Pocket Flow';

  @override
  String get splashTitle => 'Splash';

  @override
  String get onBoardingFirstTitle => 'Gain total control\nof your money';

  @override
  String get onBoardingFirstSubtitle =>
      'Become your own money manager\nand make every cent count';

  @override
  String get onBoardingSecondTitle => 'Know where your\nmoney goes';

  @override
  String get onBoardingSecondSubtitle =>
      'Track your transaction easily,\nwith categories and financial report';

  @override
  String get onBoardingThirdTitle => 'Planning ahead';

  @override
  String get onBoardingThirdSubtitle =>
      'Setup your budget for each category\nso you in control';

  @override
  String get next => 'Next';

  @override
  String get getStarted => 'Get Started';

  @override
  String get accountSetupTitle => 'Set up your account';

  @override
  String get accountSetupSubtitle =>
      'Tell us a little about you to personalise Pocket Flow';

  @override
  String get usernameLabel => 'Username';

  @override
  String get usernameHint => 'Enter your username';

  @override
  String get usernameRequired => 'Please enter a username';

  @override
  String get languageLabel => 'Language';

  @override
  String get languageHint => 'Select language';

  @override
  String get languageRequired => 'Please select a language';

  @override
  String get currencyLabel => 'Currency';

  @override
  String get currencyHint => 'Select currency';

  @override
  String get currencyRequired => 'Please select a currency';

  @override
  String get continueLabel => 'Continue';
}
