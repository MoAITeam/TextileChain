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

  Future<void> verifyQRCode(context, qrcode) async {
    await _textileWeb3Service.setCurrentTextile(qrcode);
    final contract = await _textileWeb3Service.verifyContract(qrcode);
    print(contract);
  }
}
