import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class ReceiveScreen extends StatefulWidget {
  const ReceiveScreen({super.key});

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  AppController appController=Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor.value,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 22,vertical: 20),
          children: [
           Row(
             children: [
               GestureDetector(

                   onTap:(){
                     Get.back();

                   },
                   child: Icon(Icons.arrow_back_ios,color: headingColor.value,size: 18,)),
               SizedBox(width: 8,),
               Text(
                 "${getTranslated(context,"Receive" )??"Receive"}",
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
            SizedBox(height: 32,),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle
                    ),
                    child: Image.asset('assets/images/usd.png')),
                SizedBox(width: 10,),
                Text(
                  "USDC",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: headingColor.value,
                    fontFamily: "dmsans",

                  ),

                ),
              ],
            ),
            SizedBox(height: 32,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 227,
                  width: 227,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: inputFieldBackgroundColor.value,
                    border: Border.all(width: 1,color: inputFieldBackgroundColor2.value)
                  ),
                  child: Image.asset("assets/images/Mask group.png",color: appController.isDark.value==true?headingColor.value:primaryColor.value,),
                ),
              ],
            ),
            SizedBox(height: 32,),
            Text(
              "${getTranslated(context,"Send only the specified coins to this deposit address. This address does NOT support deposit of non-fungible token." )??"Send only the specified coins to this deposit address. This address does NOT support deposit of non-fungible token."}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: lightTextColor.value,
                fontFamily: "dmsans",

              ),

            ),
            SizedBox(height: 32,),
            Divider(height: 1,color: inputFieldBackgroundColor2.value,),
            SizedBox(height: 24,),
            Text(
              "${getTranslated(context,"Deposit Address" )??"Deposit Address"}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: lightTextColor.value,
                fontFamily: "dmsans",

              ),

            ),
            SizedBox(height: 16,),
            Text(
              "0x000ahdkakckoeiwkwkojxiz",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: headingColor.value,
                fontFamily: "dmsans",

              ),

            ),

            SizedBox(height: 44,),


            Row(
              children: [
                Expanded(
                  child: Container(
                    height:
                    50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: inputFieldBackgroundColor2.value,
                      border: Border.all(width: 1,color: primaryColor.value)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/svgs/ic_round-share.svg",color: primaryColor.value,),
                        SizedBox(width: 10,),

                        Text(
                          "${getTranslated(context,"Share" )??"Share"}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: primaryColor.value,
                            fontFamily: "dmsans",

                          ),

                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Container(
                    height:
                    50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: primaryColor.value
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/svgs/Test.svg"),
                        SizedBox(width: 10,),

                        Text(
                          "${getTranslated(context,"Copy" )??"Copy"}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffFFFFFF),
                            fontFamily: "dmsans",

                          ),

                        ),
                      ],
                    ),
                  ),
                )
              ],
            )










          ],
        ),
      ),
    );
  }
}
