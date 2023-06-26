String formatNumber(int number) {
  if (number < 10000) {
    // If the number is less than 10000, just show the number as is
    return number.toString();
  } else {
    String tenThousandUnit = (number / 10000).toString();
    if (tenThousandUnit.contains('.')) {
      // If the number is greater than 10000, show the number in the format of 1.1w
      return "${tenThousandUnit.substring(0, tenThousandUnit.indexOf('.') + 2)}w";
    } else {
      // If the number is greater than 10000, show the number in the format of 1w
      return '$tenThousandUnit w';
    }
  }
}
