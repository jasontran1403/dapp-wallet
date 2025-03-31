import 'package:web3dart/web3dart.dart';
import 'package:flutter/foundation.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:hex/hex.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bip32/bip32.dart' as bip32;

abstract class WalletAddressService {
  String generateMnemonic();
  Future<String> getPrivateKey(String mnemonic);
  Future<EthereumAddress> getPublicKey(String privateKey);
}

class WalletProvider extends ChangeNotifier implements WalletAddressService {
  // Variable to store the private key
  String? privateKey;

  // Load the private key from the shared preferences
  Future<void> loadPrivateKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    privateKey = prefs.getString('privateKey');
  }

  // set the private key in the shared preferences
  Future<void> setPrivateKey(String privateKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('privateKey', privateKey);
    this.privateKey = privateKey;
    notifyListeners();
  }

  Future<void> clearPrivateKey() async {
    this.privateKey = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('privateKey');  // Xóa khỏi bộ nhớ
    notifyListeners();
  }

  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    print(mnemonic);
    final root = bip32.BIP32.fromSeed(seed);

    // Sử dụng derivation path giống MetaMask: m/44'/60'/0'/0/0
    final child = root.derivePath("m/44'/60'/0'/0/0");

    final privateKey = HEX.encode(child.privateKey!); // Lấy private key chuẩn
    await setPrivateKey(privateKey); // Lưu private key vào SharedPreferences
    return privateKey;
  }

  @override
  Future<EthereumAddress> getPublicKey(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = await private.address;
    return address;
  }
}
