import 'package:pocket_flow/core/gen/assets.gen.dart';

class OnBoardingItem {
  const OnBoardingItem({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final SvgGenImage image;
  final String title;
  final String subtitle;
}
