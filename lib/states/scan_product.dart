import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart';
import 'package:teeqrcodeoj/models/product_model.dart';
import 'package:teeqrcodeoj/utility/my_constant.dart';
import 'package:teeqrcodeoj/utility/my_dialog.dart';
import 'package:teeqrcodeoj/widgets/show_button.dart';
import 'package:teeqrcodeoj/widgets/show_image.dart';
import 'package:teeqrcodeoj/widgets/show_text.dart';
import 'package:teeqrcodeoj/widgets/show_text_button.dart';

class ScanProduct extends StatefulWidget {
  const ScanProduct({Key? key}) : super(key: key);

  @override
  State<ScanProduct> createState() => _ScanProductState();
}

class _ScanProductState extends State<ScanProduct> {
  ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.white,
      appBar: AppBar(
        title: ShowText(
          text: 'สแกนสินค้า',
          textStyle: MyConstant().h2Style(),
        ),
        backgroundColor: MyConstant.white,
        foregroundColor: MyConstant.dark,
        elevation: 0,
      ),
      body: ListView(
        children: [
          buttonScanCode(context: context),
          productModel == null ? const SizedBox() : contentWidget(),
        ],
      ),
    );
  }

  Widget contentWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          showContent(head: 'ชื่อ :', value: productModel!.name),
          showContent(head: 'ราคา :', value: '${productModel!.price} บาท'),
          showContent(head: 'จำนวน :', value: '${productModel!.amount}'),
          buttonAddCart(),
        ],
      ),
    );
  }

  ShowButton buttonAddCart() {
    return ShowButton(
      label: 'ใส่ตะกร้า',
      pressFunc: () {
        int amountProduct = 1;

        MyDialog(context: context).normalDialog(
            title: productModel!.name,
            subTitle: 'กรุณาเลือกจำนวนสินค้าที่ต้องการ',
            contentWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShowTextButton(
                  label: 'เพิ่ม',
                  pressFunc: () {},
                ),
                ShowText(
                  text: amountProduct.toString(),
                  textStyle: MyConstant().h1Style(),
                ),
                ShowTextButton(
                  label: 'ลด',
                  pressFunc: () {},
                )
              ],
            ));
      },
    );
  }

  Row showContent({required String head, required String value}) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: ShowText(
            text: head,
            textStyle: MyConstant().h2Style(),
          ),
        ),
        Expanded(
          flex: 2,
          child: ShowText(text: value),
        ),
      ],
    );
  }

  Row buttonScanCode({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            try {
              var result = await scan();
              if (result != null) {
                await FirebaseFirestore.instance
                    .collection('product')
                    .where('codeScan', isEqualTo: result)
                    .get()
                    .then((value) {
                  if (value.docs.isEmpty) {
                    MyDialog(context: context).normalDialog(
                        title: 'ไม่มีสินค้า ?',
                        subTitle: 'ไม่มีโค็ดสินค้านี้ในฐานข้อมูล');
                  } else {
                    for (var element in value.docs) {
                      productModel = ProductModel.fromMap(element.data());
                    }
                    setState(() {});
                  }
                });
              }
            } catch (e) {}
          },
          child: Card(
            color: MyConstant.light,
            child: Container(
              padding: const EdgeInsets.all(8),
              width: 200,
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: const ShowImage(
                path: 'images/image1.png',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
