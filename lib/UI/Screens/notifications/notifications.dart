import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:intl/intl.dart';

import 'package:shimmer/shimmer.dart';



class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var isNotifications=true.obs;
  AppController appController=Get.find<AppController>();



  List notificationLists=[
    {
      "type":"Send",
      "image":"assets/images/Frame 946.png",
      "text":"Your withdrawal of 0.5 BTC to your wallet address ending in 1A3F was successful.",
      "isRead":false,
      "time":"12 Feb, 2024 16:00"
    },

    {
      "type":"Deposit",
      "image":"assets/images/Frame 946.png",
      "text":"You have successfully deposited 0.2 BTC into your account.",
      "isRead":true,
      "time":"12 Feb, 2024 16:00"
    },
    {
      "type":"Swap",
      "image":"assets/images/cart11.png",
      "text":"Your swap of 50 USDT to 0.002 BTC has been initiated and is being processed.",
      "isRead":true,
      "time":"12 Feb, 2024 16:00"
    },


  ];
  Map<String, HighlightedWord> words =  {
    "0.5 BTC": HighlightedWord(
      onTap: () {
        print("Flutter");
      },
      textStyle: TextStyle(
        fontSize : 12,
        fontFamily: "dmsans",
        fontWeight  :FontWeight.w500,
        color :headingColor.value,

      ),
    ),

    "0.2 BTC": HighlightedWord(
      onTap: () {
        print("open-source");
      },
      textStyle: TextStyle(
        fontSize : 12,
        fontFamily: "dmsans",
        fontWeight  :FontWeight.w500,
        color :headingColor.value,

      ),
    ),
    "0.002 BTC": HighlightedWord(
      onTap: () {
        print("open-source");
      },
      textStyle: TextStyle(
        fontSize : 12,
        fontFamily: "dmsans",
        fontWeight  :FontWeight.w500,
        color :headingColor.value,

      ),
    ),
    "50 USDT": HighlightedWord(
      onTap: () {
        print("open-source");
      },
      textStyle: TextStyle(
        fontSize : 12,
        fontFamily: "dmsans",
        fontWeight  :FontWeight.w500,
        color :headingColor.value,

      ),
    ),




  };




  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Obx(() =>  Scaffold(
      backgroundColor: primaryBackgroundColor.value,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 17,
                      width: 17,
                      decoration: BoxDecoration(
                        // border: Border.all(width: 1,color: dividerColor.value),
                        borderRadius: BorderRadius.circular(8),
                        color: primaryBackgroundColor.value,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: headingColor.value,
                        size: 18,
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("${getTranslated(context,"Notifications" )??"Notifications"}    ",
                            // textAlign: TextAlign.s,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "dmsans",
                              fontWeight: FontWeight.w600,
                              color: headingColor.value,
                            )),
                      ],
                    ),
                  ),

                ],
              ),

              SizedBox(height: 24,),
              Expanded(
                child:

                ListView.separated(
                  physics: ClampingScrollPhysics(),
                  itemCount:notificationLists.length,
                  separatorBuilder: (BuildContext context, int index) {


                    return SizedBox(height: 8,);
                  },
                  itemBuilder: (BuildContext context, int index) {


                    return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color:notificationLists[index]['isRead']==true?primaryBackgroundColor.value: inputFieldBackgroundColor.value),
                        color: notificationLists[index]['isRead']==true? primaryBackgroundColor.value:inputFieldBackgroundColor2.value,
                        borderRadius: BorderRadius.circular(12),
                        // border: Border.all(width: 1,color: lightGrey.value)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 32,
                              width: 32,
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
borderRadius: BorderRadius.circular(8),                                  color:

                                  notificationLists[index]['type']=="Send"?

                                  Color(0xffFF5C5C):
                                  notificationLists[index]['type']=="Deposit"?
                                  Color(0xff13E69F):

                                  Color(0xff1A2B56)

                              ),
                              child:
                              notificationLists[index]['type']=="Send"?
                              SvgPicture.asset("assets/svgs/Arrow Top Right 1.svg"):
                              notificationLists[index]['type']=="Deposit"?
                              SvgPicture.asset("assets/svgs/Arrow Down 1.svg"):
                              SvgPicture.asset("assets/svgs/a swap.svg")



                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${notificationLists[index]['type']}", // You need to pass the string you want the highlights

                                      style:TextStyle(
                                        fontSize : 12.5,
                                        fontFamily: "dmsans",
                                        fontWeight  :FontWeight.w600,
                                        color :blueCard1.value,

                                      ),
                                      textAlign: TextAlign.start, // You can use any attribute of the RichText widget
                                    ),
                                    Text(
                                        "12 Feb, 2024 16:00",
                                        textAlign : TextAlign.center,
                                        style :TextStyle(
                                          fontSize : 12,
                                          fontFamily: "dmsans",
                                          fontWeight  :FontWeight.w400,

                                          color :appController.isDark.value==true? Color(0xff6C7CA7):lightTextColor.value,

                                        )),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(

                                  children: [
                                    Flexible(
                                      child: TextHighlight(

                                        text: "${notificationLists[index]['text']}", // You need to pass the string you want the highlights
                                        words:  words, // Your dictionary words
                                        textStyle:TextStyle(
                                          fontSize : 12,
                                          fontFamily: "dmsans",
                                          fontWeight  :FontWeight.w400,
                                          color :appController.isDark.value==true? Color(0xffA2BBFF):lightTextColor.value,

                                        ),
                                        textAlign: TextAlign.start, // You can use any attribute of the RichText widget
                                      ),
                                    ),
                                  ],
                                )
                                ,

                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),



            ],
          ),
        ),
      ),
    ));



  }

  String? _extractNumberFromMessage(String message) {
    RegExp regExp = RegExp(r'\b\d+(\.\d+)?\b'); // Matches integers and decimal numbers
    Iterable<RegExpMatch> matches = regExp.allMatches(message);

    for (var match in matches) {
      String? number = match.group(0);
      if (number != null && number.contains('.')) {
        return number; // Return the first decimal number found
      }
    }

    // If no decimal number is found, return the first integer
    return matches.isNotEmpty ? matches.first.group(0) : null;
  }


}


