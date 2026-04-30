// ============================================================
//  CARTZA — Messages Page  (Daraz / Temu style)
//  ✅ FULLY CENTRALIZED layout — maxWidth: 1200 everywhere
//  ✅ Full‑width AppBar with centred content
//  ✅ Banners FULLY VISIBLE — natural height, never cropped
//  ✅ Desktop: shows full content + Footer
//  ✅ Mobile: shows bottom navigation bar (icons) + no footer
//  ✅ 4 tabs: Chats · Orders · Activities · Promos
//  ✅ Banner ad images per notification (like Daraz)
//  ✅ Matches Cartza brand: orange #FF6F00, green #4CAF50
//  ✅ Mark all as read, swipe to dismiss, unread dots
//  ✅ Time‑grouped (Last 7 days / Older)
//  ✅ Animated tab switching & card entrance
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─── Brand colours (matches Cartza) ─────────────────────────
class _C {
  static const orange    = Color(0xFFFF6F00);
  static const orangeL   = Color(0xFFFFF3E0);
  static const green     = Color(0xFF4CAF50);
  static const darkGreen = Color(0xFF2E7D32);
  static const greenL    = Color(0xFFE8F5E9);
  static const bg        = Color(0xFFF4F6F8);
  static const white     = Colors.white;
  static const dark      = Color(0xFF212121);
  static const slate     = Color(0xFF37474F);
  static const grey      = Color(0xFF757575);
  static const greyL     = Color(0xFFEEEEEE);
  static const red       = Color(0xFFE53935);
  static const blue      = Color(0xFF1565C0);
  static const amber     = Color(0xFFFF8F00);
}

// ─── Responsive breakpoints (matches Homepage) ───────────────
class _BP {
  static const maxW = 1200.0;
  static const mob  = 816.0;
  static const desk = 1280.0;

  static double w(BuildContext c) => MediaQuery.sizeOf(c).width;
  static bool isMob(BuildContext c)  => w(c) < mob;
  static bool isDesk(BuildContext c) => w(c) >= desk;

  static double hp(BuildContext c) {
    final sw = w(c);
    if (sw < mob)  return 12;
    if (sw < 960)  return 18;
    return 24;
  }
}

// ─── Tab definition ──────────────────────────────────────────
enum _Tab { chats, orders, activities, promos }

extension _TabX on _Tab {
  String get label => const ['Chats', 'Orders', 'Activities', 'Promos'][index];
  IconData get icon => const [
    Icons.chat_bubble_outline_rounded,
    Icons.shopping_bag_outlined,
    Icons.bolt_outlined,
    Icons.campaign_outlined,
  ][index];
  Color get color => [_C.green, _C.orange, _C.amber, _C.orange][index];
}

// ─── Message Item model ──────────────────────────────────────
class _Msg {
  final String id;
  final _Tab tab;
  final String title;
  final String subtitle;
  final String? bannerUrl;
  final DateTime time;
  bool isRead;

  _Msg({
    required this.id,
    required this.tab,
    required this.title,
    required this.subtitle,
    this.bannerUrl,
    required this.time,
    this.isRead = false,
  });
}

