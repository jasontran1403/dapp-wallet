import 'package:crypto_wallet/UI/Screens/notifications/notifications.dart';
import 'package:crypto_wallet/UI/Screens/profile/accountAddresses.dart';
import 'package:crypto_wallet/UI/Screens/profile/accountName.dart';
import 'package:crypto_wallet/UI/Screens/profile/secretRecoveryPhrase.dart';
import 'package:crypto_wallet/UI/Screens/profile/showPrivateKey.dart';
import 'package:crypto_wallet/UI/Screens/twoFa/twoFaScreen.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
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
      ()=> Scaffold(
        backgroundColor: primaryBackgroundColor.value,
        body: SafeArea(
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
                        child: Icon(Icons.arrow_back_ios,color: headingColor.value,size: 18,)),
                    SizedBox(width: 8,),
                    Text(
                      "${getTranslated(context,"Advance" )??"Advance"}",
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
                SizedBox(height: 24,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        color:appController.isDark.value==true? Color(0xff1A2B56):inputFieldBackgroundColor2.value,
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
                  child: ListView(
                    children: [
      
      

      
                      SizedBox(height: 20,),

      
                      SizedBox(height: 20,),
                      Container(
                        // height: 80,
                          width: Get.width,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: inputFieldBackgroundColor2.value,
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
                                            "${getTranslated(context,"Show Secret Recovery Phrase" )??"Show Secret Recovery Phrase"}",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: headingColor.value,
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
                                            "${getTranslated(context,"Show Private Key" )??"Show Private Key"}",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: headingColor.value,
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
                      ),
      
                      SizedBox(height: 20,),
      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
