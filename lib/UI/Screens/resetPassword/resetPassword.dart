import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../../common_widgets/inputField.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  AppController appController=Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return  Obx(
        ()=> Scaffold(
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
                              // GestureDetector(
                              //
                              //     onTap:(){
                              //       Get.back();
                              //
                              //     },
                              //     child: Icon(Icons.arrow_back_ios,color: darkBlueColor.value,)),
                              // SizedBox(width: 8,),
                              Text(
                                "${getTranslated(context,"Password Reset" )??"Password Reset"}",
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
                            "${getTranslated(context,"Reset your password securely in just a few simple steps." )??"Reset your password securely in just a few simple steps."}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: lightTextColor.value,
                              fontFamily: "dmsans",

                            ),

                          ),

                          SizedBox(height: 40,),
                          SizedBox(height: 20,),
                          InputFieldPassword(

                              headerText: "New Password",hintText: "Enter your password...", textController: TextEditingController(), onChange: (){}),
                          SizedBox(height: 20,),
                          InputFieldPassword(

                              headerText: "Confirm New Password",hintText: "Enter your password...", textController: TextEditingController(), onChange: (){}),




                        ],
                      ),
                    ),
                    Column(
                      children: [
                        BottomRectangularBtn(onTapFunc: (){
                          Get.back();
                          Get.back();
                          Get.back();



                        }, btnTitle: "Save Password"),
                        SizedBox(height: 8,),

                        BottomRectangularBtn(
                          onlyBorder: true,
                            color: Colors.transparent,
                            onTapFunc: (){
                          Get.back();
                          Get.back();


                        }, btnTitle: "Cancel"),
                        SizedBox(height: 16,),


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
