import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import '../theme/app_theme.dart';
import '../widgets/checklist_tile.dart';

class StoreSubmitScreen extends StatelessWidget {
  const StoreSubmitScreen({super.key});

  static const _iosPhases = ['Account & Setup', 'Build & Binary', 'Store Listing', 'Review Prep'];
  static const _andPhases = ['Account & Setup', 'Build & Binary', 'Store Listing', 'Review Prep'];

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(s5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _StorePanel(
            db: db, platform: 'ios', phases: _iosPhases,
            label: 'iOS — App Store',
            icon: Icons.apple,
            note: 'Apple Developer Program · \$99/yr',
          )),
          const SizedBox(width: s4),
          Expanded(child: _StorePanel(
            db: db, platform: 'android', phases: _andPhases,
            label: 'Android — Google Play',
            icon: Icons.android,
            note: 'Google Play Console · \$25 one-time',
          )),
        ],
      ),
    );
  }
}

class _StorePanel extends StatelessWidget {
  final AppDatabase db;
  final String platform;
  final List<String> phases;
  final String label;
  final IconData icon;
  final String note;

  const _StorePanel({
    required this.db, required this.platform, required this.phases,
    required this.label, required this.icon, required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChecklistItem>>(
      stream: db.watchByCategory(platform),
      builder: (context, snap) {
        final items = snap.data ?? [];
        final done = items.where((i) => i.done == 1).length;
        return Panel(
          label: label,
          icon: icon,
          actions: [
            Text('$done/${items.length}', style: T.mono.copyWith(color: C.textMuted)),
            const SizedBox(width: s2),
            SizedBox(
              width: 48,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(rFull),
                child: LinearProgressIndicator(
                  value: items.isNotEmpty ? done / items.length : 0,
                  backgroundColor: C.borderDefault,
                  valueColor: const AlwaysStoppedAnimation<Color>(C.yellow),
                  minHeight: 3,
                ),
              ),
            ),
          ],
          child: Column(
            children: phases.expand((phase) {
              final phaseItems = items.where((i) => i.meta == phase).toList();
              final phaseDone = phaseItems.where((i) => i.done == 1).length;
              return [
                // Phase header
                Container(
                  padding: const EdgeInsets.fromLTRB(s3, 8, s3, 6),
                  color: C.bgElevated,
                  child: Row(children: [
                    Text(phase.toUpperCase(), style: T.label),
                    const Spacer(),
                    Text('$phaseDone/${phaseItems.length}',
                        style: T.mono.copyWith(fontSize: 9)),
                  ]),
                ),
                const Divider(height: 1),
                ...phaseItems.asMap().entries.map((e) => Column(children: [
                  ChecklistTile(
                    item: e.value,
                    onToggle: () => db.toggleChecklistItem(e.value.id),
                  ),
                  if (e.key < phaseItems.length - 1)
                    const Divider(height: 1, indent: s3, endIndent: s3),
                ])),
                const Divider(height: 1),
              ];
            }).toList(),
          ),
        );
      },
    );
  }
}
