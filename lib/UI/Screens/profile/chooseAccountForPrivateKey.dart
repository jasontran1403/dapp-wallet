import 'package:crypto_wallet/UI/Screens/profile/privateKey.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/appController.dart';
import '../../common_widgets/bottomRectangularbtn.dart';


class ChooseAccountForPrivateKey extends StatefulWidget {
  ChooseAccountForPrivateKey({super.key});

  @override
  State<ChooseAccountForPrivateKey> createState() => _ChooseAccountForPrivateKeyState();
}

class _ChooseAccountForPrivateKeyState extends State<ChooseAccountForPrivateKey> {
  List coins=[

    {
      "image":"assets/images/bnb.png",
      "symbol":"BNB",
      "price1":"\$1,571.45",
      "price2":"\$1,571.45",
      "percentage":"8.75%",
      "chain":""
    },
    {
      "image":"assets/images/eft.png",
      "symbol":"EFT",
      "price1":"\$1,571.45",
      "price2":"\$1,571.45",
      "percentage":"8.75%",
      "chain":""
    },

  ];
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
                      "${getTranslated(context,"Choose Account" )??"Choose Account"}",
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
                          '${getTranslated(context,"Do not share your private key" )??"Do not share your private key"}',
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
                          'if someone has access to your private key they will have full control of your wallet.',
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
                      'Account Name',
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
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                  
                    itemCount: 3,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 12,);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return  GestureDetector(
                        onTap: (){
                           Get.to(PrivateKey(privateKey: "Private Key"));
                        },
                        child: Container(
                          height:70,
                          width: Get.width,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: inputFieldBackgroundColor2.value,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                          ),
                          child: Row(
                            children: [
                              Container(
                                  height:40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle
                                  ),
                                  child: Image.asset("${coins[index]['image']}",height: 40,width: 40,)),
                  
                              SizedBox(width: 12,),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                  
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                  
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${coins[index]['symbol']}",
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w600,
                                                        color: primaryColor.value,
                                                        fontFamily: "dmsans",
                  
                                                      ),
                  
                                                    ),
                                                    Text(
                                                      "0x00...001dsax",
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w400,
                                                        color: lightTextColor.value,
                                                        fontFamily: "dmsans",
                  
                                                      ),
                  
                                                    ),
                                                  ],
                                                ),
                  
                  
                  
                                              ],
                                            ),
                                          ),
                  
                                        ],
                                      ),
                                    )
                  
                                  ],
                                ),
                              ),

                  
                            ],
                          ),
                        ),
                      );
                    },
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
