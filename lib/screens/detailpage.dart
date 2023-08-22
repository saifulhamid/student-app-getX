import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_getx/screens/editstudent.dart';
import '../getx/getx.dart';
import '../styles/refactor.dart';

class DetailsPage extends StatelessWidget {
  final int index;
  DetailsPage({super.key, required this.index});

  GetStudentDetails details = Get.put(GetStudentDetails());

  @override
  Widget build(BuildContext context) {
    final data = details.studentList[index];
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white,)
          ),
          title: appBarStyle('Student Details', Colors.white),
          centerTitle: true,
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: (){
                  Get.to(EditStudents(index: index));
                },
                icon: Icon(Icons.edit, color: Colors.white,)
            )
          ],
        ),
        body: Column(
              children: [
                sizedBoxes(height: 50),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: Colors.blueGrey,
                      image: DecorationImage(
                          image: FileImage(File(data.image))
                      )
                  ),
                ),
                sizedBoxes(height: 30),
                detailsPageText(text: data.name, fontSize: 40, fontWeight: FontWeight.bold),
                sizedBoxes(height: 10),
                detailsPageText(text: data.age.toString(), fontSize: 20),
                sizedBoxes(height: 10),
                detailsPageText(text: data.batch, fontSize: 20),
                sizedBoxes(height: 10),
                detailsPageText(text: data.number.toString(), fontSize: 20)
              ],
            )

    );
  }
}
