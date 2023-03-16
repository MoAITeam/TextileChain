import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'persistence_service.dart';
import '../setup/locator.dart';

class TextileFirebaseService {
  final PersistenceService _persistenceService =
      serviceLocator<PersistenceService>();
  final Reference storageRef = FirebaseStorage.instance.ref();

  Future<void> addProductToUser(
      String userAddress, String elementAddress) async {
    await _persistenceService.addElementToDocumentList(
        'users', userAddress, 'products', elementAddress);
  }

  Future<void> sendQRCodeToStorage(qr, filename) async {
    Reference imageFile = storageRef.child(filename+'.png');
    try {
      await imageFile.putString(qr, format: PutStringFormat.base64);
    } on FirebaseException catch (e) {
      // ...
    }
  }

  Future<List<String>> getUserProducts(String userAddress) async {
    var snapshot =
        await _persistenceService.getElementsFromDocument('users', userAddress);

    if (snapshot.exists) {
      List<dynamic> products = snapshot.data()['products'];

      return products.map<String>((item) => item.toString()).toList();
    } else {
      return [];
    }
  }
}
