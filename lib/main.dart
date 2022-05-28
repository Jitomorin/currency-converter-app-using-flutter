import 'package:currency_converter/screens/home_screen.dart';
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
          textTheme: GoogleFonts.senTextTheme(),
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      );
    }));
  }
}