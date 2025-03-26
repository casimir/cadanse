import 'package:flutter/cupertino.dart';

import 'tokens/adaptive/icons.dart';
import 'tokens/paddings.dart';
import 'tokens/spacers.dart';

class C {
  static Paddings paddings = Paddings();
  static Spacers spacers = Spacers();

  static C of(BuildContext context) => C(context);

  const C(BuildContext context) : _icons = Icons(context);

  final Icons _icons;
}
