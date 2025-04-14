import 'dart:math';

import 'package:bip39/bip39.dart' as bip39;
import 'package:crypto_wallet/UI/Screens/createAccount/createAccount.dart';
import 'package:crypto_wallet/UI/Screens/homeScreen/homeScreen.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/credentials.dart';

import '../../../controllers/appController.dart';
import '../../../providers/wallet_provider.dart';

class VerifyMnemonic extends StatefulWidget {
  final List<String> mnemonicWords;

  const VerifyMnemonic({required this.mnemonicWords, super.key});

  @override
  State<VerifyMnemonic> createState() => _VerifyMnemonicState();
}

class _VerifyMnemonicState extends State<VerifyMnemonic> {
  final appController = Get.find<AppController>();
  List<int> hiddenIndexes = [];
  final Map<int, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    hiddenIndexes = _generateHiddenIndexes();
  }

  List<int> _generateHiddenIndexes() {
    final random = Random();
    List<int> indexes = List.generate(12, (index) => index);
    indexes.shuffle(random);
    return indexes.sublist(0, 4);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          ()=> Scaffold(
        backgroundColor: primaryBackgroundColor.value,
        body: SafeArea(
          child:
          Stack(
            children: [
              Positioned.fill(
                child:
                Image.asset(
                  "assets/background/bg7.png",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${getTranslated(context, "Verify mnemonic") ?? "Verify mnemonic"}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: "dmsans",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: inputFieldBackgroundColor.value,
                              border: Border.all(width: 1, color: inputFieldBackgroundColor.value),
                            ),
                            child: Icon(
                              Icons.clear,
                              size: 18,
                              color: appController.isDark.value ? Color(0xffA2BBFF) : headingColor.value,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 24),
                    Text(
                      "${getTranslated(context, "Please enter the missing keywords.") ?? "Please enter the missing keywords."}",
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: redColor.value,
                        fontFamily: "dmsans",
                      ),
                    ),
                    SizedBox(height: 8),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        bool isHidden = hiddenIndexes.contains(index);
                        if (isHidden) {
                          controllers[index] = TextEditingController();
                        }
                        return Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade800.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(width: 1, color: inputFieldBackgroundColor.value),
                                ),
                                child: isHidden
                                    ? TextField(
                                  controller: controllers[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "____",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                )
                                    : Center(
                                  child: Text(
                                    widget.mnemonicWords[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _validateMnemonics,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade800.withOpacity(0.7),
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Verify & Create Wallet",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _validateMnemonics() {
    bool isCorrect = true;

    for (int index in hiddenIndexes) {
      if (controllers[index]!.text.trim() != widget.mnemonicWords[index]) {
        isCorrect = false;
        break;
      }
    }



    if (isCorrect) {
      _saveWalletInformation();
    } else {
      Get.snackbar("Error", "Incorrect words. Please try again!", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void _saveWalletInformation() async {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);

    try {
      // Lấy private key từ mnemonic
      String privateKey = await walletProvider.getPrivateKey(widget.mnemonicWords.join(" "));
      EthereumAddress ethereumAddress = await walletProvider.getPublicKey(privateKey);
      String walletAddress = ethereumAddress.hex;

      if (walletAddress.contains("0x")) {
        Get.to(() => CreateAccount(walletAddress: walletAddress, privateKey: privateKey, mnemonicWords: widget.mnemonicWords.join(" "),));
      } else {
        Get.snackbar("Error", "Mnemonics is invalid, please try again!", backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to generate wallet. Please try again!", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

}
