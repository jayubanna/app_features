import 'dart:io';
import 'package:app_features/until.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class update_data extends StatefulWidget {
  final StudentData student;

  const update_data({Key? key, required this.student}) : super(key: key);

  @override
  State<update_data> createState() => _update_dataState();
}

class _update_dataState extends State<update_data> {
  TextEditingController nameController = TextEditingController();
  TextEditingController grIdController = TextEditingController();
  TextEditingController stdController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController divisionController = TextEditingController();
  File? image;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.student.name;
    grIdController.text = widget.student.grId;
    stdController.text = widget.student.std;
    image = widget.student.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          "Edit Student",
          style: TextStyle(color: Colors.white),
        ),
        leading: Icon(Icons.arrow_back_ios_new_outlined),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      final imagePicker = ImagePicker();
                      final pickedImage =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                      if (pickedImage != null) {
                        setState(() {
                          image = File(pickedImage.path);
                        });
                      }
                    },
                    child: CircleAvatar(
                      backgroundImage: image != null ? FileImage(image!) : null,
                      radius: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16),
              SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: grIdController,
                decoration: InputDecoration(labelText: 'GR-ID'),
              ),
              TextField(
                controller: stdController,
                decoration: InputDecoration(labelText: 'Std'),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    StudentData editedStudent = StudentData(
                      name: nameController.text,
                      grId: grIdController.text,
                      std: stdController.text,
                      image: image ?? widget.student.image,
                    );

                    Navigator.pop(context, editedStudent);
                  },
                  child: Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}