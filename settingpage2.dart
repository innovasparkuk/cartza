import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

// ThemeProvider class should be defined first
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en', 'US');

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  bool get isDarkMode => _themeMode == ThemeMode.dark;
}

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'settings': 'Settings',
      'themeMode': 'Theme Mode',
      'darkMode': 'Dark Mode',
      'lightMode': 'Light Mode',
      'language': 'Language',
      'notifications': 'Notifications',
      'manageNotifications': 'Manage your notifications',
      'paymentMethods': 'Payment Methods',
      'addEditPaymentMethods': 'Add or edit payment methods',
      'shippingAddress': 'Shipping Address',
      'updateDeliveryAddress': 'Update your delivery address',
      'privacySecurity': 'Privacy & Security',
      'manageAccountSecurity': 'Manage your account security',
      'helpSupport': 'Help & Support',
      'getHelpWithAccount': 'Get help with your account',
      'logout': 'Logout',
      'signOutOfAccount': 'Sign out of your account',
      'selectLanguage': 'Select Language',
      'logoutDialogTitle': 'Logout',
      'logoutDialogContent': 'Are you sure you want to logout?',
      'cancel': 'Cancel',
      'confirmLogout': 'Logout',
    },
    'es': {
      'settings': 'Configuración',
      'themeMode': 'Modo de Tema',
      'darkMode': 'Modo Oscuro',
      'lightMode': 'Modo Claro',
      'language': 'Idioma',
      'notifications': 'Notificaciones',
      'manageNotifications': 'Gestiona tus notificaciones',
      'paymentMethods': 'Métodos de Pago',
      'addEditPaymentMethods': 'Agregar o editar métodos de pago',
      'shippingAddress': 'Dirección de Envío',
      'updateDeliveryAddress': 'Actualiza tu dirección de entrega',
      'privacySecurity': 'Privacidad y Seguridad',
      'manageAccountSecurity': 'Gestiona la seguridad de tu cuenta',
      'helpSupport': 'Ayuda y Soporte',
      'getHelpWithAccount': 'Obtén ayuda con tu cuenta',
      'logout': 'Cerrar Sesión',
      'signOutOfAccount': 'Cerrar sesión de tu cuenta',
      'selectLanguage': 'Seleccionar Idioma',
      'logoutDialogTitle': 'Cerrar Sesión',
      'logoutDialogContent': '¿Estás seguro de que quieres cerrar sesión?',
      'cancel': 'Cancelar',
      'confirmLogout': 'Cerrar Sesión',
    },
    'fr': {
      'settings': 'Paramètres',
      'themeMode': 'Mode Thème',
      'darkMode': 'Mode Sombre',
      'lightMode': 'Mode Clair',
      'language': 'Langue',
      'notifications': 'Notifications',
      'manageNotifications': 'Gérez vos notifications',
      'paymentMethods': 'Méthodes de Paiement',
      'addEditPaymentMethods': 'Ajouter ou modifier les méthodes de paiement',
      'shippingAddress': 'Adresse de Livraison',
      'updateDeliveryAddress': 'Mettez à jour votre adresse de livraison',
      'privacySecurity': 'Confidentialité et Sécurité',
      'manageAccountSecurity': 'Gérez la sécurité de votre compte',
      'helpSupport': 'Aide et Support',
      'getHelpWithAccount': 'Obtenez de l\'aide pour votre compte',
      'logout': 'Déconnexion',
      'signOutOfAccount': 'Déconnectez-vous de votre compte',
      'selectLanguage': 'Sélectionner la Langue',
      'logoutDialogTitle': 'Déconnexion',
      'logoutDialogContent': 'Êtes-vous sûr de vouloir vous déconnecter?',
      'cancel': 'Annuler',
      'confirmLogout': 'Déconnexion',
    },
    'de': {
      'settings': 'Einstellungen',
      'themeMode': 'Themenmodus',
      'darkMode': 'Dunkler Modus',
      'lightMode': 'Heller Modus',
      'language': 'Sprache',
      'notifications': 'Benachrichtigungen',
      'manageNotifications': 'Verwalten Sie Ihre Benachrichtigungen',
      'paymentMethods': 'Zahlungsmethoden',
      'addEditPaymentMethods': 'Zahlungsmethoden hinzufügen oder bearbeiten',
      'shippingAddress': 'Lieferadresse',
      'updateDeliveryAddress': 'Aktualisieren Sie Ihre Lieferadresse',
      'privacySecurity': 'Datenschutz & Sicherheit',
      'manageAccountSecurity': 'Verwalten Sie Ihre Kontosicherheit',
      'helpSupport': 'Hilfe & Support',
      'getHelpWithAccount': 'Hilfe zu Ihrem Konto erhalten',
      'logout': 'Abmelden',
      'signOutOfAccount': 'Melden Sie sich von Ihrem Konto ab',
      'selectLanguage': 'Sprache auswählen',
      'logoutDialogTitle': 'Abmelden',
      'logoutDialogContent': 'Sind Sie sicher, dass Sie sich abmelden möchten?',
      'cancel': 'Abbrechen',
      'confirmLogout': 'Abmelden',
    },
    'hi': {
      'settings': 'सेटिंग्स',
      'themeMode': 'थीम मोड',
      'darkMode': 'डार्क मोड',
      'lightMode': 'लाइट मोड',
      'language': 'भाषा',
      'notifications': 'नोटिफिकेशन',
      'manageNotifications': 'अपने नोटिफिकेशन प्रबंधित करें',
      'paymentMethods': 'भुगतान विधियाँ',
      'addEditPaymentMethods': 'भुगतान विधियाँ जोड़ें या संपादित करें',
      'shippingAddress': 'शिपिंग पता',
      'updateDeliveryAddress': 'अपना डिलीवरी पता अपडेट करें',
      'privacySecurity': 'गोपनीयता और सुरक्षा',
      'manageAccountSecurity': 'अपनी अकाउंट सुरक्षा प्रबंधित करें',
      'helpSupport': 'सहायता और समर्थन',
      'getHelpWithAccount': 'अपने अकाउंट के साथ सहायता प्राप्त करें',
      'logout': 'लॉगआउट',
      'signOutOfAccount': 'अपने अकाउंट से साइन आउट करें',
      'selectLanguage': 'भाषा चुनें',
      'logoutDialogTitle': 'लॉगआउट',
      'logoutDialogContent': 'क्या आप वाकई लॉगआउट करना चाहते हैं?',
      'cancel': 'रद्द करें',
      'confirmLogout': 'लॉगआउट',
    },
    'zh': {
      'settings': '设置',
      'themeMode': '主题模式',
      'darkMode': '深色模式',
      'lightMode': '浅色模式',
      'language': '语言',
      'notifications': '通知',
      'manageNotifications': '管理您的通知',
      'paymentMethods': '支付方式',
      'addEditPaymentMethods': '添加或编辑支付方式',
      'shippingAddress': '收货地址',
      'updateDeliveryAddress': '更新您的收货地址',
      'privacySecurity': '隐私与安全',
      'manageAccountSecurity': '管理您的账户安全',
      'helpSupport': '帮助与支持',
      'getHelpWithAccount': '获取账户帮助',
      'logout': '退出登录',
      'signOutOfAccount': '退出您的账户',
      'selectLanguage': '选择语言',
      'logoutDialogTitle': '退出登录',
      'logoutDialogContent': '您确定要退出登录吗？',
      'cancel': '取消',
      'confirmLogout': '退出登录',
    },
    'ar': {
      'settings': 'الإعدادات',
      'themeMode': 'وضع السمة',
      'darkMode': 'الوضع الداكن',
      'lightMode': 'الوضع الفاتح',
      'language': 'اللغة',
      'notifications': 'الإشعارات',
      'manageNotifications': 'إدارة إشعاراتك',
      'paymentMethods': 'طرق الدفع',
      'addEditPaymentMethods': 'إضافة أو تعديل طرق الدفع',
      'shippingAddress': 'عنوان الشحن',
      'updateDeliveryAddress': 'تحديث عنوان التسليم الخاص بك',
      'privacySecurity': 'الخصوصية والأمان',
      'manageAccountSecurity': 'إدارة أمان حسابك',
      'helpSupport': 'المساعدة والدعم',
      'getHelpWithAccount': 'الحصول على المساعدة لحسابك',
      'logout': 'تسجيل الخروج',
      'signOutOfAccount': 'تسجيل الخروج من حسابك',
      'selectLanguage': 'اختر اللغة',
      'logoutDialogTitle': 'تسجيل الخروج',
      'logoutDialogContent': 'هل أنت متأكد أنك تريد تسجيل الخروج?',
      'cancel': 'إلغاء',
      'confirmLogout': 'تسجيل الخروج',
    },
    'pt': {
      'settings': 'Configurações',
      'themeMode': 'Modo de Tema',
      'darkMode': 'Modo Escuro',
      'lightMode': 'Modo Claro',
      'language': 'Idioma',
      'notifications': 'Notificações',
      'manageNotifications': 'Gerencie suas notificações',
      'paymentMethods': 'Métodos de Pagamento',
      'addEditPaymentMethods': 'Adicionar ou editar métodos de pagamento',
      'shippingAddress': 'Endereço de Envio',
      'updateDeliveryAddress': 'Atualize seu endereço de entrega',
      'privacySecurity': 'Privacidade e Segurança',
      'manageAccountSecurity': 'Gerencie a segurança da sua conta',
      'helpSupport': 'Ajuda e Suporte',
      'getHelpWithAccount': 'Obtenha ajuda com sua conta',
      'logout': 'Sair',
      'signOutOfAccount': 'Sair da sua conta',
      'selectLanguage': 'Selecionar Idioma',
      'logoutDialogTitle': 'Sair',
      'logoutDialogContent': 'Tem certeza de que deseja sair?',
      'cancel': 'Cancelar',
      'confirmLogout': 'Sair',
    },
    'ru': {
      'settings': 'Настройки',
      'themeMode': 'Режим темы',
      'darkMode': 'Темный режим',
      'lightMode': 'Светлый режим',
      'language': 'Язык',
      'notifications': 'Уведомления',
      'manageNotifications': 'Управление уведомлениями',
      'paymentMethods': 'Способы оплаты',
      'addEditPaymentMethods': 'Добавить или изменить способы оплаты',
      'shippingAddress': 'Адрес доставки',
      'updateDeliveryAddress': 'Обновите адрес доставки',
      'privacySecurity': 'Конфиденциальность и безопасность',
      'manageAccountSecurity': 'Управление безопасностью аккаунта',
      'helpSupport': 'Помощь и поддержка',
      'getHelpWithAccount': 'Получить помощь по аккаунту',
      'logout': 'Выйти',
      'signOutOfAccount': 'Выйти из аккаунта',
      'selectLanguage': 'Выбрать язык',
      'logoutDialogTitle': 'Выход',
      'logoutDialogContent': 'Вы уверены, что хотите выйти?',
      'cancel': 'Отмена',
      'confirmLogout': 'Выйти',
    },
    'ja': {
      'settings': '設定',
      'themeMode': 'テーマモード',
      'darkMode': 'ダークモード',
      'lightMode': 'ライトモード',
      'language': '言語',
      'notifications': '通知',
      'manageNotifications': '通知を管理する',
      'paymentMethods': '支払い方法',
      'addEditPaymentMethods': '支払い方法を追加または編集する',
      'shippingAddress': '配送先住所',
      'updateDeliveryAddress': '配送先住所を更新する',
      'privacySecurity': 'プライバシーとセキュリティ',
      'manageAccountSecurity': 'アカウントのセキュリティを管理する',
      'helpSupport': 'ヘルプとサポート',
      'getHelpWithAccount': 'アカウントのヘルプを入手する',
      'logout': 'ログアウト',
      'signOutOfAccount': 'アカウントからログアウトする',
      'selectLanguage': '言語を選択',
      'logoutDialogTitle': 'ログアウト',
      'logoutDialogContent': 'ログアウトしますか？',
      'cancel': 'キャンセル',
      'confirmLogout': 'ログアウト',
    },
    'ko': {
      'settings': '설정',
      'themeMode': '테마 모드',
      'darkMode': '다크 모드',
      'lightMode': '라이트 모드',
      'language': '언어',
      'notifications': '알림',
      'manageNotifications': '알림 관리',
      'paymentMethods': '결제 방법',
      'addEditPaymentMethods': '결제 방법 추가 또는 편집',
      'shippingAddress': '배송 주소',
      'updateDeliveryAddress': '배송 주소 업데이트',
      'privacySecurity': '개인정보 보호 및 보안',
      'manageAccountSecurity': '계정 보안 관리',
      'helpSupport': '도움말 및 지원',
      'getHelpWithAccount': '계정 도움말 받기',
      'logout': '로그아웃',
      'signOutOfAccount': '계정에서 로그아웃',
      'selectLanguage': '언어 선택',
      'logoutDialogTitle': '로그아웃',
      'logoutDialogContent': '로그아웃하시겠습니까?',
      'cancel': '취소',
      'confirmLogout': '로그아웃',
    },
    'it': {
      'settings': 'Impostazioni',
      'themeMode': 'Modalità Tema',
      'darkMode': 'Modalità Scura',
      'lightMode': 'Modalità Chiara',
      'language': 'Lingua',
      'notifications': 'Notifiche',
      'manageNotifications': 'Gestisci le tue notifiche',
      'paymentMethods': 'Metodi di Pagamento',
      'addEditPaymentMethods': 'Aggiungi o modifica metodi di pagamento',
      'shippingAddress': 'Indirizzo di Spedizione',
      'updateDeliveryAddress': 'Aggiorna il tuo indirizzo di consegna',
      'privacySecurity': 'Privacy e Sicurezza',
      'manageAccountSecurity': 'Gestisci la sicurezza del tuo account',
      'helpSupport': 'Aiuto e Supporto',
      'getHelpWithAccount': 'Ottieni aiuto per il tuo account',
      'logout': 'Disconnetti',
      'signOutOfAccount': 'Disconnetti dal tuo account',
      'selectLanguage': 'Seleziona Lingua',
      'logoutDialogTitle': 'Disconnetti',
      'logoutDialogContent': 'Sei sicuro di volerti disconnettere?',
      'cancel': 'Annulla',
      'confirmLogout': 'Disconnetti',
    },
    'tr': {
      'settings': 'Ayarlar',
      'themeMode': 'Tema Modu',
      'darkMode': 'Karanlık Mod',
      'lightMode': 'Aydınlık Mod',
      'language': 'Dil',
      'notifications': 'Bildirimler',
      'manageNotifications': 'Bildirimlerinizi yönetin',
      'paymentMethods': 'Ödeme Yöntemleri',
      'addEditPaymentMethods': 'Ödeme yöntemlerini ekle veya düzenle',
      'shippingAddress': 'Teslimat Adresi',
      'updateDeliveryAddress': 'Teslimat adresinizi güncelleyin',
      'privacySecurity': 'Gizlilik ve Güvenlik',
      'manageAccountSecurity': 'Hesap güvenliğinizi yönetin',
      'helpSupport': 'Yardım ve Destek',
      'getHelpWithAccount': 'Hesabınızla ilgili yardım alın',
      'logout': 'Çıkış Yap',
      'signOutOfAccount': 'Hesabınızdan çıkış yapın',
      'selectLanguage': 'Dil Seçin',
      'logoutDialogTitle': 'Çıkış Yap',
      'logoutDialogContent': 'Çıkış yapmak istediğinizden emin misiniz?',
      'cancel': 'İptal',
      'confirmLogout': 'Çıkış Yap',
    },
    'nl': {
      'settings': 'Instellingen',
      'themeMode': 'Themamodus',
      'darkMode': 'Donkere Modus',
      'lightMode': 'Lichte Modus',
      'language': 'Taal',
      'notifications': 'Meldingen',
      'manageNotifications': 'Beheer uw meldingen',
      'paymentMethods': 'Betalingsmethoden',
      'addEditPaymentMethods': 'Betalingsmethoden toevoegen of bewerken',
      'shippingAddress': 'Verzendadres',
      'updateDeliveryAddress': 'Werk uw bezorgadres bij',
      'privacySecurity': 'Privacy & Beveiliging',
      'manageAccountSecurity': 'Beheer uw accountbeveiliging',
      'helpSupport': 'Hulp & Ondersteuning',
      'getHelpWithAccount': 'Hulp krijgen met uw account',
      'logout': 'Uitloggen',
      'signOutOfAccount': 'Uitloggen uit uw account',
      'selectLanguage': 'Selecteer Taal',
      'logoutDialogTitle': 'Uitloggen',
      'logoutDialogContent': 'Weet u zeker dat u wilt uitloggen?',
      'cancel': 'Annuleren',
      'confirmLogout': 'Uitloggen',
    },
    'pl': {
      'settings': 'Ustawienia',
      'themeMode': 'Tryb Motywu',
      'darkMode': 'Tryb Ciemny',
      'lightMode': 'Tryb Jasny',
      'language': 'Język',
      'notifications': 'Powiadomienia',
      'manageNotifications': 'Zarządzaj powiadomieniami',
      'paymentMethods': 'Metody Płatności',
      'addEditPaymentMethods': 'Dodaj lub edytuj metody płatności',
      'shippingAddress': 'Adres Wysyłki',
      'updateDeliveryAddress': 'Zaktualizuj adres dostawy',
      'privacySecurity': 'Prywatność i Bezpieczeństwo',
      'manageAccountSecurity': 'Zarządzaj bezpieczeństwem konta',
      'helpSupport': 'Pomoc i Wsparcie',
      'getHelpWithAccount': 'Uzyskaj pomoc dotyczącą konta',
      'logout': 'Wyloguj',
      'signOutOfAccount': 'Wyloguj się z konta',
      'selectLanguage': 'Wybierz Język',
      'logoutDialogTitle': 'Wyloguj',
      'logoutDialogContent': 'Czy na pewno chcesz się wylogować?',
      'cancel': 'Anuluj',
      'confirmLogout': 'Wyloguj',
    },
    'uk': {
      'settings': 'Налаштування',
      'themeMode': 'Режим теми',
      'darkMode': 'Темний режим',
      'lightMode': 'Світлий режим',
      'language': 'Мова',
      'notifications': 'Сповіщення',
      'manageNotifications': 'Керування сповіщеннями',
      'paymentMethods': 'Способи оплати',
      'addEditPaymentMethods': 'Додати або редагувати способи оплати',
      'shippingAddress': 'Адреса доставки',
      'updateDeliveryAddress': 'Оновити адресу доставки',
      'privacySecurity': 'Конфіденційність та безпека',
      'manageAccountSecurity': 'Керування безпекою облікового запису',
      'helpSupport': 'Довідка та підтримка',
      'getHelpWithAccount': 'Отримати допомогу з обліковим записом',
      'logout': 'Вийти',
      'signOutOfAccount': 'Вийти з облікового запису',
      'selectLanguage': 'Вибрати мову',
      'logoutDialogTitle': 'Вихід',
      'logoutDialogContent': 'Ви впевнені, що хочете вийти?',
      'cancel': 'Скасувати',
      'confirmLogout': 'Вийти',
    },
    'vi': {
      'settings': 'Cài đặt',
      'themeMode': 'Chế độ Giao diện',
      'darkMode': 'Chế độ Tối',
      'lightMode': 'Chế độ Sáng',
      'language': 'Ngôn ngữ',
      'notifications': 'Thông báo',
      'manageNotifications': 'Quản lý thông báo của bạn',
      'paymentMethods': 'Phương thức Thanh toán',
      'addEditPaymentMethods': 'Thêm hoặc chỉnh sửa phương thức thanh toán',
      'shippingAddress': 'Địa chỉ Giao hàng',
      'updateDeliveryAddress': 'Cập nhật địa chỉ giao hàng của bạn',
      'privacySecurity': 'Quyền riêng tư & Bảo mật',
      'manageAccountSecurity': 'Quản lý bảo mật tài khoản của bạn',
      'helpSupport': 'Trợ giúp & Hỗ trợ',
      'getHelpWithAccount': 'Nhận trợ giúp về tài khoản của bạn',
      'logout': 'Đăng xuất',
      'signOutOfAccount': 'Đăng xuất khỏi tài khoản của bạn',
      'selectLanguage': 'Chọn Ngôn ngữ',
      'logoutDialogTitle': 'Đăng xuất',
      'logoutDialogContent': 'Bạn có chắc chắn muốn đăng xuất không?',
      'cancel': 'Hủy',
      'confirmLogout': 'Đăng xuất',
    },
    'th': {
      'settings': 'การตั้งค่า',
      'themeMode': 'โหมดธีม',
      'darkMode': 'โหมดมืด',
      'lightMode': 'โหมดสว่าง',
      'language': 'ภาษา',
      'notifications': 'การแจ้งเตือน',
      'manageNotifications': 'จัดการการแจ้งเตือนของคุณ',
      'paymentMethods': 'วิธีการชำระเงิน',
      'addEditPaymentMethods': 'เพิ่มหรือแก้ไขวิธีการชำระเงิน',
      'shippingAddress': 'ที่อยู่จัดส่ง',
      'updateDeliveryAddress': 'อัปเดตที่อยู่จัดส่งของคุณ',
      'privacySecurity': 'ความเป็นส่วนตัวและความปลอดภัย',
      'manageAccountSecurity': 'จัดการความปลอดภัยบัญชีของคุณ',
      'helpSupport': 'ความช่วยเหลือและการสนับสนุน',
      'getHelpWithAccount': 'รับความช่วยเหลือเกี่ยวกับบัญชีของคุณ',
      'logout': 'ออกจากระบบ',
      'signOutOfAccount': 'ออกจากระบบบัญชีของคุณ',
      'selectLanguage': 'เลือกภาษา',
      'logoutDialogTitle': 'ออกจากระบบ',
      'logoutDialogContent': 'คุณแน่ใจหรือไม่ว่าต้องการออกจากระบบ?',
      'cancel': 'ยกเลิก',
      'confirmLogout': 'ออกจากระบบ',
    },
    'id': {
      'settings': 'Pengaturan',
      'themeMode': 'Mode Tema',
      'darkMode': 'Mode Gelap',
      'lightMode': 'Mode Terang',
      'language': 'Bahasa',
      'notifications': 'Notifikasi',
      'manageNotifications': 'Kelola notifikasi Anda',
      'paymentMethods': 'Metode Pembayaran',
      'addEditPaymentMethods': 'Tambah atau edit metode pembayaran',
      'shippingAddress': 'Alamat Pengiriman',
      'updateDeliveryAddress': 'Perbarui alamat pengiriman Anda',
      'privacySecurity': 'Privasi & Keamanan',
      'manageAccountSecurity': 'Kelola keamanan akun Anda',
      'helpSupport': 'Bantuan & Dukungan',
      'getHelpWithAccount': 'Dapatkan bantuan dengan akun Anda',
      'logout': 'Keluar',
      'signOutOfAccount': 'Keluar dari akun Anda',
      'selectLanguage': 'Pilih Bahasa',
      'logoutDialogTitle': 'Keluar',
      'logoutDialogContent': 'Apakah Anda yakin ingin keluar?',
      'cancel': 'Batal',
      'confirmLogout': 'Keluar',
    },
    'ms': {
      'settings': 'Tetapan',
      'themeMode': 'Mod Tema',
      'darkMode': 'Mod Gelap',
      'lightMode': 'Mod Terang',
      'language': 'Bahasa',
      'notifications': 'Pemberitahuan',
      'manageNotifications': 'Urus pemberitahuan anda',
      'paymentMethods': 'Kaedah Pembayaran',
      'addEditPaymentMethods': 'Tambah atau edit kaedah pembayaran',
      'shippingAddress': 'Alamat Penghantaran',
      'updateDeliveryAddress': 'Kemas kini alamat penghantaran anda',
      'privacySecurity': 'Privasi & Keselamatan',
      'manageAccountSecurity': 'Urus keselamatan akaun anda',
      'helpSupport': 'Bantuan & Sokongan',
      'getHelpWithAccount': 'Dapatkan bantuan dengan akaun anda',
      'logout': 'Log Keluar',
      'signOutOfAccount': 'Log keluar dari akaun anda',
      'selectLanguage': 'Pilih Bahasa',
      'logoutDialogTitle': 'Log Keluar',
      'logoutDialogContent': 'Adakah anda pasti mahu log keluar?',
      'cancel': 'Batal',
      'confirmLogout': 'Log Keluar',
    },
  };

  String? get settings => _localizedValues[locale.languageCode]!['settings'];
  String? get themeMode => _localizedValues[locale.languageCode]!['themeMode'];
  String? get darkMode => _localizedValues[locale.languageCode]!['darkMode'];
  String? get lightMode => _localizedValues[locale.languageCode]!['lightMode'];
  String? get language => _localizedValues[locale.languageCode]!['language'];
  String? get notifications => _localizedValues[locale.languageCode]!['notifications'];
  String? get manageNotifications => _localizedValues[locale.languageCode]!['manageNotifications'];
  String? get paymentMethods => _localizedValues[locale.languageCode]!['paymentMethods'];
  String? get addEditPaymentMethods => _localizedValues[locale.languageCode]!['addEditPaymentMethods'];
  String? get shippingAddress => _localizedValues[locale.languageCode]!['shippingAddress'];
  String? get updateDeliveryAddress => _localizedValues[locale.languageCode]!['updateDeliveryAddress'];
  String? get privacySecurity => _localizedValues[locale.languageCode]!['privacySecurity'];
  String? get manageAccountSecurity => _localizedValues[locale.languageCode]!['manageAccountSecurity'];
  String? get helpSupport => _localizedValues[locale.languageCode]!['helpSupport'];
  String? get getHelpWithAccount => _localizedValues[locale.languageCode]!['getHelpWithAccount'];
  String? get logout => _localizedValues[locale.languageCode]!['logout'];
  String? get signOutOfAccount => _localizedValues[locale.languageCode]!['signOutOfAccount'];
  String? get selectLanguage => _localizedValues[locale.languageCode]!['selectLanguage'];
  String? get logoutDialogTitle => _localizedValues[locale.languageCode]!['logoutDialogTitle'];
  String? get logoutDialogContent => _localizedValues[locale.languageCode]!['logoutDialogContent'];
  String? get cancel => _localizedValues[locale.languageCode]!['cancel'];
  String? get confirmLogout => _localizedValues[locale.languageCode]!['confirmLogout'];
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'fr', 'de', 'hi', 'zh', 'ar', 'pt', 'ru', 'ja', 'ko', 'it', 'tr', 'nl', 'pl', 'uk', 'vi', 'th', 'id', 'ms'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// SettingsPage2 class should be defined before its state
class SettingsPage2 extends StatefulWidget {
  const SettingsPage2({super.key});

