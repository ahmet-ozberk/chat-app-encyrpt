import 'dart:math';
String encyption({required String message}) {
  String encyptionMessage = "";
  for (var i in message.codeUnits) {
    if (i == 32) {
      encyptionMessage += "&";
    } else {
      encyptionMessage += "${(i * 571) / pi}|asrt";
    }
  }
  return encyptionMessage;
}
