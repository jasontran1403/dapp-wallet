import 'package:crypto_wallet/UI/Screens/loginScreen/loginScreen.dart';
import 'package:crypto_wallet/UI/Screens/verifyEmail/verifyEmail.dart';
import 'package:crypto_wallet/UI/common_widgets/bottomRectangularbtn.dart';
import 'package:crypto_wallet/UI/common_widgets/inputField.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
class Signupscreen extends StatelessWidget {
  const Signupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppController appController=Get.find<AppController>();

    return Obx(
        ()=>Scaffold(
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
                        SizedBox(height: 70,),
                        Row(
                          children: [
                            GestureDetector(

                                onTap:(){
                                  Get.back();

                              },
                                child: Icon(Icons.arrow_back_ios,color: darkBlueColor.value,)),
                            SizedBox(width: 8,),
                            Text(
                              "${getTranslated(context,"Register Account" )??"Register Account"} ",
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

                        SizedBox(height: 16,),
                        Text(
                          "${getTranslated(context,"Create your account to securely manage your cryptocurrencies. Get started!" )??"Create your account to securely manage your cryptocurrencies. Get started!"} ",
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
                        InputFieldPassword(

                            headerText: "Password",hintText: "Enter your password...", textController: TextEditingController(), onChange: (){}),
                        SizedBox(height: 20,),
                        InputFieldPassword(

                            headerText: "Confirm Password",hintText: "Enter your password...", textController: TextEditingController(), onChange: (){}),




                      ],
                    ),
                  ),
                  Column(
                    children: [
                      BottomRectangularBtn(onTapFunc: (){

                        Get.to(Verifyemail());
                      }, btnTitle: "Register"),
                      SizedBox(height: 16,),

                      Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Text(
                            "${getTranslated(context,"Already have an account?" )??"Already have an account?"} ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: lightTextColor.value,
                              fontFamily: "dmsans",

                            ),

                          ),
                          InkWell(
                            onTap: (){
                              Get.to(LoginScreen());

                            },
                            child: Text(
                              "${getTranslated(context,"Sign in" )??"Sign in"}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
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
