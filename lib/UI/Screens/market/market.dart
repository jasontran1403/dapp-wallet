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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor.value,
      body:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    "${getTranslated(context,"Market Info" )??"Market Info"}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:15,
                      fontWeight: FontWeight.w600,
                      color: darkBlueColor.value,
                      fontFamily: "dmsans",

                    ),

                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),

            ],
          ),
        ),
      ),
    );
  }

}
