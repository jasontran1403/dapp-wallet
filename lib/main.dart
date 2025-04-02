import 'package:crypto_wallet/UI/Screens/onBoardingScreens/onboardingScreen2.dart';
import 'package:crypto_wallet/UI/pinScreen.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/credentials.dart';
import 'providers/wallet_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'UI/Screens/onBoardingScreens/onboardingScreen1.dart';
import 'localization/demo_localization.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WalletProvider walletProvider = WalletProvider();
  await walletProvider.loadPrivateKey();

  String? privateKey = walletProvider.privateKey;

  bool isWalletCreated = privateKey != null && privateKey.isNotEmpty;

  if (isWalletCreated) {
    EthereumAddress ethereumAddress = await walletProvider.getPublicKey(privateKey);
    String walletAddress = ethereumAddress.hex;

    if (walletAddress.contains("0x")) {
      isWalletCreated = true;
    } else {
      isWalletCreated = false;
    }
  }

  runApp(
    ChangeNotifierProvider<WalletProvider>.value(
      value: walletProvider,
      child: MyApp(isWalletCreated: isWalletCreated),
    ),
  );
}

checkTheme() async {
  AppController appController = Get.find<AppController>();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Nếu không có giá trị, mặc định là false
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

  appController.isDark.value = isDarkMode;
  appController.changeTheme();
}

class MyApp extends StatelessWidget {
  final bool isWalletCreated;

  const MyApp({super.key, required this.isWalletCreated});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appController=Get.put(AppController());
    checkTheme();

    return
      GetBuilder<AppController>(builder: (appController) {
      return
        GetMaterialApp(
      title: 'Crypto Wallet',
          theme: ThemeData(
              primaryColor: Color(0xff27C19F),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor:  Color(0xff27C19F),
              )
          ),
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: child!,
            );
          },
          locale: appController.locale.value,
          fallbackLocale: appController.locale.value,
          supportedLocales: [
            Locale('en', 'US'),
            Locale('nl', 'BE'),
            Locale('bg', 'BG'),
            Locale('de', 'DE'),
            Locale('id', 'ID'),
            Locale('fr', 'FR'),
            Locale('pt', 'PT'),
            Locale('es', 'ES'),
            Locale('be', 'NL'),
          ],
          localizationsDelegates: [
            DemoLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode && supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          debugShowCheckedModeBanner: false,
          transitionDuration: const Duration(milliseconds: 500),
          defaultTransition: Transition.rightToLeftWithFade,
          home: isWalletCreated ? PinScreen() : OnBoardingScreen1(),
        );
      });
  }
}
class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}