// ─── Sample data ─────────────────────────────────────────────
final List<_Msg> _sampleMessages = [
  _Msg(
    id: 'p1', tab: _Tab.promos,
    title: '60% OFF on New Brands 👀',
    subtitle: 'Saya, Carrefour, Johnson\'s, Sony & more.. 😎💸',
    bannerUrl: 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=1200&q=80',
    time: DateTime.now().subtract(const Duration(hours: 14)), isRead: false,
  ),
  _Msg(
    id: 'p2', tab: _Tab.promos,
    title: 'Smartphones Rs.11,499 💚',
    subtitle: 'Cartza pe milrahe hain mobiles upto 15% OFF pe! 😍',
    bannerUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=1200&q=80',
    time: DateTime.now().subtract(const Duration(hours: 18)), isRead: false,
  ),
  _Msg(
    id: 'p3', tab: _Tab.promos,
    title: '70% OFF + Rs.350 Extra Voucher 💸',
    subtitle: 'Best Branded Deals — 3X Cash Back Guaranteed! 🤩',
    bannerUrl: 'https://images.unsplash.com/photo-1556741533-6e6a3bd8a0d2?w=1200&q=80',
    time: DateTime.now().subtract(const Duration(hours: 22)), isRead: true,
  ),
  _Msg(
    id: 'p4', tab: _Tab.promos,
    title: 'Fashion starting Rs.699 👗',
    subtitle: 'Style Sunday — LAST DAY! Shop trending fashion now.',
    bannerUrl: 'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=1200&q=80',
    time: DateTime.now().subtract(const Duration(days: 2)), isRead: true,
  ),
  _Msg(
    id: 'p5', tab: _Tab.promos,
    title: 'Beauty Deals up to 50% OFF 💄',
    subtitle: 'Skincare, Makeup & more — Limited time offer!',
    bannerUrl: 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=1200&q=80',
    time: DateTime.now().subtract(const Duration(days: 4)), isRead: true,
  ),
  _Msg(
    id: 'a1', tab: _Tab.activities,
    title: 'Extra discounts 🥳',
    subtitle: 'SHOP NOW with coins to get 20% off.',
    bannerUrl: 'https://images.unsplash.com/photo-1472851294608-062f824d29cc?w=1200&q=80',
    time: DateTime.now().subtract(const Duration(hours: 10)), isRead: false,
  ),
  _Msg(
    id: 'a2', tab: _Tab.activities,
    title: 'Extra discounts 🥳',
    subtitle: 'SHOP NOW with coins to get 20% off.',
    bannerUrl: 'https://images.unsplash.com/photo-1472851294608-062f824d29cc?w=1200&q=80',
    time: DateTime.now().subtract(const Duration(days: 2)), isRead: true,
  ),
  _Msg(
    id: 'a3', tab: _Tab.activities,
    title: 'Win iPhone & 99% OFF 🥳',
    subtitle: 'Play game to win exciting prizes every day!',
    bannerUrl: 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?w=1200&q=80',
    time: DateTime.now().subtract(const Duration(days: 4)), isRead: true,
  ),
  _Msg(
    id: 'o1', tab: _Tab.orders,
    title: 'Order Shipped 🚚',
    subtitle: 'Your order #12345 is on its way! Est. delivery in 2-3 days.',
    time: DateTime.now().subtract(const Duration(hours: 2)), isRead: false,
  ),
  _Msg(
    id: 'o2', tab: _Tab.orders,
    title: 'Order Delivered ✅',
    subtitle: 'Your order #12340 has been delivered. Rate your experience!',
    time: DateTime.now().subtract(const Duration(days: 1)), isRead: true,
  ),
  _Msg(
    id: 'o3', tab: _Tab.orders,
    title: 'Payment Successful 💳',
    subtitle: 'Payment of Rs.12,999 received for order #12345.',
    time: DateTime.now().subtract(const Duration(days: 1, hours: 3)), isRead: true,
  ),
  _Msg(
    id: 'o4', tab: _Tab.orders,
    title: 'Price Drop Alert 📉',
    subtitle: 'iPhone 15 Pro dropped by 15% — grab it now!',
    time: DateTime.now().subtract(const Duration(days: 3)), isRead: false,
  ),
  _Msg(
    id: 'c1', tab: _Tab.chats,
    title: 'Seller: TechZone PK',
    subtitle: 'Your item will be dispatched by tomorrow morning.',
    time: DateTime.now().subtract(const Duration(hours: 1)), isRead: false,
  ),
  _Msg(
    id: 'c2', tab: _Tab.chats,
    title: 'Cartza Support',
    subtitle: 'Hi! How can we help you today? 😊',
    time: DateTime.now().subtract(const Duration(hours: 6)), isRead: false,
  ),
  _Msg(
    id: 'c3', tab: _Tab.chats,
    title: 'Seller: BeautyHub',
    subtitle: 'Thank you for your purchase! Enjoy your product 💄',
    time: DateTime.now().subtract(const Duration(days: 2)), isRead: true,
  ),
];

