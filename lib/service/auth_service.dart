import 'package:textilechain/setup/locator.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:get_it/get_it.dart';
import 'persistence_service.dart';

class AuthService {
  static const String _privateKeyName = "user_private_key";
  final PersistenceService _persistance = serviceLocator<PersistenceService>();

  EthPrivateKey _credentials;
  EthereumAddress _userAddress;
  String _userState;

  EthPrivateKey get credentials => _credentials;
  EthereumAddress get userAddress => _userAddress;
  String get userState => _userState;

  Future<bool> setUserState(String user) async {
    await _persistance.savePrefString('state', user);
    _userState = _persistance.getPrefString('state');
  }

  bool isUserLoggedIn() {
    return _userAddress != null;
  }

  Future<bool> tryLoadUserData() async {
    String key = _persistance.getPrefString(_privateKeyName);

    try {
      var cred = EthPrivateKey.fromHex(key);
      debugPrint(key);
      var addr = await cred.extractAddress();
      debugPrint(addr.toString());
      _credentials = cred;
      _userAddress = addr;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> logIn(String privateKey) async {
    await _persistance.savePrefString(_privateKeyName, privateKey);
    return tryLoadUserData();
  }

  Future<bool> logOut() async {
    bool done = await _persistance.removePrefString(_privateKeyName);
    _credentials = null;
    _userAddress = null;
    return done;
  }
}
