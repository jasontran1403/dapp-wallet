import 'package:crypto_wallet/UI/Screens/addressBookScreens/addressBookScreen.dart';
import 'package:crypto_wallet/UI/Screens/homeScreen/homeScreen.dart';
import 'package:crypto_wallet/UI/Screens/manageAccounts/manageAccounts.dart';
import 'package:crypto_wallet/UI/Screens/notifications/notifications.dart';
import 'package:crypto_wallet/UI/Screens/onBoardingScreens/onboardingScreen1.dart';
import 'package:crypto_wallet/UI/Screens/preferences/prefrences.dart';
import 'package:crypto_wallet/UI/Screens/profile/editProfile.dart';
import 'package:crypto_wallet/UI/Screens/referralsScreen/referralScreen.dart';
import 'package:crypto_wallet/UI/Screens/securityAndPrivacy/securityAndPrivacy.dart';
import 'package:crypto_wallet/UI/Screens/twoFa/twoFaScreen.dart';
import 'package:crypto_wallet/UI/common_widgets/bottomNavBar.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:crypto_wallet/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  double? reward;
  bool? isActive;
  bool isActivating = false; // Add this with your other state variables
  bool isClaiming = false;

  @override
  void initState() {
    super.initState();
    _loadWalletData();
  }

  String formatBalance(String balance) {
    try {
      double value = double.parse(balance);

      if (value == 0) {
        return "0";
      }

      return NumberFormat("#,##0.##", "en_US").format(value);
    } catch (e) {
      return "Invalid balance";
    }
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

      dynamic accountInfo = await ApiService.getAccountRewardInfo(savedWalletAddress);

      setState(() {
        reward = accountInfo['rewards'];
        isActive = accountInfo['active'];
        walletAddress = savedWalletAddress;
        isLoading = false;
        accountName = savedAccountName;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        backgroundColor: primaryBackgroundColor.value,
        body: SafeArea(
          child:
          Stack(
            children: [
              Positioned.fill(
                child:
                Image.asset(
                  "assets/background/bg7.png",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
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
                            color: Colors.white,
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
                                  color: Colors.grey.shade800.withOpacity(0.7),
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
                                        "",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
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
                                            color: Colors.white,
                                            fontFamily: "dmsans",

                                          ),

                                        ),
                                        Text(
                                          "${formatBalance((reward ?? 0).toString())} EFT",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 16.5,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontFamily: "dmsans",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(width: 12,),
                                  Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18,)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),

                          SizedBox(height: 20,),
                          
                          Container(
                            // height: 80,
                              width: Get.width,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade800.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                              ),
                              child:
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      if (isActivating) return;
                                      // Show confirmation dialog
                                      if (!isActive!) {
                                        bool confirm = await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(getTranslated(context, "Active account") ?? "Active account"),
                                              content: Text(getTranslated(context, "Are you sure you want to active account (0.002BNB fee)?") ?? "Are you sure you want to active account (0.002BNB fee)?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text(getTranslated(context, "Cancel") ?? "Cancel"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop(false);
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text(getTranslated(context, "Confirm") ?? "Confirm", style: TextStyle(color: Colors.red)),
                                                  onPressed: () {
                                                    Navigator.of(context).pop(true);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        if (confirm == true) {
                                          setState(() => isActivating = true); // Show loading

                                          try {
                                            dynamic response = await ApiService.activeAccount(walletAddress!);

                                            if (response != null) {
                                              if (response is String) {
                                                if (response.contains("Activated account successful")) {
                                                  Get.snackbar("Success", response,
                                                      backgroundColor: Colors.greenAccent, colorText: Colors.white);
                                                  setState(() => isActive = true); // Update account status
                                                  _loadWalletData();
                                                } else {
                                                  Get.snackbar("Error", response,
                                                      backgroundColor: Colors.red, colorText: Colors.white);
                                                }
                                              } else if (response is Map) {
                                                Get.snackbar(response['error'] ?? "Error", response['message'],
                                                    backgroundColor: Colors.red, colorText: Colors.white);
                                              }
                                            } else {
                                              Get.snackbar("Error", "No response from the server.",
                                                  backgroundColor: Colors.red, colorText: Colors.white);
                                            }
                                          } catch (e) {
                                            Get.snackbar("Error", "An error occurred during activation",
                                                backgroundColor: Colors.red, colorText: Colors.white);
                                          } finally {
                                            setState(() => isActivating = false); // Hide loading
                                          }
                                        }
                                      } else {
                                        Get.snackbar("Error", "This account has been activated",
                                            backgroundColor: Colors.red, colorText: Colors.white);
                                      }
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
                                              child: Image.asset('assets/images/simple-icons_tether.png', color:appController.isDark.value==true? Color(0xffA2BBFF):headingColor.value,)
                                          ),
                                        ),
                                        SizedBox(width: 12,),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${getTranslated(context,"Active account" )??"Active account"}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                  fontFamily: "dmsans",

                                                ),

                                              ),



                                            ],
                                          ),
                                        ),

                                        SizedBox(width: 12,),
                                        Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18,)
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 8,),

                                  Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 1,),
                                  SizedBox(height: 8,),
                                  InkWell(
                                    onTap: () async {
                                      if (isClaiming) return;
                                      // Show confirmation dialog
                                      if (isActive!) {
                                        bool confirm = await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(getTranslated(context, "Claim rewards") ?? "Claim rewards"),
                                              content: Text(getTranslated(context, "Are you sure you want to claim rewards?") ?? "Are you sure you want to claim rewards?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text(getTranslated(context, "Cancel") ?? "Cancel"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop(false);
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text(getTranslated(context, "Confirm") ?? "Confirm", style: TextStyle(color: Colors.red)),
                                                  onPressed: () {
                                                    Navigator.of(context).pop(true);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        if (confirm == true) {
                                          setState(() => isClaiming = true); // Show loading

                                          try {
                                            dynamic response = await ApiService.claimRewards(walletAddress!);

                                            if (response != null) {
                                              if (response is String) {
                                                if (response.contains("Claim rewards successful")) {
                                                  Get.snackbar("Success", response,
                                                      backgroundColor: Colors.greenAccent, colorText: Colors.white);
                                                  setState(() => isClaiming = true); // Update account status
                                                  _loadWalletData();
                                                } else {
                                                  Get.snackbar("Error", response,
                                                      backgroundColor: Colors.red, colorText: Colors.white);
                                                }
                                              } else if (response is Map) {
                                                Get.snackbar(response['error'] ?? "Error", response['message'],
                                                    backgroundColor: Colors.red, colorText: Colors.white);
                                              }
                                            } else {
                                              Get.snackbar("Error", "No response from the server.",
                                                  backgroundColor: Colors.red, colorText: Colors.white);
                                            }
                                          } catch (e) {
                                            Get.snackbar("Error", "An error occurred during activation",
                                                backgroundColor: Colors.red, colorText: Colors.white);
                                          } finally {
                                            setState(() => isClaiming = false); // Hide loading
                                          }
                                        }
                                      } else {
                                        Get.snackbar("Error", "This account has not been activated",
                                            backgroundColor: Colors.red, colorText: Colors.white);
                                      }
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
                                              child: Image.asset('assets/images/simple-icons_tether.png', color:appController.isDark.value==true? Color(0xffA2BBFF):headingColor.value,)
                                          ),
                                        ),
                                        SizedBox(width: 12,),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${getTranslated(context,"Claim rewards" )??"Claim rewards"}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                  fontFamily: "dmsans",

                                                ),

                                              ),



                                            ],
                                          ),
                                        ),

                                        SizedBox(width: 12,),
                                        Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18,)
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 8,),

                                  Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 1,),
                                  SizedBox(height: 8,),
                                  InkWell(
                                    onTap: (){
                                      Get.to(ReferralScreen());
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
                                                "${getTranslated(context,"Referrals" )??"Referrals"}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                  fontFamily: "dmsans",

                                                ),

                                              ),



                                            ],
                                          ),
                                        ),

                                        SizedBox(width: 12,),
                                        Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18,)
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
                                                  color: Colors.white,
                                                  fontFamily: "dmsans",

                                                ),

                                              ),



                                            ],
                                          ),
                                        ),

                                        SizedBox(width: 12,),
                                        Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18,)
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
                                                  color: Colors.white,
                                                  fontFamily: "dmsans",

                                                ),

                                              ),



                                            ],
                                          ),
                                        ),

                                        SizedBox(width: 12,),
                                        Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18,)
                                      ],
                                    ),
                                  ),
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

                          SizedBox(height: 20,),
                          Container(
                            // height: 80,
                              width: Get.width,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade800.withOpacity(0.7),
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
                                                color: Colors.white,
                                                fontFamily: "dmsans",

                                              ),

                                            ),



                                          ],
                                        ),
                                      ),

                                      SizedBox(width: 12,),
                                      Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18,)
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
                                                color: Colors.white,
                                                fontFamily: "dmsans",

                                              ),

                                            ),



                                          ],
                                        ),
                                      ),

                                      SizedBox(width: 12,),
                                      Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18,)
                                    ],
                                  ),

                                ],
                              )
                          ),

                          SizedBox(height: 20,),
                          Container(
                            // height: 80,
                              width: Get.width,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade800.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                              ),
                              child:
                              Column(
                                children: [
                                  // Replace the existing sign-out container with this:
                                  InkWell(
                                    onTap: () async {
                                      // Show confirmation dialog
                                      bool confirm = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(getTranslated(context, "Sign Out") ?? "Sign Out"),
                                            content: Text(getTranslated(context, "Are you sure you want to sign out?") ?? "Are you sure you want to sign out?"),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text(getTranslated(context, "Cancel") ?? "Cancel"),
                                                onPressed: () {
                                                  Navigator.of(context).pop(false);
                                                },
                                              ),
                                              TextButton(
                                                child: Text(getTranslated(context, "Sign Out") ?? "Sign Out", style: TextStyle(color: Colors.red)),
                                                onPressed: () {
                                                  Navigator.of(context).pop(true);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );

                                      if (confirm == true) {
                                        // Xóa privateKey khi logout
                                        final walletProvider = Provider.of<WalletProvider>(context, listen: false);
                                        await walletProvider.clearPrivateKey(); // Xóa privateKey

                                        // Chuyển hướng về màn hình OnBoardingScreen1
                                        Get.offAll(OnBoardingScreen1());
                                      }
                                    },
                                    child: Container(
                                      width: Get.width,
                                      padding: EdgeInsets.all(0),

                                      child: Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            padding: EdgeInsets.all(11),
                                            decoration: BoxDecoration(
                                                color: appController.isDark.value == true ? Color(0xff1A2B56) : inputFieldBackgroundColor.value,
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            child: Center(
                                                child: Image.asset(
                                                  'assets/images/helpandsupport.png',
                                                  color: appController.isDark.value == true ? Color(0xffA2BBFF) : headingColor.value,
                                                )
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${getTranslated(context, "Sign out") ?? "Sign out"}",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                    fontFamily: "dmsans",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18)
                                        ],
                                      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
