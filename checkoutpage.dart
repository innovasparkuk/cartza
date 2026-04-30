import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checkout',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF43A047)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const CheckoutPage(),
    );
  }
}

// ─── Tokens ───────────────────────────────────────────────────────────────────

class C {
  static const g1 = Color(0xFF43A047);
  static const g2 = Color(0xFFFF8F00);
  static const green = Color(0xFF43A047);
  static const orange = Color(0xFFFF8F00);
  static const bg = Color(0xFFF2F3F5);
  static const white = Colors.white;
  static const textPrimary = Color(0xFF1C1C1E);
  static const textSecondary = Color(0xFF6E6E73);
  static const textMuted = Color(0xFFBEBEC0);
  static const border = Color(0xFFE5E5EA);
  static const success = Color(0xFF34C759);
  static const red = Color(0xFFFF3B30);

  static const gradient = LinearGradient(
    colors: [g1, g2],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const gradientDiag = LinearGradient(
    colors: [g1, g2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class T {
  static const h1 = TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: C.textPrimary, letterSpacing: -0.2);
  static const h2 = TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: C.textPrimary);
  static const body = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: C.textPrimary);
  static const caption = TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: C.textSecondary);
  static const label = TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: C.textSecondary);
}

// ─── Gradient Helpers ─────────────────────────────────────────────────────────

class GBox extends StatelessWidget {
  final Widget child;
  final double radius;
  final LinearGradient? gradient;
  const GBox({super.key, required this.child, this.radius = 8, this.gradient});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      gradient: gradient ?? C.gradientDiag,
      borderRadius: BorderRadius.circular(radius),
    ),
    child: child,
  );
}

ShaderMask gText(String text, TextStyle style) => ShaderMask(
  shaderCallback: (b) => C.gradient.createShader(b),
  child: Text(text, style: style.copyWith(color: Colors.white)),
);

// ─── Breakpoint ───────────────────────────────────────────────────────────────

bool isWide(BuildContext ctx) => MediaQuery.of(ctx).size.width >= 720;

// ─── Step Meta ────────────────────────────────────────────────────────────────

class _Step {
  final String label;
  final IconData icon;
  final IconData filled;
  const _Step(this.label, this.icon, this.filled);
}

const _steps = [
  _Step('Address', Icons.location_on_outlined, Icons.location_on_rounded),
  _Step('Payment', Icons.payment_outlined, Icons.payment_rounded),
  _Step('Confirm', Icons.receipt_long_outlined, Icons.receipt_long_rounded),
];

