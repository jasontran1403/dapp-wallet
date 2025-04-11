import 'dart:ffi';
import 'dart:math';

import 'package:crypto_wallet/UI/Screens/TransactionHistoryScreen/TransactionScreen.dart';
import 'package:crypto_wallet/UI/Screens/homeScreen/homeScreen.dart';
import 'package:crypto_wallet/UI/common_widgets/bottomNavBar.dart';
import 'package:crypto_wallet/UI/common_widgets/bottomRectangularbtn.dart';
import 'package:crypto_wallet/UI/common_widgets/inputField.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:crypto_wallet/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

import '../../../controllers/appController.dart';
import '../codeScanner.dart';

class ConformationScreen extends StatefulWidget {
  final String walletAddress;
  final String amount;
  final String symbol;
  final String price;
  final String memo;


  // Nhận walletAddress và amount từ SendScreen
  const ConformationScreen({
    required this.walletAddress,
    required this.amount,
    required this.symbol,
    required this.price,
    required this.memo,
    super.key
  });

  @override
  State<ConformationScreen> createState() => _ConformationScreenState();
}

class _ConformationScreenState extends State<ConformationScreen> {

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        backgroundColor: primaryBackgroundColor.value,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Confirmation",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: headingColor.value,
                            fontFamily: "dmsans",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: inputFieldBackgroundColor.value,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Icon(Icons.clear, size: 18, color: headingColor.value),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Text(
                      "Confirm Transfer",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: headingColor.value,
                        fontFamily: "dmsans",
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "We care about your privacy. Please make sure that you want to transfer money.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: lightTextColor.value,
                        fontFamily: "dmsans",
                      ),
                    ),
                    SizedBox(height: 60),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 420,
                          width: Get.width,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              color: inputFieldBackgroundColor2.value,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              // Sử dụng walletAddress và amount nhận được
                              Text(
                                "Recipient wallet",  // Default value if null
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: headingColor.value,
                                  fontFamily: "dmsans",
                                ),
                              ),
                              Text(
                                widget.walletAddress ?? 'No address provided',  // Default value if null
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: lightTextColor.value,
                                  fontFamily: "dmsans",
                                ),
                              ),
                              SizedBox(height: 57),
                              // Sử dụng walletAddress và amount nhận được
                              Text(
                                "Network",  // Default value if null
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: headingColor.value,
                                  fontFamily: "dmsans",
                                ),
                              ),
                              Text(
                                widget.symbol ?? 'No network provided',  // Default value if null
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: lightTextColor.value,
                                  fontFamily: "dmsans",
                                ),
                              ),
                              SizedBox(height: 32),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.amount,  // Hiển thị số ETH
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w700,
                                      color: headingColor.value,
                                      fontFamily: "dmsans",
                                    ),
                                  ),
                                  Text(
                                    ' ${widget.symbol}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: lightTextColor.value,
                                      fontFamily: "dmsans",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 32),
                              Text(
                                "Memo ",  // Default value if null
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: headingColor.value,
                                  fontFamily: "dmsans",
                                ),
                              ),
                              Text(
                                widget.memo ?? 'Not specified',  // Default value if null
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: lightTextColor.value,
                                  fontFamily: "dmsans",
                                ),
                              ),
                              SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 60),
                  ],
                ),
                Column(
                  children: [
                    BottomRectangularBtn(
                      onTapFunc: () {
                        // Show the bottom sheet with the confirmation dialog
                        Get.bottomSheet(
                          clipBehavior: Clip.antiAlias,
                          isScrollControlled: true,
                          backgroundColor: primaryBackgroundColor.value,
                          shape: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32)),
                          ),
                          // Pass the widget directly instead of using 'builder'
                            _showConfirmationDialog(
                              context,
                              widget.amount,
                              widget.symbol,
                              widget.walletAddress,
                              int.tryParse(widget.memo) ?? 0,
                            )
                          // Directly pass the widget
                        );
                      },
                      btnTitle: "Send",
                    ),
                    SizedBox(height: 24),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget confirmStatus() {
    return Container(
      height: Get.height * 0.5,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      color: primaryBackgroundColor.value,
      child: Column(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff76CF56).withOpacity(0.20),
                      Color(0xff55DDAF).withOpacity(0.20),
                    ]
                ),
                shape: BoxShape.circle
            ),
            child: Center(child: SvgPicture.asset("assets/svgs/shield-tick.svg")),
          ),
          SizedBox(height: 32),
          Text(
            "Transaction Completed",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: headingColor.value,
              fontFamily: "dmsans",
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Your transaction has been completed, view details in transaction history.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: lightTextColor.value,
              fontFamily: "dmsans",
            ),
          ),
          SizedBox(height: 32),
          BottomRectangularBtn(onTapFunc: () {
            // Code to view transaction history
          }, btnTitle: "View History"),
          SizedBox(height: 8),
          BottomRectangularBtn(
              onlyBorder: true,
              color: Colors.transparent,
              onTapFunc: () {
                Get.back();
                Get.back();
                Get.back();
                Get.back();
              }, btnTitle: "Home"),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

