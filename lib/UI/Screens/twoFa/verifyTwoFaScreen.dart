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
class VerifyTwoFaScreen extends StatefulWidget {
  String? fromPage;
  VerifyTwoFaScreen({super.key,this.fromPage});

  @override
  State<VerifyTwoFaScreen> createState() => _VerifyTwoFaScreenState();
}

class _VerifyTwoFaScreenState extends State<VerifyTwoFaScreen> {
  AppController appController = Get.find<AppController>();

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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body:  SafeArea(
          child: Stack(
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
                padding: EdgeInsets.symmetric(horizontal: 22,vertical: 20),
                decoration: BoxDecoration(
          
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListView(
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
                                "${getTranslated(context,"Verification Code" )??"Verification Code"}",
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
          
          
                          SizedBox(height: 12,),
                          Text(
                            "${getTranslated(context,"Enter verification code from your authenticator app here." )??"Enter verification code from your authenticator app here."}",
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
                                  color: headingColor.value,
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
          
                        Get.back();
                        Get.back();
          
          
                        }, btnTitle: "Verify Security Code"),
                        SizedBox(height: 16,),

                        SizedBox(height: 22,)
                      ],
                    )
                  ],
                ),
              ),)
            ],
          ),
        )
    );
  }
}
