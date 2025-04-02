import 'dart:convert';
import 'package:http/http.dart' as http;
import '../controllers/appController.dart';
import 'package:get/get.dart' as getX;


class ApiService {
  final appController = getX.Get.find<AppController>();

  static const String baseUrl = "http://localhost:9898/api/v1"; // Thay bằng URL API thật

  static Future<bool> getReferralCodeStatus(String referralCode) async {
    final String url = "$baseUrl/auth/validate-referral-code/$referralCode";

    try {
      final response = await http.get(Uri.parse(url)).timeout(
        Duration(seconds: 3), // Timeout sau 5 giây
        onTimeout: () {
          return http.Response('{"isValid": false}', 408); // Trả về lỗi timeout
        },
      );

      print(response);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
