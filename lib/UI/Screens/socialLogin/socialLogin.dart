import 'package:crypto_wallet/UI/Screens/createAccount/importSecretPhrase.dart';
import 'package:crypto_wallet/UI/Screens/createWallet/createWallet.dart';
import 'package:crypto_wallet/UI/Screens/homeScreen/homeScreen.dart';
import 'package:crypto_wallet/UI/Screens/loginScreen/loginScreen.dart';
import 'package:crypto_wallet/UI/pinScreen.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class SocialLogin extends StatefulWidget {
  const SocialLogin({super.key});

  @override
  State<SocialLogin> createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        backgroundColor: primaryBackgroundColor.value,
        body: SafeArea(
          child: Stack(
            children: [
              // Đặt ảnh nền ở đây
              Positioned.fill(
                child: Image.asset(
                  "assets/images/Trust.png",
                  fit: BoxFit.cover, // Đảm bảo ảnh phủ toàn màn hình
                ),
              ),

              Positioned.fill(
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Sử dụng spaceBetween để phân bố đều
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 100),
                          Text(
                            "${getTranslated(context, "Ecofution Wallet") ?? "Ecofution Wallet"}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: appController.isDark.value == true
                                  ? Color(0xffFDFCFD)
                                  : Colors.white,
                              fontFamily: "dmsans",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "${getTranslated(context, "Welcome to EcoWallet!") ?? "Welcome to EcoWallet!"}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: lightTextColor.value,
                                fontFamily: "dmsans",
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Spacer to push buttons down to the bottom
                      Spacer(),

                      // Create new wallet button
                      GestureDetector(
                        onTap: () {
                          Get.offAll(CreateWallet());
                        },
                        child: Container(
                          height: 56,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: inputFieldBackgroundColor.value,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 14),
                              Text(
                                "${getTranslated(context, "Create new wallet") ?? "Create new wallet"}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: headingColor.value,
                                  fontFamily: "dmsans",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Import existing wallet button
                      GestureDetector(
                        onTap: () {
                          Get.offAll(ImportSecretPhrase());
                        },
                        child: Container(
                          height: 56,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: inputFieldBackgroundColor.value,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 14),
                              Text(
                                "${getTranslated(context, "Import existing wallet") ?? "Import existing wallet"}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: headingColor.value,
                                  fontFamily: "dmsans",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 60),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
