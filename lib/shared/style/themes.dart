import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter2/shared/style/color.dart';
import 'package:hexcolor/hexcolor.dart';


ThemeData darkTheme = ThemeData(
  primarySwatch:defaultColor,

  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('121212'),
          statusBarIconBrightness: Brightness.light),
      backgroundColor: HexColor('121212'),
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold),
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.white,
      )),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
      backgroundColor: HexColor('121212')),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
        color: Colors.white),
  ),
  scaffoldBackgroundColor: HexColor('121212'),
);
ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor ,
  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: defaultColor,
          statusBarIconBrightness: Brightness.dark),
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold),
      color: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.black,
      )),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
        color: Colors.black),
  ),
  scaffoldBackgroundColor: Colors.white,
);