// ─── Main Page ────────────────────────────────────────────────────────────────

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _step = 0;
  bool _processing = false;
  final _pc = PageController();

  void _next() {
    if (_step < 2) {
      _pc.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() => _step++);
    } else {
      _placeOrder();
    }
  }

  void _back() {
    if (_step > 0) {
      _pc.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() => _step--);
    } else {
      Navigator.pop(context);
    }
  }

  void _placeOrder() {
    setState(() => _processing = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _processing = false);
      showDialog(context: context, barrierDismissible: false, builder: (_) => _SuccessDialog());
    });
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wide = isWide(context);
    return Scaffold(
      backgroundColor: C.bg,
      body: wide ? _buildWide() : _buildNarrow(),
    );
  }

  // ── Desktop: side-by-side with centered layout ─────────────────────────────────────────────────

  Widget _buildWide() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1400),
        child: Row(
          children: [
            // LEFT PANEL — branding + stepper
            SizedBox(
              width: 260,
              child: Container(
                decoration: const BoxDecoration(gradient: C.gradientDiag),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              const Icon(Icons.shopping_bag_rounded, color: Colors.white, size: 20),
                              const SizedBox(width: 8),
                              const Text('Cartza', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800, letterSpacing: 0.3)),
                            ]),
                            const SizedBox(height: 28),
                            const Text('Checkout', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
                            const SizedBox(height: 4),
                            Text('3 items · Rs.6,620', style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 12)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 36),
                      // Vertical stepper
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Column(
                          children: List.generate(_steps.length, (i) {
                            final isActive = i == _step;
                            final isDone = i < _step;
                            final s = _steps[i];
                            final isLast = i == _steps.length - 1;
                            return IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(children: [
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 250),
                                      width: 28, height: 28,
                                      decoration: BoxDecoration(
                                        color: isActive ? Colors.white : (isDone ? Colors.white.withOpacity(0.9) : Colors.white.withOpacity(0.2)),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        isDone ? Icons.check_rounded : (isActive ? s.filled : s.icon),
                                        size: 15,
                                        color: isActive ? C.green : (isDone ? C.success : Colors.white.withOpacity(0.6)),
                                      ),
                                    ),
                                    if (!isLast)
                                      Expanded(child: Container(width: 1.5, color: Colors.white.withOpacity(isDone ? 0.7 : 0.25))),
                                  ]),
                                  const SizedBox(width: 12),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5, bottom: 20),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text(s.label,
                                          style: TextStyle(
                                            color: isActive ? Colors.white : Colors.white.withOpacity(isDone ? 0.9 : 0.5),
                                            fontSize: 13,
                                            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                                          )),
                                      if (isActive)
                                        Text('In progress', style: TextStyle(color: Colors.white.withOpacity(0.65), fontSize: 10)),
                                      if (isDone)
                                        Text('Completed', style: TextStyle(color: Colors.white.withOpacity(0.65), fontSize: 10)),
                                    ]),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                      const Spacer(),
                      // Security badge
                      Padding(
                        padding: const EdgeInsets.fromLTRB(22, 0, 22, 28),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(children: [
                            const Icon(Icons.lock_outline_rounded, color: Colors.white, size: 13),
                            const SizedBox(width: 7),
                            Expanded(child: Text('256-bit SSL Secured', style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 11))),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // RIGHT PANEL — form + order summary
            Expanded(
              child: Column(
                children: [
                  // Top bar
                  Container(
                    color: C.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: SafeArea(
                      bottom: false,
                      child: Row(children: [
                        GestureDetector(
                          onTap: _back,
                          child: Row(children: [
                            const Icon(Icons.arrow_back_ios_rounded, size: 14, color: C.textSecondary),
                            const SizedBox(width: 4),
                            const Text('Back', style: TextStyle(fontSize: 12, color: C.textSecondary)),
                          ]),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            gradient: C.gradient,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 12),
                            SizedBox(width: 4),
                            Text('3 items', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                          ]),
                        ),
                      ]),
                    ),
                  ),
                  const Divider(height: 1, color: C.border),

                  // Content row: form | order card
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Form area with centering
                        Expanded(
                          flex: 5,
                          child: Center(
                            child: SizedBox(
                              width: 600,
                              child: PageView(
                                controller: _pc,
                                physics: const NeverScrollableScrollPhysics(),
                                onPageChanged: (i) => setState(() => _step = i),
                                children: const [AddressForm(), PaymentMethod(), OrderSummary()],
                              ),
                            ),
                          ),
                        ),
                        // Order summary sidebar
                        Container(width: 1, color: C.border),
                        SizedBox(
                          width: 240,
                          child: _OrderSidePanel(step: _step, processing: _processing, onNext: _next),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Mobile: stacked with centered layout ───────────────────────────────────────────────────────

  Widget _buildNarrow() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          children: [
            _buildNarrowHeader(),
            Expanded(
              child: PageView(
                controller: _pc,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _step = i),
                children: const [AddressForm(), PaymentMethod(), OrderSummary()],
              ),
            ),
            _buildNarrowBottom(),
          ],
        ),
      ),
    );
  }

  Widget _buildNarrowHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: C.gradientDiag,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18), bottomRight: Radius.circular(18)),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(children: [
          SizedBox(
            height: 42,
            child: Row(children: [
              IconButton(
                onPressed: _back,
                icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 16),
                padding: const EdgeInsets.only(left: 10),
              ),
              const Text('Checkout', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 11),
                  SizedBox(width: 3),
                  Text('3 items', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
                ]),
              ),
            ]),
          ),
          // Compact horizontal stepper
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 12),
            child: _HorizontalStepper(step: _step),
          ),
        ]),
      ),
    );
  }

  Widget _buildNarrowBottom() {
    const labels = ['Continue to Payment', 'Review Order', 'Place Order'];
    return Container(
      color: C.white,
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
      child: SafeArea(
        child: Row(children: [
          if (_step > 0) ...[
            SizedBox(
              width: 40, height: 40,
              child: OutlinedButton(
                onPressed: _back,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  side: const BorderSide(color: C.border, width: 1.2),
                ),
                child: const Icon(Icons.chevron_left_rounded, color: C.textPrimary, size: 19),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: GBox(
              radius: 8,
              gradient: C.gradient,
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: (_processing && _step == 2) ? null : _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: (_processing && _step == 2)
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.white)))
                      : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(labels[_step], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                    const SizedBox(width: 4),
                    Icon(_step < 2 ? Icons.arrow_forward_rounded : Icons.check_rounded, size: 14),
                  ]),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
        ]),
      ),
    );
  }
}

