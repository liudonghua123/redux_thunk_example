import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './redux.dart';
import 'app.dart';

void main() async {
  runApp(EasyLocalization(
    supportedLocales: [Locale('en', 'US'), Locale('zh', 'CN')],
    path: 'assets/langs',
    child: App(),
  ));
}