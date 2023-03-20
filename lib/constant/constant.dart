import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = Colors.black;
Color greyColor = Colors.grey;
Color whiteColor = Colors.white;
Color blackColor = Colors.black;
Color lightGreyColor = Colors.grey.withOpacity(0.1);


TextStyle bigFontStyle() {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 16.0,
      color: primaryColor,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle primaryFontStyle({fontSize, fontWeight}) {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: fontSize,
      color: primaryColor,
      fontFamily: 'Roboto',
      fontWeight: fontWeight,
    ),
  );
}
TextStyle secondaryFontStyle({fontSize, fontWeight}) {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: fontSize,
      color: primaryColor,
      fontFamily: 'Roboto',
      fontWeight: fontWeight,
    ),
  );
}

TextStyle greyFontStyle({fontSize, fontWeight}) {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: fontSize,
      color: greyColor,
      fontFamily: 'Roboto',
      fontWeight: fontWeight,
    ),
  );
}

TextStyle lightGreyFontStyle({fontSize, fontWeight}) {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: fontSize,
      color: lightGreyColor,
      fontFamily: 'Roboto',
      fontWeight: fontWeight,
    ),
  );
}

TextStyle whiteFontStyle({fontSize, fontWeight}) {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: fontSize,
      color: whiteColor,
      fontFamily: 'Roboto',
      fontWeight: fontWeight,
    ),
  );
}
