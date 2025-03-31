import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

var primaryColor = Color(0xff1A2B56).obs;
var primaryColor2 = Color(0xff1A2B56).obs;
var primaryBackgroundColor = Color(0xFFFFFFFF).obs;
var inputFieldBackgroundColor = Color(0xffF5F5F5).obs;
var inputFieldBackgroundColor2 = Color(0xffFAFAFA).obs;
var blueCard1 = Color(0xff1A1930).obs;


var lightTextColor=Color(0xff989898).obs;
var headingColor =  Color(0xFF030303).obs;
var greenColor=Color(0xff76CF56).obs;
var darkBlueColor=Color(0xff383737).obs;
var redColor=Color(0xffFF5C5C).obs;

Color lightColor = const Color(0xFFFCFCFC);
Color btnTxtColor = const Color(0xFFFCFCFC);
var greenCardColor = Color(0xFF39B171).obs;
var redCardColor = Color(0xFFF16464).obs;



var appShadow = [
  BoxShadow(
    color: Color.fromRGBO(155, 155, 155, 15).withOpacity(0.15),
    spreadRadius: 5,
    blurRadius: 7,
    offset: Offset(0, 3), // changes position of shadow
  ),
].obs;

var homeCardBgShadow = [
  BoxShadow (
    color: Color(0x00000000),
    offset: Offset(0.0, 4.0),
    blurRadius: 20.0,
  ),
].obs;