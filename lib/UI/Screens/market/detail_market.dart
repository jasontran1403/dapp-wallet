import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';

class CandleData {
  final DateTime x;
  final double open;
  final double high;
  final double low;
  final double close;

  CandleData({
    required this.x,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });
}

class DetailMarketScreen extends StatefulWidget {
  DetailMarketScreen({super.key});

  @override
  State<DetailMarketScreen> createState() => _DetailMarketScreenState();
}

class _DetailMarketScreenState extends State<DetailMarketScreen> {
  final appController = Get.find<AppController>();
  bool isLoading = false;
  List<CandleData> candleData = [];
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchCandleData();
  }

  Future<void> fetchCandleData() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      const symbol = 'BNBUSDT';
      const interval = '30m';
      const limit = 100;

      final response = await http.get(Uri.parse(
          'https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval&limit=$limit'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<CandleData> newData = [];

        for (var item in jsonData) {
          newData.add(CandleData(
            x: DateTime.fromMillisecondsSinceEpoch(item[0]),
            open: double.parse(item[1]),
            high: double.parse(item[2]),
            low: double.parse(item[3]),
            close: double.parse(item[4]),
          ));
        }

        setState(() {
          candleData = newData;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        hasError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
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

                  // ... Các phần import và class CandleData giữ nguyên

                  Expanded(
                    child: isLoading
                        ? Center(
                      child: CircularProgressIndicator(
                        color: primaryColor.value,
                      ),
                    )
                        : hasError
                        ? Center(
                      child: Text(
                        getTranslated(context, 'load_data_error') ?? 'Failed to load data',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                        : Container(
                      child:
                      SfCartesianChart(
                        zoomPanBehavior: ZoomPanBehavior(
                          enablePinching: true,
                          enablePanning: true,
                          enableSelectionZooming: true,
                          enableMouseWheelZooming: true,
                          zoomMode: ZoomMode.x,
                        ),
                        crosshairBehavior: CrosshairBehavior(
                          enable: true,
                          activationMode: ActivationMode.longPress,
                          lineType: CrosshairLineType.both,
                          lineWidth: 1,
                          lineColor: Colors.grey.withOpacity(1),
                          lineDashArray: const [20, 20],
                          shouldAlwaysShow: false,
                        ),
                        plotAreaBackgroundColor: Colors.black.withOpacity(0.65),
                        primaryXAxis: DateTimeAxis(
                          intervalType: DateTimeIntervalType.minutes,
                          dateFormat: DateFormat.Hm(),
                          majorGridLines: MajorGridLines(
                            width: 1,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          enableAutoIntervalOnZooming: true,
                          axisLine: AxisLine(width: 0),
                        ),
                        primaryYAxis: NumericAxis(
                          opposedPosition: true,
                          numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                          majorGridLines: MajorGridLines(
                            width: 1,
                            color: Colors.grey.withOpacity(1),
                          ),
                          plotOffset: 0.05,
                          axisLine: AxisLine(width: 0),
                        ),
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        series: <CandleSeries<CandleData, DateTime>>[
                          CandleSeries<CandleData, DateTime>(
                            dataSource: candleData,
                            xValueMapper: (CandleData data, _) => data.x,
                            openValueMapper: (CandleData data, _) => data.open,
                            highValueMapper: (CandleData data, _) => data.high,
                            lowValueMapper: (CandleData data, _) => data.low,
                            closeValueMapper: (CandleData data, _) => data.close,
                            bearColor: Colors.redAccent,
                            bullColor: Colors.greenAccent,
                            enableSolidCandles: true,
                          )
                        ],
                      )

                      ,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}