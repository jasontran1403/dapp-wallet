import 'dart:convert';

import 'package:crypto_wallet/UI/common_widgets/bottomRectangularbtn.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:crypto_wallet/services/apiService.dart';
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
  AppController appController = Get.find<AppController>();
  TextEditingController cycleController = TextEditingController(text: "30 days");
  int indexSelected = 0;
  bool isLoading = false;
  List<bool> tokenLoadingStates = List.filled(7, false); // Match coinsUI length
  TextEditingController interestController = TextEditingController();
  TextEditingController amountContoller = TextEditingController();
  String? walletAddress;
  List<bool> claimLoadingStates = List.filled(9, false); // Giả sử có 9 items
// Thêm getter để kiểm tra xem có bất kỳ claim nào đang loading không
  bool get isAnyClaimLoading => claimLoadingStates.any((state) => state);
  String? privateKey;
  List internalBalances = [];
  dynamic currentCoin = {};
  List coinsUI = [
      {
      "image": "assets/images/bnb.png",
      "symbol": "BNB",
      "amount": 0,
      "price": 0,
      "chain": "",
      "name": "Binance Coin"
    },
    {
    "image": "assets/images/usdt.png",
    "symbol": "USDT",
    "amount": 0,
    "price": "1.00",
    "chain": "",
    "name": "Tether USD"
    },
    {
    "image": "assets/images/eft.png",
    "symbol": "EFT",
    "amount": 0,
    "price": "0.15",
    "chain": "",
    "name": "Ecofusion Token"
    },
    {
      "image": "assets/images/btc.png",
      "symbol": "BTC",
      "amount": 0,
      "price": "0.15",
      "chain": "",
      "name": "Bitcoin"
    },
    {
      "image": "assets/images/eth.png",
      "symbol": "ETH",
      "amount": 0,
      "price": "0.15",
      "chain": "",
      "name": "Ethereum"
    },
    {
      "image": "assets/images/xrp.png",
      "symbol": "XRP",
      "amount": 0,
      "price": "0.15",
      "chain": "",
      "name": "Ripple"
    },
    {
      "image": "assets/images/ton.png",
      "symbol": "TON",
      "amount": 0,
      "price": "0.15",
      "chain": "",
      "name": "TON Coin"
    },
  ];
  double? limitStaking = 0;

  Future<void> _loadInternalBalance(String walletInput) async {
    try {
      dynamic dataTemp  = await ApiService.getInternalBalance(walletInput);
      List data = dataTemp['result'] ?? null;

      setState(() {
        internalBalances = data;
      });
    } catch (e) {
      print(e);
    }
  }

  void stakingExecute() async {
    final input = amountContoller.text.trim();

    // Kiểm tra input rỗng hoặc không phải số hợp lệ
    if (input.isEmpty || double.tryParse(input) == null || double.parse(input) <= 0) {
      Get.back();
      Get.snackbar(
        "Error",
        "Staking amount must be greater than 0.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    String symbol = currentCoin['symbol'];
    double amount = double.parse(amountContoller.text);
    double price = double.parse(currentCoin['price']);
    int duration = 30;

    String result = await ApiService.staking(walletAddress!, symbol, amount, price, duration);

    Get.back();
    if (result.contains("successful")) {
      _loadTokenData(indexSelected, walletAddress!);

      Get.snackbar(
        "Success",
        result,
        backgroundColor: Colors.white,
        colorText: Colors.green,
      );
    } else {
      Get.snackbar(
        "Error",
        result,
        backgroundColor: Colors.white,
        colorText: Colors.redAccent,
      );
    }
  }

  Future<String> claimExecute(String walletAddressParam, String symbol) async {
    String result = await ApiService.withdrawInternal(walletAddressParam, symbol);

    return result;
  }

  String _getTotalBalance() {
    try {
      double amount = double.parse(amountContoller.text.isEmpty ? "0" : amountContoller.text);
      double price = double.parse(currentCoin['price'].toString());
      return formatTotalBalance((amount * price).toString());
    } catch (e) {
      return formatTotalBalance("0.0");
    }
  }

  void _onAmountChanged() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadWalletData();
    amountContoller.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    cycleController.dispose();
    amountContoller.removeListener(_onAmountChanged);
    super.dispose();
  }

  void initInterest() {
    interestController.text = '0.15% (by EFT) per day\n0.15% (by BNB) per day';
  }

  void _updateInterestText(int index, String symbol) {
    setState(() {
      if (!isLoading && currentCoin.containsKey("symbol")) {
        if (indexSelected == 2) {
          interestController.text = '0.2% (by EFT) per day';
        } else {
          interestController.text = '0.15% (by EFT) per day\n0.15% (by ${symbol}) per day';
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

      // Only load BNB data initially
      await _loadTokenData(0, savedWalletAddress);

      await _loadInternalBalance(savedWalletAddress);

      initInterest();

      setState(() {
        walletAddress = savedWalletAddress;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  String formatBalance(String balance) {
    try {
      double value = double.parse(balance);

      if (value == 0) {
        return "0";
      }

      if (value < 0.0001) {
        return NumberFormat("0.0000000", "en_US").format(value);
      }

      return NumberFormat("#,##0.######", "en_US").format(value);
    } catch (e) {
      return "Invalid balance";
    }
  }

  Future<void> _loadTokenData(int tokenIndex, String walletAddress) async {
    if (tokenIndex < 0 || tokenIndex >= coinsUI.length) return; // Update range check

    setState(() {
      tokenLoadingStates[tokenIndex] = true;
      limitStaking = 0;
    });

    String extractSymbol = coinsUI[tokenIndex]['symbol'] ?? '';

    try {
      dynamic response = await ApiService.fetchSingStatistic(walletAddress, extractSymbol);

      setState(() {
        currentCoin = response;
        limitStaking = response['stakingLeft'];
        tokenLoadingStates[tokenIndex] = false;
        _updateInterestText(tokenIndex, currentCoin['symbol']);
      });
    } catch (e) {
      setState(() {
        tokenLoadingStates[tokenIndex] = false;
        limitStaking = 0;
      });
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
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/background/bg7.png",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "${getTranslated(context, "Staking") ?? "Staking"}",
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
                    SizedBox(height: 16),
                    Expanded(
                      child: ListView(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 380,
                                width: Get.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 370,
                                      width: Get.width,
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: inputFieldBackgroundColor2.value,
                                        border: Border.all(width: 1, color: inputFieldBackgroundColor.value),
                                      ),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.bottomSheet(
                                                clipBehavior: Clip.antiAlias,
                                                isScrollControlled: true,
                                                backgroundColor: primaryBackgroundColor.value,
                                                shape: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(32),
                                                        topLeft: Radius.circular(32))),
                                                selectToken(),
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: primaryBackgroundColor.value),
                                                      child: currentCoin.containsKey("symbol")
                                                          ? Image.asset(currentCoin['image'])
                                                          : SizedBox(),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          currentCoin.containsKey("symbol")
                                                              ? "${currentCoin['symbol']}"
                                                              : "",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600,
                                                            color: headingColor.value,
                                                            fontFamily: "dmsans",
                                                          ),
                                                        ),
                                                        tokenLoadingStates[indexSelected]
                                                            ? SizedBox(
                                                          height: 14,
                                                          width: 14,
                                                          child: CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                            color: primaryColor.value,
                                                          ),
                                                        )
                                                            : Text(
                                                          "${getTranslated(context, "Available") ?? "Available"}: ${currentCoin.containsKey("symbol") ? currentCoin['amount'] : '0'} ${currentCoin.containsKey("symbol") ? currentCoin['symbol'] : ''}",
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
                                                Icon(Icons.keyboard_arrow_down_outlined,
                                                    color: headingColor.value, size: 25),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          Divider(
                                              color: inputFieldBackgroundColor.value,
                                              height: 1,
                                              thickness: 1),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  controller: amountContoller,
                                                  keyboardType:
                                                  TextInputType.numberWithOptions(decimal: true),
                                                  inputFormatters: [
                                                    if (indexSelected == 0)
                                                      FilteringTextInputFormatter.allow(
                                                          RegExp(r'^\d*\.?\d{0,3}'))
                                                    else
                                                      FilteringTextInputFormatter.digitsOnly
                                                  ],
                                                  style: TextStyle(
                                                    fontSize: 36,
                                                    fontWeight: FontWeight.w700,
                                                    color: headingColor.value,
                                                    fontFamily: "dmsans",
                                                  ),
                                                  decoration: InputDecoration(
                                                    hintText: "Enter staking amount",
                                                    hintStyle:
                                                    TextStyle(color: Colors.grey, fontSize: 14),
                                                    isDense: true,
                                                    border: InputBorder.none,
                                                    contentPadding: EdgeInsets.zero,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
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
                                          SizedBox(height: 15),
                                          Divider(
                                              color: inputFieldBackgroundColor.value,
                                              height: 1,
                                              thickness: 1),
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
                                              SizedBox(width: 8),
                                              Expanded(
                                                child: TextFormField(
                                                  controller: cycleController,
                                                  enabled: false,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: "dmsans",
                                                  ),
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                                    disabledBorder: OutlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: inputFieldBackgroundColor.value),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: 0),
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
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
                                                  alignment: Alignment.centerLeft,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      TextFormField(
                                                        controller: interestController,
                                                        enabled: false,
                                                        maxLines: indexSelected == 2 ? 1 : 2,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontFamily: "dmsans",
                                                        ),
                                                        decoration: InputDecoration(
                                                          isDense: true,
                                                          contentPadding: EdgeInsets.symmetric(
                                                              horizontal: 12, vertical: 8),
                                                          disabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: inputFieldBackgroundColor.value),
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
                                          SizedBox(width: 32),
                                          if (currentCoin['symbol'] != "EFT")
                                            Row(
                                              children: [
                                                Text(
                                                  "Limit staking left: ",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.redAccent,
                                                    fontStyle: FontStyle.italic,
                                                    fontFamily: "dmsans",
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  "\$ ${limitStaking ?? 'Loading'}",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.redAccent,
                                                    fontStyle: FontStyle.italic,
                                                    fontFamily: "dmsans",
                                                  ),
                                                ),
                                              ],
                                            ),

                                          SizedBox(width: 32),
                                          Column(
                                            children: [
                                              SizedBox(height: 24),
                                              BottomRectangularBtn(
                                                  onTapFunc: () {
                                                    if (!isAnyClaimLoading) {
                                                      showConfirmDialog();
                                                    }
                                                  },
                                                  btnTitle: "Staking"),
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
                        ],
                      ),
                    ),

                    // Trong phần build, thay thế phần hiển thị internalBalances trước đó bằng:
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: inputFieldBackgroundColor2.value,
                        border: Border.all(color: inputFieldBackgroundColor.value),
                      ),
                      constraints: BoxConstraints(maxHeight: 340), // Giới hạn chiều cao tối đa
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "Staking Rewards",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: headingColor.value,
                              ),
                            ),
                          ),
                          Divider(height: 1, color: inputFieldBackgroundColor.value),
                          Expanded(
                            child: ListView.separated(
                              itemCount: internalBalances.length,
                              separatorBuilder: (_, __) => Divider(
                                height: 1,
                                color: inputFieldBackgroundColor.value,
                              ),
                              itemBuilder: (context, index) {
                                final token = internalBalances[index];

                                return KeyedSubtree(
                                  key: ValueKey(token['symbol']), // hoặc ValueKey(index)
                                  child: _buildBalanceItem(
                                    image: token['image']!,
                                    symbol: token['symbol']!,
                                    name: token['name']!,
                                    balance: token['amount'].toString(),
                                    index: index,
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

              if (isLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: primaryColor.value,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectToken() {
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
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 16),
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
                SizedBox(height: 24),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: coinsUI.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 12);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        // Load data for the selected token if not already loaded
                        if (coinsUI[index]['amount'] == null || tokenLoadingStates[index]) {
                          return;
                        }

                        setState(() {
                          if (indexSelected != index) _loadTokenData(index, walletAddress!);
                          indexSelected = index;

                          _updateInterestText(index, currentCoin['symbol']);
                          amountContoller.text = "";
                          cycleController.text = "30 days";
                        });

                        // Load data for the selected token if needed
                        if (coinsUI[index]['amount'] == null) {
                          await _loadTokenData(index, walletAddress!);
                        }

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
                                "${coinsUI[index]['image']}",
                                height: 40,
                                width: 40,
                              ),
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
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${coinsUI[index]['symbol']}",
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
                                                "",
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
                                                "${coinsUI[index]['name']}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: lightTextColor.value,
                                                  fontFamily: "dmsans",
                                                ),
                                              ),
                                              Text(
                                                "",
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

  Widget confirmSwap() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Column(
        children: [
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
              stakingExecute();
            },
            btnTitle: "Confirm Staking",
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Get.back();
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
        return confirmSwap();
      },
    );
  }

  Widget swapCompleted() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      color: inputFieldBackgroundColor.value,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 120,
            width: 120,
            padding: EdgeInsets.all(17),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: inputFieldBackgroundColor2.value),
            child: appController.isDark.value == true
                ? SvgPicture.asset("assets/svgs/arrow-circle (2).svg")
                : SvgPicture.asset("assets/svgs/arrow-circle.svg"),
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${getTranslated(context, "Staking completed") ?? "Staking completed"}",
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
          SizedBox(height: 3),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '${getTranslated(context, "You just stake") ?? "You just stake"}',
              style: TextStyle(
                  fontSize: 14,
                  color: lightTextColor.value,
                  fontFamily: 'Spectral',
                  fontWeight: FontWeight.w400),
              children: <TextSpan>[
                TextSpan(
                  text: ' 0.5 SOL ',
                  style: TextStyle(
                      fontSize: 13,
                      color: headingColor.value,
                      fontFamily: 'dmsans',
                      fontWeight: FontWeight.w600),
                ),
                TextSpan(text: '${getTranslated(context, "to get") ?? "to get"}'),
                TextSpan(
                  text: ' 8.3 ETH ',
                  style: TextStyle(
                      fontSize: 13,
                      color: headingColor.value,
                      fontFamily: 'dmsans',
                      fontWeight: FontWeight.w600),
                ),
                TextSpan(
                    text:
                    '${getTranslated(context, "successfully.") ?? "successfully."}'),
              ],
            ),
          ),
          SizedBox(height: 32),
          BottomRectangularBtn(
              onTapFunc: () {
                Get.back();
                Get.back();
              },
              btnTitle: "View History"),
        ],
      ),
    );
  }

  Widget _buildBalanceItem({
    required String image,
    required String symbol,
    required String name,
    required String balance,
    required int index, // Thêm index vào tham số
  }) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(image),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  symbol,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: headingColor.value,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 12,
                    color: lightTextColor.value,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: isAnyClaimLoading || claimLoadingStates[index]
                ? null
                : () async {
              // Bắt đầu loading
              setState(() => claimLoadingStates[index] = true);

              // Giả lập API call mất 2s

              String result = await claimExecute(walletAddress!, symbol);
              await _loadInternalBalance(walletAddress!);
              Get.snackbar(
                "Success",
                result,
                backgroundColor: Colors.white,
                colorText: Colors.green,
              );

              // Kết thúc loading
              setState(() => claimLoadingStates[index] = false);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              textStyle: TextStyle(fontSize: 12),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: claimLoadingStates[index]
                ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: headingColor.value,
              ),
            )
                : Text(
              formatBalance(balance),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: headingColor.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}