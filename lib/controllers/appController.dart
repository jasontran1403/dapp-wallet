

import 'dart:ffi';

import 'package:crypto_wallet/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class AppController extends GetxController {
  var isDark=false.obs;
  RxInt selectedBOttomTabIndex=RxInt(0);
  var selectedLanguage = "English".obs;
  var locale = Locale('en', 'US').obs;



  changeTheme() {
    if (isDark.value) {
       primaryColor2.value = Color(0xff1A2B56);//changes
       primaryColor.value = Color(0xff5C87FF);//changes
       primaryBackgroundColor.value = Color(0xFF100F1C);//changed
       inputFieldBackgroundColor.value = Color(0xff242438);//changes
       inputFieldBackgroundColor2.value = Color(0xff1A1930);
       blueCard1.value = Color(0xffFDFCFD);//changed


       lightTextColor.value=Color(0xff6C7CA7);//changed
       headingColor.value =  Color(0xFFFDFCFD);//changed
       greenColor.value=Color(0xff76CF56);
       darkBlueColor.value=Color(0xffFDFCFD);
       redColor.value=Color(0xffFF5C5C);

       lightColor = const Color(0xFFFCFCFC);
       btnTxtColor = const Color(0xFFFCFCFC);
       greenCardColor.value = Color(0xFF39B171);
       redCardColor.value = Color(0xFFF16464);

      Get.changeThemeMode(ThemeMode.dark);
      Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
    } else {
      primaryColor2.value = Color(0xff1A2B56);
      primaryColor.value = Color(0xff1A2B56);
      primaryBackgroundColor.value = Color(0xFFFFFFFF);
      inputFieldBackgroundColor.value = Color(0xffF5F5F5);
      inputFieldBackgroundColor2.value = Color(0xffFAFAFA);
      blueCard1.value = Color(0xff1A1930);


      lightTextColor.value=Color(0xff989898);
      headingColor.value =  Color(0xFF030303);
      greenColor.value=Color(0xff76CF56);
      darkBlueColor.value=Color(0xff383737);
      redColor.value=Color(0xffFF5C5C);

      lightColor = const Color(0xFFFCFCFC);
      btnTxtColor = const Color(0xFFFCFCFC);
      greenCardColor.value = Color(0xFF39B171);
      redCardColor.value = Color(0xFFF16464);
      appShadow.value = [
        BoxShadow(
          color: Color.fromRGBO(155, 155, 155, 15).withOpacity(0.15),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ];
    }
    Get.changeThemeMode(ThemeMode.light);
    Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
    print(primaryColor.value);
  }
}