Widget _showConfirmationDialog(BuildContext context, String amount, String symbol, String walletAddressReceiver, int memo) {
  return Container(
    height: Get.height * 0.5,
    width: Get.width,
    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
    color: primaryBackgroundColor.value,
    child: Column(
      children: [
        Text(
          "Confirm Transfer",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: headingColor.value,
            fontFamily: "dmsans",
          ),
        ),
        SizedBox(height: 24),
        Text(
          "You are about to transfer ${amount} ${symbol} to the wallet address ${walletAddressReceiver}.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: lightTextColor.value,
            fontFamily: "dmsans",
          ),
        ),
        SizedBox(height: 20),
        Text(
          "If you transfer to the wrong network, or the wrong wallet address receiver, we will not be able to assist in recovering your assets.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: redColor.value,
            fontFamily: "dmsans",
            fontStyle: FontStyle.italic,  // Make the text italic
          ),
        ),
        SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Cancel button with Expanded
            Expanded(
              child: BottomRectangularBtn(
                onlyBorder: true,
                color: Colors.transparent,
                onTapFunc: () {
                  Get.back(); // Close the confirmation dialog
                },
                btnTitle: "Cancel",
              ),
            ),
            SizedBox(width: 10),  // Add spacing between buttons
            // Confirm button with Expanded
            Expanded(
              child: BottomRectangularBtn(
                onTapFunc: () {
                  // Confirm and execute the send
                  _sendTransaction(context, walletAddressReceiver, amount, symbol, memo);
                  Get.back(); // Close the confirmation dialog
                },
                btnTitle: "Confirm",
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Future<void> _sendTransaction(BuildContext context, String walletAddressReceiver, String amount, String symbol, int memo) async {
  // Placeholder for sending logic
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? privateKey = prefs.getString('privateKey');
  String? savedWallet = prefs.getString('walletAddress');

  if (privateKey != null && savedWallet != null) {
    // Call the sendTransaction function with the wallet address, amount, and the retrieved private key
    String result ;

    if (symbol == "BNB") {
      result = await sendBNB(walletAddressReceiver, double.parse(amount), privateKey);
    } else if (symbol == "USDT") {
      result = await sendUSDTBEP20(walletAddressReceiver, double.parse(amount), privateKey);
    } else if (symbol == "EFT") {
      result = await sendEFT(walletAddressReceiver, double.parse(amount), privateKey);
    } else if (symbol == "ETH") {
      result = await ApiService.createTransactions(savedWallet, symbol, walletAddressReceiver, double.parse(amount), memo);
    } else if (symbol == "BTC") {
      result = await ApiService.createTransactions(savedWallet, symbol, walletAddressReceiver, double.parse(amount), memo);
    } else if (symbol == "TON") {
      result = await ApiService.createTransactions(savedWallet, symbol, walletAddressReceiver, double.parse(amount), memo);
    } else if (symbol == "XRP") {
      result = await ApiService.createTransactions(savedWallet, symbol, walletAddressReceiver, double.parse(amount), memo);
    } else {
      result = "Failed";
    }

    _showSuccessDialog(context, result);
  } else {
    // Handle the case where private key is not found
    _showErrorDialog(context, "Private key not found");
  }
}

void _showSuccessDialog(BuildContext context, String transactionHash) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Transaction Successful"),
        content: Text("Transaction Hash: $transactionHash"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Navigate to HomeScreen after closing the dialog
              Navigator.of(context).pop(); // Close the dialog
              Get.offAll(BottomBar());
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}

void _showErrorDialog(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Transaction Failed"),
        content: Text("Error: $errorMessage"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}

Future<String> sendBNB(String receiver, double amount, String privateKey) async {
  try {
    // Setup Web3 client with the Binance Smart Chain RPC URL
    final client = Web3Client("https://bsc-dataseed.binance.org/", http.Client());

    // Create credentials from the private key
    final credentials = EthPrivateKey.fromHex('0x' + privateKey);

    // Get the nonce (transaction count)
    final nonce = await client.getTransactionCount(credentials.address);

    // Convert the amount to Wei (BNB is 18 decimals)
    final weiAmount = BigInt.parse((amount * 1e18).toStringAsFixed(0));

    // Set gas price and gas limit
    final gasPrice = await client.getGasPrice();
    final gasLimit = 21000; // Standard gas for sending BNB

    // Check sender's balance
    final balance = await client.getBalance(credentials.address);
    final bnbBalance = balance.getInWei;

    // Calculate the total transaction cost (amount + gas)
    final gasCost = gasPrice.getInWei * BigInt.from(gasLimit);
    final totalCost = weiAmount + gasCost;

    // Check if balance is sufficient
    if (bnbBalance < totalCost) {
      return "Insufficient funds for amount + gas cost";
    }

    // Convert BigInt to EtherAmount
    EtherAmount amountInEther = EtherAmount.inWei(weiAmount);

    // Build the transaction
    final transaction = Transaction(
      to: EthereumAddress.fromHex(receiver),
      value: amountInEther, // Using EtherAmount here
      gasPrice: gasPrice,
      maxGas: gasLimit,
    );

    // Send the transaction
    final transactionHash = await client.sendTransaction(
      credentials,
      transaction,
      chainId: 56, // BSC Chain ID
    );

    return transactionHash; // Return the transaction hash
  } catch (e) {
    return "Transaction failed: $e"; // Return the error message if something goes wrong
  }
}

Future<String> sendUSDTBEP20(String receiver, double amount, String privateKey) async {
  const String MAINNET_URL = "https://bsc-dataseed.binance.org/";
  const String USDTBEP20_CONTRACT_ADDRESS = "0x55d398326f99059fF775485246999027B3197955"; // USDT contract on BSC

  try {
    // Set up Web3 client and credentials
    final client = Web3Client(MAINNET_URL, http.Client());
    final credentials = EthPrivateKey.fromHex('0x' + privateKey);

    // Convert amount to token's base unit (USDT has 18 decimals, so multiply by 10^6)
    final tokenAmount = BigInt.parse((amount * 1e18).toStringAsFixed(0));

    // Define the ABI for the ERC-20 contract methods we will call
    String abi = '''
    [
      {
        "constant": true,
        "inputs": [{"name": "owner", "type": "address"}],
        "name": "balanceOf",
        "outputs": [{"name": "", "type": "uint256"}],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
      },
      {
        "constant": false,
        "inputs": [{"name": "recipient", "type": "address"}, {"name": "amount", "type": "uint256"}],
        "name": "transfer",
        "outputs": [{"name": "", "type": "bool"}],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
      }
    ]
    ''';

    // Load the contract
    final contract = DeployedContract(
      ContractAbi.fromJson(abi, 'USDT'),
      EthereumAddress.fromHex(USDTBEP20_CONTRACT_ADDRESS),
    );

    // Get the balance of the sender
    final balanceFunction = contract.function('balanceOf');
    final balance = await client.call(
      contract: contract,
      function: balanceFunction,
      params: [credentials.address],
    );
    final senderBalance = balance[0] as BigInt;

    // Check if the sender has enough balance to send the specified amount
    if (senderBalance.compareTo(tokenAmount) < 0) {
      return "Insufficient USDT balance.";
    }

    // Get the latest nonce for the transaction
    final nonce = await client.getTransactionCount(credentials.address);

    // Define gas price and gas limit for the transaction
    final gasPrice = await client.getGasPrice();
    final gasLimit = 60000; // Gas limit for ERC-20 transfers

    // Create the transaction to send USDT
    final transferFunction = contract.function('transfer');
    final transaction = Transaction.callContract(
      contract: contract,
      function: transferFunction,
      parameters: [
        EthereumAddress.fromHex(receiver), // Recipient's address
        tokenAmount, // Amount of USDT to send
      ],
      gasPrice: gasPrice,
      maxGas: gasLimit,
    );

    // Send the transaction
    final transactionHash = await client.sendTransaction(
      credentials,
      transaction,
      chainId: 56, // BSC Chain ID
    );

    return transactionHash; // Return the transaction hash
  } catch (e) {
    return "Transaction failed: $e"; // Return the error message if something goes wrong
  }
}

Future<String> sendEFT(String receiver, double amount, String privateKey) async {
  const String MAINNET_URL = "https://bsc-dataseed.binance.org/";
  const String USDTBEP20_CONTRACT_ADDRESS = "0x3A72d1c47197Cc7DF6d4D28dADbc25dcB09DA55C"; // USDT contract on BSC

  try {
    // Set up Web3 client and credentials
    final client = Web3Client(MAINNET_URL, http.Client());
    final credentials = EthPrivateKey.fromHex('0x' + privateKey);

    // Convert amount to token's base unit (USDT has 18 decimals, so multiply by 10^6)
    final tokenAmount = BigInt.parse((amount * 1e18).toStringAsFixed(0));

    // Define the ABI for the ERC-20 contract methods we will call
    String abi = '''
    [
      {
        "constant": true,
        "inputs": [{"name": "owner", "type": "address"}],
        "name": "balanceOf",
        "outputs": [{"name": "", "type": "uint256"}],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
      },
      {
        "constant": false,
        "inputs": [{"name": "recipient", "type": "address"}, {"name": "amount", "type": "uint256"}],
        "name": "transfer",
        "outputs": [{"name": "", "type": "bool"}],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
      }
    ]
    ''';

    // Load the contract
    final contract = DeployedContract(
      ContractAbi.fromJson(abi, 'USDT'),
      EthereumAddress.fromHex(USDTBEP20_CONTRACT_ADDRESS),
    );

    // Get the balance of the sender
    final balanceFunction = contract.function('balanceOf');
    final balance = await client.call(
      contract: contract,
      function: balanceFunction,
      params: [credentials.address],
    );
    final senderBalance = balance[0] as BigInt;

    // Check if the sender has enough balance to send the specified amount
    if (senderBalance.compareTo(tokenAmount) < 0) {
      return "Insufficient USDT balance.";
    }

    // Get the latest nonce for the transaction
    final nonce = await client.getTransactionCount(credentials.address);

    // Define gas price and gas limit for the transaction
    final gasPrice = await client.getGasPrice();
    final gasLimit = 60000; // Gas limit for ERC-20 transfers

    // Create the transaction to send USDT
    final transferFunction = contract.function('transfer');
    final transaction = Transaction.callContract(
      contract: contract,
      function: transferFunction,
      parameters: [
        EthereumAddress.fromHex(receiver), // Recipient's address
        tokenAmount, // Amount of USDT to send
      ],
      gasPrice: gasPrice,
      maxGas: gasLimit,
    );

    // Send the transaction
    final transactionHash = await client.sendTransaction(
      credentials,
      transaction,
      chainId: 56, // BSC Chain ID
    );

    return transactionHash; // Return the transaction hash
  } catch (e) {
    return "Transaction failed: $e"; // Return the error message if something goes wrong
  }
}

const erc20Abi = '''[
  {"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},
  {"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},
  {"constant":true,"inputs":[],"name":"decimals","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},
  {"constant":true,"inputs":[{"name":"account","type":"address"}],"name":"balanceOf","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},
  {"constant":false,"inputs":[{"name":"to","type":"address"},{"name":"value","type":"uint256"}],"name":"transfer","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"}
]''';