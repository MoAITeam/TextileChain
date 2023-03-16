import 'package:codewords/home.dart';
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
  bool _busy = false;
  bool get busy => _busy;
  bool _isEthAddress;
  bool get isEthAddress => _isEthAddress;
  bool _isFake;
  bool get isFake => _isFake;

  Map<String, String> _details;
  Map<String, String> get getDetails => _details;

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

  void clearDetails() {
    _details = null;
  }

  void clearIsFake() {
    _isFake = null;
  }

  void clearIsEthAddress() {
    _isEthAddress = null;
  }

  Future<void> verifyQRCode(context, qrcode) async {
    setBusy(true);
    clearDetails();
    clearIsEthAddress();
    clearIsFake();
    var ver = await _textileWeb3Service.setCurrentTextile(qrcode);
    _isEthAddress = (ver == null) ? false : true;
    if (_isEthAddress) {
      _details = await _textileWeb3Service.verifyContract(qrcode);
      if (_details == null) {
        _isFake = true;
        showTextDialog(context, true, 'Alert',
            'Cannot load the contract, the product scanned could be fake.', [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeWidget(),
              ),
            ),
          ),
        ]);
      } else {
        _isFake = false;
      }

      setBusy(false);
    } else {
      setBusy(false);
      showTextDialog(
          context,
          true,
          'Alert',
          'Cannot load the contract, the qr code scanned is not an ethereum address.',
          [
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeWidget(),
                ),
              ),
            ),
          ]);
    }
  }
}
