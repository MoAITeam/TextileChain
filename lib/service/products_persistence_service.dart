import 'persistence_service.dart';
import '../setup/locator.dart';

class ProductsPersistenceService {

  final PersistenceService _persistenceService =
      serviceLocator<PersistenceService>();

  Future<void> addProductToUser(
      String userAddress, String elementAddress) async {
    await _persistenceService.addElementToDocumentList(
        'users', userAddress, 'products', elementAddress);
  }

  Future<void> removeProductFromUser(
      String userAddress, List<String> elementsAddress) async {
    await _persistenceService.deleteElementsFromDocumentList(
        'users', userAddress, 'products', elementsAddress);
  }

  Future<List<String>> getUserProducts(String userAddress) async {
    var snapshot =
        await _persistenceService.getElementsFromDocument('users', userAddress);

    if (snapshot.exists) {
      List<dynamic> products = snapshot.data()!['products'];

      return products.map<String>((item) => item.toString()).toList();
    } else {
      return [];
    }
  }
}