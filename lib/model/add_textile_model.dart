import 'package:codewords/setup/locator.dart';
import 'package:web3dart/credentials.dart';

import '../service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../service/persistence_service.dart';
import '../service/textile_firebase_service.dart';

class AddTextileModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController textController1;

  TextEditingController textController2;

  DateTime datePicked;

  TextEditingController textController3;

  String dropDownValue;

  String textile_name;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    textController1.dispose();
    textController2.dispose();
    textController3.dispose();
  }
}
