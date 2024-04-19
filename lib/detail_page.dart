import 'dart:io';

import 'package:app_features/until.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Detailpage extends StatefulWidget {
  const Detailpage({Key? key}) : super(key: key);

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  File? img;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController gridcontroller = TextEditingController();
  TextEditingController stdcontroller = TextEditingController();

  @override
  @override

  void saveData(BuildContext context) {
    if (img != null) {
      StudentData studentData = StudentData(
        grId: gridcontroller.text,
        name: namecontroller.text,
        std: stdcontroller.text,
        image: img!,
      );

      Navigator.pop(context, studentData);
    }
  }

  void resetData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Reset Form"),
          content: Text("Do you want to reset the form?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                clearData();
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                clearImageData();
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Detail Page",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  XFile? file = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (file != null) {
                    setState(() {
                      img = File(file.path);
                    });
                  }
                },
                child: CircleAvatar(
                  maxRadius: 100,
                  backgroundImage: img != null ? FileImage(img!) : null,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(30),
              height: 540,
              width: 400,
              decoration: BoxDecoration(
                color: Color(0xffEADDFF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Form(
                key: fKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Student Data Add",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Divider(thickness: 2),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: namecontroller,
                        decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: gridcontroller,
                        decoration: InputDecoration(
                          labelText: "Grid",
                          labelStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a grid';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: stdcontroller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Standard",
                          labelStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a standard';
                          }
                          return null;
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 60,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      resetData();
                                    },
                                    child: Text(
                                      "Reset",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                saveData(context);                               },
                              child: Container(
                                height: 60,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void clearData() {
    namecontroller.clear();
    gridcontroller.clear();
    stdcontroller.clear();
  }

  void clearImageData() {
    namecontroller.clear();
    gridcontroller.clear();
    stdcontroller.clear();
    setState(() {
      img = null;
    });
  }
}
