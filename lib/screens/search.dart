import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_getx/getx/getx.dart';

import '../styles/refactor.dart';
import 'detailpage.dart';


class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    details.updateData();
  }

  GetStudentDetails details = Get.put(GetStudentDetails());

  @override
  Widget build(BuildContext context) {
    final data = details.filteredList;
    return Scaffold(
      appBar: AppBar(
        title: appBarStyle('Search Students', Colors.white),
        centerTitle: true ,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
              children: [
                TextFormField(
                  onChanged: (query) {
                    details.updateSearch(query);
                  },
                  controller: searchController,
                  decoration: const InputDecoration(
                      hintText: 'Search students',
                      border: OutlineInputBorder()
                  ),
                ),
                Expanded(
                  child: Obx(() => ListView.builder(
                    itemCount: details.filteredList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DetailsPage(index: index,),)
                          );
                        },
                        child: ListTile(
                          title: Text(data[index].name),
                          // subtitle: Text(data.[index].batch),
                          trailing: IconButton(onPressed: (){
                            details.deleteStudent(index);
                          },
                              icon: const Icon(Icons.delete, color: Colors.red,)),
                        ),
                      );
                    },
                  ),)
                  
                ),
              ],
        )
      )
    );
  }
}



