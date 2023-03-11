import 'package:database/model.dart';
import 'package:database/updatepage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:database/insert.dart';





class viewpage extends StatefulWidget {
  const viewpage({Key? key}) : super(key: key);

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  Database? db;
  List<Map> l =[];
  bool status =false;


  @override
  void initState() {
    super.initState();
    //Read and select
    model().createdatabase().then((value) {
      db =value;
      String qry ="select * from contactbook";
      db!.rawQuery(qry).then((value1) {
        l=value1;
        print(l);
        setState(() {
          status=true;
        });
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("All contact")),
      ),
      body:

        status ? (l.length>0 ?
          ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
            Map map =l[index];
            String name =map['name'];
            String contact =map['contact'];

            int id=map['id'];
            return ListTile(

              title: Text("${name}"),
              subtitle: Text("${contact}"),
              onLongPress:() {
                showDialog(context: context, builder: (context) {
                  return SimpleDialog(
                    title: Text("Selectchoice"),
                    children: [
                      ListTile(
                        title: Text("Update"),
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return updatepage(map);
                          },));
                        },
                      )
                    ],
                  );
                },);
              },
            );
          },)
      :Center(
        child: Text("No data found ")))
          :Center(child: CircularProgressIndicator()),

      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return insert();
        },));
      },child: Icon(Icons.add),),
    );
  }
}
