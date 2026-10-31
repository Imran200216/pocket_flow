import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_flow/core/enums/app_language.dart';
import 'package:pocket_flow/features/account/domain/entities/account_setup.dart';
import 'package:pocket_flow/features/account/presentation/bloc/account_setup_state.dart';

class AccountSetupCubit extends Cubit<AccountSetupState> {
  AccountSetupCubit() : super(const AccountSetupState());

  void selectLanguage(AppLanguage? language) =>
      emit(state.copyWith(language: language));

  void selectCurrency(String currencyCode) =>
      emit(state.copyWith(currencyCode: currencyCode));

  void submit(String username) {
    final language = state.language;
    final currencyCode = state.currencyCode;
    if (language == null || currencyCode == null) return;
    emit(
      state.copyWith(
        completed: AccountSetup(
          username: username.trim(),
          language: language,
          currencyCode: currencyCode,
        ),
      ),
    );
  }
}
