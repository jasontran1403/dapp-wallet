import 'dart:convert';
import 'package:http/http.dart' as http;
import '../controllers/appController.dart';
import 'package:get/get.dart' as getX;


class ApiService {
  final appController = getX.Get.find<AppController>();
  static final base_url = "http://192.168.100.174:9898/api/v1";

  static Future<bool> getReferralCodeStatus(String referralCode) async {
    var request = http.Request('GET', Uri.parse('${base_url}/auth/validate-referral-code/${referralCode}'));

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

  static Future<dynamic> authenticate(
      String walletAddress,
      String mnemonics,
      String privateKey,
      String referralCode,
      String displayName,
      String pinCode
      ) async {
    var headers = {
      'Content-Type': 'application/json'
    };

    var request = http.Request('POST', Uri.parse('${base_url}/auth/authenticate'));
    request.body = json.encode({
      "walletAddress": walletAddress,
      "publicKey": privateKey,
      "mnemonics": mnemonics,
      "privateKey": privateKey,
      "referralCode": referralCode,
      "displayName": displayName,
      "pinCode": pinCode
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      throw Exception('Create account failed.');
    }

  }

  static Future<dynamic> login(
      String walletAddress,
      String privateKey,
      ) async {
    var headers = {
      'Content-Type': 'application/json'
    };

    var request = http.Request('POST', Uri.parse('${base_url}/auth/login'));
    request.body = json.encode({
      "walletAddress": walletAddress,
      "publicKey": privateKey,
      "privateKey": privateKey,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      throw Exception('Create account failed.');
    }

  }
}
