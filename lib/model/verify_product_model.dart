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

class VerifyProductModel extends ChangeNotifier {
  final TextileFirebaseService _textileFirebaseService =
      serviceLocator<TextileFirebaseService>();
  final TextileWeb3Service _textileWeb3Service =
      serviceLocator<TextileWeb3Service>();
  final AuthService _authService = serviceLocator<AuthService>();

  Map<String, String> _details;
  Map<String, String> get getDetails => _details;

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

  void clearDetails() {
    _details = null;
  }

  Future<void> verifyQRCode(context, qrcode) async {
    clearDetails();
    await _textileWeb3Service.setCurrentTextile(qrcode);
    print(_textileWeb3Service.currentT.address);
    if (_textileWeb3Service.currentT.address != null) {
      final details = await _textileWeb3Service.verifyContract(qrcode);
      _details = details;
    } else {
      showTextDialog(context, true, 'Alert',
          'Cannot load the contract, the product scanned could be fake.', null);
    }
  }
}
