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
  bool isVisible = true;
  File? img;

  late TextEditingController nameController;
  late TextEditingController gridController;
  late TextEditingController stdController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    gridController = TextEditingController();
    stdController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose of controllers
    nameController.dispose();
    gridController.dispose();
    stdController.dispose();
    super.dispose();
  }

  void saveData() {
    if (fKey.currentState!.validate()) {
      String name = nameController.text;
      String grid = gridController.text;
      String std = stdController.text;

      if (name.isNotEmpty && grid.isNotEmpty && std.isNotEmpty && img != null) {
        // Do something with the data
        // For example, add it to a list
        Map<String, String> data = {
          'name': name,
          'grid': grid,
          'std': std,
          'imgPath': img!.path,
        };
        Modal.g1.studentList.add(data);

        // Then, you can navigate back to the previous screen
        Navigator.pop(context);
      } else {
        print('Please fill in all fields and select an image.');
      }
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
                  XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
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
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Divider(thickness: 2),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: nameController,
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
                        controller: gridController,
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
                        controller: stdController,
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
                            Container(
                              height: 60,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue,
                              ),
                              child: InkWell(
                                onTap: saveData,
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
    nameController.clear();
    gridController.clear();
    stdController.clear();
  }

  void clearImageData() {
    nameController.clear();
    gridController.clear();
    stdController.clear();
    setState(() {
      img = null;
    });
  }
}
