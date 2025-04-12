import 'dart:convert';

import 'package:crypto_wallet/UI/Screens/TransactionHistoryScreen/transactionHistoryDetails.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/wallet_provider.dart';
import '../../../services/apiService.dart';
import '../../../utils/get_balances.dart';
class RewardHistoryScreen extends StatefulWidget {
  const RewardHistoryScreen({super.key});  // Sử dụng required để đảm bảo symbol được truyền vào

  @override
  State<RewardHistoryScreen> createState() => _RewardHistoryScreenState();
}

class _RewardHistoryScreenState extends State<RewardHistoryScreen> {
  List transaction=[];
  bool isLoading = true; // Thêm state loading
  String? walletAddress;

  @override
  void initState() {
    super.initState();
    _loadWalletData();
  }

  String formatTotalBalance(String balance) {
    try {
      double value = double.parse(balance);

      // Nếu số bằng 0, trả về "0"
      if (value == 0) {
        return "0.00";
      }

      // Nếu số nhỏ hơn 0.0001 thì giữ lại 7 chữ số thập phân (không có dấu `,`)
      if (value < 0.00001) {
        return NumberFormat("0.00", "en_US").format(value);
      }

      // Nếu số lớn hơn 0.0001, hiển thị có dấu `,` ngăn cách nghìn, triệu
      return NumberFormat("#,##0.#####", "en_US").format(value);
    } catch (e) {
      return "Invalid balance";
    }
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
      dynamic dataTransactions = await ApiService.getRewardHistory(savedWalletAddress);
      print(dataTransactions);

      // Cập nhật danh sách coins với dữ liệu thực
      setState(() {
        transaction = dataTransactions;
        isLoading = false; // Kết thúc loading
        walletAddress = savedWalletAddress;
      });
    } catch (e) {
      setState(() => isLoading = false); // Đảm bảo tắt loading khi có lỗi
    }
  }

  String _shortenAddress(String address) {
    if (address.length > 20) {
      return address.substring(0, 7) + "..." + address.substring(address.length - 7);
    }
    return address; // Trả lại nguyên nếu địa chỉ nhỏ hơn hoặc bằng 20 ký tự
  }

  String formatTimestamp(String timestamp) {
    try {
      // Chuyển timestamp từ String sang int (timestamp của API là giây)
      int timeInSeconds = int.parse(timestamp);
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeInSeconds * 1000);

      // Định dạng ngày giờ mong muốn
      String formattedDate = DateFormat("dd MMM yyyy  hh:mm:ss a").format(dateTime);
      return formattedDate;
    } catch (e) {
      return "Invalid Date"; // Xử lý lỗi nếu có
    }
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22,vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "${getTranslated(context,"Transactions" )??"Transactions"}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: "dmsans",

                            ),

                          ),
                        ],
                      ),
                      SizedBox(height: 22,),

                      Expanded(
                        child: ListView.separated(
                          itemCount: transaction.length,
                          padding: EdgeInsets.only(bottom: 20),
                          separatorBuilder: (BuildContext context, int index) {
                            return  SizedBox(height: 12,);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return   GestureDetector(
                              onTap: (){
                                // Get.to(TransactionHistoryDetails(type:   "${transaction[index]['type']}",));
                              },
                              child: Container(
                                // height: 100,
                                width: Get.width,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade800.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          transaction[index]['to'] == walletAddress ? "Received" : "Sent",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.greenAccent,
                                            fontFamily: "dmsans",
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            if(transaction[index]['to'] != walletAddress)
                                              Row(
                                                children: [
                                                  Text(
                                                    "To: ",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      color: lightTextColor.value,
                                                      fontFamily: "dmsans",
                                                    ),
                                                  ),
                                                  Text(
                                                    _shortenAddress(transaction[index]['to']),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      color: lightTextColor.value,
                                                      fontFamily: "dmsans",
                                                    ),

                                                  ),
                                                ],
                                              ),
                                            if(transaction[index]['to'] == walletAddress)
                                              Row(
                                                children: [
                                                  Text(
                                                    "",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      color: lightTextColor.value,
                                                      fontFamily: "dmsans",
                                                    ),
                                                  ),
                                                  Text(
                                                    // _shortenAddress("transaction[index]['from']"),
                                                    "",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      color: lightTextColor.value,
                                                      fontFamily: "dmsans",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            SizedBox(width: 10,),
                                            Container(
                                              height: 20,
                                              padding: EdgeInsets.symmetric(horizontal: 12),
                                              decoration: BoxDecoration(
                                                color: transaction[index]['status'].toString() == "1"
                                                  ? Color(0xff0FC085) // Completed (Green)
                                                      : (transaction[index]['status'].toString() == "0"
                                                  ? Color(0xFFFFD700) // Pending (Yellow)
                                                      : Colors.redAccent),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child:
                                                Text(
                                                  transaction[index]['status'].toString() == "1" ? "Completed" : (transaction[index]['status'].toString() == "0" ? "Pending" : "Rejected"),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w600,
                                                    color: primaryBackgroundColor.value,
                                                    fontFamily: "dmsans",
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 7,),
                                    Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 1,),
                                    SizedBox(height: 3,),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${getTranslated(context,"Amount" )??"Amount"}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontFamily: "dmsans",
                                              ),
                                            ),
                                            Text(
                                              "${getTranslated(context,"Date" )??"Date"}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontFamily: "dmsans",
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  formatTotalBalance(transaction[index]['value']).toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    fontFamily: "dmsans",
                                                  ),
                                                ),
                                                Text(
                                                  "  ${transaction[index]['tokenName']}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    fontFamily: "dmsans",
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              transaction[index]['timeStamp'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontFamily: "dmsans",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
        ),
      ),
    );
  }
}
