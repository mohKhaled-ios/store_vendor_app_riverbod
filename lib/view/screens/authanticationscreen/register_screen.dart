// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:multivendor_ecommerce_riverbod/controllers/authcontroller.dart';
// import 'package:multivendor_ecommerce_riverbod/views/screens/authanticationscreen/login_screen.dart';

// class Registerscreen extends StatefulWidget {
//   Registerscreen({super.key});

//   @override
//   State<Registerscreen> createState() => _RegisterscreenState();
// }

// class _RegisterscreenState extends State<Registerscreen> {
//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//   final Authcontroller _authcontroller = Authcontroller();

//   late String email;

//   late String password;

//   late String fullname;
//   bool isloading = false;
//   signup() async {
//     setState(() {
//       isloading = true;
//     });
//     await _authcontroller
//         .signupuser(
//           context: context,
//           fullname: fullname,
//           email: email,
//           password: password,
//         )
//         .whenComplete(() {
//           _formkey.currentState!.reset();
//           isloading = false;
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white.withOpacity(0.9),
//         body: Center(
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formkey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "creat your account",
//                     style: TextStyle(
//                       color: Color(0xFF0d120E),
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 0.2,
//                       fontSize: 23,
//                     ),
//                   ),
//                   const Text(
//                     'to explor the world exclusives',
//                     style: TextStyle(
//                       color: Color(0xFF0d120E),
//                       fontSize: 14,
//                       letterSpacing: 0.2,
//                     ),
//                   ),
//                   Image.asset(
//                     'assets/images/Illustration.png',
//                     width: 200,
//                     height: 200,
//                   ),
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       'Email',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: 0.2,
//                       ),
//                     ),
//                   ),
//                   TextFormField(
//                     onChanged: (value) {
//                       email = value;
//                     },
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'enter yor email';
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(9),
//                       ),
//                       focusedBorder: InputBorder.none,
//                       enabledBorder: InputBorder.none,
//                       labelText: 'enter your email',
//                       labelStyle: TextStyle(fontSize: 14, letterSpacing: 0.1),
//                       prefixIcon: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Image.asset(
//                           'assets/icons/email.png',
//                           width: 20,
//                           height: 20,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       'FullName',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: 0.2,
//                       ),
//                     ),
//                   ),
//                   TextFormField(
//                     onChanged: (value) {
//                       fullname = value;
//                     },
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'enter your full name';
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(9),
//                       ),
//                       focusedBorder: InputBorder.none,
//                       enabledBorder: InputBorder.none,
//                       labelText: 'enter your FullName',
//                       labelStyle: TextStyle(fontSize: 14, letterSpacing: 0.1),
//                       prefixIcon: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Image.asset(
//                           'assets/icons/user.jpeg',
//                           width: 20,
//                           height: 20,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextFormField(
//                     onChanged: (value) {
//                       password = value;
//                     },
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'enter your full password';
//                       } else {
//                         return null;
//                       }
//                     },
//                     keyboardType: TextInputType.visiblePassword,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(9),
//                       ),
//                       focusedBorder: InputBorder.none,
//                       enabledBorder: InputBorder.none,
//                       labelText: 'enter your password',
//                       labelStyle: TextStyle(fontSize: 14, letterSpacing: 0.1),
//                       prefixIcon: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Image.asset(
//                           'assets/icons/password.png',
//                           width: 20,
//                           height: 20,
//                         ),
//                       ),
//                       suffixIcon: Icon(Icons.visibility),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   InkWell(
//                     onTap: () async {
//                       if (_formkey.currentState!.validate()) {
//                         signup();
//                       }
//                     },
//                     child: Container(
//                       width: 319,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         gradient: LinearGradient(
//                           colors: [Color(0xFF102DE1), Color(0xCC0D6EFF)],
//                         ),
//                       ),
//                       child: Stack(
//                         children: [
//                           Positioned(
//                             left: 279,
//                             top: 19,
//                             child: Opacity(
//                               opacity: 0.5,
//                               child: Container(
//                                 width: 60,
//                                 height: 60,
//                                 clipBehavior: Clip.antiAlias,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     width: 12,
//                                     color: Color(0xFF103DE5),
//                                   ),
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 260,
//                             top: 29,
//                             child: Opacity(
//                               opacity: 0.5,
//                               child: Container(
//                                 width: 10,
//                                 height: 10,
//                                 clipBehavior: Clip.antiAlias,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     width: 3,
//                                     color: Color(0xFF2141E5),
//                                   ),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 311,
//                             top: 36,

//                             child: Opacity(
//                               opacity: 0.3,
//                               child: Container(
//                                 width: 5,
//                                 height: 5,
//                                 clipBehavior: Clip.antiAlias,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(3),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 281,
//                             top: -10,
//                             child: Opacity(
//                               opacity: 0.3,
//                               child: Container(
//                                 width: 20,
//                                 height: 20,
//                                 clipBehavior: Clip.antiAlias,

//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Center(
//                             child:
//                                 isloading
//                                     ? CircularProgressIndicator(
//                                       color: Colors.white,
//                                     )
//                                     : Text(
//                                       'Sign up',

//                                       style: TextStyle(
//                                         letterSpacing: 0.3,
//                                         fontSize: 18,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,

//                     children: [
//                       Text(
//                         'already have an Account ?',
//                         style: TextStyle(
//                           color: Colors.black.withOpacity(0.5),
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 1,
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) {
//                                 return Loginscreen();
//                               },
//                             ),
//                           );
//                         },
//                         child: Text(
//                           'SIGN in',
//                           style: TextStyle(fontSize: 20, color: Colors.blue),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:store_vendor_app_riverbod/controller/auth_vendor_controller.dart';
import 'package:store_vendor_app_riverbod/service/manage_http_response.dart';

class VendorRegisterScreen extends StatefulWidget {
  const VendorRegisterScreen({super.key});

  @override
  State<VendorRegisterScreen> createState() => _VendorRegisterScreenState();
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final VendorAuthController _authVendorService = VendorAuthController();

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> registerVendor() async {
    setState(() => isLoading = true);

    await _authVendorService.signupVendor(
      context: context,
      fullname: _fullnameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      onSuccess: () {
        showSnackBar(context, 'تم تسجيل بنجاح');
        // التوجيه لصفحة تسجيل الدخول
        Navigator.pushNamed(context, '/vendor-login');
      },
    );

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const Text(
                      "Create Vendor Account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Sign up to start selling",
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
                        'Full Name',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _fullnameController,
                      validator:
                          (value) =>
                              value!.isEmpty ? 'Enter your full name' : null,
                      decoration: InputDecoration(
                        labelText: 'Enter your full name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        prefixIcon: Icon(Icons.person),
                      ),
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
                              value!.length < 8
                                  ? 'Password must be 8+ characters'
                                  : null,
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
                          registerVendor();
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
                                    'Register',
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
                        const Text("Already have an account?"),
                        const SizedBox(width: 6),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/vendor-login');
                          },
                          child: const Text(
                            'Login',
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
