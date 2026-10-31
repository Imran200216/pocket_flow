import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pocket_flow/core/utils/responsive_utils.dart';
import 'package:pocket_flow/l10n/app_localizations.dart';

class AccountSetupHeader extends StatelessWidget {
  const AccountSetupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final responsive = context.responsive;
    final onPrimary = theme.colorScheme.onPrimary;

    return Padding(
      padding: EdgeInsets.all(responsive.horizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.accountSetupTitle,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: onPrimary,
              fontSize: responsive.value(mobile: 36.0, tablet: 44.0),
            ),
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
          SizedBox(height: responsive.elementSpacing),
          Text(
            l10n.accountSetupSubtitle,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: onPrimary.withValues(alpha: 0.8),
              fontSize: responsive.value(mobile: 16.0, tablet: 20.0),
            ),
          ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.2, end: 0),
          SizedBox(height: responsive.sectionSpacing),
        ],
      ),
    );
  }
}
