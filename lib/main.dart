import 'package:codewords/service/auth_service.dart';
import 'package:codewords/service/persistence_service.dart';
import 'package:codewords/service/textile_web3_service.dart';
import 'package:firebase_core/firebase_core.dart';

import 'create_product.dart';
import 'verify.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'setup/firebase_options.dart';
import 'model/home_model.dart';
import 'setup/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:convert/convert.dart';
import 'home.dart';
import "service/textile_firebase_service.dart";
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Reference ref =
      FirebaseStorage.instance.ref().child('/put-string-example.txt');
  ref.putString(
    "ciao",
    metadata: SettableMetadata(
      contentLanguage: 'en',
      customMetadata: <String, String>{'example': 'putString'},
    ),
  );
  setupLocator();
  await serviceLocator.allReady();

  runApp(await MyApp.init());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.

  static Future<MyApp> init() async {
    await serviceLocator<TextileWeb3Service>().setTextileFactory();
    return const MyApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomeWidget(),
      routes: {
        '/createProduct': (context) => const CreateProductWidget(),
        '/verify': (context) => const VerifyWidget(),
      },
    );
  }
}
