import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

import 'package:todoappi/myapp.dart';

class Patchh extends StatefulWidget {
  final String titile;
  final String content;
final int id;
   Patchh({super.key, required this.titile, required this.content, required this.id });

  @override
  State<Patchh> createState() => _PatchhState();
}

class _PatchhState extends State<Patchh> {

var titilecontroler=TextEditingController();

var contentcontroler=TextEditingController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
      titilecontroler.text=widget.titile;
    contentcontroler.text=widget.content;
  }
  Future<dynamic> patchh() async {
    String Url = "http://192.168.29.175:8080/edit_note";
 var response = await patch(Uri.parse(Url),
body:jsonEncode({"title":titilecontroler.text,"content":contentcontroler.text,"id":widget.id}));
print(response.body);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.redAccent,
      appBar: AppBar(title: Text("EDIT"), backgroundColor: Colors.black12),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                titilecontroler.text=value;
              },
              controller: titilecontroler,
                decoration: InputDecoration(
              label: Text("enter text to be edited"),
              border: OutlineInputBorder(),
            )),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextField(
                onChanged: (value) {
                  contentcontroler.text=value;
                },
                controller: contentcontroler,
                  decoration: InputDecoration(
                label: Text("enter contet to be edited"),
                border: OutlineInputBorder(),
              )),
            ),
            ElevatedButton(onPressed: (){
              patchh();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (cnxt){
                  return HomePage();
              }
              ));

            }, child: Text("save"))
            
            
           
          ],
        ),
      )),
    );
  }
}
