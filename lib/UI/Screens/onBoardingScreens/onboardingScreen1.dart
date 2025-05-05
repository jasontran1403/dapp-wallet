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
  AppController appController = Get.find<AppController>();
  PageController _pageController = PageController();
  var selectedIndex = 0.obs;

  List onboardingList = [
    {
      "title": "EcoWallet\nYour Crypto Assets Grow Daily",
      "subTitle1":
      "Maximum Security: EcoWallet uses advanced encryption technology to ensure that your assets are always safe from threats.",
      "subTitle2":
      "Easy Transactions: The user-friendly interface and support for multiple cryptocurrencies allow you to trade quickly and conveniently.",
      "subTitle3":
      "Smart Earning: EcoWallet offers smart staking features so you can maximize your returns on your investments",
      "darkImage": "assets/images/Trust.png",
      "lightImage": "assets/images/Trust.png"
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
          () => Scaffold(
        backgroundColor: appController.isDark.value
            ? const Color(0xff1A2B56)
            : primaryColor.value,
        body: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: onboardingList.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  width: Get.width,
                  height: MediaQuery.of(context).size.height,
                  color: Color(0xff0D1B3B),
                ),
                Positioned.fill(
                  child: Obx(
                        () => Container(
                      width: Get.width,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  width: Get.width,
                                  height: appController.isDark.value
                                      ? MediaQuery.of(context).size.height * 0.59
                                      : MediaQuery.of(context).size.height * 0.5,
                                  child: Image.asset(
                                    "assets/images/Trust.png",
                                    fit: BoxFit.fill,
                                    color: appController.isDark.value
                                        ? primaryBackgroundColor.value
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                            Transform.translate(
                              offset: appController.isDark.value
                                  ? const Offset(0, -180)
                                  : const Offset(0, -120),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: Get.width,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
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
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            getTranslated(
                                                context,
                                                "${onboardingList[selectedIndex.value]['title']}")
                                                ??
                                                "${onboardingList[selectedIndex.value]['title']}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              fontFamily: "dmsans",
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            getTranslated(
                                                context,
                                                "${onboardingList[selectedIndex.value]['subTitle1']}")
                                                ??
                                                "${onboardingList[selectedIndex.value]['subTitle1']}",
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontFamily: "dmsans",
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            getTranslated(
                                                context,
                                                "${onboardingList[selectedIndex.value]['subTitle2']}")
                                                ??
                                                "${onboardingList[selectedIndex.value]['subTitle2']}",
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontFamily: "dmsans",
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          BottomRectangularBtn(
                                            color: const Color(0x40C9FFC9),
                                            onTapFunc: () {
                                              Get.to(SocialLogin());
                                              setState(() {});
                                            },
                                            btnTitle: "Next",
                                            hasIcon: true,
                                            svgName: "arrow_next",
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 32),
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
                                    const SizedBox(height: 40),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          onPageChanged: (index) {
            selectedIndex.value = index;
            print('Page changed to $index');
          },
        ),
      ),
    );
  }
}
