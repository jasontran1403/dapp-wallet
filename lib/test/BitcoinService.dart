import 'dart:convert';
import 'package:http/http.dart' as http;

class BitcoinService {
  // static const String _baseUrl = 'https://api.blockcypher.com/v1/btc/main';
  static const String _baseUrl = 'https://api.blockcypher.com/v1/btc/test3';

  /// ✅ Tạo ví mới
  static Future<Map<String, dynamic>> createWallet() async {
    final url = Uri.parse('$_baseUrl/addrs');
    final response = await http.post(url);

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return {
        'address': data['address'],
        'private': data['private'],
        'public': data['public'],
        'wif': data['wif'], // Dạng private key chuẩn
      };
    } else {
      print("❌ create new wallet error: ${response.statusCode} | ${response.body}");
      throw Exception('Failed to create wallet');
    }
  }

  /// ✅ Lấy số dư của ví
  static Future<double> getBalance(String address) async {
    final url = Uri.parse('$_baseUrl/addrs/$address/balance');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['final_balance'] / 100000000; // satoshi to BTC
    } else {
      print("❌ getBalance error: ${response.statusCode} | ${response.body}");
      throw Exception('Failed to fetch balance: ${response.body}');
    }
  }


  /// ✅ Lấy lịch sử giao dịch
  static Future<List<dynamic>> getTxHistory(String address) async {
    final url = Uri.parse('$_baseUrl/addrs/$address/full');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['txs'];
    } else {
      print("❌ getTxHistory error: ${response.statusCode} | ${response.body}");
      throw Exception('Failed to fetch transaction history: ${response.body}');
    }
  }


  /// ✅ Alias để tương thích với UI
  static Future<String> getTransactionHistory(String address) async {
    final txs = await getTxHistory(address);
    if (txs.isEmpty) return 'Không có giao dịch nào.';

    // Tóm tắt đơn giản các giao dịch
    return txs.take(5).map((tx) {
      final hash = tx['hash'];
      final total = tx['total'] / 100000000; // satoshi to BTC
      final confirmed = tx['confirmed'] ?? 'Chưa xác nhận';
      return '🔁 TX: $hash\n💰 Tổng: $total BTC\n🕒 $confirmed\n';
    }).join('\n');
  }


  /// ✅ Tạo giao dịch
  static Future<String> sendTransaction({
    required String fromAddress,
    required String toAddress,
    required String privateKeyWif,
    required int amountSatoshi, // ví dụ 100000 = 0.001 BTC
  }) async {
    final newTx = {
      "inputs": [
        {"addresses": [fromAddress]}
      ],
      "outputs": [
        {
          "addresses": [toAddress],
          "value": amountSatoshi,
        }
      ]
    };

    final createTxUrl = Uri.parse('$_baseUrl/txs/new');
    final createRes = await http.post(createTxUrl, body: json.encode(newTx), headers: {
      'Content-Type': 'application/json',
    });

    if (createRes.statusCode != 201) {
      throw Exception('Failed to create transaction: ${createRes.body}');
    }

    final txData = json.decode(createRes.body);

    // Sign transaction with private key
    final toSign = txData['tosign'];
    final signatures = <String>[]; // TODO: bạn cần ký `tosign` bằng privateKeyWif
    final pubkeys = <String>[];    // TODO: lấy public key từ privateKeyWif

    // Tạm thời để trống vì ký cần thêm thư viện ký (hoặc server hỗ trợ)
    // Có thể dùng `bitcoin_flutter` hoặc `bitcoinjs-lib` trên backend

    final sendTx = {
      "tx": txData['tx'],
      "tosign": toSign,
      "signatures": signatures,
      "pubkeys": pubkeys,
    };

    final sendUrl = Uri.parse('$_baseUrl/txs/send');
    final sendRes = await http.post(sendUrl, body: json.encode(sendTx), headers: {
      'Content-Type': 'application/json',
    });

    if (sendRes.statusCode == 201) {
      final result = json.decode(sendRes.body);
      return result['tx']['hash'];
    } else {
      throw Exception('Failed to send transaction: ${sendRes.body}');
    }
  }
}
