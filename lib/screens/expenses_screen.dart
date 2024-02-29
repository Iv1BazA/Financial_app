import 'package:financial_calculator/const/app_styles_text.dart';
import 'package:financial_calculator/const/app_styles_txtfield.dart';
import 'package:financial_calculator/const/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class ExpensesWidget extends StatefulWidget {
  const ExpensesWidget({Key? key});

  @override
  State<ExpensesWidget> createState() => _ExpensesWidgetState();
}

class _ExpensesWidgetState extends State<ExpensesWidget> {
  int selectedIdx = 0;
  List<Category> categoryList = [
    Category(name: "Food", icon: Icons.food_bank),
    Category(name: "Transpoer", icon: Icons.directions_car),
    Category(name: "Housing", icon: Icons.home),
    Category(name: "Entertainment", icon: Icons.sports_esports),
    Category(name: "Other", icon: Icons.category),
  ];
  final discription = TextEditingController();
  final cost = TextEditingController();
  final datecontroller = TextEditingController();
  final categoryname = TextEditingController();
  final MaskTextInputFormatter dateMaskFormatter = MaskTextInputFormatter(
      mask: '##.##.####', filter: {"#": RegExp(r'[0-9]')});
  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate:
          currentDate.subtract(Duration(days: 365)), // Ограничение на год назад
      lastDate:
          currentDate.add(Duration(days: 365)), // Ограничение на год вперед
    );

    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        datecontroller.text = DateFormat('dd.MM.yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ExpensesProvider expensesProvider = Provider.of<ExpensesProvider>(context);
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
                'Add expenses',
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
            'Description',
            style: discriptionText,
          ),
          SizedBox(height: 5),
          TextField(
            controller: discription,
            style: discriptionText.copyWith(color: Colors.white),
            decoration: styleTextField.copyWith(
                hintText: 'For example (Buying a bike)'),
          ),
          SizedBox(height: 25),
          Text(
            'Sum',
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
            'Date',
            style: discriptionText,
          ),
          SizedBox(height: 5),
          TextField(
            readOnly: true,
            controller: datecontroller,
            style: TextStyle(color: Colors.white),
            decoration: styleTextField,
            onTap: () {
              _selectDate(context);
            },
          ),
          SizedBox(height: 25),
          Text(
            'Category',
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
                ExpensesModel expense = ExpensesModel(
                  name: discription.text,
                  cost: parsedCost,
                  date: date,
                  category: categoryList[selectedIdx].name,
                );

                expensesProvider.addExpense(expense);
                expensesProvider.loadExpenses();
                Navigator.of(context).pop();
              },
              child: Text(
                'Add',
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
