import 'package:financial_calculator/const/app_styles_text.dart';
import 'package:flutter/material.dart';

final styleTextField = InputDecoration(
    fillColor: Color(0xFF001A3E),
    filled: true,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
    hintStyle: discriptionText.copyWith(fontWeight: FontWeight.w400));
