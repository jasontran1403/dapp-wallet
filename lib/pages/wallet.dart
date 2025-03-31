import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto_wallet/providers/wallet_provider.dart';
import 'package:crypto_wallet/pages/create_or_import.dart';
import 'package:web3dart/web3dart.dart';
import 'package:crypto_wallet/utils/get_balances.dart';
import 'package:crypto_wallet/components/nft_balances.dart';
import 'package:crypto_wallet/components/send_tokens.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String walletAddress = '';
  String balance = '';
  String balanceUsdt = '';
  String pvKey = '';

  @override
  void initState() {
    super.initState();
    loadWalletData();
  }

  String formatBalance(String balance) {
    try {
      double value = double.parse(balance);

      // Nếu số bằng 0, trả về "0"
      if (value == 0) {
        return "0";
      }

      // Nếu số nhỏ hơn 0.0001 thì giữ lại 7 chữ số thập phân
      if (value < 0.0001) {
        return NumberFormat("0.0000000", "en_US").format(value);
      }

      // Nếu số lớn hơn 0.0001, giữ lại tối đa 6 chữ số thập phân (bỏ số 0 dư)
      return NumberFormat("0.######", "en_US").format(value);
    } catch (e) {
      return "Invalid balance";
    }
  }

  Future<void> loadWalletData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? privateKey = prefs.getString('privateKey');
    if (privateKey != null) {
      final walletProvider = WalletProvider();
      await walletProvider.loadPrivateKey();
      EthereumAddress address = await walletProvider.getPublicKey(privateKey);
      print(address.hex);
      setState(() {
        walletAddress = address.hex;
        pvKey = privateKey;
      });
      print(pvKey);
      String response = await getBalances(address.hex, 'bnb');
      dynamic data = json.decode(response);
      print(data);
      String newBalance = data['result'] ?? '0';

      String responseUsdt = await getBalances(address.hex, 'usdt');
      dynamic dataUsdt = json.decode(responseUsdt);
      print(dataUsdt);
      String newUsdtBalance = dataUsdt['result'] ?? '0';

      // Transform balance from wei to ether
      EtherAmount latestBalance =
          EtherAmount.fromBigInt(EtherUnit.wei, BigInt.parse(newBalance));
      String latestBalanceInEther =
          latestBalance.getValueInUnit(EtherUnit.ether).toString();

      EtherAmount latestBalanceUsdt =
      EtherAmount.fromBigInt(EtherUnit.wei, BigInt.parse(newUsdtBalance));
      String latestBalanceUsdtInEther =
      latestBalanceUsdt.getValueInUnit(EtherUnit.ether).toString();

      setState(() {
        balance = latestBalanceInEther;
        balanceUsdt = latestBalanceUsdtInEther;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Address',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 12.0),
                Text(
                  walletAddress,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  FloatingActionButton(
                    heroTag: 'sendButton', // Unique tag for send button
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SendTokensPage(privateKey: pvKey)),
                      );
                    },
                    child: const Icon(Icons.send),
                  ),
                  const SizedBox(height: 8.0),
                  const Text('Send'),
                ],
              ),
              Column(
                children: [
                  FloatingActionButton(
                    heroTag: 'refreshButton',
                    onPressed: () async {
                      await loadWalletData(); // Gọi lại hàm lấy dữ liệu ví và số dư
                    },
                    child: const Icon(Icons.replay_outlined),
                  ),
                  const SizedBox(height: 8.0),
                  const Text('Refresh'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30.0),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Colors.blue,
                    tabs: [
                      Tab(text: 'Assets'),
                      Tab(text: 'Activities'),
                      Tab(text: 'Options'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Assets Tab
                        Column(
                          children: [
                            Card(
                              margin: const EdgeInsets.all(16.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'BNB',
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      formatBalance(balance), // Đây là số dư BNB
                                      style: const TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              margin: const EdgeInsets.all(16.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Tether USD',
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      formatBalance(balanceUsdt), // Đây là số dư TUSD
                                      style: const TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // NFTs Tab
                        SingleChildScrollView(
                            child: NFTListPage(
                                address: walletAddress, chain: 'sepolia')),
                        // Activities Tab
                        Center(
                          child: ListTile(
                            leading: const Icon(Icons.logout),
                            title: const Text('Logout'),
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.remove('privateKey');
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CreateOrImportPage(),
                                ),
                                (route) => false,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
