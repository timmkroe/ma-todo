import 'dart:ui';

import 'package:flutter/widgets.dart';

abstract class AppColors {
  static Color primaryColor() {
    return const Color.fromRGBO(90, 103, 216, 1.0);
  }

  static Color redAccentcolor() {
    return const Color.fromRGBO(127, 29, 29, 1.0);
  }

  static Color backgroundColor() {
    return const Color.fromRGBO(237, 242, 247, 1.0);
  }

  static Color primaryTextColor() {
    return const Color.fromRGBO(45, 55, 72, 1.0);
  }

  static Color highPriorityColor() {
    return const Color.fromRGBO(229, 62, 62, 1.0);
  }

  static Color mediumPriorityColor() {
    return const Color.fromRGBO(221, 107, 32, 1.0);
  }

  static Color doneTaskColor() {
    return const Color.fromRGBO(203, 213, 224, 1.0);
  }
}
