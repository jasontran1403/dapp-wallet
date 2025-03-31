import 'package:crypto_wallet/UI/Screens/resetPassword/resetPassword.dart';
import 'package:crypto_wallet/UI/Screens/twoFa/verifyTwoFaScreen.dart';
import 'package:crypto_wallet/UI/Screens/verifySuccess/verifySuccess.dart';
import 'package:crypto_wallet/UI/common_widgets/inputField.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../common_widgets/bottomRectangularbtn.dart';
class RecetAndPrivateData extends StatefulWidget {
  String? fromPage;
  RecetAndPrivateData({super.key,this.fromPage});

  @override
  State<RecetAndPrivateData> createState() => _RecetAndPrivateDataState();
}

class _RecetAndPrivateDataState extends State<RecetAndPrivateData> {
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22,vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Column(
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
                      "${getTranslated(context,"Security & Privacy" )??"Security & Privacy"}",
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
              ],
            ),



          Column(
            children: [
              Container(

                height: 120,
                width: 120,
                decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: redColor.value.withOpacity(0.20)

                ),
                child: Center(child: SvgPicture.asset("assets/svgs/fluent_key-reset-24-regular.svg")),
              ),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
          "${getTranslated(context,"Reset & Wipe Data" )??"Reset & Wipe Data"}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: headingColor.value,
            fontFamily: "dmsans",

          ),

                ),
              ),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
          "${getTranslated(context,"This will remove all existing accounts & data. Make sure you have your secret phrase & private keys backed up." )??"This will remove all existing accounts & data. Make sure you have your secret phrase & private keys backed up."}",
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
            ],
          ),




             Column(
               children: [
                 SizedBox(height: 24,),

                 Row(
                   children: [


                     Expanded(
                       child: GestureDetector(
                         onTap: (){
                           Get.back();
                           // Get.to(VerifyTwoFaScreen());
                         },
                         child: Container(
                           height:
                           50,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(100),
                               color: redColor.value
                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [

                               Text(
                                 "${getTranslated(context,"Continue" )??"Continue"}",
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
             )










            ],
          ),
        ),
      ),
    );
  }
}
