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
  BuildContext? _bottomSheetContext;
  String? walletAddress;
  String? privateKey;
  String? bnbBalance;
  String? usdtBalance;
  String? bnbPrice;
  String? btcWalletAddress;
  String? xrpWalletAddress;
  String? tonWalletAddress;
  String? accountName;
  bool isSnackbarVisible = false;

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

  void _showPackagesBottomSheet() {
    // _loadPackages(); // Gọi _loadPackages() trong FutureBuilder của selectTokenForBuy
    showModalBottomSheet(
      context: context, // context của HomeScreen
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Để Container con tự xử lý nền
      builder: (bottomSheetBuildContext) { // context này là của BottomSheet
        _bottomSheetContext = bottomSheetBuildContext; // LƯU LẠI CONTEXT NÀY
        return selectTokenForBuy();
      },
    ).then((_) {
      // Khi bottom sheet đóng (bằng cách vuốt xuống hoặc Navigator.pop),
      // reset _bottomSheetContext
      if (mounted) {
        setState(() {
          _bottomSheetContext = null;
        });
      }
    });
  }

  Future<void> _handleClaimCapital(int id) async {
    // bool success = false; // Cờ để theo dõi thành công của API call
    try {
      // Không đặt isLoading = true ở đây nếu bạn muốn UI của BottomSheet vẫn tương tác được
      // Chỉ đặt isLoading khi thực sự bắt đầu tải lại _loadWalletData
      // Hoặc bạn có thể có một biến isLoading riêng cho nút Claim

      String response = await ApiService.claimCapital(id);

      if (response == "Claim capital successful.") {
        // success = true; // Đánh dấu thành công

        // 1. Hiển thị Snackbar (giữ nguyên logic isSnackbarVisible của bạn nếu muốn)
        if (!Get.isSnackbarOpen && !isSnackbarVisible) {
          isSnackbarVisible = true;
          Get.snackbar(
              "Thành công!", // Title
              response,       // Message
              backgroundColor: Colors.greenAccent,
              colorText: Colors.black, // Đổi màu text cho dễ đọc
              margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
              duration: const Duration(seconds: 2),
              snackPosition: SnackPosition.TOP,
              onTap: (_) { // Cho phép người dùng nhấn vào snackbar để đóng nó sớm
                Get.closeCurrentSnackbar();
              }
          );
          // Reset isSnackbarVisible sau khi snackbar đóng
          Future.delayed(const Duration(seconds: 2), () {
            isSnackbarVisible = false;
          });
        }

        // 2. Đóng BottomSheet sau 1 giây
        Future.delayed(const Duration(seconds: 1), () {
          if (_bottomSheetContext != null && Navigator.of(_bottomSheetContext!).canPop()) {
            print("Closing BottomSheet via _bottomSheetContext after 1s success delay");
            Navigator.of(_bottomSheetContext!).pop();
            _bottomSheetContext = null; // Reset context
          } else if (Get.isBottomSheetOpen ?? false) { // Fallback nếu dùng Get.bottomSheet
            print("Closing BottomSheet via Get.back() after 1s success delay");
            Get.back(closeOverlays: true);
          } else {
            print("No BottomSheet context available or GetX BottomSheet not detected to close.");
          }
        });

        // 3. Tải lại dữ liệu wallet sau 2 giây (sau khi snackbar và bottomsheet có thể đã đóng)
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() => isLoading = true); // Bắt đầu loading cho màn hình chính
            _loadWalletData();
          }
        });

      } else { // Claim không thành công từ API
        // setState(() => isLoading = false); // Dừng loading nếu bạn có set ở đầu hàm này
        if (!Get.isSnackbarOpen && !isSnackbarVisible) {
          isSnackbarVisible = true;
          Get.snackbar("Thất bại", response, backgroundColor: Colors.red /*...*/);
          Future.delayed(const Duration(seconds: 2), () => isSnackbarVisible = false);
        }
      }
    } catch (e) {
      // setState(() => isLoading = false); // Dừng loading nếu có set ở đầu hàm này
      if (!Get.isSnackbarOpen && !isSnackbarVisible) {
        isSnackbarVisible = true;
        Get.snackbar("Lỗi", e.toString(), backgroundColor: Colors.red /*...*/);
        Future.delayed(const Duration(seconds: 2), () => isSnackbarVisible = false);
      }
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
                            fontSize: dimensions.getFont(14),
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
                            fontSize: dimensions.getFont(13),
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
                            fontSize: dimensions.getFont(13),
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontFamily: "dmsans",
                          ),
                        ),
                        Text(
                          "\$ ${formatBalance(coins[index]['price'])}",
                          style: TextStyle(
                            fontSize: dimensions.getFont(12),
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
    Dimensions dimensions = Dimensions(context);

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(dimensions.getWidth(20))),
          image: DecorationImage(
            image: AssetImage("assets/background/bg7.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(dimensions.getWidth(16)),
              decoration: BoxDecoration(
                color: Colors.grey[900]!.withOpacity(0.9),
                borderRadius: BorderRadius.vertical(top: Radius.circular(dimensions.getWidth(20))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Choose Token",
                    style: TextStyle(
                      fontSize: dimensions.getFont(20),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white, size: dimensions.getFont(24)),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),

            // Search
            // Padding(
            //   padding: EdgeInsets.all(dimensions.getWidth(16)),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       filled: true,
            //       fillColor: Colors.grey[800]!.withOpacity(0.7),
            //       hintText: "Search...",
            //       hintStyle: TextStyle(
            //         fontSize: dimensions.getFont(16),
            //         color: Colors.grey,
            //       ),
            //       prefixIcon: Icon(Icons.search, color: Colors.grey, size: dimensions.getFont(20)),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(dimensions.getWidth(15)),
            //         borderSide: BorderSide.none,
            //       ),
            //       contentPadding: EdgeInsets.symmetric(vertical: dimensions.getHeight(10)),
            //     ),
            //     style: TextStyle(
            //       fontSize: dimensions.getFont(16),
            //       color: Colors.white,
            //     ),
            //   ),
            // ),

            // Token List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: dimensions.getWidth(16),
                  vertical: dimensions.getHeight(8),
                ),
                itemCount: coins.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(ReceiveScreen(
                        symbol: coins[index]['symbol'],
                        image: coins[index]['image'],
                        walletAddress: coins[index]['walletAddress'],
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: dimensions.getHeight(12)),
                      padding: EdgeInsets.all(dimensions.getWidth(12)),
                      decoration: BoxDecoration(
                        color: Colors.grey[800]!.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(dimensions.getWidth(15)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: dimensions.getWidth(40),
                            height: dimensions.getHeight(40),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(coins[index]['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: dimensions.getWidth(12)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  coins[index]['symbol'],
                                  style: TextStyle(
                                    fontSize: dimensions.getFont(16),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: dimensions.getHeight(4)),
                                Text(
                                  coins[index]['des'] ?? '',
                                  style: TextStyle(
                                    fontSize: dimensions.getFont(12),
                                    color: Colors.grey[300],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formatBalance(coins[index]['amount']),
                                style: TextStyle(
                                  fontSize: dimensions.getFont(14),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: dimensions.getHeight(4)),
                              Text(
                                "\$${(double.parse(coins[index]['amount']) * double.parse(coins[index]['price'])).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: dimensions.getFont(12),
                                  color: Colors.greenAccent,
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
      ),
    );
  }

  Widget selectTokenForBuy() {
    Dimensions dimensions = Dimensions(context);

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8, // Maintained at 80%
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(dimensions.getWidth(30)),
          ),
          image: DecorationImage(
            image: AssetImage("assets/background/bg7.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder(
          future: _loadPackages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(dimensions.getWidth(16)),
                  decoration: BoxDecoration(
                    color: Colors.grey[900]!.withOpacity(0.9),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(dimensions.getWidth(20)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Packages",
                        style: TextStyle(
                          fontSize: dimensions.getFont(20),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: dimensions.getFont(24),
                        ),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ),

                // Package List
                Expanded(
                  child: packages.isEmpty
                      ? Center(
                    child: Text(
                      "No packages available",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: dimensions.getFont(16),
                      ),
                    ),
                  )
                      : ListView.builder(
                    padding: EdgeInsets.all(dimensions.getWidth(16)),
                    itemCount: packages.length,
                    itemBuilder: (context, index) {
                      // Determine border color based on conditions
                      Color borderColor;
                      if (packages[index]['status'] == true && packages[index]['cycleLeft'] > 0) {
                        borderColor = Colors.blue;
                      } else if (packages[index]['status'] == true && packages[index]['cycleLeft'] == 0) {
                        borderColor = Colors.green;
                      } else if (packages[index]['status'] == false && packages[index]['cycleLeft'] == 0) {
                        borderColor = Colors.red;
                      } else {
                        borderColor = Colors.transparent; // Default case, no border
                      }

                      // Calculate card width (screen width minus padding)
                      double cardWidth = MediaQuery.of(context).size.width - 2 * dimensions.getWidth(16);
                      // Calculate button width as 90% of card width
                      double buttonWidth = cardWidth * 0.9;

                      return Container(
                        margin: EdgeInsets.only(
                          bottom: dimensions.getHeight(12),
                        ),
                        padding: EdgeInsets.all(dimensions.getWidth(12)),
                        decoration: BoxDecoration(
                          color: Colors.grey[800]!.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(
                            dimensions.getWidth(15),
                          ),
                          border: Border.all(
                            color: borderColor,
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: dimensions.getWidth(40),
                                  height: dimensions.getHeight(40),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/${packages[index]['symbol'].toLowerCase()}.png",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: dimensions.getWidth(12)),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Staking ${packages[index]['amountInToken']} ${packages[index]['symbol']}",
                                        style: TextStyle(
                                          fontSize:
                                          dimensions.getFont(16),
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                          height:
                                          dimensions.getHeight(4)),
                                      Text(
                                        "~ ${packages[index]['amountInUSDT']} USDT",
                                        style: TextStyle(
                                          fontSize:
                                          dimensions.getFont(14),
                                          color: Colors.grey[300],
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${packages[index]['cycleLeft']}/${packages[index]['cycles']}",
                                      style: TextStyle(
                                        fontSize:
                                        dimensions.getFont(16),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                        dimensions.getHeight(4)),
                                    Text(
                                      packages[index]['date'] ?? '',
                                      style: TextStyle(
                                        fontSize:
                                        dimensions.getFont(10),
                                        color: Colors.grey[400],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (packages[index]['cycleLeft'] == 0 &&
                                packages[index]['status'] == true) ...[
                              SizedBox(height: dimensions.getHeight(8)),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  width: buttonWidth, // 90% of card width
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _handleClaimCapital(packages[index]['id']);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[900], // Dark gray background
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          dimensions.getWidth(10),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: dimensions.getWidth(16),
                                        vertical: dimensions.getHeight(6), // Reduced vertical padding
                                      ),
                                    ),
                                    child: Text(
                                      "Claim",
                                      style: TextStyle(
                                        fontSize: dimensions.getFont(14),
                                        color: Colors.grey[300], // Light gray text
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

}