import 'dart:convert';

import 'package:crypto_wallet/UI/common_widgets/bottomRectangularbtn.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

import '../../../providers/wallet_provider.dart';
import '../../../utils/get_balances.dart';
import '../../common_widgets/inputField.dart';
class StakingScreen extends StatefulWidget {
  const StakingScreen({super.key});

  @override
  State<StakingScreen> createState() => _StakingScreenState();
}

class _StakingScreenState extends State<StakingScreen> {
  AppController appController=Get.find<AppController>();
  TextEditingController cycleController = TextEditingController(text: "30 days");
  int indexSelected = 0;
  bool isLoading = false;
  TextEditingController interestController = TextEditingController();
  TextEditingController amountContoller = TextEditingController();
  String? walletAddress;
  String? privateKey;
  List coins=[];

  void stakingExecute() {

    print("Wallet Address: ${walletAddress}");
    print("Symbol: ${coins[indexSelected]['symbol']}");
    print("Price: ${coins[indexSelected]['price']}");
    print("Amount: ${amountContoller.text}");
  }

  String _getTotalBalance() {
    try {
      double amount = double.parse(amountContoller.text.isEmpty ? "0" : amountContoller.text);
      double price = double.parse(coins[indexSelected]['price'].toString());
      return formatTotalBalance((amount * price).toString());
    } catch (e) {
      return formatTotalBalance("0.0");
    }
  }

  void _onAmountChanged() {
    setState(() {}); // Khi text thay đổi, rebuild widget
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateInterestText();
    _loadWalletData();
    amountContoller.addListener(_onAmountChanged);
  }


  @override
  void dispose() {
    cycleController.dispose();
    amountContoller.removeListener(_onAmountChanged);
    super.dispose();
  }

  void _updateInterestText() {
    setState(() {
      if (!isLoading && coins.length > 0) {
        if (indexSelected == 2) {
          interestController.text = '0.2% (by EFT) per day';
        } else {
          interestController.text = '0.15% (by EFT) per day\n0.15% (by ${coins[indexSelected]['symbol']}) per day';
        }
      }
    });
  }

