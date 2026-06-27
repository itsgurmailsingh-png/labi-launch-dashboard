import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/database.dart';
import 'seed/seed_data.dart';
import 'theme/app_theme.dart';
import 'widgets/sidebar.dart';
import 'screens/dashboard_screen.dart';
import 'screens/trajectory_screen.dart';
import 'screens/technical_screen.dart';
import 'screens/runner_screen.dart';
import 'screens/store_submit_screen.dart';
import 'screens/ops_screen.dart';
import 'screens/milestones_screen.dart';
import 'screens/requirements_screen.dart';
import 'screens/marketing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();
  if (await db.isEmpty()) await seedData(db);
  runApp(
    Provider<AppDatabase>(
      create: (_) => db,
      dispose: (_, d) => d.close(),
      child: const LabiApp(),
    ),
  );
}

class LabiApp extends StatelessWidget {
  const LabiApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Labi — Launch Control',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const LabiShell(),
    );
  }
}

class LabiShell extends StatefulWidget {
  const LabiShell({super.key});
  @override
  State<LabiShell> createState() => _LabiShellState();
}

class _LabiShellState extends State<LabiShell> {
  int _idx = 0;

  static const _titles = [
    'Dashboard', 'Trajectory', 'Engineering', 'Protocol Runner',
    'App Store Submit', 'Ops & Legal', 'Milestones', 'Requirements', 'Marketing',
  ];

  Widget _screen(int i) => switch (i) {
    0 => DashboardScreen(onNavigate: (j) => setState(() => _idx = j)),
    1 => const TrajectoryScreen(),
    2 => const TechnicalScreen(),
    3 => const RunnerScreen(),
    4 => const StoreSubmitScreen(),
    5 => const OpsScreen(),
    6 => const MilestonesScreen(),
    7 => const RequirementsScreen(),
    8 => const MarketingScreen(),
    _ => const SizedBox.shrink(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bgBase,
      body: Row(
        children: [
          AppSidebar(
            selectedIndex: _idx,
            onSelect: (i) => setState(() => _idx = i),
          ),
          Container(width: 1, color: C.borderMuted),
          Expanded(
            child: Column(
              children: [
                _TopBar(title: _titles[_idx]),
                Expanded(
                  child: _screen(_idx),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final String title;
  const _TopBar({required this.title});

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    return Container(
      height: 48,
      decoration: const BoxDecoration(
        color: C.bgSurface,
        border: Border(bottom: BorderSide(color: C.borderMuted)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: s5),
      child: Row(
        children: [
          Text(title, style: T.titleMd),
          const Spacer(),
          _LaunchBadge(db: db),
          const SizedBox(width: s4),
          Text('Sept 30 2026',
              style: T.bodyXs.copyWith(color: C.textMuted)),
          const SizedBox(width: s4),
          // Days remaining
          StreamBuilder<List<ChecklistItem>>(
            stream: db.watchAllChecklist(),
            builder: (_, __) {
              final days = DateTime(2026, 9, 30).difference(DateTime.now()).inDays;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: s2 + 2, vertical: 4),
                decoration: BoxDecoration(
                  color: C.bgElevated,
                  borderRadius: BorderRadius.circular(r2),
                  border: Border.all(color: C.borderDefault),
                ),
                child: Text('$days d',
                    style: T.mono.copyWith(color: C.yellow)),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LaunchBadge extends StatelessWidget {
  final AppDatabase db;
  const _LaunchBadge({required this.db});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChecklistItem>>(
      stream: db.watchAllChecklist(),
      builder: (context, snap) {
        final items = snap.data ?? [];
        final crit = items.where((i) => i.tag == 'crit' && i.done == 0).length;
        final done = items.where((i) => i.done == 1).length;
        final pct = items.isNotEmpty ? done / items.length : 0.0;

        final (label, color) = crit == 0 && pct > 0.9
            ? ('Ready', C.green)
            : crit == 0
                ? ('On Track', C.yellow)
                : ('Pre-Launch', C.red);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: s2 + 2, vertical: 4),
          decoration: BoxDecoration(
            color: color.withAlpha(22),
            borderRadius: BorderRadius.circular(rFull),
            border: Border.all(color: color.withAlpha(55)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 5, height: 5,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: color),
              ),
              const SizedBox(width: 5),
              Text(label,
                  style: T.bodyXs.copyWith(
                      color: color, fontWeight: FontWeight.w600)),
            ],
          ),
        );
      },
    );
  }
}
