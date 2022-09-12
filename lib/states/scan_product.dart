import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart';
import 'package:teeqrcodeoj/models/product_model.dart';
import 'package:teeqrcodeoj/models/sqlite_model.dart';
import 'package:teeqrcodeoj/states/main_home.dart';
import 'package:teeqrcodeoj/states/show_cart.dart';
import 'package:teeqrcodeoj/utility/my_constant.dart';
import 'package:teeqrcodeoj/utility/my_dialog.dart';
import 'package:teeqrcodeoj/utility/sqlite.dart';
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
  int amountProduct = 1;
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          showContent(head: 'บาร์โค็ด', value: productModel!.codeScan),
          showContent(head: 'ชื่อ :', value: productModel!.name),
          showContent(head: 'ราคา :', value: '${productModel!.price} บาท'),
          showContent(head: 'จำนวน :', value: '${productModel!.amount}'),
          ShowText(
            text: 'ใส่จำนำสินค้า',
            textStyle: MyConstant().h2Style(),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                if (productModel!.amount != amountProduct) {
                  setState(() {
                    amountProduct++;
                  });
                }
              });
            },
            icon: Icon(
              Icons.add_circle,
              color: MyConstant.dark,
            ),
          ),
          ShowText(
            text: amountProduct.toString(),
            textStyle: MyConstant().h1Style(),
          ),
          IconButton(
            onPressed: () {
              if (amountProduct != 1) {
                setState(() {
                  amountProduct--;
                });
              }
            },
            icon: Icon(
              Icons.do_not_disturb_on,
              color: MyConstant.dark,
            ),
          ),
          buttonAddCart(),
        ],
      ),
    );
  }

  ElevatedButton buttonAddCart() {
    return ElevatedButton(
      onPressed: () async {
        Navigator.pop(context);
        String idProduct = productModel!.codeScan;
        String name = productModel!.name;
        String price = productModel!.price.toString();
        String amount = amountProduct.toString();
        double sumInt = double.parse(price) * double.parse(amount);
        String sum = sumInt.toString();
        print(
            '### codeScan ==>> $idProduct,name ==>> $name,price ==>> $price, amount ==>> $amount,sum ==>> $sum');
        SQLiteModel sqLiteModel = SQLiteModel(
            idProduct: idProduct,
            name: name,
            price: price,
            amount: amount,
            sum: sum);

        await SQLite().insertValueToSQLite(sqLiteModel).then((value) =>
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ShowCart())));
      },
      child: Text('ใส่ตะกร้าสินค้า'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
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
