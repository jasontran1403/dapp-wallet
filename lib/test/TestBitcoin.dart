import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'BitcoinService.dart';

class BitcoinTestnetUI extends StatefulWidget {
  const BitcoinTestnetUI({super.key});

  @override
  State<BitcoinTestnetUI> createState() => _BitcoinTestnetUIState();
}

class _BitcoinTestnetUIState extends State<BitcoinTestnetUI> {
  String address = '';
  String privateKey = '';
  String mnemonic = '';
  String message = '';
  dynamic walletInfo;
  bool isLoading = false;

  TextEditingController walletAddressController = TextEditingController();
  TextEditingController privateKeyController = TextEditingController();
  TextEditingController toAddressController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  void _createWallet() async {
    setState(() {
      isLoading = true;
      walletInfo = null;
    });

    try {
      final newWallet = await BitcoinService.createWallet();
      setState(() {
        walletInfo = newWallet;
        walletAddressController.text = newWallet['address'] ?? '';
        privateKeyController.text = newWallet['private'] ?? '';
        address = newWallet['address'] ?? '';
        privateKey = newWallet['private'] ?? '';
        isLoading = false;
      });
    } catch (e) {
      print('Lỗi khi tạo ví: $e');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Tạo ví thất bại: $e'),
      ));
    }
  }



  void _getBalance() async {
    if (address.isEmpty) return;
    final balance = await BitcoinService.getBalance(address);
    setState(() {
      message = 'Balance: $balance BTC';
    });
  }

  void _getHistory() async {
    if (address.isEmpty) return;
    final history = await BitcoinService.getTransactionHistory(address);
    setState(() {
      message = history;
    });
  }

  void _sendBTC() async {
    if (address.isEmpty || privateKey.isEmpty) return;

    final toAddress = toAddressController.text.trim();
    final amount = double.tryParse(amountController.text.trim());

    if (toAddress.isEmpty || amount == null) {
      setState(() => message = '⚠️ Nhập địa chỉ và số BTC');
      return;
    }

    final tx = await BitcoinService.sendTransaction(
      fromAddress: address,
      toAddress: toAddress,
      privateKeyWif: privateKey,
      amountSatoshi: (amount * 100000000).toInt(),
    );


    setState(() => message = tx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bitcoin Testnet UI")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: isLoading ? null : _createWallet,
              child: isLoading
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 10),
                  Text("Đang tạo ví...")
                ],
              )
                  : const Text("🆕 Tạo ví mới"),
            ),
            const SizedBox(height: 8),
            if (walletInfo != null) ...[
              Row(
                children: [
                  Expanded(child: Text("📬 Address: ${walletInfo['address']}")),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: walletInfo['address']));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đã copy địa chỉ ví!')),
                      );
                    },
                  ),
                ],
              ),

              Text("🔑 Private Key: ${walletInfo['private']}"),
              Text("🧠 WIF: ${walletInfo['wif']}"),
            ],
            const Divider(),
            ElevatedButton(
              onPressed: _getBalance,
              child: const Text("💰 Lấy số dư"),
            ),
            ElevatedButton(
              onPressed: _getHistory,
              child: const Text("📜 Lịch sử giao dịch"),
            ),
            const Divider(),
            TextField(
              controller: toAddressController,
              decoration: const InputDecoration(labelText: "Địa chỉ nhận BTC"),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: "Số BTC"),
            ),
            ElevatedButton(
              onPressed: _sendBTC,
              child: const Text("🚀 Gửi BTC"),
            ),
            const Divider(),
            Text("🧾 Message: $message"),
          ],
        ),
      ),
    );
  }
}
