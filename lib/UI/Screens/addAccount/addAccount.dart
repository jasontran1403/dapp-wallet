import 'package:crypto_wallet/UI/Screens/createAccount/createAccount.dart';
import 'package:crypto_wallet/UI/Screens/createAccount/importPrivateKey.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/appController.dart';
import '../createAccount/importSecretPhrase.dart';


class AddAccount extends StatefulWidget {
  AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor.value,
      body: Obx(
            () => SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0,vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Text(
                          "${getTranslated(context,"Add/Connect Wallet" )??"Add/Connect Wallet"}",
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
                    GestureDetector(

                      onTap:(){
                        Get.back();

                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: inputFieldBackgroundColor.value,
                            border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                        ),
                        child: Icon(Icons.clear,size: 18,color:appController.isDark.value==true? Color(0xffA2BBFF): headingColor.value,),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24,),
                InkWell(
                  onTap: (){
                    Get.to(CreateAccount());
                  },
                  child: Container(
                    // height: 80,
                    width: Get.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color:inputFieldBackgroundColor2.value,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                    ),
                    child:
                    Row
                      (
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color:appController.isDark.value==true? Color(0xff1A2B56):  inputFieldBackgroundColor.value,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child:  Center(
                            child:Icon(Icons.add,color: appController.isDark.value==true? Color(0xffA2BBFF):headingColor.value,size: 16,),
                          ),
                        ),
                        SizedBox(width: 12,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${getTranslated(context,"Create New Account" )??"Create New Account"}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: headingColor.value,
                                  fontFamily: "dmsans",

                                ),

                              ),
                              Text(
                                "${getTranslated(context,"Add a new multi-chain account" )??"Add a new multi-chain account"}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: lightTextColor.value,
                                  fontFamily: "dmsans",

                                ),

                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 12,),
                        Icon(Icons.arrow_forward_ios,color: headingColor.value,size: 18,)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                InkWell(
                  onTap: (){
                    Get.to(ImportSecretPhrase());
                  },
                  child: Container(
                    // height: 80,
                    width: Get.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: inputFieldBackgroundColor2.value,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                    ),
                    child:
                    Row
                      (
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color:appController.isDark.value==true? Color(0xff1A2B56):inputFieldBackgroundColor.value,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child:  Center(
                            child:SvgPicture.asset("assets/svgs/charm_cross.svg",color:appController.isDark.value==true? Color(0xffA2BBFF): headingColor.value,),
                          ),
                        ),
                        SizedBox(width: 12,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${getTranslated(context,"Import Secret Recovery Phrase" )??"Import Secret Recovery Phrase"}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: headingColor.value,
                                  fontFamily: "dmsans",

                                ),

                              ),
                              Text(
                                "${getTranslated(context,"Import accounts from another wallet" )??"Import accounts from another wallet"}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: lightTextColor.value,
                                  fontFamily: "dmsans",

                                ),

                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 12,),
                        Icon(Icons.arrow_forward_ios,color: headingColor.value,size: 18,)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                GestureDetector(
                  onTap: (){
                    Get.to(ImportPrivateKey());
                  },
                  child: Container(
                    // height: 80,
                    width: Get.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: inputFieldBackgroundColor2.value,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                    ),
                    child:
                    Row
                      (
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color:appController.isDark.value==true? Color(0xff1A2B56):  inputFieldBackgroundColor.value,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child:  Center(
                            child:SvgPicture.asset("assets/svgs/charm_cross33.svg",color:appController.isDark.value==true? Color(0xffA2BBFF): headingColor.value,),
                          ),
                        ),
                        SizedBox(width: 12,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${getTranslated(context,"Import Private Key" )??"Import Private Key"}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: headingColor.value,
                                  fontFamily: "dmsans",

                                ),

                              ),
                              Text(
                                "${getTranslated(context,"Import a single-chain account" )??"Import a single-chain account"}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: lightTextColor.value,
                                  fontFamily: "dmsans",

                                ),

                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 12,),
                        Icon(Icons.arrow_forward_ios,color: headingColor.value,size: 18,)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16,),




              ],
            ),
          ),
        ),
      ),
    );
  }
}
