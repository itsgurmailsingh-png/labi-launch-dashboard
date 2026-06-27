import 'package:flutter/material.dart';
import '../database/database.dart';
import '../theme/app_theme.dart';

extension RequirementExt on Requirement {
  Color get statusColor => switch (status) {
    'done' => C.green,
    'wip'  => C.yellow,
    _      => C.textMuted,
  };

  String get statusLabel => switch (status) {
    'done' => 'DONE',
    'wip'  => 'WIP',
    _      => 'TODO',
  };

  IconData get statusIcon => switch (status) {
    'done' => Icons.check_circle_outline_rounded,
    'wip'  => Icons.timelapse_rounded,
    _      => Icons.radio_button_unchecked,
  };
}
