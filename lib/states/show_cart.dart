import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teeqrcodeoj/models/order_model.dart';
import 'package:teeqrcodeoj/models/product_model.dart';
import 'package:teeqrcodeoj/models/sqlite_model.dart';
import 'package:teeqrcodeoj/models/stock_model.dart';
import 'package:teeqrcodeoj/states/add_product.dart';
import 'package:teeqrcodeoj/states/main_home.dart';
import 'package:teeqrcodeoj/states/scan_product.dart';
import 'package:teeqrcodeoj/utility/my_constant.dart';
import 'package:teeqrcodeoj/utility/my_dialog.dart';
import 'package:teeqrcodeoj/utility/sqlite.dart';
import 'package:teeqrcodeoj/widgets/show_button.dart';
import 'package:teeqrcodeoj/widgets/show_form.dart';
import 'package:teeqrcodeoj/widgets/show_from_int.dart';
import 'package:teeqrcodeoj/widgets/show_image.dart';
import 'package:teeqrcodeoj/widgets/show_progress.dart';
import 'package:teeqrcodeoj/widgets/show_text.dart';

class ShowCart extends StatefulWidget {
  const ShowCart({Key? key}) : super(key: key);

  @override
  State<ShowCart> createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  List<SQLiteModel> sqliteModels = [];
  bool load = true;
  bool? haveData;
  double change = 0; // เงินทอน
  double total = 0; // ผลรวมราคาสินค้าทั้งหมด
  double payment = 0; // ใส่เงินลูกค้า
  String urlSlip = '';
  String? UidRecode;

