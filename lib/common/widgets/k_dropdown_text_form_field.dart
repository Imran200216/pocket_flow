import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pocket_flow/common/widgets/k_labeled_field.dart';

/// App-wide dropdown form field, built on `dropdown_button2`.
/// ALWAYS use this instead of `DropdownButtonFormField` / raw dropdown widgets.
/// Styling comes from the theme (`InputDecorationTheme`, `ColorScheme`).
class KDropdownTextFormField<T> extends HookWidget {
  const KDropdownTextFormField({
    super.key,
    required this.label,
    required this.items,
    required this.itemLabel,
    required this.hintText,
    required this.onChanged,
    this.value,
    this.validator,
    this.prefixIcon,
  });

  final String label;
  final List<T> items;
  final String Function(T item) itemLabel;
  final String hintText;
  final ValueChanged<T?> onChanged;
  final T? value;
  final FormFieldValidator<T>? validator;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final selectedValue = useValueNotifier<T?>(value, [value]);

    return KLabeledField(
      label: label,
      child: DropdownButtonFormField2<T>(
        valueListenable: selectedValue,
        isExpanded: true,
        decoration: InputDecoration(
          prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
        ),
        hint: Text(
          hintText,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        items: [
          for (final item in items)
            DropdownItem<T>(
              value: item,
              child: Text(itemLabel(item), style: theme.textTheme.bodyLarge),
            ),
        ],
        selectedItemBuilder: (context) => [
          for (final item in items)
            Text(itemLabel(item), style: theme.textTheme.bodyLarge),
        ],
        onChanged: onChanged,
        validator: validator,
        buttonStyleData: const FormFieldButtonStyleData(
          padding: EdgeInsets.zero,
        ),
        iconStyleData: IconStyleData(
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          iconEnabledColor: colors.onSurfaceVariant,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 280,
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.primaryContainer),
          ),
          offset: const Offset(0, -4),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
