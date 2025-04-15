import 'package:crypto_wallet/UI/Screens/profile/secretRecoveryPhrase.dart';
import 'package:crypto_wallet/UI/Screens/profile/showPrivateKey.dart';
import 'package:crypto_wallet/UI/Screens/profile/secretRecoveryPhraseTon.dart';
import 'package:crypto_wallet/UI/Screens/profile/showPrivateKeyRipple.dart';
import 'package:crypto_wallet/UI/Screens/profile/showPrivateKeyBitcoin.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var isNotifications=true.obs;
  AppController appController = Get.find<AppController>();

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
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 22.0,vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap:(){
                              Get.back();
                            },
                            child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 18,)),
                        SizedBox(width: 8,),
                        Text(
                          "${getTranslated(context,"Advance" )??"Advance"}",
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
                    SizedBox(height: 24,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade800.withOpacity(0.7),
                              shape: BoxShape.circle
                          ),
                          child:       Center(
                            child: Text(
                              "",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: headingColor.value,
                                fontFamily: "dmsans",

                              ),

                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24,),


                    Expanded(
                      child:
                      ListView(
                        children: [
                          SizedBox(height: 20,),
                          SizedBox(height: 20,),
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
                                  InkWell(

                                    onTap:(){
                                      Get.to(SecretRecoveryPharase());
                                    },
                                    splashColor: Colors.transparent,
                                    child: Row
                                      (
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${getTranslated(context,"Show Mnemonics Phrase BSC" )??"Show Mnemonics Phrase BSC"}",
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
                                        Icon(Icons.arrow_forward_ios,color: headingColor.value,size: 18,)
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 8,),

                                  Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 1,),
                                  SizedBox(height: 8,),
                                  InkWell(

                                    onTap:(){
                                      Get.to(ShowPrivateKey());
                                    },
                                    splashColor: Colors.transparent,
                                    child: Row
                                      (
                                      children: [

                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${getTranslated(context,"Show Private Key BSC" )??"Show Private Key BSC"}",
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
                                        Icon(Icons.arrow_forward_ios,color: headingColor.value,size: 18,)
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 8,),

                                  Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 1,),
                                  SizedBox(height: 8,),
                                  InkWell(

                                    onTap:(){
                                      Get.to(ShowPrivateKeyBitcoin());
                                    },
                                    splashColor: Colors.transparent,
                                    child: Row
                                      (
                                      children: [

                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${getTranslated(context,"Show Private Key Bitcoin" )??"Show Private Key Bitcoin"}",
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
                                        Icon(Icons.arrow_forward_ios,color: headingColor.value,size: 18,)
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 8,),

                                  Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 1,),
                                  SizedBox(height: 8,),
                                  InkWell(

                                    onTap:(){
                                      Get.to(ShowPrivateKeyRipple());
                                    },
                                    splashColor: Colors.transparent,
                                    child: Row
                                      (
                                      children: [

                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${getTranslated(context,"Show Private Key Ripple" )??"Show Private Key Ripple"}",
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
                                        Icon(Icons.arrow_forward_ios,color: headingColor.value,size: 18,)
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 8,),

                                  Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 1,),
                                  SizedBox(height: 8,),
                                  InkWell(

                                    onTap:(){
                                      Get.to(SecretRecoveryPharaseTon());
                                    },
                                    splashColor: Colors.transparent,
                                    child: Row
                                      (
                                      children: [

                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${getTranslated(context,"Show Mnemonics TON Network" )??"Show Mnemonics TON Network"}",
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
                                        Icon(Icons.arrow_forward_ios,color: headingColor.value,size: 18,)
                                      ],
                                    ),
                                  ),
                                ],
                              )
                              ,
                          ),

                          SizedBox(height: 20,),

                        ],
                      ),

                    ),


                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
