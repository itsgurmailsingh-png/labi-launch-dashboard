import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import '../theme/app_theme.dart';
import '../widgets/milestone_tile.dart';

class MilestonesScreen extends StatelessWidget {
  const MilestonesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(s5),
      child: StreamBuilder<List<Milestone>>(
        stream: db.watchAllMilestones(),
        builder: (context, snap) {
          final miles = snap.data ?? [];
          final done = miles.where((m) => m.done == 1).length;
          return Panel(
            label: 'Launch Milestones',
            icon: Icons.flag_outlined,
            actions: [
              Text('$done/${miles.length}',
                  style: T.mono.copyWith(color: C.textMuted)),
              const SizedBox(width: s3),
              SizedBox(
                width: 64,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(rFull),
                  child: LinearProgressIndicator(
                    value: miles.isNotEmpty ? done / miles.length : 0,
                    backgroundColor: C.borderDefault,
                    valueColor: const AlwaysStoppedAnimation<Color>(C.green),
                    minHeight: 3,
                  ),
                ),
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.fromLTRB(s4, s4, s3, s2),
              child: Column(
                children: miles.asMap().entries.map((e) => MilestoneTile(
                  milestone: e.value,
                  isLast: e.key == miles.length - 1,
                  onToggle: () => db.toggleMilestone(e.value.id),
                )).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
