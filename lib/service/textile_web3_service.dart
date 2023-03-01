import 'package:web3dart/web3dart.dart';

import 'web3_link_service.dart';
import 'persistence_service.dart';
import '../setup/locator.dart';

class TextileWeb3Service {
  static const String factoryContractName = "TextileFactory";
  static const String productContractName = "Textile";

  final Web3Service _web3service = serviceLocator<Web3Service>();
  final PersistenceService _persistenceService =
      serviceLocator<PersistenceService>();

  DeployedContract _factoryT;
  DeployedContract _currentT;

  void clearFactory() => _currentT = null;
  void clearCurrentProduct() => _currentT = null;

  Future<void> setTextileFactory([String factoryAddress]) async {
    _factoryT =
        await _web3service.loadContract(factoryContractName, factoryAddress);
  }

  Future<void> setCurrentTextile(String productAddress) async {
    _currentT =
        await _web3service.loadContract(productContractName, productAddress);
  }

  Future<String> addComponent(String componentAddress) async {
    return await _web3service.submitTransaction(
        _currentT, "addComponent", [EthereumAddress.fromHex(componentAddress)]);
  }

  Future<String> createProduct(String name, String factoryName,
      String factoryLocation, String factoryDate) async {
    return await _web3service.submitTransaction(_factoryT, 'createProduct',
        [name, factoryName, factoryLocation, factoryDate]);
  }

  Future<String> getNewProductAddress(String transactionHash) async {
    var address = await _web3service.extractEventDataFromReceipt(
        _factoryT, 'TextileCreated', transactionHash, 0);

    return address[0].toString();
  }

  Future<String> finalProduct() async {
    return await _web3service.submitTransaction(_currentT, "finalProduct", []);
  }

  Future<String> consumeProduct() async {
    return await _web3service
        .submitTransaction(_currentT, "consumeProduct", []);
  }

  Future<String> productExchange() async {
    return await _web3service
        .submitTransaction(_currentT, "productExchange", []);
  }

  Future<Map<String, String>> getOldAndNewProductOwner(
      String transactionHash) async {
    var addressList = await _web3service.extractEventDataFromReceipt(
        _currentT, 'OwnershipTransferred', transactionHash, 0);

    return {
      'oldOwner': addressList[0].toString(),
      'newOwner': addressList[1].toString()
    };
  }

  Future<List<String>> getComponents() async {
    List<dynamic> response =
        await _web3service.queryContract(_currentT, "getConstituents", []);

    return response.first.map<String>((item) => item.toString()).toList();
  }

  Future<String> getName() async {
    List<dynamic> response =
        await _web3service.queryContract(_currentT, "getName", []);

    return response.first.toString();
  }

  Future<Map<String, String>> getProductDetails() async {
    List<dynamic> response =
        await _web3service.queryContract(_currentT, "getProductDetails", []);

    Map<String, String> map = {};

    map['product_name'] = response[0];
    map['manufacturer_name'] = response[1].toString();
    map['factory_name'] = response[2];
    map['factory_location'] = response[3];
    map['factory_date'] = response[4].toString();

    return map;
  }
}
