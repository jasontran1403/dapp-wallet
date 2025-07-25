import 'dart:convert';
import 'package:http/http.dart' as http;
import '../controllers/appController.dart';
import 'package:get/get.dart' as getX;


class ApiService {
  final appController = getX.Get.find<AppController>();
  // static final base_url = "http://192.168.1.143:9898/api/v1";
  static final base_url = "https://eft.cloudapi.space/api/v1";

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

  static Future<dynamic> claimCapital(int id) async {
    var request = http.Request('GET', Uri.parse('${base_url}/auth/claim-capital/${id}'));

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();

        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> getDirectTree(String walletAddress) async {
    var request = http.Request('GET', Uri.parse('${base_url}/auth/get-direct/${walletAddress}'));

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);

        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> fetchTransactions(String walletAddress, String symbol) async {
    var headers = {
      'Content-Type': 'application/json'
    };

    var request = http.Request('POST', Uri.parse('${base_url}/auth/blockchain-manipulate'));
    request.body = json.encode({
      "network": symbol.toLowerCase(),
      "method": "transactions",
      "walletAddress": walletAddress
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();

      final data = json.decode(responseBody);

      return data;
    }
    else {
      throw Exception('Fetch transactions ${symbol} failed.');
    }
  }

  static Future<dynamic> createTransactions(String walletAddress, String symbol, String to, double amount, int memo) async {
    var headers = {
      'Content-Type': 'application/json'
    };

    var request = http.Request('POST', Uri.parse('${base_url}/auth/blockchain-manipulate'));
    request.body = json.encode({
      "network": symbol.toLowerCase(),
      "method": "send",
      "walletAddress": walletAddress,
      "receiver": to,
      "amount": amount,
      "memo": memo
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      return responseBody.trim();
    } else {
      throw Exception('Create transactions $symbol failed.');
    }
  }

  static Future<dynamic> fetchStatistic(String walletAddress) async {
    var request = http.Request('GET', Uri.parse('${base_url}/auth/prices/${walletAddress}'));

    try {
      // Gửi yêu cầu HTTP
      http.StreamedResponse response = await request.send();

      // Kiểm tra mã trạng thái của phản hồi
      if (response.statusCode == 200) {
        // Đọc body của phản hồi và giải mã từ JSON
        String responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);

        // Trả về giá trị 'isValid' từ API
        return data;  // Nếu không có 'isValid', trả về false
      } else {
        // Nếu mã trạng thái không phải 200, in lỗi và trả về false
        print('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      // Nếu có lỗi xảy ra trong quá trình gửi yêu cầu, in lỗi và trả về false
      print('Exception: $e');
      return null;
    }
  }

  static Future<dynamic> fetchSingStatistic(String walletAddress, String symbol) async {
    var request = http.Request('GET', Uri.parse('${base_url}/auth/price/${walletAddress}/${symbol}'));

    try {
      // Gửi yêu cầu HTTP
      http.StreamedResponse response = await request.send();

      // Kiểm tra mã trạng thái của phản hồi
      if (response.statusCode == 200) {
        // Đọc body của phản hồi và giải mã từ JSON
        String responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);

        // Trả về giá trị 'isValid' từ API
        return data;  // Nếu không có 'isValid', trả về false
      } else {
        // Nếu mã trạng thái không phải 200, in lỗi và trả về false
        print('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      // Nếu có lỗi xảy ra trong quá trình gửi yêu cầu, in lỗi và trả về false
      print('Exception: $e');
      return null;
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

  static Future<String> staking(String walletAddress, String symbol, double amount, double price, int duration) async {
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request('POST', Uri.parse('${base_url}/auth/staking'));

    request.body = json.encode({
      "walletAddress": walletAddress,
      "symbol": symbol,
      "amount": amount,
      "price": price,
      "duration": duration
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      return responseBody; // vì API trả về là 1 chuỗi string
    } catch (e) {
      return "Server busy, please try again later";
    }

  }

  static Future<String> getSecret(String walletAddress, String symbol) async {
    var request = http.Request('GET', Uri.parse('${base_url}/auth/export-secret/${walletAddress}/${symbol}'));

    try {
      // Gửi yêu cầu HTTP
      http.StreamedResponse response = await request.send();

      // Kiểm tra mã trạng thái của phản hồi
      if (response.statusCode == 200) {
        // Đọc body của phản hồi và giải mã từ JSON
        String responseBody = await response.stream.bytesToString();
        final data = responseBody;

        // Trả về giá trị 'isValid' từ API
        return data;  // Nếu không có 'isValid', trả về false
      } else {
        // Nếu mã trạng thái không phải 200, in lỗi và trả về false
        return 'Error: ${response.reasonPhrase}';
      }
    } catch (e) {
      // Nếu có lỗi xảy ra trong quá trình gửi yêu cầu, in lỗi và trả về false
      return 'Exception: $e';
    }

  }

  static Future<dynamic> getInternalBalance(String walletAddress) async {
    var request = http.Request('GET', Uri.parse('${base_url}/auth/get-internals-balance/${walletAddress}'));

    try {
      // Gửi yêu cầu HTTP
      http.StreamedResponse response = await request.send();

      // Kiểm tra mã trạng thái của phản hồi
      if (response.statusCode == 200) {
        // Đọc body của phản hồi và giải mã từ JSON
        String responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);

        // Trả về giá trị 'isValid' từ API
        return data;  // Nếu không có 'isValid', trả về false
      } else {
        // Nếu mã trạng thái không phải 200, in lỗi và trả về false
        print('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      // Nếu có lỗi xảy ra trong quá trình gửi yêu cầu, in lỗi và trả về false
      print('Exception: $e');
      return null;
    }
  }

  static Future<String> withdrawInternal(String walletAddress, String symbol) async {
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request('POST', Uri.parse('${base_url}/auth/withdraw-rewards'));
    request.body = json.encode({
      "walletAddress": walletAddress,
      "symbol": symbol,
    });
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      return responseBody; // vì API trả về là 1 chuỗi string
    } catch (e) {
      return "Server busy, please try again later.";
    }
  }

  static Future<dynamic> getRewardHistory(String walletAddress) async {
    var request = http.Request('GET', Uri.parse('${base_url}/auth/get-account-rewards/${walletAddress}'));

    try {
      // Gửi yêu cầu HTTP
      http.StreamedResponse response = await request.send();

      // Kiểm tra mã trạng thái của phản hồi
      if (response.statusCode == 200) {
        // Đọc body của phản hồi và giải mã từ JSON
        String responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);

        // Trả về giá trị 'isValid' từ API
        return data;  // Nếu không có 'isValid', trả về false
      } else {
        // Nếu mã trạng thái không phải 200, in lỗi và trả về false
        print('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      // Nếu có lỗi xảy ra trong quá trình gửi yêu cầu, in lỗi và trả về false
      print('Exception: $e');
      return null;
    }
  }

  static Future<dynamic> getPackages(String walletAddress) async {
    var request = http.Request('GET', Uri.parse('${base_url}/auth/packages/${walletAddress}'));

    try {
      // Gửi yêu cầu HTTP
      http.StreamedResponse response = await request.send();

      // Kiểm tra mã trạng thái của phản hồi
      if (response.statusCode == 200) {
        // Đọc body của phản hồi và giải mã từ JSON
        String responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);

        // Trả về giá trị 'isValid' từ API
        return data;  // Nếu không có 'isValid', trả về false
      } else {
        // Nếu mã trạng thái không phải 200, in lỗi và trả về false
        print('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      // Nếu có lỗi xảy ra trong quá trình gửi yêu cầu, in lỗi và trả về false
      print('Exception: $e');
      return null;
    }
  }

  static Future<dynamic> getAccountRewardInfo(String walletAddress) async {
    var request = http.Request('GET', Uri.parse('${base_url}/auth/get-account-info/${walletAddress}'));

    try {
      // Gửi yêu cầu HTTP
      http.StreamedResponse response = await request.send();

      // Kiểm tra mã trạng thái của phản hồi
      if (response.statusCode == 200) {
        // Đọc body của phản hồi và giải mã từ JSON
        String responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);

        // Trả về giá trị 'isValid' từ API
        return data;  // Nếu không có 'isValid', trả về false
      } else {
        // Nếu mã trạng thái không phải 200, in lỗi và trả về false
        print('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      // Nếu có lỗi xảy ra trong quá trình gửi yêu cầu, in lỗi và trả về false
      print('Exception: $e');
      return null;
    }
  }

  static Future<dynamic> activeAccount(String walletAddress) async {
    var request = http.Request('GET', Uri.parse('${base_url}/auth/active-account/${walletAddress}'));

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      // First try to parse as JSON
      try {
        final data = json.decode(responseBody);
        if (response.statusCode == 200) {
          return data;
        } else {
          return {'error': 'API Error', 'message': data['message'] ?? response.reasonPhrase};
        }
      } catch (e) {
        // If not JSON, return as plain text
        if (response.statusCode == 200) {
          return responseBody;
        } else {
          return {'error': 'API Error', 'message': responseBody};
        }
      }
    } catch (e) {
      print('Exception: $e');
      return {'error': 'Network Error', 'message': e.toString()};
    }
  }

  static Future<dynamic> claimRewards(String walletAddress) async {
    var request = http.Request('GET', Uri.parse('${base_url}/auth/claim-reward/${walletAddress}'));

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      // First try to parse as JSON
      try {
        final data = json.decode(responseBody);
        if (response.statusCode == 200) {
          return data;
        } else {
          return {'error': 'API Error', 'message': data['message'] ?? response.reasonPhrase};
        }
      } catch (e) {
        // If not JSON, return as plain text
        if (response.statusCode == 200) {
          return responseBody;
        } else {
          return {'error': 'API Error', 'message': responseBody};
        }
      }
    } catch (e) {
      print('Exception: $e');
      return {'error': 'Network Error', 'message': e.toString()};
    }
  }
}
