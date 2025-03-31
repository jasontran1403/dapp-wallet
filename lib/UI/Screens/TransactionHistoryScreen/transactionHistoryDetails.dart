import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
class TransactionHistoryDetails extends StatefulWidget {
  String? type;
   TransactionHistoryDetails({super.key,this.type});

  @override
  State<TransactionHistoryDetails> createState() => _TransactionHistoryDetailsState();
}

class _TransactionHistoryDetailsState extends State<TransactionHistoryDetails> {


  List transaction=[
    {
      "type":"Send",
      "status":"Completed",
    },
    {
      "type":"Receive",
      "status":"Pending",
    },
    {
      "type":"Swap",
      "status":"Completed",
    },
    {
      "type":"Send",
      "status":"Completed",
    },
    {
      "type":"Receive",
      "status":"Rejected",
    },
    {
      "type":"Send",
      "status":"Completed",
    },
    {
      "type":"Receive",
      "status":"Rejected",
    },
    {
      "type":"Send",
      "status":"Completed",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    children: [
                      GestureDetector(

                          onTap:(){
                            Get.back();

                          },
                          child: Icon(Icons.arrow_back_ios,color: darkBlueColor.value,size: 17,)),
                      SizedBox(width: 8,),
                      Text(
                        "${getTranslated(context,"Transaction Details" )??"Transaction Details"}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: darkBlueColor.value,
                          fontFamily: "dmsans",

                        ),

                      ),
                    ],
                  ),
                  SizedBox(height: 22,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                       widget.type=="Receive"||widget.type=="Swap"?"+0.002002": "-0.002002",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color:widget.type=="Receive"||widget.type=="Swap"?greenCardColor.value: darkBlueColor.value,
                          fontFamily: "dmsans",

                        ),

                      ),
                      SizedBox(width: 8,),
                      Text(
                        "ETH",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color:widget.type=="Receive"||widget.type=="Swap"?greenCardColor.value: darkBlueColor.value,
                          fontFamily: "dmsans",

                        ),

                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Text(
                    "≈ \$2580",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: lightTextColor.value,
                      fontFamily: "dmsans",

                    ),

                  ),
                  SizedBox(height: 32,),
                  Container(
                    // height: 100,
                    width: Get.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: inputFieldBackgroundColor2.value,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1,color: inputFieldBackgroundColor.value)

                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${getTranslated(context,"Transaction Type" )??"Transaction Type"}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: lightTextColor.value,
                                fontFamily: "dmsans",

                              ),

                            ),
                            Text(
                              "${getTranslated(context,"Timestamp" )??"Timestamp"}",
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
                                  "${widget.type}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: headingColor.value,
                                    fontFamily: "dmsans",

                                  ),

                                ),

                              ],
                            ),
                            Text(
                              "17 Sep 2023 11:21 AM",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: headingColor.value,
                                fontFamily: "dmsans",

                              ),

                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  widget.type=="Swap"?
                  Container(
                    // height: 100,
                    width: Get.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: inputFieldBackgroundColor2.value,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1,color: inputFieldBackgroundColor.value)

                    ),
                    child: Column(
                      children: [
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
                                    shape: BoxShape.circle,

                                  ),
                                  child:Image.asset("assets/images/eth.png") ,
                                ),
                                SizedBox(width: 8,),
                                Text(
                                  "Tether",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
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
                                    shape: BoxShape.circle,

                                  ),
                                  child:Image.asset("assets/images/bttc.png") ,
                                ),
                                SizedBox(width: 8,),

                                Text(
                              "Bitcoin",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: headingColor.value,
                                fontFamily: "dmsans",

                              ),)



                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16,),
                        Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 1,),

                        SizedBox(height: 16,),



                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${getTranslated(context,"Amount" )??"Amount"}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: lightTextColor.value,
                                fontFamily: "dmsans",

                              ),

                            ),
                            Text(
                              "${getTranslated(context,"Amount" )??"Amount"}",
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
                                  "0.68612  ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: headingColor.value,
                                    fontFamily: "dmsans",

                                  ),

                                ),
                                Text(
                                  "ETH",
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

                            Row(
                              children: [
                                Text(
                                  "0.68612  ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: headingColor.value,
                                    fontFamily: "dmsans",

                                  ),

                                ),
                                Text(
                                  "ETH",
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
                  ):
                  Container(
                    // height: 100,
                    width: Get.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: inputFieldBackgroundColor2.value,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1,color: inputFieldBackgroundColor.value)

                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.type=="Receive"?"From":  "To",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: lightTextColor.value,
                                fontFamily: "dmsans",

                              ),

                            ),
                            Text(
                              "${getTranslated(context,"Amount" )??"Amount"}",
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
                                  "0x000.0da0c0gb0",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: headingColor.value,
                                    fontFamily: "dmsans",

                                  ),

                                ),

                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "0.68612 ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: headingColor.value,
                                    fontFamily: "dmsans",

                                  ),

                                ),
                                Text(
                                  "ETH",
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
                  SizedBox(height: 16,),
                  Container(
                    // height: 100,
                    width: Get.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: inputFieldBackgroundColor2.value,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1,color: inputFieldBackgroundColor.value)

                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                            widget.type=="Swap"?"${getTranslated(context,"Routing Fee" )??"Routing Fee"}":  "${getTranslated(context,"Network Fee" )??"Network Fee"}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: lightTextColor.value,
                                fontFamily: "dmsans",

                              ),

                            ),
                            Text(
                              "${getTranslated(context,"Status" )??"Status"}",
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
                                  "0.000126",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: headingColor.value,
                                    fontFamily: "dmsans",

                                  ),

                                ),
                                Text(
                                  " ETH ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: lightTextColor.value,
                                    fontFamily: "dmsans",

                                  ),


                                ),
                                Text(
                                  "(\$0.07)",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: headingColor.value,
                                    fontFamily: "dmsans",

                                  ),

                                ),

                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "${getTranslated(context,"Completed" )??"Completed"} ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
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
                  )



                ],
              ),
              Column(
                children: [
                  Container(
                    height: 50,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xff76CF56).withOpacity(0.10),Color(0xff55DDAF).withOpacity(0.10)]

                      ),
                      border: Border.all(width: 1,color: Color(0xff76CF56),


                      )
                    ),
                    child: Center(
                      child: GradientText(
                        "${getTranslated(context,"View on block explorer" )??"View on block explorer"}",
                        textAlign: TextAlign.center,
    gradientDirection: GradientDirection.ttb,
    colors: [Color(0xff76CF56),Color(0xff55DDAF)],

    style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,

                          fontFamily: "dmsans",

                        ),

                      ),
                    ),
                  ),
                  SizedBox(height: 24,)

                ],
              )
            ],
          ),
        ),
      ),

    );
  }
}
