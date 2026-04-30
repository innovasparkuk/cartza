import 'package:cartza_user/seller_signup.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'main.dart';

class SignupPage extends StatelessWidget {
  final String role;

  const SignupPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 900) {
            return DesktopSignupView(role: role);
          } else if (constraints.maxWidth >= 600) {
            return TabletSignupView(role: role);
          } else {
            return MobileSignupView(role: role);
          }
        },
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// DESKTOP VIEW
////////////////////////////////////////////////////////////

class DesktopSignupView extends StatelessWidget {
  final String role;

  const DesktopSignupView({super.key, required this.role});

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
                    "Join Cartza",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Create your marketplace account",
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

                /// SIGNUP AS SELLER BUTTON
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
                              const ReversedSignupPage(role: "Seller"),),
                        );
                      },
                      icon: const Icon(Icons.store,
                          color: Colors.white, size: 18),
                      label: const Text(
                        "Sign Up as Seller",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: SignupForm(role: role),
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
/// TABLET VIEW
////////////////////////////////////////////////////////////

class TabletSignupView extends StatelessWidget {
  final String role;

  const TabletSignupView({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

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
              child: Image.asset(
                "assests/images/assets/logo1.png",
                height: 110,
              ),
            ),
          ),
        ),

        Expanded(
          flex: 3,
          child: SafeArea(
            child: Column(
              children: [

                /// SIGNUP AS SELLER BUTTON
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
                              const ReversedSignupPage(role: "Seller"),),
                        );
                      },
                      icon: const Icon(Icons.store,
                          color: Colors.white, size: 18),
                      label: const Text(
                        "Sign Up as Seller",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: SignupForm(role: role),
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

class MobileSignupView extends StatelessWidget {
  final String role;

  const MobileSignupView({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [

          /// SIGNUP AS SELLER BUTTON
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
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
                        //const SignupPage(role: "Seller")
                      const ReversedSignupPage(role: "Seller"),
                    ),
                  );
                },
                icon: const Icon(Icons.store,
                    color: Colors.white, size: 18),
                label: const Text(
                  "Sign Up as Seller",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),

          Expanded(
            child: SignupForm(role: role),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// SIGNUP FORM
////////////////////////////////////////////////////////////

class SignupForm extends StatefulWidget {
  final String role;

  const SignupForm({super.key, required this.role});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  bool acceptTerms = false;
  bool obscurePassword = true;
  bool obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: 420,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Center(
                child: Image.asset(
                  "assests/images/assets/logo1.png",
                  height: 60,
                ),
              ),

              const SizedBox(height: 10),

              Center(
                child: Text(
                  widget.role == "Seller"
                      ? "Create Seller Account"
                      : "Create your account",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Center(
                child: Text(
                  "Join Cartza and start shopping smarter",
                  style: TextStyle(color: Colors.black54),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [

                  Expanded(
                    child: TextField(
                      controller: firstName,
                      decoration: _inputDecoration("First Name"),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: TextField(
                      controller: lastName,
                      decoration: _inputDecoration("Last Name"),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              TextField(
                controller: email,
                decoration: _inputDecoration("Email Address"),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: phone,
                decoration: _inputDecoration("Phone Number"),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: password,
                obscureText: obscurePassword,
                decoration: _inputDecoration("Password").copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: confirmPassword,
                obscureText: obscureConfirm,
                decoration: _inputDecoration("Confirm Password").copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                        obscureConfirm
                            ? Icons.visibility_off
                            : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        obscureConfirm = !obscureConfirm;
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

              const SizedBox(height: 10),

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
                    if (widget.role == "Seller") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SellerPage()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const HomePage()),
                      );
                    }
                  },
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Sign In",
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
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}