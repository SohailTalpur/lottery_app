import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottery_app/constants/app_colors.dart';
import 'package:lottery_app/views/home_screen/home_controller.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (_) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.primary, AppColors.tabletPrimary],
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your device is not authenticated",
                    style: GoogleFonts.darkerGrotesque(
                      fontSize: w * 0.02,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Kindly contact support, authenticate your device and then click on authenticate",
                    style: GoogleFonts.darkerGrotesque(
                      fontSize: w * 0.02,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Token : ${_.token}",
                    style: GoogleFonts.darkerGrotesque(
                      fontSize: w * 0.03,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: MyElevatedButton(
                      width: w / 2,
                      onPressed: () async {
                        await _.authGetLotteryList();
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: const Text('Authenticate'),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: MyElevatedButton(
                  //     width: w / 3,
                  //     onPressed: () async {
                  //       await _.checkInternetConnection(true);
                  //     },
                  //     borderRadius: BorderRadius.circular(20),
                  //     child: const Text('Check Internet'),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        });
  }
}

class MyElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 44.0,
    this.gradient = const LinearGradient(
        colors: [AppColors.primary, AppColors.tabletPrimary]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}
