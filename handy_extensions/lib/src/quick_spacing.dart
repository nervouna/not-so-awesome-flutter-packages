import 'package:flutter/widgets.dart';

extension QuickSpacing on num {
  SizedBox get w => SizedBox(width: toDouble());
  SizedBox get h => SizedBox(height: toDouble());
}
