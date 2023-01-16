import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Attendance {
  String userId;
  String userName;
  String id;
  String img;
  String time;
  String date;
  bool isTimeIn;

  //getter
  Attendance({
    required this.userId,
    required this.userName,
    required this.id,
    required this.img,
    required this.time,
    required this.date,
    required this.isTimeIn,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    id: json["id"],
    userId: json["userId"],
    userName: json["userName"],
    date: json["date"],
    time: json["time"],
    img: json["img"],
    isTimeIn: json["isTimeIn"] == 0 ? false : true,
  );

  // Convert an Attendance object to a JSON map.
  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "userName": userName,
    "date": date,
    "time": time,
    "img": img,
    "isTimeIn": isTimeIn ? 1 : 0,
  };
}
