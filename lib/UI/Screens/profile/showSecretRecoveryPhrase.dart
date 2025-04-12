import 'package:crypto_wallet/UI/Screens/profile/privateKey.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:crypto_wallet/services/utilServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/appController.dart';
import '../../common_widgets/bottomRectangularbtn.dart';

class ShowSecretRecoveryPhrase extends StatefulWidget {
  final String mnemonics;

  ShowSecretRecoveryPhrase({
    required this.mnemonics,
    super.key,
  });

  @override
  State<ShowSecretRecoveryPhrase> createState() => _ShowSecretRecoveryPhraseState();
}

class _ShowSecretRecoveryPhraseState extends State<ShowSecretRecoveryPhrase> {
  final appController = Get.find<AppController>();
  var isCheckBox = false.obs;
  var ch = ''.obs;

  // Chia mnemonics thành các từ riêng biệt
  List<String> get mnemonicsList {
    return widget.mnemonics.split(' ');
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
                padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "${getTranslated(context, "Secret Recovery Phrase") ?? "Secret Recovery Phrase"}",
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
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 48.0),
                            child: Text(
                              '${getTranslated(context, "Write Down Your Seed Phrase") ?? "Write Down Your Seed Phrase"}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'dmsans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28.0),
                            child: Text(
                              '${getTranslated(context, "If someone has access to your secret phrase they will have full control of your wallet.") ?? "If someone has access to your secret phrase they will have full control of your wallet."}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 14,
                                fontFamily: 'dmsans',
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Container(
                      width: Get.width,
                      height: 200,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800.withOpacity(0.7),
                        border: Border.all(width: 1, color: inputFieldBackgroundColor.value),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: GridView.builder(
                        itemCount: mnemonicsList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 32,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          crossAxisCount: 3,  // Số cột là 4
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 56,
                            width: 80,
                            child: Center(  // Đặt Center ở đây để canh giữa nội dung
                              child: Text(
                                '${index + 1}. ${mnemonicsList[index]}', // Hiển thị từ tại chỉ mục index
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'dmsans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        UtilService().copyToClipboard(widget.mnemonics);
                      },
                      child: Container(
                        height: 40,
                        width: 189,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade800.withOpacity(0.7),
                            border: Border.all(width: 1, color: inputFieldBackgroundColor.value),
                            borderRadius: BorderRadius.circular(60)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/u_copy-landscape.png",
                              height: 17,
                              width: 17,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '${getTranslated(context, "Copy to clipboard") ?? "Copy to clipboard"}',
                              style: TextStyle(
                                color: Colors.white,
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

          ],
        ),
      ),
    );
  }
}
