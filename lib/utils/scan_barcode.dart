
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
Future scanBarcode(BuildContext context)async{

  return await FlutterBarcodeScanner.scanBarcode(
      "#D1F1BB",
      "Cancel",
     false,
      ScanMode.BARCODE);

}