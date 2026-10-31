import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Label on top, field below. Shared by every `K` form field so labels look
/// identical app-wide.
class KLabeledField extends StatelessWidget {
  const KLabeledField({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const Gap(8),
        child,
      ],
    );
  }
}
