import 'package:uuid/uuid.dart';

class CommonUtils {
  static generateId() {
    var uuid = const Uuid();
    var v4 = uuid.v4();
    return v4;
  }
}