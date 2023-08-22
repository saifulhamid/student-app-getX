import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_getx/screens/addstudent.dart';
import 'package:student_app_getx/screens/detailpage.dart';
import 'package:student_app_getx/screens/search.dart';
import '../getx/getx.dart';
import '../styles/refactor.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final GetStudentDetails details = Get.put(GetStudentDetails());

  @override
  Widget build(BuildContext context) {
    final studentList = details.studentList;
    return Scaffold(
      appBar: AppBar(
        title: appBarStyle('Student List', Colors.white),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => Get.to(SearchPage()),
            icon: const Icon(Icons.search, color: Colors.white, size: 30),
          ),
          sizedBoxes(width: 20)
        ],
      ),
      body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Obx(() => ListView.builder(
                itemCount: details.studentList.length,
                itemBuilder: (context, index) {
                  final data = studentList[index];
                  return GestureDetector(
                    onTap: (){
                      Get.to(DetailsPage(index: index));
                    },
                    child: ListTile(
                      title: Text(data.name),
                      subtitle: Text(data.batch),
                      trailing: IconButton(onPressed: (){
                        details.deleteStudent(index);
                      },
                      icon: const Icon(Icons.delete, color: Colors.red,)),
                    ),

                  );

                }),)
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(AddStudents()),
          //     Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => AddStudents(),)),
          child: Icon(Icons.add)

      ),
    );

  }
}
