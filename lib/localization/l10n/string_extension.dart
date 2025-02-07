import 'package:home_module/localization/l10n/app_localization.dart';
import 'package:flutter/material.dart';

extension LocalizationExtension on String {
  String tr(BuildContext context) {
    return AppLocalizations.of(context)?.translate(this) ?? this;
  }
}
