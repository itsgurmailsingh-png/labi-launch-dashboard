import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import '../theme/app_theme.dart';
import '../widgets/checklist_tile.dart';

class TechnicalScreen extends StatelessWidget {
  const TechnicalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(s5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _CheckPanel(db: db, category: 'tech',
              label: 'Engineering', icon: Icons.code_rounded,
              subtitle: 'Core app implementation')),
          const SizedBox(width: s4),
          Expanded(child: _CheckPanel(db: db, category: 'qa',
              label: 'QA & Testing', icon: Icons.bug_report_outlined,
              subtitle: 'Validation on real devices')),
        ],
      ),
    );
  }
}

class _CheckPanel extends StatelessWidget {
  final AppDatabase db;
  final String category;
  final String label;
  final IconData icon;
  final String subtitle;

  const _CheckPanel({
    required this.db, required this.category,
    required this.label, required this.icon, required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChecklistItem>>(
      stream: db.watchByCategory(category),
      builder: (context, snap) {
        final items = snap.data ?? [];
        final done = items.where((i) => i.done == 1).length;
        return Panel(
          label: label,
          icon: icon,
          actions: [
            Text('$done/${items.length}',
                style: T.mono.copyWith(color: C.textMuted)),
            const SizedBox(width: s2),
            // Mini bar
            SizedBox(
              width: 48,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(rFull),
                child: LinearProgressIndicator(
                  value: items.isNotEmpty ? done / items.length : 0,
                  backgroundColor: C.borderDefault,
                  valueColor: const AlwaysStoppedAnimation<Color>(C.blue),
                  minHeight: 3,
                ),
              ),
            ),
          ],
          child: Column(
            children: items.isEmpty
                ? [Padding(
                    padding: const EdgeInsets.all(s4),
                    child: Text('Loading…', style: T.body),
                  )]
                : items.asMap().entries.map((e) => Column(
                    children: [
                      ChecklistTile(
                        item: e.value,
                        onToggle: () => db.toggleChecklistItem(e.value.id),
                      ),
                      if (e.key < items.length - 1)
                        const Divider(height: 1, indent: s3, endIndent: s3),
                    ],
                  )).toList(),
          ),
        );
      },
    );
  }
}
