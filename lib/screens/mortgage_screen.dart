import 'package:financial_calculator/const/app_styles_text.dart';
import 'package:financial_calculator/const/app_styles_txtfield.dart';
import 'package:financial_calculator/screens/mortage_calc.dart';
import 'package:flutter/material.dart';

class MortgageWidget extends StatefulWidget {
  const MortgageWidget({super.key});

  @override
  State<MortgageWidget> createState() => _MortgageWidgetState();
}

class _MortgageWidgetState extends State<MortgageWidget> {
  final fullcost = TextEditingController();
  final firstpay = TextEditingController();
  String selectedMonths = '5';
  String selectedPercentage = '5';

  List<String> monthsList = ['5', '10', '15', '20'];
  List<String> percentageList = ['5', '10', '15', '20'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 45),
          Text(
            'Mortgage \ncalculator',
            style: cost.copyWith(fontSize: 32),
          ),
          SizedBox(height: 25),
          Text(
            'Property value',
            style: discriptionText,
          ),
          SizedBox(height: 5),
          TextField(
            controller: fullcost,
            style: discriptionText.copyWith(color: Colors.white),
            decoration: styleTextField,
          ),
          SizedBox(height: 25),
          Text(
            'First pay',
            style: discriptionText,
          ),
          SizedBox(height: 5),
          TextField(
            controller: firstpay,
            style: discriptionText.copyWith(color: Colors.white),
            decoration: styleTextField,
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 170,
                child: Text(
                  'Term',
                  style: discriptionText,
                ),
              ),
              Container(
                width: 170,
                child: Text(
                  '% Rate',
                  style: discriptionText,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: buildDropdownButton(
                  value: selectedMonths,
                  items: monthsList,
                  onChanged: (value) {
                    setState(() {
                      selectedMonths = value.toString();
                    });
                  },
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: buildDropdownButton(
                  value: selectedPercentage,
                  items: percentageList,
                  onChanged: (value) {
                    setState(() {
                      selectedPercentage = value.toString();
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextButton(
              onPressed: () {
                final fully = double.tryParse(fullcost.text) ?? 0;
                final first = double.tryParse(firstpay.text) ?? 0;
                final year = int.tryParse(selectedMonths) ?? 0;
                final percent = double.tryParse(selectedPercentage) ?? 0;
                print(fully);
                print(first);
                print(year);
                print(percent);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => Container(
                      height: MediaQuery.of(context).size.height * 0.70,
                      decoration: BoxDecoration(
                        color: Color(0xFF002E58),
                      ),
                      child: MortgageCalcWidget(
                        fullcost: fully,
                        firstpay: first,
                        years: year,
                        percent: percent,
                      )),
                );
              },
              child: Text(
                'Calculate',
                style: TextStyle(color: Color(0xFF002E58)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdownButton({
    required String value,
    required List<String> items,
    required void Function(dynamic) onChanged,
  }) {
    return Container(
      height: 55,
      width: 170,
      decoration: BoxDecoration(
        color: Color(0xFF001A3E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        borderRadius: BorderRadius.circular(16),
        value: value,
        onChanged: onChanged,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: discriptionText.copyWith(color: Colors.white),
            ),
          );
        }).toList(),
        style: discriptionText.copyWith(color: Colors.white),
        dropdownColor: Color(0xFF001A3E),
      ),
    );
  }
}
