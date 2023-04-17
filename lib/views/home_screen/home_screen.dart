// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:math';

import 'package:battery_indicator/battery_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:lottery_app/constants/app_colors.dart';
import 'package:lottery_app/views/home_screen/home_controller.dart';

import 'models/lottery_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  //int child = 7;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: Colors.grey.withOpacity(0.15),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: _.isLoadingData
                    ? CircularProgressIndicator()
                    : _.lotteryList.isEmpty
                        ? Text(
                            'No Data found',
                            style: GoogleFonts.darkerGrotesque(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                textStyle: TextStyle()),
                          )
                        : GridView.builder(
                            padding: EdgeInsets.all(8),
                            itemCount: _.child * 3,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: _.child,
                                    crossAxisSpacing: 5,
                                    childAspectRatio:
                                        _.childAspectRatioCalculator(_.child),
                                    mainAxisSpacing: 5),
                            itemBuilder: (BuildContext context, int index) {
                              return Center(
                                  child: LotteryWidget(
                                      double.parse(_.child.toString()),
                                      _.lotteryList[index]));
                            },
                          ),
              ),
            ),
          );
        });
  }
}

class LotteryWidget extends StatelessWidget {
  double child;
  Lotteries item;
  LotteryWidget(this.child, this.item);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1399 - child;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double h = MediaQuery.of(context).size.height;
    double ffem = (fem * 0.97);

