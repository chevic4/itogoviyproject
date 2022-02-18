import 'package:flutter/material.dart';

class nologinscreen extends StatelessWidget {
  const nologinscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('введен неправильный пароль'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('назад'),
        ),
      ),
    );
  }
}
