import 'package:crypto_wallet/UI/Screens/forgotPassword/fogotPassword.dart';
import 'package:crypto_wallet/UI/Screens/homeScreen/homeScreen.dart';
import 'package:crypto_wallet/UI/Screens/signupScreen/signupScreen.dart';
import 'package:crypto_wallet/UI/Screens/verifyEmail/verifyEmail.dart';
import 'package:crypto_wallet/UI/common_widgets/bottomRectangularbtn.dart';
import 'package:crypto_wallet/UI/common_widgets/inputField.dart';
import 'package:crypto_wallet/UI/pinScreen.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                              // GestureDetector(
                              //
                              //     onTap:(){
                              //       Get.back();
                              //
                              //     },
                              //     child: Icon(Icons.arrow_back_ios,color: darkBlueColor.value,)),
                              // SizedBox(width: 8,),
                              Text(
                                "${getTranslated(context,"Welcome Back!" )??"Welcome Back!"}",
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
                            "${getTranslated(context,"Sign in to access your crypto wallet account." )??"Sign in to access your crypto wallet account."}",
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
                            textController: TextEditingController(),
                            headerText: "Email Address",
                            hasHeader: true,
                            hintText: "Enter your email...",
                            onChange: (v){},



                          ),
                          SizedBox(height: 20,),
                          InputFieldPassword(

                              headerText: "Password",hintText: "Enter your password...", textController: TextEditingController(), onChange: (){}),

                         SizedBox(height: 4,), Row(
                            mainAxisAlignment:MainAxisAlignment.end
                            ,
                            children: [
                              GestureDetector(
      onTap:(){ Get.to(ForgotPasswordScreen());},
                                child: Text(
                                  "${getTranslated(context,"Forget password?" )??"Forget password?"}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 9.2,
                                    fontWeight: FontWeight.w600,
                                    color: headingColor.value,
                                    fontFamily: "dmsans",

                                  ),

                                ),
                              ),

                            ],),

                        ],
                      ),
                    ),
                    Column(
                      children: [
                        BottomRectangularBtn(onTapFunc: (){
                          // Get.to(HomeScreen());
                          Get.to(PinScreen());


                        }, btnTitle: "Sign In"),
                        SizedBox(height: 16,),

                        Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text(
                              "${getTranslated(context,"Are you new here?" )??"Are you new here?"} ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: lightTextColor.value,
                                fontFamily: "dmsans",

                              ),

                            ),
                            GestureDetector(
                              onTap: (){
                                Get.to(Signupscreen());
                              },
                              child: Text(
                                "${getTranslated(context,"Sign Up" )??"Sign Up"}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: greenColor.value,
                                  fontFamily: "dmsans",

                                ),

                              ),
                            ),
                          ],),
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
