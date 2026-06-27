import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import '../theme/app_theme.dart';

class AppSidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const AppSidebar({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();

    return Container(
      width: 216,
      color: C.bgSurface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: s4),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: C.borderMuted)),
            ),
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: C.accent,
                    borderRadius: BorderRadius.circular(r1 + 1),
                  ),
                  child: const Center(
                    child: Text('⌬',
                        style: TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                ),
                const SizedBox(width: s2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Labi', style: T.titleSm),
                    Text('Launch Control',
                        style: T.bodyXs.copyWith(color: C.textMuted)),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: s2, vertical: s2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // OVERVIEW
                    const SectionLabel('Overview'),
                    _NavItem(label: 'Dashboard', icon: Icons.grid_view_rounded,
                        index: 0, selected: selectedIndex == 0, onTap: onSelect),
                    _NavItem(label: 'Trajectory', icon: Icons.stacked_bar_chart,
                        index: 1, selected: selectedIndex == 1, onTap: onSelect),

                    // TECHNICAL
                    const SectionLabel('Technical'),
                    _NavItemBadged(
                      label: 'Engineering', icon: Icons.code_rounded,
                      index: 2, selected: selectedIndex == 2, onTap: onSelect,
                      db: db, categories: const ['tech', 'qa'],
                    ),
                    _NavItem(label: 'Protocol Runner', icon: Icons.play_circle_outline_rounded,
                        index: 3, selected: selectedIndex == 3, onTap: onSelect),

                    // PROCESS
                    const SectionLabel('Process'),
                    _NavItemBadged(
                      label: 'App Store Submit', icon: Icons.rocket_launch_outlined,
                      index: 4, selected: selectedIndex == 4, onTap: onSelect,
                      db: db, categories: const ['ios', 'android'],
                    ),
                    _NavItemBadged(
                      label: 'Ops & Legal', icon: Icons.gavel_outlined,
                      index: 5, selected: selectedIndex == 5, onTap: onSelect,
                      db: db, categories: const ['ops'],
                    ),

                    // PRODUCT
                    const SectionLabel('Product'),
                    _NavItem(label: 'Milestones', icon: Icons.flag_outlined,
                        index: 6, selected: selectedIndex == 6, onTap: onSelect),
                    _NavItem(label: 'Requirements', icon: Icons.format_list_bulleted_rounded,
                        index: 7, selected: selectedIndex == 7, onTap: onSelect),
                    _NavItemBadged(
                      label: 'Marketing', icon: Icons.campaign_outlined,
                      index: 8, selected: selectedIndex == 8, onTap: onSelect,
                      db: db, categories: const ['mkt'],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Footer stats
          _SidebarFooter(db: db),
        ],
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final IconData icon;
  final int index;
  final bool selected;
  final ValueChanged<int> onTap;
  final int? badge;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.index,
    required this.selected,
    required this.onTap,
    this.badge,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.selected;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => widget.onTap(widget.index),
        child: AnimatedContainer(
          duration: fast,
          margin: const EdgeInsets.only(bottom: 1),
          padding: const EdgeInsets.symmetric(horizontal: s2 + 2, vertical: 7),
          decoration: BoxDecoration(
            color: isActive
                ? C.accentMuted
                : _hovered
                    ? C.bgHover
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(r2),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 14,
                color: isActive ? C.accent : C.textMuted,
              ),
              const SizedBox(width: s2),
              Expanded(
                child: Text(
                  widget.label,
                  style: T.bodySm.copyWith(
                    color: isActive ? C.textPrimary : C.textSecondary,
                    fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ),
              if (widget.badge != null && widget.badge! > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                    color: C.red.withAlpha(28),
                    borderRadius: BorderRadius.circular(rFull),
                    border: Border.all(color: C.red.withAlpha(55)),
                  ),
                  child: Text(
                    '${widget.badge}',
                    style: T.bodyXs.copyWith(color: C.red, fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItemBadged extends StatelessWidget {
  final String label;
  final IconData icon;
  final int index;
  final bool selected;
  final ValueChanged<int> onTap;
  final AppDatabase db;
  final List<String> categories;

  const _NavItemBadged({
    required this.label,
    required this.icon,
    required this.index,
    required this.selected,
    required this.onTap,
    required this.db,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChecklistItem>>(
      stream: db.watchAllChecklist(),
      builder: (context, snap) {
        final incomplete = (snap.data ?? [])
            .where((i) => categories.contains(i.category) && i.done == 0)
            .length;
        return _NavItem(
          label: label,
          icon: icon,
          index: index,
          selected: selected,
          onTap: onTap,
          badge: incomplete > 0 ? incomplete : null,
        );
      },
    );
  }
}

class _SidebarFooter extends StatelessWidget {
  final AppDatabase db;
  const _SidebarFooter({required this.db});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChecklistItem>>(
      stream: db.watchAllChecklist(),
      builder: (context, snap) {
        final items = snap.data ?? [];
        final done = items.where((i) => i.done == 1).length;
        final crit = items.where((i) => i.tag == 'crit' && i.done == 0).length;
        final pct = items.isNotEmpty ? (done / items.length * 100).round() : 0;

        return Container(
          padding: const EdgeInsets.all(s4),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: C.borderMuted)),
          ),
          child: Column(
            children: [
              // Mini progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(rFull),
                child: LinearProgressIndicator(
                  value: items.isNotEmpty ? done / items.length : 0,
                  backgroundColor: C.borderDefault,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    crit == 0 ? C.green : C.yellow,
                  ),
                  minHeight: 3,
                ),
              ),
              const SizedBox(height: s2),
              Row(
                children: [
                  Text('$pct% complete',
                      style: T.bodyXs.copyWith(color: C.textMuted)),
                  const Spacer(),
                  if (crit > 0)
                    Row(children: [
                      Container(
                          width: 5, height: 5,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: C.red)),
                      const SizedBox(width: 4),
                      Text('$crit blocker${crit == 1 ? '' : 's'}',
                          style: T.bodyXs.copyWith(color: C.red)),
                    ])
                  else
                    Text('No blockers',
                        style: T.bodyXs.copyWith(color: C.green)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
