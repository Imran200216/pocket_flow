import 'package:flutter/material.dart';

/// App-wide filled button with a loading state.
/// ALWAYS use this instead of a raw `FilledButton`.
class KFilledBtn extends StatelessWidget {
  const KFilledBtn({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  static const double _loaderSize = 24;

  @override
  Widget build(BuildContext context) {
    final onPrimary = Theme.of(context).colorScheme.onPrimary;

    return FilledButton(
      // Keeps the enabled look while loading, but swallows taps.
      onPressed: isLoading ? () {} : onPressed,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: isLoading
            ? SizedBox(
                key: const ValueKey('loader'),
                width: _loaderSize,
                height: _loaderSize,
                child: CircularProgressIndicator.adaptive(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(onPrimary),
                ),
              )
            : Text(label, key: ValueKey(label)),
      ),
    );
  }
}
