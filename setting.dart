// ─────────────────────────────────────────────
//  SETTINGS SCREEN  — Production-ready
//  Features:
//   • Profile editing with SharedPreferences persistence
//   • Profile image (camera/gallery) with persistence
//   • Full EN/UR localization (JSON-based)
//   • Dark/Light/System theme via AppProvider
//   • Clean Architecture: Model → Service → Provider → UI
// ─────────────────────────────────────────────

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart'; // <--- ADD THIS LINE
import 'package:cartza_user/login_page.dart';
import 'appprovider.dart';
import 'applocalization.dart';
import 'user_profile.dart';
// ─────────────────────────────────────────────
//  ENTRY POINT
// ─────────────────────────────────────────────
class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  int _selectedIndex = 0;

  List<_NavItem> _buildNavItems(AppLocalizations s) => [
    _NavItem(Icons.person_outline,                  s.t('myProfile')),
    _NavItem(Icons.location_on_outlined,            s.t('addresses')),
    _NavItem(Icons.credit_card_outlined,            s.t('paymentMethods')),
    _NavItem(Icons.account_balance_wallet_outlined, s.t('wallet')),
    _NavItem(Icons.notifications_none,              s.t('notifications')),
    _NavItem(Icons.language,                        s.t('languageRegion')),
    _NavItem(Icons.shield_outlined,                 s.t('security')),
    _NavItem(Icons.sunny,                           s.t('darkLightMode')),
    _NavItem(Icons.help_outline,                    s.t('helpSupport')),
    _NavItem(Icons.logout,                          s.t('logout')),
  ];

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context);
    final navItems = _buildNavItems(s);

    final isDark = context.watch<AppProvider>().themeMode == ThemeMode.dark;
    final bgColor   = isDark ? const Color(0xFF121212) : Colors.white;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: isDark ? 0 : 0,
        backgroundColor: cardColor,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE),
          ),
        ),
        title: Center(
          child: Image.asset('assests/images/assets/logo1.png', width: 130),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 900) {
            return _DesktopLayout(
              navItems: navItems,
              selectedIndex: _selectedIndex,
              onNavTap: (i) => setState(() => _selectedIndex = i),
            );
          } else if (constraints.maxWidth >= 600) {
            return _TabletLayout(
              navItems: navItems,
              selectedIndex: _selectedIndex,
              onNavTap: (i) => setState(() => _selectedIndex = i),
            );
          } else {
            return _MobileLayout(navItems: navItems);
          }
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  DATA MODEL
// ─────────────────────────────────────────────
class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}

