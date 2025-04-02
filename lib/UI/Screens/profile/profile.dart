import 'package:crypto_wallet/UI/Screens/addressBookScreens/addressBookScreen.dart';
import 'package:crypto_wallet/UI/Screens/manageAccounts/manageAccounts.dart';
import 'package:crypto_wallet/UI/Screens/notifications/notifications.dart';
import 'package:crypto_wallet/UI/Screens/preferences/prefrences.dart';
import 'package:crypto_wallet/UI/Screens/profile/editProfile.dart';
import 'package:crypto_wallet/UI/Screens/securityAndPrivacy/securityAndPrivacy.dart';
import 'package:crypto_wallet/UI/Screens/twoFa/twoFaScreen.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../providers/wallet_provider.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AppController appController=Get.find<AppController>();
  String? walletAddress;
  String? accountName;
  var isTwoFa=true.obs;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWalletData();
  }

  Future<void> _loadWalletData() async {
    try {
      final walletProvider = Provider.of<WalletProvider>(context, listen: false);
      await walletProvider.loadPrivateKey();

      String? savedWalletAddress = await walletProvider.getWalletAddress();
      if (savedWalletAddress == null) {
        throw Exception("Can't get the wallet address");
      }

      String? savedAccountName = await walletProvider.getAccountName();

      setState(() {
        walletAddress = savedWalletAddress;
        isLoading = false;
        accountName = savedAccountName;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        backgroundColor: primaryBackgroundColor.value,
        body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 22.0, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${getTranslated(context, "Profile") ?? "Profile"}",
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
                Expanded(
                  child: ListView(
                    children: [
                      InkWell(
                        onTap:(){
                          Get.to(EditProfile());
                        },
                        splashColor: Colors.transparent,
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
                          Row
                            (
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color:appController.isDark.value==true? Color(0xff1A2B56):inputFieldBackgroundColor.value,
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                child:  Center(
                                  child: Text(
                                    "E",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: headingColor.value,
                                      fontFamily: "dmsans",

                                    ),

                                  ),
                                ),
                              ),
                              SizedBox(width: 12,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      accountName ?? "Loading...",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.w600,
                                        color: headingColor.value,
                                        fontFamily: "dmsans",

                                      ),

                                    ),
                                    Text(
                                      "\$0.00",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.w600,
                                        color: lightTextColor.value,
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
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: (){
                          Get.to(NotificationScreen());
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
                          Row
                            (
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color:appController.isDark.value==true? Color(0xff1A2B56):inputFieldBackgroundColor.value,
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child:  Center(
                                  child: Image.asset('assets/images/notifications.png', color:appController.isDark.value==true? Color(0xffA2BBFF):headingColor.value,)
                                ),
                              ),
                              SizedBox(width: 12,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${getTranslated(context,"Notifications" )??"Notifications"}",
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
                      ),
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
                           onTap: (){
                             Get.to(ManageAccounts());
                           },
                           splashColor: Colors.transparent,
                           child: Row
                             (
                             children: [
                               Container(
                                 height: 40,
                                 width: 40,
                                 padding: EdgeInsets.all(11),
                                 decoration: BoxDecoration(

                                     color:appController.isDark.value==true? Color(0xff1A2B56):inputFieldBackgroundColor.value,
                                     borderRadius: BorderRadius.circular(12)
                                 ),
                                 child:  Center(
                                     child: Image.asset('assets/images/solar_wallet-outline.png', color:appController.isDark.value==true? Color(0xffA2BBFF):headingColor.value,)
                                 ),
                               ),
                               SizedBox(width: 12,),
                               Expanded(
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(
                                       "${getTranslated(context,"Manage Accounts" )??"Manage Accounts"}",
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
                           onTap: (){
                             Get.to(PrefrencesScreen());
                           },
                           child: Row
                             (
                             children: [
                               Container(
                                 height: 40,
                                 width: 40,
                                 padding: EdgeInsets.all(11),
                                 decoration: BoxDecoration(

                                     color:appController.isDark.value==true? Color(0xff1A2B56):inputFieldBackgroundColor.value,
                                     borderRadius: BorderRadius.circular(12)
                                 ),
                                 child:  Center(
                                     child: Image.asset('assets/images/prefrences.png', color:appController.isDark.value==true? Color(0xffA2BBFF):headingColor.value,)
                                 ),
                               ),
                               SizedBox(width: 12,),
                               Expanded(
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(
                                       "${getTranslated(context,"Preferences" )??"Preferences"}",
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
                           onTap: (){
                             Get.to(SecurityAndPrivacy());
                           },
                           splashColor: Colors.transparent,
                           child: Row
                             (
                             children: [
                               Container(
                                 height: 40,
                                 width: 40,
                                 padding: EdgeInsets.all(11),
                                 decoration: BoxDecoration(

                                     color:appController.isDark.value==true? Color(0xff1A2B56):inputFieldBackgroundColor.value,
                                     borderRadius: BorderRadius.circular(12)
                                 ),
                                 child:  Center(
                                     child: Image.asset('assets/images/securityAndPrivacy.png', color:appController.isDark.value==true? Color(0xffA2BBFF):headingColor.value,)
                                 ),
                               ),
                               SizedBox(width: 12,),
                               Expanded(
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(
                                       "${getTranslated(context,"Security & Privacy" )??"Security & Privacy"}",
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
                         // InkWell(
                         //   splashColor: Colors.transparent,
                         //   onTap: (){
                         //     Get.to(TwoFaScreen());
                         //   },
                         //   child: Row
                         //     (
                         //     children: [
                         //       Container(
                         //         height: 40,
                         //         width: 40,
                         //         padding: EdgeInsets.all(11),
                         //         decoration: BoxDecoration(
                         //
                         //             color:appController.isDark.value==true? Color(0xff1A2B56):inputFieldBackgroundColor.value,
                         //             borderRadius: BorderRadius.circular(12)
                         //         ),
                         //         child:  Center(
                         //             child: Image.asset('assets/images/2fa.png', color:appController.isDark.value==true? Color(0xffA2BBFF):headingColor.value,)
                         //         ),
                         //       ),
                         //       SizedBox(width: 12,),
                         //       Expanded(
                         //         child: Column(
                         //           mainAxisAlignment: MainAxisAlignment.center,
                         //           crossAxisAlignment: CrossAxisAlignment.start,
                         //           children: [
                         //             Text(
                         //               "${getTranslated(context,"2FA" )??"2FA"}",
                         //               textAlign: TextAlign.start,
                         //               style: TextStyle(
                         //                 fontSize: 14,
                         //                 fontWeight: FontWeight.w400,
                         //                 color: headingColor.value,
                         //                 fontFamily: "dmsans",
                         //
                         //               ),
                         //
                         //             ),
                         //
                         //
                         //
                         //           ],
                         //         ),
                         //       ),
                         //
                         //       SizedBox(width: 12,),
                         //       FlutterSwitch(
                         //         activeColor:appController.isDark.value==true? primaryBackgroundColor.value: primaryColor.value,
                         //         inactiveColor:appController.isDark.value==true? primaryBackgroundColor.value: headingColor.value,
                         //         width: 40.0,
                         //         toggleColor:appController.isDark.value==true? Color(0xffA2BBFF): primaryBackgroundColor.value,
                         //         height: 20.0,
                         //         valueFontSize: 10.0,
                         //         toggleSize: 18.0,
                         //         value: isTwoFa.value,
                         //         borderRadius: 16.0,
                         //         padding: 2.0,
                         //         showOnOff: false,
                         //         onToggle: (val) {
                         //           setState(() {
                         //             isTwoFa.value = val;
                         //           });
                         //         },
                         //       ),
                         //
                         //     ],
                         //   ),
                         // ),
                       ],
                                           )
                      ),
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
                              Row
                                (
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    padding: EdgeInsets.all(11),
                                    decoration: BoxDecoration(

                                        color:appController.isDark.value==true? Color(0xff1A2B56):inputFieldBackgroundColor.value,
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    child:  Center(
                                        child: Image.asset('assets/images/tabler_world.png', color:appController.isDark.value==true? Color(0xffA2BBFF):headingColor.value,)
                                    ),
                                  ),
                                  SizedBox(width: 12,),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${getTranslated(context,"Active Networks" )??"Active Networks"}",
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
                              SizedBox(height: 8,),

                              Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 1,),
                              SizedBox(height: 8,),


                            ],
                          )
                      ),

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
                              Row
                                (
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    padding: EdgeInsets.all(11),
                                    decoration: BoxDecoration(

                                        color:appController.isDark.value==true? Color(0xff1A2B56):inputFieldBackgroundColor.value,
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    child:  Center(
                                        child: Image.asset('assets/images/helpandsupport.png', color:appController.isDark.value==true? Color(0xffA2BBFF):headingColor.value,)
                                    ),
                                  ),
                                  SizedBox(width: 12,),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${getTranslated(context,"Online Support" )??"Online Support"}",
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
                              SizedBox(height: 8,),

                              Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 1,),
                              SizedBox(height: 8,),
                              Row
                                (
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    padding: EdgeInsets.all(11),
                                    decoration: BoxDecoration(

                                        color:appController.isDark.value==true? Color(0xff1A2B56):inputFieldBackgroundColor.value,
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    child:  Center(
                                        child: Image.asset('assets/images/aboutCryptoWallet.png', color:appController.isDark.value==true? Color(0xffA2BBFF):headingColor.value,
                                        )
                                    ),
                                  ),
                                  SizedBox(width: 12,),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${getTranslated(context,"About EcoWallet" )??"About EcoWallet"}",
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
