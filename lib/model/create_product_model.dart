import 'package:codewords/service/auth_service.dart';
import 'package:codewords/service/textile_web3_service.dart';
import 'package:codewords/setup/locator.dart';
import 'package:flutter/material.dart';
import '../service/textile_firebase_service.dart';

class CreateProductModel extends ChangeNotifier {
  final TextileFirebaseService _textileFirebaseService =
      serviceLocator<TextileFirebaseService>();
  final TextileWeb3Service _textileWeb3Service =
      serviceLocator<TextileWeb3Service>();
  final AuthService _authService = serviceLocator<AuthService>();

  final Map<String, String> _userTextiles = {};
  Map<String, String> get userProducts => _userTextiles;

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

  Future<void> getAllUserProducts(context) async {
    _userTextiles.clear();

    List<String> constituents = await _textileFirebaseService
        .getUserProducts(_authService.userAddress.toString());

    for (String constituent in constituents) {
      await _textileWeb3Service.setCurrentTextile(constituent);
      _userTextiles[constituent] = await _textileWeb3Service.getName();
      print(_userTextiles[constituent]);
      _textileWeb3Service.clearCurrentProduct();
    }

    notifyListeners();
  }
}
