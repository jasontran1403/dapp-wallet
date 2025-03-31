import 'package:crypto_wallet/UI/Screens/addAccount/addAccount.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/appController.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../createAccount/connectWallet.dart';


class ManageAccounts extends StatefulWidget {
  ManageAccounts({super.key});

  @override
  State<ManageAccounts> createState() => _ManageAccountsState();
}

class _ManageAccountsState extends State<ManageAccounts> {
  final appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor.value,
      body: Obx(
            () => SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0,vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(

                            onTap:(){
                              Get.back();

                            },
                            child: Icon(Icons.arrow_back_ios,color: headingColor.value,size: 18,)),
                        SizedBox(width: 8,),
                        Text(
                          "${getTranslated(context,"Your Accounts" )??"Your Accounts"}",
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
                    InkWell(
                      onTap: (){
                        Get.to(AddAccount());
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: inputFieldBackgroundColor.value,
                          border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                        ),
                        child: Icon(Icons.add,size: 20,color:appController.isDark.value==true? Color(0xffA2BBFF): headingColor.value,),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24,),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: 3,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 16,);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        // height: 80,
                        width: Get.width,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: inputFieldBackgroundColor2.value,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                        ),
                        child:
                        Row
                          (
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color:appController.isDark.value==true? Color(0xff1A2B56):inputFieldBackgroundColor.value,
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child:  Center(
                                child: Text(
                                  "E",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: headingColor.value,
                                    fontFamily: "dmsans",
                  
                                  ),
                  
                                ),
                              ),
                            ),
                            SizedBox(width: 12,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Edric Jaye",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16.5,
                                      fontWeight: FontWeight.w600,
                                      color: headingColor.value,
                                      fontFamily: "dmsans",
                  
                                    ),
                  
                                  ),
                                  Text(
                                    "\$0.00",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: lightTextColor.value,
                                      fontFamily: "dmsans",
                  
                                    ),
                  
                                  ),
                                ],
                              ),
                            ),
                  
                            SizedBox(width: 12,),
                            Icon(Icons.arrow_forward_ios,color: headingColor.value,size: 18,)
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20,),

                BottomRectangularBtn(onTapFunc: (){

                  Get.to(ConnectWallet());
                }, btnTitle: "Add / Connect Wallet"),
                SizedBox(height: 20,),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
