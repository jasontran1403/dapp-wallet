import 'package:crypto_wallet/UI/Screens/createAccount/createAccount.dart';
import 'package:crypto_wallet/UI/Screens/createAccount/importPrivateKey.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/appController.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../../common_widgets/inputField.dart';
import '../createAccount/importSecretPhrase.dart';


class AddAdress extends StatefulWidget {
  AddAdress({super.key});

  @override
  State<AddAdress> createState() => _AddAdressState();
}

class _AddAdressState extends State<AddAdress> {
  final appController = Get.find<AppController>();

  TextEditingController nameController=TextEditingController();
  TextEditingController privateKeyController=TextEditingController();
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Text(
                              "${getTranslated(context,"Add Address" )??"Add Address"}",
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
                      child: Center(child: SvgPicture.asset("assets/svgs/mdi_contact-outline (1).svg",height: 60,color: headingColor.value)),
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
                            child: SvgPicture.asset("assets/svgs/mdi_currency-btc.svg",color:appController.isDark.value==true?Color(0xffA2BBFF):  headingColor.value,),
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
                      hintText: "Label",),
                    SizedBox(height: 16,),
                    InputFields2(
                      textController: privateKeyController,
                      onChange: (v){
                        setState(() {

                        });
                      },
                      hintText: "Address",),




                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 16,),
                    BottomRectangularBtn(
                        // color: nameController.text.trim()==""|| privateKeyController.text.trim()==""?inputFieldBackgroundColor2.value:primaryColor.value,
                        // isDisabled:nameController.text.trim()==""|| privateKeyController.text.trim()==""?true:false,
                        //

                        onTapFunc: (){

                          Get.back();
                        }, btnTitle: "Save address"),
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
