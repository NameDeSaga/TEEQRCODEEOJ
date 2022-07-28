import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teeqrcodeoj/utility/my_constant.dart';
import 'package:teeqrcodeoj/utility/my_dialog.dart';
import 'package:teeqrcodeoj/widgets/show_button.dart';
import 'package:teeqrcodeoj/widgets/show_form.dart';
import 'package:teeqrcodeoj/widgets/show_image.dart';
import 'package:teeqrcodeoj/widgets/show_text.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textLogin(),
            imageLogo(),
            formUser(),
            formPassword(),
            buttonLogin()
          ],
        ),
      ),
    );
  }

  ShowButton buttonLogin() {
    return ShowButton(
      label: 'Login',
      pressFunc: () async {
        if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
          MyDialog(context: context).normalDialog(
              title: 'มีช่องว่าง ?', subTitle: 'กรุณากรองให้ถูกต้องด้วย ค่ะ');
        } else {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: user!, password: password!)
              .then((value) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/mainHome', (route) => false);
          }).catchError((value) {
            MyDialog(context: context)
                .normalDialog(title: value.code, subTitle: value.message);
          });
        }
      },
    );
  }

  ShowForm formPassword() {
    return ShowForm(
      iconData: Icons.lock_outline,
      hint: 'Password:',
      ChangeFunc: (p0) {
        password = p0.trim();
      },
    );
  }

  ShowForm formUser() {
    return ShowForm(
      iconData: Icons.perm_identity,
      hint: 'User:',
      ChangeFunc: (p0) {
        user = p0.trim();
      },
    );
  }

  SizedBox imageLogo() {
    return SizedBox(
      width: 200,
      child: ShowImage(),
    );
  }

  ShowText textLogin() {
    return ShowText(
      text: 'Login',
      textStyle: MyConstant().h1Style(),
    );
  }
}