// ─── Horizontal Stepper (mobile) ──────────────────────────────────────────────

class _HorizontalStepper extends StatelessWidget {
  final int step;
  const _HorizontalStepper({required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      child: Row(
        children: List.generate(_steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            final done = (i ~/ 2) < step;
            return Expanded(child: Container(height: 1.5, margin: const EdgeInsets.symmetric(horizontal: 3),
                color: done ? Colors.white : Colors.white.withOpacity(0.28)));
          }
          final idx = i ~/ 2;
          final isActive = idx == step;
          final isDone = idx < step;
          final s = _steps[idx];
          return AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: isActive ? const EdgeInsets.symmetric(horizontal: 9, vertical: 3) : const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: isActive ? Colors.white : (isDone ? Colors.white.withOpacity(0.85) : Colors.transparent),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(
                isDone ? Icons.check_circle_rounded : (isActive ? s.filled : s.icon),
                size: 15,
                color: isActive ? C.green : (isDone ? C.success : Colors.white.withOpacity(0.7)),
              ),
              if (isActive) ...[
                const SizedBox(width: 4),
                Text(s.label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: C.green)),
              ],
            ]),
          );
        }),
      ),
    );
  }
}

// ─── Order Side Panel (desktop right) ────────────────────────────────────────

class _OrderSidePanel extends StatelessWidget {
  final int step;
  final bool processing;
  final VoidCallback onNext;
  const _OrderSidePanel({required this.step, required this.processing, required this.onNext});

  static const _items = [
    _OItem('Wireless Headphones', 2000, 1, '🎧'),
    _OItem('Smartphone Case', 1500, 2, '📱'),
    _OItem('USB-C Cable', 1200, 1, '🔌'),
  ];

