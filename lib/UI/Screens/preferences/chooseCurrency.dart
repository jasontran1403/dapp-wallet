import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widgets/inputField.dart';
class ChooseCurrency extends StatefulWidget {
  const ChooseCurrency({super.key});

  @override
  State<ChooseCurrency> createState() => _ChooseCurrencyState();
}

class _ChooseCurrencyState extends State<ChooseCurrency> {
  AppController appController=Get.find<AppController>();

  List coins=[
    {
      "image":"assets/images/usd.png",
      "symbol":"USD",
      "price1":"\$1,571.45",
      "price2":"\$1,571.45",
      "percentage":"8.75%",
      "chain":""
    },
    {
      "image":"assets/images/eur.png",
      "symbol":"EUR",
      "price1":"\$1,571.45",
      "price2":"\$1,571.45",
      "percentage":"8.75%",
      "chain":""
    },
    {
      "image":"assets/images/ngn.png",
      "symbol":"NGN",
      "price1":"\$1,571.45",
      "price2":"\$1,571.45",
      "percentage":"8.75%",
      "chain":""
    },
    {
      "image":"assets/images/usd.png",
      "symbol":"USD",
      "price1":"\$1,571.45",
      "price2":"\$1,571.45",
      "percentage":"8.75%",
      "chain":""
    },
    {
      "image":"assets/images/eth.png",
      "symbol":"ETH",
      "price1":"\$1,571.45",
      "price2":"\$1,571.45",
      "percentage":"8.75%",
      "chain":""
    },
    {
      "image":"assets/images/bttc.png",
      "symbol":"BTC",
      "price1":"\$1,571.45",
      "price2":"\$1,571.45",
      "percentage":"8.75%",
      "chain":""
    },
    {
      "image":"assets/images/usdt.png",
      "symbol":"USD",
      "price1":"\$1,571.45",
      "price2":"\$1,571.45",
      "percentage":"8.75%",
      "chain":"bnb"
    },
    {
      "image":"assets/images/usd.png",
      "symbol":"USD",
      "price1":"\$1,571.45",
      "price2":"\$1,571.45",
      "percentage":"8.75%",
      "chain":""
    },
    {
      "image":"assets/images/usd.png",
      "symbol":"USD",
      "price1":"\$1,571.45",
      "price2":"\$1,571.45",
      "percentage":"8.75%",
      "chain":""
    },

  ];
  List fiat=[
    {
      "image":"assets/images/Ellipse 26.png",
      "symbol":"USD",

    },
    {
      "image":"assets/images/Ellipse 26 (1).png",
      "symbol":"GBP",

    },
    {
      "image":"assets/images/Ellipse 28.png",
      "symbol":"AUD",

    },


  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor.value,
      body: SafeArea(child: selectCurrency()),
    );
  }
  Widget selectCurrency(){
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: primaryBackgroundColor.value,

      ),
      padding: EdgeInsets.symmetric(horizontal: 22,vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${getTranslated(context,"Choose Currency" )??"Choose Currency"}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: headingColor.value,
                  fontFamily: "dmsans",

                ),
              ),
              GestureDetector(

                onTap:(){
                  Get.back();

                },
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: inputFieldBackgroundColor2.value,
                      border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                  ),
                  child: Icon(Icons.clear,size: 18,color:appController.isDark.value==true?Color(0xffA2BBFF):  headingColor.value,),
                ),
              )




            ],
          ),
          SizedBox(height: 16,),
          Expanded(
            child: ListView(
              children: [

                InputFields(


                  icon:Image.asset("assets/images/Search.png")
                  ,
                  hintText: '',
                ),
                SizedBox(height: 16,),


                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 23,
                      width: 100,
                      decoration: BoxDecoration(
                          // color: inputFieldBackgroundColor2.value,
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
                    Expanded(child: Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 1,)),

                  ],
                ),
                SizedBox(height: 16,),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),

                  itemCount:fiat.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 12,);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return  GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        height:59,
                        width: Get.width,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            // color: inputFieldBackgroundColor2.value,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                        ),
                        child: Row(
                          children: [
                            Container(
                                height:24,
                                width: 24,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle
                                ),
                                child: Image.asset("${fiat[index]['image']}",height: 40,width: 40,)),

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
                                                "US Dollars",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: headingColor.value,
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
                                                "USD",
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
                SizedBox(height: 16,),


                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 23,
                      width: 63,
                      decoration: BoxDecoration(
                          // color: inputFieldBackgroundColor2.value,
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
                    Expanded(child: Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 1,)),

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
                        Get.back();
                      },
                      child: Container(
                        height:59,
                        width: Get.width,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                        ),
                        child: Row(
                          children: [
                            Container(
                                height:24,
                                width:24,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle
                                ),
                                child: Image.asset("assets/images/Ellipse 26 (3).png",height: 40,width: 40,)),

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
                                                "Azerbaijan",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: headingColor.value,
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
                                                "AZN",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 13,
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
          )







        ],
      ),
    );
  }
}
