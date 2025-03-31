import 'package:crypto_wallet/UI/Screens/createAccount/connectWallet.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/appController.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../../common_widgets/inputField.dart';


class CreateAccount extends StatefulWidget {
  CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Text(
                              "${getTranslated(context,"Create Account" )??"Create Account"}",
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
                                color: inputFieldBackgroundColor2.value,
                                border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                            ),
                            child: Icon(Icons.clear,size: 18,color:appController.isDark.value==true?Color(0xffA2BBFF):  headingColor.value,),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 24,),

                    InputFieldsWithSeparateIcon(

                        suffixIcon: Icon(Icons.clear,color: headingColor.value,size: 16,),
                        svg: "Wallet2",
                        headerText: "", hintText: "Enter account name", hasHeader: false, onChange: (){

                    }),






                  ],
                ),
               Column(
                 children: [
                   SizedBox(height: 16,),
                   BottomRectangularBtn(onTapFunc: (){
                     Get.back();
                   }, btnTitle: "Create"),
                   SizedBox(height: 16,),
                 ],
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
