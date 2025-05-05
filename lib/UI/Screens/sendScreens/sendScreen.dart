import 'dart:ffi';

import 'package:crypto_wallet/UI/Screens/sendScreens/conformationScreen.dart';
import 'package:crypto_wallet/UI/common_widgets/bottomRectangularbtn.dart';
import 'package:crypto_wallet/UI/common_widgets/inputField.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../codeScanner.dart';

class SendScreen extends StatefulWidget {
  final String symbol;
  final String balance;
  final String price;

  const SendScreen({
    required this.symbol,
    required this.balance,
    required this.price,
    super.key,
  });

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  TextEditingController nameAddreeC = TextEditingController();
  TextEditingController amountC = TextEditingController();
  TextEditingController memoC = TextEditingController(); // Thêm controller memo
  var isOpen = true.obs;

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
              child: GestureDetector(
                onTap: () {
                  // Dismiss keyboard when tapping outside
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "${getTranslated(context, "Send") ?? "Send"} ${widget.symbol}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: "dmsans",
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SvgPicture.asset(
                              "assets/svgs/mdi_contact-outline.svg",
                              color: headingColor.value,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    InputFields2(
                      textController: nameAddreeC,
                      suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () async {
                              final clipboardData = await Clipboard.getData('text/plain');
                              if (clipboardData != null && clipboardData.text != null) {
                                nameAddreeC.text = clipboardData.text!.trim();
                                setState(() {});
                              }
                            },
                            child: Container(
                              height: 21,
                              width: 46,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  tileMode: TileMode.clamp,
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: nameAddreeC.text.isEmpty
                                      ? [lightTextColor.value, lightTextColor.value]
                                      : [Color(0xff76CF56), Color(0xff55DDAF)],
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  "${getTranslated(context, "Paste") ?? "Paste"}",
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                    color: primaryBackgroundColor.value,
                                    fontFamily: "dmsans",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                      hasHeader: true,
                      headerText: "Address",
                      hintText: "Enter address",
                      onChange: (val) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 18),
                    Text(
                      'Balance available: ${widget.balance} ${widget.symbol}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: "dmsans",
                      ),
                    ),
                    if (widget.symbol == "XRP") ...[
                      SizedBox(height: 8),
                      Text(
                        'Ripple requires a minimum reserve of 1 XRP to remain in the wallet.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.redAccent,
                          fontFamily: "dmsans",
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],

                    SizedBox(height: 16),
                    TextFormField(
                      controller: amountC,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*[,\.]?\d{0,8}')),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          // Kiểm tra và thay thế dấu ',' bằng '.'
                          final newText = newValue.text.replaceAll(',', '.');
                          return newValue.copyWith(text: newText);
                        }),
                      ],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: "dmsans",
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter transfer amount",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade800.withOpacity(0.7), // Màu cho hint text
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'dmsans',
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade800.withOpacity(0.7), // Màu nền của ô nhập liệu
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.2), width: 1),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.2), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.2), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    // Hiển thị ô nhập memo nếu là XRP hoặc TON
                    if (widget.symbol == "XRP" || widget.symbol == "TON") ...[
                      SizedBox(height: 18),
                      InputFields2(
                        textController: memoC,
                        hasHeader: true,
                        headerText: "Memo",
                        hintText: "Enter memo (if required)",
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () async {
                                final clipboardData = await Clipboard.getData('text/plain');
                                if (clipboardData != null && clipboardData.text != null) {
                                  memoC.text = clipboardData.text!;
                                  setState(() {});
                                }
                              },
                              child: Container(
                                height: 21,
                                width: 46,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    tileMode: TileMode.clamp,
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: memoC.text.isEmpty
                                        ? [lightTextColor.value, lightTextColor.value]
                                        : [Color(0xff76CF56), Color(0xff55DDAF)],
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    "${getTranslated(context, "Paste") ?? "Paste"}",
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      color: primaryBackgroundColor.value,
                                      fontFamily: "dmsans",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                        onChange: (v) {
                          setState(() {});
                        },
                      ),
                    ],
                    SizedBox(height: 24),
                    BottomRectangularBtn(
                      onTapFunc: () {
                        String walletAddress = nameAddreeC.text;
                        String amountText = amountC.text;

                        if (walletAddress.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Recipient wallet address cannot be empty.",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }

                        double amount = double.tryParse(amountText) ?? 0;
                        if (amount <= 0) {
                          Get.snackbar(
                            "Error",
                            "Please enter a valid amount.",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }

                        double balance =
                            double.tryParse(widget.balance.toString()) ?? 0;
                        if (amount >= balance) {
                          Get.snackbar(
                            "Error",
                            "The transfer amount exceeds your available balance, excluding fees.",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }

                        if (widget.symbol == "BTC") {
                          if (amount < 0.00002) {
                            Get.snackbar(
                              "Error",
                              "Minimum transaction of Bitcoin is 0.00002 BTC.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                            return;
                          }
                        }

                        if (widget.symbol == "ETH") {
                          if (amount < 0.001) {
                            Get.snackbar(
                              "Error",
                              "Minimum transaction of Ethereum is 0.001 ETH.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                            return;
                          }
                        }

                        if (widget.symbol == "EFT") {
                          if (amount < 1) {
                            Get.snackbar(
                              "Error",
                              "Minimum transaction of Ecofusion Token is 1.00 EFT.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                            return;
                          }
                        }

                        if (widget.symbol == "USDT") {
                          if (amount < 1) {
                            Get.snackbar(
                              "Error",
                              "Minimum transaction of Tether USDT is 1.00 USDT.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                            return;
                          }
                        }

                        if (widget.symbol == "XRP") {
                          if (amount < 1) {
                            Get.snackbar(
                              "Error",
                              "Minimum transaction of Ripple is 1.00 XRP.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                            return;
                          }

                          if (amount + 1 >= balance) {
                            Get.snackbar(
                              "Error",
                              "The XRP wallet must maintain a minimum of 1 XRP after a successful transaction..",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                            return;
                          }
                        }

                        if (widget.symbol == "TON") {
                          if (amount < 1) {
                            Get.snackbar(
                              "Error",
                              "Minimum transaction of TON Coin is 1.00 TON.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                            return;
                          }
                        }

                        if (widget.symbol == "BNB") {
                          if (amount < 0.003) {
                            Get.snackbar(
                              "Error",
                              "Minimum transaction of Binance Coin is 0.003 BNB.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                            return;
                          }
                        }

                        Get.to(ConformationScreen(
                          walletAddress: walletAddress,
                          amount: amountText,
                          symbol: widget.symbol,
                          price: widget.price,
                          memo: (widget.symbol == "XRP" || widget.symbol == "TON")
                              ? memoC.text
                              : '',
                        ));
                      },
                      btnTitle: "Next",
                      color: Colors.green, // 💚 Thêm dòng này
                    ),
                    SizedBox(height: 24),
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
