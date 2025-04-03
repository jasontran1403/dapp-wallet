import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class CoinData {
  final String symbol;
  final String name;
  final double price;
  final double change24h;
  final double volume24h;
  final double marketCap;

  CoinData({
    required this.symbol,
    required this.price,
    required this.name,
    required this.change24h,
    required this.volume24h,
    required this.marketCap,
  });
}

class MarketScreen extends StatefulWidget {
  MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final appController = Get.find<AppController>();
  List<CoinData> coins = [];
  bool isLoading = true;
  bool hasError = false;

  final Map<String, String> coinNames = {
    'BTCUSDT': 'Bitcoin',
    'ETHUSDT': 'Ethereum',
    'XRPUSDT': 'Ripple',
    'BNBUSDT': 'Binance Coin',
    'SOLUSDT': 'Solana',
    'DOGEUSDT': 'Dogecoin',
    'TRXUSDT': 'Tron',
    'TONUSDT': 'Toncoin',
    'XLMUSDT': 'Stellar',
    'LINKUSDT': 'Chainlink',
    'DOTUSDT': 'Polkadot',
    'UNIUSDT': 'Uniswap',
    'TRUMPUSDT': 'Official Trump',
    'SUIUSDT': 'Sui',
    'SHIBUSDT': 'Shiba Inu',
    'PEPEUSDT': 'Pepe',
    'ARBUSDT': 'Arbitrum',
    'HBARUSDT': 'Hedera Hashgraph',
    'LTCUSDT': 'Litecoin',
    'BCHUSDT': 'Bitcoin Cash',
    'OMUSDT': 'Mantra',
    'DAIUSDT': 'Dai',
    'NEARUSDT': 'Near Protocol',
    'UNIUSDT': 'Uniswap'
  };

  @override
  void initState() {
    super.initState();
    fetchMarketData();
  }

  Future<void> fetchMarketData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.binance.com/api/v3/ticker/24hr'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<CoinData> tempList = [];

        for (var item in data) {
          String symbol = item['symbol'].toString();

          // Check if the symbol ends with 'USDT' and the base symbol is in coinNames
          if (symbol.endsWith('USDT')) {
            // Check if the base symbol is in coinNames
            if (coinNames.containsKey(symbol)) {
              tempList.add(CoinData(
                symbol: symbol.replaceAll('USDT', ''),
                name: coinNames[symbol]!,
                price: double.parse(item['lastPrice']),
                change24h: double.parse(item['priceChangePercent']),
                volume24h: double.parse(item['volume']),
                marketCap: double.parse(item['quoteVolume']),
              ));
            }
          }
        }

        setState(() {
          coins = tempList;  // Now coins will have only the coins in coinNames
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }


  Widget _buildDataRow(String title, String value, {Color? color}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontFamily: 'dmsans',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: color ?? Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'dmsans',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoinRow(CoinData coin) {
    final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 2);
    final formatPercent = NumberFormat.decimalPercentPattern(decimalDigits: 2);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4), // Thêm dòng này
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coinNames[coin.symbol] ?? coin.symbol,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'dmsans',
                  ),
                ),
                Text(
                  coin.name,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.greenAccent,
                    fontFamily: 'dmsans',
                    fontStyle: FontStyle.italic
                  ),
                ),
              ],
            ),
          ),
          _buildDataRow(
            'Price',
            formatCurrency.format(coin.price),
          ),
          _buildDataRow(
            '24h Chg',
            formatPercent.format(coin.change24h / 100),
            color: coin.change24h >= 0 ? Colors.green : Colors.red,
          ),
          _buildDataRow(
            '24h Vol',
            NumberFormat.compact().format(coin.volume24h),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        backgroundColor: primaryBackgroundColor.value,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/background/bg7.png",
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 20),
                    child: Text(
                      "${getTranslated(context, "Market Info") ?? "Market Info"}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: "dmsans",
                      ),
                    ),
                  ),
                  isLoading
                      ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: primaryColor.value,
                      ),
                    ),
                  )
                      : hasError
                      ? Expanded(
                    child: Center(
                      child: Text(
                        getTranslated(context, 'load_data_error') ??
                            'Failed to load data',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  )
                      : Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: coins.length,
                      separatorBuilder: (context, index) =>
                          Divider(height: 1),
                      itemBuilder: (context, index) =>
                          _buildCoinRow(coins[index]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}