import 'package:crypto_wallet/UI/Screens/profile/showSecretRecoveryPhrase.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/appController.dart';
import '../../common_widgets/bottomRectangularbtn.dart';


class SecretRecoveryPharase extends StatefulWidget {
  SecretRecoveryPharase({super.key});

  @override
  State<SecretRecoveryPharase> createState() => _SecretRecoveryPharaseState();
}

class _SecretRecoveryPharaseState extends State<SecretRecoveryPharase> {
  final appController = Get.find<AppController>();
 var isCheckBox= false.obs;
  var ch = ''.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor.value,
      body: Obx(
            () => SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0,vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(

                            onTap:(){
                              Get.back();

                            },
                            child: Icon(Icons.arrow_back_ios,color: headingColor.value,size: 18,)),
                        SizedBox(width: 8,),
                        Text(
                          "${getTranslated(context,"Edit Account" )??"Edit Account"}",
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
                    SizedBox(height: 50,),

                    Container(
                      width: 120,
                      height: 120,
                      padding: EdgeInsets.all(30),
                      decoration: ShapeDecoration(
                        color: Color(0x33FF5C5C),
                        shape: OvalBorder(),
                      ),
                      child: Image.asset("assets/images/mingcute_warning-line.png"),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${getTranslated(context,"Show Secret Phrase" )??"Show Secret Phrase"}',
                          style: TextStyle(
                            color: headingColor.value,
                            fontSize: 20,
                            fontFamily: 'dmsans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 66,
                      padding: EdgeInsets.all(12),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Color(0x19FF5C5C),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 16,
                                        height: 16,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(),
                                        child: SvgPicture.asset("assets/svgs/fluent-mdl2_key-phrase-extraction.svg"),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            '${getTranslated(context,"Your secret phrase is the only way to recover your wallet" )??"Your secret phrase is the only way to recover your wallet"}',
                                            style: TextStyle(
                                              color: headingColor.value,
                                              fontSize: 14,
                                              fontFamily: 'dmsans',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 66,
                      padding: EdgeInsets.all(12),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Color(0x19FF5C5C),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 16,
                                        height: 16,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(),
                                        child: SvgPicture.asset("assets/svgs/mdi_eye-lock.svg"),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            '${getTranslated(context,"Do not let anyone see your secret phrase" )??"Do not let anyone see your secret phrase"}',
                                            style: TextStyle(
                                              color: headingColor.value,
                                              fontSize: 14,
                                              fontFamily: 'dmsans',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 66,
                      padding: EdgeInsets.all(12),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Color(0x19FF5C5C),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 16,
                                        height: 16,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(),
                                        child: SvgPicture.asset("assets/svgs/Frame 34209.svg"),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            '${getTranslated(context,"Never share your secret phrase with anyone" )??"Never share your secret phrase with anyone"}',
                                            style: TextStyle(
                                              color: headingColor.value,
                                              fontSize: 14,
                                              fontFamily: 'dmsans',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),



                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 16),
                    Row(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,

                          child: Theme(
                            data: ThemeData(

                                checkboxTheme: CheckboxThemeData(
                                  side: BorderSide(width: 2,color: lightTextColor.value),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
                                  ),

                                )
                            ),
                            child: Checkbox(
                                activeColor: primaryColor.value,
                                value: isCheckBox.value, onChanged: (val){
                              isCheckBox.value=val!;

                            }),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Text(
                            '${getTranslated(context,"I will not share my secret phrase with anyone." )??"I will not share my secret phrase with anyone."}',
                            style: TextStyle(
                              color: lightTextColor.value,
                              fontSize: 14,
                              fontFamily: 'dmsans',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    BottomRectangularBtn(
                      color: isCheckBox.value==true?primaryColor.value:inputFieldBackgroundColor2.value,
                      isDisabled: isCheckBox==false?true:false,
                        onTapFunc: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowSecretRecoveryPhrase()));

                        },
                        btnTitle: "Continue"),
                    SizedBox(height: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
