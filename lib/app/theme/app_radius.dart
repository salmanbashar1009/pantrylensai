import 'package:flutter/cupertino.dart';

abstract class AppRadius {
  static const double smalValue = 8.0;
  static const double mediumValue = 16.0;
  static const double largeValue = 24.0;
  static const double circularValue = 999.0;


  static const BorderRadius small = BorderRadius.all(Radius.circular(smalValue));
  static const BorderRadius medium = BorderRadius.all(Radius.circular(mediumValue));
  static const BorderRadius large = BorderRadius.all(Radius.circular(largeValue));
  static const BorderRadius circular = BorderRadius.all(Radius.circular(circularValue));
}