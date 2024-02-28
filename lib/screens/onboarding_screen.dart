import 'package:financial_calculator/const/app_styles_text.dart';
import 'package:financial_calculator/const/images.dart';
import 'package:flutter/material.dart';

class StartWidget extends StatelessWidget {
  const StartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 72),
            Image(
              image: AssetImage(startimage),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'Добро пожаловать в \nFinancial Planner!',
                style: mainText,
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'Здесь вы сможете легко рассчитать \nстоимость ипотеки и создать\nфинансовый план на будущее.',
                style: discriptionText,
              ),
            ),
            SizedBox(height: 45),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/mainscreen');
                        },
                        child: Text('Начать'))),
              ),
            )
          ],
        )
      ]),
    );
  }
}
