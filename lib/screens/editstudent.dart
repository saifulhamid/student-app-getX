import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getx/getx.dart';
import '../model/model.dart';
import '../styles/refactor.dart';

class EditStudents extends StatelessWidget {
  final index;
  EditStudents({super.key, required this.index});

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  GetStudentDetails details = Get.put(GetStudentDetails());
  GetStudentImage image = Get.put(GetStudentImage());

  RxString selectedPath = ''.obs;

  @override
  Widget build(BuildContext context) {
    final data = details.studentList;
    final imagePath = details.studentList[index].image;
    nameController.text = data[index].name;
    ageController.text = data[index].age.toString();
    batchController.text = data[index].batch;
    numberController.text = data[index].number.toString();
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
              Obx(() => GestureDetector(
                onTap: () async {
                  await image.pickImage();
                  selectedPath = image.imagePath;
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      image: selectedPath.isNotEmpty
                          ? DecorationImage(image: FileImage(File(selectedPath.toString())))
                          : DecorationImage(image: FileImage(File(imagePath)))
                  ),
                ),
              ),),
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
                child: text(text: 'Update', color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }
  void onClickAddButton(BuildContext context) {
    final image = selectedPath;
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

      details.updateStudent(index, student);


      Navigator.pop(context);

      nameController.clear();
      ageController.clear();
      batchController.clear();
      numberController.clear();
      // studentImage.clearImage(image: null);

    } else {
      return;
    }

  }
}
