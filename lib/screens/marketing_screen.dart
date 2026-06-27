import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import '../theme/app_theme.dart';
import '../widgets/checklist_tile.dart';

class MarketingScreen extends StatelessWidget {
  const MarketingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(s5),
      child: StreamBuilder<List<ChecklistItem>>(
        stream: db.watchByCategory('mkt'),
        builder: (context, snap) {
          final items = snap.data ?? [];
          final done = items.where((i) => i.done == 1).length;
          return Panel(
            label: 'Marketing & Growth',
            icon: Icons.campaign_outlined,
            actions: [
              Text('$done/${items.length}',
                  style: T.mono.copyWith(color: C.textMuted)),
            ],
            child: Column(
              children: items.asMap().entries.map((e) => Column(children: [
                ChecklistTile(
                  item: e.value,
                  onToggle: () => db.toggleChecklistItem(e.value.id),
                ),
                if (e.key < items.length - 1)
                  const Divider(height: 1, indent: s3, endIndent: s3),
              ])).toList(),
            ),
          );
        },
      ),
    );
  }
}
