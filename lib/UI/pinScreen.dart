import 'package:crypto_wallet/UI/Screens/homeScreen/homeScreen.dart';
import 'package:crypto_wallet/UI/Screens/socialLogin/socialLogin.dart';
import 'package:crypto_wallet/UI/common_widgets/bottomNavBar.dart';
import 'package:crypto_wallet/UI/common_widgets/customNamPad.dart';
import 'package:crypto_wallet/UI/common_widgets/inputField.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_dot/pin_dot.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        backgroundColor: primaryBackgroundColor.value,
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                "assets/background/bg7.png",
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 64,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${getTranslated(context,"Enter PIN" )??"Enter PIN"}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontFamily: "dmsans",

                              ),)

                            ,
                          ],
                        ),
                        SizedBox(height: 24,),

                        PinDot(
                          size: 17,
                          length: 4,
                          controller: _pinController,
                          inactiveColor: primaryBackgroundColor.value,
                          activeColor: primaryColor.value,
                          borderColor: primaryColor.value,
                        ),
                      ],
                    ),


                    Column(
                      children: [
                        CustomNumPad(
                          buttonSize: Get.width / 5,
                          delete: () {
                            if (_pinController.text.isNotEmpty) {
                              _pinController.text = _pinController.text.substring(0, _pinController.text.length - 1);
                            }
                          },
                          onSubmit: () {

                          },
                          controller: _pinController,
                        ),
                        SizedBox(height: 16),
                      ],
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}