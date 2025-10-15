import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_vendor_app_riverbod/controller/auth_vendor_controller.dart';
import 'package:store_vendor_app_riverbod/service/manage_http_response.dart';

class VendorLoginScreen extends ConsumerStatefulWidget {
  const VendorLoginScreen({super.key});

  @override
  ConsumerState<VendorLoginScreen> createState() => _VendorLoginScreenState();
}

class _VendorLoginScreenState extends ConsumerState<VendorLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final VendorAuthController _authVendorService = VendorAuthController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> loginVendor() async {
    setState(() => isLoading = true);

    await _authVendorService.signinVendor(
      context: context,
      ref: ref,
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      onSuccess: () {
        showSnackBar(context, 'تم تسجيل الدخول بنجاح');
        Navigator.pushNamed(context, '/vendor-dashboard');
      },
    );

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const Text(
                      "Vendor Login",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Login to manage your store',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/images/Illustration.png',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Email',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _emailController,
                      validator:
                          (value) => value!.isEmpty ? 'Enter your email' : null,
                      decoration: InputDecoration(
                        labelText: 'Enter your email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      validator:
                          (value) =>
                              value!.isEmpty ? 'Enter your password' : null,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Enter your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          loginVendor();
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF102DE1), Color(0xCC0D6EFF)],
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child:
                              isLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        const SizedBox(width: 6),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/vendor-register');
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
