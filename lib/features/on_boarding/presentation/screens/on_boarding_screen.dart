import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:pocket_flow/common/widgets/k_filled_btn.dart';
import 'package:pocket_flow/common/widgets/responsive_body.dart';
import 'package:pocket_flow/core/gen/assets.gen.dart';
import 'package:pocket_flow/core/router/app_router.gr.dart';
import 'package:pocket_flow/core/utils/responsive_utils.dart';
import 'package:pocket_flow/features/on_boarding/presentation/models/on_boarding_item.dart';
import 'package:pocket_flow/features/on_boarding/presentation/widgets/on_boarding_page_content.dart';
import 'package:pocket_flow/features/on_boarding/presentation/widgets/on_boarding_page_indicator.dart';
import 'package:pocket_flow/l10n/app_localizations.dart';

@RoutePage()
class OnBoardingScreen extends HookWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final responsive = context.responsive;
    final pageController = usePageController();
    final currentPage = useState(0);

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
    final isLastPage = currentPage.value == items.length - 1;

    void onPrimaryPressed() {
      if (isLastPage) {
        context.router.replace(const AccountSetupRoute());
        return;
      }
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ResponsiveBody(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: items.length,
                  onPageChanged: (page) => currentPage.value = page,
                  itemBuilder: (context, index) =>
                      OnBoardingPageContent(item: items[index]),
                ),
              ),
              Gap(responsive.sectionSpacing),
              OnBoardingPageIndicator(
                controller: pageController,
                count: items.length,
              ),
              Gap(responsive.sectionSpacing),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.horizontalPadding,
                ),
                child: KFilledBtn(
                  label: isLastPage ? l10n.getStarted : l10n.next,
                  onPressed: onPrimaryPressed,
                ),
              ),
              Gap(responsive.verticalSpacing),
            ],
          ),
        ),
      ),
    );
  }
}
