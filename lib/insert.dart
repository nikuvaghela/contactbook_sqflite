import 'package:database/model.dart';
import 'package:database/viewpage.dart';
import 'package:flutter/material.dart';


import 'package:sqflite/sqflite.dart';


class insert extends StatefulWidget {
  const insert({Key? key}) : super(key: key);

  @override
  State<insert> createState() => _insertState();
}

class _insertState extends State<insert> {
  TextEditingController tname=TextEditingController();
  TextEditingController tcontact=TextEditingController();

  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initDatabase();  // to initialize database
  }

  initDatabase() async {
    db = await model().createdatabase(); // get the database value return by following function
  }
  Future<bool> goback()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return viewpage();
    },));
    return Future.value();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create contact"),
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return viewpage();
          },));
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: tname,
              
            ),
          ),
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
        controller: tcontact,
    ),
    ),
          ElevatedButton(onPressed: () async{
            String name =tname.text;
            String contact=tcontact.text;
            String qry = "insert into contactbook(name,contact) values ('$name','$contact')";
            int a = await db!.rawInsert(qry);
            print("id :$a");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return viewpage();
            },));
          }, child: Text("SAVE"),)
        ],
      ),

    );
  }
}
