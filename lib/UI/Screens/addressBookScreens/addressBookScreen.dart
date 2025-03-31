import 'package:crypto_wallet/UI/Screens/addAccount/addAccount.dart';
import 'package:crypto_wallet/UI/Screens/addressBookScreens/addAdress.dart';
import 'package:crypto_wallet/UI/Screens/addressBookScreens/updateAddress.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/appController.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../createAccount/connectWallet.dart';


class AddressBookScreen extends StatefulWidget {
  AddressBookScreen({super.key});

  @override
  State<AddressBookScreen> createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> {
  final appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        backgroundColor: primaryBackgroundColor.value,
        body:  SafeArea(
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
                            "${getTranslated(context,"Address Book" )??"Address Book"}",
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
                          child: Icon(Icons.add,size: 20,color:appController.isDark.value==true?Color(0xffA2BBFF): headingColor.value,),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 24,),
                  Expanded(
                    //empty view hide below
                    child:
                    // Column(
                    //   children: [
                    //     Container(
                    //       height: 128,
                    //       width: 128,
                    //       padding: EdgeInsets.all(25),
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(24),
                    //         color: inputFieldBackgroundColor2.value,
                    //
                    //       ),
                    //       child: SvgPicture.asset("assets/svgs/mdi_contact-outline (1).svg"),
                    //     ),
                    //     SizedBox(height: 16,),
                    //
                    //     Text(
                    //       "${getTranslated(context,"Your Address Book is empty" )??"Your Address Book is empty"}",
                    //       textAlign: TextAlign.start,
                    //       style: TextStyle(
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.w700,
                    //         color: headingColor.value,
                    //         fontFamily: "dmsans",
                    //
                    //       ),
                    //
                    //     ),
                    //     SizedBox(height: 16,),
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    //       child: Text(
                    //         "${getTranslated(context,"Click the “+” or “Add Address” buttons to add your favorite addresses." )??"Click the “+” or “Add Address” buttons to add your favorite addresses."}",
                    //         textAlign: TextAlign.center,
                    //         style: TextStyle(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w400,
                    //           color: lightTextColor.value,
                    //           fontFamily: "dmsans",
                    //
                    //         ),
                    //
                    //       ),
                    //     ),
                    //     SizedBox(height: 16,),
                    //
                    //     InkWell(
                    //       onTap: (){
                    //         Get.to(AddAdress());
                    //       },
                    //       child: Container(height: 50,
                    //         width: Get.width*0.7,
                    //         decoration: BoxDecoration(
                    //             color: inputFieldBackgroundColor2.value,
                    //             borderRadius: BorderRadius.circular(66)
                    //         ),
                    //         child:  Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Icon(Icons.add,color: headingColor.value,size: 20,),
                    //             SizedBox(width: 10,),
                    //             Text(
                    //               "${getTranslated(context,"Add address" )??"Add address"}",
                    //               textAlign: TextAlign.start,
                    //               style: TextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w700,
                    //                 color: headingColor.value,
                    //                 fontFamily: "dmsans",
                    //
                    //               ),
                    //
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //
                    //   ],
                    // )
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: 3,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 16,);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            Get.to(UpdateAddress());
                          },
                          child: Container(
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
                                      color:appController.isDark.value==true?Color(0xff242438): inputFieldBackgroundColor.value,
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
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.w600,
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
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20,),

                  GestureDetector(
                    onTap: (){
                      Get.to(AddAdress());
                      // Get.back();
                    },
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


                          Text(
                            "${getTranslated(context,"Add new address" )??"Add new address"}",
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
                  SizedBox(height: 20,),


                ],
              ),
            ),
          ),

      ),
    );
  }
}
