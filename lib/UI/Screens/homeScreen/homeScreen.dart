import 'dart:convert';

import 'package:crypto_wallet/UI/Screens/TransactionHistoryScreen/TransactionScreen.dart';
import 'package:crypto_wallet/UI/Screens/buyScreen.dart';
import 'package:crypto_wallet/UI/Screens/receiveScreen.dart';
import 'package:crypto_wallet/UI/Screens/sendScreens/selectTokenScreen.dart';
import 'package:crypto_wallet/UI/Screens/swapScreens/swapScreen.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:crypto_wallet/utils/get_balances.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

import '../../../providers/wallet_provider.dart';
import '../../common_widgets/inputField.dart';
import '../onBoardingScreens/onboardingScreen1.dart';
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

  var isVisible=false.obs;
  bool isLoading = true;

  List coins=[];

  List fiat=[
    {
      "image":"assets/images/Ellipse 26.png",
      "symbol":"USD",

    },
  ];

  List selectTokenList=[
    {
      "image":"assets/images/bnb.png",
      "symbol":"BNB",
      "price1":"0 BNB",
      "price2":"\$1,571.45",
      "percentage":"8.75%",
      "chain":""
    },
    {
      "image":"assets/images/usdt.png",
      "symbol":"USDT",
      "price1":"0 USDT",
      "price2":"\$1,571.45",
      "percentage":"8.75%",
      "chain":""
    },
    // {
    //   "image":"assets/images/eth.png",
    //   "symbol":"Ethereum",
    //   "price1":"0 ETH",
    //   "price2":"\$1,571.45",
    //   "percentage":"8.75%",
    //   "chain":""
    // },
  ];

  AppController appController=Get.find<AppController>();

  @override
  void initState() {
    super.initState();
    _loadWalletData();
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
            "chain": ""
          },
          {
            "image": "assets/images/usdt.png",
            "symbol": "USDT",
            "amount": latestBalanceUsdtInEther,
            "price": "1.00",
            "chain": ""
          },
          {
            "image": "assets/images/eft.png",
            "symbol": "EFT",
            "amount": latestBalanceEftInEther,
            "price": "0.15",
            "chain": ""
          },
        ];
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
  Widget build(BuildContext context) {
    return Obx(
          ()=> Scaffold(
        backgroundColor:primaryBackgroundColor.value,
        body: SafeArea(
          child: isLoading ? Center(
            child: CircularProgressIndicator(
                    color: primaryColor.value,
                ),
            )
              :
          Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/background/bg7.png",
                  fit: BoxFit.cover,
                ),
              ),
              ListView (
                padding: EdgeInsets.symmetric(horizontal: 22,vertical: 20),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Row(
                          children: [
                            Text(
                              "Edric Jaye",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: headingColor.value,
                                fontFamily: "dmsans",

                              ),
                            ),
                            SizedBox(width: 8,),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              isVisible.value = !isVisible.value;
                            },
                            child: Container(
                              height: 32,
                              width: 32,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: appController.isDark.value ? Color(0xff1A2B56) : inputFieldBackgroundColor.value,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: isVisible == true
                                  ? Icon(Icons.visibility_outlined, color: headingColor.value, size: 17)
                                  : SvgPicture.asset("assets/svgs/hideBalance.svg", color: appController.isDark.value ? Color(0xffA2BBFF) : headingColor.value),
                            ),
                          ),
                          SizedBox(width: 8,),
                          Container(
                            height: 32,
                            width: 32,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: appController.isDark.value ? Color(0xff1A2B56) : inputFieldBackgroundColor.value,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // Lưu walletAddress vào clipboard khi nhấn vào container
                                Clipboard.setData(ClipboardData(text: walletAddress ?? ""));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Wallet Address copied to clipboard!')),
                                );
                              },
                              child: SvgPicture.asset(
                                "assets/svgs/u_copy-landscape.svg",
                                color: appController.isDark.value ? Color(0xffA2BBFF) : headingColor.value,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            height: 32,
                            width: 32,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: appController.isDark.value ? Color(0xff1A2B56) : inputFieldBackgroundColor.value,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SvgPicture.asset("assets/svgs/ion_qr-code.svg", color: appController.isDark.value ? Color(0xffA2BBFF) : headingColor.value),
                          ),
                          SizedBox(width: 8,), // Thêm khoảng cách trước icon logout
                          GestureDetector(
                            onTap: () {
                              _loadWalletData();
                            },
                            child: Container(
                              height: 32,
                              width: 32,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: appController.isDark.value ? Color(0xff1A2B56) : inputFieldBackgroundColor.value,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.refresh_rounded, color: headingColor.value, size: 20),
                            ),
                          ),
                          SizedBox(width: 8,), // Thêm khoảng cách trước icon logout
                          GestureDetector(
                            onTap: () {
                              final walletProvider = Provider.of<WalletProvider>(context, listen: false);
                              walletProvider.clearPrivateKey(); // Xóa privateKey khi logout
                              walletProvider.clearWalletAddress();

                              // Chuyển hướng về màn hình OnBoardingScreen1
                              Get.offAll(OnBoardingScreen1());
                            },
                            child: Container(
                              height: 32,
                              width: 32,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: appController.isDark.value ? Color(0xff1A2B56) : inputFieldBackgroundColor.value,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.logout, color: headingColor.value, size: 20),
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                  SizedBox(height: 32,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isVisible.value==true?
                      Text(
                        "*****",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.w600,
                          color:appController.isDark.value==true?Color(0xffFDFCFD): primaryColor.value,
                          fontFamily: "dmsans",

                        ),

                      ):


                      Text(
                        "\$ ${formatTotalBalance(getTotalBalance(coins).toString())}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w600,
                          color:appController.isDark.value==true?Color(0xffFDFCFD): primaryColor.value,
                          fontFamily: "dmsans",

                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _shortenAddress(walletAddress ?? ""),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          color: appController.isDark.value
                              ? Color(0xffFDFCFD)
                              : primaryColor.value,
                          fontFamily: "dmsans",
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(SelectTokenScreen(coins: coins));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 56,
                              width: 56,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color:appController.isDark.value==true?Color(0xFF1A2B56): primaryColor.value,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Center(child: SvgPicture.asset("assets/svgs/sendIcon.svg",height: 28,width: 28,color:appController.isDark.value==true?Color(0xFFA2BBFF):primaryBackgroundColor.value)),
                            ),
                            SizedBox(height: 12,),
                            Text(
                              "${getTranslated(context,"Send" )??"Send"}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:appController.isDark.value==true?Color(0xffFDFCFD): primaryColor.value,
                                fontFamily: "dmsans",
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.bottomSheet(
                              clipBehavior: Clip.antiAlias,
                              isScrollControlled: true,
                              backgroundColor:appController.isDark.value==true? Color(0xffA2BBFF):primaryBackgroundColor.value,
                              shape: OutlineInputBorder(
                                  borderSide: BorderSide.none, borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32))),
                              selectToken());
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 56,
                              width: 56,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color:appController.isDark.value==true?Color(0xFF1A2B56): primaryColor.value,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Center(child: SvgPicture.asset("assets/svgs/receiveicon.svg",height: 28,width: 28,color:appController.isDark.value==true?Color(0xFFA2BBFF):primaryBackgroundColor.value)),
                            ),
                            SizedBox(height: 12,),
                            Text(
                              "${getTranslated(context,"Receive" )??"Receive"}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:appController.isDark.value==true?Color(0xffFDFCFD): primaryColor.value,
                                fontFamily: "dmsans",
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(SwapScreen());
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 56,
                              width: 56,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color:appController.isDark.value==true?Color(0xFF1A2B56): primaryColor.value,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Center(child: SvgPicture.asset("assets/svgs/swap.svg",height: 28,width: 28,color:appController.isDark.value==true?Color(0xFFA2BBFF):primaryBackgroundColor.value)),
                            ),
                            SizedBox(height: 12,),
                            Text(
                              "${getTranslated(context,"Swap" )??"Swap"}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:appController.isDark.value==true?Color(0xffFDFCFD): primaryColor.value,
                                fontFamily: "dmsans",
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.bottomSheet(
                              clipBehavior: Clip.antiAlias,
                              isScrollControlled: true,
                              backgroundColor: primaryBackgroundColor.value,
                              shape: OutlineInputBorder(
                                  borderSide: BorderSide.none, borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32))),
                              selectTokenForBuy());
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 56,
                              width: 56,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color:appController.isDark.value==true?Color(0xFF1A2B56): primaryColor.value,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Center(child: SvgPicture.asset("assets/svgs/buy.svg",height: 28,width: 28,color: appController.isDark.value==true?Color(0xFFA2BBFF):primaryBackgroundColor.value,)),
                            ),
                            SizedBox(height: 12,),
                            Text(
                              "${getTranslated(context,"Buy" )??"Buy"}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:appController.isDark.value==true?Color(0xffFDFCFD): primaryColor.value,
                                fontFamily: "dmsans",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32,),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: coins.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 12,);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                            () => GestureDetector(
                          onTap: () {
                            // Navigate to TransactionScreen and pass the symbol as an argument
                            print("Navigating to TransactionScreen");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TransactionScreen(symbol: coins[index]['symbol']), // Pass symbol here
                              ),
                            );
                          },
                          child: Container(
                            height: 72,
                            width: Get.width,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: inputFieldBackgroundColor2.value,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(width: 1, color: inputFieldBackgroundColor.value),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset("${coins[index]['image']}", height: 40, width: 40),
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
                                                    "${coins[index]['symbol']}",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      color: appController.isDark.value == true
                                                          ? Color(0xffFDFCFD)
                                                          : primaryColor.value,
                                                      fontFamily: "dmsans",
                                                    ),
                                                  ),
                                                  Text(
                                                    formatBalance(
                                                      (double.parse(coins[index]['amount'].toString()) *
                                                          double.parse(coins[index]['price'].toString()))
                                                          .toString(),
                                                    ),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600,
                                                      color: appController.isDark.value
                                                          ? Color(0xffFDFCFD)
                                                          : primaryColor.value,
                                                      fontFamily: "dmsans",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 7),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    formatBalance(
                                                      (double.parse(coins[index]['amount'].toString()).toString()),
                                                    ),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w400,
                                                      color: lightTextColor.value,
                                                      fontFamily: "dmsans",
                                                    ),
                                                  ),
                                                  Text(
                                                    "\$ ${formatTotalBalance(coins[index]['price'])}",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 14,
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
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget selectToken(){
    return Container(
      height: Get.height*0.95,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 22,vertical: 22),
      color: inputFieldBackgroundColor.value,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${getTranslated(context,"Choose Token" )??"Choose Token"}",
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

          InputFields(
            hintText: "",
            icon:Image.asset("assets/images/Search.png"),


          ),
          SizedBox(height: 24,),
          Expanded(
            child: ListView.separated(

              itemCount: coins.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 12,);
              },
              itemBuilder: (BuildContext context, int index) {
                return  GestureDetector(
                  onTap: (){
                    Get.to(ReceiveScreen());
                  },
                  child: Container(
                    height:72,
                    width: Get.width,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:appController.isDark.value==true?Colors.transparent: inputFieldBackgroundColor.value,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 1,color:appController.isDark.value==true?inputFieldBackgroundColor2.value :inputFieldBackgroundColor.value),
                    ),
                    child: Row(
                      children: [
                        Container(
                            height:40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:inputFieldBackgroundColor.value
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
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: appController.isDark.value==true?headingColor.value:primaryColor.value,
                                              fontFamily: "dmsans",

                                            ),

                                          ),

                                          Text(
                                            "${formatBalance(coins[index]['amount'])}",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color:appController.isDark.value==true?headingColor.value: primaryColor.value,
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
                                            "Bitcoin",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: lightTextColor.value,
                                              fontFamily: "dmsans",

                                            ),

                                          ),

                                          Text(
                                            "\$ ${formatBalance(
                                                ((double.tryParse(coins[index]['amount'].toString()) ?? 0.0) *
                                                    (double.tryParse(coins[index]['price'].toString()) ?? 0.0)).toString()
                                            )}",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color:
                                              headingColor.value,
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
          ),







        ],
      ),
    );
  }
  Widget selectTokenForBuy(){
    return Container(
      height: Get.height*0.95,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 22,vertical: 22),
      color:appController.isDark.value==true?Color(0xff1A1930): inputFieldBackgroundColor.value,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${getTranslated(context,"Choose Token" )??"Choose Token"}",
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

                InputFields(


                  icon:Image.asset("assets/images/Search.png"),
                  hintText: "",


                ),
                SizedBox(height: 16,),


                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 23,
                      width: 113,
                      decoration: BoxDecoration(
                          color:appController.isDark.value==true?Color(0xff1A2B56): inputFieldBackgroundColor2.value,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(width: 1,color: inputFieldBackgroundColor.value)

                      ),
                      child:   Center(
                        child: Text(
                          "${getTranslated(context,"Popular" )??"Popular"}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: headingColor.value,
                            fontFamily: "dmsans",

                          ),

                        ),
                      ),
                    ),
                    Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 2,),

                  ],
                ),
                SizedBox(height: 16,),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){Get.to(BuyScreen());},

                        child: Container(
                          height:72,
                          width: Get.width,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: inputFieldBackgroundColor2.value,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                          ),
                          child: Row(
                            children: [
                              Container(
                                  height:40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle
                                  ),
                                  child: Image.asset("assets/images/eth.png",height: 40,width: 40,)),

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
                                                  "ETH",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color:appController.isDark.value==true?Color(0xffFDFCFD): primaryColor.value,
                                                    fontFamily: "dmsans",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Ethereum",
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
                      ),
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      child: InkWell(
                        onTap: (){Get.to(BuyScreen());},
                        child: Container(
                          height:72,
                          width: Get.width,
                          padding: EdgeInsets.all(12),
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
                                  child: Image.asset("assets/images/btc.png",height: 40,width: 40,)),

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
                                                  "BTC",
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
                                          SizedBox(width: 20,),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                Text(
                                                  "Bitcoin",
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
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16,),


                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 23,
                      width: 113,
                      decoration: BoxDecoration(
                          color:appController.isDark.value==true?Color(0xff1A2B56):  inputFieldBackgroundColor2.value,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(width: 1,color: inputFieldBackgroundColor.value)

                      ),
                      child:   Center(
                        child: Text(
                          "${getTranslated(context,"All" )??"All"}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: headingColor.value,
                            fontFamily: "dmsans",

                          ),

                        ),
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
                      onTap: (){Get.to(BuyScreen());},


                      child: Container(
                        height:72,
                        width: Get.width,
                        padding: EdgeInsets.all(12),
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

                                              Row(
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
                                                  if(index==0)
                                                    Text(
                                                      "  TRC20",
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        color:
                                                        lightTextColor.value,
                                                        fontFamily: "dmsans",

                                                      ),

                                                    ),
                                                ],
                                              ),

                                              Text(
                                                "21",
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
                                                "Bitcoin",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: lightTextColor.value,
                                                  fontFamily: "dmsans",

                                                ),

                                              ),

                                              Text(
                                                "\$46448.00",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                  lightTextColor.value,
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
          )







        ],
      ),
    );
  }

}
