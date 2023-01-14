import 'package:flutter/material.dart';
import 'package:zero_app/modules/start_module.dart';

class StartAttendanceProvider extends ChangeNotifier {
  final List<StartAttendance> _startattendanceList = [];

  StartAttendance _currentDay = StartAttendance('end', 'dd-mm-yyyy', '');

  //getter
  List<StartAttendance> get startattendanceList => _startattendanceList;
  StartAttendance get currentDay => _currentDay;

  
  void newTimeIn() {
    StartAttendance activeHomeAttendance =
        StartAttendance('', 'dd-mm-yyyy', '');

    activeHomeAttendance.getDate();
    activeHomeAttendance.getStartTime();

    _currentDay = activeHomeAttendance;

    //push the array list
    _startattendanceList.add(activeHomeAttendance);

    notifyListeners();
  }
}
