import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teeqrcodeoj/states/add_product.dart';
import 'package:teeqrcodeoj/states/body_history_order.dart';
import 'package:teeqrcodeoj/states/body_history_product.dart';
import 'package:teeqrcodeoj/states/body_list_product.dart';
import 'package:teeqrcodeoj/states/history_item.dart';
import 'package:teeqrcodeoj/states/history_product.dart';
import 'package:teeqrcodeoj/states/list_product.dart';
import 'package:teeqrcodeoj/states/scan_product.dart';
import 'package:teeqrcodeoj/states/show_cart.dart';
import 'package:teeqrcodeoj/utility/my_constant.dart';
import 'package:teeqrcodeoj/widgets/show_image.dart';
import 'package:teeqrcodeoj/widgets/show_text.dart';
import 'package:teeqrcodeoj/widgets/show_text_button.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  var user = FirebaseAuth.instance.currentUser;
  String? emailUser;

  var titles = <String>[
    'สแกนสินค้า',
    'ตระกร้าสินค้า',
    'สินค้าทั้งหมด',
    'เพิ่มสินค้า',
    'ประวัติทำรายการ',
    'ประวัติสินค้า',
  ];

  var pothImages = <String>[
    'images/image1.png',
    'images/image2.png',
    'images/image3.png',
    'images/image4.png',
    'images/image5.png',
    'images/image6.png',
  ];

  var widgets = <Widget>[
    const ScanProduct(),
    const ShowCart(),
    BodyProduct(),
    const AddProduct(),
    BodyOrder(),
    BodyHistoryProduct(),
  ];

  @override
  void initState() {
    super.initState();
    findUser();
  }

  void findUser() {
    setState(() {
      emailUser = user!.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.white,
      appBar: newAppBar(context),
      body: ListView(
        children: [
          ShowTitle(),
          GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: titles.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => widgets[index],
                    ));
              },
              child: Card(
                color: MyConstant.light,
                child: Column(
                  children: [
                    SizedBox(
                      width: 150,
                      child: ShowImage(
                        path: pothImages[index],
                      ),
                    ),
                    ShowText(
                      text: titles[index],
                      textStyle: MyConstant().h3Style(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ShowText ShowTitle() {
    return ShowText(
      text: 'Menu:',
      textStyle: MyConstant().h1Style(),
    );
  }

  AppBar newAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Icon(
            Icons.email_outlined,
            color: MyConstant.dark,
          ),
          const SizedBox(
            width: 5,
          ),
          ShowText(
            text: emailUser ?? '',
            textStyle: MyConstant().h2Style(),
          ),
        ],
      ),
      elevation: 0,
      backgroundColor: MyConstant.white,
      actions: [
        ShowTextButton(
          label: 'SignOut',
          pressFunc: () async {
            await FirebaseAuth.instance.signOut().then((value) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/authen', (route) => false);
            });
          },
        )
      ],
    );
  }
}
