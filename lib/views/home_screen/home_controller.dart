import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottery_app/constants/app_colors.dart';
import 'package:lottery_app/views/auth/auth_screen.dart';
import 'package:lottery_app/views/home_screen/home_screen.dart';
import 'package:lottery_app/views/home_screen/models/lottery_model.dart';

class HomeController extends GetxController {
  var lotteryList = <Lotteries>[];
  var lotteryListStatic = <LotteryModel>[];
  var data = ApiResult();
  String token = "";

  int child = 7;
  bool isConnected = false;
  bool isAuthenticated = false;
  bool isLoadingData = true;
  @override
  void onInit() {
    startFunc();

    super.onInit();
  }

  startFunc() async {
    await getDeviceId();
    getLotteryList_1();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      getLotteryList();
    });
  }

  getLotteryList() async {
    // Create a list to hold the LotteryModel objects
    await checkInternetConnection(false);
    if (isConnected) {
      lotteryListStatic.clear();
      for (int i = 1; i <= 50; i++) {
        LotteryModel lottery = LotteryModel(
            remainingTickets: getRandoTickets(),
            ticketAmount: getRandomAmount(),
            ticketNo: getRandomTicketNumber(),
            //image: "assets/images/lotto_1.png",
            image: 'https://i.ibb.co/FzMDmFZ/lotto-1.png');
        lotteryListStatic.add(lottery);
      }
    }
    update();
  }

  getLotteryList_1() async {
    isLoadingData = true;
    final headers = {'apptoken': 'app-crony-9761fde94e8'};
    final dio = Dio();
    dio.options.headers.addAll(headers);

    token = "dddf37e6-3a0c-41d8-9d3f-9bdebc66ecb7";
    await checkInternetConnection(false);
    if (isConnected) {
      lotteryListStatic.clear();
      try {
        final response = await dio.get(
            'https://cronyprotest.azurewebsites.net/api/TVApp/LotteryTV/GetDataByToken?token=$token');

        if (response.statusCode == 200) {
          data = ApiResult.fromJson(response.data);
          for (var element in data.successContents!.lotteries!) {
            if (element.imageLink == "" ||
                element.imageLink ==
                    "https://dev.cronypos.com/images/black.jpg") {
              element.imageLink = "https://i.ibb.co/FzMDmFZ/lotto-1.png";
            }
          }
          child = 7;
          if (data.successContents!.wideList != null) {
            if (data.successContents!.wideList!.isNotEmpty) {
              int wideList = int.parse(data.successContents!.wideList ?? "7");
              if (wideList >= 6 || wideList <= 9) {
                child = int.parse(data.successContents!.wideList ?? "7");
              }
            }
          }

          lotteryList = data.successContents!.lotteries!;
          isAuthenticated = true;
          isLoadingData = false;
        } else {
          isAuthenticated = false;
          isLoadingData = false;
          Get.offAll(const AuthScreen());
        }
      } catch (e) {
        isAuthenticated = false;
        isLoadingData = false;
        Get.offAll(const AuthScreen());
      }
    }
    update();
  }

  authGetLotteryList() async {
    isLoadingData = true;
    final headers = {'apptoken': 'app-crony-9761fde94e8'};
    final dio = Dio();
    dio.options.headers.addAll(headers);
    token = "dddf37e6-3a0c-41d8-9d3f-9bdebc66ecb7";
    await checkInternetConnection(false);
    if (isConnected) {
      lotteryListStatic.clear();
      try {
        final response = await dio.get(
            'https://cronyprotest.azurewebsites.net/api/TVApp/LotteryTV/GetDataByToken?token=$token');

        if (response.statusCode == 200) {
          data = ApiResult.fromJson(response.data);
          for (var element in data.successContents!.lotteries!) {
            if (element.imageLink == "" ||
                element.imageLink ==
                    "https://dev.cronypos.com/images/black.jpg") {
              element.imageLink = "https://i.ibb.co/FzMDmFZ/lotto-1.png";
            }
          }
          child = 7;
          if (data.successContents!.wideList != null) {
            if (data.successContents!.wideList!.isNotEmpty) {
              int wideList = int.parse(data.successContents!.wideList ?? "7");
              if (wideList >= 6 || wideList <= 9) {
                child = int.parse(data.successContents!.wideList ?? "7");
              }
            }
          }

          lotteryList = data.successContents!.lotteries!;
          isAuthenticated = true;
          isLoadingData = false;
          Get.to(HomeScreen());
        } else {
          isAuthenticated = false;
          isLoadingData = false;
          Get.snackbar(
            '',
            '',
            titleText: Text(
              "Your device is not authenticated",
              style: GoogleFonts.darkerGrotesque(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: AppColors.redColor,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }
      } on DioError catch (e) {
        if (e.response!.statusCode == 400) {
          data = ApiResult.fromJson(e.response!.data);
          isAuthenticated = false;
          isLoadingData = false;
          Get.snackbar(
            '',
            '',
            messageText: Text(
              data.failReason ?? "UnAuthorized Access",
              style: GoogleFonts.darkerGrotesque(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            titleText: Text(
              "UnAuthorized Access",
              style: GoogleFonts.darkerGrotesque(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: AppColors.redColor,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }
      } catch (e) {
        Get.snackbar(
          '',
          '',
          messageText: Text(
            e.toString(),
            style: GoogleFonts.darkerGrotesque(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          titleText: Text(
            "Oops something went wrong, please try again",
            style: GoogleFonts.darkerGrotesque(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        );
        isAuthenticated = false;
        isLoadingData = false;
      }
    }
    update();
  }

  checkInternetConnection(bool showMsg) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          if (showMsg) {
            Get.snackbar(
              '',
              '',
              titleText: Text(
                "Active Internet Connection",
                style: GoogleFonts.darkerGrotesque(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              messageText: Text(
                "Connected To Internet",
                style: GoogleFonts.darkerGrotesque(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              snackPosition: SnackPosition.TOP,
            );
          }

          isConnected = true;
        }
      } on SocketException catch (_) {
        Get.snackbar(
          '',
          '',
          titleText: Text(
            "No Active Internet Connection",
            style: GoogleFonts.darkerGrotesque(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          messageText: Text(
            "Please make sure you are connected to internet",
            style: GoogleFonts.darkerGrotesque(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          snackPosition: SnackPosition.TOP,
        );

        isConnected = false;
      }
    } else {
      Get.snackbar(
        '',
        '',
        titleText: Text(
          "No Internet connection",
          style: GoogleFonts.darkerGrotesque(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        messageText: Text(
          "Please make sure you are connected to internet",
          style: GoogleFonts.darkerGrotesque(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        snackPosition: SnackPosition.TOP,
      );

      isConnected = false;
    }
    update();
  }

  getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    var androidDeviceInfo = await deviceInfo.androidInfo;
    token = androidDeviceInfo.id;
    update();
  }

  String getRandomTicketNumber() {
    final random = Random();
    return (random.nextInt(99) + 1).toString();
  }

  getRandomConfig() {
    final random = Random();
    child = (random.nextInt(4) + 6);
  }

  int getRandoTickets() {
    final random = Random();
    return (random.nextInt(299) + 1);
  }

  Color getColor(int remaining) {
    var color = AppColors.redColor;

    if (remaining > 199) {
      color = AppColors.greenColor;
    }
    if (remaining > 99 && remaining < 200) {
      color = AppColors.yellowColor;
    }
    if (remaining < 100) {
      color = AppColors.redColor;
    }
    return color;
  }

  String getRandomAmount() {
    final random = Random();
    return (random.nextInt(30) + 1).toString();
  }

  double childAspectRatioCalculator(int x) {
    switch (x) {
      case 6:
        return 0.9;
      case 7:
        return 0.76;
      case 8:
        return 0.66;
      case 9:
        return 0.58;
      case 10:
        return 0.52;
      default:
        return 0.55; // return 0.0 for any input other than 6, 7, 8, 9, or 10
    }
  }

  double moonHieght(double x) {
    int y = x.toInt();
    switch (y) {
      case 6:
        return 3.5;
      case 7:
        return 2.5;
      case 8:
        return 2.1;
      case 9:
        return 1.8;
      case 10:
        return 1.5;
      default:
        return 2.5; // return 0.0 for any input other than 6, 7, 8, 9, or 10
    }
  }

  double greenContainerHeight(double x) {
    int y = x.toInt();
    switch (y) {
      case 6:
        return 0.05;
      case 7:
        return 0.055;
      case 8:
        return 0.051;
      case 9:
        return 0.050;
      case 10:
        return 0.055;
      default:
        return 0.055; // return 0.0 for any input other than 6, 7, 8, 9, or 10
    }
  }

  double greenContainerPadding(double x) {
    int y = x.toInt();
    switch (y) {
      case 6:
        return 0.02;
      case 7:
        return 0.02;
      case 8:
        return 0.027;
      case 9:
        return 0.027;
      case 10:
        return 0.027;
      default:
        return 0.02; // return 0.0 for any input other than 6, 7, 8, 9, or 10
    }
  }

  double floatingSize(double x) {
    int y = x.toInt();
    switch (y) {
      case 6:
        return 0.3;
      case 7:
        return 0.34;
      case 8:
        return 0.33;
      case 9:
        return 0.35;
      case 10:
        return 0.35;
      default:
        return 0.35; // return 0.0 for any input other than 6, 7, 8, 9, or 10
    }
  }

  double floatingPadding(double x) {
    int y = x.toInt();
    switch (y) {
      case 6:
        return 5;
      case 7:
        return 10;
      case 8:
        return 16;
      case 9:
        return 17;
      case 10:
        return 17;
      default:
        return 8; // return 0.0 for any input other than 6, 7, 8, 9, or 10
    }
  }

  double remainigFontSize(double x) {
    int y = x.toInt();
    switch (y) {
      case 6:
        return 9;
      case 7:
        return 7.2;
      case 8:
        return 7;
      case 9:
        return 7;
      case 10:
        return 7;
      default:
        return 8; // return 0.0 for any input other than 6, 7, 8, 9, or 10
    }
  }

  double ticketNumberFontSize(String x) {
    switch (x.length) {
      case 1:
        return 17;
      case 2:
        return 14;
      case 3:
        return 11;
      case 4:
        return 7;
      case 5:
        return 7;
      default:
        return 7; // return 0.0 for any input other than 6, 7, 8, 9, or 10
    }
  }

  double batteryHealth(String x) {
    int y = int.parse(x);
    var percentage = 0.1;

    if (y > 199) {
      percentage = 1;
    }
    if (y > 99 && y < 200) {
      percentage = y / 160;
    }
    if (y < 100) {
      percentage = y / 100;
    }
    return percentage;
  }

  int dottedDeviderHeight(double input) {
    if (input == 6) {
      return 70;
    } else {
      return 70;
    }
  }

  double getHeight() {
    double height = 0;

    return height;
  }
}
