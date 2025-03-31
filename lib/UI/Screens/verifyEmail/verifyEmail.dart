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
class Verifyemail extends StatefulWidget {
  String? fromPage;
   Verifyemail({super.key,this.fromPage});

  @override
  State<Verifyemail> createState() => _VerifyemailState();
}

class _VerifyemailState extends State<Verifyemail> {
  AppController appController=Get.find<AppController>();

  final defaultPinTheme = PinTheme(
    width:Get.width*0.12,
    height: 45,

    textStyle: TextStyle(fontSize: 24, color: headingColor.value, fontWeight: FontWeight.w700),
    decoration: BoxDecoration(
      // color: inputFieldBackgroundColor.value,
      border: Border(
        bottom: BorderSide(width: 3, color:Color(0xff76CF56),style:BorderStyle.solid ),
      ),
      // borderRadius: BorderRadius.circula/r(10),
    ),
  );
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border(
        bottom: BorderSide(width: 3, color:Color(0xff76CF56),style:BorderStyle.solid ),
      ),      // borderRadius: BorderRadius.circular(8),
    );
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        // color: Color.fromRGBO(234, 239, 243, 1),
        border: Border(
          bottom: BorderSide(width: 3, color:Color(0xff76CF56),style:BorderStyle.solid ),
        ),
      ),
    );
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
                                "${getTranslated(context,"Verify Email Address" )??"Verify Email Address"}",
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
                            "${getTranslated(context,"We just sent an OTP to your registered email address" )??"We just sent an OTP to your registered email address"}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: lightTextColor.value,
                              fontFamily: "dmsans",

                            ),

                          ),

                          SizedBox(height: 90,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Pinput(
                                // controller: pinController,
                                length: 6,
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme: focusedPinTheme,
                                submittedPinTheme: submittedPinTheme,
                                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                                showCursor: true,
                                onChanged: (val) => {},
                                onCompleted: (pin) => (){


                                },
                              )
                            ],
                          ),
                          SizedBox(height: 12,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "00:34",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color:appController.isDark.value==true?Color(0xffFDFCFD): Color(0xffAFB6D3),
                                  fontFamily: "dmsans",

                                ),

                              ),
                            ],
                          ),




                        ],
                      ),
                    ),
                    Column(
                      children: [
                        BottomRectangularBtn(onTapFunc: (){

                          print("-----------${widget.fromPage}");
                          if(widget.fromPage=="forgot"){
                            Get.to(ResetPassword());
                          }else{
                            Get.to(VerifySuccess());
                          }


                        }, btnTitle: "Verify Email"),
                        SizedBox(height: 16,),

                        Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text(
                              "${getTranslated(context,"Didn’t received the code?" )??"Didn’t received the code?"} ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: lightTextColor.value,
                                fontFamily: "dmsans",

                              ),

                            ),
                            GestureDetector(
                              onTap: (){
                                // Get.to(Signupscreen());
                              },
                              child: Text(
                                "${getTranslated(context,"Resend" )??"Resend"}",
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
