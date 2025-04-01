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
import '../../../utils/get_balances.dart';
class TransactionScreen extends StatefulWidget {
  final String symbol;  // Thêm biến này để nhận symbol từ màn hình trước

  const TransactionScreen({super.key, required this.symbol});  // Sử dụng required để đảm bảo symbol được truyền vào

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List transaction=[];
  bool isLoading = true; // Thêm state loading
  String? walletAddress;
  late String symbolConverted;  // Định nghĩa biến mới

  @override
  void initState() {
    super.initState();
    symbolConverted = widget.symbol.toUpperCase();  // Chuyển symbol thành chữ hoa
    _loadWalletData();
  }


  double parseNanoBalance(String nanoBalance) {
    try {
      double balance = double.tryParse(nanoBalance) ?? 0.0;
      return balance / 1000000000000000000;  // Chia cho 10^18 để chuyển đổi từ wei sang BNB
    } catch (e) {
      return 0.0;
    }
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
      String responseTransactionHistory = await fetchTransactionHistory(savedWalletAddress, symbolConverted);
      dynamic dataTransactions = json.decode(responseTransactionHistory);
      List tempTransactions = dataTransactions['result'] ?? null;

      // Cập nhật danh sách coins với dữ liệu thực
      setState(() {
        transaction = tempTransactions;
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor.value,
      body: SafeArea(
        child: isLoading ? Center(
            child: CircularProgressIndicator(
            color: primaryColor.value,
            ),
          )
        :  Padding(
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
                      color: darkBlueColor.value,
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
                        Get.to(TransactionHistoryDetails(type:   "${transaction[index]['type']}",));
                      },
                      child: Container(
                        // height: 100,
                        width: Get.width,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: inputFieldBackgroundColor2.value,
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
                                    color: darkBlueColor.value,
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
                                            "From: ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: lightTextColor.value,
                                              fontFamily: "dmsans",
                                            ),
                                          ),
                                          Text(
                                            _shortenAddress(transaction[index]['from']),
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
                                      color: symbolConverted == "BNB"
                                      ? (transaction[index]['txreceipt_status'].toString() == "1"
                                      ? Color(0xff0FC085) // Completed (Green)
                                          : (transaction[index]['txreceipt_status'].toString() == "0"
                                      ? Color(0xFFFFD700) // Pending (Yellow)
                                          : Color(0xffFF1100) // Rejected (Red)
                                      )
                                      ): (
                                      (transaction[index]['confirmations'] is int
                                      ? transaction[index]['confirmations']
                                          : int.tryParse(transaction[index]['confirmations'].toString()) ?? 0) > 30
                                      ? Color(0xff0FC085) // Completed (Green)
                                          : Color(0xFFFFD700) // Pending (Yellow)
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                        child: Text(
                                          symbolConverted == "BNB"
                                              ? (transaction[index]['txreceipt_status'].toString() == "1"
                                              ? "Completed"
                                              : (transaction[index]['txreceipt_status'].toString() == "0"
                                              ? "Pending"
                                              : "Rejected"))
                                              : (
                                              (transaction[index]['confirmations'] is int
                                                  ? transaction[index]['confirmations']
                                                  : int.tryParse(transaction[index]['confirmations'].toString()) ?? 0) > 30
                                                  ? "Completed"
                                                  : "Pending (${transaction[index]['confirmations']}/30)"
                                          ),
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
                                        color: lightTextColor.value,
                                        fontFamily: "dmsans",
                                      ),
                                    ),
                                    Text(
                                      "${getTranslated(context,"Date" )??"Date"}",
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
                                SizedBox(height: 3,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          formatTotalBalance(parseNanoBalance(transaction[index]['value']).toString()),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: headingColor.value,
                                            fontFamily: "dmsans",
                                          ),
                                        ),
                                        Text(
                                          symbolConverted == "BNB"
                                              ? "  $symbolConverted"
                                              : "  ${transaction[index]['tokenName']}", // Nếu là USDT thì lấy tokenName từ transaction[index]
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: symbolConverted == "BNB"
                                                ? 12
                                                : 10,
                                            fontWeight: FontWeight.w700,
                                            color: lightTextColor.value,
                                            fontFamily: "dmsans",
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      formatTimestamp(transaction[index]['timeStamp']),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: headingColor.value,
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
      ),
    );
  }
}