// ─── MessagesPage ─────────────────────────────────────────────
class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  late List<_Msg> _msgs;

  @override
  void initState() {
    super.initState();
    _msgs = List.from(_sampleMessages);
    _tabCtrl = TabController(length: 4, vsync: this);
    _tabCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  List<_Msg> _forTab(_Tab t) => _msgs.where((m) => m.tab == t).toList();

  int _unreadCount(_Tab t) => _msgs.where((m) => m.tab == t && !m.isRead).length;
  int get _totalUnread => _msgs.where((m) => !m.isRead).length;

  void _markAllRead(_Tab t) {
    setState(() {
      for (final m in _msgs) {
        if (m.tab == t) m.isRead = true;
      }
    });
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('All marked as read'),
        backgroundColor: _C.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _delete(String id) {
    setState(() => _msgs.removeWhere((m) => m.id == id));
    HapticFeedback.mediumImpact();
  }

  void _markRead(String id) {
    setState(() {
      final idx = _msgs.indexWhere((m) => m.id == id);
      if (idx != -1) _msgs[idx].isRead = true;
    });
  }

  // ─── Bottom navigation bar for mobile ─────────────────────────
  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: _C.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: NavigationBar(
          height: 62,
          selectedIndex: 3, // Messages = Alerts tab
          backgroundColor: Colors.transparent,
          elevation: 0,
          indicatorColor: _C.green.withOpacity(0.12),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: (i) {
            // In a real app you'd navigate to the respective pages.
            // Here we just pop or show a toast for demo.
            if (i == 2) {
              // My Cart – you can implement navigation
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Navigate to Cart (integrate with main app)'),
                  duration: Duration(seconds: 1),
                ),
              );
            } else if (i != 3) {
              Navigator.maybePop(context);
            }
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded, color: _C.green),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.grid_view_outlined),
              selectedIcon: Icon(Icons.grid_view_rounded, color: _C.green),
              label: 'Categories',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              selectedIcon: Icon(Icons.shopping_cart_rounded, color: _C.green),
              label: 'My Cart',
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications_outlined),
              selectedIcon: Icon(Icons.notifications_rounded, color: _C.green),
              label: 'Alerts',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded),
              selectedIcon: Icon(Icons.person_rounded, color: _C.green),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mob = _BP.isMob(context);
    final currentTab = _Tab.values[_tabCtrl.index];
    final unread = _unreadCount(currentTab);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: _C.bg,
        appBar: _buildAppBar(currentTab, unread),
        body: Column(
          children: [
            // Tab icon row (centered)
            Container(
              color: _C.white,
              width: double.infinity,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _BP.maxW),
                  child: _buildTabIconRow(mob),
                ),
              ),
            ),
            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabCtrl,
                children: _Tab.values.map((t) => _TabBody(
                  key: ValueKey(t),
                  tab: t,
                  messages: _forTab(t),
                  onDelete: _delete,
                  onRead: _markRead,
                  isMobile: mob,
                )).toList(),
              ),
            ),
            // Footer – only on desktop
            if (!mob) _buildFooter(),
          ],
        ),
        // Bottom navigation bar – only on mobile
        bottomNavigationBar: mob ? _buildBottomNavBar() : null,
      ),
    );
  }

  // ── AppBar ───────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar(_Tab currentTab, int unread) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(58),
      child: Container(
        color: _C.white,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _BP.maxW),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                                color: _C.dark, size: 20),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Row(
                            children: [
                              const Text(
                                'Messages',
                                style: TextStyle(
                                  color: _C.dark,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              if (_totalUnread > 0) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _C.red,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '$_totalUnread',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const Spacer(),
                          if (unread > 0)
                            TextButton.icon(
                              onPressed: () =>
                                  _markAllRead(_Tab.values[_tabCtrl.index]),
                              icon: const Icon(Icons.done_all_rounded, size: 16),
                              label: const Text('Mark all read',
                                  style: TextStyle(fontSize: 12)),
                              style: TextButton.styleFrom(
                                  foregroundColor: _C.orange),
                            ),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(height: 0.5, color: _C.greyL),
          ],
        ),
      ),
    );
  }

  // ── Tab Icon Row ─────────────────────────────────────────────
  Widget _buildTabIconRow(bool mob) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _BP.hp(context),
        vertical: mob ? 12 : 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _Tab.values.map((t) {
          final isSelected = _tabCtrl.index == t.index;
          final unread = _unreadCount(t);
          return mob
              ? _MobileTabIcon(
            tab: t,
            isSelected: isSelected,
            unread: unread,
            onTap: () {
              HapticFeedback.selectionClick();
              _tabCtrl.animateTo(t.index);
            },
          )
              : _DesktopTabPill(
            tab: t,
            isSelected: isSelected,
            unread: unread,
            onTap: () {
              HapticFeedback.selectionClick();
              _tabCtrl.animateTo(t.index);
            },
          );
        }).toList(),
      ),
    );
  }

  // ── Footer (Desktop only) ────────────────────────────────────
  Widget _buildFooter() {
    return Container(
      color: const Color(0xFF1A1A1A),
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _BP.maxW),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: _C.green,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Text('CARTZA',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                    letterSpacing: 1.5)),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Your trusted online shopping\ndestination for quality products.',
                            style: TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                                height: 1.6),
                          ),
                          const SizedBox(height: 14),
                          Row(children: [
                            _SI(Icons.facebook, const Color(0xFF1877F2)),
                            _SI(Icons.chat, const Color(0xFF25D366)),
                            _SI(Icons.camera_alt, const Color(0xFFE4405F)),
                            _SI(Icons.play_arrow, const Color(0xFFFF0000)),
                          ]),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                        child: _FC('Shop', [
                          'New Arrivals',
                          'Best Sellers',
                          'Flash Sale',
                          'Categories',
                          'Deals'
                        ])),
                    Expanded(
                        child: _FC('Customer Care', [
                          'Contact Us',
                          'Help Center',
                          'Track Order',
                          'Returns',
                          'Shipping'
                        ])),
                    Expanded(
                        child: _FC('Company',
                            ['About Us', 'Careers', 'Privacy', 'Terms'])),
                  ],
                ),
                const SizedBox(height: 16),
                Container(height: 0.5, color: _C.green.withOpacity(0.3)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.copyright,
                                color: Colors.white38, size: 12),
                            SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                '2025 Cartza. All rights reserved.',
                                style: TextStyle(
                                    color: Colors.white60, fontSize: 11),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(children: [
                        const Text('We Accept: ',
                            style: TextStyle(
                                color: Colors.white60, fontSize: 11)),
                        ...[
                          Icons.credit_card,
                          Icons.account_balance_wallet,
                          Icons.payment
                        ].map((ic) => Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.07),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.white24)),
                              child: Icon(ic,
                                  color: Colors.white54, size: 13),
                            ))),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Mobile Tab Icon ─────────────────────────────────────────
