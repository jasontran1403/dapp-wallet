import 'dart:ffi';

import 'package:crypto_wallet/UI/Screens/sendScreens/conformationScreen.dart';
import 'package:crypto_wallet/UI/common_widgets/bottomRectangularbtn.dart';
import 'package:crypto_wallet/UI/common_widgets/inputField.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../codeScanner.dart';
class SendScreen extends StatefulWidget {
  const SendScreen({super.key});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
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
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 22,vertical: 20),

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(

                          onTap:(){
                            Get.back();

                          },
                          child: Icon(

                            Icons.arrow_back_ios,color: darkBlueColor.value,size: 16,)),
                      SizedBox(width: 8,),
                      Text(
                        "${getTranslated(context,"Send" )??"Send"}  ETH",
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
                  Row(
                    children: [

                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Container(
                          height: 32,
                          width: 32,
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: inputFieldBackgroundColor.value,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: SvgPicture.asset("assets/svgs/mdi_contact-outline.svg",color: headingColor.value,)
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 20,),
              InputFields2(
                textController: nameAddreeC,
                suffixIcon: Row
                  (
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 21,
                      width: 46,
                      decoration: BoxDecoration(


                          gradient: LinearGradient(
                              tileMode: TileMode.clamp,
                              begin: Alignment.topCenter,

                              end: Alignment.bottomCenter,

                              colors:nameAddreeC.text==""?[lightTextColor.value,lightTextColor.value,]: [Color(0xff76CF56),Color(0xff55DDAF),]),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child:  Center(
                        child: Text(
                          "${getTranslated(context,"Paste" )??"Paste"}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: primaryBackgroundColor.value,
                            fontFamily: "dmsans",

                          ),

                        ),
                      ),
                    ),
                    SizedBox(width: 8,),
                    GestureDetector(
                        onTap: (){
                          Get.to(CodeScanner1());
                        },
                        child: SvgPicture.asset("assets/svgs/qr.svg")),
                    SizedBox(width: 10,),

                  ],
                ),
                hasHeader: true,
                headerText: "Name or Address",
                hintText: "Enter Name or Address",
                onChange: (val){
                  setState(() {

                  });
                },


              ),
              SizedBox(height: 16,),
              InputFields2(
                textController: amountC,
                suffixIcon: Row
                  (
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 21,
                      width: 46,
                      decoration: BoxDecoration(


                          gradient: LinearGradient(
                            tileMode: TileMode.clamp,
                              begin: Alignment.topCenter,

                             end: Alignment.bottomCenter,

                              colors:amountC.text==""?[lightTextColor.value,lightTextColor.value,]: [Color(0xff76CF56),Color(0xff55DDAF),]),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child:  Center(
                        child: Text(
                          "${getTranslated(context,"MAX" )??"MAX"}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: primaryBackgroundColor.value,
                            fontFamily: "dmsans",

                          ),

                        ),
                      ),
                    ),
                    SizedBox(width: 8,),
                    GestureDetector(
                        onTap: (){
                          Get.to(CodeScanner1());
                        },
                        child: SvgPicture.asset("assets/svgs/qr.svg")),
                    SizedBox(width: 10,),

                  ],
                ),
                inputType: TextInputType.number,
                hasHeader: true,
                headerText: "Amount",
                hintText: "Enter Name or Address",
                onChange: (v){
                  setState(() {

                  });
                },


              ),
              SizedBox(height: 32,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${getTranslated(context,"Recent transfers" )??"Recent transfers"}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: headingColor.value,
                      fontFamily: "dmsans",

                    ),

                  ),
                  GestureDetector(
                      onTap: (){
                        isOpen.value=!isOpen.value;
                      },
                      child: Icon(
                        // isOpen.value==true?Icons.keyboard_arrow_up_sharp:

                        Icons.keyboard_arrow_down_sharp,size: 27,color: headingColor.value,))
                ],
              ),

              isOpen==false?SizedBox():  AnimatedSize(
                duration: Duration(
                  milliseconds: 5000,
                ),
                curve: Curves.decelerate,
                child: GridView.builder(


                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 20, top: 10),
                    physics: ClampingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 300, childAspectRatio: 7 / 7.7, crossAxisSpacing: 12, mainAxisSpacing: 12),
                    itemCount: 4,
                    itemBuilder: (BuildContext ctx, index) {
                      return Container(
                        // width: 187,
                        padding: EdgeInsets.all(12),
                        decoration:
                        BoxDecoration(border: Border.all(width: 1, color: inputFieldBackgroundColor.value), color: primaryBackgroundColor.value, borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100), color: Colors.grey.shade50, border: Border.all(width: 2, color: primaryBackgroundColor.value)),
                              child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: inputFieldBackgroundColor.value,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child:
                                      //if user name empty then show image otherwise show name first character
                                      index!=3?
                                  Center(
                                    child: Text(
                                      "E",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: headingColor.value,
                                        fontFamily: 'dmsans',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ):
                                  Image.asset("assets/images/3d_avatar_21.png")),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text(

                                  //if user name empty then show star
                                index==3?"*****":  "Edric Jaye",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: headingColor.value,
                                    fontFamily: 'dmsans',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "40.00",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: headingColor.value,
                                    fontFamily: 'dmsans',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  " ETH",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: lightTextColor.value,
                                    fontFamily: 'dmsans',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),


                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "0x00...001dsax ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: lightTextColor.value,
                                    fontFamily: 'dmsans',
                                  ),
                                ),
                                SvgPicture.asset("assets/svgs/copyIcon.svg",color: headingColor.value,)

                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(height: 24,),
              BottomRectangularBtn(onTapFunc: (){

                Get.to(ConformationScreen());
              }, btnTitle: "Next"),
              SizedBox(height: 24,),


            ],
          ),
        ),
      ),
    );
  }
}
