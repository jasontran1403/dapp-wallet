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
      body: SafeArea(
        child: Stack(
          children: [
            // Ảnh nền
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background/bg7.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Lớp phủ nội dung
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${getTranslated(context, "Select Token") ?? "Select Token"}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: "dmsans",
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 32,
                        width: 32,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.clear, size: 15, color: headingColor.value),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),

                // Ô tìm kiếm
                InputFields(
                  hintText: "",
                  icon: Image.asset("assets/images/Search.png"),
                ),

                const SizedBox(height: 32),

                // Danh sách token
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.coins.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final coin = widget.coins[index];
                    return InkWell(
                      onTap: () {
                        Get.to(SendScreen(
                          symbol: coin['symbol'],
                          balance: coin['amount'],
                          price: coin['price'],
                        ));
                      },
                      child: Container(
                        height: 80,
                        width: Get.width,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 1,
                            color: inputFieldBackgroundColor.value,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryBackgroundColor.value,
                              ),
                              child: Image.asset(
                                "${coin['image']}",
                                height: 40,
                                width: 40,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${coin['symbol']}",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "dmsans",
                                    ),
                                  ),
                                  Text(
                                    "${coin['amount']}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontFamily: "dmsans",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
