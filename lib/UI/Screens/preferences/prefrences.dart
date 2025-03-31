import 'package:crypto_wallet/UI/Screens/addAccount/addAccount.dart';
import 'package:crypto_wallet/UI/Screens/addressBookScreens/addAdress.dart';
import 'package:crypto_wallet/UI/Screens/addressBookScreens/updateAddress.dart';
import 'package:crypto_wallet/UI/Screens/preferences/appLanguage.dart';
import 'package:crypto_wallet/UI/Screens/preferences/chooseCurrency.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/appController.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../createAccount/connectWallet.dart';


class PrefrencesScreen extends StatefulWidget {
  PrefrencesScreen({super.key});

  @override
  State<PrefrencesScreen> createState() => _PrefrencesScreenState();
}

class _PrefrencesScreenState extends State<PrefrencesScreen> {
  final appController = Get.find<AppController>();
   var _theme = false.obs;
   @override
  void initState() {
     _theme.value=appController.isDark.value;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        backgroundColor: primaryBackgroundColor.value,
        body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.0,vertical: 20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            "${getTranslated(context,"Preferences" )??"Preferences"}",
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

                    ],
                  ),
                  SizedBox(height: 24,),
                  InkWell(
                    onTap: (){
                      Get.to(Applanguage());
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
                        Column(
                          children: [
                            Row
                              (
                              children: [

                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${getTranslated(context,"App Language" )??"App Language"}",
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
                              Row(
                                children: [
                                  Text(
                                    "English",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: lightTextColor.value,
                                      fontFamily: "dmsans",

                                    ),

                                  ),
                                  SizedBox(width: 7,),
                                  Icon(Icons.arrow_forward_ios,color: headingColor.value,size: 16,)

                                ],
                              )                           ],
                            ),


                          ],
                        )
                    ),
                  ),
                  SizedBox(height: 16,),
                  InkWell(
                    onTap: (){
                      Get.to(ChooseCurrency());
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
                        Column(
                          children: [
                            Row
                              (
                              children: [

                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${getTranslated(context,"Currency" )??"Currency"}",
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
                                Row(
                                  children: [
                                    Text(
                                      "USD",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: lightTextColor.value,
                                        fontFamily: "dmsans",

                                      ),

                                    ),
                                    SizedBox(width: 7,),
                                    Icon(Icons.arrow_forward_ios,color: headingColor.value,size: 16,)

                                  ],
                                )                           ],
                            ),


                          ],
                        )
                    ),
                  ),
                  SizedBox(height: 16,),
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
                          Row
                            (
                            children: [

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${getTranslated(context,"Theme" )??"Theme"}",
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
                              // Row(
                              //   children: [
                              //     Text(
                              //       "Lite",
                              //       textAlign: TextAlign.start,
                              //       style: TextStyle(
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.w400,
                              //         color: lightTextColor.value,
                              //         fontFamily: "dmsans",
                              //
                              //       ),
                              //
                              //     ),
                              //     SizedBox(width: 7,),
                              //     Icon(Icons.arrow_forward_ios,color: headingColor.value,size: 16,)
                              //
                              //   ],
                              // )   ,
                              FlutterSwitch(
                                activeText: "",
                                inactiveText: "",
                                activeColor: primaryColor.value,
                                width: 45.0,
                                height: 23.0,
                                valueFontSize: 10.0,
                                toggleSize: 19.0,
                                value: _theme.value,
                                borderRadius: 30.0,
                                padding: 2.0,
                                showOnOff: true,
                                onToggle: (val) async {
                                  _theme.value = val;
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  appController.isDark.value = _theme.value;
                                  await prefs.setBool('isDarkMode', _theme.value);
                                  appController.changeTheme();
                                },
                              )],
                          ),


                        ],
                      )
                  ),
                  SizedBox(height: 16,)






                ],
              ),
            ),
          ),

      ),
    );
  }
}
