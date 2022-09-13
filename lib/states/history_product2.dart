import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teeqrcodeoj/utility/my_constant.dart';
import 'package:teeqrcodeoj/widgets/show_text.dart';
import 'package:intl/intl.dart';

class HistoryProduct2 extends StatefulWidget {
  final String id;
  HistoryProduct2({Key? key, required this.id}) : super(key: key);

  @override
  _HistoryProduct2State createState() => _HistoryProduct2State();
}

class _HistoryProduct2State extends State<HistoryProduct2> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ประวัติสินค้าออก"),
      ),
      body: Form(
        key: _formKey,
        // Getting Specific Data by ID
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('stockcut')
              .doc(widget.id)
              .get(),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              print('Something Went Wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            var dateOrder = snapshot.data!.get('dateOrder');
            var status = snapshot.data!.get('status');
            var mapOrder = snapshot.data!.get('mapOrder');

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: ListView(
                children: [
                  ShowText(
                    text: 'สถานะ : ' + status,
                    textStyle: MyConstant().h4Style(),
                  ),
                  ShowText(
                    text: '\nวันที่ทำรายการ : ' +
                        DateFormat(' dd-MM-yyyy  เวลา : HH:mm:ss')
                            .format(dateOrder.toDate()),
                    textStyle: MyConstant().h4Style(),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: const <int, TableColumnWidth>{
                          2: FixedColumnWidth(50),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
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
                                      'จำนวน',
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
                          for (var index = 0; index < mapOrder.length; index++) ...[
                            TableRow(
                              children: [
                                TableCell(
                                  child: Center(
                                      child: Text(mapOrder[index]['name'])),
                                ),
                                
                                TableCell(
                                  child: Center(
                                      child: Text(
                                          mapOrder[index]['amount'])),
                                ),
                               
                              ],
                            ),
                            
                          ]
                          ,
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
