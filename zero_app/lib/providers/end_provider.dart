import 'package:flutter/material.dart';
import 'package:zero_app/modules/end_module.dart';

class EndAttendanceProvider extends ChangeNotifier {
  final List<EndAttendance> _endattendanceList = [];

  EndAttendance _endcurrentDay = EndAttendance('end', 'dd-mm-yyyy', '');

  //getter
  List<EndAttendance> get endattendanceList => _endattendanceList;
  EndAttendance get endcurrentDay => _endcurrentDay;

  void newTimeOut() {
    EndAttendance activeEndAttendance = EndAttendance('', 'dd-mm-yyyy', '');

    activeEndAttendance.getDate();
    activeEndAttendance.getEndTime();
    _endcurrentDay = activeEndAttendance;

    //push the array list
    _endattendanceList.add(activeEndAttendance);

    notifyListeners();
  }
}
