import 'package:flutter/material.dart';

import '../Fonts/custom_fonts_properties.dart';

class CustomButtonStyles {
  static ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: CustomFontsProperties.customButtonFontSize,
    ),
  );
}
