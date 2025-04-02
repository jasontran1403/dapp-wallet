import 'package:crypto_wallet/UI/Screens/createAccount/connectWallet.dart';
import 'package:crypto_wallet/UI/Screens/homeScreen/homeScreen.dart';
import 'package:crypto_wallet/UI/Screens/onBoardingScreens/onboardingScreen1.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:crypto_wallet/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/appController.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../../common_widgets/inputField.dart';

class CreateAccount extends StatefulWidget {
  final String walletAddress;
  final String privateKey;
  final String mnemonicWords;

  CreateAccount({
    required this.walletAddress,
    required this.privateKey,
    required this.mnemonicWords,
    super.key
  });

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final appController = Get.find<AppController>();

  final TextEditingController referralController = TextEditingController();
  final RxBool isReferralValid = false.obs;
  final RxBool isCheckingReferral = false.obs;

  void checkReferralCode() async {
    print(widget.mnemonicWords);
    print(widget.walletAddress);
    print(widget.privateKey);

    isCheckingReferral.value = true;

    try {
      bool isValid = await ApiService.getReferralCodeStatus(referralController.text);

      print("API result: ${isValid}");

      if (isValid) {
        isReferralValid.value = true;
        Get.snackbar("Success", "Referral code is valid",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        isReferralValid.value = false;
        Get.snackbar("Error", "Referral code is not existed, please try again",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      isReferralValid.value = false;
      Get.snackbar("Error", "Something went wrong, please try again later",
          backgroundColor: Colors.red, colorText: Colors.white);
    }

    isCheckingReferral.value = false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor.value,
      body: Obx(
            () => SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${getTranslated(context, "Create Account") ?? "Create Account"}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: headingColor.value,
                        fontFamily: "dmsans",
                      ),
                    ),
                    SizedBox(height: 24),

                    InputFieldsWithSeparateIcon(
                      svg: "Wallet2",
                      headerText: "",
                      hintText: "Enter account name",
                      hasHeader: false,
                      onChange: () {},
                    ),

                    InputFieldsWithSeparateIcon(
                      controller: referralController,
                      suffixIcon: isCheckingReferral.value
                          ? Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : GestureDetector(
                        onTap: checkReferralCode,
                        child: Icon(Icons.check_rounded,
                            color: headingColor.value, size: 16),
                      ),
                      svg: "mdi_contact-outline",
                      headerText: "",
                      hintText: "Enter referral code",
                      hasHeader: false,
                      onChange: () {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.remove('privateKey');
                          await prefs.remove('walletAddress');

                          Get.offAll(() => OnBoardingScreen1());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16), // ✅ Thêm khoảng cách giữa hai nút
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!isReferralValid.value) {
                            Get.to(() => HomeScreen());
                          } else {
                            print("not ok");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isReferralValid.value ? Colors.greenAccent : Colors.grey,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Create account",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
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

