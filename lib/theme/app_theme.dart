import 'package:flutter/material.dart';

// ── Color tokens ───────────────────────────────────────────────────────────
class C {
  // Backgrounds
  static const bgBase     = Color(0xFF0C0C0E);
  static const bgSurface  = Color(0xFF111113);
  static const bgElevated = Color(0xFF18181B);
  static const bgHover    = Color(0xFF1E1E22);

  // Borders
  static const borderMuted   = Color(0xFF1F1F24);
  static const borderDefault = Color(0xFF2A2A30);
  static const borderSubtle  = Color(0xFF3A3A42);

  // Text
  static const textPrimary   = Color(0xFFEAEAEC);
  static const textSecondary = Color(0xFF8E8E98);
  static const textMuted     = Color(0xFF52525C);
  static const textDisabled  = Color(0xFF36363E);

  // Accent
  static const accent      = Color(0xFF7C5CFC);
  static const accentMuted = Color(0xFF1A1528);

  // Semantic
  static const green  = Color(0xFF3DD68C);
  static const greenMuted = Color(0xFF0E2A1A);
  static const yellow = Color(0xFFF5A623);
  static const yellowMuted = Color(0xFF2A1E08);
  static const red    = Color(0xFFFF4455);
  static const redMuted   = Color(0xFF2A0E12);
  static const blue   = Color(0xFF3B82F6);
  static const blueMuted  = Color(0xFF0E1E38);
  static const purple = Color(0xFFAB87FF);
  static const purpleMuted = Color(0xFF1E1530);
}

// ── Text styles ────────────────────────────────────────────────────────────
class T {
  static const titleLg   = TextStyle(fontSize: 15, fontWeight: FontWeight.w600, height: 1.3, color: C.textPrimary);
  static const titleMd   = TextStyle(fontSize: 13, fontWeight: FontWeight.w600, height: 1.4, color: C.textPrimary);
  static const titleSm   = TextStyle(fontSize: 12, fontWeight: FontWeight.w600, height: 1.4, color: C.textPrimary);
  static const body      = TextStyle(fontSize: 13, fontWeight: FontWeight.w400, height: 1.6, color: C.textSecondary);
  static const bodySm    = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 1.5, color: C.textSecondary);
  static const bodyXs    = TextStyle(fontSize: 11, fontWeight: FontWeight.w400, height: 1.4, color: C.textMuted);
  static const label     = TextStyle(fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 0.8, height: 1.2, color: C.textMuted);
  static const mono      = TextStyle(fontFamily: 'monospace', fontSize: 11, height: 1.4, color: C.textMuted);
}

// ── Spacing ────────────────────────────────────────────────────────────────
const s1 = 4.0;
const s2 = 8.0;
const s3 = 12.0;
const s4 = 16.0;
const s5 = 20.0;
const s6 = 24.0;

// ── Radius ─────────────────────────────────────────────────────────────────
const r1 = 4.0;
const r2 = 6.0;
const r3 = 8.0;
const r4 = 12.0;
const rFull = 999.0;

// ── Durations ──────────────────────────────────────────────────────────────
const fast   = Duration(milliseconds: 120);
const normal = Duration(milliseconds: 200);

// ── Theme builder ──────────────────────────────────────────────────────────
ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: C.bgBase,
    colorScheme: const ColorScheme.dark(
      surface: C.bgSurface,
      primary: C.accent,
    ),
    dividerTheme: const DividerThemeData(
      color: C.borderMuted,
      space: 1,
      thickness: 1,
    ),
    scrollbarTheme: const ScrollbarThemeData(
      thumbVisibility: WidgetStatePropertyAll(false),
    ),
    textTheme: const TextTheme(
      bodyMedium: T.body,
      bodySmall: T.bodySm,
    ),
  );
}

// ── Reusable layout widgets ────────────────────────────────────────────────

/// Standard panel with 36px header and scrollable body
class Panel extends StatelessWidget {
  final String label;
  final IconData icon;
  final Widget child;
  final List<Widget> actions;

  const Panel({
    super.key,
    required this.label,
    required this.icon,
    required this.child,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: C.bgSurface,
        borderRadius: BorderRadius.circular(r3),
        border: Border.all(color: C.borderMuted),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _PanelHeader(label: label, icon: icon, actions: actions),
          child,
        ],
      ),
    );
  }
}

class _PanelHeader extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<Widget> actions;

  const _PanelHeader({required this.label, required this.icon, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: const BoxDecoration(
        color: C.bgElevated,
        border: Border(bottom: BorderSide(color: C.borderMuted)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: s3),
      child: Row(
        children: [
          Icon(icon, size: 12, color: C.textMuted),
          const SizedBox(width: s2),
          Text(label.toUpperCase(), style: T.label),
          const Spacer(),
          ...actions,
        ],
      ),
    );
  }
}

/// Status badge: green / yellow / red / blue / purple / muted
class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final Color? bgColor;

  const StatusBadge({
    super.key,
    required this.label,
    required this.color,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: s2, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor ?? color.withAlpha(28),
        borderRadius: BorderRadius.circular(rFull),
        border: Border.all(color: color.withAlpha(55)),
      ),
      child: Text(
        label,
        style: T.bodyXs.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

/// Thin section label
class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(s3, s4, s3, s2),
      child: Text(text.toUpperCase(), style: T.label),
    );
  }
}

/// Interactive row — base for nav items, list rows, etc.
class TapRow extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final BorderRadius? borderRadius;
  final bool selected;

  const TapRow({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: s3, vertical: s2),
    this.borderRadius,
    this.selected = false,
  });

  @override
  State<TapRow> createState() => _TapRowState();
}

class _TapRowState extends State<TapRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: fast,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.selected
                ? C.accentMuted
                : _hovered
                    ? C.bgHover
                    : Colors.transparent,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(r2),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

/// Circular progress arc widget
class ArcProgress extends StatelessWidget {
  final double value; // 0.0 – 1.0
  final Color color;
  final double size;
  final double strokeWidth;
  final Widget? center;

  const ArcProgress({
    super.key,
    required this.value,
    required this.color,
    this.size = 64,
    this.strokeWidth = 5,
    this.center,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _ArcPainter(
              value: value,
              color: color,
              strokeWidth: strokeWidth,
              bgColor: color.withAlpha(22),
            ),
          ),
          if (center != null) center!,
        ],
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double value;
  final Color color;
  final double strokeWidth;
  final Color bgColor;

  const _ArcPainter({
    required this.value,
    required this.color,
    required this.strokeWidth,
    required this.bgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    const startAngle = -1.5707963267948966; // -π/2
    const fullAngle = 6.283185307179586;     // 2π

    // Background track
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      fullAngle,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..color = bgColor
        ..strokeCap = StrokeCap.round,
    );
    // Progress
    if (value > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        fullAngle * value,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..color = color
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(_ArcPainter old) =>
      old.value != value || old.color != color;
}
