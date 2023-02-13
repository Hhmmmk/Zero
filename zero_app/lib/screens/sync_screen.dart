import 'package:collection/collection.dart';
import 'package:provider/provider.dart';
import 'package:zero_app/main.dart';
import 'package:flutter/material.dart';
import 'package:zero_app/providers/login_provider.dart';

import '../providers/attendace_provider.dart';

class SyncPage extends StatefulWidget {
  const SyncPage({super.key});

  @override
  State<SyncPage> createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //showLoginDialog();
      context.read<AttendanceProvider>().getAllAttendance();
    });
    super.initState();
  }

  //password
  bool _isObscure = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                'Sync',
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
      body: (Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              //Employee required to sync
              const Text(
                'Employee:',
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontFamily: 'Poppins'),
              ),
              const Text(
                ' 5 required to sync',
                style: TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                width: 20,
              ),
              //button to sync
              ElevatedButton.icon(
                onPressed: () {
                  print("You pressed Icon Elevated Button");
                  //Show Dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 9, 50, 111),
                ),
                icon: Icon(Icons.sync), //icon data for elevated button
                label: const Text(
                  'Sync now',
                  style: TextStyle(fontFamily: 'Poppins'),
                ), //label text
              ),

              const SizedBox(
                width: 15,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'List of Attendance',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),

              //Table
            ],
          ),
          Column(
            children: [
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                children: [
                  _renderTabel(),
                ],
              ),
            ],
          )
        ],
      )),
    );
  }

  _renderTabel() {
    final listAttendance = context.watch<AttendanceProvider>().listAttendance;
    final data = listAttendance
        .map((a) => _Row(a.userId, a.userName, a.userCode, a.time,
            a.isTimeIn ? 'Time In' : 'Time Out', a.date))
        .toList();
    return PaginatedDataTable(
      header: const Text(
        'Attendance',
        style: TextStyle(
            fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w600),
      ),
      rowsPerPage: 5,
      columns: const [
        DataColumn(
            label: Text(
          'ACC ID',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        )),
        DataColumn(
            label: Text(
          'EMPLOYEE CODE',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        )),
        DataColumn(
            label: Text(
          'NAME',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        )),
        DataColumn(
            label: Text(
          'TIME',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        )),
        DataColumn(
            label: Text(
          'TYPE',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        )),
        DataColumn(
            label: Text(
          'DATE',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        )),
      ],
      source: _DataSource(context, data),
    );
  }

  /* NOTE: THIS IS WORKING LOGIN */
  // void showLoginDialog() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       final isLoginError = context.watch<LoginProvider>().isLoginError;
  //       final isLoading = context.watch<LoginProvider>().isLoading;
  //       return AlertDialog(
  //           scrollable: true,
  //           title: const Text(
  //             'Login',
  //             style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
  //           ),
  //           content: Padding(
  //             padding: EdgeInsets.all(8.00),
  //             child: Container(
  //               // width: MediaQuery.of(context).size.width - 10,
  //               // height: MediaQuery.of(context).size.height - 20,
  //               width: MediaQuery.of(context).size.width * 0.45,
  //               // height:
  //               //     MediaQuery.of(context).size.height * 0.30,
  //               child: Form(
  //                   child: Column(
  //                 children: <Widget>[
  //                   TextFormField(
  //                     controller: emailController,
  //                     keyboardType: TextInputType.emailAddress,
  //                     decoration: const InputDecoration(
  //                       labelText: 'Email',
  //                       labelStyle: TextStyle(
  //                           fontFamily: 'Poppins', fontWeight: FontWeight.w500),
  //                       icon: Icon(Icons.email),
  //                     ),
  //                   ),
  //                   TextFormField(
  //                     controller: passwordController,
  //                     obscureText: _isObscure,
  //                     decoration: const InputDecoration(
  //                       labelText: 'Password',
  //                       labelStyle: TextStyle(
  //                           fontFamily: 'Poppins', fontWeight: FontWeight.w500),
  //                       //icon: Icon(Icons.password),
  //                       icon: Icon(Icons.lock),
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 25,
  //                   ),
  //                   isLoginError
  //                       ? const Padding(
  //                           padding: EdgeInsets.only(bottom: 15),
  //                           child: Text(
  //                             'Email or password is incorrect',
  //                             style: TextStyle(
  //                               color: Colors.red,
  //                               fontSize: 14,
  //                             ),
  //                           ),
  //                         )
  //                       : Container(),
  //                   Container(
  //                     width: 130,
  //                     child: ElevatedButton(
  //                       onPressed: login,
  //                       style: ElevatedButton.styleFrom(
  //                           backgroundColor: Color.fromARGB(255, 9, 50, 111),
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(10))),
  //                       child: !isLoading
  //                           ? const Text(
  //                               'LOGIN',
  //                               style: TextStyle(
  //                                   fontSize: 22,
  //                                   fontFamily: 'Poppins',
  //                                   letterSpacing: 2,
  //                                   color: Colors.white,
  //                                   fontWeight: FontWeight.w600),
  //                             )
  //                           : Container(
  //                               width: 15,
  //                               height: 15,
  //                               child: const CircularProgressIndicator(
  //                                 color: Colors.white,
  //                                 strokeWidth: 3.0,
  //                               ),
  //                             ),
  //                     ),
  //                   )
  //                 ],
  //               )),
  //             ),
  //           ));
  //     },
  //   );
  // }

  void login() async {
    context
        .read<LoginProvider>()
        .login(emailController.text, passwordController.text)
        .then((value) {
      if (value == true) Navigator.of(context).pop();
    });
  }
}

class _Row {
  _Row(
    this.userId,
    this.userName,
    this.userCode,
    this.time,
    this.isTimeIn,
    this.date,
  );

  final String userId;
  final String userName;
  final String userCode;
  final String time;
  final String isTimeIn;
  final String date;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, List<_Row> data) {
    _rows = data;
  }

  final BuildContext context;
  late List<_Row> _rows;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(row.userId)),
        DataCell(Text(row.userCode)),
        DataCell(Text(row.userName)),
        DataCell(Text(row.time)),
        DataCell(Text(row.isTimeIn)),
        DataCell(Text(row.date)),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
