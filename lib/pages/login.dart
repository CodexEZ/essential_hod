import 'package:ess_ward/pages/home.dart';
import 'package:ess_ward/res/colors.dart';
import 'package:ess_ward/res/images.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Hero(tag: "anim", child: SizedBox(height: 200, child: SvgPicture.asset(essentialLogo))),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(color: Colors.shadowColor, blurRadius: 30)
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Hostal admin",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 50),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      decoration: const InputDecoration(
                          isDense: true,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 14, right: 10),
                            child: Text(
                              "ID:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.gray, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      maxLines: 1,
                      decoration: const InputDecoration(
                          isDense: true,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 14, right: 10),
                            child: Text(
                              "Pass:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.gray, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                    ),
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage())),
                      child: Container(
                        height: 75,
                        width: 75,
                        decoration: const BoxDecoration(
                            color: Colors.primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: const Icon(Icons.chevron_right_rounded,
                            color: Colors.white, size: 70),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  
  }
}
