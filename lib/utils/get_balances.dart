import 'dart:convert'; // Thêm thư viện để xử lý JSON
import 'package:http/http.dart' as http;

Future<String> getBalances(String walletAddress, String chain) async {
  Uri url;

  if (chain == 'bnb') {
    url = Uri.https('api.bscscan.com', '/api', {
      'module': 'account',
      'action': 'balance',
      'address': walletAddress,
      'apikey': 'T8YV1F7ABVNFNRMI5AEG58RBHN91DPU15N',
    });
  } else if (chain == 'usdt') {
    url = Uri.https('api.bscscan.com', '/api', {
      'module': 'account',
      'action': 'tokenbalance',
      'contractaddress': '0x55d398326f99059ff775485246999027b3197955',
      'address': walletAddress,
      'apikey': 'T8YV1F7ABVNFNRMI5AEG58RBHN91DPU15N',
    });
  } else {
    throw Exception('Unsupported chain');
  }

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to get balances');
  }
}
