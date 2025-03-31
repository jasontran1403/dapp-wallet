import 'package:crypto_wallet/UI/Screens/profile/privateKey.dart';
import 'package:crypto_wallet/UI/Screens/socialLogin/socialLogin.dart';
import 'package:crypto_wallet/UI/common_widgets/inputField.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:crypto_wallet/services/utilServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/appController.dart';
import '../../common_widgets/bottomRectangularbtn.dart';


class ImportSecretPhrase extends StatefulWidget {
  ImportSecretPhrase({super.key});

  @override
  State<ImportSecretPhrase> createState() => _ImportSecretPhraseState();
}

class _ImportSecretPhraseState extends State<ImportSecretPhrase> {
  TextEditingController secretPhraseController=TextEditingController();

  final appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Text(
                              "${getTranslated(context,"Import Secret Phrase" )??"Import Secret Phrase"}",
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
                            Get.to(SocialLogin());
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

                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 48.0),
                            child: Text(
                              '${getTranslated(context,"Secret Recovery Phase" )??"Secret Recovery Phase"}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: headingColor.value,
                                fontSize: 20,
                                fontFamily: 'dmsans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28.0),
                            child: Text(
                              '${getTranslated(context,"Restore an existing wallet with your 12-24-word secret recovery phrase" )??"Restore an existing wallet with your 12-24-word secret recovery phrase"}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: lightTextColor.value,
                                fontSize: 14,
                                fontFamily: 'dmsans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24,),
                    Row(
                      children: [
                        Text(
                          '${getTranslated(context,"Secret Phrase" )??"Secret Phrase"}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: headingColor.value,
                            fontSize: 15,
                            fontFamily: 'dmsans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                   InputFields2(
                     textController: secretPhraseController,
                     onChange: (v){
                       setState(() {

                       });
                     },
                     maxLines: 5,hintText: "${getTranslated(context,"Secret Recovery Phrase" )??"Secret Recovery Phrase"}",),






                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 20,),
                    BottomRectangularBtn(
                        color: secretPhraseController.text.trim()!=""?primaryColor.value:inputFieldBackgroundColor2.value,
                        isDisabled:secretPhraseController.text.trim()==""?true:false,

                        onTapFunc: (){
                          Get.back();


                        }, btnTitle: "Import"),
                    SizedBox(height: 20,),

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
