import 'package:crypto_wallet/UI/common_widgets/bottomRectangularbtn.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../socialLogin/socialLogin.dart';
class OnBoardingScreen3 extends StatelessWidget {
   OnBoardingScreen3({super.key});
  AppController appController=Get.find<AppController>();


  @override
  Widget build(BuildContext context) {
    return Obx(
          ()=> Scaffold(
        backgroundColor:appController.isDark.value==true?Color(0xff1A2B56): primaryColor.value,
        body: Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [

                  Image.asset("assets/images/onboardingBackgroundImage.png",width: Get.width,height: MediaQuery.of(context).size.height*0.6,),
                  Expanded(child: SizedBox())
                ],
              ),
            ),
            Positioned.fill(child: Obx(
                  ()=> Container(
                height: Get.height,
                width: Get.width,

                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(

                        width:Get.width,
                        // color: primaryBackgroundColor.value,
                        child: Stack(
                          children: [
                            Container(
                              // color: primaryBackgroundColor.value,
                                width: Get.width,
                                height:appController.isDark.value==true?  MediaQuery.of(context).size.height*0.59:MediaQuery.of(context).size.height*0.5,

                                child:appController.isDark.value==true?Image.asset("assets/images/onboarding1dark.png",width: Get.width,height:  MediaQuery.of(context).size.height*0.5,fit: BoxFit.fill,color: primaryBackgroundColor.value,): Image.asset("assets/images/onboarding1.png",width: Get.width,height:  MediaQuery.of(context).size.height*0.535,fit: BoxFit.fill,)),
                            Positioned.fill(child: Center(child:appController.isDark.value==true?Image.asset("assets/images/Receive Money (1).png",width: 183,height:  262,) :Image.asset("assets/images/Receive Money.png",width: 183,height:  262,)),
                            )
                          ],
                        )),
                    Column(
                      children: [
                        Transform.translate(
                          offset:appController.isDark.value==true? Offset(0, -80):Offset(0, -40),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Column(
                              children: [
                                Container(
                                  height: Get.height*0.4,
                                  width: Get.width,
                                  padding: EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                      color: primaryBackgroundColor.value,

                                      borderRadius: BorderRadius.circular(8),

                                      boxShadow: [
                                        BoxShadow(
                                          color: headingColor.value.withOpacity(0.15),
                                          blurRadius: 14,
                                          spreadRadius: -5,

                                        )
                                      ]
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "${getTranslated(context,"Buy Crypto \nEffortlessly" )??"Buy Crypto \nEffortlessly"}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color:appController.isDark.value==true?headingColor.value: primaryColor.value,
                                          fontFamily: "dmsans",

                                        ),

                                      ),
                                      Text(
                                        "${getTranslated(context,"Streamline your crypto purchases effortlessly on our platform, providing you with a hassle-free experience and peace of mind." )??"Streamline your crypto purchases effortlessly on our platform, providing you with a hassle-free experience and peace of mind."} ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: lightTextColor.value,
                                          fontFamily: "dmsans",

                                        ),

                                      ),
                                      SizedBox(height: 20,),
                                      BottomRectangularBtn(
                                        color: appController.isDark.value==true?Color(0xff5C87FF): primaryColor.value,
                                        onTapFunc: (){Get.to(SocialLogin());}, btnTitle: "Take me in",hasIcon: true,svgName:"arrow_next" ,)

                                    ],
                                  ),
                                ),
                                SizedBox(height:32,),
                                SvgPicture.asset("assets/svgs/Slider indicator (2).svg",height: 9,width: 80,)
                                ,SizedBox(height: 20,),



                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),




                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

}
