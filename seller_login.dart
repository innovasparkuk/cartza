import 'package:flutter/material.dart';
import 'login_page.dart'; // where LoginForm exists

class ReversedLoginPage extends StatelessWidget {
  final String role;
  const ReversedLoginPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 900) {
            return _desktopView();
          } else if (constraints.maxWidth >= 600) {
            return _tabletView();
          } else {
            return LoginForm(role: role);
          }
        },
      ),
    );
  }

////////////////////////////////////////////////////////////
  /// DESKTOP VIEW (FORM LEFT - BRAND RIGHT)
////////////////////////////////////////////////////////////

  Widget _desktopView() {
    return Row(
      children: [

        /// LOGIN FORM (LEFT)
        Expanded(
          flex: 1,
          child: LoginForm(role: role),
        ),

        /// BRAND PANEL (RIGHT)
        Expanded(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFF57C00),
                  Colors.white,
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assests/images/assets/logo1.png",
                    height: 120,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome to Cartza",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Smart shopping made simple",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

////////////////////////////////////////////////////////////
  /// TABLET VIEW (FORM LEFT - BRAND RIGHT)
////////////////////////////////////////////////////////////

  Widget _tabletView() {
    return Row(
      children: [

        /// LOGIN FORM
        Expanded(
          flex: 3,
          child: LoginForm(role: role),
        ),

        /// BRAND PANEL
        Expanded(
          flex: 2,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFF57C00),
                  Colors.white,
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assests/images/assets/logo1.png",
                    height: 120,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome to Cartza",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Smart shopping made simple",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}