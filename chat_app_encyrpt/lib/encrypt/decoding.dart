import 'dart:math';

String decoding({required String encryptionMessage}) {
  String message = "";
  for (var i in encryptionMessage.split("|asrt")) {
    if (i.contains('&')) {
      message +=
          " ${String.fromCharCode(int.parse(((double.parse(i.substring(1, i.length)) * pi) / 571).toStringAsFixed(0)))}";
    } else if (i.contains("|asrt")) {
    } else {
      try {
        message += String.fromCharCode(
            int.parse(((double.parse(i) * pi) / 571).toStringAsFixed(0)));
      } catch (e) {
        //print(e);
      }
    }
  }
  return message;
}
