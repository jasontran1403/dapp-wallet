import 'package:crypto_wallet/UI/Screens/createAccount/importSecretPhrase.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/appController.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../../common_widgets/inputField.dart';


class ImportPrivateKey extends StatefulWidget {
  ImportPrivateKey({super.key});

  @override
  State<ImportPrivateKey> createState() => _ImportPrivateKeyState();
}

class _ImportPrivateKeyState extends State<ImportPrivateKey> {
  final appController = Get.find<AppController>();
  TextEditingController nameController=TextEditingController();
  TextEditingController privateKeyController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primaryBackgroundColor.value,
        body:SafeArea(
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
                                "${getTranslated(context,"Import Private Key" )??"Import Private Key"}",
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
                              child: Icon(Icons.clear,size: 18,color:appController.isDark.value==true?Color(0xffA2BBFF): headingColor.value,),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 24,),

                      Container(
                        height: 114,
                        width: 128,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: inputFieldBackgroundColor2.value
                        ),
                        child: Center(child: SvgPicture.asset("assets/svgs/charm_cross33.svg",height: 60,color: headingColor.value,)),
                      ),
                      SizedBox(height: 24,),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38.0),
                        child: Text(
                          "${getTranslated(context,"Import Private Key" )??"Import Private Key"}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: headingColor.value,
                            fontFamily: "dmsans",

                          ),

                        ),
                      ),
                      SizedBox(height: 32,),
                      Container(
                        // height: 56,
                        width: Get.width,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: inputFieldBackgroundColor2.value,
                          border: Border.all(width: 1,color: headingColor.value)
                        ),
                        child:
                        Row
                          (
                          children: [
                            Container(
                              height: 36,
                              width: 36,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: inputFieldBackgroundColor.value
                              ),
                              child: SvgPicture.asset("assets/svgs/mdi_currency-btc.svg",color:appController.isDark.value?Color(0xffA2BBFF): headingColor.value,),
                            ),
                            SizedBox(width: 12,),
                            Expanded(
                              child: Text(
                                "Solana",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: headingColor.value,
                                  fontFamily: "dmsans",

                                ),

                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down,size: 22,color: headingColor.value,)

                          ],
                        ),

                      ),
                      SizedBox(height: 16,),
                      InputFields2(
                        textController: nameController,
                        onChange: (v){
                          setState(() {

                          });
                        },
                      hintText: "Name",),
                      SizedBox(height: 16,),
                      InputFields2(
                        textController: privateKeyController,
                        onChange: (v){
                          setState(() {

                          });
                        },
                      hintText: "Private key",),




                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 16,),
                      BottomRectangularBtn(
                        buttonTextColor: nameController.text.trim()==""&&appController.isDark.value==true|| privateKeyController.text.trim()==""&&appController.isDark.value==true?
                        Color(0xff6C7CA7)
                            :Color(0xffFFFFFF),
                          color:
                          nameController.text.trim()==""|| privateKeyController.text.trim()==""&&appController.isDark.value==true?

                          inputFieldBackgroundColor2.value:primaryColor.value,
                          isDisabled:nameController.text.trim()==""|| privateKeyController.text.trim()==""?true:false,


                          onTapFunc: (){

                     Get.back();
                      }, btnTitle: "Import"),
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
