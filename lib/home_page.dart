import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_features/until.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<StudentData> studentList = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController grIdController = TextEditingController();
  TextEditingController stdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = '';
    grIdController.text = '';
    stdController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xff30BA9D),
        systemNavigationBarColor: Colors.white,
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(
          side: BorderSide(style: BorderStyle.solid, color: Colors.blue),
        ),
        onPressed: () async {
          final result = await Navigator.pushNamed(context, "detail_page");
          if (result is StudentData) {
            setState(() {
              studentList.add(result);
            });
          }
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Home Page",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: studentList.asMap().entries.map((entry) {
            final index = entry.key;
            final student = entry.value;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {

                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            XFile? file = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (file != null) {
                              setState(() {
                                student.image = File(file.path);
                              });
                            }
                          },
                          child: CircleAvatar(
                            backgroundImage: FileImage(student.image),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  student.name,
                                  style: TextStyle(color: Colors.white,fontSize: 20),
                                ),
                                Text("GrId: ${student.grId}   |  Std: ${student.std}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          TextEditingController studentNameController = TextEditingController(text: studentList[index].name);
                          TextEditingController studentGridController = TextEditingController(text: studentList[index].grId);
                          TextEditingController studentStdController = TextEditingController(text: studentList[index].std);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Center(child: Text("Edit Student")),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextField(
                                        controller: studentNameController,
                                        decoration: InputDecoration(labelText: 'Name'),
                                      ),
                                      TextField(
                                        controller: studentGridController,
                                        decoration: InputDecoration(labelText: 'GR-ID'),
                                      ),
                                      TextField(
                                        controller: studentStdController,
                                        decoration: InputDecoration(labelText: 'Std'),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      StudentData editedStudent = StudentData(
                                        image: studentList[index].image,
                                        name: studentNameController.text,
                                        grId: studentGridController.text,
                                        std: studentStdController.text,
                                      );

                                      setState(() {
                                        studentList[index] = editedStudent;
                                      });

                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Save"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.edit, color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Delete Student"),
                                content: Text("Are you sure you want to delete this student?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("No"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        studentList.removeAt(index);
                                      });
                                    },
                                    child: Text("Yes"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
