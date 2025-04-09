

import 'package:crypto_wallet/Constants/colors.dart';
import 'package:crypto_wallet/UI/Screens/TransactionHistoryScreen/TransactionScreen.dart';
import 'package:crypto_wallet/UI/Screens/TransactionHistoryScreen/rewardHistory.dart';
import 'package:crypto_wallet/UI/Screens/homeScreen/homeScreen.dart';
import 'package:crypto_wallet/UI/Screens/market/market.dart';
import 'package:crypto_wallet/UI/Screens/nfts/nftsScreen.dart';
import 'package:crypto_wallet/UI/Screens/profile/profile.dart';
import 'package:crypto_wallet/UI/Screens/stakingScreen/stakingScreen.dart';
import 'package:crypto_wallet/UI/Screens/swapScreens/swapScreen.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';



class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List pages = [
    HomeScreen(),
    StakingScreen(),
    MarketScreen(),
    RewardHistoryScreen(),
    Profile(
      // fromPage: 'bottomNav',
    ),
  ];

  AppController appController = Get.find<AppController>();
  DateTime? lastPressed;
  late DateTime currentBackPressTime;

  List<bool> isLoadingPages = [false, false, false, false, false]; // Mỗi trang có một trạng thái loading riêng

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    appController.selectedBOttomTabIndex.value = 0;
  }

  // Hàm kiểm tra trạng thái loading của trang trước khi chuyển tab
  bool canSwitchTab(int index) {
    return !isLoadingPages[index];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          final now = DateTime.now();

          if (lastPressed == null || now.difference(lastPressed!) > Duration(seconds: 1)) {
            // Save the time of the last press
            lastPressed = now;
            // Show a message or toast (optional)
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text('Press back again to exit')),
            // );
            return false;  // Prevent the default back behavior
          }

          return true;  // Allow the pop action (exit or go back)
        },
        child: Scaffold(
            // backgroundColor: Colors.black,
            bottomNavigationBar: Obx(
              ()=> Container(
                 height: 70,
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: headingColor.value.withOpacity(0.02), width: 1),
                    ),
                     color:appController.isDark.value?Color(0xff1A1930):primaryBackgroundColor.value
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              //print("appController.isHyptics.value ${appController.isHyptics.value}");

                              appController.selectedBOttomTabIndex.value = 0;
                            },
                            child: Container(
                              // color:  primaryBackgroundColor.value,
                              height: 40,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // appController.isDark == true
                                  //     ?
                                  appController.selectedBOttomTabIndex.value == 0
                                          ? SvgPicture.asset("assets/svgs/selectedHome.svg",color: appController.isDark.value==true?greenCardColor.value:primaryColor.value,)
                                          : SvgPicture.asset("assets/svgs/unselectedHome.svg",color:appController.isDark.value==true?Color(0xff6C7CA7):headingColor.value,),
                                SizedBox(height: 5,),
                                  appController.selectedBOttomTabIndex.value == 0
                                      ? Container(
                                    height: 6,
                                    width: 6,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xff76CF56),
                                          Color(0xff55DDAF)
                                        ]
                                      )
                                    ),
                                  )
                                      : SizedBox(
                                          height: 0,
                                          width: 0,
                                        )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {

                              appController.selectedBOttomTabIndex.value = 1;
                            },
                            child: Container(
                              // color:  primaryBackgroundColor.value,
                              height: 40,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // appController.isDark == true
                                  //     ?
                                  appController.selectedBOttomTabIndex.value == 1
                                      ? SvgPicture.asset("assets/svgs/nftSelected.svg",color: appController.isDark.value==true?greenCardColor.value:primaryColor.value,)
                                      : SvgPicture.asset("assets/svgs/nftunSelected.svg",color:appController.isDark.value==true?Color(0xff6C7CA7): headingColor.value,),
                                  SizedBox(height: 5,),
                                  appController.selectedBOttomTabIndex.value == 1
                                      ? Container(
                                    height: 6,
                                    width: 6,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xff76CF56),
                                              Color(0xff55DDAF)
                                            ]
                                        )
                                    ),
                                  )
                                      : SizedBox(
                                    height: 0,
                                    width: 0,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {

                              appController.selectedBOttomTabIndex.value = 2;
                            },
                            child: Container(
                              // color:  primaryBackgroundColor.value,
                              height: 40,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // appController.isDark == true
                                  //     ?
                                  appController.selectedBOttomTabIndex.value == 2
                                      ? appController.isDark.value==true?SvgPicture.asset("assets/svgs/Activity.svg",): SvgPicture.asset("assets/svgs/Group 62915.svg",)
                                      : SvgPicture.asset("assets/svgs/unselectedHistory.svg",color:appController.isDark.value==true?Color(0xff6C7CA7):Color(0xff1A2B56),),
                                  SizedBox(height: 5,),
                                  appController.selectedBOttomTabIndex.value == 2
                                      ? Container(
                                    height: 6,
                                    width: 6,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xff76CF56),
                                              Color(0xff55DDAF)
                                            ]
                                        )
                                    ),
                                  )
                                      : SizedBox(
                                    height: 0,
                                    width: 0,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {

                              appController.selectedBOttomTabIndex.value = 3;
                            },
                            child: Container(
                              // color:  primaryBackgroundColor.value,
                              height: 40,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // appController.isDark == true
                                  //     ?
                                  appController.selectedBOttomTabIndex.value == 3
                                      ? appController.isDark.value==true?SvgPicture.asset("assets/svgs/swapSelected.svg",): SvgPicture.asset("assets/svgs/swapSelected.svg",)
                                      : SvgPicture.asset("assets/svgs/swap.svg",color:appController.isDark.value==true?Color(0xff6C7CA7):Color(0xff1A2B56),),
                                  SizedBox(height: 5,),
                                  appController.selectedBOttomTabIndex.value == 3
                                      ? Container(
                                    height: 6,
                                    width: 6,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xff76CF56),
                                              Color(0xff55DDAF)
                                            ]
                                        )
                                    ),
                                  )
                                      : SizedBox(
                                    height: 0,
                                    width: 0,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {

                              appController.selectedBOttomTabIndex.value = 4;
                            },
                            child: Container(
                              // color:  primaryBackgroundColor.value,
                              height: 40,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // appController.isDark == true
                                  //     ?
                                  appController.selectedBOttomTabIndex.value == 4
                                      ? SvgPicture.asset("assets/svgs/selectedProfile.svg",color: appController.isDark.value==true?greenCardColor.value:primaryColor.value,)
                                      : SvgPicture.asset("assets/svgs/unselectedProfile.svg",color:appController.isDark.value==true?Color(0xff6C7CA7): headingColor.value,),
                                  SizedBox(height: 5,),
                                  appController.selectedBOttomTabIndex.value == 4
                                      ? Container(
                                    height: 6,
                                    width: 6,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xff76CF56),
                                              Color(0xff55DDAF)
                                            ]
                                        )
                                    ),
                                  )
                                      : SizedBox(
                                    height: 0,
                                    width: 0,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: pages.elementAt(appController.selectedBOttomTabIndex.value),
          ),
      ),
    );
  }
}
