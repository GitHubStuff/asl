/// Extended the idea of 'Brightness' beyond just Dark/Light to include what dictates the current
/// brightness type (Follows System/Device setting, or the Application has set Dark/Light Modes)
import 'package:flutter/material.dart';

enum BrightnessSetting {
  applicationDark,
  applicationLight,
  systemDark,
  systemLight,
}

extension BrightnessIcon on BrightnessSetting {
  IconData get icon {
    switch (this) {
      case BrightnessSetting.applicationDark:
        return Icons.lightbulb_outline;
      case BrightnessSetting.applicationLight:
        return Icons.lightbulb;
      case BrightnessSetting.systemDark:
        return Icons.dark_mode_outlined;
      case BrightnessSetting.systemLight:
        return Icons.light_mode_sharp;
    }
  }
}
