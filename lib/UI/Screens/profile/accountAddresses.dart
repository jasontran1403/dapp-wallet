import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class AccountAddresses extends StatefulWidget {
  const AccountAddresses({super.key});

  @override
  State<AccountAddresses> createState() => _AccountAddressesState();
}

class _AccountAddressesState extends State<AccountAddresses> {
  List coins=[

    {
      "image":"assets/images/eth.png",
      "symbol":"Ethereum",
      "price1":"\$1,571.45",
      "price2":"\$1,571.45",
      "percentage":"8.75%",
      "chain":""
    },
    {
      "image":"assets/images/bttc.png",
      "symbol":"Bitcoin",
      "price1":"\$1,571.45",
      "price2":"\$1,571.45",
      "percentage":"8.75%",
      "chain":""
    },
    {
      "image":"assets/images/solana.png",
      "symbol":"Solana",
      "price1":"\$1,571.45",
      "price2":"\$1,571.45",
      "percentage":"8.75%",
      "chain":"Solana"
    },


  ];
  AppController appController = Get.find<AppController>();

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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(

                      onTap:(){
                        Get.back();

                      },
                      child: Icon(Icons.arrow_back_ios,color: headingColor.value,size: 18,)),
                  SizedBox(width: 8,),
                  Text(
                    "${getTranslated(context,"Account Address" )??"Account Address"}",
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
              SizedBox(height: 24,),
              ListView.separated(
                shrinkWrap: true,

                itemCount: 3,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 12,);
                },
                itemBuilder: (BuildContext context, int index) {
                  return  GestureDetector(
                    onTap: (){
                      // Get.to(ReceiveScreen());
                    },
                    child: Container(
                      height:70,
                      width: Get.width,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: inputFieldBackgroundColor2.value,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                      ),
                      child: Row(
                        children: [
                          Container(
                              height:40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle
                              ),
                              child: Image.asset("${coins[index]['image']}",height: 40,width: 40,)),

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

                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${coins[index]['symbol']}",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                    color:appController.isDark.value==true?headingColor.value:  primaryColor.value,
                                                    fontFamily: "dmsans",

                                                  ),

                                                ),
                                                Text(
                                                  "0x00...001dsax",
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



                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                )

                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                height: 28,
                                width: 28,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: appController.isDark.value==true?Color(0xff1A2B56):primaryColor.value,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                                ),
                                child: Image.asset("assets/images/ion_qr-code.png",color: appController.isDark.value==true?Color(0xffA2BBFF):primaryColor.value,),
                              ),
                              SizedBox(width: 7,),
                              Container(
                                height: 28,
                                width: 28,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: appController.isDark.value==true?Color(0xff1A2B56):primaryColor.value,

                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                                ),
                                child: Image.asset("assets/images/u_copy-landscape.png",color: appController.isDark.value==true?Color(0xffA2BBFF):primaryColor.value,),
                              )
                            ],
                          )

                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
