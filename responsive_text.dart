extension ResponsiveSizeHelper on BuildContext {
  double responsiveHeight(double percentage) {
    return MediaQuery.of(this).size.height * (percentage / 100);
  }

  double responsiveWidth(double percentage) {
    return MediaQuery.of(this).size.width * (percentage / 100);
  }

  // Add this method for responsive text sizes
  double responsiveText(double fontSize) {
    // This assumes that the base screen size you are designing for is around 360px width
    double baseWidth = 360.0;
    return fontSize * (MediaQuery.of(this).size.width / baseWidth);
  }
}
