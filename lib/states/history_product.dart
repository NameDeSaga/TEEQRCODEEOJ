import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teeqrcodeoj/widgets/show_button.dart';
import 'package:intl/intl.dart';

class Historyproduct extends StatefulWidget {
  Historyproduct({Key? key}) : super(key: key);

  @override
  State<Historyproduct> createState() => _HistoryproductState();
}

class _HistoryproductState extends State<Historyproduct> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('stockupdate').snapshots();

  CollectionReference product =
      FirebaseFirestore.instance.collection('stockupdate');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: studentsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print('Something went Wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final List storedocs = [];
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          storedocs.add(a);
          a['id'] = document.id;
        }).toList();

        return ListView(
          children: [
            ShowButton(
              label: 'ประวัติสินค้าออก',
              pressFunc: () {},
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Table(
                    border: TableBorder.all(),
                    columnWidths: const <int, TableColumnWidth>{
                      1: FixedColumnWidth(80),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              color: Colors.greenAccent,
                              child: Center(
                                child: Text(
                                  'ชื่อสินค้า',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              color: Colors.greenAccent,
                              child: Center(
                                child: Text(
                                  'วันที่',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              color: Colors.greenAccent,
                              child: Center(
                                child: Text(
                                  'จำนวน',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              color: Colors.greenAccent,
                              child: Center(
                                child: Text(
                                  'สถานะ',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      for (var i = 0; i < storedocs.length; i++) ...[
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(
                                  child: Text(storedocs[i]['name'],
                                      style: TextStyle(fontSize: 10.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text(
                                      DateFormat('dd-MM-yyyy\nHH:mm:ss')
                                          .format(storedocs[i]['dateRecord'].toDate()),
                                      style: TextStyle(fontSize: 10.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text(storedocs[i]['amount'].toString(),
                                      style: TextStyle(fontSize: 10.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text(storedocs[i]['status'].toString(),
                                      style: TextStyle(fontSize: 10.0))),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                )),
          ],
        );
      },
    );
  }
}
