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
  } else if (chain == 'eft') {
    url = Uri.https('api.bscscan.com', '/api', {
      'module': 'account',
      'action': 'tokenbalance',
      'contractaddress': '0x3A72d1c47197Cc7DF6d4D28dADbc25dcB09DA55C',
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

Future<String> fetchBNBPrice() async {
  final url = Uri.parse('https://api.binance.com/api/v3/ticker/price?symbol=BNBUSDT');

  final response = await http.get(url);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load BNB price');
  }
}

Future<String> fetchTransactionHistory(String walletAddress, String symbol) async {
  const String apiKey = "T8YV1F7ABVNFNRMI5AEG58RBHN91DPU15N";

  String symbolLowerCase = symbol.toLowerCase(); // Convert to lowercase

  // URL API để lấy lịch sử giao dịch
  String url = '';  // Gán giá trị mặc định để tránh lỗi

  if (symbolLowerCase == 'bnb') {
    url = 'https://api.bscscan.com/api?module=account&action=txlist&address=$walletAddress&startblock=0&endblock=99999999&page=1&offset=10&sort=desc&apikey=$apiKey';
  } else if (symbolLowerCase == 'usdt') {
    url = 'https://api.bscscan.com/api?module=account&action=tokentx&contractaddress=0x55d398326f99059fF775485246999027B3197955&address=$walletAddress&startblock=0&endblock=99999999&page=1&offset=10&sort=desc&apikey=$apiKey';
  } else if (symbolLowerCase == 'eft') {
    url = 'https://api.bscscan.com/api?module=account&action=tokentx&contractaddress=0x3A72d1c47197Cc7DF6d4D28dADbc25dcB09DA55C&address=$walletAddress&startblock=0&endblock=99999999&page=1&offset=10&sort=desc&apikey=$apiKey';
  } else {
    throw Exception('Unsupported symbol: $symbolLowerCase');
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Can not fetch transaction history from Binance Smart Chain');
  }
}


String parseWeiToEther(String wei) {
  try {
    double weiAmount = double.tryParse(wei) ?? 0.0;
    return (weiAmount / 1000000000000000000).toString(); // Chuyển đổi từ Wei sang Ether
  } catch (e) {
    return '0.0';
  }
}

String formatTimestamp(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000); // Chuyển UNIX timestamp sang DateTime
  return '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
}

