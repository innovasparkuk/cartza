// ─────────────────────────────────────────────────────────────────────────────
//  Cartza — Dark Forest Splash Screen
//  Design: deep dark-green bg, floating ambient orbs, grid overlay,
//          shimmer sweep, animated staggered entry, glow logo
//  Fully responsive: phone → tablet → desktop
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(const CartzaApp());

class CartzaApp extends StatelessWidget {
  const CartzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cartza',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const SplashScreen(),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  DESIGN TOKENS
// ═══════════════════════════════════════════════════════════
abstract class _C {
  static const Color bg        = Color(0xFF060E07);
  static const Color bgMid     = Color(0xFF0A1A0C);
  static const Color bgDeep    = Color(0xFF0D2210);

  static const Color green400  = Color(0xFF72CC77);
  static const Color green300  = Color(0xFF9AD99E);
  static const Color green200  = Color(0xFFBEEBC1);
  static const Color green500  = Color(0xFF4CAF50);
  static const Color green700  = Color(0xFF1B5E20);

  static const Color orange    = Color(0xFFFF6F00);
  static const Color orangeAcc = Color(0xFFFF8C42);

  static const Color textPri   = Color(0xFFF0F7F0);
  static const Color textSec   = Color(0xFF8EB890);
  static const Color textMut   = Color(0xFF5A7A5C);

  static const Color glassG    = Color(0x1A4CAF50);
  static const Color borderG   = Color(0x3372CC77);
}

// ═══════════════════════════════════════════════════════════
//  RESPONSIVE
// ═══════════════════════════════════════════════════════════
class _Screen {
  final double width, height;
  _Screen(BuildContext ctx)
      : width  = MediaQuery.sizeOf(ctx).width,
        height = MediaQuery.sizeOf(ctx).height;

  bool get isDesktop => width >= 1024;
  bool get isTablet  => width >= 600 && width < 1024;
  bool get isNarrow  => width < 380;

  double get scale       => isDesktop ? 1.38 : (isTablet ? 1.18 : 1.0);
  double get maxWidth    => isDesktop ? 520.0 : (isTablet ? 440.0 : double.infinity);
  double get hPad        => isDesktop ? 60 : (isTablet ? 40 : (isNarrow ? 20 : 28));
  double get logoSize    => isDesktop ? 140 : (isTablet ? 120 : (isNarrow ? 88 : 104));
  double get brandFont   => isDesktop ? 50 : (isTablet ? 42 : (isNarrow ? 28 : 34));
  double get tagFont     => isDesktop ? 15 : (isTablet ? 13.5 : (isNarrow ? 10.5 : 12));
  double get badgeFont   => isDesktop ? 13 : (isTablet ? 12 : (isNarrow ? 10 : 11));
}

// ═══════════════════════════════════════════════════════════
//  SPLASH SCREEN
// ═══════════════════════════════════════════════════════════
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  // Orb float (9 s looping)
  late final AnimationController _bgCtrl;
  late final Animation<double> _orb1x, _orb1y, _orb2x, _orb2y;

  // Staggered entry (2.6 s)
  late final AnimationController _entryCtrl;
  late final Animation<double>  _logoOpacity, _logoScale;
  late final Animation<Offset>  _logoSlide;
  late final Animation<double>  _brandOpacity;
  late final Animation<Offset>  _brandSlide;
  late final Animation<double>  _divW, _divOpacity;
  late final Animation<double>  _tagOpacity;
  late final Animation<Offset>  _tagSlide;
  late final Animation<double>  _badgeOpacity;
  late final Animation<Offset>  _badgeSlide;
  late final Animation<double>  _loaderOpacity;

  // Logo pulse glow (2.2 s)
  late final AnimationController _pulseCtrl;
  late final Animation<double>   _pulse;

  // Shimmer sweep (1.8 s)
  late final AnimationController _shimCtrl;
  late final Animation<double>   _shim;

  // Dot loader
  late final AnimationController _dotCtrl;

