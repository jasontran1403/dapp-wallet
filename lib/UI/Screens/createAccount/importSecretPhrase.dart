import 'dart:convert';

import 'package:crypto_wallet/UI/Screens/profile/privateKey.dart';
import 'package:crypto_wallet/UI/Screens/socialLogin/socialLogin.dart';
import 'package:crypto_wallet/UI/common_widgets/bottomNavBar.dart';
import 'package:crypto_wallet/UI/common_widgets/inputField.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:crypto_wallet/services/utilServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/credentials.dart';

import '../../../controllers/appController.dart';
import '../../../providers/wallet_provider.dart';
import '../../../services/apiService.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../homeScreen/homeScreen.dart';

class ImportSecretPhrase extends StatefulWidget {
  ImportSecretPhrase({super.key});

  @override
  State<ImportSecretPhrase> createState() => _ImportSecretPhraseState();
}

class _ImportSecretPhraseState extends State<ImportSecretPhrase> {
  TextEditingController secretPhraseController = TextEditingController();

  final appController = Get.find<AppController>();

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${getTranslated(context, "Import Secret Phrase") ?? "Import Secret Phrase"}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: headingColor.value,
                                fontFamily: "dmsans",
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(SocialLogin());
                              },
                              child: Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: inputFieldBackgroundColor2.value,
                                  border: Border.all(width: 1, color: inputFieldBackgroundColor.value),
                                ),
                                child: Icon(
                                  Icons.clear,
                                  size: 18,
                                  color: appController.isDark.value == true ? Color(0xffA2BBFF) : headingColor.value,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                                child: Text(
                                  '${getTranslated(context, "Secret Recovery Phrase") ?? "Secret Recovery Phrase"}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: headingColor.value,
                                    fontSize: 20,
                                    fontFamily: 'dmsans',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                child: Text(
                                  '${getTranslated(context, "Restore an existing wallet with your 12-24-word secret recovery phrase") ?? "Restore an existing wallet with your 12-24-word secret recovery phrase"}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: lightTextColor.value,
                                    fontSize: 14,
                                    fontFamily: 'dmsans',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Text(
                              '${getTranslated(context, "Secret Phrase") ?? "Secret Phrase"}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: headingColor.value,
                                fontSize: 15,
                                fontFamily: 'dmsans',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        InputFields2(
                          textController: secretPhraseController,
                          onChange: (v) {
                            setState(() {});
                          },
                          maxLines: 5,
                          hintText: "${getTranslated(context, "Secret Recovery Phrase") ?? "Secret Recovery Phrase"}",
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(height: 20),
                        BottomRectangularBtn(
                          color: secretPhraseController.text.trim() != "" ? primaryColor.value : inputFieldBackgroundColor2.value,
                          isDisabled: secretPhraseController.text.trim() == "" ? true : false,
                          onTapFunc: () {
                            // Lấy mnemonicWords từ secretPhraseController.text và kiểm tra số lượng từ
                            List<String> mnemonicWords = secretPhraseController.text.trim().split(" ");

                            // Kiểm tra nếu mnemonic có ít hơn 12 từ
                            if (mnemonicWords.length != 12) {
                              // Hiển thị lỗi nếu không đủ 12 từ
                              Get.snackbar(
                                  "Error",
                                  "Mnemonics không hợp lệ. Vui lòng nhập đủ 12 từ.",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white
                              );
                            } else {
                              // Nếu đủ 12 từ, gọi hàm _saveWalletInformation
                              _saveWalletInformation(mnemonicWords);
                            }
                          },
                          btnTitle: "Import",
                        ),
                        SizedBox(height: 20),
                      ],
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

  // Hàm lưu thông tin ví sau khi kiểm tra mnemonic
  void _saveWalletInformation(List<String> mnemonicWords) async {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);

    try {
      // Lấy private key từ mnemonic
      String privateKey = await walletProvider.getPrivateKey(mnemonicWords.join(" "));

      // Lấy địa chỉ ví từ private key
      EthereumAddress ethereumAddress = await walletProvider.getPublicKey(privateKey);
      String walletAddress = ethereumAddress.hex;

      if (walletAddress.contains("0x")) {
        // Lưu vào Provider để các component khác có thể sử dụng
        // await walletProvider.setPrivateKey(privateKey);
        // await walletProvider.setWalletAddress(walletAddress.hex);
        dynamic response = await ApiService.login(walletAddress, privateKey);

        String responseWalletAddress = json.decode(response)['walletAddress'];
        String responseAccountName = json.decode(response)['displayName'];
        String responsePinCode = json.decode(response)['pinCode'];
        String responseBtcWalletAddress = json.decode(response)['btcWalletAddress'];
        String responseXrpWalletAddress = json.decode(response)['xrpWalletAddress'];
        String responseTonWalletAddress = json.decode(response)['tonWalletAddress'];

        print(responseBtcWalletAddress + " " + responseXrpWalletAddress + " " + responseTonWalletAddress);

        if (responseWalletAddress == walletAddress) {
          Get.snackbar(
            "Success",
            "Sign in successful. Redirect after 1 seconds.",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('privateKey', privateKey);
          await prefs.setString('walletAddress', walletAddress);
          await prefs.setString('accountName', responseAccountName);
          await prefs.setString('pinCode', responsePinCode);
          await prefs.setString('mnemonics', mnemonicWords.join(" "));
          await prefs.setString('btcWalletAddress', responseBtcWalletAddress);
          await prefs.setString('xrpWalletAddress', responseXrpWalletAddress);
          await prefs.setString('tonWalletAddress', responseTonWalletAddress);

          Future.delayed(Duration(seconds: 1), () {
            Get.offAll(BottomBar());
          });
        } else {
          Get.snackbar(
            "Error",
            "Sign in failed.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }


      } else {
        Get.snackbar("Error", "Mnemonics is invalid, please try again!", backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to generate wallet. Please try again!", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