  Timestamp? dateRecordbill;
  var user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processReadSQLite();
    DateTime dateTime = DateTime.now();
    dateRecordbill = Timestamp.fromDate(dateTime);
    UidRecode = user!.email;
  }

  Future<Null> processReadSQLite() async {
    if (sqliteModels.isEmpty) {
      sqliteModels.clear();
    }

    await SQLite().readSQLite().then((value) async {
      print('### maps on SQLitHelper ==>> $value');

      if (value.isEmpty) {
        haveData = false;
      } else {
        haveData = true;
        for (var item in value) {
          SQLiteModel sqLiteModel = item;
          sqliteModels.add(sqLiteModel);
        }
      }

      setState(() {
        load = false;
        sqliteModels = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //รวมราคาสินค้า
    total = 0;
    double producttotal = 0;

    for (var item in sqliteModels) {
      double sumInt = double.parse(item.sum.trim());
      setState(() {
        total = total + sumInt;
      });
    }
    setState(() {
      change = (payment - total) > 0 ? (payment - total) : 0;
    });

    //

    return Scaffold(
      appBar: AppBar(
          title: ShowText(
            text: 'ตะกร้าสินค้า',
            textStyle: MyConstant().h2Style(),
          ),
          backgroundColor: MyConstant.white,
          foregroundColor: MyConstant.dark,
          elevation: 0),
      body: load
          ? ShowProgress()
          : sqliteModels.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShowText(
                          text: 'ไม่มีสินค้าอยู่ในตะกร้า',
                          textStyle: MyConstant().h2Style()),
                    ],
                  ),
                )
              : buildContent(total),
    );
  }

  ListView buildContent(double total) {
    return ListView(
      children: [
        ShowName(),
        BuildHead(),
        listProduct(),
        BuildDivider(),
        BuildTotalProduct(total),
        BuildTotalProduct2(),
        BuildTotalProduct3(change),
        BuildDivider(),
        buttonController(),
      ],
    );
  }

  Future<void> confirmEmptyCart() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: 'images/logo.png'),
          title: ShowText(
            text: 'คุณต้องการเคลียร์ตระกร้า ? ',
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowText(
            text: 'เคลียร์ตระกร้าทั้งหมด',
            textStyle: MyConstant().h3Style(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await SQLite().emptySQLite().then((value) {
                Navigator.pop(context);
                processReadSQLite();
              });
            },
            child: Text('ยืนยัน'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ยกเลิก'),
          )
        ],
      ),
    );
  }

  Row buttonController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              change = payment - total;
            });
          },
          child: Text('คิดเงินทอน'),
        ),
        Container(
          margin: EdgeInsets.only(left: 4),
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: ListTile(
                    leading: ShowImage(path: 'images/logo.png'),
                    title: ShowText(
                      text: 'ยืนยันการคิดเงิน ? ',
                      textStyle: MyConstant().h2Style(),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        //เก็บสินค้าในตะกร้า
                        var mapOrders = <Map<String, dynamic>>[];
                        for (var item in sqliteModels) {
                          mapOrders.add(item.toMap());
                        }
                        Timestamp dateOrder =
                            Timestamp.fromDate(DateTime.now());
                        OrderModel orderModel = OrderModel(
                          dateOrder: dateOrder,
                          mapOrders: mapOrders,
                          status: 'ขายสินค้า',
                          totalOrder: total.toString(),
                          PaymentOrder: payment.toString(),
                          changeOrder: change.toString(),
                          UidRecode: UidRecode!,
                        );

                        DocumentReference reference = FirebaseFirestore.instance
                            .collection('order')
                            .doc();

                        await reference
                            .set(orderModel.toMap())
                            .then((value) async {
                          String docId = reference.id;
                          print('## Save Order Success $docId');
                        });

                        //เก็บค่าสินค้าที่ออกจากสต๊อก
                        var mapOrdersCut = <Map<String, dynamic>>[];
                        for (var item in sqliteModels) {
                          mapOrdersCut.add(item.toMap());
                        }
                        StockModel stockModel = StockModel(
                            dateOrder: dateOrder,
                            mapOrderCut: mapOrdersCut,
                            status: 'สินค้าออก');
                        // ignore: unused_local_variable
                        await FirebaseFirestore.instance
                            .collection('stockcut')
                            .doc()
                            .set(stockModel.toMap())
                            .then((value) => null);
                        //ตัดสินค้าออกจากสต๊อก

                        for (var item in sqliteModels) {
                          await FirebaseFirestore.instance
                              .collection('product')
                              .where('codeScan', isEqualTo: item.idProduct)
                              .get()
                              .then((value) async {
                            if (value.docs.isEmpty) {
                            } else {
                              var existingAmount = value.docs[0].get('amount');

                              Map<String, dynamic> data = {};
                              data['amount'] =
                                  existingAmount - int.parse(item.amount);

                              await FirebaseFirestore.instance
                                  .collection('product')
                                  .doc(value.docs[0].id)
                                  .update(data)
                                  .then((value) {
                                print(
                                    '# Successfully Update ${item.name}: ${data['amount']}');
                              });
                            }
                          });
                        }

                        //เคลียร์ตระกร้าทั้งหมด
                        await SQLite().emptySQLite().then((value) {
                          Navigator.pop(context);
                          processReadSQLite();
                        });
                      },
                      child: Text('ยืนยัน'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('ยกเลิก'),
                    )
                  ],
                ),
              );
            },
            child: Text('คิดเงิน'),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 4, right: 8),
          child: ElevatedButton(
            onPressed: () => confirmEmptyCart(),
            child: Text('เคลียร์ตระกร้า'),
          ),
        ),
      ],
    );
  }

  Divider BuildDivider() {
    return Divider(
      color: MyConstant.dark,
    );
  }

  Row BuildTotalProduct3(double total2) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShowText(
                text: 'เงินทอน : ',
                textStyle: MyConstant().h3ButtonStyle(),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: ShowText(
            text: total2 == null ? '' : total2.toString(),
            textStyle: MyConstant().h2Style(),
          ),
        ),
      ],
    );
  }

  Row BuildTotalProduct2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowFormInt(
          iconData: Icons.money,
          hint: 'จำนวนเงินลูกค้า',
          changeFunc: (p0) {
            payment = double.parse(p0);
          },
        )
      ],
    );
  }

  Row BuildTotalProduct(double total) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShowText(
                text: 'Total : ',
                textStyle: MyConstant().h3ButtonStyle(),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: ShowText(
            text: total == null ? '' : total.toString(),
            textStyle: MyConstant().h2Style(),
          ),
        ),
      ],
    );
  }

  ListView listProduct() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: sqliteModels.length,
      itemBuilder: (context, index) => Row(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: ShowText(
                text: sqliteModels[index].name,
                textStyle: MyConstant().h3Style(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ShowText(
                text: sqliteModels[index].price,
                textStyle: MyConstant().h3Style(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ShowText(
                text: sqliteModels[index].amount,
                textStyle: MyConstant().h3Style(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ShowText(
                text: sqliteModels[index].sum,
                textStyle: MyConstant().h3Style(),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Center(
                child: IconButton(
                    onPressed: () async {
                      int idSQLIte = sqliteModels[index].id!;
                      print('### You Delete idSQLite ==>> $idSQLIte');
                      await SQLite()
                          .deleteSQLiteWhereId(idSQLIte)
                          .then((value) => processReadSQLite());
                    },
                    icon: Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.red,
                    )),
              )),
        ],
      ),
    );
  }

  Container BuildHead() {
    return Container(
      decoration: BoxDecoration(color: MyConstant.light),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: ShowText(
                  text: 'ชื่อสินค้า',
                  textStyle: MyConstant().h3ButtonStyle(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: ShowText(
                  text: 'ราคา',
                  textStyle: MyConstant().h3ButtonStyle(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: ShowText(
                  text: 'จำนวน',
                  textStyle: MyConstant().h3ButtonStyle(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: ShowText(
                  text: 'ผลรวม',
                  textStyle: MyConstant().h3ButtonStyle(),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: ShowText(
                  text: 'Delete',
                  textStyle: MyConstant().h3ButtonStyle(),
                )),
          ],
        ),
      ),
    );
  }

  Padding ShowName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShowText(
        text: 'รายการสินค้า',
        textStyle: MyConstant().h2Style(),
      ),
    );
  }
}
