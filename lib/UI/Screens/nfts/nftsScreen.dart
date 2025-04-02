import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_wallet/UI/Screens/nfts/nftsDetail.dart';
import 'package:crypto_wallet/UI/Screens/nfts/receiveNftScreen.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';





class NftsScreen extends StatefulWidget {
  NftsScreen({super.key});

  @override
  State<NftsScreen> createState() => _NftsScreenState();
}

class _NftsScreenState extends State<NftsScreen> {
  final appController = Get.find<AppController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor.value,
      body:  SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      "${getTranslated(context,"Staking" )??"Staking"}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:15,
                        fontWeight: FontWeight.w600,
                        color: darkBlueColor.value,
                        fontFamily: "dmsans",

                      ),

                    ),

                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Expanded(
                  child:  GridView.builder(
                    padding: EdgeInsets.only(top: 0.0, bottom: 80, left: 2.0, right: 2),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent: 190, crossAxisSpacing: 12, mainAxisSpacing: 12, crossAxisCount: 2),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(NftDetails());
                        },
                        child: Container(
                          // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          decoration: ShapeDecoration(
                            color: inputFieldBackgroundColor2.value,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Column(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(

                                tag: 'https://media.istockphoto.com/id/1372146767/photo/nft-hexagons-pixelated-concept.jpg?b=1&s=612x612&w=0&k=20&c=4dMyZNzeFIAQfDvEL_jHqOa1eUYxsAymj-GwIUxK95Q=',

                                child: Container(
                                  height: 130,
                                  width: Get.width,
                                  clipBehavior: Clip.antiAlias,
                                  padding: EdgeInsets.zero,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFC4C4C4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                         topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(0),

                                      ),
                                    ),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: 'https://media.istockphoto.com/id/1372146767/photo/nft-hexagons-pixelated-concept.jpg?b=1&s=612x612&w=0&k=20&c=4dMyZNzeFIAQfDvEL_jHqOa1eUYxsAymj-GwIUxK95Q=',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Meka #6582',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: headingColor.value,
                                              fontSize: 11,
                                              fontFamily: 'dmsans',
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ),

                                      ],
                                    ),
                                    SizedBox(width: 12),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [

                                          Text(
                                            '#1267',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: headingColor.value,
                                              fontSize: 10,
                                              fontFamily: 'dmsans',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Image.asset("assets/images/simple-icons_tether.png",height: 12,width: 12,color: headingColor.value,),
                                              Text(
                                                ' 6.64',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: headingColor.value,
                                                  fontSize: 11,
                                                  fontFamily: 'dmsans',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
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

  Widget receiveNft(){
    return Container(
      height: 200,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 22,vertical: 22),
      color: primaryBackgroundColor.value,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Receive NFT",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: headingColor.value,
                  fontFamily: "dmsans",

                ),
              ),
              GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.clear,color: headingColor.value,))



            ],
          ),
          SizedBox(height: 32,),
          Expanded(
            child: ListView(
              children: [
                
                GestureDetector(
                  onTap:(){
                    Get.to(ReceiveNftScreen());
                  },
                  child: Container(
                    // height: 61,
                    width: Get.width,
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 1,color: inputFieldBackgroundColor.value)
                    ),

                    child:
                    Row(
                      children: [
                        Container(
                          height: 36,
                          width:36,
                          decoration: BoxDecoration(
                            color: inputFieldBackgroundColor.value,
                              borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.add,color: headingColor.value,size: 20,),
                        ),
                        SizedBox(width: 12,),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${getTranslated(context,"Receive NFT" )??"Receive NFT"}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: headingColor.value,
                                  fontSize: 13,
                                  fontFamily: 'dmsans',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${getTranslated(context,"Receive a new collectible in your account..." )??"Receive a new collectible in your account..."}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: lightTextColor.value,
                                  fontSize: 12,
                                  fontFamily: 'dmsans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(width: 12,),
                        Icon(Icons.arrow_forward_ios,size: 16,color: headingColor.value,)

                      ],
                    ),
                  ),
                )


              ],
            ),
          )







        ],
      ),
    );
  }
}