  @override
  State<SettingsPage2> createState() => _SettingsPage2State();
}

class _SettingsPage2State extends State<SettingsPage2> {
  final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English', 'country': 'US'},
    {'code': 'es', 'name': 'Español', 'country': 'ES'},
    {'code': 'fr', 'name': 'Français', 'country': 'FR'},
    {'code': 'de', 'name': 'Deutsch', 'country': 'DE'},
    {'code': 'hi', 'name': 'हिन्दी', 'country': 'IN'},
    {'code': 'zh', 'name': '中文 (简体)', 'country': 'CN'},
    {'code': 'zh', 'name': '中文 (繁體)', 'country': 'TW'},
    {'code': 'ar', 'name': 'العربية', 'country': 'SA'},
    {'code': 'pt', 'name': 'Português', 'country': 'BR'},
    {'code': 'ru', 'name': 'Русский', 'country': 'RU'},
    {'code': 'ja', 'name': '日本語', 'country': 'JP'},
    {'code': 'ko', 'name': '한국어', 'country': 'KR'},
    {'code': 'it', 'name': 'Italiano', 'country': 'IT'},
    {'code': 'tr', 'name': 'Türkçe', 'country': 'TR'},
    {'code': 'nl', 'name': 'Nederlands', 'country': 'NL'},
    {'code': 'pl', 'name': 'Polski', 'country': 'PL'},
    {'code': 'uk', 'name': 'Українська', 'country': 'UA'},
    {'code': 'vi', 'name': 'Tiếng Việt', 'country': 'VN'},
    {'code': 'th', 'name': 'ไทย', 'country': 'TH'},
    {'code': 'id', 'name': 'Bahasa Indonesia', 'country': 'ID'},
    {'code': 'ms', 'name': 'Bahasa Melayu', 'country': 'MY'},
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.settings!,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: _buildSettingsSection(),
    );
  }

  Widget _buildSettingsSection() {
    final localizations = AppLocalizations.of(context);

    return ResponsiveWrapper(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            // Theme Mode Setting
            _buildThemeModeItem(),

            // Language Setting
            _buildLanguageItem(),

            // Existing settings items
            _buildSettingsItem(
              Icons.notifications,
              localizations.notifications!,
              localizations.manageNotifications!,
              onTap: () {},
            ),
            _buildSettingsItem(
              Icons.payment,
              localizations.paymentMethods!,
              localizations.addEditPaymentMethods!,
              onTap: () {},
            ),
            _buildSettingsItem(
              Icons.location_on,
              localizations.shippingAddress!,
              localizations.updateDeliveryAddress!,
              onTap: () {},
            ),
            _buildSettingsItem(
              Icons.security,
              localizations.privacySecurity!,
              localizations.manageAccountSecurity!,
              onTap: () {},
            ),
            _buildSettingsItem(
              Icons.help,
              localizations.helpSupport!,
              localizations.getHelpWithAccount!,
              onTap: () {},
            ),
            _buildSettingsItem(
              Icons.logout,
              localizations.logout!,
              localizations.signOutOfAccount!,
              isLogout: true,
              onTap: _showLogoutDialogMethod,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeModeItem() {
    final localizations = AppLocalizations.of(context);

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: Colors.purple,
                size: 22,
              ),
            ),
            title: Text(
              localizations.themeMode!,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            subtitle: Text(
              themeProvider.isDarkMode ? localizations.darkMode! : localizations.lightMode!,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.setThemeMode(
                  value ? ThemeMode.dark : ThemeMode.light,
                );
              },
              activeColor: Colors.purple,
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageItem() {
    final localizations = AppLocalizations.of(context);

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final currentLocale = themeProvider.locale;
        final currentLanguage = languages.firstWhere(
              (lang) => lang['code'] == currentLocale.languageCode,
          orElse: () => languages.first,
        );

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.language,
                color: Colors.blue,
                size: 22,
              ),
            ),
            title: Text(
              localizations.language!,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            subtitle: Text(
              currentLanguage['name']!,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[400],
            ),
            onTap: () => _showLanguageDialog(themeProvider),
          ),
        );
      },
    );
  }

  void _showLanguageDialog(ThemeProvider themeProvider) {
    final localizations = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400, // Fixed width for both phone and Chrome
              maxHeight: 500, // Fixed max height
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    localizations.selectLanguage!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: languages.length,
                    itemBuilder: (context, index) {
                      final language = languages[index];
                      return ListTile(
                        leading: Text(
                          _getFlagEmoji(language['country']!),
                          style: const TextStyle(fontSize: 20),
                        ),
                        title: Text(
                          language['name']!,
                          style: const TextStyle(fontSize: 14),
                        ),
                        trailing: themeProvider.locale.languageCode == language['code']
                            ? const Icon(Icons.check, color: Colors.green, size: 20)
                            : null,
                        onTap: () {
                          themeProvider.setLocale(Locale(language['code']!, language['country']!));
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getFlagEmoji(String countryCode) {
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  // Renamed to avoid duplicate method name
  void _showLogoutDialogMethod() {
    final localizations = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localizations.logoutDialogTitle!),
          content: Text(localizations.logoutDialogContent!),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(localizations.cancel!),
            ),
            TextButton(
              onPressed: () {
                // Implement logout logic here
                Navigator.of(context).pop();
              },
              child: Text(
                localizations.confirmLogout!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String subtitle,
      {bool isLogout = false, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isLogout
                ? Colors.red.withOpacity(0.1)
                : const Color(0xFF4CAF50).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isLogout ? Colors.orange : const Color(0xFF4CAF50),
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isLogout
                ? Colors.orange
                : Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[400],
        ),
        onTap: onTap,
      ),
    );
  }
}

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Always use the same layout regardless of screen size
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600), // Fixed max width for all screen sizes
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16), // Fixed padding for all screen sizes
          child: child,
        ),
      ),
    );
  }
}

