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
  AppController appController=Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        backgroundColor: primaryBackgroundColor.value,
        body: Stack(
          children: [
        if(appController.isDark.value==false)
            Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                color: primaryBackgroundColor.value

              ),

              child: SvgPicture.asset("assets/svgs/backgroundPlaceHolder.svg",),
            ),
            Positioned.fill(child:  Container(
              height: Get.height,
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 100,),

                      Container(
                        height: 114,
                        width: 128,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color:appController.isDark.value==true?Color(0xff1A2B56): inputFieldBackgroundColor.value
                        ),
                        child: Center(child: SvgPicture.asset("assets/svgs/bitcoin-icons_node-hardware-outline.svg",color: appController.isDark.value?Color(0xffA2BBFF):darkBlueColor.value,)),
                      ),
                      SizedBox(height: 40,),
                      Text(
                        "${getTranslated(context,"Crypto Wallet" )??"Crypto Wallet"}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color:appController.isDark.value==true?Color(0xffFDFCFD): primaryColor.value,
                          fontFamily: "dmsans",

                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "${getTranslated(context,"Welcome to Crypto Wallet! Begin your journey by using Apple, Google or your email address." )??"Welcome to Crypto Wallet! Begin your journey by using Apple, Google or your email address."}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: lightTextColor.value,
                            fontFamily: "dmsans",

                          ),

                        ),
                      ),
                      SizedBox(height: 40,),
                      GestureDetector(
                        onTap: (){
                          Get.offAll(CreateWallet());
                        },
                        child: Container(
                          height: 56,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: inputFieldBackgroundColor.value,
                            borderRadius: BorderRadius.circular(16)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SvgPicture.asset("assets/svgs/apple.svg",color: headingColor.value,),
                              SizedBox(width: 14,),
                              Text(
                                "${getTranslated(context,"Create new wallet" )??"Create new wallet"}",
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
                      SizedBox(height: 8,),
                      GestureDetector(
                        onTap: (){
                          Get.offAll(ImportSecretPhrase());},
                        child: Container(
                          height: 56,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: inputFieldBackgroundColor.value,
                              borderRadius: BorderRadius.circular(16)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SvgPicture.asset("assets/svgs/google.svg"),
                              SizedBox(width: 14,),
                              Text(
                                "${getTranslated(context,"Import existing wallet" )??"Import existing wallet"}",
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




                    ],
                  ),
                ],
              ),
            ),)
          ],
        )
      ),
    );
  }
}
