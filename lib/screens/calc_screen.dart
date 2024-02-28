import 'package:financial_calculator/const/app_styles_text.dart';
import 'package:financial_calculator/const/models.dart';
import 'package:financial_calculator/screens/expenses_screen.dart';
import 'package:financial_calculator/screens/income_screen.dart';
import 'package:financial_calculator/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalcExpIncWidget extends StatefulWidget {
  const CalcExpIncWidget({super.key});

  @override
  State<CalcExpIncWidget> createState() => _CalcExpIncWidgetState();
}

class _CalcExpIncWidgetState extends State<CalcExpIncWidget> {
  int _currentIndex = 0;
  int _currentIndexButton = 0;
  List<bool> isSelected = [true, false];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 65,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Общая сумма',
                      style: sum,
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
                              style: cost,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                Divider(),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        decoration: BoxDecoration(
                          color: Color(0xFF002E58),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(25.0),
                            topRight: const Radius.circular(25.0),
                          ),
                        ),
                        child: isSelected[0]
                            ? IncomeWidgetScreen()
                            : ExpensesWidget(),
                      ),
                    );
                  },
                  child: Text(
                    'Добавить',
                    style: discriptionText.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          ToggleButtonsWidget(
            isSelected: isSelected,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                isSelected = [false, false];
                isSelected[index] = true;
              });
            },
          ),
          SizedBox(height: 25),
          Container(
            height: MediaQuery.of(context).size.height - 180,
            child: isSelected[0] ? IncomeWidget() : Expenses(),
          ),
        ],
      ),
    );
  }
}

class ToggleButtonsWidget extends StatelessWidget {
  final Function(int) onTap;
  final List<bool> isSelected;

  const ToggleButtonsWidget(
      {Key? key, required this.onTap, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ToggleButtons(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSelected[0] ? Colors.white : Color(0xFF001A3E),
            ),
            width: 178,
            child: Center(
              child: Text(
                'Доходы',
                style: TextStyle(
                  color: isSelected[0]
                      ? Color(0xFF002E58)
                      : Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: isSelected[1] ? Colors.white : Color(0xFF001A3E),
            ),
            width: 190,
            child: Center(
              child: Text(
                'Расходы',
                style: TextStyle(
                  color: isSelected[1]
                      ? Color(0xFF002E58)
                      : Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
        onPressed: onTap,
        isSelected: isSelected,
        borderRadius: BorderRadius.circular(9),
        selectedColor: Colors.white,
      ),
    );
  }
}

class Expenses extends StatelessWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensesProvider>(
      builder: (context, expensesProvider, _) {
        return ListView.builder(
          itemCount: expensesProvider.expensesList.length,
          itemBuilder: (context, index) {
            ExpensesModel expense = expensesProvider.expensesList[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff001A3E),
                      borderRadius: BorderRadius.circular(8)),
                  width: double.infinity,
                  height: 72,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            expense.name!,
                            style: maintextOrder,
                          ),
                          Text(
                            '-${expense.cost} ₽',
                            style: maintextOrder,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            expense.category!,
                            style: secondtextOrder,
                          ),
                          Text(
                            DateFormat('dd.MM.yyyy').format(expense.date!),
                            style: secondtextOrder,
                          )
                        ],
                      ),
                    ]),
                  )),
            );
          },
        );
      },
    );
  }
}

class IncomeWidget extends StatelessWidget {
  const IncomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<IncomeProvider>(
      builder: (context, incomeProvider, _) {
        return ListView.builder(
          itemCount: incomeProvider.incomeList.length,
          itemBuilder: (context, index) {
            IncomeModel income = incomeProvider.incomeList[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff001A3E),
                      borderRadius: BorderRadius.circular(8)),
                  width: double.infinity,
                  height: 72,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            income.name!,
                            style: maintextOrder,
                          ),
                          Text(
                            '${income.cost} ₽',
                            style: maintextOrder,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            income.category!,
                            style: secondtextOrder,
                          ),
                          Text(
                            DateFormat('dd.MM.yyyy').format(income.date!),
                            style: secondtextOrder,
                          )
                        ],
                      ),
                    ]),
                  )),
            );
          },
        );
      },
    );
  }
}
