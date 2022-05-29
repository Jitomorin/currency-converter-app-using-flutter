import 'package:currency_converter/screens/home_screen.dart';
import 'package:currency_converter/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Currency converter',
        theme: ThemeData(
          backgroundColor: mainCLight,
          textTheme: GoogleFonts.senTextTheme(),
        ),
        darkTheme: ThemeData(
          backgroundColor: mainCDark,
          textTheme: GoogleFonts.senTextTheme(),
        ),
        home: const HomeScreen(),
      );
    }));
  }
}
