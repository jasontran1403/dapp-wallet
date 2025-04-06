import 'package:crypto_wallet/UI/common_widgets/bottomRectangularbtn.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common_widgets/inputField.dart';
class StakingScreen extends StatefulWidget {
  const StakingScreen({super.key});

  @override
  State<StakingScreen> createState() => _StakingScreenState();
}

class _StakingScreenState extends State<StakingScreen> {
  AppController appController=Get.find<AppController>();

  int indexSelected = 0;
  bool isLoading = false;

  List coins=[
    {
      "image":"assets/images/bnb.png",
      "symbol":"BNB",
      "name": "Binance Coin",
      "amount":"1,571.45",
      "price":"1,571.45",
      "percentage":"8.75%",
      "chain":"bnb"
    },

    {
      "image":"assets/images/usdt.png",
      "symbol":"USDT",
      "name": "Tether USD",
      "amount":"1,571.45",
      "price":"1,571.45",
      "percentage":"8.75%",
      "chain":"usdt"
    },
    {
      "image":"assets/images/eft.png",
      "symbol":"EFT",
      "name": "EFT",
      "amount":"1,571.45",
      "price":"1,571.45",
      "percentage":"8.75%",
      "chain":"eft"
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    simulateLoading();
  }

  void simulateLoading() {
    setState(() {
      isLoading = true; // Bắt đầu loading
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false; // Kết thúc loading sau 1 giây
      });
    });
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
                                    height: 368,
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
                                            Text(
                                              "0",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 36,
                                                fontWeight: FontWeight.w700,
                                                color: headingColor.value,
                                                fontFamily: "dmsans",

                                              ),

                                            ),
                                            Text(
                                              "\$ ${coins[0]['amount']}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: lightTextColor.value,
                                                fontFamily: "dmsans",

                                              ),

                                            )

                                          ],
                                        ),

                                        SizedBox(height: 15,),
                                        Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 1,),
                                        
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),

                        Column(
                          children: [
                            SizedBox(height: 24,),
                            BottomRectangularBtn(
                                onTapFunc: (){
                                  Get.bottomSheet(
                                      clipBehavior: Clip.antiAlias,
                                      isScrollControlled: true,

                                      backgroundColor: primaryBackgroundColor.value,
                                      shape: OutlineInputBorder(
                                          borderSide: BorderSide.none, borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32))),
                                      confirmSwap()
                                  );
                                }, btnTitle: "Swap"),
                          ],
                        )
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

  Widget confirmSwap(){
    return Container(
      // height: 520,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 22,vertical: 22),
      color: inputFieldBackgroundColor.value,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(

            height: 162,
            width: Get.width,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: inputFieldBackgroundColor2.value,
                borderRadius: BorderRadius.circular(16)
            ),
            child: Column(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${getTranslated(context,"You Pay" )??"You Pay"}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: lightTextColor.value,
                        fontFamily: "dmsans",

                      ),
                    ),
                    Text(
                      "${getTranslated(context,"You Get" )??"You Get"}",
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
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Row(
                      children: [
                        Text(
                          "0.68612",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: headingColor.value,
                            fontFamily: "dmsans",

                          ),
                        ),
                        SizedBox(width: 7,),

                        Text(
                          "SOL",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: lightTextColor.value,
                            fontFamily: "dmsans",

                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "0.68612",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: headingColor.value,
                            fontFamily: "dmsans",

                          ),
                        ),
                        SizedBox(width: 7,),
                        Text(
                          "ETH",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: lightTextColor.value,
                            fontFamily: "dmsans",

                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "(≈\$0.07)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: lightTextColor.value,
                        fontFamily: "dmsans",

                      ),
                    ),
                    Text(
                      "(≈\$0.07)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: lightTextColor.value,
                        fontFamily: "dmsans",

                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10,),

                Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 2,),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${getTranslated(context,"From" )??"From"}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: lightTextColor.value,
                        fontFamily: "dmsans",

                      ),
                    ),
                    Text(
                      "${getTranslated(context,"To" )??"To"}",
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

                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                              color: inputFieldBackgroundColor.value,
                              shape: BoxShape.circle
                          ),
                          child: Image.asset("assets/images/eth.png"),
                        ),
                        SizedBox(width: 8,),
                        Text(
                          "Ethereum",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: headingColor.value,
                            fontFamily: "dmsans",

                          ),
                        ),

                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                              color: inputFieldBackgroundColor.value,
                              shape: BoxShape.circle
                          ),
                          child: Image.asset("assets/images/matic.png"),
                        ),
                        SizedBox(width: 8,),
                        Text(
                          "Matic",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: headingColor.value,
                            fontFamily: "dmsans",

                          ),
                        ),

                      ],
                    ),
                  ],
                )


              ],
            ),
          ),
          SizedBox(height: 16,),
          Container(

            // height:70,
            width: Get.width,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: inputFieldBackgroundColor2.value,
                borderRadius: BorderRadius.circular(16)
            ),
            child: Column(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${getTranslated(context,"Routing Fee" )??"Routing Fee"}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: lightTextColor.value,
                        fontFamily: "dmsans",

                      ),
                    ),
                    Text(
                      "${getTranslated(context,"Slippage Tolerance" )??"Slippage Tolerance"}",
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
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Row(
                      children: [
                        Text(
                          "0.68612",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: headingColor.value,
                            fontFamily: "dmsans",

                          ),
                        ),
                        SizedBox(width: 7,),

                        Text(
                          "SOL",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: lightTextColor.value,
                            fontFamily: "dmsans",

                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "0.1%",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
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

          SizedBox(height: 16,),
          Container(

            // height:70,
            width: Get.width,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: inputFieldBackgroundColor2.value,
                borderRadius: BorderRadius.circular(16)
            ),
            child: Column(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${getTranslated(context,"Quote" )??"Quote"}",
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
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Row(
                      children: [
                        Text(
                          "1 ETH ≈",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: headingColor.value,
                            fontFamily: "dmsans",

                          ),
                        ),
                        SizedBox(width: 7,),

                        Text(
                          "  1.089323 SOL",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: lightTextColor.value,
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
          SizedBox(height: 40,),

          BottomRectangularBtn(
            onTapFunc: () {
              Get.bottomSheet(
                swapCompleted(), // Widget hiển thị khi staking xong
                clipBehavior: Clip.antiAlias,
                isScrollControlled: true,
                isDismissible: true, // ✅ Cho phép tap ra ngoài để đóng
                enableDrag: true,    // ✅ Cho phép vuốt xuống để đóng
                backgroundColor: primaryBackgroundColor.value,
                shape: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(32),
                    topLeft: Radius.circular(32),
                  ),
                ),
              );
            },
            btnTitle: "Confirm staking",
          ),


        ],
      ),
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

            // Get.to(TransactionScreen());
          } ,btnTitle: "View History"),
          SizedBox(height: 12,),

          BottomRectangularBtn(
              onlyBorder: true,
              color: Colors.transparent,
              onTapFunc: (){
                Get.back();
                Get.back();


              }, btnTitle: "Cancel"),
          // SizedBox(height: 24,),






        ],
      ),
    );
  }
}
