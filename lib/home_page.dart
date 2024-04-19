import 'package:app_features/until.dart';
import 'package:app_features/updet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Home extends StatefulWidget {
  const Home({Key? key}): super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<StudentData> studentList = [];
  @override

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
      body:  SingleChildScrollView(
        child: Column(
          children: studentList.asMap().entries.map((entry) {
            final index = entry.key;
            final student = entry.value;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: FileImage(student.image),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.name,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Edit???"),
                              content: Text(
                                  "Are you sure you want to edit this Student?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text("No"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            update_data(student: student),
                                      ),
                                    ).then((editedStudent) {
                                      if (editedStudent != null &&
                                          editedStudent is StudentData) {
                                        setState(() {
                                          studentList[index] = editedStudent;
                                        });
                                      }
                                    });
                                  },
                                  child: Text("Yes"),
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
                              title: Text("Delete form"),
                              content: Text(
                                  "Are you sure you stdent from delete"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text("No"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      studentList.removeAt(index);
                                    }); // Close the dialog
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
            );
          }).toList(),
        ),
      ),
    );
  }
}
