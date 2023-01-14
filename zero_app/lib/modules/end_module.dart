import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class EndAttendance {
  String id = '';
  String imgEnd = '';
  String endTime = '';
  String date = 'dd-mm-yyyy';

  //getter
  EndAttendance(this.imgEnd, this.endTime, this.date) {
    id = generateId();
  }

  generateId() {
    var uuid = const Uuid();
    var v4 = uuid.v4();
    return v4;
  }

  getDate() {
    var date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = '${dateParse.day}-${dateParse.month}-${dateParse.year}';
    var finalDate = formattedDate.toString();

    this.date = finalDate;
  }

  getTime() {
    var time = DateTime.now().toString();
    var timeParse = DateTime.parse(time);
    var formattedTime =
        "${timeParse.hour}:${timeParse.minute}:${timeParse.second}";
    var finalTime = formattedTime.toString();

    return finalTime;
  }

  getEndImage(String img64) {
    this.imgEnd = img64;
  }

  getEndTime() {
    var currentTime = getTime();

    endTime = currentTime;
  }
}
