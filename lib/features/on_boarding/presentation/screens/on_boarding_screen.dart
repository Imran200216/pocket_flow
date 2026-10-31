import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pocket_flow/common/widgets/responsive_body.dart';
import 'package:pocket_flow/core/gen/assets.gen.dart';
import 'package:pocket_flow/core/router/app_router.gr.dart';
import 'package:pocket_flow/core/utils/responsive_utils.dart';
import 'package:pocket_flow/features/on_boarding/presentation/models/on_boarding_item.dart';
import 'package:pocket_flow/features/on_boarding/presentation/widgets/on_boarding_page_content.dart';
import 'package:pocket_flow/features/on_boarding/presentation/widgets/on_boarding_page_indicator.dart';
import 'package:pocket_flow/l10n/app_localizations.dart';

@RoutePage()
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPrimaryPressed(int pageCount) {
    if (_currentPage == pageCount - 1) {
      context.router.replace(const AccountSetupRoute());
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = [
      OnBoardingItem(
        image: Assets.svg.moneyWithHand,
        title: l10n.onBoardingFirstTitle,
        subtitle: l10n.onBoardingFirstSubtitle,
      ),
      OnBoardingItem(
        image: Assets.svg.moneyWithBill,
        title: l10n.onBoardingSecondTitle,
        subtitle: l10n.onBoardingSecondSubtitle,
      ),
      OnBoardingItem(
        image: Assets.svg.plan,
        title: l10n.onBoardingThirdTitle,
        subtitle: l10n.onBoardingThirdSubtitle,
      ),
    ];
    final isLast = _currentPage == items.length - 1;
    final responsive = context.responsive;

    return Scaffold(
      body: SafeArea(
        child: ResponsiveBody(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: items.length,
                  onPageChanged: (page) => setState(() => _currentPage = page),
                  itemBuilder: (context, index) =>
                      OnBoardingPageContent(item: items[index]),
                ),
              ),
              SizedBox(height: responsive.sectionSpacing),
              OnBoardingPageIndicator(
                controller: _controller,
                count: items.length,
              ),
              SizedBox(height: responsive.sectionSpacing),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.horizontalPadding,
                ),
                child: FilledButton(
                  onPressed: () => _onPrimaryPressed(items.length),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Text(
                      isLast ? l10n.getStarted : l10n.next,
                      key: ValueKey(isLast),
                    ),
                  ),
                ),
              ),
              SizedBox(height: responsive.verticalSpacing),
            ],
          ),
        ),
      ),
    );
  }
}
