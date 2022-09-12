import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teeqrcodeoj/utility/my_constant.dart';
import 'package:teeqrcodeoj/widgets/show_text.dart';

class OrderHistory extends StatefulWidget {
  final String id;

  OrderHistory({Key? key, required this.id}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final _formKey = GlobalKey<FormState>();
  CollectionReference order = FirebaseFirestore.instance.collection('order');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ประวัติบิล"),
      ),
      body: Form(
        key: _formKey,
        // Getting Specific Data by ID
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('order')
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
            var UidRecode = snapshot.data!.get('UidRecode');
            var dateOrder = snapshot.data!.get('dateOrder');
            var totalOrder = snapshot.data!.get('totalOrder');
            var PaymentOrder = snapshot.data!.get('PaymentOrder');
            var changeOrder = snapshot.data!.get('changeOrder');
            var mapOrders = snapshot.data!.get('mapOrders');

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: ListView(
                children: [
                  ShowText(
                    text: 'ชื่อผู้ทำรายการ : \n' + UidRecode,
                    textStyle: MyConstant().h4Style(),
                  ),
                  ShowText(
                    text: '\nวันที่ทำรายการ : \n' + dateOrder.toString(),
                    textStyle: MyConstant().h4Style(),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Center(child: Text('ชื่อสินค้า')),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(child: Text('ราคา')),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(child: Text('จำนวน')),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(child: Text('ผลรวม')),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: MyConstant.dark,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: mapOrders.length,
                    itemBuilder: (context, index) => Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            mapOrders[index]['name'],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            mapOrders[index]['price'],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            mapOrders[index]['amount'],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            mapOrders[index]['sum'],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: MyConstant.dark,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ShowText(
                                text: 'Total : ',
                                textStyle: MyConstant().h4Style(),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ShowText(
                            text: totalOrder,
                            textStyle: MyConstant().h4Style(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ShowText(
                                text: 'เงินลูกค้า : ',
                                textStyle: MyConstant().h4Style(),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ShowText(
                            text: PaymentOrder,
                            textStyle: MyConstant().h4Style(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ShowText(
                                text: 'เงินทอนลูกค้า : ',
                                textStyle: MyConstant().h4Style(),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ShowText(
                            text: changeOrder,
                            textStyle: MyConstant().h4Style(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
