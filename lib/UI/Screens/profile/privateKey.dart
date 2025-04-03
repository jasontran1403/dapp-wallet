import 'package:crypto_wallet/UI/Screens/profile/privateKey.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/services/utilServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/appController.dart';
import '../../common_widgets/bottomRectangularbtn.dart';


class PrivateKey extends StatefulWidget {
  final String? privateKey;

  PrivateKey({
    required this.privateKey,
    super.key});

  @override
  State<PrivateKey> createState() => _PrivateKeyState();
}

class _PrivateKeyState extends State<PrivateKey> {
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
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back_ios,color: headingColor.value,size: 18,)),
                    SizedBox(width: 8,),
                    Text(
                      "Your Private Key",
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
                          'Do not share your private key',
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
                      "Private key",
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
            Container(
              width: Get.width,
              padding: EdgeInsets.all( 16),
              decoration: BoxDecoration(
                color: inputFieldBackgroundColor2.value,
                border: Border.all(width: 1,color: headingColor.value),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Text(
                widget.privateKey ?? "Loading...",
                style: TextStyle(
                  color: headingColor.value,
                  fontSize: 14,
                  fontFamily: 'dmsans',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
                SizedBox(height: 16,),
                GestureDetector(
                  onTap: (){
                    UtilService().copyToClipboard(widget.privateKey!);
                  },
                  child: Container(
                    height: 40,
                    width: 189,
                    decoration: BoxDecoration(
                        color: inputFieldBackgroundColor2.value,
                        border: Border.all(width: 1,color: inputFieldBackgroundColor.value),
                        borderRadius: BorderRadius.circular(60)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/u_copy-landscape.png",height: 17,width: 17,),
                        SizedBox(width: 10,),
                        Text(
                          'Copy to clipboard',
                          style: TextStyle(
                            color: headingColor.value,
                            fontSize: 14,
                            fontFamily: 'dmsans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
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
