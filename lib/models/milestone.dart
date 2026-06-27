import 'package:flutter/material.dart';
import '../database/database.dart';
import '../theme/app_theme.dart';

extension MilestoneExt on Milestone {
  bool get isDone => done == 1;

  Color get statusColor => isDone ? C.green : switch (status) {
    'overdue' => C.red,
    'soon'    => C.yellow,
    _         => C.textMuted,
  };

  String get statusLabel => isDone ? 'Done' : switch (status) {
    'overdue' => 'Overdue',
    'soon'    => 'Soon',
    _         => 'Pending',
  };

  List<String> get linkedIdList =>
      linkedIds.isNotEmpty ? linkedIds.split(',') : [];
}
