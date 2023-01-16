
import 'package:sqflite/sql.dart';

import '../modules/attendance.dart';
import '../utils/common_utils.dart';
import '../utils/local_db.dart';

class AttendanceService {
  static insertAttendance(Attendance attendance) async {
    final db = await DBProvider.db.database;
    if (db == null) return;
    var res = await db.insert(DBProvider.attendanceTableName, attendance.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  static Future<Attendance?> getTodayAttendance() async {
    final db = await DBProvider.db.database;
    if (db == null) return null;
    // var res = await db.query(DBProvider.attendanceTableName, where: "date = ?", whereArgs: [CommonUtils.convertDateDDMMYYYY(DateTime.now())]);
    // return res.isNotEmpty ? Attendance.fromJson(res.first) : null ;
  }

  static Future<List<Attendance>?> getAllAttendance() async {
    final db = await DBProvider.db.database;
    if (db == null) return null;
    var res = await db.query(DBProvider.attendanceTableName);
    return res.isNotEmpty ? res.map((e) => Attendance.fromJson(e)).toList() : [] ;
  }
}