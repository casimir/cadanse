import 'package:cadanse/tokens/constants.dart';
import 'package:flutter/widgets.dart';

const groupPadding = EdgeInsets.all(kSpacingBetweenGroups);
const inGroupPadding = EdgeInsets.all(kSpacingInGroup);

class Paddings {
  @Deprecated('Use [Paddings.group] instead')
  final EdgeInsets defaultPadding = groupPadding;

  final EdgeInsets group = groupPadding;
  final EdgeInsets inGroup = inGroupPadding;
}