// ─────────────────────────────────────────────
//  LOGOUT DIALOG
// ─────────────────────────────────────────────
void _showLogoutDialog(BuildContext context) {
  final s = AppLocalizations.of(context);
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(s.t('logoutConfirmTitle'),
          style: const TextStyle(fontWeight: FontWeight.w600)),
      content: Text(s.t('logoutConfirmBody')),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(s.t('cancel'), style: const TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const ResponsiveLoginPage(role: 'User')),
                  (route) => false,
            );
          },
          child: Text(s.t('logout'), style: const TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────
//  DESKTOP
// ─────────────────────────────────────────────
class _DesktopLayout extends StatelessWidget {
  final List<_NavItem> navItems;
  final int selectedIndex;
  final ValueChanged<int> onNavTap;

  const _DesktopLayout({
    required this.navItems,
    required this.selectedIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final provider  = context.watch<AppProvider>();
    final profile   = provider.profile;
    final isDark    = provider.themeMode == ThemeMode.dark;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final bgColor   = isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5);
    final s         = AppLocalizations.of(context);

    return Row(
      children: [
        // ── Sidebar ──────────────────────────
        Container(
          width: 350,
          color: cardColor,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: Row(
                  children: [
                    _ProfileAvatar(radius: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(profile.fullName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                          const SizedBox(height: 2),
                          Text(profile.email,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 11, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: navItems.length,
                  itemBuilder: (context, i) {
                    final item      = navItems[i];
                    final isSelected = selectedIndex == i;
                    final isLogout  = i == 9;
                    return InkWell(
                      onTap: () => isLogout
                          ? _showLogoutDialog(context)
                          : onNavTap(i),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFFF8A00).withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: isSelected
                              ? Border.all(color: const Color(0xFFFF8A00), width: 1)
                              : null,
                        ),
                        child: Row(
                          children: [
                            Icon(item.icon,
                                size: 20,
                                color: isLogout
                                    ? Colors.red
                                    : isSelected
                                    ? const Color(0xFFFF8A00)
                                    : Colors.grey[600]),
                            const SizedBox(width: 12),
                            Text(item.label,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: isLogout
                                        ? Colors.red
                                        : isSelected
                                        ? const Color(0xFFFF8A00)
                                        : null)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // ── Content ──────────────────────────
        Expanded(
          child: Container(
            color: bgColor,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: _SettingContent(selectedIndex: selectedIndex),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  TABLET
// ─────────────────────────────────────────────
class _TabletLayout extends StatelessWidget {
  final List<_NavItem> navItems;
  final int selectedIndex;
  final ValueChanged<int> onNavTap;

  const _TabletLayout({
    required this.navItems,
    required this.selectedIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final provider  = context.watch<AppProvider>();
    final isDark    = provider.themeMode == ThemeMode.dark;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    return Row(
      children: [
        Container(
          width: 68,
          color: cardColor,
          child: Column(
            children: [
              const SizedBox(height: 16),
              _ProfileAvatar(radius: 20),
              const SizedBox(height: 14),
              const Divider(height: 1),
              const SizedBox(height: 6),
              Expanded(
                child: ListView.builder(
                  itemCount: navItems.length,
                  itemBuilder: (context, i) {
                    final item      = navItems[i];
                    final isSelected = selectedIndex == i;
                    final isLogout  = i == 9;
                    return Tooltip(
                      message: item.label,
                      child: InkWell(
                        onTap: () => isLogout
                            ? _showLogoutDialog(context)
                            : onNavTap(i),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFFF8A00).withOpacity(0.12)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(item.icon,
                              size: 22,
                              color: isLogout
                                  ? Colors.red
                                  : isSelected
                                  ? const Color(0xFFFF8A00)
                                  : Colors.grey[500]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: _SettingContent(selectedIndex: selectedIndex),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  MOBILE
// ─────────────────────────────────────────────
class _MobileLayout extends StatelessWidget {
  final List<_NavItem> navItems;
  const _MobileLayout({required this.navItems});

  @override
  Widget build(BuildContext context) {
    final profile   = context.watch<AppProvider>().profile;
    final s         = AppLocalizations.of(context);
    final isDark    = context.watch<AppProvider>().themeMode == ThemeMode.dark;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final bgColor   = isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5);

    return Container(
      color: bgColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 3))
                ],
              ),
              child: Row(
                children: [
                  _ProfileAvatar(radius: 32),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile.fullName,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text(profile.email,
                            style: const TextStyle(color: Colors.grey, fontSize: 13)),
                        const SizedBox(height: 2),
                        Text(profile.location,
                            style: const TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _mobileSection(context, s.t('account'),     [0, 1, 2, 3]),
            _mobileSection(context, s.t('preferences'), [4, 5, 6, 7]),
            _mobileSection(context, s.t('support'),     [8]),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.withOpacity(0.08),
                    foregroundColor: Colors.red,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.red, width: 0.8),
                    ),
                  ),
                  onPressed: () => _showLogoutDialog(context),
                  icon: const Icon(Icons.logout, size: 18),
                  label: Text(s.t('logout'),
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _mobileSection(
      BuildContext context, String title, List<int> indices) {
    final navItems = this.navItems; // ← directly access the field
    final s         = AppLocalizations.of(context);
    final isDark    = context.watch<AppProvider>().themeMode == ThemeMode.dark;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 16, bottom: 6),
          child: Text(title.toUpperCase(),
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                  color: Colors.grey)),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.08),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 2))
            ],
          ),
          child: Column(
            children: indices.asMap().entries.map((entry) {
              final i   = entry.key;
              final idx = entry.value;
              final item = navItems[idx];
              return Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            _MobileDetailPage(title: item.label, index: idx),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 13),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF8A00).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(item.icon,
                                color: const Color(0xFFFF8A00), size: 18),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                              child: Text(item.label,
                                  style: const TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w500))),
                          Icon(Icons.arrow_forward_ios,
                              size: 14, color: Colors.grey[400]),
                        ],
                      ),
                    ),
                  ),
                  if (i < indices.length - 1)
                    const Divider(height: 1, indent: 54, endIndent: 16),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

// Mobile detail screen
class _MobileDetailPage extends StatelessWidget {
  final String title;
  final int index;
  const _MobileDetailPage({required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    final isDark    = context.watch<AppProvider>().themeMode == ThemeMode.dark;
    final bgColor   = isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: cardColor,
        elevation: 0.5,
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: _SettingContent(selectedIndex: index),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  PROFILE AVATAR (shared widget)
//  Reads profile image from AppProvider.
// ─────────────────────────────────────────────
class _ProfileAvatar extends StatelessWidget {
  final double radius;
  const _ProfileAvatar({required this.radius});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<AppProvider>().profile;
    final imagePath = profile.profileImagePath;

    return CircleAvatar(
      radius: radius,
      backgroundColor: imagePath != null && imagePath.isNotEmpty
          ? Colors.transparent
          : const Color(0xFFFF8A00).withOpacity(0.15),
      backgroundImage: imagePath != null && imagePath.isNotEmpty
          ? FileImage(File(imagePath)) as ImageProvider
          : null,
      child: imagePath == null || imagePath.isEmpty
          ? Text(profile.initials,
          style: TextStyle(
              color: const Color(0xFFFF8A00),
              fontWeight: FontWeight.bold,
              fontSize: radius * 0.6))
          : null,
    );
  }
}

// ─────────────────────────────────────────────
//  SHARED CONTENT
// ─────────────────────────────────────────────
class _SettingContent extends StatefulWidget {
  final int selectedIndex;
  const _SettingContent({required this.selectedIndex});

  @override
  State<_SettingContent> createState() => _SettingContentState();
}

class _SettingContentState extends State<_SettingContent> {
  // ── Notification toggles ──
  bool _orderPlaced = true;
  bool _shipping    = true;
  bool _delivery    = true;
  bool _returns     = false;
  bool _flashSales  = true;
  bool _vouchers    = true;
  bool _newsletter  = false;
  bool _pushNotif   = true;
  bool _smsAlerts   = true;
  bool _emailNotif  = false;

  // ── Address list ──
  final List<Map<String, dynamic>> _addresses = [
    {
      'name': 'Ayesha Khan',
      'address': 'House 12, Street 4, F-7/2\nIslamabad, Punjab 44000',
      'phone': '+92 300 1234567',
      'isDefault': true,
    },
    {
      'name': 'Office',
      'address': '3rd Floor, Blue Area, G-9\nRawalpindi, Punjab 46000',
      'phone': '+92 311 7654321',
      'isDefault': false,
    },
  ];

  // ── Region fields ──
  String _selectedCountry  = '🇵🇰 Pakistan';
  String _selectedCurrency = 'PKR — Pakistani Rupee';
  String _selectedTimezone = 'PKT (UTC+5)';

  @override
  Widget build(BuildContext context) {
    switch (widget.selectedIndex) {
      case 0: return _buildProfile();
      case 1: return _buildAddresses();
      case 2: return _buildPayments();
      case 3: return _buildWallet();
      case 4: return _buildNotifications();
      case 5: return _buildLanguage();
      case 6: return _buildSecurity();
      case 7: return _buildDarkMode();
      case 8: return _buildHelp();
      default: return _buildProfile();
    }
  }

  // ── Theme helpers ──────────────────────────
  bool get _isDark => context.watch<AppProvider>().themeMode == ThemeMode.dark;
  Color get _cardBg     => _isDark ? const Color(0xFF1E1E1E) : Colors.white;
  Color get _textPrimary => _isDark ? Colors.white : Colors.black87;

  // ─────────────────────────────────────────
  //  HELPERS
  // ─────────────────────────────────────────
  Widget _header(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Text(title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
  );

  Widget _card({String? title, required Widget child}) => Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: _cardBg,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 2))
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Text(title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ),
          Divider(height: 1, color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
        ],
        child,
      ],
    ),
  );

  Widget _fieldRow(String label, String value, {VoidCallback? onEdit}) {
    final s = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)))),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 3),
                Text(value, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
          if (onEdit != null)
            TextButton(
              onPressed: onEdit,
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFFF8A00),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(s.t('edit'),
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  Widget _toggleRow(
      String title, String sub, bool val, ValueChanged<bool> onChange) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14)),
                  if (sub.isNotEmpty)
                    Text(sub,
                        style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            Switch(
                value: val,
                onChanged: onChange,
                activeColor: const Color(0xFFFF8A00)),
          ],
        ),
      );

  Widget _smallBtn(String label,
      {required VoidCallback onTap, bool isDanger = false}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(
                color: isDanger ? Colors.red : Colors.grey[300]!),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(label,
              style: TextStyle(
                  fontSize: 12,
                  color: isDanger ? Colors.red : null)),
        ),
      );

  // ─────────────────────────────────────────
  //  PROFILE EDIT DIALOG
  //  Shows a dialog with a pre-filled TextField.
  //  On Save → updates AppProvider (which persists).
  // ─────────────────────────────────────────
  void _showEditDialog({
    required String label,
    required String currentValue,
    required String fieldKey,
    List<String>? options, // for Gender — shows a dropdown
  }) {
    final s           = AppLocalizations.of(context);
    final controller  = TextEditingController(text: currentValue);
    String? selected  = options != null ? currentValue : null;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        content: options != null
            ? StatefulBuilder(builder: (ctx2, setS) {
          return DropdownButtonFormField<String>(
            value: selected,
            items: options
                .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                .toList(),
            onChanged: (v) => setS(() => selected = v),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
        })
            : TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)),
            labelText: label,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(s.t('cancel'),
                style: const TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF8A00),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              final newValue =
              options != null ? (selected ?? currentValue) : controller.text.trim();
              if (newValue.isNotEmpty) {
                context.read<AppProvider>().updateField(fieldKey, newValue);
              }
              Navigator.pop(ctx);
            },
            child: Text(s.t('save'),
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  //  IMAGE PICKER (bottom sheet)
  // ─────────────────────────────────────────
  void _showImageSourcePicker() {
    final s        = AppLocalizations.of(context);
    final provider = context.read<AppProvider>();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFFFF8A00)),
              title: Text(s.t('takePhoto')),
              onTap: () {
                Navigator.pop(context);
                provider.pickProfileImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Color(0xFFFF8A00)),
              title: Text(s.t('chooseFromGallery')),
              onTap: () {
                Navigator.pop(context);
                provider.pickProfileImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  //  1. PROFILE
  // ─────────────────────────────────────────
  Widget _buildProfile() {
    final s       = AppLocalizations.of(context);
    final profile = context.watch<AppProvider>().profile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(s.t('myProfile')),
        _card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        _ProfileAvatar(radius: 36),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _showImageSourcePicker,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                  color: Color(0xFFFF8A00),
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.camera_alt,
                                  size: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile.fullName,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text(profile.email,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              // ── Editable fields ──
              _fieldRow(s.t('fullName'), profile.fullName,
                  onEdit: () => _showEditDialog(
                      label: s.t('fullName'),
                      currentValue: profile.fullName,
                      fieldKey: 'fullName')),
              _fieldRow(s.t('phone'), profile.phone,
                  onEdit: () => _showEditDialog(
                      label: s.t('phone'),
                      currentValue: profile.phone,
                      fieldKey: 'phone')),
              _fieldRow(s.t('email'), profile.email,
                  onEdit: () => _showEditDialog(
                      label: s.t('email'),
                      currentValue: profile.email,
                      fieldKey: 'email')),
              _fieldRow(s.t('dateOfBirth'), profile.dateOfBirth,
                  onEdit: () => _showEditDialog(
                      label: s.t('dateOfBirth'),
                      currentValue: profile.dateOfBirth,
                      fieldKey: 'dateOfBirth')),
              _fieldRow(s.t('gender'), profile.gender,
                  onEdit: () => _showEditDialog(
                      label: s.t('gender'),
                      currentValue: profile.gender,
                      fieldKey: 'gender',
                      options: ['Male', 'Female', 'Other', 'Prefer not to say'])),
            ],
          ),
        ),
        _card(
          title: s.t('accountStats'),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _statBox('24', s.t('orders')),
                const SizedBox(width: 12),
                _statBox('8', s.t('reviews')),
                const SizedBox(width: 12),
                _statBox('142', s.t('wishlist')),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _statBox(String val, String label) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
          color: _isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(val,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFF8A00))),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    ),
  );

  // ─────────────────────────────────────────
  //  2. ADDRESSES
  // ─────────────────────────────────────────
  Widget _buildAddresses() {
    final s = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(s.t('savedAddresses')),
        _card(
          child: Column(
            children: [
              ..._addresses.asMap().entries.map((entry) {
                final idx  = entry.key;
                final addr = entry.value;
                return Column(
                  children: [
                    _addressTile(
                      index: idx,
                      name: addr['name'],
                      address: addr['address'],
                      phone: addr['phone'],
                      isDefault: addr['isDefault'],
                    ),
                    if (idx < _addresses.length - 1)
                      Divider(height: 1,
                          color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
                  ],
                );
              }),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 14),
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: _showAddAddressSheet,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8A00),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.add, size: 16, color: Colors.white),
                    label: Text(s.t('addNewAddress'),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAddAddressSheet() {
    final s        = AppLocalizations.of(context);
    final nameCtrl = TextEditingController();
    final addrCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(s.t('addNewAddress'),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                    labelText: s.t('name'),
                    border: const OutlineInputBorder())),
            const SizedBox(height: 10),
            TextField(
                controller: addrCtrl,
                maxLines: 2,
                decoration: InputDecoration(
                    labelText: s.t('address'),
                    border: const OutlineInputBorder())),
            const SizedBox(height: 10),
            TextField(
                controller: phoneCtrl,
                decoration: InputDecoration(
                    labelText: s.t('phone'),
                    border: const OutlineInputBorder())),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8A00),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  if (nameCtrl.text.isNotEmpty) {
                    setState(() {
                      _addresses.add({
                        'name': nameCtrl.text,
                        'address': addrCtrl.text,
                        'phone': phoneCtrl.text,
                        'isDefault': false,
                      });
                    });
                  }
                  Navigator.pop(context);
                },
                child: Text(s.t('saveAddress'),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _addressTile({
    required int index,
    required String name,
    required String address,
    required String phone,
    required bool isDefault,
  }) {
    final s = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDefault)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFFF8A00).withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(s.t('default'),
                  style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFFFF8A00),
                      fontWeight: FontWeight.w600)),
            ),
          Text(name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 4),
          Text(address,
              style: const TextStyle(
                  fontSize: 13, color: Colors.grey, height: 1.5)),
          const SizedBox(height: 2),
          Text(phone, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 10),
          Row(
            children: [
              _smallBtn(s.t('edit'), onTap: () {}),
              const SizedBox(width: 8),
              _smallBtn(s.t('delete'),
                  isDanger: true,
                  onTap: () => setState(() => _addresses.removeAt(index))),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  //  3. PAYMENT METHODS
  //  FIX: "Add new card" button improved
  // ─────────────────────────────────────────
  Widget _buildPayments() {
    final s = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(s.t('paymentMethods')),
        _card(
          title: s.t('savedCards'),
          child: Column(
            children: [
              _paymentRow(
                  logo: _cardBadge('VISA', const Color(0xFF1A1F71)),
                  name: 'Visa ending in 4521',
                  detail: 'Expires 09/2027',
                  isDefault: true),
              Divider(height: 1, indent: 16, endIndent: 16,
                  color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _paymentRow(
                  logo: _cardBadge('MC', const Color(0xFFEB001B)),
                  name: 'Mastercard ending in 8833',
                  detail: 'Expires 03/2026',
                  actionLabel: 'Remove'),
            ],
          ),
        ),
        _card(
          title: s.t('mobileWallets'),
          child: Column(
            children: [
              _paymentRow(
                  logo: _cardBadge('EP', const Color(0xFF5E9E4E)),
                  name: 'EasyPaisa',
                  detail: '+92 300 1234567 · Linked',
                  actionLabel: 'Unlink'),
              Divider(height: 1, indent: 16, endIndent: 16,
                  color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _paymentRow(
                  logo: _cardBadge('JC', const Color(0xFF6F2DA8)),
                  name: 'JazzCash',
                  detail: 'Not linked',
                  actionLabel: 'Link'),
            ],
          ),
        ),
        // ── IMPROVED "Add new card" button ──
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 4, bottom: 8),
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8A00),
                foregroundColor: Colors.white,
                elevation: 3,
                shadowColor: const Color(0xFFFF8A00).withOpacity(0.4),
                padding:
                const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.add_card, size: 18),
              label: Text(s.t('addNewCard'),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _cardBadge(String text, Color bg) => Container(
    width: 44,
    height: 28,
    decoration:
    BoxDecoration(color: bg, borderRadius: BorderRadius.circular(5)),
    alignment: Alignment.center,
    child: Text(text,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 9)),
  );

  Widget _paymentRow({
    required Widget logo,
    required String name,
    required String detail,
    bool isDefault = false,
    String? actionLabel,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            logo,
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 13)),
                  Text(detail,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            if (isDefault)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Default',
                    style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF4CAF50),
                        fontWeight: FontWeight.w600)),
              ),
            if (actionLabel != null)
              _smallBtn(actionLabel,
                  onTap: () {},
                  isDanger:
                  actionLabel == 'Remove' || actionLabel == 'Unlink'),
          ],
        ),
      );

  // ─────────────────────────────────────────
  //  4. WALLET
  // ─────────────────────────────────────────
  Widget _buildWallet() {
    final s = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Center(
            child: Text(s.t('myWallet'),
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600)),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFF57C00), Color(0xFFFF8A00)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(s.t('availableBalance'),
                  style: const TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 8),
              const Text('Rs. 2,450',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('${s.t('lastToppedUp')}: Apr 20, 2026',
                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.22),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 16),
                      label: Text(s.t('addMoney'),
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.22),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.swap_horiz, size: 16),
                      label: Text(s.t('transfer'),
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        _card(
          title: s.t('recentTransactions'),
          child: Column(
            children: [
              _txnRow(Icons.arrow_downward, 'Cashback received',
                  'Apr 22, 2026', '+Rs. 250', true),
              _txnRow(Icons.arrow_upward, 'Order #ORD-88231 payment',
                  'Apr 18, 2026', '−Rs. 1,200', false),
              _txnRow(Icons.add, 'Top-up via EasyPaisa', 'Apr 15, 2026',
                  '+Rs. 3,000', true),
              _txnRow(Icons.arrow_upward, 'Order #ORD-77441 payment',
                  'Apr 10, 2026', '−Rs. 400', false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _txnRow(IconData icon, String title, String date, String amount,
      bool isCredit) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isCredit
                    ? const Color(0xFF4CAF50).withOpacity(0.12)
                    : Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon,
                  size: 16,
                  color: isCredit ? const Color(0xFF4CAF50) : Colors.red),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 13)),
                  Text(date,
                      style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
            Text(amount,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isCredit ? const Color(0xFF4CAF50) : Colors.red)),
          ],
        ),
      );

  // ─────────────────────────────────────────
  //  5. NOTIFICATIONS
  // ─────────────────────────────────────────
  Widget _buildNotifications() {
    final s = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(s.t('notifications')),
        _card(
          title: s.t('orderUpdates'),
          child: Column(
            children: [
              _toggleRow(s.t('orderPlaced'), s.t('whenOrderConfirmed'),
                  _orderPlaced, (v) => setState(() => _orderPlaced = v)),
              Divider(height: 1, indent: 16, endIndent: 16,
                  color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _toggleRow(s.t('shippingUpdates'), s.t('trackParcelRealTime'),
                  _shipping, (v) => setState(() => _shipping = v)),
              Divider(height: 1, indent: 16, endIndent: 16,
                  color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _toggleRow(s.t('deliveryConfirmation'),
                  s.t('whenOrderDelivered'), _delivery,
                      (v) => setState(() => _delivery = v)),
              Divider(height: 1, indent: 16, endIndent: 16,
                  color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _toggleRow(s.t('returnRefundStatus'),
                  s.t('updatesOnReturnRequests'), _returns,
                      (v) => setState(() => _returns = v)),
            ],
          ),
        ),
        _card(
          title: s.t('promotionsOffers'),
          child: Column(
            children: [
              _toggleRow(s.t('flashSales'), s.t('limitedTimeDeals'),
                  _flashSales, (v) => setState(() => _flashSales = v)),
              Divider(height: 1, indent: 16, endIndent: 16,
                  color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _toggleRow(s.t('vouchersCoupons'), s.t('newPromoCodes'),
                  _vouchers, (v) => setState(() => _vouchers = v)),
              Divider(height: 1, indent: 16, endIndent: 16,
                  color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _toggleRow(s.t('newsletter'), s.t('weeklyPicks'), _newsletter,
                      (v) => setState(() => _newsletter = v)),
            ],
          ),
        ),
        _card(
          title: s.t('channels'),
          child: Column(
            children: [
              _toggleRow(s.t('pushNotifications'), s.t('onYourPhone'),
                  _pushNotif, (v) => setState(() => _pushNotif = v)),
              Divider(height: 1, indent: 16, endIndent: 16,
                  color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _toggleRow(s.t('smsAlerts'), 'Text to +92 300 1234567',
                  _smsAlerts, (v) => setState(() => _smsAlerts = v)),
              Divider(height: 1, indent: 16, endIndent: 16,
                  color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _toggleRow(s.t('emailNotifications'),
                  context.watch<AppProvider>().profile.email, _emailNotif,
                      (v) => setState(() => _emailNotif = v)),
            ],
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  //  6. LANGUAGE & REGION
  // ─────────────────────────────────────────
  Widget _buildLanguage() {
    final s        = AppLocalizations.of(context);
    final provider = context.watch<AppProvider>();
    final langCode = provider.locale.languageCode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(s.t('languageRegion')),
        _card(
          title: s.t('language'),
          child: Column(
            children: [
              _langOption('English', 'en', langCode),
              Divider(height: 1, indent: 16, endIndent: 16,
                  color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _langOption('اردو (Urdu)', 'ur', langCode),
            ],
          ),
        ),
        _card(
          title: s.t('regionCurrency'),
          child: Column(
            children: [
              _editableRegionRow(s.t('country'), _selectedCountry,
                  onTap: () => _showPickerSheet(
                    title: s.t('selectCountry'),
                    options: ['🇵🇰 Pakistan', '🇸🇦 Saudi Arabia', '🇦🇪 UAE',
                      '🇬🇧 United Kingdom', '🇺🇸 United States'],
                    onSelect: (v) => setState(() => _selectedCountry = v),
                  )),
              Divider(height: 1, color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _editableRegionRow(s.t('currency'), _selectedCurrency,
                  onTap: () => _showPickerSheet(
                    title: s.t('selectCurrency'),
                    options: ['PKR — Pakistani Rupee', 'SAR — Saudi Riyal',
                      'AED — UAE Dirham', 'GBP — British Pound',
                      'USD — US Dollar'],
                    onSelect: (v) => setState(() => _selectedCurrency = v),
                  )),
              Divider(height: 1, color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _editableRegionRow(s.t('timeZone'), _selectedTimezone,
                  onTap: () => _showPickerSheet(
                    title: s.t('selectTimeZone'),
                    options: ['PKT (UTC+5)', 'AST (UTC+3)', 'GST (UTC+4)',
                      'GMT (UTC+0)', 'EST (UTC-5)'],
                    onSelect: (v) => setState(() => _selectedTimezone = v),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _langOption(String displayName, String code, String current) {
    final provider   = context.watch<AppProvider>();
    final isSelected = current == code;
    return InkWell(
      onTap: () => provider.setLocale(Locale(code)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Text(displayName,
                  style: TextStyle(
                      fontSize: 14,
                      color: isSelected
                          ? const Color(0xFFFF8A00)
                          : null,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400)),
            ),
            if (isSelected)
              const Icon(Icons.check, color: Color(0xFFFF8A00), size: 18),
          ],
        ),
      ),
    );
  }

  Widget _editableRegionRow(String label, String value,
      {required VoidCallback onTap}) =>
      InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 3),
                    Text(value, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[400]),
            ],
          ),
        ),
      );

  void _showPickerSheet({
    required String title,
    required List<String> options,
    required ValueChanged<String> onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Text(title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          ),
          const Divider(height: 1),
          ...options.map((opt) => ListTile(
            title: Text(opt, style: const TextStyle(fontSize: 14)),
            onTap: () {
              onSelect(opt);
              Navigator.pop(context);
            },
          )),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  //  7. SECURITY
  // ─────────────────────────────────────────
  Widget _buildSecurity() {
    final s = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(s.t('security')),
        _card(
          child: Column(
            children: [
              _secItem(Icons.lock_outline, s.t('password'),
                  'Last changed 3 months ago'),
              Divider(height: 1, indent: 16, endIndent: 16,
                  color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _secItem(Icons.phone_android, s.t('twoFactorAuth'),
                  '● Enabled via SMS'),
              Divider(height: 1, indent: 16, endIndent: 16,
                  color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _secItem(Icons.access_time, s.t('loginActivity'),
                  '2 active sessions'),
              Divider(height: 1, indent: 16, endIndent: 16,
                  color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _secItem(Icons.fingerprint, s.t('faceFingerprintId'),
                  '○ Not set up'),
            ],
          ),
        ),
        _card(
          child: InkWell(
            onTap: () => _showLogoutDialog(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Icon(Icons.logout, size: 18, color: Colors.red),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.t('signOutAllDevices'),
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.red)),
                        Text(s.t('endAllSessions'),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios,
                      size: 14, color: Colors.grey[400]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _secItem(IconData icon, String title, String sub,
      {bool isDanger = false}) =>
      InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: isDanger
                      ? Colors.red.withOpacity(0.1)
                      : const Color(0xFFFF8A00).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(icon,
                    size: 18,
                    color: isDanger ? Colors.red : const Color(0xFFFF8A00)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDanger ? Colors.red : null)),
                    if (sub.isNotEmpty)
                      Text(sub,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  size: 14, color: Colors.grey[400]),
            ],
          ),
        ),
      );

  // ─────────────────────────────────────────
  //  8. DARK / LIGHT MODE
  // ─────────────────────────────────────────
  Widget _buildDarkMode() {
    final s        = AppLocalizations.of(context);
    final provider = context.watch<AppProvider>();
    final mode     = provider.themeMode;
    final isDark   = mode == ThemeMode.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(s.t('darkLightMode')),
        _card(
          child: Column(
            children: [
              // Dark / Light toggle
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF8A00).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Icon(
                          isDark ? Icons.dark_mode : Icons.light_mode,
                          size: 18,
                          color: const Color(0xFFFF8A00)),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(isDark ? s.t('darkMode') : s.t('lightMode'),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                          Text(
                              isDark
                                  ? s.t('currentlyDark')
                                  : s.t('currentlyLight'),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                    Switch(
                      value: isDark,
                      onChanged: (v) => provider.setTheme(
                          v ? ThemeMode.dark : ThemeMode.light),
                      activeColor: const Color(0xFFFF8A00),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              // System default toggle
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: const Icon(Icons.settings_suggest,
                          size: 18, color: Colors.grey),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.t('useSystemDefault'),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                          Text(s.t('followDeviceTheme'),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                    Switch(
                      value: mode == ThemeMode.system,
                      onChanged: (v) => provider.setTheme(
                          v ? ThemeMode.system : ThemeMode.light),
                      activeColor: const Color(0xFFFF8A00),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Preview card
        _card(
          title: s.t('preview'),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => provider.setTheme(ThemeMode.light),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: mode == ThemeMode.light
                                ? const Color(0xFFFF8A00)
                                : Colors.grey[300]!,
                            width: mode == ThemeMode.light ? 2 : 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.light_mode,
                              color: Color(0xFFFF8A00)),
                          const SizedBox(height: 6),
                          Text(s.t('light'),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: mode == ThemeMode.light
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: mode == ThemeMode.light
                                      ? const Color(0xFFFF8A00)
                                      : Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => provider.setTheme(ThemeMode.dark),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: mode == ThemeMode.dark
                                ? const Color(0xFFFF8A00)
                                : Colors.grey[700]!,
                            width: mode == ThemeMode.dark ? 2 : 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.dark_mode,
                              color: Color(0xFFFF8A00)),
                          const SizedBox(height: 6),
                          Text(s.t('dark'),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: mode == ThemeMode.dark
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: mode == ThemeMode.dark
                                      ? const Color(0xFFFF8A00)
                                      : Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  //  9. HELP & SUPPORT
  // ─────────────────────────────────────────
  Widget _buildHelp() {
    final s = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(s.t('helpSupport')),
        _card(
          child: Column(
            children: [
              _helpRow(Icons.help_outline, s.t('faqs'), s.t('faqsSub'),
                  const Color(0xFFFF8A00)),
              Divider(height: 1, indent: 16, endIndent: 16,
                  color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _helpRow(Icons.chat_bubble_outline, s.t('liveChat'),
                  s.t('liveChatSub'), Colors.blue),
              Divider(height: 1, indent: 16, endIndent: 16,
                  color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _helpRow(Icons.phone_outlined, s.t('callUs'), s.t('callUsSub'),
                  const Color(0xFF4CAF50)),
            ],
          ),
        ),
        _card(
          child: Column(
            children: [
              _helpRow(Icons.report_problem_outlined, s.t('reportProblem'),
                  s.t('reportProblemSub'), Colors.orange),
              Divider(height: 1, indent: 16, endIndent: 16,
                  color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _helpRow(Icons.star_outline, s.t('rateApp'), s.t('rateAppSub'),
                  Colors.amber),
              Divider(height: 1, indent: 16, endIndent: 16,
                  color: _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE)),
              _helpRow(Icons.article_outlined, s.t('termsPrivacy'),
                  s.t('legalInformation'), Colors.grey),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: Text(s.t('appVersion'),
                style: TextStyle(fontSize: 12, color: Colors.grey[400])),
          ),
        ),
      ],
    );
  }

  Widget _helpRow(
      IconData icon, String title, String sub, Color color) =>
      InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(icon, size: 18, color: color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 14)),
                    Text(sub,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  size: 14, color: Colors.grey[400]),
            ],
          ),
        ),
      );
}