class MyApp3 extends StatelessWidget {
  const MyApp3({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Builder(
        builder: (context) {
          final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Your App',
            theme: ThemeData.light().copyWith(
              primaryColor: Colors.green,
              cardColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              scaffoldBackgroundColor: Colors.grey[50],
            ),
            darkTheme: ThemeData.dark().copyWith(
              primaryColor: Colors.green,
              cardColor: Colors.grey[900],
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.grey[900],
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              scaffoldBackgroundColor: Colors.grey[900],
            ),
            themeMode: themeProvider.themeMode,
            locale: themeProvider.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'), // English
              Locale('es', 'ES'), // Spanish
              Locale('fr', 'FR'), // French
              Locale('de', 'DE'), // German
              Locale('hi', 'IN'), // Hindi
              Locale('zh', 'CN'), // Chinese Simplified
              Locale('zh', 'TW'), // Chinese Traditional
              Locale('ar', 'SA'), // Arabic
              Locale('pt', 'BR'), // Portuguese (Brazil)
              Locale('ru', 'RU'), // Russian
              Locale('ja', 'JP'), // Japanese
              Locale('ko', 'KR'), // Korean
              Locale('it', 'IT'), // Italian
              Locale('tr', 'TR'), // Turkish
              Locale('nl', 'NL'), // Dutch
              Locale('pl', 'PL'), // Polish
              Locale('uk', 'UA'), // Ukrainian
              Locale('vi', 'VN'), // Vietnamese
              Locale('th', 'TH'), // Thai
              Locale('id', 'ID'), // Indonesian
              Locale('ms', 'MY'), // Malay
            ],
            home: const SettingsPage2(), // Added home property
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const MyApp3());
}

// Example widget showing how to use localization in other parts of the app
class SomeOtherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Text(localizations.settings!);
  }
}