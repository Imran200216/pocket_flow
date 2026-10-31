enum AppLanguage {
  english('en', 'English'),
  spanish('es', 'Español'),
  french('fr', 'Français'),
  german('de', 'Deutsch'),
  hindi('hi', 'हिन्दी'),
  arabic('ar', 'العربية');

  const AppLanguage(this.code, this.nativeName);

  final String code;
  final String nativeName;
}
