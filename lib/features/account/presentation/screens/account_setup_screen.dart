import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pocket_flow/common/widgets/responsive_body.dart';
import 'package:pocket_flow/features/account/presentation/widgets/account_setup_form.dart';
import 'package:pocket_flow/features/account/presentation/widgets/account_setup_header.dart';

@RoutePage()
class AccountSetupScreen extends StatelessWidget {
  const AccountSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
