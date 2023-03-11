import 'package:database/viewpage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'Model.dart';

class updatepage extends StatefulWidget {
  Map map;

  updatepage(this.map);


  @override
  State<updatepage> createState() => _updatepageState();
}

class _updatepageState extends State<updatepage> {
  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();

  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tname.text = widget.map['name'];
    tcontact.text = widget.map['contact'];

    model().createdatabase().then((value) {
      db = value;
    });
  }

  Future<bool> goback()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return viewpage();
      },
    ));
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(
        title: Text("Create Contact"),
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return viewpage();
            },
          ));
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: ListView(
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
          ElevatedButton(
              onPressed: () {
                String newname = tname.text;
                String newcontact = tcontact.text;

                int id = widget.map['id'];

                String qry =
                    "update contactbook set name='$newname',contact='$newcontact' where id='$id'";
                db!.rawUpdate(qry).then((value) {
                  print(value);

                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return viewpage();
                    },
                  ));
                });
              },
              child: Text("Update"))
        ],
      ),
    ), onWillPop: goback);
  }
}

