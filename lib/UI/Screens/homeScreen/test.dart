import 'dart:convert';

import 'package:crypto_wallet/UI/Screens/TransactionHistoryScreen/TransactionScreen.dart';
import 'package:crypto_wallet/UI/Screens/profile/profile.dart';
import 'package:crypto_wallet/UI/Screens/receiveScreen.dart';
import 'package:crypto_wallet/UI/Screens/sendScreens/selectTokenScreen.dart';
import 'package:crypto_wallet/UI/Screens/stakingScreen/stakingScreen.dart';
import 'package:crypto_wallet/UI/Screens/swapScreens/swapScreen.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:crypto_wallet/services/apiService.dart';
import 'package:crypto_wallet/UI/common_widgets/dimensions.dart';
import 'package:crypto_wallet/utils/get_balances.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

import '../../../providers/wallet_provider.dart';
import '../../common_widgets/dimensions.dart';
import '../../common_widgets/inputField.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? walletAddress;
  String? privateKey;
  String? bnbBalance;
  String? usdtBalance;
  String? bnbPrice;
  String? btcWalletAddress;
  String? xrpWalletAddress;
  String? tonWalletAddress;
  String? accountName;

  var isVisible = false.obs;
  bool isLoading = true;

  List coins = [];
  List packages = [];

  List fiat = [
    {
      "image": "assets/images/Ellipse 26.png",
      "symbol": "USD",
    },
  ];

  List selectTokenList = [
    {
      "image": "assets/images/bnb.png",
      "symbol": "BNB",
      "price1": "0 BNB",
      "price2": "\$1,571.45",
      "percentage": "8.75%",
      "chain": ""
    },
    {
      "image": "assets/images/usdt.png",
      "symbol": "USDT",
      "price1": "0 USDT",
      "price2": "\$1,571.45",
      "percentage": "8.75%",
      "chain": ""
    },
  ];

  AppController appController = Get.find<AppController>();

  @override
  void initState() {
    super.initState();
    _loadWalletData();
  }

  Future<void> _loadPackages() async {
    try {
      setState(() => isLoading = true);

      dynamic response = await ApiService.getPackages(walletAddress!);
      setState(() {
        packages = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
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

      dynamic response = await ApiService.fetchStatistic(savedWalletAddress);

      setState(() {
        coins = response;
        walletAddress = savedWalletAddress;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  double getTotalBalance(List coins) {
    return coins.fold(0.0, (total, coin) {
      double amount = double.tryParse(coin['amount'].toString()) ?? 0.0;
      double price = double.tryParse(coin['price'].toString()) ?? 0.0;
      return total + (amount * price);
    });
  }

  String _shortenAddress(String address) {
    if (address.length > 20) {
      return address.substring(0, 10) + "..." + address.substring(address.length - 10);
    }
    return address;
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context); // Initialize dimensions helper
    return Obx(
          () => Scaffold(
        backgroundColor: primaryBackgroundColor.value,
        body: SafeArea(
          child: isLoading
              ? Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/background/bg7.png',
                fit: BoxFit.cover,
              ),
              Center(
                child: CircularProgressIndicator(
                  color: primaryColor.value,
                ),
              ),
            ],
          )
              : Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/background/bg7.png",
                  fit: BoxFit.cover,
                ),
              ),
              ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: dimensions.getWidth(22),
                  vertical: dimensions.getHeight(20),
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => Profile());
                        },
                        child: Row(
                          children: [
                            Text(
                              "",
                              style: TextStyle(
                                fontSize: dimensions.getFont(18),
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                fontFamily: "dmsans",
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(width: dimensions.getWidth(8)),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              isVisible.value = !isVisible.value;
                            },
                            child: Container(
                              height: dimensions.getHeight(32),
                              width: dimensions.getWidth(32),
                              padding: EdgeInsets.all(dimensions.getWidth(8)),
                              decoration: BoxDecoration(
                                color: appController.isDark.value
                                    ? Color(0xff1A2B56)
                                    : inputFieldBackgroundColor.value,
                                borderRadius: BorderRadius.circular(dimensions.getWidth(8)),
                              ),
                              child: isVisible.value
                                  ? Icon(Icons.visibility_outlined,
                                  color: headingColor.value,
                                  size: dimensions.getFont(17))
                                  : SvgPicture.asset(
                                  "assets/svgs/hideBalance.svg",
                                  color: appController.isDark.value
                                      ? Color(0xffA2BBFF)
                                      : headingColor.value),
                            ),
                          ),
                          SizedBox(width: dimensions.getWidth(8)),
                          GestureDetector(
                            onTap: () {
                              _loadWalletData();
                            },
                            child: Container(
                              height: dimensions.getHeight(32),
                              width: dimensions.getWidth(32),
                              padding: EdgeInsets.all(dimensions.getWidth(8)),
                              decoration: BoxDecoration(
                                color: appController.isDark.value
                                    ? Color(0xff1A2B56)
                                    : inputFieldBackgroundColor.value,
                                borderRadius: BorderRadius.circular(dimensions.getWidth(8)),
                              ),
                              child: Icon(Icons.refresh_rounded,
                                  color: headingColor.value,
                                  size: dimensions.getFont(20)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: dimensions.getHeight(32)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isVisible.value == true
                          ? Text(
                        "*****",
                        style: TextStyle(
                          fontSize: dimensions.getFont(56),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: "dmsans",
                        ),
                      )
                          : Text(
                        "\$ ${formatTotalBalance(getTotalBalance(coins).toString())}",
                        style: TextStyle(
                          fontSize: dimensions.getFont(50),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: "dmsans",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: dimensions.getHeight(24)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        dimensions,
                        "Send",
                        "assets/svgs/sendIcon.svg",
                            () => Get.to(SelectTokenScreen(coins: coins)),
                      ),
                      _buildActionButton(
                        dimensions,
                        "Receive",
                        "assets/svgs/receiveicon.svg",
                            () => Get.bottomSheet(selectToken()),
                      ),
                      _buildActionButton(
                        dimensions,
                        "Swap",
                        "assets/svgs/swap.svg",
                            () => Get.to(SwapScreen()),
                      ),
                      _buildActionButton(
                        dimensions,
                        "Packages",
                        "assets/svgs/buy.svg",
                            () {
                          _loadPackages();
                          Get.bottomSheet(selectTokenForBuy());
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: dimensions.getHeight(32)),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: coins.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: dimensions.getHeight(12)),
                    itemBuilder: (context, index) => _buildCoinItem(dimensions, index),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(Dimensions dimensions, String label, String iconPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: dimensions.getHeight(56),
            width: dimensions.getWidth(56),
            padding: EdgeInsets.all(dimensions.getWidth(16)),
            decoration: BoxDecoration(
              color: appController.isDark.value ? Color(0xFF1A2B56) : primaryColor.value,
              borderRadius: BorderRadius.circular(dimensions.getWidth(15)),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                height: dimensions.getHeight(28),
                width: dimensions.getWidth(28),
                color: appController.isDark.value ? Color(0xFFA2BBFF) : primaryBackgroundColor.value,
              ),
            ),
          ),
          SizedBox(height: dimensions.getHeight(12)),
          Text(
            "${getTranslated(context, label) ?? label}",
            style: TextStyle(
              fontSize: dimensions.getFont(16),
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: "dmsans",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoinItem(Dimensions dimensions, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionScreen(
              symbol: coins[index]['symbol'],
            ),
          ),
        );
      },
      child: Container(
        height: dimensions.getHeight(72),
        width: Get.width,
        padding: EdgeInsets.all(dimensions.getWidth(12)),
        decoration: BoxDecoration(
          color: Colors.grey.shade800.withOpacity(0.7),
          borderRadius: BorderRadius.circular(dimensions.getWidth(16)),
          border: Border.all(width: 1, color: inputFieldBackgroundColor.value),
        ),
        child: Row(
          children: [
            // Coin Image
            Container(
              height: dimensions.getHeight(40),
              width: dimensions.getWidth(40),
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image.asset(
                "${coins[index]['image']}",
                height: dimensions.getHeight(40),
                width: dimensions.getWidth(40),
              ),
            ),
            SizedBox(width: dimensions.getWidth(12)),

            // Coin Info
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // First row: Symbol + Total Value
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${coins[index]['symbol']}",
                          style: TextStyle(
                            fontSize: dimensions.getFont(16),
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: "dmsans",
                          ),
                        ),
                        Text(
                          formatBalance(
                            (double.parse(coins[index]['amount'].toString()) *
                                double.parse(coins[index]['price'].toString()))
                                .toString(),
                          ),
                          style: TextStyle(
                            fontSize: dimensions.getFont(15),
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: "dmsans",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: dimensions.getHeight(7)),

                  // Second row: Coin amount + price
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatBalance(
                            double.parse(coins[index]['amount'].toString())
                                .toString(),
                          ),
                          style: TextStyle(
                            fontSize: dimensions.getFont(15),
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontFamily: "dmsans",
                          ),
                        ),
                        Text(
                          "\$ ${formatBalance(coins[index]['price'])}",
                          style: TextStyle(
                            fontSize: dimensions.getFont(14),
                            fontWeight: FontWeight.w600,
                            color: Color(0xff56CDAD),
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
    );
  }

  Widget selectToken() {
    // Get screen dimensions
    final screenWidth = Get.width;
    final screenHeight = Get.height;
    // Reference dimensions (Pixel 9 Pro XL: 1344x2992 logical pixels)
    const referenceWidth = 1344.0;
    const referenceHeight = 2992.0;
    // Scaling factors
    final widthScale = screenWidth / referenceWidth;
    final heightScale = screenHeight / referenceHeight;
    final textScale = (widthScale + heightScale) / 2;

    return Container(
      height: Get.height * 0.90,
      width: Get.width,
      padding: EdgeInsets.symmetric(
        horizontal: 22 * widthScale,
        vertical: 22 * heightScale,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background/bg7.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${getTranslated(context, "Choose Token") ?? "Choose Token"}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20 * textScale,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: "dmsans",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 24 * textScale,
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * heightScale),
          InputFields(
            hintText: "Search...",
            icon: Image.asset(
              "assets/images/Search.png",
              height: 24 * heightScale,
              width: 24 * widthScale,
            ),
          ),
          SizedBox(height: 24 * heightScale),
          Expanded(
            child: ListView.separated(
              itemCount: coins.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 12 * heightScale);
              },
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(ReceiveScreen(
                      symbol: coins[index]['symbol'],
                      image: coins[index]['image'],
                      walletAddress: coins[index]['walletAddress'],
                    ));
                  },
                  child: Container(
                    height: 72 * heightScale,
                    width: Get.width,
                    padding: EdgeInsets.all(12 * widthScale),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16 * widthScale),
                      border: Border.all(
                        width: 1 * widthScale,
                        color: Colors.white24,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 40 * heightScale,
                          width: 40 * widthScale,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            "${coins[index]['image']}",
                            height: 40 * heightScale,
                            width: 40 * widthScale,
                          ),
                        ),
                        SizedBox(width: 12 * widthScale),
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
                                      style: TextStyle(
                                        fontSize: 18 * textScale,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontFamily: "dmsans",
                                      ),
                                    ),
                                    Text(
                                      "${formatBalance(coins[index]['amount'])}",
                                      style: TextStyle(
                                        fontSize: 18 * textScale,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
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
                                      "${coins[index]['des']}",
                                      style: TextStyle(
                                        fontSize: 13 * textScale,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white70,
                                        fontFamily: "dmsans",
                                      ),
                                    ),
                                    Text(
                                      "\$ ${formatBalance(((double.tryParse(coins[index]['amount'].toString()) ?? 0.0) * (double.tryParse(coins[index]['price'].toString()) ?? 0.0)).toString())}",
                                      style: TextStyle(
                                        fontSize: 12 * textScale,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white70,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget selectTokenForBuy() {
    // Get screen dimensions
    final screenWidth = Get.width;
    final screenHeight = Get.height;
    // Reference dimensions (Pixel 9 Pro XL: 1344x2992 logical pixels)
    const referenceWidth = 1344.0;
    const referenceHeight = 2992.0;
    // Scaling factors
    final widthScale = screenWidth / referenceWidth;
    final heightScale = screenHeight / referenceHeight;
    final textScale = (widthScale + heightScale) / 2;

    return Container(
      height: Get.height * 0.9,
      width: Get.width,
      padding: EdgeInsets.symmetric(
        horizontal: 22 * widthScale,
        vertical: 22 * heightScale,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background/bg7.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${getTranslated(context, "List Packages") ?? "List Packages"}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20 * textScale,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: "dmsans",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 24 * textScale,
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * heightScale),
          Expanded(
            child: ListView.separated(
              itemCount: packages.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 12 * heightScale);
              },
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // Handle package selection
                  },
                  child: Container(
                    height: 120 * heightScale,
                    width: Get.width,
                    padding: EdgeInsets.all(12 * widthScale),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16 * widthScale),
                      border: Border.all(
                        width: 1 * widthScale,
                        color: Colors.white24,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40 * heightScale,
                              width: 40 * widthScale,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Image.asset(
                                "assets/images/${packages[index]['symbol'].toLowerCase()}.png",
                                height: 40 * heightScale,
                                width: 40 * widthScale,
                              ),
                            ),
                            SizedBox(width: 12 * widthScale),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Staking ${packages[index]['amountInToken']} ${packages[index]['symbol']}",
                                    style: TextStyle(
                                      fontSize: 16 * textScale,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontFamily: "dmsans",
                                    ),
                                  ),
                                  SizedBox(height: 4 * heightScale),
                                  Text(
                                    "~ ${packages[index]['amountInUSDT']} USDT",
                                    style: TextStyle(
                                      fontSize: 13 * textScale,
                                      color: Colors.white70,
                                      fontFamily: "dmsans",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${packages[index]['cycleLeft']} / ${packages[index]['cycles']}",
                                  style: TextStyle(
                                    fontSize: 18 * textScale,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: "dmsans",
                                  ),
                                ),
                                SizedBox(height: 4 * heightScale),
                                Text(
                                  packages[index]['date'] ?? '',
                                  style: TextStyle(
                                    fontSize: 12 * textScale,
                                    color: Colors.white70,
                                    fontFamily: "dmsans",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8 * heightScale),
                          child: Divider(
                            color: Colors.white24,
                            height: 1 * heightScale,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${packages[index]['status'] == false ? "Running" : "Completed"}",
                              style: TextStyle(
                                fontSize: 13 * textScale,
                                color: Colors.white70,
                                fontFamily: "dmsans",
                              ),
                            ),
                            Text(
                              "",
                              style: TextStyle(
                                fontSize: 13 * textScale,
                                color: Colors.white70,
                                fontFamily: "dmsans",
                              ),
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
    );
  }
}