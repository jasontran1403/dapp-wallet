import 'package:crypto_wallet/UI/Screens/createAccount/importSecretPhrase.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/appController.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../../common_widgets/inputField.dart';


class ConnectWallet extends StatefulWidget {
  ConnectWallet({super.key});

  @override
  State<ConnectWallet> createState() => _ConnectWalletState();
}

class _ConnectWalletState extends State<ConnectWallet> {
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
                              "${getTranslated(context,"Connect Ledger" )??"Connect Ledger"}",
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

                   Container(
                     height: 114,
                     width: 128,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(16),
                       color: inputFieldBackgroundColor2.value
                     ),
                     child: Center(child: SvgPicture.asset("assets/svgs/bitcoin-icons_node-hardware-outline222.svg",color: headingColor.value,)),
                   ),
                    SizedBox(height: 24,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38.0),
                      child: Text(
                        "${getTranslated(context,"Connect your Ledger hardware wallet" )??"Connect your Ledger hardware wallet"}",
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
                    Row(
                      children: [
                        Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: inputFieldBackgroundColor2.value,
                              border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                          ),
                          child:Center(
                            child: Text(
                              "1",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: headingColor.value,
                                fontFamily: "dmsans",

                              ),

                            ),
                          ),
                        ),
                        SizedBox(width: 8,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${getTranslated(context,"Enable Bluetooth" )??"Enable Bluetooth"}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: headingColor.value,
                                  fontFamily: "dmsans",
                          
                                ),
                          
                              ),
                              Text(
                                "${getTranslated(context,"Allow permission to use Bluetooth to connect" )??"Allow permission to use Bluetooth to connect"}",
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
                        )

                      ],
                    ),
                    SizedBox(height: 24,),
                    Row(
                      children: [
                        Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: inputFieldBackgroundColor2.value,
                              border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                          ),
                          child:Center(
                            child: Text(
                              "2",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: headingColor.value,
                                fontFamily: "dmsans",

                              ),

                            ),
                          ),
                        ),
                        SizedBox(width: 8,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${getTranslated(context,"Pair with your Ledger device" )??"Pair with your Ledger device"}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: headingColor.value,
                                  fontFamily: "dmsans",

                                ),

                              ),
                              Text(
                                "${getTranslated(context,"Keep your device nearby to get the best signal" )??"Keep your device nearby to get the best signal"}",
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
                        )

                      ],
                    ),
                    SizedBox(height: 24,),
                    Row(
                      children: [
                        Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: inputFieldBackgroundColor2.value,
                              border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                          ),
                          child:Center(
                            child: Text(
                              "3",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: headingColor.value,
                                fontFamily: "dmsans",

                              ),

                            ),
                          ),
                        ),
                        SizedBox(width: 8,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${getTranslated(context,"Connect accounts" )??"Connect accounts"}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: headingColor.value,
                                  fontFamily: "dmsans",

                                ),

                              ),
                              Text(
                                "${getTranslated(context,"We’ll look for activity in any accounts you might have used" )??"We’ll look for activity in any accounts you might have used"}",
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
                        )

                      ],
                    ),




                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 16,),
                    BottomRectangularBtn(onTapFunc: (){

                      Get.back();
                    }, btnTitle: "Create your Ledger device"),
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
