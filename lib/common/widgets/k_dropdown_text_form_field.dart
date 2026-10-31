import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

/// App-wide dropdown form field, built on `dropdown_button2`.
/// ALWAYS use this instead of `DropdownButtonFormField` / raw dropdown widgets.
/// Styling comes from the theme (`InputDecorationTheme`, `ColorScheme`).
class KDropdownTextFormField<T> extends StatefulWidget {
  const KDropdownTextFormField({
    super.key,
    required this.items,
    required this.itemLabel,
    required this.hintText,
    required this.onChanged,
    this.value,
    this.validator,
    this.prefixIcon,
  });

  final List<T> items;
  final String Function(T item) itemLabel;
  final String hintText;
  final ValueChanged<T?> onChanged;
  final T? value;
  final FormFieldValidator<T>? validator;
  final Widget? prefixIcon;

  @override
  State<KDropdownTextFormField<T>> createState() =>
      _KDropdownTextFormFieldState<T>();
}

class _KDropdownTextFormFieldState<T> extends State<KDropdownTextFormField<T>> {
  late final ValueNotifier<T?> _selectedValue = ValueNotifier(widget.value);

  @override
  void didUpdateWidget(covariant KDropdownTextFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedValue.value = widget.value;
  }

  @override
  void dispose() {
    _selectedValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return DropdownButtonFormField2<T>(
      valueListenable: _selectedValue,
      isExpanded: true,
      decoration: InputDecoration(prefixIcon: widget.prefixIcon),
      hint: Text(
        widget.hintText,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: colors.onSurfaceVariant,
        ),
      ),
      items: [
        for (final item in widget.items)
          DropdownItem<T>(
            value: item,
            child: Text(
              widget.itemLabel(item),
              style: theme.textTheme.bodyLarge,
            ),
          ),
      ],
      selectedItemBuilder: (context) => [
        for (final item in widget.items)
          Text(widget.itemLabel(item), style: theme.textTheme.bodyLarge),
      ],
      onChanged: widget.onChanged,
      validator: widget.validator,
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
    );
  }
}
