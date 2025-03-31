import 'package:crypto_wallet/UI/Screens/createAccount/createAccount.dart';
import 'package:crypto_wallet/UI/Screens/createAccount/importPrivateKey.dart';
import 'package:crypto_wallet/UI/Screens/socialLogin/socialLogin.dart';
import 'package:crypto_wallet/UI/Screens/verifyMnemonic/verifyMnemonic.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:crypto_wallet/providers/wallet_provider.dart';

import '../../../controllers/appController.dart';
import '../createAccount/importSecretPhrase.dart';


class CreateWallet extends StatefulWidget {
  CreateWallet({super.key});

  @override
  State<CreateWallet> createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  final appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    final mnemonic = walletProvider.generateMnemonic();
    final mnemonicWords = mnemonic.split(' ');

    return Scaffold(
      backgroundColor: primaryBackgroundColor.value,
      body: Obx(
            () => SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0,vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Text(
                          "${getTranslated(context,"Create new wallet" )??"Create new wallet"}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: headingColor.value,
                            fontFamily: "dmsans",

                          ),

                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap:(){
                        Get.offAll(SocialLogin());
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: inputFieldBackgroundColor.value,
                            border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                        ),
                        child: Icon(Icons.clear,size: 18,color:appController.isDark.value==true? Color(0xffA2BBFF): headingColor.value,),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24,),
                InkWell(
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: inputFieldBackgroundColor2.value,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 1, color: inputFieldBackgroundColor.value),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${getTranslated(context, "Wallet seed phrase (12 keywords)") ?? "Wallet seed phrase (12 keywords)"}",
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: headingColor.value,
                            fontFamily: "dmsans",
                          ),
                        ),
                        Text(
                          "${getTranslated(context, "Please store this mnemonic phrase safely.") ?? "Please store this mnemonic phrase safely."}",
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: redColor.value,
                            fontFamily: "dmsans",
                          ),
                        ),
                        SizedBox(height: 8),
                        Column(
                          children: [
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, // 3 ô mỗi hàng
                                childAspectRatio: 1, // Tỉ lệ chiều rộng và chiều cao của ô
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 4,
                              ),
                              itemCount: 12,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    // Số thứ tự nằm ngoài ô
                                    Text(
                                      "${index + 1}.",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: headingColor.value,
                                      ),
                                    ),
                                    SizedBox(width: 4), // Khoảng cách giữa số và ô

                                    // Ô chứa từ tiếng Anh
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                        decoration: BoxDecoration(
                                          color: appController.isDark.value ? Color(0xff1A2B56) : inputFieldBackgroundColor.value,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(width: 1, color: inputFieldBackgroundColor.value),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Word ${index + 1}", // Thay bằng danh sách từ thật nếu có
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: headingColor.value,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: 16), // Khoảng cách giữa GridView và Button

                            // Nút xác nhận chuyển sang trang VerifyMnemonic
                            ElevatedButton(
                              onPressed: () {
                                Get.to(VerifyMnemonic());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white, // Màu nền nút
                                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "Saved mnemonics",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