  static const _labels = ['Continue to Payment', 'Review Order', 'Place Order'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: C.bg,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(14),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Order Summary', style: T.h1),
                const SizedBox(height: 10),
                // Items
                ..._items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(children: [
                    Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(gradient: C.gradientDiag, borderRadius: BorderRadius.circular(7)),
                      child: Center(child: Text(item.emoji, style: const TextStyle(fontSize: 18))),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(item.name, style: T.h2, maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text('Qty: ${item.qty}', style: T.caption),
                    ])),
                    gText('Rs.${(item.price * item.qty)}', const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                  ]),
                )),
                const SizedBox(height: 10),
                const Divider(color: C.border, height: 1),
                const SizedBox(height: 10),
                _row('Subtotal', 'Rs.6,200'),
                _row('Shipping', 'Rs.300'),
                _row('Tax', 'Rs.120'),
                const SizedBox(height: 8),
                Container(height: 1, decoration: const BoxDecoration(gradient: C.gradient)),
                const SizedBox(height: 8),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const Text('Total', style: T.h1),
                  gText('Rs.6,620', const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                ]),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(color: C.success.withOpacity(0.09), borderRadius: BorderRadius.circular(6)),
                  child: Row(children: [
                    const Icon(Icons.savings_outlined, size: 12, color: C.success),
                    const SizedBox(width: 5),
                    Text('You save Rs.480!', style: T.caption.copyWith(color: C.success, fontWeight: FontWeight.w600)),
                  ]),
                ),
              ]),
            ),
          ),
          // CTA button in panel
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: GBox(
              radius: 8,
              gradient: C.gradient,
              child: SizedBox(
                width: double.infinity,
                height: 38,
                child: ElevatedButton(
                  onPressed: (processing && step == 2) ? null : onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: (processing && step == 2)
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.white)))
                      : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(_labels[step], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                    const SizedBox(width: 4),
                    Icon(step < 2 ? Icons.arrow_forward_rounded : Icons.check_rounded, size: 13),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: T.caption),
        Text(value, style: T.body),
      ]),
    );
  }
}

class _OItem {
  final String name;
  final int price, qty;
  final String emoji;
  const _OItem(this.name, this.price, this.qty, this.emoji);
}

// ─── Success Dialog ───────────────────────────────────────────────────────────

class _SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Container(
          decoration: BoxDecoration(color: C.white, borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(22),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            GBox(radius: 36, child: const SizedBox(width: 58, height: 58, child: Icon(Icons.check_rounded, color: Colors.white, size: 30))),
            const SizedBox(height: 14),
            const Text('Order Placed!', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: C.textPrimary)),
            const SizedBox(height: 6),
            Text('Confirmed. Delivery in 3–5 business days.',
                textAlign: TextAlign.center, style: T.body.copyWith(color: C.textSecondary, height: 1.5)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(gradient: C.gradient, borderRadius: BorderRadius.circular(6)),
              child: const Text('Order #DZ-2024-78341', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 16),
            GBox(
              radius: 8,
              gradient: C.gradient,
              child: SizedBox(
                width: double.infinity, height: 38,
                child: ElevatedButton(
                  onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, foregroundColor: Colors.white,
                    shadowColor: Colors.transparent, elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Continue Shopping', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
              child: const Text('Track My Order', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: C.green)),
            ),
          ]),
        ),
      ),
    );
  }
}

// ─── Shared Field ─────────────────────────────────────────────────────────────

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label, hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Widget? suffix;

  const _Field({
    required this.controller, required this.label, required this.hint, required this.icon,
    this.keyboardType, this.obscureText = false, this.inputFormatters, this.validator, this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      style: T.body,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: T.label,
        hintStyle: T.body.copyWith(color: C.textMuted),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10, right: 8),
          child: ShaderMask(
            shaderCallback: (b) => C.gradient.createShader(b),
            child: Icon(icon, color: Colors.white, size: 16),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: suffix,
        filled: true,
        fillColor: C.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: C.border)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: C.border)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: C.green, width: 1.6)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: C.red)),
        errorStyle: T.caption.copyWith(color: C.red, fontSize: 10),
      ),
    );
  }
}

// ─── Card ─────────────────────────────────────────────────────────────────────

class _Card extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const _Card({required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: C.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: C.border),
      ),
      child: child,
    );
  }
}

// ─── Section Header ───────────────────────────────────────────────────────────

class _SH extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  const _SH({required this.icon, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 3),
      child: Row(children: [
        GBox(
          radius: 7,
          child: SizedBox(width: 24, height: 24, child: Icon(icon, color: Colors.white, size: 13)),
        ),
        const SizedBox(width: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: T.h1),
          if (subtitle != null) Text(subtitle!, style: T.caption),
        ]),
      ]),
    );
  }
}

// ─── Address Form ─────────────────────────────────────────────────────────────

