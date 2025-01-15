import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tasky/app/helper/navigator.dart';
import 'package:tasky/app/utils/colors.dart';
import 'package:tasky/app/widget/custom_text.dart';
import 'package:tasky/features/tasks/presentation/screens/task_details_screen.dart';

class QrCodeScanner extends StatelessWidget {
   QrCodeScanner({super.key});

  final MobileScannerController controller = MobileScannerController();
  bool _hasNavigated = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const CustomText(text: 'QR ID Scanner', color: Colors.black),
          centerTitle: true,
          backgroundColor: AppColors.palePrimary,
        ),
        body: MobileScanner(
          controller: controller,
          onDetect: (BarcodeCapture capture) {
            final List<Barcode> barcodes = capture.barcodes;
            if (barcodes.isNotEmpty) {
              print(barcodes[0].rawValue);
              if (barcodes.isNotEmpty && !_hasNavigated) {
                _hasNavigated = true; // Set the flag to true
                MagicRouter.navigateReplacement(
                  page: TaskDetailsScreen(
                    taskId: barcodes[0].rawValue!,
                  ),
                );
              }
            }
          },
        ));
  }
}
