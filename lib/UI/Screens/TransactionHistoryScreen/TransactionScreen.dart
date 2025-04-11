import 'dart:convert';

import 'package:crypto_wallet/UI/Screens/TransactionHistoryScreen/transactionHistoryDetails.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:crypto_wallet/services/apiService.dart';
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
      dynamic dataTransactions;

      if (widget.symbol == "BNB" || widget.symbol == "EFT" || widget.symbol == "USDT") {
        final response = await fetchTransactionHistory(savedWalletAddress, symbolConverted);
        dataTransactions = json.decode(response);
      } else {
        final response = await ApiService.fetchTransactions(savedWalletAddress, widget.symbol);
        dataTransactions = response;
      }

      List tempTransactions = (widget.symbol == "BNB" || widget.symbol == "EFT" || widget.symbol == "USDT")
          ? dataTransactions['result'] ?? [] // Dữ liệu BTC đã là mảng trực tiếp
          : dataTransactions;

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

  String formatTimestampXRP(dynamic timestamp) {
    try {
      // Xử lý cả số nguyên và chuỗi số
      int timeInSeconds = timestamp is String
          ? int.tryParse(timestamp) ?? 0
          : timestamp as int;

      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeInSeconds * 1000);
      return DateFormat("dd MMM yyyy  hh:mm:ss a").format(dateTime);
    } catch (e) {
      print("Lỗi định dạng thời gian: $e");
      return "Invalid Date";
    }
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
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                size: 20,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Thêm logic back ở đây nếu cần
                                Get.back();
                              },
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                          ),
                          Text(
                            "${getTranslated(context, "Transactions") ?? "Transactions"}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700, // Độ đậm tăng lên 700
                              color: Colors.white, // Đổi màu thành trắng
                              fontFamily: "dmsans",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 22,),

                      if (widget.symbol == "BNB" || widget.symbol == "USDT" || widget.symbol == "EFT")
                        bscTransactions()
                      else if (widget.symbol == "BTC")
                        btcTransactions()
                      else if (widget.symbol == "XRP")
                        xrpTransactions()
                      else if (widget.symbol == "ETH")
                        ethTransactions()
                      else if (widget.symbol == "TON")
                        tonTransactions()
                      else
                        Text("Unsupported symbol"),
                    ],
                  ),
                ),

              ],
            ),
        ),
      ),
    );
  }

  Widget tonTransactions() {
    return Expanded(
      child: ListView.separated(
        itemCount: transaction.length,
        padding: const EdgeInsets.only(bottom: 20),
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 12);
        },
        itemBuilder: (BuildContext context, int index) {
          final tx = transaction[index];
          return GestureDetector(
            onTap: () {
              // Xử lý khi click vào transaction
            },
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: inputFieldBackgroundColor2.value,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      width: 1,
                      color: inputFieldBackgroundColor.value
                  )
              ),
              child: Column(
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tx['type'] ?? 'Transaction',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: darkBlueColor.value,
                          fontFamily: "dmsans",
                        ),
                      ),
                      Container(
                        height: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: _getTonStatusColor(tx['status']),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            tx['status'],
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
                  const SizedBox(height: 12),
                  // Address Section
                  _buildAddressRow(
                    label: tx['type'] == 'Incoming' ? 'From' : 'To',
                    address: tx['type'] == 'Incoming' ? tx['from'] : tx['to'],
                  ),
                  const SizedBox(height: 12),
                  // Details Section
                  Column(
                    children: [
                      _buildDetailRow(
                        label: "${getTranslated(context, "Amount") ?? "Amount"}",
                        value: "${tx['amount'].toStringAsFixed(2)} TON",
                        context: context,
                      ),
                      // _buildDetailRow(
                      //   label: "${getTranslated(context, "Fee") ?? "Fee"}",
                      //   value: "${tx['fee'].toStringAsFixed(6)} TON",
                      //   context: context,
                      // ),
                      _buildDetailRow(
                        label: "${getTranslated(context, "Date") ?? "Date"}",
                        value: _formatTonTimestamp(tx['timestamp']),
                        context: context,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

// Helper Functions
  Color _getTonStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'success':
        return const Color(0xff0FC085);
      case 'failed':
        return const Color(0xffFF1100);
      default:
        return const Color(0xFFFFD700);
    }
  }

  String _formatTonTimestamp(dynamic timestamp) {
    try {
      if (timestamp is int) {
        final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
        return DateFormat('dd/MM/yyyy HH:mm').format(date);
      }
      return "Invalid Date";
    } catch (e) {
      return "Invalid Date";
    }
  }

  Widget _buildAddressRow({required String label, required String address}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: lightTextColor.value,
            fontFamily: "dmsans",
          ),
        ),
        Expanded(
          child: Text(
            _shortenTonAddress(address),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: lightTextColor.value,
              fontFamily: "dmsans",
            ),
          ),
        ),
      ],
    );
  }

  String _shortenTonAddress(String address) {
    if (address.length > 15) {
      return '${address.substring(0, 6)}...${address.substring(address.length - 6)}';
    }
    return address;
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: lightTextColor.value,
              fontFamily: "dmsans",
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: headingColor.value,
              fontFamily: "dmsans",
            ),
          ),
        ],
      ),
    );
  }

  Widget bscTransactions() {
    return Expanded(
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
    );
  }

  Widget btcTransactions() {
    return Expanded(
      child: ListView.separated(
        itemCount: transaction.length,
        padding: EdgeInsets.only(bottom: 20),
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 12);
        },
        itemBuilder: (BuildContext context, int index) {
          final tx = transaction[index];
          return GestureDetector(
            onTap: () {
              // Get.to(TransactionHistoryDetails(type: "${tx['role']}"));
            },
            child: Container(
              width: Get.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: inputFieldBackgroundColor2.value,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1, color: inputFieldBackgroundColor.value),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tx['role'],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: darkBlueColor.value,
                          fontFamily: "dmsans",
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 20,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: _getStatusColor(tx['status']),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                tx['status'],
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
                  SizedBox(height: 7),
                  Divider(color: inputFieldBackgroundColor.value, height: 1, thickness: 1),
                  SizedBox(height: 3),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${getTranslated(context, "Amount") ?? "Amount"}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: lightTextColor.value,
                              fontFamily: "dmsans",
                            ),
                          ),
                          Text(
                            "${getTranslated(context, "Date") ?? "Date"}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: lightTextColor.value,
                              fontFamily: "dmsans",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                tx['valueInBTC'].toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: headingColor.value,
                                  fontFamily: "dmsans",
                                ),
                              ),
                              Text(
                                " BTC",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: lightTextColor.value,
                                  fontFamily: "dmsans",
                                ),
                              ),
                            ],
                          ),
                          Text(
                            formatTimestamp(tx['confirmedTime'].toString()),
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
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed' || 'success':
        return Color(0xff0FC085);
      case 'pending':
        return Color(0xFFFFD700);
      default:
        return Color(0xffFF1100);
    }
  }

  Widget xrpTransactions() {
    return Expanded(
      child: ListView.separated(
        itemCount: transaction.length,
        padding: EdgeInsets.only(bottom: 20),
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 12);
        },
        itemBuilder: (BuildContext context, int index) {
          final tx = transaction[index];
          return GestureDetector(
            onTap: () {
              // Xử lý khi click vào transaction
            },
            child: Container(
              width: Get.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: inputFieldBackgroundColor2.value,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1, color: inputFieldBackgroundColor.value),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tx['type'] ?? 'Unknown',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: darkBlueColor.value,
                          fontFamily: "dmsans",
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 20,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: _getStatusColor(tx['status']),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                tx['status'],
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
                  SizedBox(height: 7),
                  Divider(color: inputFieldBackgroundColor.value, height: 1, thickness: 1),
                  SizedBox(height: 3),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${getTranslated(context, "Amount") ?? "Amount"}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: lightTextColor.value,
                              fontFamily: "dmsans",
                            ),
                          ),
                          Text(
                            "${getTranslated(context, "Date") ?? "Date"}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: lightTextColor.value,
                              fontFamily: "dmsans",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                _convertDropsToXRP(tx['amount']),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: headingColor.value,
                                  fontFamily: "dmsans",
                                ),
                              ),
                              Text(
                                " XRP",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: lightTextColor.value,
                                  fontFamily: "dmsans",
                                ),
                              ),
                            ],
                          ),
                          Text(
                            formatTimestampXRP(tx['timestamp']),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: headingColor.value,
                              fontFamily: "dmsans",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      _buildDestinationInfo(tx['destination'], tx['destination_tag']),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

// Hàm chuyển đổi drops sang XRP
  String _convertDropsToXRP(String drops) {
    try {
      double amount = double.parse(drops);
      return (amount / 1000000).toStringAsFixed(2);
    } catch (e) {
      return "0.00";
    }
  }

// Hàm hiển thị thông tin destination
  Widget _buildDestinationInfo(String destination, dynamic tag) {
    return Row(
      children: [
        Text(
          "To: ",
          style: TextStyle(
            fontSize: 12,
            color: lightTextColor.value,
          ),
        ),
        Expanded(
          child: Text(
            _shortenAddress(destination),
            style: TextStyle(
              fontSize: 12,
              color: lightTextColor.value,
            ),
          ),
        ),
        if (tag != null && tag != -1)
          Text(
            "Tag: $tag",
            style: TextStyle(
              fontSize: 12,
              color: lightTextColor.value,
            ),
          ),
      ],
    );
  }

  Widget ethTransactions() {
    return Expanded(
      child: ListView.separated(
        itemCount: transaction.length,
        padding: EdgeInsets.only(bottom: 20),
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 12);
        },
        itemBuilder: (BuildContext context, int index) {
          final tx = transaction[index];
          return GestureDetector(
            onTap: () {
              // Get.to(TransactionHistoryDetails(type: tx['type']));
            },
            child: Container(
              width: Get.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: inputFieldBackgroundColor2.value,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      width: 1,
                      color: inputFieldBackgroundColor.value
                  )
              ),
              child: Column(
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tx['to'].toLowerCase() == walletAddress!.toLowerCase()
                            ? "Received"
                            : "Sent",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: darkBlueColor.value,
                          fontFamily: "dmsans",
                        ),
                      ),
                      Row(
                        children: [
                          // Address Info
                          if (tx['to'] != walletAddress)
                            Row(
                              children: [
                                Text(
                                  "To: ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: lightTextColor.value,
                                    fontFamily: "dmsans",
                                  ),
                                ),
                                Text(
                                  _shortenAddress(tx['to']),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: lightTextColor.value,
                                    fontFamily: "dmsans",
                                  ),
                                ),
                              ],
                            ),
                          if (tx['to'] == walletAddress)
                            Row(
                              children: [
                                Text(
                                  "From: ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: lightTextColor.value,
                                    fontFamily: "dmsans",
                                  ),
                                ),
                                Text(
                                  _shortenAddress(tx['from']),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: lightTextColor.value,
                                    fontFamily: "dmsans",
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(width: 10),
                          // Status Badge
                          Container(
                            height: 20,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: _getEthStatusColor(tx['status']),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                _getStatusText(tx['status']),
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
                  SizedBox(height: 7),
                  Divider(
                    color: inputFieldBackgroundColor.value,
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(height: 3),
                  // Details Section
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${getTranslated(context, "Amount") ?? "Amount"}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: lightTextColor.value,
                              fontFamily: "dmsans",
                            ),
                          ),
                          Text(
                            "${getTranslated(context, "Date") ?? "Date"}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: lightTextColor.value,
                              fontFamily: "dmsans",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Amount
                          Row(
                            children: [
                              Text(
                                formatEthValue(tx['value']),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: headingColor.value,
                                  fontFamily: "dmsans",
                                ),
                              ),
                              Text(
                                " ETH",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: lightTextColor.value,
                                  fontFamily: "dmsans",
                                ),
                              ),
                            ],
                          ),
                          // Date
                          Text(
                            formatEthTimestamp(tx['timestamp']),
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
    );
  }

// Helper Functions
  Color _getEthStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'success':
        return Color(0xff0FC085);
      case 'pending':
        return Color(0xFFFFD700);
      default:
        return Color(0xffFF1100);
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'success':
        return "Completed";
      case 'pending':
        return "Pending";
      default:
        return "Failed";
    }
  }

  String formatEthValue(dynamic value) {
    if (value is num) {
      return value.toStringAsFixed(4);
    }
    return '0.0000';
  }

  String formatEthTimestamp(dynamic timestamp) {
    try {
      final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return DateFormat('dd/MM/yyyy HH:mm').format(date);
    } catch (e) {
      return "Invalid Date";
    }
  }
}


