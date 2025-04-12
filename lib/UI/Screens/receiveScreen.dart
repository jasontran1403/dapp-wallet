import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveScreen extends StatefulWidget {
  final String? symbol;
  final String? image;
  final String? walletAddress;

  const ReceiveScreen({
    required this.symbol,
    required this.image,
    required this.walletAddress,
    super.key});

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  AppController appController=Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background/bg7.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 18)),
                  SizedBox(width: 8),
                  Text(
                    "${getTranslated(context, "Receive") ?? "Receive"}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: "dmsans",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset(widget.image ?? "assets/images/bnb.png"),
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.symbol ?? "BNB",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: "dmsans",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 227,
                    width: 227,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: QrImageView(
                      data: widget.walletAddress ?? "",
                      version: QrVersions.auto,
                      size: 200,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text(
                "${getTranslated(context, "Send only the specified coins to this deposit address. This address does NOT support deposit of non-fungible token.") ?? "Send only the specified coins to this deposit address. This address does NOT support deposit of non-fungible token."}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.redAccent,
                  fontStyle: FontStyle.italic,
                  fontFamily: "dmsans",
                ),
              ),
              SizedBox(height: 32),
              Divider(height: 1, color: Colors.white54),
              SizedBox(height: 24),
              Text(
                "${getTranslated(context, "Deposit Address") ?? "Deposit Address"}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontFamily: "dmsans",
                ),
              ),
              SizedBox(height: 16),
              Text(
                widget.walletAddress ?? "Loading...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: "dmsans",
                ),
              ),
              SizedBox(height: 44),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: widget.walletAddress ?? "null"));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                            Text("Copied wallet address to clipboard!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: primaryColor.value,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/svgs/Test.svg"),
                            SizedBox(width: 10),
                            Text(
                              "${getTranslated(context, "Copy") ?? "Copy"}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontFamily: "dmsans",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
