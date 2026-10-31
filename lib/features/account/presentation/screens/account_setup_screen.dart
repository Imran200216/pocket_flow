import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_flow/common/widgets/responsive_body.dart';
import 'package:pocket_flow/core/router/app_router.gr.dart';
import 'package:pocket_flow/features/account/presentation/bloc/account_setup_cubit.dart';
import 'package:pocket_flow/features/account/presentation/bloc/account_setup_state.dart';
import 'package:pocket_flow/features/account/presentation/widgets/account_setup_form.dart';
import 'package:pocket_flow/features/account/presentation/widgets/account_setup_header.dart';

@RoutePage()
class AccountSetupScreen extends StatelessWidget implements AutoRouteWrapper {
  const AccountSetupScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) =>
      BlocProvider(create: (_) => AccountSetupCubit(), child: this);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountSetupCubit, AccountSetupState>(
      listenWhen: (previous, current) =>
          previous.completed == null && current.completed != null,
      listener: (context, state) => context.router.replace(const HomeRoute()),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SafeArea(
          bottom: false,
          child: ResponsiveBody(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: const [
                      Expanded(child: AccountSetupHeader()),
                      AccountSetupForm(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
