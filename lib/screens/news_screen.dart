import 'package:financial_calculator/const/app_styles_text.dart';
import 'package:financial_calculator/const/images.dart';
import 'package:financial_calculator/const/models.dart';
import 'package:financial_calculator/const/news.dart';
import 'package:financial_calculator/screens/news_profile_screen.dart';
import 'package:flutter/material.dart';

class NewsScreenWidget extends StatefulWidget {
  const NewsScreenWidget({super.key});

  @override
  State<NewsScreenWidget> createState() => _NewsScreenWidgetState();
}

class _NewsScreenWidgetState extends State<NewsScreenWidget> {
  List<News> newsList = [
    News(
        title: 'Внедрение новых технологий для обеспечения безопасности',
        date: '5 февраля 2023',
        description:
            'Внедрение новых технологий играет важную роль в обеспечении безопасности финансовых операций.',
        imageUrl: newsimg6,
        fullText: news1),
    News(
        title: 'Повышение процентной ставки по депозитам для клиентов',
        date: '5 февраля 2023',
        description:
            'Повышение процентной ставки по депозитам для клиентов представляет собой один из механизмов, которыми баннки и финансовые институты могут оперировать для привлечения средств клиентов и управления своей ликвидностью.',
        imageUrl: newsimg1,
        fullText: news2),
    News(
        title: 'Партнерство с финансовыми учреждениями для расширения услуг.',
        date: '5 февраля 2023',
        description:
            'Партнерство с финансовыми учреждениями является важным стратегическим шагом для расширения спектра услуг компании и увеличения ее конкурентоспособности на рынке.',
        imageUrl: newsimg2,
        fullText: news3),
    News(
        title: 'Осуществление операций с криптовалютой.',
        date: '5 февраля 2023',
        description:
            'Внедрение операций с криптовалютой – это процесс интеграции возможности проведения финансовых операций с использованием криптовалюты в различные аспекты бизнеса и повседневной жизни.',
        imageUrl: newsimg3,
        fullText: news4),
    News(
        title:
            'Бонусная программа для клиентов за использование онлайн-банкинга.',
        date: '5 февраля 2023',
        description:
            'Программа поощрения клиентов за использование онлайн-банкинга может предлагать различные преимущества, такие как отсутствие комиссий за определенные транзакции, более высокие процентные ставки по депозитам, скидки по кредитам или привилегии при использовании других финансовых инструментов, предлагаемых банком.',
        imageUrl: newsimg4,
        fullText: news5),
    News(
        title: 'Внедрение новых кредитных продуктов для предпринимателей.',
        date: '5 февраля 2023',
        description:
            'Внедрение новых кредитных продуктов для предпринимателей – стратегически важное решение для финансового учреждения, направленное на удовлетворение потребностей предпринимателей и стимулирование роста бизнеса.',
        imageUrl: newsimg5,
        fullText: news6),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 45),
          Text(
            'Новости',
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: 'Roboto'),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            child: Column(
              children: newsList.map((news) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: NewsListItem(news: news),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class NewsListItem extends StatefulWidget {
  final News news;
  const NewsListItem({super.key, required this.news});

  @override
  State<NewsListItem> createState() => _NewsListItemState();
}

class _NewsListItemState extends State<NewsListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewsItemScreen(news: widget.news),
          ),
        );
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color(0xFF001A3E)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            widget.news.imageUrl,
                            width: 105,
                            height: 90,
                            fit: BoxFit.cover,
                          )),
                      SizedBox(width: 15),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          width: 190,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.news.title,
                                style: extens,
                              ),
                              Text(
                                widget.news.date,
                                style: discriptionText,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.news.description,
                  style: maintextOrder.copyWith(fontWeight: FontWeight.w400),
                )
              ],
            ),
          )),
    );
  }
}
