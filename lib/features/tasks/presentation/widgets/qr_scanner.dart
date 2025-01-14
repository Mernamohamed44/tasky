import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tasky/app/helper/navigator.dart';
import 'package:tasky/features/tasks/presentation/screens/task_details_screen.dart';

class QrCodeScanner extends StatelessWidget {
  QrCodeScanner({super.key});

  final MobileScannerController controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: controller,
      onDetect: (BarcodeCapture capture) {
        final List<Barcode> barcodes = capture.barcodes;
        if (barcodes.isNotEmpty) {
          print(barcodes[0].rawValue);
          MagicRouter.navigateReplacement(
            page: TaskDetailsScreen(
              taskId: barcodes[0].rawValue!,
            ),
          );
        }
      },
    );
  }
}
