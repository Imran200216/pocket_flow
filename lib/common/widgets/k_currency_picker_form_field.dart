import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';

/// Form field that opens the `currency_picker` sheet. Styled by the theme.
class KCurrencyPickerFormField extends StatelessWidget {
  const KCurrencyPickerFormField({
    super.key,
    required this.hintText,
    required this.onSelected,
    this.currencyCode,
    this.validator,
  });

  final String hintText;
  final ValueChanged<Currency> onSelected;
  final String? currencyCode;
  final FormFieldValidator<String>? validator;

  String? get _displayText {
    final code = currencyCode;
    if (code == null) return null;
    final currency = CurrencyService().findByCode(code);
    return currency == null ? code : '${currency.code} - ${currency.name}';
  }

  void _openPicker(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: onSelected,
      theme: CurrencyPickerThemeData(
        backgroundColor: colors.surface,
        titleTextStyle: theme.textTheme.bodyLarge,
        subtitleTextStyle: theme.textTheme.bodyMedium?.copyWith(
          color: colors.onSurfaceVariant,
        ),
        currencySignTextStyle: theme.textTheme.titleMedium?.copyWith(
          color: colors.primary,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        bottomSheetHeight: MediaQuery.sizeOf(context).height * 0.8,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FormField<String>(
      key: ValueKey(currencyCode),
      initialValue: currencyCode,
      validator: validator,
      builder: (field) => InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _openPicker(context),
        child: InputDecorator(
          decoration: InputDecoration(
            errorText: field.errorText,
            suffixIcon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          isEmpty: _displayText == null,
          child: Text(
            _displayText ?? hintText,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: _displayText == null
                  ? theme.colorScheme.onSurfaceVariant
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