  Future<void> _loadWalletData() async {
    try {
      setState(() => isLoading = true);

      final walletProvider = Provider.of<WalletProvider>(context, listen: false);
      await walletProvider.loadPrivateKey();

      String? savedWalletAddress = await walletProvider.getWalletAddress();
      if (savedWalletAddress == null) {
        throw Exception("Can't get the wallet address");
      }

      String response = await getBalances(savedWalletAddress, 'bnb');
      dynamic data = json.decode(response);
      String newBalance = data['result'] ?? '0';

      String responseUsdt = await getBalances(savedWalletAddress, 'usdt');
      dynamic dataUsdt = json.decode(responseUsdt);
      String newUsdtBalance = dataUsdt['result'] ?? '0';

      String responseEft = await getBalances(savedWalletAddress, 'eft');
      dynamic dataEft = json.decode(responseEft);
      String newEftBalance = dataEft['result'] ?? '0';

      // Transform balance from wei to ether
      EtherAmount latestBalance =
      EtherAmount.fromBigInt(EtherUnit.wei, BigInt.parse(newBalance));
      String latestBalanceInEther =
      latestBalance.getValueInUnit(EtherUnit.ether).toString();

      EtherAmount latestBalanceUsdt =
      EtherAmount.fromBigInt(EtherUnit.wei, BigInt.parse(newUsdtBalance));
      String latestBalanceUsdtInEther =
      latestBalanceUsdt.getValueInUnit(EtherUnit.ether).toString();

      EtherAmount latestBalanceEft =
      EtherAmount.fromBigInt(EtherUnit.wei, BigInt.parse(newEftBalance));
      String latestBalanceEftInEther =
      latestBalanceEft.getValueInUnit(EtherUnit.ether).toString();

      String responseBNBPrice = await fetchBNBPrice();
      dynamic dataBNBPrice = json.decode(responseBNBPrice);
      String newBNBPrice = dataBNBPrice['price'] ?? '0';

      setState(() {
        coins = [
          {
            "image": "assets/images/bnb.png",
            "symbol": "BNB",
            "amount": latestBalanceInEther,
            "price": newBNBPrice,
            "chain": "",
            "name": "Binance Coin"
          },
          {
            "image": "assets/images/usdt.png",
            "symbol": "USDT",
            "amount": latestBalanceUsdtInEther,
            "price": "1.00",
            "chain": "",
            "name": "Tether USD"
          },
          {
            "image": "assets/images/eft.png",
            "symbol": "EFT",
            "amount": latestBalanceEftInEther,
            "price": "0.15",
            "chain": "",
            "name": "Ecofusion Token"
          },
        ];
        walletAddress = savedWalletAddress;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  String formatTotalBalance(String balance) {
    try {
      double value = double.parse(balance);

      if (value == 0) {
        return "0.00";
      }

      if (value < 0.0001) {
        return NumberFormat("0.00", "en_US").format(value);
      }

      return NumberFormat("#,##0.##", "en_US").format(value);
    } catch (e) {
      return "Invalid balance";
    }
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
                          "${getTranslated(context,"Staking" )??"Staking"}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: "dmsans",

                          ),

                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Expanded(
                      child: ListView(children: [
                        Stack(
                          children: [
                            Container(
                              height: 400,
                              width: Get.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 350,
                                    width: Get.width,
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: inputFieldBackgroundColor2.value,
                                        border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                                    ),
                                    child:Column(
                                      children: [
                                        InkWell(
                                          onTap:(){
                                            Get.bottomSheet(
                                                clipBehavior: Clip.antiAlias,
                                                isScrollControlled: true,
                                                backgroundColor: primaryBackgroundColor.value,
                                                shape: OutlineInputBorder(
                                                    borderSide: BorderSide.none, borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32))),
                                                selectToken());
                                          },
                                          child:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: primaryBackgroundColor.value
                                                    ),
                                                    child: Image.asset(coins[indexSelected]['image']),
                                                  ),
                                                  SizedBox(width: 10,),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "${coins[indexSelected]['symbol']}",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight: FontWeight.w600,
                                                          color: headingColor.value,
                                                          fontFamily: "dmsans",
                                                        ),
                                                      ),
                                                      Text(
                                                        "${getTranslated(context,"Available" )??"Available"}: ${coins[indexSelected]['amount']} ${coins[indexSelected]['symbol']}",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                          color: lightTextColor.value,
                                                          fontFamily: "dmsans",

                                                        ),

                                                      ),

                                                    ],
                                                  )
                                                ],
                                              ),

                                              Icon(Icons.keyboard_arrow_down_outlined,color: headingColor.value,size: 25,)
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 15,),
                                        Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 1,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: amountContoller,
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [
                                    if (indexSelected == 0)
                                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')) // Cho phép 3 số sau dấu thập phân
                                    else
                                      FilteringTextInputFormatter.digitsOnly // Chỉ cho phép số nguyên
                                  ],
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w700,
                                    color: headingColor.value,
                                    fontFamily: "dmsans",
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Enter staking amount",
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14
                                    ),
                                    isDense: true,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10), // Khoảng cách 10 đơn vị
                              Text(
                                // Kiểm tra và đảm bảo rằng amountController.text là một số hợp lệ
                                "\$ ${_getTotalBalance()}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: lightTextColor.value,
                                  fontFamily: "dmsans",
                                ),
                              ),
                            ],
                          ),


                      SizedBox(height: 15,),
                                        Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 1,),
                                        Row(
                                          children: [
                                            Text(
                                              "Cycle:",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontFamily: "dmsans",
                                              ),
                                            ),
                                            SizedBox(width: 8), // Thêm khoảng cách giữa text và input
                                            Expanded(
                                              child: TextFormField(
                                                controller: cycleController,
                                                enabled: false, // 🔒 Vô hiệu hóa hoàn toàn
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: "dmsans",
                                                ),
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                                  disabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: inputFieldBackgroundColor.value),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                              ),
                                            )

                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center, // Đảm bảo văn bản "Interest" căn chỉnh với đầu của input
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(top: 0),
                                              child: Align(
                                                alignment: Alignment.centerLeft, // Căn chỉnh "Interest" với bên trái của input
                                                child: Text(
                                                  "Interest:",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontFamily: "dmsans",
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.centerLeft, // Căn chỉnh "TextFormField" với bên trái
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    TextFormField(
                                                      controller: interestController,
                                                      enabled: false,
                                                      maxLines: indexSelected == 2 ? 1 : 2, // Allow for two lines of text
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontFamily: "dmsans",
                                                      ),
                                                      decoration: InputDecoration(
                                                        isDense: true,
                                                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                                        disabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: inputFieldBackgroundColor.value),
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 32), // Thêm khoảng cách giữa text và input
                                        Column(
                                          children: [
                                            SizedBox(height: 24,),
                                            BottomRectangularBtn(
                                                onTapFunc: (){
                                                  showConfirmDialog();
                                                }, btnTitle: "Staking"),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),


                      ],),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SizedBox(height: 70,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(height: 12,),
                        BottomRectangularBtn(onTapFunc: (){

                        }, btnTitle: "Interest History"),
                        SizedBox(height: 12,),
                      ],
                    )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectToken(){
    return Container(
      height: Get.height * 0.9,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      color: appController.isDark.value == true
          ? Color(0xff1A1930)
          : inputFieldBackgroundColor.value,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Choose Token",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: headingColor.value,
                  fontFamily: "dmsans",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.clear,
                  color: headingColor.value,
                ),
              )
            ],
          ),
          SizedBox(height: 16,),
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 23,
                      width: 113,
                      decoration: BoxDecoration(
                        color: appController.isDark.value == true
                            ? Color(0xff1A2B56)
                            : inputFieldBackgroundColor2.value,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          width: 1,
                          color: inputFieldBackgroundColor.value,
                        ),
                      ),
                    ),
                    Divider(
                      color: inputFieldBackgroundColor.value,
                      height: 1,
                      thickness: 2,
                    ),
                  ],
                ),
                SizedBox(height: 24,),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: coins.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 12,);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          indexSelected = index;
                          _updateInterestText();
                          amountContoller.text = "";

                          // Cập nhật chu kỳ tối thiểu khi chọn token
                          final minCycle = (indexSelected == 2) ? 30 : 30;
                          cycleController.text = minCycle.toString() + " days";
                        });
                        Get.back();
                      },
                      child: Container(
                        height: 60,
                        width: Get.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: inputFieldBackgroundColor2.value,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 1,
                            color: inputFieldBackgroundColor.value,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                "${coins[index]['image']}",
                                height: 40,
                                width: 40,
                              ),
                            ),
                            SizedBox(width: 12,),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${coins[index]['symbol']}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: appController.isDark.value == true
                                                      ? Color(0xffFDFCFD)
                                                      : primaryColor.value,
                                                  fontFamily: "dmsans",
                                                ),
                                              ),
                                              Text(
                                                "${coins[index]['amount']}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: appController.isDark.value == true
                                                      ? Color(0xffFDFCFD)
                                                      : primaryColor.value,
                                                  fontFamily: "dmsans",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${coins[index]['name']}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: lightTextColor.value,
                                                  fontFamily: "dmsans",
                                                ),
                                              ),
                                              Text(
                                                "\$ ${formatTotalBalance(
                                                  (double.parse(coins[index]['amount'].toString()) *
                                                      double.parse(coins[index]['price'].toString()))
                                                      .toString(),
                                                )}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: lightTextColor.value,
                                                  fontFamily: "dmsans",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
          ),
        ],
      ),
    );
  }


  Widget selectDuration(){
    return Container(
      height: Get.height*0.9,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 22,vertical: 22),
      color:appController.isDark.value==true ?Color(0xff1A1930):inputFieldBackgroundColor.value,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Choose Token",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: headingColor.value,
                  fontFamily: "dmsans",

                ),
              ),
              GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.clear,color: headingColor.value,))
            ],
          ),
          SizedBox(height: 16,),
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 16,),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 23,
                      width: 113,
                      decoration: BoxDecoration(
                          color:appController.isDark.value==true ?Color(0xff1A2B56):  inputFieldBackgroundColor2.value,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(width: 1,color: inputFieldBackgroundColor.value)

                      ),
                    ),
                    Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 2,),

                  ],
                ),
                SizedBox(height: 24,),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),

                  itemCount: coins.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 12,);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return  GestureDetector(
                      onTap: (){
                        setState(() {
                          indexSelected = index; // ✅ CẬP NHẬT INDEX
                        });
                        Get.back();
                      },
                      child: Container(
                        height:60,
                        width: Get.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: inputFieldBackgroundColor2.value,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                        ),
                        child: Row(
                          children: [
                            Container(
                                height:32,
                                width: 32,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle
                                ),
                                child: Image.asset("${coins[index]['image']}",height: 40,width: 40,)),

                            SizedBox(width: 12,),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Text(
                                                "${coins[index]['symbol']}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color:appController.isDark.value==true?Color(0xffFDFCFD):  primaryColor.value,
                                                  fontFamily: "dmsans",

                                                ),

                                              ),

                                              Text(
                                                "${coins[index]['amount']}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color:appController.isDark.value==true?Color(0xffFDFCFD):  primaryColor.value,
                                                  fontFamily: "dmsans",

                                                ),

                                              ),

                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Text(
                                                "${coins[index]['name']}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: lightTextColor.value,
                                                  fontFamily: "dmsans",

                                                ),

                                              ),

                                              Text(
                                                "\$ ${coins[index]['price']}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 12,
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
          // SizedBox(height: 16,),







        ],
      ),
    );
  }

  Widget confirmSwap() {
    return AlertDialog(
      // Cài đặt giao diện của Dialog
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Column(
        children: [
          // Nếu cần tiêu đề cho dialog, có thể thêm ở đây
          Text(
            'Confirm Staking',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Nội dung chính của dialog
          Text(
            'Are you sure you want to confirm the staking?',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          BottomRectangularBtn(
            onTapFunc: () {
              stakingExecute(); // Xử lý khi xác nhận staking
              Get.back(); // Đóng dialog
              Get.bottomSheet(
                swapCompleted(), // Widget hiển thị khi staking xong
                clipBehavior: Clip.antiAlias,
                isScrollControlled: true,
                isDismissible: true, // ✅ Cho phép tap ra ngoài để đóng
                enableDrag: true, // ✅ Cho phép vuốt xuống để đóng
                backgroundColor: Colors.grey,
                shape: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(32),
                    topLeft: Radius.circular(32),
                  ),
                ),
              );
            },
            btnTitle: "Confirm Staking",
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Get.back(); // Đóng dialog khi nhấn Cancel
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      actions: [],
    );
  }

  void showConfirmDialog() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return confirmSwap(); // Hiển thị dialog
      },
    );
  }


  Widget swapCompleted(){
    return Container(
      // height: 430,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 22,vertical: 22),
      color: inputFieldBackgroundColor.value,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 120,
            width: 120,
            padding: EdgeInsets.all(17),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: inputFieldBackgroundColor2.value
            ),
            child:appController.isDark.value==true?
            SvgPicture.asset("assets/svgs/arrow-circle (2).svg"):
            SvgPicture.asset("assets/svgs/arrow-circle.svg"),
          ),
          SizedBox(height: 32,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${getTranslated(context,"Staking completed" )??"Staking completed"}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: headingColor.value,
                  fontFamily: "dmsans",

                ),
              ),
            ],
          ),


          SizedBox(height: 3,),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '${getTranslated(context,"You just stake" )??"You just stake"}',
              style: TextStyle(fontSize: 14, color: lightTextColor.value, fontFamily: 'Spectral', fontWeight: FontWeight.w400),
              children: <TextSpan>[
                TextSpan(
                  text: ' 0.5 SOL ',
                  style: TextStyle(fontSize: 13, color: headingColor.value, fontFamily: 'dmsans', fontWeight: FontWeight.w600),
                ),
                TextSpan(text: '${getTranslated(context,"to get" )??"to get"}'),
                TextSpan(
                  text: ' 8.3 ETH ',
                  style: TextStyle(fontSize: 13, color: headingColor.value, fontFamily: 'dmsans', fontWeight: FontWeight.w600),
                ),

                TextSpan(text: '${getTranslated(context,"successfully." )??"successfully."}'),
              ],
            ),
          ),
          SizedBox(height: 32,),



          BottomRectangularBtn(onTapFunc: (){

            Get.back();
            Get.back();
            // Get.to(TransactionScreen());
          } ,btnTitle: "View History"),
        ],
      ),
    );
  }
}
