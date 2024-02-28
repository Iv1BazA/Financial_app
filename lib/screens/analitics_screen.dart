import 'package:financial_calculator/const/app_styles_text.dart';
import 'package:financial_calculator/const/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  late int _currentIndex;
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    isSelected = [true, false, false, false];
  }

  @override
  Widget build(BuildContext context) {
    ExpensesProvider expensesProvider = Provider.of<ExpensesProvider>(context);
    IncomeProvider incomeProvider = Provider.of<IncomeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 45),
          Text(
            'Аналитика',
            style: cost.copyWith(fontSize: 32),
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ToggleButtonsAnaliticsWidget(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                    for (int buttonIndex = 0;
                        buttonIndex < isSelected.length;
                        buttonIndex++) {
                      isSelected[buttonIndex] = buttonIndex == index;
                    }
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 25),
          Container(
            width: 355,
            height: 283,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xff001A3E)),
            child: Consumer<ExpensesProvider>(
              builder: (context, expensesProvider, _) {
                return Consumer<IncomeProvider>(
                  builder: (context, incomeProvider, _) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: buildBarChart(
                          _currentIndex, incomeProvider, expensesProvider),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 25),
          Container(
            height: 55,
            decoration: BoxDecoration(
                color: Color(0xff001A3E),
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Общая сумма',
                    style: discriptionText.copyWith(color: Colors.white),
                  ),
                  Consumer<IncomeProvider>(
                    builder: (context, incomeProvider, _) {
                      int totalIncome = incomeProvider.getTotalIncome();
                      return Consumer<ExpensesProvider>(
                        builder: (context, expensesProvider, _) {
                          int totalExpenses =
                              expensesProvider.getTotalExpenses();
                          int overallTotal = totalIncome - totalExpenses;
                          return Text(
                            '$overallTotal ₽',
                            style: discriptionText,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            height: 108,
            decoration: BoxDecoration(
                color: Color(0xff001A3E),
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Доходы',
                          style: discriptionText.copyWith(color: Colors.white),
                        ),
                        Text(
                          '${incomeProvider.getTotalIncome()}₽',
                          style: discriptionText,
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      color: Color(0xFF002E58),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Расходы',
                            style:
                                discriptionText.copyWith(color: Colors.white),
                          ),
                          if (expensesProvider.getTotalExpenses() != 0)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '-${expensesProvider.getTotalExpenses()}₽',
                                    style: discriptionText,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBarChart(int currentIndex, IncomeProvider incomeProvider,
      ExpensesProvider expensesProvider) {
    List<int> dailyIncomes;
    List<int> dailyExpenses;

    switch (currentIndex) {
      case 0:
        dailyIncomes = incomeProvider
            .getIncomeForDate(DateTime.now())
            .map((income) => income.cost!)
            .toList();
        dailyExpenses = expensesProvider
            .getExpensesForDate(DateTime.now())
            .map((expense) => expense.cost!)
            .toList();
        break;
      case 1:
        dailyIncomes = incomeProvider
            .getIncomeByDate(
                DateTime.now().subtract(Duration(days: 30)), DateTime.now())
            .values
            .toList();
        dailyExpenses = expensesProvider
            .getExpensesByDate(
                DateTime.now().subtract(Duration(days: 30)), DateTime.now())
            .values
            .toList();
        break;
      case 2:
        dailyIncomes = incomeProvider
            .getIncomeByDate(
                DateTime.now().subtract(Duration(days: 12)), DateTime.now())
            .values
            .toList();
        dailyExpenses = expensesProvider
            .getExpensesByDate(
                DateTime.now().subtract(Duration(days: 12)), DateTime.now())
            .values
            .toList();
        break;
      default:
        dailyIncomes = [];
        dailyExpenses = [];
    }

    int maxDailyIncome = dailyIncomes.isNotEmpty
        ? dailyIncomes
            .reduce((value, element) => value > element ? value : element)
        : 1;
    int maxDailyExpense = dailyExpenses.isNotEmpty
        ? dailyExpenses
            .reduce((value, element) => value > element ? value : element)
        : 1;

    int overallTotal = dailyIncomes.isNotEmpty
        ? dailyIncomes.fold(0, (sum, income) => sum + income)
        : 1;

    return BarChart(
      BarChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(
          dailyIncomes.length,
          (index) => BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                width: 22,
                toY: (dailyIncomes[index] - dailyExpenses[index]) /
                    (maxDailyIncome + maxDailyExpense) *
                    overallTotal,
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ToggleButtonsAnaliticsWidget extends StatefulWidget {
  const ToggleButtonsAnaliticsWidget({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  final int currentIndex;
  final Function(int) onTap;

  @override
  _ToggleButtonsAnaliticsWidgetState createState() =>
      _ToggleButtonsAnaliticsWidgetState();
}

class _ToggleButtonsAnaliticsWidgetState
    extends State<ToggleButtonsAnaliticsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ToggleButtons(
        children: [
          buildToggleButton('Сегодня', 0),
          buildToggleButton('Неделя', 1),
          buildToggleButton('Месяц', 2),
          buildToggleButton('Год', 3),
        ],
        onPressed: widget.onTap,
        isSelected: List.generate(
          4,
          (index) => index == widget.currentIndex,
        ),
        borderRadius: BorderRadius.circular(9),
        selectedColor: Colors.white,
      ),
    );
  }

  Widget buildToggleButton(String text, int index) {
    return Container(
      decoration: BoxDecoration(
        color: index == widget.currentIndex ? Colors.white : Color(0xFF001A3E),
      ),
      width: 81,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: index == widget.currentIndex
                ? Color(0xFF002E58)
                : Colors.white.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
