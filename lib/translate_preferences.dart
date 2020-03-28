import 'dart:ui';
import 'package:flutter_translate/flutter_translate.dart';

class TranslatePreferences implements ITranslatePreferences {

  @override
  Future<Locale> getPreferredLocale() async {
    return Locale('en', 'US');
  }

  @override
  Future savePreferredLocale(Locale locale) async {
    return null;
  }
}
