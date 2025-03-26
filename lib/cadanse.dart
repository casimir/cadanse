import 'package:flutter/widgets.dart';

import 'tokens/adaptive/icons.dart';
import 'tokens/paddings.dart';
import 'tokens/spacers.dart';

class C {
  static Paddings paddings = Paddings();
  static Spacers spacers = Spacers();

  C(BuildContext context) : icons = AdaptiveIconFactory(context);

  final AdaptiveIconFactory icons;
}
