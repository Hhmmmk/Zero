import 'package:zero_app/providers/attendace_provider.dart';
import 'package:zero_app/providers/start_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../main.dart';
import '../providers/end_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AttendanceProvider>().getLastestTodayAttendance();
    });
  }

  @override
  Widget build(BuildContext context) {

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
            SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 120,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Attendance QR Code",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                _checkInOutBtn()
              ],
            ),
          ],
        ));
  }

  _checkInOutBtn() {
    final latestTodayAttendace = context.watch<AttendanceProvider>().latestTodayAttendace;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //Button Time In
        context.watch<AttendanceProvider>().isLoading
            ? const CircularProgressIndicator()
            : SizedBox.fromSize(
                size: const Size(120, 120),
                child: ClipRect(
                  child: Material(
                    color:latestTodayAttendace == null ||
                                  !latestTodayAttendace.isTimeIn ? Colors.blue : Colors.green,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        var isPerformTimeIn = !(latestTodayAttendace?.isTimeIn ?? false);
                        context.read<AttendanceProvider>().newAttendace(isPerformTimeIn);
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: latestTodayAttendace == null ||
                                  !latestTodayAttendace.isTimeIn
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
              ),
      ],
    );
  }
}
