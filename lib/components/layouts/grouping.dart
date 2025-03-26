import 'package:cadanse/tokens/paddings.dart';
import 'package:flutter/widgets.dart';

/// A Group is an area that contains a group of related widgets. The grouping is
/// done using negative spaces (padding and spacing).
class PaddedGroup extends StatelessWidget {
  const PaddedGroup({
    super.key,
    required this.child,
    this.padding = groupPadding,
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: child,
    );
  }
}
