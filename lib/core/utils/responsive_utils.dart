import 'package:flutter/widgets.dart';
import 'package:pocket_flow/core/enums/device_type.dart';

/// Single source of truth for mobile/tablet adaptation.
/// Use via `context.responsive` — never read `MediaQuery` sizes in screens.
class ResponsiveUtils {
  const ResponsiveUtils._(this.size);

  /// Shortest side at or above this width is treated as a tablet.
  static const double tabletBreakpoint = 600;

  /// Max width of page content on tablets, so layouts don't stretch.
  static const double tabletContentMaxWidth = 560;

  final Size size;

  factory ResponsiveUtils.of(BuildContext context) =>
      ResponsiveUtils._(MediaQuery.sizeOf(context));

  DeviceType get deviceType => size.shortestSide >= tabletBreakpoint
      ? DeviceType.tablet
      : DeviceType.mobile;

  bool get isTablet => deviceType == DeviceType.tablet;
  bool get isMobile => deviceType == DeviceType.mobile;
  bool get isLandscape => size.width > size.height;

  /// Picks a value by device type.
  T value<T>({required T mobile, required T tablet}) =>
      isTablet ? tablet : mobile;

  double get horizontalPadding => value(mobile: 24.0, tablet: 48.0);
  double get verticalSpacing => value(mobile: 24.0, tablet: 32.0);
  double get elementSpacing => value(mobile: 16.0, tablet: 24.0);
  double get sectionSpacing => value(mobile: 40.0, tablet: 56.0);
  double get contentMaxWidth =>
      value(mobile: double.infinity, tablet: tabletContentMaxWidth);
}

extension ResponsiveContext on BuildContext {
  ResponsiveUtils get responsive => ResponsiveUtils.of(this);
}
