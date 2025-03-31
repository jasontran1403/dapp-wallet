import 'package:crypto_wallet/UI/Screens/notifications/notifications.dart';
import 'package:crypto_wallet/UI/Screens/twoFa/twoFaScreen.dart';
import 'package:crypto_wallet/UI/common_widgets/inputField.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
class AccountName extends StatefulWidget {
  const AccountName({super.key});

  @override
  State<AccountName> createState() => _AccountNameState();
}

class _AccountNameState extends State<AccountName> {var isNotifications=true.obs;

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
                      "${getTranslated(context,"Account Name" )??"Account Name"}",
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
                          color: inputFieldBackgroundColor2.value,
                          shape: BoxShape.circle
                      ),
                      child:       Center(
                        child: Text(
                          "E",
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
                InputFieldsWithSeparateIcon(
                  suffixIcon: Icon(Icons.clear,color: headingColor.value,size: 16,),
                    svg: "Wallet2",
                    headerText: "", hintText: "", hasHeader: false, onChange: (){

                })


               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