class _MobileTabIcon extends StatelessWidget {
  final _Tab tab;
  final bool isSelected;
  final int unread;
  final VoidCallback onTap;
  const _MobileTabIcon({
    required this.tab,
    required this.isSelected,
    required this.unread,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: isSelected ? tab.color : _C.greyL,
                  shape: BoxShape.circle,
                  boxShadow: isSelected
                      ? [
                    BoxShadow(
                      color: tab.color.withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ]
                      : null,
                ),
                child: Icon(
                  tab.icon,
                  color: isSelected ? Colors.white : _C.grey,
                  size: 24,
                ),
              ),
              if (unread > 0)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: _C.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$unread',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            tab.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              color: isSelected ? tab.color : _C.grey,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Desktop Tab Pill ─────────────────────────────────────────
class _DesktopTabPill extends StatelessWidget {
  final _Tab tab;
  final bool isSelected;
  final int unread;
  final VoidCallback onTap;
  const _DesktopTabPill({
    required this.tab,
    required this.isSelected,
    required this.unread,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? tab.color : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? tab.color : _C.greyL,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: tab.color.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 3),
            )
          ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              tab.icon,
              color: isSelected ? Colors.white : _C.grey,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              tab.label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? Colors.white : _C.grey,
              ),
            ),
            if (unread > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.3)
                      : _C.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$unread',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Tab Body ────────────────────────────────────────────────
class _TabBody extends StatelessWidget {
  final _Tab tab;
  final List<_Msg> messages;
  final void Function(String) onDelete;
  final void Function(String) onRead;
  final bool isMobile;

