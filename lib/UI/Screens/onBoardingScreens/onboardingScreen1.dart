import 'package:crypto_wallet/UI/common_widgets/bottomRectangularbtn.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../socialLogin/socialLogin.dart';
class OnBoardingScreen1 extends StatefulWidget {
   OnBoardingScreen1({super.key});

  @override
  State<OnBoardingScreen1> createState() => _OnBoardingScreen1State();
}

class _OnBoardingScreen1State extends State<OnBoardingScreen1> {
  AppController appController=Get.find<AppController>();
  PageController _pageController = PageController();


  var selectedIndex=0.obs;

  List onboardingList=[
    {
      "title":"EcoWallet\nYour Crypto Assets Grow Daily",
      "subTitle1":"Maximum Security: EcoWallet uses advanced encryption technology to ensure that your assets are always safe from threats.",
      "subTitle2":"Easy Transactions: The user-friendly interface and support for multiple cryptocurrencies allow you to trade quickly and conveniently.",
      "subTitle3":"Smart Earning: EcoWallet offers smart staking features so you can maximize your returns on your investments",
      "darkImage":"assets/images/Trust.png",
      "lightImage":"assets/images/Trust.png"
    },
  ];
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        backgroundColor:appController.isDark.value==true?Color(0xff1A2B56): primaryColor.value,
        body: PageView.builder(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          itemCount: onboardingList.length, // Number of pages
          itemBuilder: (context, index) {
            // Build each page
            return  Stack(
              children: [
                Container(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    children: [
                      Image.asset("assets/images/3d_avatar_21.png",width: Get.width,height: MediaQuery.of(context).size.height*0.7,),
                      Expanded(child: SizedBox())
                    ],
                  ),
                ),
                Positioned.fill(child: Obx(
                      ()=> Container(
                    height: Get.height,
                    width: Get.width,
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                            width:Get.width,
                            // color: primaryBackgroundColor.value,
                            child: Stack(
                              children: [
                                Container(
                                  width: Get.width,
                                  height: appController.isDark.value == true
                                      ? MediaQuery.of(context).size.height * 0.59
                                      : MediaQuery.of(context).size.height * 0.5,
                                  child: appController.isDark.value == true
                                      ? Image.asset(
                                    "assets/images/Trust.png",
                                    width: Get.width,
                                    height: MediaQuery.of(context).size.height * 0.5,
                                    fit: BoxFit.fill,
                                    color: primaryBackgroundColor.value,
                                  )
                                      : Image.asset(
                                    "assets/images/Trust.png",
                                    width: Get.width,
                                    height: MediaQuery.of(context).size.height * 0.535,
                                    fit: BoxFit.fill,
                                  ),
                                )

                              ],
                            )),
                        Column(
                          children: [
                            Transform.translate(
                              offset: appController.isDark.value == true ? Offset(0, -180) : Offset(0, -120),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: Get.height * 0.5,
                                      width: Get.width,
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5), // Nền mờ
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: headingColor.value.withOpacity(0.15),
                                            blurRadius: 14,
                                            spreadRadius: -5,
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "${getTranslated(context, "${onboardingList[selectedIndex.value]['title']}") ?? "${onboardingList[selectedIndex.value]['title']}"}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white, // Màu chữ trắng
                                              fontFamily: "dmsans",
                                            ),
                                          ),
                                          Text(
                                            "${getTranslated(context, "${onboardingList[selectedIndex.value]['subTitle1']}") ?? "${onboardingList[selectedIndex.value]['subTitle1']}"}",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white, // Màu chữ trắng
                                              fontFamily: "dmsans",
                                            ),
                                          ),
                                          Text(
                                            "${getTranslated(context, "${onboardingList[selectedIndex.value]['subTitle2']}") ?? "${onboardingList[selectedIndex.value]['subTitle2']}"}",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white, // Màu chữ trắng
                                              fontFamily: "dmsans",
                                            ),
                                          ),

                                          BottomRectangularBtn(
                                            color: Color(0x40C9FFC9),
                                            onTapFunc: () {
                                              Get.to(SocialLogin());
                                              setState(() {});
                                            },
                                            btnTitle: "Next",
                                            hasIcon: true,
                                            svgName: "arrow_next",
                                          ),
                                          SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 32),
                                    AnimatedSmoothIndicator(
                                      activeIndex: selectedIndex.value,
                                      count: onboardingList.length,
                                      effect: ExpandingDotsEffect(
                                        expansionFactor: 4,
                                        dotColor: primaryBackgroundColor.value,
                                        spacing: 4,
                                        dotHeight: 10,
                                        dotWidth: 7,
                                        radius: 40,
                                        activeDotColor: greenCardColor.value,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),


                        SizedBox(height: 30,),
                      ],
                    ),
                  ),
                ))
              ],
            );
          },
          onPageChanged: (index) {
            selectedIndex.value=index;
            // Callback when the page is changed
            print('Page changed to $index');
          },
        ),
      ),
    );
  }
}
