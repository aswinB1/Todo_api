import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:todoappi/myapp.dart';

class Home1 extends StatelessWidget {
  Home1({super.key});

  Future<dynamic> todoapi() async {
    String Url = "http://192.168.29.175:8080/add_note";
    
    var response = await post(Uri.parse(Url),
        body: jsonEncode({"title": addtittle, "content": addcontent}));
    print(response.body);

    var added = jsonDecode(response.body);
    print(added);
  }

  var addtittle;

  var addcontent; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        
        mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
                label: Text(
              "Title",
              selectionColor: Colors.black,
            )),
            onChanged: (value) {
              addtittle = value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
                label: Text(
              "Content",
              selectionColor: Colors.black,
            )),
            onChanged: (value) {
              addcontent = value;
            },
          ),
        ),
        
            FloatingActionButton(onPressed: (() {
              
               todoapi();
       backgroundColor:Colors.yellow;
       Icon(Icons.bookmarks_outlined);
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (value) {
                  return HomePage();
                  
                }
              ));
            }
            )),  
      ]),
    );
  }
}