  const _TabBody({
    Key? key,
    required this.tab,
    required this.messages,
    required this.onDelete,
    required this.onRead,
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) return _EmptyState(tab: tab);

    final recent = messages
        .where((m) => DateTime.now().difference(m.time).inDays < 7)
        .toList();
    final older = messages
        .where((m) => DateTime.now().difference(m.time).inDays >= 7)
        .toList();

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        if (recent.isNotEmpty) ...[
          _CenteredSection(child: _SectionLabel('Last 7 days')),
          ...recent.asMap().entries.map((e) => _AnimatedEntry(
            delay: Duration(milliseconds: e.key * 50),
            child: _CenteredSection(
              child: _MsgCard(
                msg: e.value,
                isMobile: isMobile,
                onDelete: () => onDelete(e.value.id),
                onTap: () => onRead(e.value.id),
              ),
            ),
          )),
        ],
        if (older.isNotEmpty) ...[
          _CenteredSection(child: _SectionLabel('Older')),
          ...older.map((m) => _CenteredSection(
            child: _MsgCard(
              msg: m,
              isMobile: isMobile,
              onDelete: () => onDelete(m.id),
              onTap: () => onRead(m.id),
            ),
          )),
        ],
      ],
    );
  }
}

// ─── Centralised section wrapper ─────────────────────────────
class _CenteredSection extends StatelessWidget {
  final Widget child;
  final Color? bg;
  const _CenteredSection({required this.child, this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bg ?? _C.bg,
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _BP.maxW),
          child: child,
        ),
      ),
    );
  }
}

