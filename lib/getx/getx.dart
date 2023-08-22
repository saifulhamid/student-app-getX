import 'dart:core';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/model.dart';

class GetStudentDetails extends GetxController{

  RxList studentList = <StudentDetails>[].obs;
  RxList filteredList = <StudentDetails>[].obs;

  addStudent(StudentDetails values) {
    studentList.add(values);
  }

  void deleteStudent(int index) {
    studentList.removeAt(index);
  }

  void updateStudent(int index, StudentDetails values) {
    studentList.removeAt(index);
    studentList.insert(index, values);

  }

  void updateData() {
    if (filteredList.isEmpty) {
      filteredList = RxList.from(studentList);
    }
  }

  void updateSearch(String query) {
    if (query.isEmpty) {
      filteredList = RxList.from(studentList);
    } else {
      filteredList.clear();
      filteredList.addAll(
          studentList.where((student) =>
              student.name.toLowerCase()
                  .contains(query.toLowerCase())
          ),
      );
    }
  }

}

class GetStudentImage extends GetxController {


  RxList studentList = <StudentDetails>[].obs;
  RxString imagePath = ''.obs;
  Future<void> pickImage() async {
    ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null) {
      imagePath.value = image.path.toString();
    }
  }

  Future<void> clearImage({image}) async {
    imagePath.value = image;
  }



}