import 'package:flutter/material.dart';
import 'package:pocket_flow/core/utils/responsive_utils.dart';

/// Centers [child] and limits its width on tablets. Wrap every screen body.
class ResponsiveBody extends StatelessWidget {
  const ResponsiveBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: context.responsive.contentMaxWidth,
        ),
        child: child,
      ),
    );
  }
}
