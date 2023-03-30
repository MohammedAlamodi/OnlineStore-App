

// ignore: missing_return
String moneyFormatSetWithOutComma(String price) {
  if (price.length > 2) {
    var value = '';
    for (var i = 0; i < price.length; i++) {
      if (price[i] != ',') {
        value += price[i];
      }
    }
    return value;
  }
}