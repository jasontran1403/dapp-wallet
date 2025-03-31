import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../common_widgets/bottomRectangularbtn.dart';


class NftDetails extends StatefulWidget {
  NftDetails({super.key, });

  @override
  State<NftDetails> createState() => _NftDetailsState();
}

class _NftDetailsState extends State<NftDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor.value,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: headingColor.value,
                      size: 16,
                    ),
                  ),
                  SizedBox(width: 12,),
                  Text(
                    '${getTranslated(context,"Your Collectible" )??"Your Collectible"}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: headingColor.value,
                      fontSize: 15,
                      fontFamily: 'dmsans',
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                    ),
                  ),
                ],
              ),
            ),


            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                        
                          children: [
                            Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          'Meka #3139',
                                          style: TextStyle(
                                            color: headingColor.value,
                                            fontSize: 16.5,
                                            fontFamily: 'dmsans',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                        
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '#1267',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color:headingColor.value,
                                              fontSize: 14,
                                              fontFamily: 'dmsans',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Hero(
                                    tag: 'https://media.istockphoto.com/id/1372146767/photo/nft-hexagons-pixelated-concept.jpg?b=1&s=612x612&w=0&k=20&c=4dMyZNzeFIAQfDvEL_jHqOa1eUYxsAymj-GwIUxK95Q=',
                                    child: Container(
                                      width: Get.width,
                        
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: 'https://media.istockphoto.com/id/1372146767/photo/nft-hexagons-pixelated-concept.jpg?b=1&s=612x612&w=0&k=20&c=4dMyZNzeFIAQfDvEL_jHqOa1eUYxsAymj-GwIUxK95Q=',
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) => Icon(Icons.person),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          '${getTranslated(context,"Description" )??"Description"}',
                                          style: TextStyle(
                                            color: headingColor.value,
                                            fontSize: 16.5,
                                            fontFamily: 'dmsans',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Image.asset("assets/images/simple-icons_tether.png",color: headingColor.value,height: 12,width: 12,),
                                          Text(
                                            ' 6.64',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color:headingColor.value,
                                              fontSize: 14,
                                              fontFamily: 'dmsans',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16,),
                                  Container(
                                    width: Get.width,
                                    child: Column(
                                      // mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Andy shoes are designed to keeping in mind durability as well as trends, the most stylish range of shoes & sandals. Carbonate web goalkeeper gloves are ergonomically designed to give easy fit. ',
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
                                ],
                              ),
                            ),
                            SizedBox(height: 24),
                            Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  child: Text(
                                                    '${getTranslated(context,"Properties" )??"Properties"}',
                                                    style: TextStyle(
                                                      color: headingColor.value,
                                                      fontSize: 16.5,
                                                      fontFamily: 'dmsans',
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                        Container(
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 80,
                                                child: Text(
                                                  '${getTranslated(context,"Price" )??"Price"}',
                                                  style: TextStyle(
                                                    color: lightTextColor.value,
                                                    fontSize: 14,
                                                    fontFamily: 'dmsans',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                '6.64 USDT',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: headingColor.value,
                                                  fontSize: 14,
                                                  fontFamily: 'dmsans',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                        Container(
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 80,
                                                child: Text(
                                                  '${getTranslated(context,"Network" )??"Network"}',
                                                  style: TextStyle(
                                                    color: lightTextColor.value,
                                                    fontSize: 14,
                                                    fontFamily: 'dmsans',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                'Binance Smart Chain',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: headingColor.value,
                                                  fontSize: 14,
                                                  fontFamily: 'dmsans',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                        Container(
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${getTranslated(context,"Contract Address" )??"Contract Address"}',
                                                style: TextStyle(
                                                  color: lightTextColor.value,
                                                  fontSize: 14,
                                                  fontFamily: 'dmsans',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                '1273eY6123iIg81361DBW',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: headingColor.value,
                                                  fontSize: 12.5,
                                                  fontFamily: 'dmsans',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      BottomRectangularBtn(
                          onTapFunc: () {
                            // Navigator.push(context, PageTransition(duration: Duration(milliseconds: 100), type: PageTransitionType.topToBottom, child: SendNftScreen(nft: widget.nft, onSent: (){
                            //   widget.onSent.call();
                            //   Get.back();
                            //
                            // },)));
                          },
                          btnTitle: "Transfer NFT"),
                      SizedBox(height: 16),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
