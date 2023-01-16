import 'package:flutter/material.dart';
import 'package:zero_app/modules/attendance.dart';
import 'package:zero_app/services/attendance_services.dart';

import '../utils/common_utils.dart';

class AttendanceProvider extends ChangeNotifier{
  Attendance? latestTodayAttendace;
  List<Attendance> listAttendance = [];

  void newAttendace(bool isTimeIn, String date, String img, String time) async {
    final now = DateTime.now();
    final date = '${now.day}-${now.month}-${now.year}';
    final time = '${now.hour}:${now.minute}:${now.second}';
    final newAttendance = Attendance(id: CommonUtils.generateId(), date: date, img: img, time: time, isTimeIn: isTimeIn);
    // save attendace to db
    await AttendanceService.insertAttendance(newAttendance);
    await getLastestTodayAttendance();
    notifyListeners();
  }
  
  getLastestTodayAttendance() {}     
}