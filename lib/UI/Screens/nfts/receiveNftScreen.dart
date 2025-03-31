import 'package:crypto_wallet/UI/Screens/resetPassword/resetPassword.dart';
import 'package:crypto_wallet/UI/Screens/verifySuccess/verifySuccess.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../common_widgets/bottomRectangularbtn.dart';
class ReceiveNftScreen extends StatefulWidget {
  String? fromPage;
  ReceiveNftScreen({super.key,this.fromPage});

  @override
  State<ReceiveNftScreen> createState() => _ReceiveNftScreenState();
}

class _ReceiveNftScreenState extends State<ReceiveNftScreen> {
  AppController appController=Get.find<AppController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: primaryBackgroundColor.value,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 22,vertical: 20),
          children: [
            Row(
              children: [
                GestureDetector(

                    onTap:(){
                      Get.back();

                    },
                    child: Icon(Icons.arrow_back_ios,color: headingColor.value,size: 18,)),
                SizedBox(width: 8,),
                Text(
                  "${getTranslated(context,"Receive NFT" )??"Receive NFT"}",
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
            SizedBox(height: 32,),


            SizedBox(height: 32,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 227,
                  width: 227,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: inputFieldBackgroundColor.value,
                      border: Border.all(width: 1,color: inputFieldBackgroundColor2.value)
                  ),
                  child: Image.asset("assets/images/Mask group.png"

                  ,color: appController.isDark.value==true?Color(0xffA2BBFF):primaryColor.value,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                "${getTranslated(context,"Share this qr code to receive NFT on this address" )??"Share this qr code to receive NFT on this address"}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: lightTextColor.value,
                  fontFamily: "dmsans",

                ),

              ),
            ),
            SizedBox(height: 32,),
            Divider(height: 1,color: inputFieldBackgroundColor2.value,),
            SizedBox(height: 24,),
            Text(
              "${getTranslated(context,"Address" )??"Address"}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: lightTextColor.value,
                fontFamily: "dmsans",

              ),

            ),
            SizedBox(height: 16,),
            Text(
              "0x000ahdkakckoeiwkwkojxiz",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: headingColor.value,
                fontFamily: "dmsans",

              ),

            ),

            SizedBox(height: 44,),


            Row(
              children: [
                Expanded(
                  child: Container(
                    height:
                    50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: inputFieldBackgroundColor2.value,
                        border: Border.all(width: 1,color: primaryColor.value)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/svgs/ic_round-share.svg",color:appController.isDark.value==true?Color(0xff5C87FF): primaryColor.value,),
                        SizedBox(width: 10,),

                        Text(
                          "${getTranslated(context,"Share" )??"Share"}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color:appController.isDark.value==true?Color(0xff5C87FF): primaryColor.value,
                            fontFamily: "dmsans",

                          ),

                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Container(
                    height:
                    50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: primaryColor.value
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/svgs/Test.svg"),
                        SizedBox(width: 10,),

                        Text(
                          "Copy",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffFFFFFF),
                            fontFamily: "dmsans",

                          ),

                        ),
                      ],
                    ),
                  ),
                )
              ],
            )










          ],
        ),
      ),
    );
  }
}