class AddressForm extends StatefulWidget {
  const AddressForm({super.key});
  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();
  final _addr = TextEditingController();
  final _city = TextEditingController();
  final _zip = TextEditingController();
  final _phone = TextEditingController();
  String? _country;
  bool _save = false;
  final _countries = ['United States', 'Canada', 'United Kingdom', 'Australia', 'Germany', 'France', 'Pakistan'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 6),
            _SH(icon: Icons.location_on_outlined, title: 'Delivery Address', subtitle: 'Where should we deliver?'),
            _Card(child: Column(children: [
              _Field(controller: _addr, label: 'Street Address', hint: 'House / Flat, Street name', icon: Icons.home_outlined,
                  validator: (v) => (v == null || v.isEmpty) ? 'Required' : null),
              const SizedBox(height: 9),
              Row(children: [
                Expanded(child: _Field(controller: _city, label: 'City', hint: 'e.g. Karachi', icon: Icons.location_city_outlined,
                    validator: (v) => (v == null || v.isEmpty) ? 'Required' : null)),
                const SizedBox(width: 9),
                Expanded(child: _Field(controller: _zip, label: 'ZIP', hint: '00000', icon: Icons.pin_drop_outlined,
                    keyboardType: TextInputType.number, validator: (v) => (v == null || v.isEmpty) ? 'Required' : null)),
              ]),
              const SizedBox(height: 9),
              _Field(controller: _phone, label: 'Phone Number', hint: '+92 300 0000000', icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone, validator: (v) => (v == null || v.isEmpty) ? 'Required' : null),
              const SizedBox(height: 9),
              DropdownButtonFormField<String>(
                value: _country, style: T.body, dropdownColor: C.white, isDense: true,
                icon: const Icon(Icons.expand_more_rounded, size: 16, color: C.textSecondary),
                decoration: InputDecoration(
                  labelText: 'Country', labelStyle: T.label, isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 8),
                    child: ShaderMask(shaderCallback: (b) => C.gradient.createShader(b),
                        child: const Icon(Icons.flag_outlined, color: Colors.white, size: 16)),
                  ),
                  prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                  filled: true, fillColor: C.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: C.border)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: C.border)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: C.green, width: 1.6)),
                ),
                items: _countries.map((c) => DropdownMenuItem(value: c, child: Text(c, style: T.body))).toList(),
                onChanged: (v) => setState(() => _country = v),
                validator: (v) => v == null ? 'Required' : null,
              ),
            ])),
            _Card(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: SwitchListTile(
                dense: true, contentPadding: EdgeInsets.zero,
                value: _save, activeColor: C.green,
                onChanged: (v) => setState(() => _save = v),
                title: Text('Save address for future orders', style: T.body),
                subtitle: Text('Quick checkout next time', style: T.caption),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 4, 14, 12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                decoration: BoxDecoration(color: C.success.withOpacity(0.09), borderRadius: BorderRadius.circular(6)),
                child: Row(children: [
                  const Icon(Icons.local_shipping_outlined, size: 12, color: C.success),
                  const SizedBox(width: 5),
                  Text('Free delivery on orders above Rs.1000', style: T.caption.copyWith(color: C.success, fontWeight: FontWeight.w600)),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// ─── Payment Method ───────────────────────────────────────────────────────────

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});
  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  String _sel = 'credit_card';
  final _cardC = TextEditingController();
  final _expC = TextEditingController();
  final _cvvC = TextEditingController();
  final _nameC = TextEditingController();

  static final _methods = [
    _PM('credit_card', 'Credit / Debit Card', 'Visa, Mastercard', Icons.credit_card_rounded, const Color(0xFF1565C0)),
    _PM('easypaisa', 'EasyPaisa', 'Mobile wallet', Icons.account_balance_wallet_outlined, const Color(0xFF00897B)),
    _PM('jazzcash', 'JazzCash', 'Mobile wallet', Icons.smartphone_rounded, const Color(0xFFE53935)),
    _PM('cod', 'Cash on Delivery', 'Pay on receive', Icons.payments_outlined, const Color(0xFF757575)),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 6),
          _SH(icon: Icons.payment_outlined, title: 'Payment Method', subtitle: 'Secure & encrypted'),
          _Card(child: Column(
            children: _methods.map((m) {
              final selected = _sel == m.id;
              return GestureDetector(
                onTap: () => setState(() => _sel = m.id),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  margin: const EdgeInsets.only(bottom: 7),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? C.green.withOpacity(0.05) : C.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: selected ? C.green : C.border, width: selected ? 1.5 : 1),
                  ),
                  child: Row(children: [
                    Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        gradient: selected ? C.gradientDiag : null,
                        color: selected ? null : m.color.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Icon(m.icon, color: selected ? Colors.white : m.color, size: 16),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(m.title, style: T.h2),
                      Text(m.subtitle, style: T.caption),
                    ])),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 17, height: 17,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: selected ? C.green : C.textMuted, width: 1.8),
                      ),
                      child: selected
                          ? Center(child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: C.green, shape: BoxShape.circle)))
                          : null,
                    ),
                  ]),
                ),
              );
            }).toList(),
          )),
          if (_sel == 'credit_card') ...[
            _SH(icon: Icons.credit_card_outlined, title: 'Card Details'),
            _Card(child: Column(children: [
              _Field(
                controller: _cardC, label: 'Card Number', hint: '0000  0000  0000  0000', icon: Icons.credit_card_rounded,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(16), CardNumberFormatter()],
                suffix: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    _CBadge('VISA', const Color(0xFF1565C0)),
                    const SizedBox(width: 3),
                    _CBadge('MC', const Color(0xFFE53935)),
                  ]),
                ),
              ),
              const SizedBox(height: 9),
              Row(children: [
                Expanded(child: _Field(controller: _expC, label: 'Expiry', hint: 'MM/YY', icon: Icons.calendar_today_outlined,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4), CardDateFormatter()])),
                const SizedBox(width: 9),
                Expanded(child: _Field(controller: _cvvC, label: 'CVV', hint: '•••', icon: Icons.lock_outline_rounded,
                    keyboardType: TextInputType.number, obscureText: true,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)])),
              ]),
              const SizedBox(height: 9),
              _Field(controller: _nameC, label: 'Name on Card', hint: 'As printed on card', icon: Icons.person_outline_rounded),
            ])),
          ],
          const SizedBox(height: 12),
        ]),
      ),
    );
  }
}

