import 'package:app_features/until.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
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
            await Navigator.pushNamed(context, "detail_page").then((value) {
              if (value != null) {
                setState(() {});
              }
            });
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
      body: ListView.builder(
        itemCount: Modal.g1.studentList.length,
        itemBuilder: (context, index) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.10,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey),
              child: Column(
                children: [
                  Text(
                    "${Modal.g1.studentList[index]["grid"]}",
                  ),
                  Text(
                    "${Modal.g1.studentList[index]["name"]}",
                  ),
                  Text(
                    "${Modal.g1.studentList[index]["standard"]}",
                  ),
                ],
              ));
        },
      ),    );
  }
}
