import 'package:financial_calculator/const/app_styles_text.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:intl/intl.dart';

class MortgageCalcWidget extends StatefulWidget {
  final double fullcost;
  final double firstpay;
  final int years;
  final double percent;
  const MortgageCalcWidget(
      {super.key,
      required this.fullcost,
      required this.firstpay,
      required this.years,
      required this.percent});

  @override
  State<MortgageCalcWidget> createState() => _MortgageCalcWidgetState();
}

class _MortgageCalcWidgetState extends State<MortgageCalcWidget> {
  var formatter = NumberFormat.currency(locale: 'ru', symbol: '₽');
  String maindolg = '';
  String percent = '';
  String monthpay = '';
  String giftpercent = '';
  String fullcash = '';
  double firstProgressBarValue = 0.0;
  double secondProgressBarValue = 0.0;

  @override
  void initState() {
    super.initState();
    calculation();
  }

  void calculation() {
    double propertyCost = widget.fullcost;
    double downPayment = widget.firstpay;
    int loanTermYears = widget.years;
    double interestRate = widget.percent / 100;

    // Рассчитываем сумму кредита
    double loanAmount = propertyCost - downPayment;

    // Рассчитываем ежемесячную процентную ставку
    double monthlyInterestRate = interestRate / 12;

    // Рассчитываем общее количество месяцев
    int totalMonths = loanTermYears * 12;

    // Рассчитываем ежемесячную оплату
    double monthlyPayment = loanAmount *
        (monthlyInterestRate * math.pow(1 + monthlyInterestRate, totalMonths)) /
        (math.pow(1 + monthlyInterestRate, totalMonths) - 1);

    // Инициализируем переменные для хранения начисленных процентов и общей суммы выплат
    double totalInterest = 0;
    double totalAmount = 0;

    // Рассчитываем начисленные проценты и общую сумму выплат по каждому месяцу
    for (int i = 1; i <= totalMonths; i++) {
      double monthlyInterest = loanAmount * monthlyInterestRate;
      double monthlyPrincipal = monthlyPayment - monthlyInterest;

      totalInterest +=
          monthlyInterest; // Добавляем проценты к общей сумме процентов
      totalAmount +=
          monthlyPayment; // Добавляем ежемесячный платеж к общей сумме

      // Проверяем, чтобы основной долг не стал отрицательным
      if (loanAmount >= monthlyPrincipal) {
        loanAmount -= monthlyPrincipal;
      } else {
        loanAmount = 0;
      }
    }

    firstProgressBarValue = double.parse(
        ((totalInterest * 100 / totalAmount) / 100).toStringAsFixed(2));
    final secondprogressbar =
        ((propertyCost - downPayment) * 100 / totalAmount) / 100;
    secondProgressBarValue = double.parse(secondprogressbar.toStringAsFixed(2));
    maindolg = (propertyCost - downPayment).toStringAsFixed(2);
    percent = totalInterest.toStringAsFixed(2);
    monthpay = monthlyPayment.toStringAsFixed(2);
    fullcash = totalAmount.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ипотечный калькулятор \nрассчитал',
                style: extens,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  )),
            ],
          ),
          SizedBox(height: 16),
          Text('Процентная ставка', style: discriptionText),
          SizedBox(height: 8),
          buildProgressBar(
            value: firstProgressBarValue,
            backgroundColor: Color(0xFF001A3E),
            fillColor: Colors.white,
          ),
          SizedBox(height: 8),
          Text('Основной долг', style: discriptionText),
          SizedBox(height: 16),
          buildProgressBar(
            value: secondProgressBarValue,
            backgroundColor: Color(0xFF001A3E),
            fillColor: Colors.white,
          ),
          SizedBox(height: 25),
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
                          'Основной долг',
                          style: discriptionText.copyWith(color: Colors.white),
                        ),
                        Text(('${maindolg}₽'), style: discriptionText)
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
                            'Процентная ставка',
                            style:
                                discriptionText.copyWith(color: Colors.white),
                          ),
                          Text('${percent}₽', style: discriptionText)
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
          SizedBox(height: 25),
          Container(
            height: 162,
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
                          'Ежемесячная оплата',
                          style: discriptionText.copyWith(color: Colors.white),
                        ),
                        Text(('${monthpay}₽'), style: discriptionText)
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
                            'Начисленные предметы',
                            style:
                                discriptionText.copyWith(color: Colors.white),
                          ),
                          Text('${percent}₽', style: discriptionText)
                        ],
                      ),
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
                            'Долг + проценты',
                            style:
                                discriptionText.copyWith(color: Colors.white),
                          ),
                          Text('${fullcash}₽', style: discriptionText)
                        ],
                      ),
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }

  Widget buildProgressBar({
    required double value,
    required Color backgroundColor,
    required Color fillColor,
  }) {
    return Container(
      width: double.infinity,
      height: 38,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Container(
            width: 300 * value,
            decoration: BoxDecoration(
              color: fillColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  '${(value * 100).toInt()}%',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
