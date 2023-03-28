import 'dart:convert'as convert;
import 'dart:convert';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:todoappi/page1.dart';
import 'package:todoappi/patch.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<dynamic> todoapi() async {
    String Url = "http://192.168.29.175:8080/get_notes";
    var response = await get(Uri.parse(Url));

    print(response.body);

    var msg = jsonDecode(response.body)["message"];
    print(msg);
    return msg;
  }

  Future<dynamic> deleteele(int id) async {
    String Url = "http://192.168.29.175:8080/remove_note";
    print(id);
    var response = await delete(Uri.parse(Url), body: jsonEncode({"id": id}));

    print(response.body);
    var _delt = jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    todoapi();
    return Scaffold(
      appBar: AppBar(title: Text("NOTE"), backgroundColor: Colors.orange),
      body: SafeArea(
        child: FutureBuilder(
          future: todoapi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {;
                    return Padding(
                      padding: EdgeInsets.all(20),
                      child: SizedBox(
                        width: 250,
                        height: 170,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(179, 255, 250, 119),
                          ),
                          // height: 56,si
                          // width: 57,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (cnxt) {
                                      return Patchh(
                                          titile: snapshot.data[index]['title'],
                                          content: snapshot.data[index]
                                              ['content'],
                                              id:snapshot.data[index]['id']);
                                    }));
                                  },
                                  icon: Icon(Icons.edit)),
                              Text('titile: ${snapshot.data[index]['title']}'),
                              Text(
                                  'content: ${snapshot.data[index]['content']}'),
                              IconButton(
                                icon: Icon(Icons.delete_forever),
                                color: Colors.black54,
                                onPressed: () {
                                  print('clicked');

                                  setState(() {
                                    deleteele(snapshot.data[index]['id']);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: Text("SOMETHING WENT WRONG"));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (cntxt) {
              return Home1();
            }));
          },
          child: Icon(Icons.add_card_outlined, color: Colors.white54)),
    );
  }
}
