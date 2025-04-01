import 'package:crypto_wallet/UI/Screens/sendScreens/sendScreen.dart';
import 'package:crypto_wallet/UI/common_widgets/inputField.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SelectTokenScreen extends StatefulWidget {
  final List coins;  // Danh sách các coin sẽ được truyền vào

  const SelectTokenScreen({super.key, required this.coins});

  @override
  State<SelectTokenScreen> createState() => _SelectTokenScreenState();
}

class _SelectTokenScreenState extends State<SelectTokenScreen> {
  AppController appController = Get.find<AppController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor.value,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "${getTranslated(context, "Select Token") ?? "Select Token"}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: headingColor.value,
                        fontFamily: "dmsans",
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: inputFieldBackgroundColor.value,
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(Icons.clear, size: 15, color: headingColor.value),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            InputFields(
              hintText: "",
              icon: Image.asset("assets/images/Search.png"),
            ),
            SizedBox(height: 32),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.coins.length,  // Sử dụng widget.coins thay vì coins
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 12);
              },
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Get.to(SendScreen(
                      symbol: widget.coins[index]['symbol'],
                      balance: widget.coins[index]['amount'], // Pass the balance here
                      price: widget.coins[index]['price'],
                    ));
                  },

                  child: Container(
                    height: 72,
                    width: Get.width,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: inputFieldBackgroundColor2.value,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1, color: inputFieldBackgroundColor.value)),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: primaryBackgroundColor.value),
                          child: Image.asset("${widget.coins[index]['image']}", height: 40, width: 40, fit: BoxFit.fitHeight),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${widget.coins[index]['symbol']}",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: headingColor.value,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "dmsans",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${widget.coins[index]['amount']}",  // Cập nhật giá theo danh sách coins
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: lightTextColor.value,
                                              fontFamily: "dmsans",
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
