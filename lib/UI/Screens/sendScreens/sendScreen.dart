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
  final String symbol;
  final String balance;
  final String price;

  // Nhận walletAddress và amount từ SendScreen
  const SendScreen({
    required this.symbol,
    required this.balance,
    required this.price,
    super.key
  });

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
                        "${getTranslated(context,"Send" )??"Send"}  ${widget.symbol}",
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
                headerText: "Address",
                hintText: "Enter address",
                onChange: (val){
                  setState(() {

                  });
                },


              ),
              SizedBox(height: 18,),
              Text(
                'Balance available: ${widget.balance} ${widget.symbol}',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor.value,
                  fontFamily: "dmsans",
                ),
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
                  ],
                ),
                inputType: TextInputType.number,
                hasHeader: true,
                headerText: "Amount",
                hintText: "Enter amount",
                onChange: (v){
                  setState(() {
                  });
                },
              ),
              SizedBox(height: 24,),
              BottomRectangularBtn(
                  onTapFunc: () {
                    String walletAddress = nameAddreeC.text; // Get the wallet address input by the user
                    String amountText = amountC.text; // Get the amount input by the user

                    // Check if wallet address is empty
                    if (walletAddress.isEmpty) {
                      // Show error if wallet address is empty
                      Get.snackbar(
                        "Error",
                        "Recipient wallet address cannot be empty.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    // Convert amount to double for comparison
                    double amount = double.tryParse(amountText) ?? 0;

                    // Check if amount is valid and less than the balance
                    if (amount <= 0) {
                      // Show error if amount is not a valid number
                      Get.snackbar(
                        "Error",
                        "Please enter a valid amount.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    double balance = double.tryParse(widget.balance.toString()) ?? 0;

                    if (amount > balance) {
                      // Show error if amount is greater than the available balance
                      Get.snackbar(
                        "Error",
                        "Insufficient balance to transfer the amount.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    // If all checks pass, navigate to the confirmation screen
                    Get.to(ConformationScreen(walletAddress: walletAddress, amount: amountText, symbol: widget.symbol, price: widget.price));
                  },
                  btnTitle: "Next"
              ),

              SizedBox(height: 24,),
            ],
          ),
        ),
      ),
    );
  }
}
