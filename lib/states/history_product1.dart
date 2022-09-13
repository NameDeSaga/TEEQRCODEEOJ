import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teeqrcodeoj/states/history_product2.dart';
import 'package:intl/intl.dart';

class HitoryProduct1 extends StatefulWidget {
  HitoryProduct1({Key? key}) : super(key: key);

  @override
  State<HitoryProduct1> createState() => _HitoryProduct1State();
}

class _HitoryProduct1State extends State<HitoryProduct1> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('stockcut').snapshots();

  CollectionReference product =
      FirebaseFirestore.instance.collection('stockcut');
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
          return ListView(children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Table(
                    border: TableBorder.all(),
                    columnWidths: const <int, TableColumnWidth>{
                      /*  1: FixedColumnWidth(80),*/
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
                                  'Action',
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
                                  child: Text(
                                      DateFormat('dd-MM-yyyy\nHH:mm:ss').format(
                                          storedocs[i]['dateOrder'].toDate()),
                                      style: TextStyle(fontSize: 10.0))),
                            ),
                            TableCell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HistoryProduct2(
                                            id: storedocs[i]['id'],
                                          ),
                                        ),
                                      )
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]
                    ]),
              ),
            )
          ]);
        });
  }
}