class _PM {
  final String id, title, subtitle;
  final IconData icon;
  final Color color;
  const _PM(this.id, this.title, this.subtitle, this.icon, this.color);
}

class _CBadge extends StatelessWidget {
  final String text;
  final Color color;
  const _CBadge(this.text, this.color);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
    child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
  );
}

// ─── Order Summary ────────────────────────────────────────────────────────────

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  static const _items = [
    _OI('Wireless Headphones', 2000, 1, '🎧', 'Electronics'),
    _OI('Smartphone Case', 1500, 2, '📱', 'Accessories'),
    _OI('USB-C Cable', 1200, 1, '🔌', 'Accessories'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 6),
          _SH(icon: Icons.receipt_long_outlined, title: 'Order Summary', subtitle: 'Review before placing'),
          _Card(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Column(children: _items.map(_buildItem).toList()),
          ),
          _SH(icon: Icons.calculate_outlined, title: 'Price Details'),
          _Card(child: Column(children: [
            _pRow('Subtotal (4 items)', 'Rs.6,200'),
            const SizedBox(height: 5),
            _pRow('Shipping', 'Rs.300'),
            const SizedBox(height: 5),
            _pRow('GST / Tax', 'Rs.120'),
            const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(color: C.border, height: 1)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Total', style: T.h1),
              ShaderMask(shaderCallback: (b) => C.gradient.createShader(b),
                  child: const Text('Rs.6,620', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white))),
            ]),
            const SizedBox(height: 7),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(color: C.success.withOpacity(0.08), borderRadius: BorderRadius.circular(6)),
              child: Row(children: [
                const Icon(Icons.savings_outlined, size: 12, color: C.success),
                const SizedBox(width: 5),
                Text('You save Rs.480 on this order!', style: T.caption.copyWith(color: C.success, fontWeight: FontWeight.w600)),
              ]),
            ),
          ])),
          _SH(icon: Icons.home_outlined, title: 'Delivery Address'),
          _Card(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GBox(radius: 7, child: const SizedBox(width: 28, height: 28, child: Icon(Icons.location_on_outlined, color: Colors.white, size: 14))),
            const SizedBox(width: 9),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('John Doe', style: T.h2),
              const SizedBox(height: 1),
              Text('123 Main Street, New York, NY 10001', style: T.body.copyWith(color: C.textSecondary)),
              Text('United States  •  +1 (555) 123-4567', style: T.caption),
            ])),
            ShaderMask(shaderCallback: (b) => C.gradient.createShader(b),
                child: const Text('Edit', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white))),
          ])),
          _SH(icon: Icons.credit_card_outlined, title: 'Payment Method'),
          _Card(child: Row(children: [
            Container(
              width: 28, height: 28,
              decoration: BoxDecoration(color: const Color(0xFF1565C0).withOpacity(0.1), borderRadius: BorderRadius.circular(7)),
              child: const Icon(Icons.credit_card_rounded, color: Color(0xFF1565C0), size: 14),
            ),
            const SizedBox(width: 9),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Credit Card', style: T.h2),
              Text('ending in •••• 4567', style: T.caption),
            ])),
            ShaderMask(shaderCallback: (b) => C.gradient.createShader(b),
                child: const Text('Change', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white))),
          ])),
          const SizedBox(height: 14),
        ]),
      ),
    );
  }

  static Widget _buildItem(_OI item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(children: [
        Container(
          width: 42, height: 42,
          decoration: BoxDecoration(gradient: C.gradientDiag, borderRadius: BorderRadius.circular(8)),
          child: Center(child: Text(item.emoji, style: const TextStyle(fontSize: 20))),
        ),
        const SizedBox(width: 9),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(item.name, style: T.h2, maxLines: 1, overflow: TextOverflow.ellipsis),
          Text(item.category, style: T.caption),
          Container(
            margin: const EdgeInsets.only(top: 3),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(color: C.bg, borderRadius: BorderRadius.circular(4)),
            child: Text('Qty: ${item.qty}', style: T.caption.copyWith(fontSize: 10)),
          ),
        ])),
        ShaderMask(shaderCallback: (b) => C.gradient.createShader(b),
            child: Text('Rs.${(item.price * item.qty)}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white))),
      ]),
    );
  }

  static Widget _pRow(String label, String value) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: T.body.copyWith(color: C.textSecondary)),
      Text(value, style: T.body),
    ]);
  }
}

class _OI {
  final String name, emoji, category;
  final int price, qty;
  const _OI(this.name, this.price, this.qty, this.emoji, this.category);
}

// ─── Formatters ───────────────────────────────────────────────────────────────

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue o, TextEditingValue n) {
    if (n.selection.baseOffset == 0) return n;
    final buf = StringBuffer();
    for (int i = 0; i < n.text.length; i++) {
      buf.write(n.text[i]);
      if ((i + 1) % 4 == 0 && n.text.length != i + 1) buf.write('  ');
    }
    final s = buf.toString();
    return TextEditingValue(text: s, selection: TextSelection.collapsed(offset: s.length));
  }
}

class CardDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue o, TextEditingValue n) {
    if (n.selection.baseOffset == 0) return n;
    final buf = StringBuffer();
    for (int i = 0; i < n.text.length; i++) {
      buf.write(n.text[i]);
      if ((i + 1) % 2 == 0 && n.text.length != i + 1) buf.write('/');
    }
    final s = buf.toString();
    return TextEditingValue(text: s, selection: TextSelection.collapsed(offset: s.length));
  }
}