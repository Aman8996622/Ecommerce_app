import 'package:flutter/material.dart';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:movieapp/presentation/widget/scanner_animation.dart';

class ScanQrBox extends StatefulWidget {
  const ScanQrBox({super.key});

  @override
  State<ScanQrBox> createState() => _ScanQrBoxState();
}

class _ScanQrBoxState extends State<ScanQrBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  MobileScannerController mobileScannerController = MobileScannerController();
  String scannedText = '';

  @override
  void initState() {
    scanQr();

    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animateScanAnimation(reverse: true);
      } else if (status == AnimationStatus.dismissed) {
        animateScanAnimation(reverse: false);
      }
    });
    animateScanAnimation(reverse: true);
    super.initState();
  }

  double borderWidth = 4;

  @override
  Widget build(BuildContext context) {
    double defaultSize = MediaQuery.of(context).size.width - 30;
    return Column(
      children: [
        SizedBox(
          width: defaultSize + 1,
          height: defaultSize + 1,
          child: Stack(
            children: [
              Container(
                width: defaultSize,
                height: defaultSize,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.grey.shade700,
                    width: borderWidth,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: defaultSize + 1,
                  height: defaultSize - 150,
                  color: Colors.white,
                ),
              ),
              Center(
                child: Container(
                  width: defaultSize - 150,
                  height: defaultSize + 1,
                  color: Colors.white,
                ),
              ),
              Center(
                child: SizedBox(
                  width: defaultSize - 15,
                  height: defaultSize - 15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: MobileScanner(
                      controller: mobileScannerController,
                      fit: BoxFit.fill,
                      onDetect: (capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        for (final barcode in barcodes) {
                          setState(() {
                            scannedText = barcode.rawValue ?? 'No data found';
                          });
                        }
                        mobileScannerController.stop();
                      },
                    ),
                  ),
                ),
              ),
              ScannerAnimation(
                animation: _animationController as Animation<double>,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Scanned Text: $scannedText',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

/* ************************************* / 
 //SCAN QR 
 
 /// 
/ ************************************* */
  void scanQr() {
    // scanQrController.barcodeValue = "";
    // // scanQrController.mobileScannerController.start();
    // scanQrController.mobileScannerController.start();
  }

/* ************************************* / 
  // ANIMATE SCAN ANIMATION

  /// this method is responsible for animating the qr scan animation 
/ ************************************* */
  void animateScanAnimation({bool? reverse}) {
    if (reverse ?? false) {
      _animationController.reverse(from: 1);
    } else {
      _animationController.forward(from: 0);
    }
  }

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   scanQrController.mobileScannerController.stop();
  //   super.dispose();
  // }
}
