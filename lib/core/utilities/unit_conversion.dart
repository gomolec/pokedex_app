String metersToFeetsAndInches(double meters) {
  double length = 100 * meters / 2.54;
  int feet = (length / 12).floor();
  double inch = length - (12 * feet);
  return "$feet ft ${inch.toStringAsFixed(1)} in";
}

String kilogramsToPounds(double kilograms) {
  double lbs = kilograms / 0.45359237;
  return "${lbs.toStringAsFixed(1)} lbs";
}
