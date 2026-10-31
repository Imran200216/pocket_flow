import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:pocket_flow/core/utils/responsive_utils.dart';
import 'package:pocket_flow/features/on_boarding/presentation/models/on_boarding_item.dart';

class OnBoardingPageContent extends StatelessWidget {
  const OnBoardingPageContent({super.key, required this.item});

  final OnBoardingItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final responsive = context.responsive;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive.horizontalPadding),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: item.image
                  .svg(fit: BoxFit.contain)
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .scale(
                    begin: const Offset(0.9, 0.9),
                    curve: Curves.easeOutBack,
                    duration: 500.ms,
                  ),
            ),
          ),
          Gap(responsive.sectionSpacing),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontSize: responsive.value(mobile: 32.0, tablet: 40.0),
            ),
          ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.2, end: 0),
          Gap(responsive.elementSpacing),
          Text(
            item.subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: responsive.value(mobile: 16.0, tablet: 20.0),
            ),
          ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }
}
