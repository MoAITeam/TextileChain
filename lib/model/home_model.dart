import 'package:codewords/setup/locator.dart';
import 'package:web3dart/credentials.dart';

import '../service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../service/persistence_service.dart';
import '../service/textile_firebase_service.dart';

class HomeViewModel extends ChangeNotifier {
  final AuthService _authService = serviceLocator<AuthService>();
  bool _busy = false;
  bool get busy => _busy;

  EthPrivateKey get key => _authService.credentials;

  String get userState => _authService.userState;

  bool get isUserLogged => _authService.isUserLoggedIn();

  Future<void> login(BuildContext context, String privateKey) async {
    setBusy(true);
    bool success = await _authService.logIn(privateKey);
    setBusy(false);

    if (!success) {
      showTextDialog(context, true, 'Error',
          'Something went wrong with your key. Try again!', null);
    } else {
      //final TextileFirebaseService t = serviceLocator<TextileFirebaseService>();
      final PersistenceService p = serviceLocator<PersistenceService>();
      p.addElementToDocumentList('users', 'aaaa', 'products', 'bbbb');
      Navigator.pop(context);
    }
  }

  Future<void> logOut() async {
    await _authService.logOut();
    notifyListeners();
  }

  Future<void> setUserStateDropDown(BuildContext context, String user) async {
    await _authService.setUserState(user);
  }

  Future<void> navigateToLoginView(BuildContext context) async {
    await Navigator.pushNamed(context, '/logIn');
    notifyListeners();
  }

  Future<void> navigateToCreateProductView(BuildContext context) async {
    if (isUserLogged) {
      await Navigator.pushNamed(context, '/createProduct');
    } else {
      showTextDialog(context, true, 'You are not logged in',
          'To create a product you need to log in first', null);
    }
  }

  Future<void> navigateFindProductView(BuildContext context) async {
    await Navigator.pushNamed(context, '/findProduct');
  }

  Future<void> navigateMyProductsView(BuildContext context) async {
    if (isUserLogged) {
      await Navigator.pushNamed(context, '/myProducts');
    } else {
      showTextDialog(context, true, 'You are not logged in',
          'To see your products you need to log in first', null);
    }
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

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
