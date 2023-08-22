import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getx/getx.dart';
import '../model/model.dart';
import '../styles/refactor.dart';

class AddStudents extends StatelessWidget {
  AddStudents({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  String selectedPath = '';
  GetStudentDetails details = Get.put(GetStudentDetails());
  GetStudentImage images = Get.put(GetStudentImage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: appBarStyle('Add Student', Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                  onTap: () async => await images.pickImage(),
                  child: Obx(() => Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white54,
                        image: images.imagePath != null && images.imagePath.value.isNotEmpty ?
                        DecorationImage(image: FileImage(File(images.imagePath.toString()))) :
                        const DecorationImage(image: NetworkImage('https://imgs.search.brave.com/ZL3LTCZRrh3Q4t6moevHoxCDYy6bo7c-xL8l_N-cTZE/rs:fit:500:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAxLzAwLzUxLzc3/LzM2MF9GXzEwMDUx/NzcwNV9EVmhiTVFR/WktjNEhFRHZZSnhh/blhXbE1WNU1IcWVt/dC5qcGc'))

                    ),
                  ),)
                ),
              sizedBoxes(height: 10),
              textFormField(labelText: 'Name', controller: nameController),
              sizedBoxes(height: 10),
              textFormField(labelText: 'Age', controller: ageController),
              sizedBoxes(height: 10),
              textFormField(labelText: 'Batch', controller:  batchController),
              sizedBoxes(height: 10),
              textFormField(labelText: 'Number', controller: numberController),
              sizedBoxes(height: 10),
              ElevatedButton(
                onPressed: (){
                  onClickAddButton(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(10),
                ),
                child: text(text: 'Add', color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }
  void onClickAddButton(BuildContext context) {

    final image = images.imagePath;
    final name = nameController.text;
    final age = ageController.text;
    final batch = batchController.text;
    final number = numberController.text;

    if (
    image.isNotEmpty ||
        name.isNotEmpty ||
        age.isNotEmpty ||
        batch.isNotEmpty ||
        number.isNotEmpty
    ) {
      final student = StudentDetails(
          image: image.toString(),
          name: name,
          age: int.parse(age),
          batch: batch,
          number: int.parse(number)
      );

      details.addStudent(student);

      Navigator.pop(context);

      nameController.clear();
      ageController.clear();
      batchController.clear();
      numberController.clear();

      images.clearImage(image: '');

    } else {
      return;
    }
  }
}
