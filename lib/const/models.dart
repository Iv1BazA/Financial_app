import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Category {
  final String name;
  final IconData icon;

  Category({required this.name, required this.icon});
}

class ExpensesModel {
  final String? name;
  final int? cost;
  final DateTime? date;
  final String? category;

  ExpensesModel({this.name, this.cost, this.date, this.category});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cost': cost,
      'date': date?.millisecondsSinceEpoch,
      'category': category,
    };
  }

  factory ExpensesModel.fromJson(Map<String, dynamic> json) {
    return ExpensesModel(
      name: json['name'],
      cost: json['cost'],
      date: json['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['date'])
          : null,
      category: json['category'],
    );
  }
}

class ExpensesProvider extends ChangeNotifier {
  List<ExpensesModel> expensesList = [];

  void addExpense(ExpensesModel expense) {
    expensesList.add(expense);
    saveExpenses();
    notifyListeners();
  }

  int getTotalExpenses() {
    return expensesList.fold(0, (sum, expense) => sum + (expense.cost ?? 0));
  }

  List<ExpensesModel> getExpensesForDate(DateTime date) {
    return expensesList
        .where((expense) =>
            expense.date != null &&
            expense.date!.year == date.year &&
            expense.date!.month == date.month &&
            expense.date!.day == date.day &&
            expense.cost != null)
        .toList();
  }

  Map<DateTime, int> getExpensesByDate(DateTime startDate, DateTime endDate) {
    Map<DateTime, int> expensesByDate = {};

    for (ExpensesModel expense in expensesList) {
      if (expense.date != null &&
          expense.date!.isAfter(startDate) &&
          expense.date!.isBefore(endDate)) {
        if (expensesByDate.containsKey(expense.date!)) {
          expensesByDate[expense.date!] =
              expensesByDate[expense.date!]! + expense.cost!;
        } else {
          expensesByDate[expense.date!] = expense.cost!;
        }
      }
    }

    return expensesByDate;
  }

  void resetValues() async {
    expensesList.clear();
    await saveExpenses();
    notifyListeners();
  }

  Future<void> saveExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> expensesJsonList =
        expensesList.map((e) => json.encode(e.toJson())).toList();
    prefs.setStringList('expenses', expensesJsonList);
  }

  Future<void> loadExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? expensesJsonList = prefs.getStringList('expenses');
    if (expensesJsonList != null) {
      expensesList = expensesJsonList.map((e) {
        ExpensesModel expense = ExpensesModel.fromJson(json.decode(e));

        return expense;
      }).toList();
    }
  }
}

class IncomeModel {
  final String? name;
  final int? cost;
  final DateTime? date;
  final String? category;

  IncomeModel({this.name, this.cost, this.date, this.category});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cost': cost,
      'date': date?.millisecondsSinceEpoch,
      'category': category,
    };
  }

  factory IncomeModel.fromJson(Map<String, dynamic> json) {
    return IncomeModel(
      name: json['name'],
      cost: json['cost'],
      date: json['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['date'])
          : null,
      category: json['category'],
    );
  }
}

class IncomeProvider extends ChangeNotifier {
  List<IncomeModel> incomeList = [];

  void addIncome(IncomeModel income) {
    incomeList.add(income);
    saveIncome();
    notifyListeners();
  }

  int getTotalIncome() {
    return incomeList.fold(0, (sum, income) => sum + income.cost!);
  }

  List<IncomeModel> getIncomeForDate(DateTime date) {
    return incomeList
        .where((income) =>
            income.date != null &&
            income.date!.year == date.year &&
            income.date!.month == date.month &&
            income.date!.day == date.day)
        .toList();
  }

  Map<DateTime, int> getIncomeByDate(DateTime startDate, DateTime endDate) {
    Map<DateTime, int> incomeByDate = {};

    for (IncomeModel income in incomeList) {
      if (income.date != null &&
          income.date!.isAfter(startDate) &&
          income.date!.isBefore(endDate)) {
        if (incomeByDate.containsKey(income.date!)) {
          incomeByDate[income.date!] =
              incomeByDate[income.date!]! + income.cost!;
        } else {
          incomeByDate[income.date!] = income.cost!;
        }
      }
    }

    return incomeByDate;
  }

  void resetValues() async {
    incomeList.clear();
    await saveIncome();
    notifyListeners();
  }

  Future<void> saveIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> incomeJsonList =
        incomeList.map((e) => json.encode(e.toJson())).toList();
    prefs.setStringList('income', incomeJsonList);
  }

  Future<void> loadIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? incomeJsonList = prefs.getStringList('income');
    if (incomeJsonList != null) {
      incomeList = incomeJsonList.map((e) {
        IncomeModel income = IncomeModel.fromJson(json.decode(e));

        return income;
      }).toList();
    }
  }
}

