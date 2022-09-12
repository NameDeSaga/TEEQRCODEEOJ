import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teeqrcodeoj/utility/my_constant.dart';

import 'package:teeqrcodeoj/widgets/show_text.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({Key? key}) : super(key: key);

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  TextEditingController barCodeTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController priceTextEditingController = TextEditingController();
  TextEditingController amountTextEditingController = TextEditingController();

  get index => null;

  _buildTextField(TextEditingController controller, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          color: MyConstant.white, border: Border.all(color: Colors.black)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            border: InputBorder.none),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.white,
      appBar: AppBar(
        title: ShowText(
          text: 'สินค้าทั้งหมด',
          textStyle: MyConstant().h2Style(),
        ),
        backgroundColor: MyConstant.white,
        foregroundColor: MyConstant.dark,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('product').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Container(
                child: ListTile(
                  leading: IconButton(
                      onPressed: () {
                        barCodeTextEditingController.text =
                            document['codeScan'];
                        nameTextEditingController.text = document['name'];
                        priceTextEditingController.text =
                            document['price'].toString();
                        amountTextEditingController.text =
                            document['amount'].toString();
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  child: Container(
                                    color: Color.fromARGB(255, 220, 220, 220),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          _buildTextField(
                                              barCodeTextEditingController,
                                              'บาร์โค้ด'),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          _buildTextField(
                                              nameTextEditingController,
                                              'ชื่อ'),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          _buildTextField(
                                              priceTextEditingController,
                                              'ราคา'),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          _buildTextField(
                                              amountTextEditingController,
                                              'จำนวน'),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              /*snapshot.data.document[index]
                                                  .reference
                                                  .updateData({
                                                'codeScan':
                                                    barCodeTextEditingController
                                                        .text,
                                                'name':
                                                    barCodeTextEditingController
                                                        .text,
                                                'price':
                                                    barCodeTextEditingController
                                                        .text,
                                                'amount':
                                                    barCodeTextEditingController
                                                        .text,
                                              });*/
                                            },
                                            child: Text('แก้ไขสินค้า'),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: Text('ลบสินค้า'),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12), // <-- Radius
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                      },
                      icon: Icon(
                        Icons.edit,
                        color: MyConstant.dark,
                      )),
                /*  title: Text(document['name']),
                  subtitle: Column(
                    children: <Widget>[
                      Text(document['amount'].toString()),
                      Text(document['price'].toString(),
                          style: TextStyle(color: MyConstant.actlve)),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),*/
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
