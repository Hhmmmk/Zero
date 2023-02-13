import 'package:sqflite/sql.dart';

import '../modules/attendance.dart';
import '../utils/common_utils.dart';
import '../utils/local_db.dart';

class AttendanceService {
  static insertAttendance(Attendance attendance) async {
    final db = await DBProvider.db.database;
    if (db == null) return;
    var res = await db.insert(
        DBProvider.attendanceTableName, attendance.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  static Future<Attendance?> getLatestTodayAttendanceOfUser(
      String userId) async {
    final db = await DBProvider.db.database;
    if (db == null) return null;
    var res = await db.query(DBProvider.attendanceTableName,
        where: "date = ? AND userId = ?",
        whereArgs: [CommonUtils.convertDateDDMMYYYY(DateTime.now()), userId]);
    if (res.isEmpty) return null;
    final listAttendanceToday = res.map((e) => Attendance.fromJson(e)).toList();
    listAttendanceToday.sort((a1, a2) {
      final time1 = CommonUtils.convertDDMMYYtoDate(a1.date);
      final time2 = CommonUtils.convertDDMMYYtoDate(a2.date);
      // latest attendance first
      return time1.isAfter(time2) ? 0 : 1;
    });
    return listAttendanceToday[0];
  }

  static Future<List<Attendance>> getAllAttendance() async {
    final db = await DBProvider.db.database;
    if (db == null) return [];
    var res = await db.query(DBProvider.attendanceTableName);
    return res.isNotEmpty
        ? res.map((e) => Attendance.fromJson(e)).toList()
        : [];
  }
}
