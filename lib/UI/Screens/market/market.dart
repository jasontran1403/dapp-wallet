import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_wallet/UI/Screens/nfts/nftsDetail.dart';
import 'package:crypto_wallet/UI/Screens/nfts/receiveNftScreen.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';





class MarketScreen extends StatefulWidget {
  MarketScreen({super.key});


  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final appController = Get.find<AppController>();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    simulateLoading();
  }

  void simulateLoading() {
    setState(() {
      isLoading = true; // Bắt đầu loading
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false; // Kết thúc loading sau 1 giây
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        backgroundColor: primaryBackgroundColor.value,
        body: SafeArea(
            child: isLoading
                ? Stack(
              fit: StackFit.expand, // Đảm bảo nền phủ toàn màn hình
              children: [
                // Background Image
                Image.asset(
                  'assets/background/bg7.png',
                  fit: BoxFit.cover, // Phủ kín màn hình
                ),

                // Loading Spinner
                Center(
                  child: CircularProgressIndicator(
                    color: primaryColor.value,
                  ),
                ),
              ],
            )
                :
            Stack(
              children: [
                Positioned.fill(
                  child:
                  Image.asset(
                    "assets/background/bg7.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 20,

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20), // Thêm padding cho text
                          child: Text(
                            "${getTranslated(context, "Market Info") ?? "Market Info"}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: darkBlueColor.value,
                              fontFamily: "dmsans",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),

              ],
            ),
        ),
      ),
    );
  }
}
