import 'dart:convert';
import 'package:http/http.dart' as http;
import '../controllers/appController.dart';
import 'package:get/get.dart' as getX;


class ApiService {
  final appController = getX.Get.find<AppController>();

  static Future<bool> getReferralCodeStatus(String referralCode) async {

    var request = http.Request('GET', Uri.parse('http://192.168.100.174:9898/api/v1/auth/validate-referral-code/${referralCode}'));

    try {
      // Gửi yêu cầu HTTP
      http.StreamedResponse response = await request.send();

      // Kiểm tra mã trạng thái của phản hồi
      if (response.statusCode == 200) {
        // Đọc body của phản hồi và giải mã từ JSON
        String responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);

        // Trả về giá trị 'isValid' từ API
        return data ?? false;  // Nếu không có 'isValid', trả về false
      } else {
        // Nếu mã trạng thái không phải 200, in lỗi và trả về false
        print('Error: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      // Nếu có lỗi xảy ra trong quá trình gửi yêu cầu, in lỗi và trả về false
      print('Exception: $e');
      return false;
    }
  }
}
