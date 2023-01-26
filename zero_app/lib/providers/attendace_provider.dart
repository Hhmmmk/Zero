import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:zero_app/modules/attendance.dart';
import 'package:zero_app/modules/user.dart';
import 'package:zero_app/services/attendance_services.dart';

import '../utils/common_utils.dart';

class AttendanceProvider extends ChangeNotifier {
  Attendance? latestTodayAttendaceOfCurrentUser;
  List<Attendance> listAttendance = [];
  bool isLoading = false;
  User? currentUser;


  void newAttendace(bool isTimeIn) async {
    if (currentUser == null) return;
    final img = await _getStartImageData();
    if (img == null) return;
    final now = DateTime.now();
    final date = CommonUtils.convertDateDDMMYYYY(now); 
    final time = CommonUtils.convertTimeHHMMss(now); 
    final newAttendance = Attendance(
      id: CommonUtils.generateId(),
      date: date,
      img: img,
      time: time,
      isTimeIn: isTimeIn,
      userId: currentUser!.accid,
      userName: currentUser!.name,
    );
    // save attendace to db
    await AttendanceService.insertAttendance(newAttendance);
    latestTodayAttendaceOfCurrentUser = await AttendanceService.getLatestTodayAttendanceOfUser(currentUser!.accid);
    resetUser();
    notifyListeners();
    showAttendanceSuccessfullyToast(isTimeIn);
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

  getLastestTodayAttendanceOfUser() async {
    if (currentUser == null) return;
    isLoading = true;
    notifyListeners();
    latestTodayAttendaceOfCurrentUser = await AttendanceService.getLatestTodayAttendanceOfUser(currentUser!.accid);
    isLoading = false;
    notifyListeners();
  }

  void getAllAttendance() async {
    listAttendance = await AttendanceService.getAllAttendance();
    listAttendance.sort((a1, a2) {
      final time1 = CommonUtils.convertDDMMYYtoDate(a1.date);
      final time2 = CommonUtils.convertDDMMYYtoDate(a2.date);
      // latest attendance first
      return time1.isAfter(time2) ? 0 : 1;
    });
    notifyListeners();
  }

  changeUser(User user) async {
    currentUser = user;
    notifyListeners();
    await getLastestTodayAttendanceOfUser();
  }

  void resetUser() {
    currentUser = null;
    notifyListeners();
  }
  
  void showAttendanceSuccessfullyToast(bool isTimeIn) {
    Fluttertoast.showToast(
        msg: "Perform ${isTimeIn ? "Time In" : "Time Out"} Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
