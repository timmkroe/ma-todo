import 'dart:ui';

import 'package:ma_todo/shared/app_colors.dart';

enum Priority {
  Low,
  Medium,
  High,
}

extension PriorityExtension on Priority {
  Color get color {
    if (this == Priority.High) {
      return AppColors.highPriorityColor();
    }
    if (this == Priority.Medium) {
      return AppColors.mediumPriorityColor();
    }

    return AppColors.primaryTextColor();
  }

  String get name {
    if (this == Priority.High) {
      return "High";
    }
    if (this == Priority.Medium) {
      return "Medium";
    }

    return "Low";
  }
}
