import 'dart:ffi';

import 'package:crypto_wallet/UI/Screens/TransactionHistoryScreen/TransactionScreen.dart';
import 'package:crypto_wallet/UI/common_widgets/bottomRectangularbtn.dart';
import 'package:crypto_wallet/UI/common_widgets/inputField.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../codeScanner.dart';
class ConformationScreen extends StatefulWidget {
  const ConformationScreen({super.key});

  @override
  State<ConformationScreen> createState() => _ConformationScreenState();
}

class _ConformationScreenState extends State<ConformationScreen> {
  TextEditingController nameAddreeC=TextEditingController();
  TextEditingController amountC=TextEditingController();
  var isOpen=true.obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          ()=> Scaffold(
        backgroundColor: primaryBackgroundColor.value,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22,vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${getTranslated(context,"Confirmation" )??"Confirmation"}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: headingColor.value,
                            fontFamily: "dmsans",

                          ),

                        ),

                        GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: inputFieldBackgroundColor.value,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Icon(Icons.clear,size: 18,color: headingColor.value,),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      "${getTranslated(context,"Confirm Transfer" )??"Confirm Transfer"}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: headingColor.value,
                        fontFamily: "dmsans",

                      ),

                    ),
                    SizedBox(height: 12,),



                    Text(
                      "${getTranslated(context,"We care about your privacy.  Please make sure that you want to transfer money." )??"We care about your privacy.  Please make sure that you want to transfer money."}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: lightTextColor.value,
                        fontFamily: "dmsans",

                      ),

                    ),





                    SizedBox(height: 60,),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height:350,
                          width: Get.width,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              color: inputFieldBackgroundColor2.value,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child:
                          Column(
                            children: [
                              SizedBox(height: 57,),
                              Text(
                                "Edric Jaye",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: headingColor.value,
                                  fontFamily: "dmsans",

                                ),

                              ),
                              SizedBox(height: 12,),
                              Text(
                                "0x00...001dsax",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: lightTextColor.value,
                                  fontFamily: "dmsans",

                                ),

                              ),
                              SizedBox(height: 32,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "25",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w700,
                                      color: headingColor.value,
                                      fontFamily: "dmsans",

                                    ),

                                  ),
                                  Text(
                                    " ETH",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: lightTextColor.value,
                                      fontFamily: "dmsans",

                                    ),),
                                ],
                              ),
                              SizedBox(height: 10,),

                              Text(
                                "USDT \$2580",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: lightTextColor.value,
                                  fontFamily: "dmsans",

                                ),),

                              SizedBox(height: 60,),
                              Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 1,),
                              SizedBox(height: 10,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${getTranslated(context,"Transfer Fee" )??"Transfer Fee"}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: lightTextColor.value,
                                      fontFamily: "dmsans",

                                    ),),
                                  Text(
                                    "\$0.00USD",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: headingColor.value,
                                      fontFamily: "dmsans",

                                    ),),
                                ],
                              ),

                            ],
                          ),
                        ),
                        Positioned(
                            top: -38,
                            child: Container(
                              width: Get.width-44,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container
                                                      (
                                                      height: 75,
                                                      width: 75,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                  color: inputFieldBackgroundColor2.value,
                                  border:Border.all(width:1,color: primaryBackgroundColor.value)
                                                      ),
                                    child:            Center(
                                      child: Text(
                                        "E",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: headingColor.value,
                                          fontFamily: "dmsans",

                                        ),

                                      ),
                                    ),
                                                    ),
                                ],
                              ),
                            ))
                      ],
                    ),



                    SizedBox(height: 60,),




                  ],
                ),
                Column(
                  children: [


                    BottomRectangularBtn(onTapFunc: (){

                      Get.bottomSheet(
                          clipBehavior: Clip.antiAlias,
                          isScrollControlled: true,
                          backgroundColor: primaryBackgroundColor.value,
                          shape: OutlineInputBorder(
                              borderSide: BorderSide.none, borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32))),
                          confirmStatus());                    }, btnTitle: "Send"),
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
  Widget confirmStatus(){
    return Container(
      height: Get.height*0.5,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 22,vertical: 22),
      color: primaryBackgroundColor.value,
      child: Column(
        children: [

          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff76CF56).withOpacity(0.20),
                  Color(0xff55DDAF).withOpacity(0.20),
                ]
              ),
              shape: BoxShape.circle
            ),
            child: Center(child: SvgPicture.asset("assets/svgs/shield-tick.svg")),
          ),
          SizedBox(height: 32,),
          Text(
            "${getTranslated(context,"Transaction Completed" )??"Transaction Completed"}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: headingColor.value,
              fontFamily: "dmsans",

            ),),
          SizedBox(height: 10,),

          Text(
            "${getTranslated(context,"Your transaction has been completed, view details in transaction history." )??"Your transaction has been completed, view details in transaction history."}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: lightTextColor.value,
              fontFamily: "dmsans",

            ),),
          SizedBox(height: 32,),
          BottomRectangularBtn(onTapFunc: (){
            Get.to(TransactionScreen());
          }, btnTitle: "View History"),
          SizedBox(height: 8,),

          BottomRectangularBtn(
              onlyBorder: true,
              color: Colors.transparent,
              onTapFunc: (){
                Get.back();
                Get.back();
                Get.back();
                Get.back();



              }, btnTitle: "Home"),
          SizedBox(height: 16,),



        ],
      ),
    );
  }


}
