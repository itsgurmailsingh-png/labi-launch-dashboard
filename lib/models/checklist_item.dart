import 'package:flutter/material.dart';
import '../database/database.dart';
import '../theme/app_theme.dart';

extension ChecklistItemExt on ChecklistItem {
  bool get isDone => done == 1;

  Color get tagColor => switch (tag) {
    'crit' => C.red,
    'core' => C.blue,
    'nice' => C.textMuted,
    _      => C.textMuted,
  };

  String get tagLabel => switch (tag) {
    'crit' => 'CRIT',
    'core' => 'CORE',
    'nice' => 'NICE',
    _      => '',
  };
}
