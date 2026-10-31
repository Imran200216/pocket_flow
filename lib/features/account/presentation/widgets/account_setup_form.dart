import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_flow/common/widgets/k_currency_picker_form_field.dart';
import 'package:pocket_flow/common/widgets/k_dropdown_text_form_field.dart';
import 'package:pocket_flow/core/enums/app_language.dart';
import 'package:pocket_flow/core/utils/responsive_utils.dart';
import 'package:pocket_flow/features/account/presentation/bloc/account_setup_cubit.dart';
import 'package:pocket_flow/features/account/presentation/bloc/account_setup_state.dart';
import 'package:pocket_flow/l10n/app_localizations.dart';

/// Rounded bottom sheet holding the username, language and currency fields.
class AccountSetupForm extends StatefulWidget {
  const AccountSetupForm({super.key});

  @override
  State<AccountSetupForm> createState() => _AccountSetupFormState();
}

class _AccountSetupFormState extends State<AccountSetupForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _onContinuePressed() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<AccountSetupCubit>().submit(_usernameController.text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final responsive = context.responsive;
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(
        responsive.horizontalPadding,
        responsive.verticalSpacing,
        responsive.horizontalPadding,
        responsive.verticalSpacing,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: BlocBuilder<AccountSetupCubit, AccountSetupState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _usernameController,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(hintText: l10n.usernameHint),
                  validator: (value) => (value ?? '').trim().isEmpty
                      ? l10n.usernameRequired
                      : null,
                ),
                SizedBox(height: responsive.elementSpacing),
                KDropdownTextFormField<AppLanguage>(
                  items: AppLanguage.values,
                  itemLabel: (language) => language.nativeName,
                  hintText: l10n.languageHint,
                  value: state.language,
                  onChanged: context.read<AccountSetupCubit>().selectLanguage,
                  validator: (language) =>
                      language == null ? l10n.languageRequired : null,
                ),
                SizedBox(height: responsive.elementSpacing),
                KCurrencyPickerFormField(
                  hintText: l10n.currencyHint,
                  currencyCode: state.currencyCode,
                  onSelected: (currency) => context
                      .read<AccountSetupCubit>()
                      .selectCurrency(currency.code),
                  validator: (currencyCode) =>
                      currencyCode == null ? l10n.currencyRequired : null,
                ),
                SizedBox(height: responsive.sectionSpacing),
                FilledButton(
                  onPressed: _onContinuePressed,
                  child: Text(l10n.continueLabel),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
