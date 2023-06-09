import 'package:BikeCrossing/models/bike_model.dart';
import 'package:BikeCrossing/providers/bikes_provider.dart';
import 'package:BikeCrossing/screens/rent_contract_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends ConsumerStatefulWidget {
  const QrScannerScreen({super.key, required this.bike});

  final BikeModel bike;

  @override
  ConsumerState<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends ConsumerState<QrScannerScreen> {
  void _creatingRentalContract() {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => RentalContractScreen(
                bike: widget.bike,
              )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 20),
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_circle_left_outlined),
                  label: Text('Back')),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
              child: Text(
                'Scan the bike:',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _creatingRentalContract();
                },
                child: Text('test')),
            Container(
              width: 500,
              height: 500,
              child: MobileScanner(
                fit: BoxFit.contain,
                controller: MobileScannerController(
                  detectionSpeed: DetectionSpeed.noDuplicates,
                  facing: CameraFacing.back,
                  torchEnabled: false,
                ),
                onDetect: (capture) async {
                  final List<Barcode> barcodes = capture.barcodes;
                  String bikeId = barcodes.last.rawValue.toString();
                  Navigator.of(context).pop();
                  _creatingRentalContract();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
