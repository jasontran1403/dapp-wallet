import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../common_widgets/bottomRectangularbtn.dart';
class VerifySuccess extends StatefulWidget {
  const VerifySuccess({super.key});

  @override
  State<VerifySuccess> createState() => _VerifySuccessState();
}

class _VerifySuccessState extends State<VerifySuccess> {
  AppController appController=Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> Scaffold(
        backgroundColor: primaryBackgroundColor.value,
          resizeToAvoidBottomInset: false,
          body:  Stack(
            children: [
              if(appController.isDark.value==false)

                Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                    color: primaryBackgroundColor.value

                ),
                child: SvgPicture.asset("assets/svgs/backgroundPlaceHolder.svg",fit: BoxFit.fitWidth,),
              ),
              Positioned.fill(child:  Container(
                height: Get.height,
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 22,),
                decoration: BoxDecoration(

                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 10,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/svgs/Frame 18.svg"),
                          SizedBox(height: 44,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // GestureDetector(
                              //
                              //     onTap:(){
                              //       Get.back();
                              //
                              //     },
                              //     child: Icon(Icons.arrow_back_ios,color: darkBlueColor.value,)),
                              // SizedBox(width: 8,),
                              Text(
                                "${getTranslated(context,"Email Verified" )??"Email Verified"}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: darkBlueColor.value,
                                  fontFamily: "dmsans",

                                ),

                              ),
                            ],
                          ),

                          SizedBox(height: 12,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 38.0),
                            child: Text(
                              "${getTranslated(context,"Your email verification is complete. Click 'Continue' to access your crypto wallet." )??"Your email verification is complete. Click 'Continue' to access your crypto wallet."}",
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
                    ),
                    Column(
                      children: [
                        BottomRectangularBtn(onTapFunc: (){
                          Get.back();
                          Get.back();
                          Get.back();
                        }, btnTitle: "Continue"),
                        SizedBox(height: 24,),

                      ]
                    )
                  ],
                ),
              ),)
            ],
          )
      ),
    );
  }
}
