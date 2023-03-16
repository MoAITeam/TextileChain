import 'package:codewords/service/auth_service.dart';
import 'package:codewords/service/textile_web3_service.dart';
import 'package:codewords/setup/locator.dart';
import 'package:web3dart/credentials.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../service/persistence_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../service/persistence_service.dart';
import '../service/textile_firebase_service.dart';
import 'dart:math';

class AddTextileModel extends ChangeNotifier {
  final TextileFirebaseService _textileFirebaseService =
      serviceLocator<TextileFirebaseService>();
  final TextileWeb3Service _textileWeb3Service =
      serviceLocator<TextileWeb3Service>();
  final AuthService _authService = serviceLocator<AuthService>();
  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  void showTextDialog(BuildContext context, bool isDismissible, String title,
      String content, List<Widget> buttonList) {
    showDialog(
        barrierDismissible: isDismissible,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            title: Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold)),
            content: Text(content,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04)),
            actions: buttonList,
          );
        });
  }

  Future<void> createTextile(
      String factory_name,
      String factory_date,
      String factory_location,
      String textile_name,
      BuildContext context) async {
    setBusy(true);
    if (factory_date == "" ||
        factory_location == "" ||
        textile_name == "" ||
        factory_name == "") {
      showTextDialog(
          context, true, 'Alert', 'One of the fields is empty', null);
    } else {
      var verification_id = Random().nextInt(10000000).toString();
      var address = await _textileWeb3Service.createProduct(textile_name,
          factory_name, factory_location, factory_date, verification_id);

      await _textileFirebaseService.addProductToUser(
          _authService.userAddress.toString(), address);
      setBusy(false);

      showTextDialog(context, false, 'Success!',
          'Your product was added to the blockchain', [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: FlutterFlowTheme.of(context).primaryColor,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text('OK'))
      ]);
    }
  }
}
