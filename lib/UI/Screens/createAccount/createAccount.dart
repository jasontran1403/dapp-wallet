import 'dart:convert';

import 'package:crypto_wallet/UI/Screens/createAccount/connectWallet.dart';
import 'package:crypto_wallet/UI/Screens/homeScreen/homeScreen.dart';
import 'package:crypto_wallet/UI/Screens/onBoardingScreens/onboardingScreen1.dart';
import 'package:crypto_wallet/UI/common_widgets/bottomNavBar.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:crypto_wallet/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final TextEditingController accountNameController = TextEditingController();
  final RxBool isReferralValid = false.obs;
  final RxBool isCheckingReferral = false.obs;
  TextEditingController pinController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();

  RxBool isPinVisible = false.obs;
  RxString pinErrorText = ''.obs;
  Rx<Color> pinBorderColor = Colors.grey.obs;

  void validatePin() {
    if (confirmPinController.text.length == 4) {
      if (pinController.text != confirmPinController.text) {
        pinErrorText.value = "PIN codes do not match";
        pinBorderColor.value = Colors.red;
        isReferralValid.value = false;
      } else {
        pinErrorText.value = "";
        pinBorderColor.value = Colors.grey;
        isReferralValid.value = true;
      }
    }
  }

  void checkReferralCode() async {
    // Kiểm tra xem referral code có trống không
    if (referralController.text.isEmpty) {
      Get.snackbar("Error", "Referral code cannot be empty",
          backgroundColor: Colors.red, colorText: Colors.white);
      return; // Nếu trống thì không gọi API
    }

    isCheckingReferral.value = true;

    try {
      bool isValid = await ApiService.getReferralCodeStatus(referralController.text);

      if (isValid) {
        isReferralValid.value = true;
        Get.snackbar("Success", "Referral code is valid",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        isReferralValid.value = false;
        Get.snackbar("Error", "Referral code is not valid, please try again",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      isReferralValid.value = false;
      Get.snackbar("Error", "Something went wrong, please try again later",
          backgroundColor: Colors.red, colorText: Colors.white);
    }

    isCheckingReferral.value = false;
  }

  void createAccount() async {
    if (accountNameController.text.isEmpty) {
      Get.snackbar("Error", "Account name cannot be empty",
          backgroundColor: Colors.red, colorText: Colors.white);
      return; // Nếu trống thì không gọi API
    }

    if (accountNameController.text.length < 4) {
      Get.snackbar("Error", "Account name length must be greater than 4",
          backgroundColor: Colors.red, colorText: Colors.white);
      return; // Nếu trống thì không gọi API
    }

    if (referralController.text.isEmpty) {
      Get.snackbar("Error", "Referral code cannot be empty",
          backgroundColor: Colors.red, colorText: Colors.white);
      return; // Nếu trống thì không gọi API
    }

    if (pinController.text.isEmpty) {
      Get.snackbar("Error", "Pin code cannot be empty",
          backgroundColor: Colors.red, colorText: Colors.white);
      return; // Nếu trống thì không gọi API
    }

    if (pinController.text.length < 4) {
      Get.snackbar("Error", "Pin code must be exactly 4 digits",
          backgroundColor: Colors.red, colorText: Colors.white);
      return; // Nếu không đủ 4 ký tự thì không gọi API
    }

    if (pinController.text != confirmPinController.text) {
      Get.snackbar("Error", "PIN codes do not match",
          backgroundColor: Colors.red, colorText: Colors.white);
      return; // Nếu không khớp thì không gọi API
    }


    dynamic response = await ApiService.authenticate(
      widget.walletAddress, widget.mnemonicWords, widget.privateKey, referralController.text, accountNameController.text, pinController.text
    );

    String responseWalletAddress = json.decode(response)['walletAddress'];

    if (responseWalletAddress == widget.walletAddress) {
      Get.snackbar(
        "Success",
        "Create account successful. Redirect after 1 seconds.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('privateKey', widget.privateKey);
      await prefs.setString('walletAddress', widget.walletAddress);
      await prefs.setString('accountName', accountNameController.text);
      await prefs.setString('pinCode', pinController.text);

      Future.delayed(Duration(seconds: 1), () {
        Get.offAll(BottomBar());
      });
    } else {
      Get.snackbar(
        "Error",
        "Create account failed.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
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

                        TextField(
                          controller: accountNameController,
                          style: TextStyle(color: Colors.black),
                          maxLength: 12, // Giới hạn tối đa 12 ký tự
                          decoration: InputDecoration(
                            labelText: "Account Name",
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: "Enter account name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue, width: 2),
                            ),
                            counterText: "", // Ẩn bộ đếm ký tự mặc định
                          ),
                          onChanged: (value) {

                          },
                        ),

                        SizedBox(height: 24),

                        TextField(
                          controller: referralController,
                          style: TextStyle(color: Colors.black), // ✅ Màu chữ đen khi nhập
                          readOnly: isReferralValid.value, // ✅ Không cho phép chỉnh sửa nếu valid
                          decoration: InputDecoration(
                            labelText: "Referral Code",
                            labelStyle: TextStyle(color: Colors.black), // ✅ Màu label luôn đen
                            hintText: "Enter referral code",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue, width: 2),
                            ),
                            suffixIcon: Obx(() => isCheckingReferral.value
                                ? Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                                : GestureDetector(
                              onTap: checkReferralCode,
                              child: Icon(Icons.check_rounded,
                                  color: headingColor.value, size: 16),
                            )),
                          ),
                          onChanged: (value) {
                            if (!isReferralValid.value) {
                            }
                          },
                        ),

                        SizedBox(height: 24),
                        TextField(
                          controller: pinController,
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          obscureText: !isPinVisible.value,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                            labelText: "PIN Code",
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: "Enter 4-digit PIN",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: pinBorderColor.value),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue, width: 2),
                            ),
                            suffixIcon: Obx(
                                  () => GestureDetector(
                                onTap: () => isPinVisible.value = !isPinVisible.value,
                                child: Icon(
                                  isPinVisible.value ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 24),
                        TextField(
                          controller: confirmPinController,
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          obscureText: !isPinVisible.value,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                            labelText: "Confirm PIN Code",
                            labelStyle: TextStyle(color: Colors.black),
                            hintText: "Enter 4-digit PIN",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: pinBorderColor.value),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue, width: 2),
                            ),
                            suffixIcon: Obx(
                                  () => GestureDetector(
                                onTap: () => isPinVisible.value = !isPinVisible.value,
                                child: Icon(
                                  isPinVisible.value ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          onChanged: (value) => validatePin(),
                        ),

                        Obx(
                              () => pinErrorText.value.isNotEmpty
                              ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              pinErrorText.value,
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          )
                              : SizedBox.shrink(),
                        )

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
                              createAccount();
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
            ],
          ),
        ),
      ),
    );
  }
}

