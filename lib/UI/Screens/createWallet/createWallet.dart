import 'package:crypto_wallet/UI/Screens/socialLogin/socialLogin.dart';
import 'package:crypto_wallet/UI/Screens/verifyMnemonic/verifyMnemonic.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:crypto_wallet/providers/wallet_provider.dart';

import '../../../controllers/appController.dart';

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
                                color: Colors.white,
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
                          color: Colors.grey.shade800.withOpacity(0.7),
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
                                color: Colors.white,
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
                                    crossAxisCount: 3,
                                    childAspectRatio: 1.3, // Tăng tỉ lệ chiều cao để chứa text wrap
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 4,
                                  ),
                                  itemCount: 12,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade800.withOpacity(1),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            width: 1,
                                            color: inputFieldBackgroundColor.value
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          // Nội dung từ khoá
                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(0),
                                              child: Text(
                                                "${index + 1}. ${mnemonicWords[index]}",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 12, // Giảm kích thước chữ
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white,
                                                ),
                                                softWrap: true, // Cho phép xuống dòng
                                                maxLines: 2, // Giới hạn tối đa 2 dòng
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 16), // Khoảng cách giữa GridView và Button

                                // Nút xác nhận chuyển sang trang VerifyMnemonic
                                ElevatedButton(
                                  onPressed: () {
                                    Get.to(() => VerifyMnemonic(mnemonicWords: mnemonicWords)); // Truyền danh sách mnemonic
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade800.withOpacity(0.7), // Màu nền nút
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
                                      color: Colors.white,
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

            ],
          ),
        ),
      ),
    );
  }
}
