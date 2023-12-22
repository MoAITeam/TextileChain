<h1 align="center">TextileChain </h1>
<p align="center">

<div align="center">
    <img src="assets/images/appbar_small.png"  alt="Blockchain Logo"/>
</div>

<br> 

TextileChain is a cross platform DApp that demonstrates the use of a web3 supply chain management system in the context of textile industry. The app allows the manufacturer to upload the primary resources (such as cotton, linen...) along with their production information to an Ethereum blockchain and then create a final product (such as trousers, tshirts,...) using the aforementioned materials; a QR code associated to each garment added in the blockchain is generated and uploaded on Firebase storage. The QR code points to the Ethereum address of the product and can be verified trough the application in order to determine its authenticity.

The app can be integrated with a textile quality control autonomous system that embeds a deep neural network, which scans the textile (ideally) in the industry checking for defects, then if it doen't find defects the textile a message is uploaded on IOTA ledger with a verification ID which proves that the primary resource is in fact detected as defectless. This contributes to make not counterfeitable the data uploaded in the blockchain.

## App UI
<p align="center">
  <img src="assets/images/homepage.PNG" alt="Image 1">
  <img src="assets/images/createproduct.PNG" alt="Image 2">
</p>


## Technologies deployed:
- Solidity
- Truffle
- Ganache 
- Web3Dart
- Dart
- Flutter

## Set up the development environment 
- Necessary programs and plugins 
    - Clone this repo
    - Install Flutter: https://docs.flutter.dev/get-started/install
    - Install Node.js and Npm: https://nodejs.org/en/
    - Install Truffle: `npm install -g truffle`
    - Download Ganache from: https://www.trufflesuite.com/ganache
    - Install FlutterFire CLI following this guide: https://firebase.flutter.dev/docs/cli
    - Install the flutter extension for VsCode (or the IDE of your choice)
- Set up the project 
    - run `flutter pub get` 
    - set the desired Http JSON-RPC API endpoint URL in the [config.dart file](lib/service/web3_link_service.dart)
    - generate a new firebase_options.dart file [like this](lib/setup/firebase_options.dart) 
      <br> to do so run `flutterfire configure -o "lib/setup/firebase_options.dart"` 
      <br> or follow this guide https://firebase.flutter.dev/docs/overview/
    - open Ganache , create a testnet and run it locally on port `7545`
    - enter the [smartcontracts folder](smartcontract) on the terminal and run `truffle migrate` 

## Run the app
- connect a device or open the emulator in Android Studio / Xcode
- start the flutter app : `flutter run`

## Authors 
- Alessio Bonacchi
- Marco Guerra