    return GetBuilder<HomeController>(builder: (_) {
      return ClipPath(
        clipper: DolDurmaClipper(holeRadius: 25 * fem),
        child: Material(
          elevation: 8,
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(2), // Border width
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: item.imageLink!,
                        // placeholder: (context, url) =>
                        //    Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.fill,
                        height: 130 * fem,
                        width: 310 * fem,
                      ),
                      // Image.asset(
                      //                   'https://i.ibb.co/FzMDmFZ/lotto-1.png',
                      //                   fit: BoxFit.fill,
                      //                   height: 130 * fem,
                      //                   width: 310 * fem,
                      //                 ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: _.dottedDeviderHeight(child) * fem,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: DottedLine(
                      direction: Axis.horizontal,
                      lineLength: double.infinity,
                      lineThickness: 6.0 * ffem,
                      dashLength: 6.0 * ffem,
                      dashColor: Colors.amber,
                      dashGradient: [
                        Colors.grey.shade100,
                        Colors.grey.shade100,
                      ],
                      dashRadius: 15.0,
                      dashGapLength: 10.0,
                      dashGapColor: Colors.transparent,
                      dashGapRadius: 10.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 3 * fem),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Transform(
                        transform: Matrix4.rotationZ(10.2),
                        alignment: FractionalOffset.center,
                        child: FractionallySizedBox(
                          widthFactor: 0.5,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: CustomPaint(
                              painter: MoonPainter(
                                  child,
                                  _.getColor(int.parse(item.lotteryRemaining!)),
                                  _),
                            ),
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: h * _.greenContainerPadding(child),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: h * _.greenContainerHeight(child),
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: _.getColor(int.parse(item.lotteryRemaining!)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10 * ffem,
                            left: 3 * ffem,
                            bottom: 5 * ffem,
                            right: 3 * ffem),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Remaining Tickets :',
                                  style: GoogleFonts.darkerGrotesque(
                                      fontSize: _.remainigFontSize(child) * fem,
                                      height: 0.01 * ffem,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      textStyle: TextStyle()),
                                ),
                                Text(
                                  item.lotteryRemaining!,
                                  style: GoogleFonts.darkerGrotesque(
                                    fontSize: 20 * fem,
                                    height: 0.01 * ffem,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ticket Amount',
                                  style: GoogleFonts.darkerGrotesque(
                                    fontSize: _.remainigFontSize(child) * fem,
                                    height: 0.01 * ffem,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '\$ ${double.parse(item.lotteryPrice ?? "0").toStringAsFixed(2)}',
                                  style: GoogleFonts.darkerGrotesque(
                                    fontSize: 20 * fem,
                                    height: 0.01 * ffem,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
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
                Padding(
                  padding:
                      EdgeInsets.only(bottom: _.floatingPadding(child) * ffem),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomRoundButton(child, item, _)),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class CustomRoundButton extends StatelessWidget {
  double child;
  Lotteries item;
  HomeController _;
  CustomRoundButton(this.child, this.item, this._);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 3840;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final diagonalSize =
        sqrt((screenWidth * screenWidth) + (screenHeight * screenHeight));
    final fontScaleFactor = diagonalSize / 1000;

    return FractionallySizedBox(
      widthFactor: _.floatingSize(child),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(100 * fem),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 6 * fem,
              blurRadius: 5 * fem,
              offset: Offset(-5 * fem, 10 * fem),
            ),
          ],
        ),
        child: FittedBox(
          child: FloatingActionButton(
            mini: false,
            backgroundColor: AppColors.primary,
            splashColor: Colors.black,
            onPressed: () {
              // logOutDialog(context);
            },
            elevation: 0,
            child: DottedBorder(
                strokeCap: StrokeCap.round,
                dashPattern: [0.1 * ffem, 0.1 * ffem, 0.1 * ffem, 2 * ffem],
                borderType: BorderType.Circle,
                radius: Radius.circular(20 * fem),
                padding: EdgeInsets.all(12 * fem),
                color: Colors.white,
                child: Container(
                  height: 32,
                  width: 33,
                  //color: Colors.amber,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 0.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          item.lotterySequence ?? "0",
                          style: GoogleFonts.darkerGrotesque(
                            fontSize: _.ticketNumberFontSize(
                                    item.lotterySequence ?? "0") *
                                fontScaleFactor,
                            height: 0.8 * ffem,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white, width: 0.5 * ffem),
                            borderRadius: BorderRadius.all(
                              Radius.circular(2 * fem),
                            )),
                        height: 22 * fem,
                        width: 40 * ffem,
                        child: LiquidLinearProgressIndicator(
                          value: _.batteryHealth(item.lotteryRemaining ??
                              "0"), // 0.80, // Defaults to 0.5.
                          valueColor: AlwaysStoppedAnimation(_.getColor(
                              int.parse(item.lotteryRemaining ?? "0"))),
                          backgroundColor: Colors.transparent,
                          borderColor: Colors.black,
                          borderWidth: 0.5 * ffem,
                          borderRadius: 2 * fem,
                          direction: Axis.horizontal,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

class CustomHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = new Path();
    path.lineTo(0.0, size.height / 2);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class MoonPainter extends CustomPainter {
  double child;
  Color color;
  HomeController _;
  MoonPainter(this.child, this.color, this._);
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
        size.width / _.moonHieght(child), size.height / _.moonHieght(child));
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          color,
          color,
          color,
          color,
        ],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    Path path1 = Path()
      ..addOval(Rect.fromCenter(
          center: center, width: size.width, height: size.height));

    Path path2 = Path()
      ..addOval(
        Rect.fromCenter(
          center: Offset(
            center.dx - (size.width / 60),
            center.dy - (size.width / 60),
          ),
          width: size.width - (size.width / 70),
          height: size.height - (size.width / 70),
        ),
      );
    canvas.drawPath(
      Path.combine(PathOperation.difference, path1, path2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DolDurmaClipper extends CustomClipper<Path> {
  final double holeRadius;

  DolDurmaClipper({required this.holeRadius});

  @override
  Path getClip(Size size) {
    var bottom = size.height / 3.2;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0.0, size.height - bottom - holeRadius)
      ..arcToPoint(
        Offset(0, size.height - bottom),
        clockwise: true,
        radius: Radius.circular(1),
      )
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height - bottom)
      ..arcToPoint(
        Offset(size.width, size.height - bottom - holeRadius),
        clockwise: true,
        radius: Radius.circular(1),
      );

    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(DolDurmaClipper oldClipper) => true;
}
