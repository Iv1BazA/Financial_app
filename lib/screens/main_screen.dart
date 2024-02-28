import 'package:financial_calculator/screens/mortgage_screen.dart';
import 'package:financial_calculator/screens/news_screen.dart';
import 'package:financial_calculator/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:financial_calculator/const/app_styles_text.dart';
import 'package:financial_calculator/const/models.dart';
import 'package:financial_calculator/screens/analitics_screen.dart';
import 'package:financial_calculator/screens/calc_screen.dart';
import 'package:financial_calculator/screens/expenses_screen.dart';
import 'package:financial_calculator/screens/income_screen.dart';
import 'package:provider/provider.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _currentIndex = 0;
  final CalcExpIncWidget calcExpIncWidget = CalcExpIncWidget();
  final AnalyticsScreen analyticsScreen = AnalyticsScreen();
  final MortgageWidget mortgagescr = MortgageWidget();
  final NewsScreenWidget newsScreen = NewsScreenWidget();
  final SettingsScreen sttngs = SettingsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: IndexedStack(
        index: _currentIndex,
        children: [
          calcExpIncWidget,
          analyticsScreen,
          mortgagescr,
          newsScreen,
          sttngs
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF001A3E),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Аналитика',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Калькулятор',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Новости',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Настройки',
          ),
        ],
      ),
    );
  }
}
