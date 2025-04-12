import 'package:crypto_wallet/UI/Screens/resetPassword/resetPassword.dart';
import 'package:crypto_wallet/UI/Screens/securityAndPrivacy/resetAndWipeData.dart';
import 'package:crypto_wallet/UI/Screens/twoFa/verifyTwoFaScreen.dart';
import 'package:crypto_wallet/UI/Screens/verifySuccess/verifySuccess.dart';
import 'package:crypto_wallet/UI/common_widgets/inputField.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../common_widgets/bottomRectangularbtn.dart';
class SecurityAndPrivacy extends StatefulWidget {
  String? fromPage;
  SecurityAndPrivacy({super.key,this.fromPage});

  @override
  State<SecurityAndPrivacy> createState() => _SecurityAndPrivacyState();
}

class _SecurityAndPrivacyState extends State<SecurityAndPrivacy> {
  var faceId=false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        backgroundColor: primaryBackgroundColor.value,
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                "assets/background/bg7.png",
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 22,vertical: 20),
                children: [
                  Row(
                    children: [
                      GestureDetector(

                          onTap:(){
                            Get.back();

                          },
                          child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 18,)),
                      SizedBox(width: 8,),
                      Text(
                        "${getTranslated(context,"Security & Privacy" )??"Security & Privacy"}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: "dmsans",

                        ),

                      ),
                    ],
                  ),
                  SizedBox(height: 32,),
                  Container(
                    // height: 80,
                      width: Get.width,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                      ),
                      child:
                      Column(
                        children: [
                          Row
                            (
                            children: [

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${getTranslated(context,"Face ID" )??"Face ID"}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontFamily: "dmsans",

                                      ),

                                    ),



                                  ],
                                ),
                              ),

                              SizedBox(width: 12,),
                              FlutterSwitch(
                                activeColor: Colors.grey.shade800.withOpacity(0.7),
                                inactiveColor: headingColor.value,
                                width: 50.0,
                                height: 20.0,
                                valueFontSize: 10.0,
                                toggleSize: 18.0,
                                value: faceId.value, // Mặc định false
                                borderRadius: 16.0,
                                padding: 2.0,
                                showOnOff: true,
                                onToggle: (val) {
                                  if (val) { // Nếu bật lên
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("This feature is currently unavailable, please try again later."),
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.only(top: 50, left: 0, right: 0),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }

                                  setState(() {
                                    faceId.value = false; // Luôn đặt lại về false
                                  });
                                },
                              ),
                            ],
                          ),


                        ],
                      )
                  ),
                  SizedBox(height: 16,),
                  // InkWell(
                  //   onTap: (){
                  //     Get.to(RecetAndPrivateData());
                  //   },
                  //   child: Container(
                  //     // height: 80,
                  //       width: Get.width,
                  //       padding: EdgeInsets.all(16),
                  //       decoration: BoxDecoration(
                  //           color: inputFieldBackgroundColor2.value,
                  //           borderRadius: BorderRadius.circular(16),
                  //           border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                  //       ),
                  //       child:
                  //       Column(
                  //         children: [
                  //           Row
                  //             (
                  //             children: [
                  //
                  //               Expanded(
                  //                 child: Column(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(
                  //                       "${getTranslated(context,"Reset App" )??"Reset App"}",
                  //                       textAlign: TextAlign.start,
                  //                       style: TextStyle(
                  //                         fontSize: 14,
                  //                         fontWeight: FontWeight.w400,
                  //                         color: redColor.value,
                  //                         fontFamily: "dmsans",
                  //
                  //                       ),
                  //
                  //                     ),
                  //
                  //
                  //
                  //                   ],
                  //                 ),
                  //               ),
                  //
                  //               SizedBox(width: 12,),
                  //              Icon(Icons.arrow_forward_ios,size: 17,color: headingColor.value,)                             ],
                  //           ),
                  //
                  //
                  //         ],
                  //       )
                  //   ),
                  // ),

                  SizedBox(height: 32,),
















                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
