import 'package:cartza_user/seller_login.dart';
import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'main.dart';

class ResponsiveLoginPage extends StatelessWidget {
  final String role;
  const ResponsiveLoginPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 900) {
            return DesktopView(role: role);
          } else if (constraints.maxWidth >= 600) {
            return TabletView(role: role);
          } else {
            return MobileView(role: role);
          }
        },
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// DESKTOP VIEW
////////////////////////////////////////////////////////////

class DesktopView extends StatelessWidget {
  final String role;
  const DesktopView({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        /// LEFT PANEL
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

        /// RIGHT PANEL
        Expanded(
          flex: 1,
          child: SafeArea(
            child: Column(
              children: [

                /// SELLER BUTTON
                Padding(
                  padding: const EdgeInsets.only(top: 16, right: 20),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF8A00),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  ReversedLoginPage(role: "Seller")),
                        );
                      },
                      icon:
                      const Icon(Icons.store, color: Colors.white, size: 18),
                      label: const Text(
                        "Login as Seller",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                /// FORM
                Expanded(
                  child: LoginForm(role: role),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////
/// TABLET VIEW (FIXED OVERFLOW)
////////////////////////////////////////////////////////////

class TabletView extends StatelessWidget {
  final String role;
  const TabletView({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        /// LEFT PANEL
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
                    height: 110,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome to Cartza",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Smart shopping made simple",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        /// RIGHT PANEL
        Expanded(
          flex: 3,
          child: SafeArea(
            child: Column(
              children: [

                /// SELLER BUTTON
                Padding(
                  padding: const EdgeInsets.only(top: 16, right: 20),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF8A00),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  ReversedLoginPage(role: "Seller")),
                        );
                      },
                      icon:
                      const Icon(Icons.store, color: Colors.white, size: 18),
                      label: const Text(
                        "Login as Seller",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                /// LOGIN FORM
                Expanded(
                  child: LoginForm(role: role),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////
/// MOBILE VIEW
////////////////////////////////////////////////////////////

class MobileView extends StatelessWidget {
  final String role;
  const MobileView({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: Align(
              alignment: Alignment.topRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8A00),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            ReversedLoginPage(role: "Seller")),
                  );
                },
                icon:
                const Icon(Icons.store, color: Colors.white, size: 18),
                label: const Text(
                  "Login as Seller",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),

          Expanded(
            child: LoginForm(role: role),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// LOGIN FORM
////////////////////////////////////////////////////////////
class LoginForm extends StatefulWidget {
  final String role;
  const LoginForm({super.key, required this.role});

  @override
  State<LoginForm> createState() => _LoginFormState();
}
Widget _googleButton() {
  return SizedBox(
    width: double.infinity,
    height: 56,
    child: Material(
      color: Colors.white,
      elevation: 1.5,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assests/download.png", height: 22),
            const SizedBox(width: 14),
            const Text(
              "Continue with Google",
              style: TextStyle(
                fontSize: 15.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF212121),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _facebookButton() {
  return SizedBox(
    width: double.infinity,
    height: 56,
    child: ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.facebook_outlined,color: Colors.white,size:20 ,),
      label: const Text(
        "Continue with Facebook",
        style: TextStyle(
            fontSize: 15.5,
            color: Colors.white,
            fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1877F2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),
  );
}
class _LoginFormState extends State<LoginForm> {
  bool rememberMe = false;
  bool acceptTerms = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;
  void navigateByRole(BuildContext context, String role) {
    if (role == "Seller") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SellerPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            /// SELLER BUTTON

            Center(
            child: Container(
              width: 420,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [




                  /// LOGO
                  Center(
                    child: Image.asset(
                      "assests/images/assets/logo1.png",
                      height: 60,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// TITLE
                  const Center(
                    child: Text(
                      "Welcome back, explorer!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Center(
                    child: Text(
                      "Securely access your personalized marketplace",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 5),

                  _googleButton(),
                  const SizedBox(height: 10),
                  _facebookButton(),
                  const SizedBox(height: 5),
                  /// EMAIL FIELD
                  const Text("Email Address",
                      style: TextStyle(fontWeight: FontWeight.w500)),

                  const SizedBox(height: 6),

                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "email@example.com",
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// PASSWORD FIELD
                  const Text("Password",
                      style: TextStyle(fontWeight: FontWeight.w500)),

                  const SizedBox(height: 6),

                  TextField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: acceptTerms,
                        onChanged: (val) {
                          setState(() {
                            acceptTerms = val!;
                          });
                        },
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Text("I accept the "),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const TermsConditionsPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Terms & Conditions",
                                style: TextStyle(
                                  color: Color(0xFFFF8A00), // orange like your theme
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 6,),
                  /// FORGOT
                  Row(
                    children: [

                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Forgot Password?",
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 5),

                  /// LOGIN BUTTON (SOLID ORANGE)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF8A00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        navigateByRole(context, widget.role);
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// SIGNUP
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SignupPage(role: "User",)),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color(0xFFFF8A00),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
                ),
          ],
        ),
      );
  }
}
class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Here you can place your Terms & Conditions for Cartaza...",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}