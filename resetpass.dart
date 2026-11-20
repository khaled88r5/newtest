import 'package:flutter/material.dart';
import 'package:newtest/core/WIDGETS/button.dart';
import 'package:newtest/features/auth/signup/widget/customfield.dart';

class resetpass extends StatelessWidget {
  const resetpass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Center(child: Text('استعادة كلمة المرور')),
      ),
      body: Center(
        child: Container(
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Container(
                width: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'لا تقلق ، ما عليك سوى كتابة رقم هاتفك وسنرسل رمز التحقق.',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Customtextfiel(
                  hintText: 'رقم الهاتف ',
                  fillColor: const Color.fromRGBO(249, 250, 250, 1),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Custombutton(
                  txt: Text('استعادة كلمة المرور'),
                  fillColor: const Color.fromRGBO(27, 94, 55, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
