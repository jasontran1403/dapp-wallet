import 'dart:convert';

import 'package:crypto_wallet/UI/Screens/addAccount/addAccount.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:crypto_wallet/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../controllers/appController.dart';
import '../../../providers/wallet_provider.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../createAccount/connectWallet.dart';


class ReferralScreen extends StatefulWidget {
  ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  final appController = Get.find<AppController>();
  List referrals=[];
  bool isLoading = true; // Thêm state loading
  String? walletAddress;
  String? refCode;

  @override
  void initState() {
    super.initState();
    _loadWalletData();
  }

  Future<void> _loadWalletData() async {
    try {
      setState(() => isLoading = true); // Bắt đầu loading

      final walletProvider = Provider.of<WalletProvider>(context, listen: false);
      await walletProvider.loadPrivateKey();

      String? savedWalletAddress = await walletProvider.getWalletAddress();

      if (savedWalletAddress == null) {
        throw Exception("Can't extract wallet address");
      }

      // Sử dụng symbolConverted thay vì symbol
      dynamic responseReferrals = await ApiService.getDirectTree(savedWalletAddress);

      // Cập nhật danh sách coins với dữ liệu thực
      setState(() {
        referrals = responseReferrals['referrals'];
        refCode = responseReferrals['refCode'];
        isLoading = false; // Kết thúc loading
      });
    } catch (e) {
      setState(() => isLoading = false); // Đảm bảo tắt loading khi có lỗi
    }
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
                padding: EdgeInsets.symmetric(horizontal: 22.0,vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(

                                onTap:(){
                                  Get.back();

                                },
                                child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 18,)),
                            SizedBox(width: 8,),
                            Text(
                              "${getTranslated(context,"Your referrals information" )??"Your referrals information"}",
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
                      ],
                    ),
                    SizedBox(height: 24,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          getTranslated(context, "Your referral code") ?? "Your referral code",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: "dmsans",
                          ),
                        ),
                        SizedBox(height: 8), // Khoảng cách giữa 2 dòng
                        GestureDetector(
                          onTap: () {
                            if (refCode != null) {
                              Clipboard.setData(ClipboardData(text: refCode!));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Copied to clipboard: $refCode"),
                                  behavior: SnackBarBehavior.floating, // Hiển thị dạng nổi
                                  margin: EdgeInsets.only(top: 50, left: 0, right: 0), // Hiển thị ở trên
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: Text(
                            refCode ?? "Loading...", // Hiển thị refCode
                            style: TextStyle(
                              fontSize: 16, // Chữ nhỏ hơn
                              fontStyle: FontStyle.italic, // In nghiêng
                              color: Colors.grey, // Màu xám
                              fontFamily: "dmsans",
                            ),
                          ),
                        ),
                      ],
                    ),


                    SizedBox(height: 24,),
                    Expanded(
                      child: referrals.isEmpty
                          ? Center(
                        child: Text(
                          "No referrals found",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      )
                          : ListView.separated(
                        padding: EdgeInsets.only(bottom: 16), // Tránh bị che bởi bottom navigation
                        itemCount: referrals.length,
                        separatorBuilder: (context, index) => SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final referral = referrals[index];

                          return Container(
                            width: Get.width,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: inputFieldBackgroundColor2.value,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(width: 1, color: inputFieldBackgroundColor.value),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        referral['accountName'] ?? "Unknown", // Tránh lỗi null
                                        style: TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontFamily: "dmsans",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  "\$${(referral['sales'] ?? 0).toStringAsFixed(2)}", // Tránh lỗi null
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontFamily: "dmsans",
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                    ,

                    SizedBox(height: 40,),

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
