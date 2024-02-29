import 'package:financial_calculator/const/app_styles_text.dart';
import 'package:financial_calculator/const/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expensesProvider =
        Provider.of<ExpensesProvider>(context, listen: false);
    final incomeProvider = Provider.of<IncomeProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 55),
          Text(
            'Settings',
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: 'Roboto'),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              expensesProvider.resetValues();
              incomeProvider.resetValues();
            },
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFF001A3E)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.refresh,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Reset amount',
                    style: discriptionText.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 35),
          GestureDetector(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFF001A3E)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.share,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Share with friends',
                      style: discriptionText.copyWith(color: Colors.white),
                    ),
                    Spacer(),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFF001A3E)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.shield,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Privacy Policy',
                      style: discriptionText.copyWith(color: Colors.white),
                    ),
                    Spacer(),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFF001A3E)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.edit_document,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'terms of Use',
                      style: discriptionText.copyWith(color: Colors.white),
                    ),
                    Spacer(),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
