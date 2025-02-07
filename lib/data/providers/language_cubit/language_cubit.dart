import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<String> {
  static const String _languageCodeKey = 'languageCode';

  LanguageCubit() : super('en') {
    loadSavedLanguage();
  }

  // Load the saved language code from SharedPreferences
  Future<void> loadSavedLanguage() async {
    const savedLanguageCode = "en";
    emit(savedLanguageCode);
  }

  // Update the language and save it in SharedPreferences
  Future<void> changeLanguage(String languageCode) async {
    emit(languageCode);
  }
}

