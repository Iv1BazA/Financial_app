import 'package:financial_calculator/const/models.dart';
import 'package:financial_calculator/screens/expenses_screen.dart';
import 'package:financial_calculator/screens/main_screen.dart';
import 'package:financial_calculator/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ExpensesProvider()),
          ChangeNotifierProvider(create: (context) => IncomeProvider())
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF002E58),
      ),
      home: const StartWidget(),
      routes: {
        '/mainscreen': (context) => MainScreenWidget(),
        '/qwe': (context) => ExpensesWidget()
      },
    );
  }
}
