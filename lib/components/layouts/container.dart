import 'package:cadanse/layout.dart';
import 'package:flutter/widgets.dart';

/// A widget that constrains its child to a maximum width. It is intended to
/// be used as the main content container in apps that target small and large
/// screens.
///
/// The maximum width is defined by the [mediumBreakpoint] constant.
class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: mediumBreakpoint),
        child:
            padding != null ? Padding(padding: padding!, child: child) : child,
      ),
    );
  }
}
