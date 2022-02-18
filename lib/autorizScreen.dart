import 'package:finalproject/usercontentscreen.dart';
import 'package:flutter/material.dart';
import 'nologinerror.dart';
const keylog ='89165325904';
const keypass = '5904';
TextEditingController curlogin=TextEditingController();
TextEditingController curpass=TextEditingController();

class autorizScreen extends StatelessWidget {
  const autorizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column (children: [
            SizedBox(height: 50,),
            const SizedBox(width: 220, height: 220, child: Image(image: AssetImage('assets/image.png')),),
            SizedBox(height: 10,),
            Text('авторизация',
              style: TextStyle (fontSize: 14, color: Color.fromRGBO(0, 0, 8, 0.5)),),
            SizedBox(height: 20,),
             SizedBox(width: 300,
              child: TextField(
                controller: curlogin,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(
                      244, 239, 241, 1),
                  labelText: 'номер телефона',
                ),
              ),
            ),
            SizedBox(height: 20,),
             SizedBox(width: 300,
              child: TextField(
                controller: curpass,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(
                      244, 239, 241, 1),
                  labelText: 'пароль',
                ),
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(width: 154, height: 55, child:
            ElevatedButton (
              onPressed: () {
              if (curlogin.text==keylog && curpass.text==keypass) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UsersListPage()));
              } else {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const nologinscreen()));
                };
              },
              child: Text('Войти'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF0079D0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36.0),
                ),
              ),
            )
            ),
          ],),
        )
    );
  }
}