  @override
  void initState() {
    super.initState();

    // ── Orb float ──
    _bgCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 9))
      ..repeat(reverse: true);

    _orb1x = Tween<double>(begin: -0.05, end:  0.05).animate(
        CurvedAnimation(parent: _bgCtrl, curve: Curves.easeInOut));
    _orb1y = Tween<double>(begin: -0.04, end:  0.06).animate(
        CurvedAnimation(parent: _bgCtrl, curve: Curves.easeInOut));
    _orb2x = Tween<double>(begin:  0.06, end: -0.04).animate(
        CurvedAnimation(parent: _bgCtrl, curve: Curves.easeInOut));
    _orb2y = Tween<double>(begin:  0.04, end: -0.03).animate(
        CurvedAnimation(parent: _bgCtrl, curve: Curves.easeInOut));

    // ── Staggered entry ──
    _entryCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2600))
      ..forward();

    Interval iv(double s, double e, [Curve c = Curves.easeOut]) =>
        Interval(s, e, curve: c);

    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _entryCtrl, curve: iv(0.0, 0.22)));
    _logoScale   = Tween<double>(begin: 0.55, end: 1).animate(
        CurvedAnimation(parent: _entryCtrl,
            curve: iv(0.0, 0.28, Curves.elasticOut)));
    _logoSlide   = Tween<Offset>(
        begin: const Offset(0, -0.35), end: Offset.zero).animate(
        CurvedAnimation(parent: _entryCtrl, curve: iv(0.0, 0.28)));

    _brandOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _entryCtrl, curve: iv(0.15, 0.38)));
    _brandSlide   = Tween<Offset>(
        begin: const Offset(0, 0.28), end: Offset.zero).animate(
        CurvedAnimation(parent: _entryCtrl, curve: iv(0.15, 0.38)));

    _divOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _entryCtrl, curve: iv(0.23, 0.38)));
    _divW       = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _entryCtrl, curve: iv(0.23, 0.46)));

    _tagOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _entryCtrl, curve: iv(0.30, 0.52)));
    _tagSlide   = Tween<Offset>(
        begin: const Offset(0, 0.30), end: Offset.zero).animate(
        CurvedAnimation(parent: _entryCtrl, curve: iv(0.30, 0.52)));

    _badgeOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _entryCtrl, curve: iv(0.42, 0.65)));
    _badgeSlide   = Tween<Offset>(
        begin: const Offset(0, 0.50), end: Offset.zero).animate(
        CurvedAnimation(parent: _entryCtrl, curve: iv(0.42, 0.65)));

    _loaderOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _entryCtrl, curve: iv(0.68, 0.90)));

    // ── Pulse glow ──
    _pulseCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2200))
      ..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.80, end: 1.08).animate(
        CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    // ── Shimmer sweep ──
    _shimCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800))
      ..repeat();
    _shim = Tween<double>(begin: -1.8, end: 2.8).animate(
        CurvedAnimation(parent: _shimCtrl, curve: Curves.linear));

    // ── Dot loader ──
    _dotCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200))
      ..repeat();
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    _entryCtrl.dispose();
    _pulseCtrl.dispose();
    _shimCtrl.dispose();
    _dotCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sc = _Screen(context);

    return Scaffold(
      backgroundColor: _C.bg,
      body: AnimatedBuilder(
        animation: Listenable.merge(
            [_bgCtrl, _entryCtrl, _pulseCtrl, _shimCtrl, _dotCtrl]),
        builder: (context, _) => Stack(fit: StackFit.expand, children: [

          // ── 1. Radial mesh background ──────────────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, -0.25),
                radius: 1.7,
                colors: [
                  Color(0xFF0F2E14),
                  Color(0xFF0A1A0C),
                  Color(0xFF060E07),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // ── 2. Ambient orbs ─────────────────────────────────────────────
          _AmbientOrb(
            frac: Offset(0.12 + _orb1x.value, 0.08 + _orb1y.value),
            color: const Color(0xFF1B5E20),
            diamFrac: sc.isDesktop ? 0.40 : 0.68,
            blur: 100, sc: sc,
          ),
          _AmbientOrb(
            frac: Offset(0.75 + _orb2x.value, 0.68 + _orb2y.value),
            color: const Color(0xFF8D3800),
            diamFrac: sc.isDesktop ? 0.32 : 0.55,
            blur: 90, sc: sc,
          ),
          _AmbientOrb(
            frac: Offset(0.05 + _orb1y.value * 0.5, 0.55),
            color: const Color(0xFF2E7D32),
            diamFrac: sc.isDesktop ? 0.18 : 0.30,
            blur: 70, sc: sc, opacity: 0.08,
          ),

          // ── 3. Grid overlay ─────────────────────────────────────────────
          const _GridOverlay(),

          // ── 4. Shimmer diagonal sweep ───────────────────────────────────
          ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds) => LinearGradient(
              begin: Alignment(_shim.value - 0.4, -0.3),
              end:   Alignment(_shim.value + 0.4,  0.3),
              colors: const [
                Colors.transparent,
                Color(0x07FFFFFF),
                Colors.transparent,
              ],
            ).createShader(bounds),
            child: Container(color: Colors.transparent),
          ),

          // ── 5. Center content ───────────────────────────────────────────
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: sc.maxWidth),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: sc.hPad),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    // Logo
                    SlideTransition(
                      position: _logoSlide,
                      child: FadeTransition(
                        opacity: _logoOpacity,
                        child: ScaleTransition(
                          scale: _logoScale,
                          child: _GlowLogo(
                            size: sc.logoSize,
                            pulse: _pulse.value,
                            shim: _shim.value,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24 * sc.scale),

                    // Brand name
                    SlideTransition(
                      position: _brandSlide,
                      child: FadeTransition(
                        opacity: _brandOpacity,
                        child: _GradientBrandName(fontSize: sc.brandFont),
                      ),
                    ),

                    SizedBox(height: 16 * sc.scale),

                    // Divider
                    FadeTransition(
                      opacity: _divOpacity,
                      child: ClipRect(
                        child: Align(
                          widthFactor: _divW.value,
                          child: Container(
                            height: 1.5,
                            width: 160 * sc.scale,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [
                                Colors.transparent,
                                _C.green400,
                                _C.orange,
                                _C.green400,
                                Colors.transparent,
                              ]),
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 14 * sc.scale),

                    // Tagline
                    SlideTransition(
                      position: _tagSlide,
                      child: FadeTransition(
                        opacity: _tagOpacity,
                        child: Text(
                          'Shop Smarter, Live Better',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: sc.tagFont,
                            fontWeight: FontWeight.w300,
                            letterSpacing: sc.isNarrow ? 1.8 : 2.4,
                            color: _C.textSec,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30 * sc.scale),

                    // Badge pills
                    SlideTransition(
                      position: _badgeSlide,
                      child: FadeTransition(
                        opacity: _badgeOpacity,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8, runSpacing: 8,
                          children: [
                            _BadgePill(
                              icon: Icons.local_shipping_outlined,
                              label: 'Fast Delivery',
                              scale: sc.scale,
                              fontSize: sc.badgeFont,
                            ),
                            _BadgePill(
                              icon: Icons.verified_outlined,
                              label: 'Verified Sellers',
                              scale: sc.scale,
                              fontSize: sc.badgeFont,
                            ),
                            _BadgePill(
                              icon: Icons.lock_outline,
                              label: 'Secure Checkout',
                              scale: sc.scale,
                              fontSize: sc.badgeFont,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 44 * sc.scale),

                    // Dot loader
                    FadeTransition(
                      opacity: _loaderOpacity,
                      child: _DotLoader(ctrl: _dotCtrl, scale: sc.scale),
                    ),

                    SizedBox(height: 10 * sc.scale),

                    FadeTransition(
                      opacity: _loaderOpacity,
                      child: Text(
                        'Preparing your experience…',
                        style: TextStyle(
                          fontSize: (sc.isNarrow ? 9.5 : 11) * sc.scale,
                          color: _C.textMut,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── 6. Version ────────────────────────────────────────────────
          Positioned(
            bottom: math.max(20,
                MediaQuery.of(context).padding.bottom + 14),
            left: 0, right: 0,
            child: FadeTransition(
              opacity: _loaderOpacity,
              child: Text(
                'v3.0.0',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10 * sc.scale,
                  color: _C.textMut.withOpacity(0.35),
                  letterSpacing: 1.8,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  GLOW LOGO
// ═══════════════════════════════════════════════════════════
class _GlowLogo extends StatelessWidget {
  const _GlowLogo({required this.size, required this.pulse, required this.shim});
  final double size;
  final double pulse;
  final double shim;

  @override
  Widget build(BuildContext context) {
    final total = size * 1.45;

    return SizedBox(
      width: total, height: total,
      child: Stack(alignment: Alignment.center, children: [

        // Outer pulsing glow ring
        Transform.scale(
          scale: pulse,
          child: Container(
            width: size * 1.42, height: size * 1.42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(colors: [
                _C.green500.withOpacity(0.16 * pulse),
                Colors.transparent,
              ]),
            ),
          ),
        ),

        // Secondary ring border
        Transform.scale(
          scale: math.max(0.9, pulse * 0.95),
          child: Container(
            width: size * 1.18, height: size * 1.18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: _C.green400.withOpacity(0.12), width: 1),
            ),
          ),
        ),

        // Glass circle
        Container(
          width: size, height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(colors: [
              _C.green500.withOpacity(0.22),
              _C.green500.withOpacity(0.06),
            ]),
            border: Border.all(
                color: _C.green400.withOpacity(0.32), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: _C.green400.withOpacity(0.20),
                blurRadius: 32, spreadRadius: 4,
              ),
            ],
          ),
        ),

        // Cart icon with shimmer
        CustomPaint(
          size: Size(size * 0.64, size * 0.64),
          painter: _CartPainter(shimOffset: shim),
        ),
      ]),
    );
  }
}

// ─── Cart painter with shimmer ───
class _CartPainter extends CustomPainter {
  const _CartPainter({required this.shimOffset});
  final double shimOffset;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final sw = w * 0.115;

    Paint mk(Color c) => Paint()
      ..color = c
      ..style = PaintingStyle.stroke
      ..strokeWidth = sw
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    const orange = Color(0xFFFF8000);
    const green  = Color(0xFF28B846);

    // Handle (orange)
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.08, h * 0.26)
        ..quadraticBezierTo(w * 0.08, h * 0.05, w * 0.26, h * 0.05)
        ..lineTo(w * 0.85, h * 0.05),
      mk(orange),
    );
    // Right vertical (green)
    canvas.drawLine(
        Offset(w * 0.85, h * 0.05), Offset(w * 0.85, h * 0.61), mk(green));
    // Bottom bar (green)
    canvas.drawLine(
        Offset(w * 0.23, h * 0.61), Offset(w * 0.85, h * 0.61), mk(green));
    // Left leg (orange)
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.08, h * 0.26)
        ..lineTo(w * 0.08, h * 0.61)
        ..lineTo(w * 0.23, h * 0.61),
      mk(orange),
    );
    // Wheels (green)
    final wr = sw * 0.88;
    canvas.drawCircle(Offset(w * 0.32, h * 0.80), wr, mk(green));
    canvas.drawCircle(Offset(w * 0.75, h * 0.80), wr, mk(green));

    // Shimmer layer
    final shimX = w * ((shimOffset + 1.8) / 4.6).clamp(0.0, 1.0);
    final shimPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment((shimX / w) * 2 - 1.5, 0),
        end:   Alignment((shimX / w) * 2 + 0.5, 0),
        colors: const [
          Color(0x00FFFFFF), Color(0x22FFFFFF), Color(0x00FFFFFF),
        ],
      ).createShader(Offset.zero & size)
      ..blendMode = BlendMode.srcATop;

    canvas.saveLayer(Offset.zero & size, Paint());
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.08, h * 0.26)
        ..quadraticBezierTo(w * 0.08, h * 0.05, w * 0.26, h * 0.05)
        ..lineTo(w * 0.85, h * 0.05)
        ..moveTo(w * 0.85, h * 0.05)
        ..lineTo(w * 0.85, h * 0.61)
        ..moveTo(w * 0.23, h * 0.61)
        ..lineTo(w * 0.85, h * 0.61)
        ..moveTo(w * 0.08, h * 0.26)
        ..lineTo(w * 0.08, h * 0.61)
        ..lineTo(w * 0.23, h * 0.61),
      mk(orange),
    );
    canvas.drawCircle(Offset(w * 0.32, h * 0.80), wr, mk(green));
    canvas.drawCircle(Offset(w * 0.75, h * 0.80), wr, mk(green));
    canvas.drawRect(Offset.zero & size, shimPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_CartPainter old) => old.shimOffset != shimOffset;
}

// ═══════════════════════════════════════════════════════════
//  GRADIENT BRAND NAME
// ═══════════════════════════════════════════════════════════
class _GradientBrandName extends StatelessWidget {
  const _GradientBrandName({required this.fontSize});
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFFBEEBC1), Color(0xFF72CC77), Color(0xFFBEEBC1)],
        stops: [0.0, 0.5, 1.0],
      ).createShader(bounds),
      child: Text(
        'CARTZA',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          letterSpacing: fontSize * 0.26,
          color: Colors.white,
          height: 1.0,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  BADGE PILL
// ═══════════════════════════════════════════════════════════
class _BadgePill extends StatelessWidget {
  const _BadgePill({
    required this.icon,
    required this.label,
    required this.scale,
    required this.fontSize,
  });
  final IconData icon;
  final String label;
  final double scale;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 12 * scale, vertical: 7 * scale),
      decoration: BoxDecoration(
        color: _C.glassG,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: _C.borderG, width: 1),
        boxShadow: [
          BoxShadow(
            color: _C.green500.withOpacity(0.07),
            blurRadius: 14, spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: fontSize + 2, color: _C.green400),
          SizedBox(width: 6 * scale),
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              color: _C.textSec,
              letterSpacing: 0.3,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  DOT LOADER
// ═══════════════════════════════════════════════════════════
class _DotLoader extends StatelessWidget {
  const _DotLoader({required this.ctrl, required this.scale});
  final AnimationController ctrl;
  final double scale;

  @override
  Widget build(BuildContext context) {
    const colors = [_C.green400, _C.green300, _C.orange];

    return AnimatedBuilder(
      animation: ctrl,
      builder: (_, __) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) {
          final phase = (ctrl.value - i * 0.18).clamp(0.0, 1.0);
          final opacity = math.sin(phase * math.pi).clamp(0.2, 1.0);
          final s = 0.65 + 0.55 * math.sin(phase * math.pi);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4 * scale),
            child: Transform.scale(
              scale: s,
              child: Container(
                width: 7 * scale,
                height: 7 * scale,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (colors[i] as Color).withOpacity(opacity),
                  boxShadow: [
                    BoxShadow(
                      color: (colors[i] as Color).withOpacity(opacity * 0.5),
                      blurRadius: 8, spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  AMBIENT ORB
// ═══════════════════════════════════════════════════════════
class _AmbientOrb extends StatelessWidget {
  const _AmbientOrb({
    required this.frac,
    required this.color,
    required this.diamFrac,
    required this.blur,
    required this.sc,
    this.opacity = 0.16,
  });
  final Offset frac;
  final Color color;
  final double diamFrac, blur, opacity;
  final _Screen sc;

  @override
  Widget build(BuildContext context) {
    final d = sc.width * diamFrac;
    return Positioned(
      left: sc.width * frac.dx - d / 2,
      top:  sc.height * frac.dy - d / 2,
      child: Container(
        width: d, height: d,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(opacity),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(opacity * 0.5),
              blurRadius: blur,
              spreadRadius: blur * 0.35,
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  GRID OVERLAY
// ═══════════════════════════════════════════════════════════
class _GridOverlay extends StatelessWidget {
  const _GridOverlay();

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.035,
      child: CustomPaint(painter: _GridPainter()),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = _C.green400
      ..strokeWidth = 0.5;

    const step = 46.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(_GridPainter _) => false;
}