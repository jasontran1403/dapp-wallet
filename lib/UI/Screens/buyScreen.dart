import 'package:crypto_wallet/UI/common_widgets/bottomRectangularbtn.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../common_widgets/inputField.dart';
class BuyScreen extends StatefulWidget {
  const BuyScreen({super.key});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
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
    return Obx(
      ()=> Scaffold(
        backgroundColor: primaryBackgroundColor.value,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(height: 70,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
          
                            onTap:(){
                              Get.back();
          
                            },
                            child: Icon(Icons.arrow_back_ios,color: darkBlueColor.value,size: 18,)),
                        SizedBox(width: 8,),
                        Text(
                          "${getTranslated(context,"Buy" )??"Buy"} ETH",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:15,
                            fontWeight: FontWeight.w600,
                            color: darkBlueColor.value,
                            fontFamily: "dmsans",
          
                          ),
          
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        Get.bottomSheet(
                            clipBehavior: Clip.antiAlias,
                            isScrollControlled: true,
                            backgroundColor: primaryBackgroundColor.value,
                            shape: OutlineInputBorder(
                                borderSide: BorderSide.none, borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32))),
                            selectCurrency());
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
          
                            ),
                            child: Image.asset("assets/images/Ellipse 26 (1).png"),
                          ),
                          Icon(Icons.keyboard_arrow_down_outlined,size: 27,color: headingColor.value,)
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
          
          
          
                        Text(
                          "\$",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:54,
                            fontWeight: FontWeight.w700,
                            color: headingColor.value,
                            fontFamily: "dmsans",
          
                          ),
          
                        ),
                        Container(
                           width:150,
                          child: TextFormField(

                            showCursor: false,
          
                            autofocus: true,
                            keyboardType: TextInputType.number,
          
                            style: TextStyle(
                              fontSize:54,
                              fontWeight: FontWeight.w700,
                              color: headingColor.value,
                              fontFamily: "dmsans",
          
          
                            ),
          
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 0),
                              border:OutlineInputBorder(
                                  borderSide: BorderSide.none
                              ),
                              focusedBorder:OutlineInputBorder(
                                  borderSide: BorderSide.none
                              ),
                              enabledBorder:OutlineInputBorder(
                                  borderSide: BorderSide.none
                              ),
                            ),
                          ),
                        ),
          
          
          
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
          
          
          
                        Text(
                          "USD Dollars",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:16,
                            fontWeight: FontWeight.w400,
                            color: lightTextColor.value,
                            fontFamily: "dmsans",
          
                          ),),
          
          
                      ],
                    ),
                    SizedBox(height: 12,),
          
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
          
          
          
                        Text(
                          "≈ 0.00832 ETH",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:18,
                            fontWeight: FontWeight.w400,
                            color: lightTextColor.value,
                            fontFamily: "dmsans",
          
                          ),),
          
                      ],
                    ),
          
                  ],
                ),
                Column(
                  children: [
          
                    Container(
                      height: 58,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color:appController.isDark.value==true?Color(0xff1A1930): Color(0xffF7F9FC),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset("assets/svgs/wallet.svg"),
                          SizedBox(width: 12,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${getTranslated(context,"Pay with Credit Card  or Bank" )??"Pay with Credit Card  or Bank"}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff8F9BB3),
                                  fontFamily: "dmsans",
          
                                ),),
                              Text(
                                "${getTranslated(context,"with Transik" )??"with Transik"}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff8F9BB3),
                                  fontFamily: "dmsans",
          
                                ),),
                            ],
                          ),
          
                        ],
                      ),
                    ),
                    SizedBox(height: 24,),
                    BottomRectangularBtn(onTapFunc: (){
                      Get.back();
                      Get.back();
          
                    }, btnTitle: "Buy"),
                    SizedBox(height: 24,),
          
          
                  ],
                )
          
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget selectCurrency(){
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
                ),
                SizedBox(height: 16,),


                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 23,
                      width: 100,
                      decoration: BoxDecoration(
                          color: inputFieldBackgroundColor2.value,
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
                            color: inputFieldBackgroundColor2.value,
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
                          color: inputFieldBackgroundColor2.value,
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
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        height:59,
                        width: Get.width,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: inputFieldBackgroundColor2.value,
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
