import 'package:flutter/material.dart';

// Main Colors
const pureBlack = Color.fromARGB(255, 0, 0, 0);
const smokyBlack = Color(0xFF131212);
const eerieBlack = Color(0xFF1F1F1F);
const amaranth = Color(0xFFE30846);
const lavenderBlush = Color(0xFFFFF0F0);
const actionSuccesful = Color(0xFFAFD132);
const rctGrey = Color.fromARGB(255, 105, 103, 103);

class CreateMaterialColor {
  MaterialColor customColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

final customColor = CreateMaterialColor();

// MaterialColor mainColor = AcidGreen.acidgreen;
MaterialColor primarySwatch = customColor.customColor(
  const Color(0xE0D1CE33),
);
MaterialColor defaultColor = customColor.customColor(
  const Color(0xFFD1CE33),
);

MaterialColor matButtonColor = customColor.customColor(
  const Color(0xFFD1CE33),
);

MaterialColor scaffoldMBG = customColor.customColor(
  Color.fromARGB(255, 237, 235, 223),
);

MaterialColor mcLavenderBlush = customColor.customColor(
  const Color(0xFFFFF0F0),
);

const buttonBG = Color(0xFF8DC640);
const navPane = Colors.white;
final scaffoldBG = Colors.grey[350];
final appGrey = Colors.grey[350];

// Main Colors
// const pureBlack = Color(0x00000000);
// const smokyBlack = Color(0xFF131212);
// const eerieBlack = Color(0xFF1F1F1F);
// const amaranth = Color(0xFFE30846);
// const lavenderBlush = Color(0xFFFFF0F0);
// const actionSuccesful = Color(0xFFAFD132);

const a4Transparent = Colors.transparent;
const registerSuccesful = Color(0xFFAFD132);

const vHomeTab = Color(0xff8DC640);

const blueGradient = LinearGradient(
  begin: Alignment(1.0, 0.11),
  end: Alignment(-1.03, 0.08),
  colors: [Color(0xFF3861B0), Color(0xFF2777B9), Color(0xFF01A0C7)],
  stops: [0.0, 0.498, 1.0],
);
