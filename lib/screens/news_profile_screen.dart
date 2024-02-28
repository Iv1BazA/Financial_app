import 'package:financial_calculator/const/app_styles_text.dart';
import 'package:financial_calculator/const/models.dart';
import 'package:flutter/material.dart';

class NewsItemScreen extends StatefulWidget {
  final News news;
  const NewsItemScreen({super.key, required this.news});

  @override
  State<NewsItemScreen> createState() => _NewsItemScreenState();
}

class _NewsItemScreenState extends State<NewsItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFF001A3E)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.news.title,
                      style: newsTxt,
                    ),
                    Text(
                      widget.news.date,
                      style: discriptionText,
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(widget.news.imageUrl)),
                    ),
                    SizedBox(height: 15),
                    Text(
                      widget.news.fullText,
                      style: discriptionText.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.white),
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
