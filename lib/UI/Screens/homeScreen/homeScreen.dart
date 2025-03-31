import 'package:crypto_wallet/UI/Screens/buyScreen.dart';
import 'package:crypto_wallet/UI/Screens/profile/profile.dart';
import 'package:crypto_wallet/UI/Screens/receiveScreen.dart';
import 'package:crypto_wallet/UI/Screens/sendScreens/selectTokenScreen.dart';
import 'package:crypto_wallet/UI/Screens/swapScreens/swapScreen.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/wallet_provider.dart';
import '../../common_widgets/inputField.dart';
import '../nfts/nftsScreen.dart';
import '../onBoardingScreens/onboardingScreen1.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var isVisible=false.obs;
  List coins=[
    {
      "image":"assets/images/bnb.png",
      "symbol":"BNB",
      "amount":"1000.4545",
      "price":"589.44",
      "chain":""
    },
    {
      "image":"assets/images/usdt.png",
      "symbol":"USDT",
      "amount":"6000.4545",
      "price":"1.00",
      "chain":""
    },
    {
      "image":"assets/images/eth.png",
      "symbol":"ETH",
      "amount":"100.989",
      "price":"1785.04",
      "chain":""
    },
  ];
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
    {
      "image":"assets/images/eth.png",
      "symbol":"Ethereum",
      "price1":"0 ETH",
      "price2":"\$1,571.45",
      "percentage":"8.75%",
      "chain":""
    },


  ];
  AppController appController=Get.find<AppController>();

  double getTotalBalance(List coins) {
    return coins.fold(0.0, (total, coin) {
      double amount = double.tryParse(coin['amount'].toString()) ?? 0.0;
      double price = double.tryParse(coin['price'].toString()) ?? 0.0;
      return total + (amount * price);
    });
  }

  String formatBalance(String balance) {
    try {
      double value = double.parse(balance);

      // Nếu số bằng 0, trả về "0"
      if (value == 0) {
        return "0";
      }

      // Nếu số nhỏ hơn 0.0001 thì giữ lại 7 chữ số thập phân (không có dấu `,`)
      if (value < 0.0001) {
        return NumberFormat("0.0000000", "en_US").format(value);
      }

      // Nếu số lớn hơn 0.0001, hiển thị có dấu `,` ngăn cách nghìn, triệu
      return NumberFormat("#,##0.######", "en_US").format(value);
    } catch (e) {
      return "Invalid balance";
    }
  }

  String formatTotalBalance(String balance) {
    try {
      double value = double.parse(balance);

      // Nếu số bằng 0, trả về "0"
      if (value == 0) {
        return "0";
      }

      // Nếu số nhỏ hơn 0.0001 thì giữ lại 7 chữ số thập phân (không có dấu `,`)
      if (value < 0.0001) {
        return NumberFormat("0.00", "en_US").format(value);
      }

      // Nếu số lớn hơn 0.0001, hiển thị có dấu `,` ngăn cách nghìn, triệu
      return NumberFormat("#,##0.##", "en_US").format(value);
    } catch (e) {
      return "Invalid balance";
    }
  }

  @override
  Widget build(BuildContext context) {
    print(context);

    return Obx(
      ()=> Scaffold(
        backgroundColor:primaryBackgroundColor.value,
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 22,vertical: 20),
            children: [
              // SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(Profile());
                    },
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
                        Icon(Icons.keyboard_arrow_down,color: headingColor.value,)
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
                        child: SvgPicture.asset("assets/svgs/u_copy-landscape.svg", color: appController.isDark.value ? Color(0xffA2BBFF) : headingColor.value),
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
                        child: SvgPicture.asset("assets/svgs/ion_qr-code.svg", color: appController.isDark.value ? Color(0xffA2BBFF) : headingColor.value),
                      ),
                      SizedBox(width: 8,), // Thêm khoảng cách trước icon logout
                      GestureDetector(
                        onTap: () {
                          final walletProvider = Provider.of<WalletProvider>(context, listen: false);
                          walletProvider.clearPrivateKey(); // Xóa privateKey khi logout

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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(SelectTokenScreen());
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
                  // GestureDetector(
                  //   onTap: (){
                  // Get.to(NftsScreen());
                  //   },
                  //   child: Column(
                  //     children: [
                  //       Container(
                  //         height: 56,
                  //         width: 56,
                  //         padding: EdgeInsets.all(12),
                  //         decoration: BoxDecoration(
                  //             color: primaryColor.value,
                  //             borderRadius: BorderRadius.circular(15)
                  //         ),
                  //         child: Center(child: SvgPicture.asset("assets/svgs/buy.svg",height: 28,width: 28,)),
                  //       ),
                  //       SizedBox(height: 12,),
                  //       Text(
                  //         "Nft",
                  //         textAlign: TextAlign.start,
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w600,
                  //           color: primaryColor.value,
                  //           fontFamily: "dmsans",
                  //
                  //         ),
                  //
                  //       ),
                  //
                  //     ],
                  //   ),
                  // ),

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
                  return  Obx(
                    ()=> Container(
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
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color:appController.isDark.value==true?Color(0xffFDFCFD):primaryColor.value,
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
                                                color: appController.isDark.value ? Color(0xffFDFCFD) : primaryColor.value,
                                                fontFamily: "dmsans",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 7,),
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
                                              "\$ ${coins[index]['price']}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color:Color(0xff56CDAD),
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
                                            "21",
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
                                            "\$46448.00",
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
                                                  "Etheream",
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
