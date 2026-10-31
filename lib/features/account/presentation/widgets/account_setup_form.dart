import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:pocket_flow/common/widgets/k_currency_picker_form_field.dart';
import 'package:pocket_flow/common/widgets/k_dropdown_text_form_field.dart';
import 'package:pocket_flow/common/widgets/k_filled_btn.dart';
import 'package:pocket_flow/common/widgets/k_text_form_field.dart';
import 'package:pocket_flow/core/enums/app_language.dart';
import 'package:pocket_flow/core/router/app_router.gr.dart';
import 'package:pocket_flow/core/utils/responsive_utils.dart';
import 'package:pocket_flow/l10n/app_localizations.dart';

/// Rounded bottom sheet holding the username, language and currency fields.
/// UI only for now: selections live in local hook state, nothing is saved.
class AccountSetupForm extends HookWidget {
  const AccountSetupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final responsive = context.responsive;
    final colors = Theme.of(context).colorScheme;
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final usernameController = useTextEditingController();
    final selectedLanguage = useState<AppLanguage?>(null);
    final selectedCurrencyCode = useState<String?>(null);

    void onContinuePressed() {
      if (!(formKey.currentState?.validate() ?? false)) return;
      context.router.replace(const HomeRoute());
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.horizontalPadding,
        vertical: responsive.verticalSpacing,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            KTextFormField(
              label: l10n.usernameLabel,
              hintText: l10n.usernameHint,
              prefixIcon: Icons.person_outline_rounded,
              controller: usernameController,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              validator: (value) =>
                  (value ?? '').trim().isEmpty ? l10n.usernameRequired : null,
            ),
            Gap(responsive.elementSpacing),
            KDropdownTextFormField<AppLanguage>(
              label: l10n.languageLabel,
              hintText: l10n.languageHint,
              prefixIcon: Icons.language_rounded,
              items: AppLanguage.values,
              itemLabel: (language) => language.nativeName,
              value: selectedLanguage.value,
              onChanged: (language) => selectedLanguage.value = language,
              validator: (language) =>
                  language == null ? l10n.languageRequired : null,
            ),
            Gap(responsive.elementSpacing),
            KCurrencyPickerFormField(
              label: l10n.currencyLabel,
              hintText: l10n.currencyHint,
              prefixIcon: Icons.payments_outlined,
              currencyCode: selectedCurrencyCode.value,
              onSelected: (currency) =>
                  selectedCurrencyCode.value = currency.code,
              validator: (currencyCode) =>
                  currencyCode == null ? l10n.currencyRequired : null,
            ),
            Gap(responsive.sectionSpacing),
            KFilledBtn(label: l10n.continueLabel, onPressed: onContinuePressed),
          ],
        ),
      ),
    );
  }
}