class News {
  final String title;
  final String date;
  final String description;
  final String imageUrl;
  final String fullText;

  News(
      {required this.title,
      required this.fullText,
      required this.date,
      required this.description,
      required this.imageUrl});
}

class DailyData {
  DateTime date;
  int totalAmount;

  DailyData(this.date, this.totalAmount);
}

class DailyDataWithChart {
  List<DailyData> dailyData;
  BarChart? barChart; // Сделаем barChart необязательным (nullable)

  DailyDataWithChart(this.dailyData, this.barChart);
}

DailyDataWithChart generateDailyData(List<IncomeModel> incomeList,
    List<ExpensesModel> expenseList, int currentIndex) {
  List<DateTime> allDates = [];
  DateTime now = DateTime.now();
  DateTime startDate = now;

  switch (currentIndex) {
    case 0:
      allDates.addAll(incomeList
          .where(
              (income) => income.date != null && isSameDay(income.date!, now))
          .map((income) => income.date!));
      allDates.addAll(expenseList
          .where((expense) =>
              expense.date != null && isSameDay(expense.date!, now))
          .map((expense) => expense.date!));
      break;
    case 1:
      DateTime weekAgo = now.subtract(Duration(days: 7));
      allDates.addAll(incomeList
          .where(
              (income) => income.date != null && income.date!.isAfter(weekAgo))
          .map((income) => income.date!));
      allDates.addAll(expenseList
          .where((expense) =>
              expense.date != null && expense.date!.isAfter(weekAgo))
          .map((expense) => expense.date!));
      break;
    case 2:
      startDate = DateTime(now.year, now.month, 1);
      allDates.addAll(incomeList
          .where((income) =>
              income.date != null && income.date!.isAfter(startDate))
          .map((income) => income.date!));
      allDates.addAll(expenseList
          .where((expense) =>
              expense.date != null && expense.date!.isAfter(startDate))
          .map((expense) => expense.date!));
      break;
    case 3:
      List<DailyData> yearlyData = generateYearlyData(incomeList, expenseList);
      List<BarChartGroupData> barChartGroups =
          generateBarChartGroups(yearlyData);

      BarChart barChart = BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          barGroups: barChartGroups,
        ),
      );

      // Возвращаем DailyDataWithChart с dailyData и barChart
      return DailyDataWithChart(yearlyData, barChart);
  }

  allDates = allDates.toSet().toList();
  allDates.sort();

  List<DailyData> dailyData = [];
  int totalAmount = 0;

  for (DateTime date in allDates) {
    totalAmount = incomeList
            .where((income) => income.date == date)
            .map((income) => income.cost!)
            .fold(0, (sum, income) => sum + income) -
        expenseList
            .where((expense) => expense.date == date)
            .map((expense) => expense.cost!)
            .fold(0, (sum, expense) => sum + expense);

    dailyData.add(DailyData(date, totalAmount));
  }

  // Возвращаем DailyDataWithChart с dailyData (без графика)
  return DailyDataWithChart(dailyData, null);
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

List<DailyData> generateYearlyData(
    List<IncomeModel> incomeList, List<ExpensesModel> expenseList) {
  final now = DateTime.now();
  List<DateTime> allDates = [];
  allDates.addAll(incomeList.map((income) => income.date!));
  allDates.addAll(expenseList.map((expense) => expense.date!));
  allDates = allDates.toSet().toList();
  allDates.sort();

  List<DailyData> yearlyData = [];
  int totalAmount = 0;

  for (int i = 1; i <= 12; i++) {
    DateTime startOfMonth = DateTime(now.year, i, 1);
    DateTime endOfMonth =
        DateTime(now.year, i + 1, 1).subtract(Duration(days: 1));

    int incomeForMonth = incomeList
        .where((income) =>
            income.date != null &&
            income.date!.isAfter(startOfMonth) &&
            income.date!.isBefore(endOfMonth))
        .fold(0, (sum, income) => sum + income.cost!);

    int expenseForMonth = expenseList
        .where((expense) =>
            expense.date != null &&
            expense.date!.isAfter(startOfMonth) &&
            expense.date!.isBefore(endOfMonth))
        .fold(0, (sum, expense) => sum + expense.cost!);

    totalAmount += incomeForMonth - expenseForMonth;
    yearlyData.add(DailyData(DateTime(now.year, i), totalAmount));
  }

  return yearlyData;
}

List<BarChartGroupData> generateBarChartGroups(List<DailyData> dailyData) {
  return List.generate(
    dailyData.length,
    (index) {
      double totalValue = dailyData[index].totalAmount.toDouble();

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            width: 22,
            toY: totalValue,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
        showingTooltipIndicators: [],
      );
    },
  );
}
