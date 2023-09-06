import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:math';

import 'barcode_scanner_window.dart';

class BarcodeTest extends StatefulWidget {
  const BarcodeTest();

  @override
  State<BarcodeTest> createState() => _BarcodeTestState();
}

class _BarcodeTestState extends State<BarcodeTest> {
  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: 200,
      height: 200,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('With Scan window')),
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            // scanWindow: Rect.fromCenter(center: center, width: width, height: height),
            onDetect: (barcodes) {
              print('barcodes: ${barcodes.barcodes[0].format}');
            },
          ),
          CustomPaint(
            painter: ScannerOverlay(scanWindow),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: Colors.black.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 120,
                      height: 50,
                      child: FittedBox(
                        child: Text(
                          'Scan something!',
                          overflow: TextOverflow.fade,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // CustomPaint(
          //   foregroundPainter: BorderPainter(),
          //   child: Container(
          //     width: 200,
          //     height: 100,
          //     color: Colors.transparent,
          //   ),
          // ),
          // Positioned.fill(
          //   top: MediaQuery.of(context).size.height * 0.05,
          //   child: Align(
          //     alignment: Alignment.topCenter,
          //     child: SizedBox(
          //       height: MediaQuery.of(context).size.height * 0.55,
          //       child: const VerticalDivider(
          //         color: Color(0xFFB8F416),
          //         thickness: 3,
          //         endIndent: 0,
          //         width: 20,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height; // for convenient shortage
    double sw = size.width; // for convenient shortage
    double cornerSide = sh * 0.1; // desirable value for corners side

    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path()
      ..moveTo(cornerSide, 0)
      ..quadraticBezierTo(0, 0, 0, cornerSide)
      ..moveTo(0, sh - cornerSide)
      ..quadraticBezierTo(0, sh, cornerSide, sh)
      ..moveTo(sw - cornerSide, sh)
      ..quadraticBezierTo(sw, sh, sw, sh - cornerSide)
      ..moveTo(sw, cornerSide)
      ..quadraticBezierTo(sw, 0, sw - cornerSide, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => false;
}
