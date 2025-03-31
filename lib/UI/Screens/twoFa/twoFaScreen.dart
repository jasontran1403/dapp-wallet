import 'package:crypto_wallet/UI/Screens/resetPassword/resetPassword.dart';
import 'package:crypto_wallet/UI/Screens/twoFa/verifyTwoFaScreen.dart';
import 'package:crypto_wallet/UI/Screens/verifySuccess/verifySuccess.dart';
import 'package:crypto_wallet/UI/common_widgets/inputField.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../common_widgets/bottomRectangularbtn.dart';
class TwoFaScreen extends StatefulWidget {
  String? fromPage;
  TwoFaScreen({super.key,this.fromPage});

  @override
  State<TwoFaScreen> createState() => _TwoFaScreenState();
}

class _TwoFaScreenState extends State<TwoFaScreen> {
  AppController appController = Get.find<AppController>();

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
                  "${getTranslated(context,"2 Factor Authentication" )??"2 Factor Authentication"}",
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
                  child: Image.asset("assets/images/Mask group.png",color:appController.isDark.value==true?Color(0xffA2BBFF): primaryColor.value,),
                ),
              ],
            ),
            SizedBox(height: 32,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                "${getTranslated(context,"For more security, enable on authenticator app" )??"For more security, enable on authenticator app"}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: lightTextColor.value,
                  fontFamily: "dmsans",

                ),

              ),
            ),
            SizedBox(height: 24,),

            Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 1,),
            SizedBox(height: 24,),
            Divider(height: 1,color: inputFieldBackgroundColor2.value,),
            SizedBox(height: 16,),
            Row(
              children: [
                Text(
                  "${getTranslated(context,"Security Key" )??"Security Key"}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: headingColor.value,
                    fontFamily: "dmsans",

                  ),

                ),
              ],
            ),
            SizedBox(height: 8,),
            InputFields(
              hintText: "",
            ),

            SizedBox(height: 24,),

            Row(
              children: [


                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Get.to(VerifyTwoFaScreen());
                    },
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

                          Text(
                            "${getTranslated(context,"Enable Now" )??"Enable Now"}",
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
                  ),
                )
              ],
            ),
            SizedBox(height: 12,),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Get.back();
                    },
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


                          Text(
                            "${getTranslated(context,"Cancel" )??"Cancel"}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: primaryColor.value,
                              fontFamily: "dmsans",

                            ),

                          ),
                        ],
                      ),
                    ),
                  ),
                ),


              ],
            ),











          ],
        ),
      ),
    );
  }
}
