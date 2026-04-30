import 'package:cartza_user/applocalization.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'appprovider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final provider = AppProvider();
  await provider.init();  // important — initialise before runApp

  runApp(
    ChangeNotifierProvider<AppProvider>(
      create: (_) => provider,
      child: const CartzaApp(),
    ),
  );
}

class CartzaApp extends StatefulWidget {
  const CartzaApp({super.key});

  @override
  State<CartzaApp> createState() => _CartzaAppState();
}

class _CartzaAppState extends State<CartzaApp> {
  Locale _locale = const Locale('en'); // default language

  // Function to change language
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ✅ HOME PAGE (FIXED POSITION)
      home: const ResponsiveLoginPage(role: "User"),

      // ✅ LOCALIZATION
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ur'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}

////////////////////////////////////////////////////////////
/// USER HOME PAGE
////////////////////////////////////////////////////////////

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "User Home",
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          "Welcome User!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// SELLER PAGE
////////////////////////////////////////////////////////////

class SellerPage extends StatelessWidget {
  const SellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Seller Dashboard",
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          "Welcome Seller!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
