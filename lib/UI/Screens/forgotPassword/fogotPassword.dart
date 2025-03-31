import 'package:crypto_wallet/UI/Screens/homeScreen/homeScreen.dart';
import 'package:crypto_wallet/UI/Screens/signupScreen/signupScreen.dart';
import 'package:crypto_wallet/UI/Screens/verifyEmail/verifyEmail.dart';
import 'package:crypto_wallet/UI/common_widgets/bottomRectangularbtn.dart';
import 'package:crypto_wallet/UI/common_widgets/inputField.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                padding: EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(

                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          SizedBox(height: 80,),
                          Row(
                            children: [
                              GestureDetector(

                                  onTap:(){
                                    Get.back();

                                  },
                                  child: Icon(Icons.arrow_back_ios,color: darkBlueColor.value,)),
                              SizedBox(width: 8,),
                              Text(
                                "${getTranslated(context,"Get Verification Code" )??"Get Verification Code"}",
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
                          Text(
                            "${getTranslated(context,"Enter the registered email to get verification code on" )??"Enter the registered email to get verification code on"}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: lightTextColor.value,
                              fontFamily: "dmsans",

                            ),

                          ),

                          SizedBox(height: 40,),
                          InputFields(
                            headerText: "Email Address",
                            hasHeader: true,
                            hintText: "Enter your email...",



                          ),
                          SizedBox(height: 20,),


                        ],
                      ),
                    ),
                    Column(
                      children: [
                        BottomRectangularBtn(onTapFunc: (){
                          Get.to(Verifyemail(fromPage: 'forgot',));


                        }, btnTitle: "Get Code"),


                        SizedBox(height: 22,)
                      ],
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
