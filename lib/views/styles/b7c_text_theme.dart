import 'package:dummy_api/views/styles/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class B7CTextTheme {
  static TextStyle tagTextStyle = GoogleFonts.oswald(
    fontWeight: FontWeight.w500,
    color: B7CColor.primaryColor,
  );
  static TextStyle nameTextStyle = GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    color: B7CColor.blackColor,
  );
  static TextStyle textTextStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal,
    color: B7CColor.blackColor,
  );
}
