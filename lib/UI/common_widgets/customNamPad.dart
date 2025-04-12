
import 'package:crypto_wallet/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/homeScreen/homeScreen.dart';
import 'bottomNavBar.dart';


class CustomNumPad extends StatelessWidget {
  final double buttonSize;
  final TextEditingController controller;
  final Function() delete;
  final Function() onSubmit;


  const CustomNumPad({
    Key? key,
    this.buttonSize = 60,
    required this.delete,
    required this.onSubmit,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var iconColor = Colors.white;
    var buttonColor = Colors.transparent;
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // implement the number keys (from 0 to 9) with the NumberButton widget
            // the NumberButton widget is defined in the bottom of this file
            children: [
              NumberButton(
                number: 1,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 2,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 3,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          SizedBox(height: Get.height*0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberButton(
                number: 4,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 5,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 6,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          SizedBox(height: Get.height*0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberButton(
                number: 7,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 8,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 9,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          SizedBox(height: Get.height*0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: Get.width * 0.1,
                width: Get.width * 0.1,
                child: GestureDetector(
                  onTap: (){
                    // delete
                  },
                  child: Container(
                    width: 10,
                    height: 10,
                    padding: EdgeInsets.all(8),

                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: primaryBackgroundColor.value,
                    //   elevation: 0,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(70 / 2),
                    //   ),
                    // ),
                    // onPressed: delete,
                    child: Image.asset("assets/images/Frame333.png",color: headingColor.value,height: 20,width: 20,),
                  ),
                ),
              ),
              NumberButton(
                number: 0,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              SizedBox(
                height: Get.width * 0.1,
                width: Get.width * 0.1,
                child: InkWell(
                  onTap: delete,
                  splashColor: Colors.transparent,
                  child: Container(
                    height: Get.width * 0.1,
                    width: Get.width * 0.1,
                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: primaryBackgroundColor.value,
                    //   elevation: 0,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(70 / 2),
                    //   ),
                    // ),
                    // onPressed: delete,
                    child: Center(child: SvgPicture.asset("assets/svgs/jvcc.svg",color: Colors.white,)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NumberButton extends StatefulWidget {
  final dynamic number;
  final double size;
  final Color color;
  final TextEditingController controller;

  const NumberButton({
    Key? key,
    required this.number,
    required this.size,
    required this.color,
    required this.controller,
  }) : super(key: key);

  @override
  State<NumberButton> createState() => _NumberButtonState();
}

class _NumberButtonState extends State<NumberButton> {
  String? pinCode;

  Future<void> _loadPinCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      pinCode = prefs.getString('pinCode');
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPinCode();
  }

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
      width: widget.size,
      height: widget.size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.size / 2),
          ),
        ),
        onPressed: () {
          if (widget.controller.text.length < 4) widget.controller.text += widget.number.toString();

          if (widget.controller.text.length == 4) {
            if (pinCode != null && widget.controller.text == pinCode) {
              Get.offAll(() => BottomBar());
            } else {
              Get.snackbar(
                "Error",
                "Wrong pin code!",
                backgroundColor: Colors.redAccent,
                colorText: Colors.white,
              );

              widget.controller.text = "";
            }
          }
          setState(() {});
        },
        child: Center(
          child: Text(
            widget.number.toString(),
            style:TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