// ─── Section Label ───────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
      child: Text(
        text,
        style: const TextStyle(
          color: _C.grey,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

// ─── Message Card (with fully visible banners) ───────────────
class _MsgCard extends StatefulWidget {
  final _Msg msg;
  final bool isMobile;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const _MsgCard({
    required this.msg,
    required this.isMobile,
    required this.onDelete,
    required this.onTap,
  });

  @override
  State<_MsgCard> createState() => _MsgCardState();
}

class _MsgCardState extends State<_MsgCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressCtrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _pressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween(begin: 1.0, end: 0.98)
        .animate(CurvedAnimation(parent: _pressCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _pressCtrl.dispose();
    super.dispose();
  }

  String _timeLabel(DateTime t) {
    final diff = DateTime.now().difference(t);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    return '${t.day}/${t.month}/${t.year}';
  }

  Color get _tabColor => widget.msg.tab.color;
  IconData get _tabIcon => widget.msg.tab.icon;

  @override
  Widget build(BuildContext context) {
    final msg = widget.msg;
    final hasBanner = msg.bannerUrl != null;
    final mob = widget.isMobile;
    final hMargin = mob ? 12.0 : 16.0;

    return Dismissible(
        key: Key(msg.id),
        direction: DismissDirection.endToStart,
        background: _dismissBg(hMargin),
        onDismissed: (_) => widget.onDelete(),
        child: ScaleTransition(
            scale: _scale,
            child: GestureDetector(
                onTapDown: (_) => _pressCtrl.forward(),
                onTapUp: (_) {
                  _pressCtrl.reverse();
                  widget.onTap();
                },
                onTapCancel: () => _pressCtrl.reverse(),
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: hMargin, vertical: 5),
                    decoration: BoxDecoration(
                      color: _C.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border: msg.isRead
                          ? null
                          : Border.all(
                        color: _tabColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header row
                        Padding(
                            padding: EdgeInsets.fromLTRB(
                                14, 12, 14, hasBanner ? 10 : 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Stack(
                            children: [
                            Container(
                            width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: _tabColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(_tabIcon,
                                  color: Colors.white, size: 20),
                            ),
                            if (!msg.isRead)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: _C.red,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: _C.white, width: 1.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            msg.title,
                            style: TextStyle(
                              fontSize: mob ? 14 : 15,
                              fontWeight: msg.isRead
                                  ? FontWeight.w600
                                  : FontWeight.w800,
                              color: _C.dark,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _timeLabel(msg.time),
                            style: const TextStyle(
                              fontSize: 11.5,
                              color: _C.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!msg.isRead)
                Container(
                width: 8,
                height: 8,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: _tabColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _tabColor.withOpacity(0.5),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ),

        // Banner image section
        if (hasBanner) ...[
    ClipRRect(
    borderRadius: const BorderRadius.only(
    bottomLeft: Radius.circular(14),
    bottomRight: Radius.circular(14),
    ),
    child: ConstrainedBox(
    constraints: BoxConstraints(
    maxHeight: mob ? 200 : 220,
    ),
    child: Image.network(
    msg.bannerUrl!,
    width: double.infinity,
    fit: BoxFit.contain,
    loadingBuilder: (_, child, progress) {
    if (progress == null) return child;
    return Container(
    height: 160,
    color: _C.greyL,
    child: Center(
    child: CircularProgressIndicator(
    color: _tabColor,
    strokeWidth: 2,
    ),
    ),
    );
    },
    errorBuilder: (_, __, ___) => Container(
    height: 120,
    color: _C.greyL,
    child: Center(
    child: Icon(Icons.broken_image_outlined,
    color: _C.grey, size: 40),
    ),
    ),
    ),
    ),
    ),
    Padding(
    padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
    child: Text(
    msg.subtitle,
    style: TextStyle(
    fontSize: mob ? 13 : 14,
    color: _C.dark,
    height: 1.4,
    ),
    ),
    ),
    ] else
    Padding(
    padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
    child: Row(
    children: [
    const SizedBox(width: 54),
    Expanded(
    child: Text(
    msg.subtitle,
    style: const TextStyle(
    fontSize: 13,
    color: _C.grey,
    height: 1.4,
    ),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    );
  }

  Widget _dismissBg(double hMargin) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: hMargin, vertical: 5),
      decoration: BoxDecoration(
        color: _C.red,
        borderRadius: BorderRadius.circular(14),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 24),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.delete_outline_rounded, color: Colors.white, size: 24),
          SizedBox(height: 4),
          Text(
            'Delete',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Animated entry wrapper ──────────────────────────────────
class _AnimatedEntry extends StatefulWidget {
  final Widget child;
  final Duration delay;
  const _AnimatedEntry({required this.child, required this.delay});

  @override
  State<_AnimatedEntry> createState() => _AnimatedEntryState();
}

class _AnimatedEntryState extends State<_AnimatedEntry>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween(begin: const Offset(0, 0.05), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _fade,
    child: SlideTransition(position: _slide, child: widget.child),
  );
}

// ─── Empty State ─────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  final _Tab tab;
  const _EmptyState({required this.tab});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: tab.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(tab.icon, color: tab.color, size: 36),
          ),
          const SizedBox(height: 16),
          Text(
            'No ${tab.label}',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: _C.dark,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'You\'re all caught up!',
            style: TextStyle(fontSize: 13, color: _C.grey),
          ),
        ],
      ),
    );
  }
}

// ─── Footer helpers ──────────────────────────────────────────
class _FC extends StatelessWidget {
  final String title;
  final List<String> links;
  const _FC(this.title, this.links);

  @override
  Widget build(_) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 12.5)),
      const SizedBox(height: 10),
      ...links.map((l) => Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_right_rounded,
                  size: 13,
                  color: _C.green.withOpacity(0.65)),
              const SizedBox(width: 3),
              Text(l,
                  style: const TextStyle(
                      color: Colors.white60, fontSize: 11.5)),
            ],
          ),
        ),
      )),
      const SizedBox(height: 24),
    ],
  );
}

class _SI extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _SI(this.icon, this.color);

  @override
  Widget build(_) => Padding(
    padding: const EdgeInsets.only(right: 8),
    child: InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(7)),
        child: Icon(icon, color: Colors.white, size: 14),
      ),
    ),
  );
}
