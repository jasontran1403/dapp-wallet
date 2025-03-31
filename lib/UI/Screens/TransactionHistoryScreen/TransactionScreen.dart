import 'package:crypto_wallet/UI/Screens/TransactionHistoryScreen/transactionHistoryDetails.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {


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
            children: [
              Row(
                children: [
                  Text(
                    "${getTranslated(context,"Transactions" )??"Transactions"}",
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


              Expanded(
                child: ListView.separated(

                  itemCount: transaction.length,
                  padding: EdgeInsets.only(bottom: 20),
                  separatorBuilder: (BuildContext context, int index) {
                    return  SizedBox(height: 12,);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return   GestureDetector(
                      onTap: (){
                        Get.to(TransactionHistoryDetails(type:   "${transaction[index]['type']}",));
                      },
                      child: Container(
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
                                  "${transaction[index]['type']}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: darkBlueColor.value,
                                    fontFamily: "dmsans",

                                  ),

                                ),
                                Row(
                                  children: [
                                    if(transaction[index]['type']=="Send")
                                    Row(
                                      children: [
                                        Text(
                                          "To: ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: lightTextColor.value,
                                            fontFamily: "dmsans",

                                          ),

                                        ),
                                        Text(
                                          "0x000.0da0c0gb0",
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
                                    if(transaction[index]['type']=="Receive")
                                      Row(
                                        children: [
                                          Text(
                                            "From: ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: lightTextColor.value,
                                              fontFamily: "dmsans",

                                            ),

                                          ),
                                          Text(
                                            "0x000.0da0c0gb0",
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

                                    SizedBox(width: 10,),

                                    Container(
                                      height: 20,
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      decoration: BoxDecoration(
                                          color:transaction[index]['status']=="Completed"? Color(0xff0FC085):
                                          transaction[index]['status']=="Rejected"? Color(0xffC03A0F):
                                          Color(0xffFF9900)
                                          ,
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Center(
                                        child: Text(
                                         "${transaction[index]['status']}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600,
                                            color: primaryBackgroundColor.value,
                                            fontFamily: "dmsans",

                                          ),

                                        ),
                                      )
                                      ,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 7,),

                            Divider(color: inputFieldBackgroundColor.value,height: 1,thickness: 1,),
                            SizedBox(height: 3,),
                            if(transaction[index]['type']=="Send"||transaction[index]['type']=="Receive")
                            Column(
                              children: [
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
                                      "${getTranslated(context,"Date" )??"Date"}",
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
                                SizedBox(height: 3,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "0.68612 ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: headingColor.value,
                                            fontFamily: "dmsans",

                                          ),

                                        ),
                                        Text(
                                          "ETH",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: lightTextColor.value,
                                            fontFamily: "dmsans",

                                          ),

                                        ),
                                      ],
                                    ),
                                    Text(
                                      "17 Sep 2023  11:21 AM",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: headingColor.value,
                                        fontFamily: "dmsans",

                                      ),

                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if(transaction[index]['type']=="Swap")

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                        SizedBox(height: 3,),
                                    
                                        Row(
                                          children: [
                                            Text(
                                              "0.68612 ",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: headingColor.value,
                                                fontFamily: "dmsans",
                                    
                                              ),
                                    
                                            ),
                                            Text(
                                              "ETH",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: lightTextColor.value,
                                                fontFamily: "dmsans",
                                    
                                              ),
                                    
                                            ),
                                          ],
                                        ),
                                    
                                    
                                      ],
                                    ),
                                  ),
                                  Image.asset("assets/images/arrow-2.png",color: headingColor.value,height: 20,width: 20,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                    
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${getTranslated(context,"To" )??"To"}",
                                          // textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: lightTextColor.value,
                                            fontFamily: "dmsans",
                                    
                                          ),
                                    
                                        ),
                                        SizedBox(height: 3,),
                                    
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "0.68612 ",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: headingColor.value,
                                                fontFamily: "dmsans",
                                    
                                              ),
                                    
                                            ),
                                            Text(
                                              "ETH",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: lightTextColor.value,
                                                fontFamily: "dmsans",
                                    
                                              ),
                                    
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
        ),
      ),

    );
  }
}
