import 'package:financial_calculator/const/app_styles_text.dart';
import 'package:financial_calculator/const/app_styles_txtfield.dart';
import 'package:financial_calculator/const/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class IncomeWidgetScreen extends StatefulWidget {
  const IncomeWidgetScreen({Key? key});

  @override
  State<IncomeWidgetScreen> createState() => _IncomeWidgetScreenState();
}

class _IncomeWidgetScreenState extends State<IncomeWidgetScreen> {
  final discription = TextEditingController();
  final cost = TextEditingController();
  final datecontroller = TextEditingController();
  final categoryname = TextEditingController();
  final MaskTextInputFormatter dateMaskFormatter = MaskTextInputFormatter(
      mask: '##.##.####', filter: {"#": RegExp(r'[0-9]')});
  int selectedIdx = 0;
  List<Category> categoryList = [
    Category(name: "Зароботная плата", icon: Icons.money),
    Category(name: "Инвестиции", icon: Icons.present_to_all),
    Category(name: "Подарок", icon: Icons.home),
  ];
  @override
  Widget build(BuildContext context) {
    IncomeProvider incomeProvider = Provider.of<IncomeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Добавить доходы',
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
          SizedBox(height: 15),
          Text(
            'Описание',
            style: discriptionText,
          ),
          SizedBox(height: 5),
          TextField(
            controller: discription,
            style: discriptionText.copyWith(color: Colors.white),
            decoration:
                styleTextField.copyWith(hintText: 'Например (Зарплата)'),
          ),
          SizedBox(height: 25),
          Text(
            'Сумма',
            style: discriptionText,
          ),
          SizedBox(height: 5),
          TextField(
            controller: cost,
            style: discriptionText.copyWith(color: Colors.white),
            decoration: styleTextField.copyWith(hintText: '0 Р'),
          ),
          SizedBox(height: 25),
          Text(
            'Дата',
            style: discriptionText,
          ),
          SizedBox(height: 5),
          TextField(
            inputFormatters: [dateMaskFormatter],
            controller: datecontroller,
            style: discriptionText.copyWith(color: Colors.white),
            decoration:
                styleTextField.copyWith(prefixIcon: Icon(Icons.calendar_month)),
          ),
          SizedBox(height: 25),
          Text(
            'Категории',
            style: discriptionText,
          ),
          SizedBox(height: 15),
          buildCategoryRow(categoryList),
          SizedBox(height: 15),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextButton(
              onPressed: () {
                DateTime date =
                    DateFormat('dd.MM.yyyy').parse(datecontroller.text);
                int? parsedCost = int.tryParse(cost.text);
                IncomeModel income = IncomeModel(
                  name: discription.text,
                  cost: parsedCost,
                  date: date,
                  category: categoryList[selectedIdx].name,
                );

                incomeProvider.addIncome(income);
                Navigator.of(context).pop();
              },
              child: Text(
                'Добавить',
                style: TextStyle(color: Color(0xFF002E58)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: discriptionText,
        ),
        SizedBox(height: 5),
        Container(
          height: 55,
          child: TextField(
              decoration: styleTextField.copyWith(hintText: hintText)),
        ),
        SizedBox(height: 25),
      ],
    );
  }

  Widget buildTextFieldWithPrefixIcon(
      String label, String hintText, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: discriptionText,
        ),
        SizedBox(height: 5),
        Container(
          height: 55,
          child: TextField(
              decoration: styleTextField.copyWith(
                  prefixIcon: Icon(
            Icons.calendar_month,
            color: Colors.grey,
          ))),
        ),
        SizedBox(height: 25),
      ],
    );
  }

  Widget buildCategoryRow(List<Category> categories) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: List.generate(
          categories.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                selectedIdx = index;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
              height: 45.0,
              decoration: BoxDecoration(
                color: selectedIdx == index ? Colors.white : Color(0xFF001A3E),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    categories[index].icon,
                    color:
                        selectedIdx == index ? Color(0xFF002E58) : Colors.grey,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    categories[index].name,
                    style: TextStyle(
                      color: selectedIdx == index
                          ? Color(0xFF002E58)
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
