import 'package:zero_app/providers/start_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../main.dart';
import '../providers/end_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _scanBarcode = 'Unknown';
  //Image Picker
  XFile? _image;

  final picker = ImagePicker();

  // this is a code get image from Camera -- this is working
  _imageFromCamera() async {
    final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);

    _getStartImageData(image!);
  }

  _imageCamera() async {
    final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    _getEndImageData(image!);
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      //print the data
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<StartAttendanceProvider>().startattendanceList;
    context.watch<EndAttendanceProvider>().endattendanceList;
    return Scaffold(
        drawer: RealDrawer(),
        appBar: AppBar(
          toolbarHeight: 100.0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Text(
                  'Home',
                  style: TextStyle(
                      color: Colors.white,
                      //  fontStyle: FontStyle.italic,
                      fontFamily: 'Poppins',
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 120,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Attendance QR Code",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //Button Time In
                    SizedBox.fromSize(
                      size: Size(120, 120),
                      child: ClipRect(
                        child: Material(
                          color: Colors.blue,
                          child: InkWell(
                            splashColor: Colors.white,
                            onTap: () async {
                              scanQR();
                              _imageFromCamera();
                              context
                                  .read<StartAttendanceProvider>()
                                  .newTimeIn();
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Icon(
                                  Icons.alarm_add,
                                  color: Colors.white,
                                  size: 60,
                                ),
                                Text(
                                  "Time In",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    //Button Time out
                    SizedBox.fromSize(
                      size: Size(120, 120),
                      child: ClipRect(
                          child: Material(
                        color: Colors.green,
                        child: InkWell(
                          splashColor: Colors.white,
                          onTap: () async {
                            scanQR();
                            _imageCamera();
                            context.read<EndAttendanceProvider>().newTimeOut();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(Icons.logout, color: Colors.white, size: 60),
                              Text(
                                'Time Out',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  void _getStartImageData(XFile file) {
    final imageBytes = File(file.path).readAsBytesSync();
    String img64 = base64Encode(imageBytes);
    print(img64);

    context.read<StartAttendanceProvider>().currentDay.getStartImage(img64);
  }

  void _getEndImageData(XFile file) {
    final imageBytes = File(file.path).readAsBytesSync();
    String img64 = base64Encode(imageBytes);
    print(img64);

    context.read<EndAttendanceProvider>().endcurrentDay.getEndImage(img64);
  }
}
