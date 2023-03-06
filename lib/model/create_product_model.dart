import 'package:codewords/service/auth_service.dart';
import 'package:codewords/service/textile_web3_service.dart';
import 'package:codewords/setup/locator.dart';
import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../service/textile_firebase_service.dart';

class QueryResultForDropdown{
  String address;
  String displayText;

  @override String toString() {
    return displayText;
  }
}

class CreateProductModel extends ChangeNotifier {
  final TextileFirebaseService _textileFirebaseService =
      serviceLocator<TextileFirebaseService>();
  final TextileWeb3Service _textileWeb3Service =
      serviceLocator<TextileWeb3Service>();
  final AuthService _authService = serviceLocator<AuthService>();

  final Map<String, QueryResultForDropdown> _userTextiles = {};
  Map<String, QueryResultForDropdown> get userProducts => _userTextiles;

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
      QueryResultForDropdown result = new QueryResultForDropdown();
      result.displayText =  await _textileWeb3Service.getName() + '[' +
          constituent.substring(constituent.length - 6) +
          ']';
      result.address = constituent;
      _userTextiles[constituent] = result;
      /*_userTextiles[constituent] = _userTextiles[constituent] +
          '                       [' +
          constituent.substring(constituent.length - 6) +
          ']';*/
      _textileWeb3Service.clearCurrentProduct();
    }

    notifyListeners();
  }

  Future<void> createFinalProduct(String garment, String textile,
      String location, String date, BuildContext context) async {
    if (garment == "" || textile == "" || location == "" || date == "") {
      showTextDialog(
          context, true, 'Alert', 'One of the fields is empty', null);
    } else {
      var address = await _textileWeb3Service.createProduct(
          garment, "Placeholder tm.", location, date);

      await _textileFirebaseService.addProductToUser(
          _authService.userAddress.toString(), address);

      // Ci sarebbe anche da rimuovere i cstituents qui se uno vuole

      await _textileWeb3Service.setCurrentTextile(address);

      await _textileWeb3Service.addComponent(textile);

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
