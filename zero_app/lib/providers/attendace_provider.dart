import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zero_app/modules/attendance.dart';
import 'package:zero_app/services/attendance_services.dart';

import '../utils/common_utils.dart';

class AttendanceProvider extends ChangeNotifier {
  Attendance? latestTodayAttendace;
  List<Attendance> listAttendance = [];
  bool isLoading = false;

  void newAttendace(bool isTimeIn) async {
    final userData = await scanQR();
    final img = await _getStartImageData();
    if (userData == null || img == null) return;
    final data = jsonDecode(userData);
    final now = DateTime.now();
    final date = CommonUtils.convertDateDDMMYYYY(now); 
    final time = CommonUtils.convertTimeHHMMss(now); 
    final newAttendance = Attendance(
      id: CommonUtils.generateId(),
      date: date,
      img: img,
      time: time,
      isTimeIn: isTimeIn,
      userId: data['accid'],
      userName: data['name'],
    );
    // save attendace to db
    await AttendanceService.insertAttendance(newAttendance);
    await AttendanceService.getLatestTodayAttendance();
    notifyListeners();
  }

  Future<String?> _getStartImageData() async {
    final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    if (image == null) return null;
    final imageBytes = File(image.path).readAsBytesSync();
    String img64 = base64Encode(imageBytes);
    return img64;
  }

  Future<String?> scanQR() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      return await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      return null;
    }
  }

  getLastestTodayAttendance() async {
    isLoading = true;
    notifyListeners();
    latestTodayAttendace = await AttendanceService.getLatestTodayAttendance();
    isLoading = false;
    notifyListeners();
  }
}
