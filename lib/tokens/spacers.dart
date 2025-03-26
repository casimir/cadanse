import 'package:flutter/widgets.dart';

import 'constants.dart';

class Spacers {
  final Widget horizontalContent = const SizedBox(width: kSpacingBetweenGroups);
  final Widget verticalContent = const SizedBox(height: kSpacingBetweenGroups);

  final Widget horizontalComponent = const SizedBox(width: kSpacingInGroup);
  final Widget verticalComponent = const SizedBox(height: kSpacingInGroup);
}
