import 'package:flutter/material.dart';

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
}

class ExpensesProvider extends ChangeNotifier {
  List<ExpensesModel> expensesList = [];

  void addExpense(ExpensesModel expense) {
    expensesList.add(expense);
    notifyListeners();
  }

  int getTotalExpenses() {
    return expensesList.fold(0, (sum, expense) => sum + expense.cost!);
  }

  List<ExpensesModel> getExpensesForDate(DateTime date) {
    return expensesList
        .where((expense) =>
            expense.date != null &&
            expense.date!.year == date.year &&
            expense.date!.month == date.month &&
            expense.date!.day == date.day)
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

  void resetValues() {
    expensesList.clear();
    notifyListeners();
  }
}

class IncomeModel {
  final String? name;
  final int? cost;
  final DateTime? date;
  final String? category;

  IncomeModel({this.name, this.cost, this.date, this.category});
}

class IncomeProvider extends ChangeNotifier {
  List<IncomeModel> incomeList = [];

  void addIncome(IncomeModel income) {
    incomeList.add(income);
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

  void resetValues() {
    incomeList.clear();
    notifyListeners();
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
