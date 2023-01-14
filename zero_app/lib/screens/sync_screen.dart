import 'package:zero_app/main.dart';
import 'package:flutter/material.dart';

class SyncPage extends StatefulWidget {
  const SyncPage({super.key});

  @override
  State<SyncPage> createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
  //password
  bool _isObscure = true;

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
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            scrollable: true,
                            title: const Text(
                              'Login',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 20),
                            ),
                            content: Padding(
                              padding: EdgeInsets.all(8.00),
                              child: Container(
                                // width: MediaQuery.of(context).size.width - 10,
                                // height: MediaQuery.of(context).size.height - 20,
                                width: MediaQuery.of(context).size.width * 0.45,
                                // height:
                                //     MediaQuery.of(context).size.height * 0.30,
                                child: Form(
                                    child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                        labelText: 'Email',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500),
                                        icon: Icon(Icons.email),
                                      ),
                                    ),
                                    TextFormField(
                                      obscureText: _isObscure,
                                      decoration: const InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500),
                                        //icon: Icon(Icons.password),
                                        icon: Icon(Icons.lock),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Color.fromARGB(255, 9, 50, 111),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        child: const Text(
                                          'LOGIN',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontFamily: 'Poppins',
                                              letterSpacing: 2,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ))
                                  ],
                                )),
                              ),
                            ));
                      });
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
                  PaginatedDataTable(
                    header: const Text(
                      'Attendance',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    rowsPerPage: 5,
                    columns: const [
                      DataColumn(
                          label: Text(
                        'Acc ID',
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                      )),
                      DataColumn(
                          label: Text(
                        'Name',
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                      )),
                      DataColumn(
                          label: Text(
                        'Start In',
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                      )),
                      DataColumn(
                          label: Text(
                        'End Time',
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                      )),
                      DataColumn(
                          label: Text(
                        'Date',
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                      )),
                    ],
                    source: _DataSource(context),
                  ),
                ],
              ),
            ],
          )
        ],
      )),
    );
  }
}

class _Row {
  _Row(
    this.valueA,
    this.valueB,
    this.valueC,
    this.valueD,
    this.valueE,
  );

  final String valueA;
  final String valueB;
  final String valueC;
  final String valueD;
  final String valueE;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _rows = <_Row>[
      _Row('1001', 'John Doe', '7:30', '4:30', '13/01/32'),
      _Row('1001', 'John Doe', '7:30', '4:30', '13/01/32'),
      _Row('1001', 'John Doe', '7:30', '4:30', '13/01/32'),
      _Row('1001', 'John Doe', '7:30', '4:30', '13/01/32'),
      _Row('1001', 'John Doe', '7:30', '4:30', '13/01/32'),
    ];
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
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD.toString())),
        DataCell(Text(row.valueE)),
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
