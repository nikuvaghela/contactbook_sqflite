import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class picker extends StatefulWidget {
  const picker({Key? key}) : super(key: key);

  @override
  State<picker> createState() => _pickerState();
}

class _pickerState extends State<picker> {


  final ImagePicker _picker = ImagePicker();
  String imagepath = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Picture"),
      ),
      body: Column(
        children: [
          imagepath.isNotEmpty
            ? Image.file(File(imagepath),height: 100,width: 100,)
            : Icon(Icons.supervised_user_circle,size: 100,),
          OutlinedButton(onPressed: () {
            showDialog(context: context, builder: (context) {
              return SimpleDialog(
                title: Text("Select picture"),
                children: [
                  ListTile(
                title: Text("Camera"),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await _picker.pickImage(source: ImageSource.camera);

                    setState(() {
                      if(image!=null)
                        {
                          imagepath=image.path;
                        }
                    });

                },
              ),
                  ListTile(
                    title: Text("Gallery"),
                    onTap: () async {
                      Navigator.pop(context);
                      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

                      setState(() {
                        if(image!=null)
                        {
                          imagepath=image.path;
                        }
                      });

                    },
                  ),
                ],
              );
            },);
          }, child: Text("Choose File"))
        ],
      ),
    );
  }
}
