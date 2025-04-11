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
  Future<void> setWalletAddress(String walletAddress);
  Future<String?> getWalletAddress();
  Future<void> clearWalletAddress(); // ✅ Thêm hàm clear walletAddress
  Future<String?> getBtcWalletAddress();
  Future<String?> getXrpWalletAddress();
  Future<String?> getTonWalletAddress();
}

class WalletProvider extends ChangeNotifier implements WalletAddressService {
  String? privateKey;
  String? walletAddress;

  // Load the private key from SharedPreferences
  Future<void> loadPrivateKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    privateKey = prefs.getString('privateKey');
  }

  // Set the private key and store it in SharedPreferences
  Future<void> setPrivateKey(String privateKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('privateKey', privateKey);
    this.privateKey = privateKey;
    notifyListeners();
  }

  // Clear the private key from memory and storage
  Future<void> clearPrivateKey() async {
    this.privateKey = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('privateKey');  // Remove from storage
    await prefs.remove('accountName');  // Remove from storage
    await prefs.remove('pinCode');  // Remove from storage
    await prefs.remove('walletAddress');  // Remove from storage
    await prefs.remove('mnemonics');  // Remove from storage
    await prefs.remove('btcWalletAddress');  // Remove from storage
    await prefs.remove('tonWalletAddress');  // Remove from storage
    await prefs.remove('xrpWalletAddress');  // Remove from storage

    notifyListeners();
  }

  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  // Generate private key from mnemonic
  @override
  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final root = bip32.BIP32.fromSeed(seed);
    final child = root.derivePath("m/44'/60'/0'/0/0");

    final privateKey = HEX.encode(child.privateKey!); // Generate private key
    return privateKey;
  }

  // Generate wallet address from private key
  @override
  Future<EthereumAddress> getPublicKey(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = await private.address;
    return address;
  }

  // ✅ Set Wallet Address in SharedPreferences
  @override
  Future<void> setWalletAddress(String walletAddress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('walletAddress', walletAddress);
    this.walletAddress = walletAddress;
    notifyListeners();
  }

  // ✅ Get Wallet Address from SharedPreferences
  @override
  Future<String?> getWalletAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('walletAddress');
  }

  @override
  Future<String?> getBtcWalletAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('btcWalletAddress');
  }

  @override
  Future<String?> getXrpWalletAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('xrpWalletAddress');
  }

  @override
  Future<String?> getTonWalletAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('tonWalletAddress');
  }

  Future<String?> getMnemonics() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('mnemonics');
  }

  Future<String?> getAccountName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accountName');
  }

  Future<String?> getPrivateKeyFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('privateKey');
  }

  // ✅ Clear Wallet Address from SharedPreferences (Logout)
  @override
  Future<void> clearWalletAddress() async {
    this.walletAddress = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('walletAddress');  // Xóa khỏi bộ nhớ
    notifyListeners();
  }
}
