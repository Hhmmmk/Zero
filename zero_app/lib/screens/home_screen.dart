import 'dart:convert';

import 'package:zero_app/modules/user.dart';
import 'package:zero_app/providers/attendace_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<AttendanceProvider>().currentUser;
    return Scaffold(
        drawer: RealDrawer(),
        appBar: AppBar(
          toolbarHeight: 100.0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Text(
                  'Home',
                  style: TextStyle(
                      color: Colors.white,
                      //  fontStyle: FontStyle.italic,
                      fontFamily: 'Poppins',
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 120,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  currentUser == null
                      ? "Attendance QR Code"
                      : "Hello ${currentUser.name}",
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                currentUser == null ? _attendanceBtn() : _checkInOutBtn(),
                // _checkInOutBtn()
              ],
            ),
          ],
        ));
  }

  _checkInOutBtn() {
    final latestTodayAttendaceOfCurrentUser =
        context.watch<AttendanceProvider>().latestTodayAttendaceOfCurrentUser;
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      //Button Time In
      context.watch<AttendanceProvider>().isLoading
          ? const CircularProgressIndicator()
          : SizedBox.fromSize(
              size: const Size(120, 120),
              child: ClipRect(
                child: Material(
                  color: latestTodayAttendaceOfCurrentUser == null ||
                          !latestTodayAttendaceOfCurrentUser.isTimeIn
                      ? Colors.blue
                      : Colors.green,
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: () {
                      var isPerformTimeIn =
                          !(latestTodayAttendaceOfCurrentUser?.isTimeIn ??
                              false);
                      context
                          .read<AttendanceProvider>()
                          .newAttendace(isPerformTimeIn);
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: latestTodayAttendaceOfCurrentUser == null ||
                                !latestTodayAttendaceOfCurrentUser.isTimeIn
                            ? const <Widget>[
                                Icon(
                                  Icons.alarm_add,
                                  color: Colors.white,
                                  size: 60,
                                ),
                                Text(
                                  "Time In",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]
                            : const <Widget>[
                                Icon(Icons.logout,
                                    color: Colors.white, size: 60),
                                Text(
                                  'Time Out',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                  ),
                ),
              ),
            )
    ]);
  }

  _attendanceBtn() {
    return Center(
      child: ClipRect(
        child: Material(
          color: Colors.blueAccent,
          child: InkWell(
            splashColor: Colors.white,
            onTap: changeCurrentUser,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.qr_code,
                      color: Colors.white,
                      size: 60,
                    ),
                    Text(
                      "Attendance",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

//user
  changeCurrentUser() async {
    final provider = context.read<AttendanceProvider>();
    final data = await provider.scanQR();
    if (data == null) return;
    final userData = jsonDecode(data);
    final user =
        User(userData['accid'], userData['employeeCode'], userData['name']);
    await provider.changeUser(user);
  }
}
