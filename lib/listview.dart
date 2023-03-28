import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';


class Listuser extends StatelessWidget {
  Listuser({super.key});

  // Map<String, dynamic> result = {
  //   "page": 2,
  //   "per_page": 6,
  //   "total": 12,
  //   "total_pages": 2,
  //   "data": [
  //     {
  //       "id": 7,
  //       "email": "michael.lawson@reqres.in",
  //       "first_name": "Michael",
  //       "last_name": "Lawson",
  //       "avatar": "https://reqres.in/img/faces/7-image.jpg"
  //     },
  //     {
  //       "id": 8,
  //       "email": "lindsay.ferguson@reqres.in",
  //       "first_name": "Lindsay",
  //       "last_name": "Ferguson",
  //       "avatar": "https://reqres.in/img/faces/8-image.jpg"
  //     },
  //     {
  //       "id": 9,
  //       "email": "tobias.funke@reqres.in",
  //       "first_name": "Tobias",
  //       "last_name": "Funke",
  //       "avatar": "https://reqres.in/img/faces/9-image.jpg"
  //     },
  //     {
  //       "id": 10,
  //       "email": "byron.fields@reqres.in",
  //       "first_name": "Byron",
  //       "last_name": "Fields",
  //       "avatar": "https://reqres.in/img/faces/10-image.jpg"
  //     },
  //     {
  //       "id": 11,
  //       "email": "george.edwards@reqres.in",
  //       "first_name": "George",
  //       "last_name": "Edwards",
  //       "avatar": "https://reqres.in/img/faces/11-image.jpg"
  //     },
  //     {
  //       "id": 12,
  //       "email": "rachel.howell@reqres.in",
  //       "first_name": "Rachel",
  //       "last_name": "Howell",
  //       "avatar": "https://reqres.in/img/faces/12-image.jpg"
  //     }
  //   ],
  //   "support": {
  //     "url": "https://reqres.in/#support-heading",
  //     "text":
  //         "To keep ReqRes free, contributions towards server costs are appreciated!"
  //   }
  // };
  Future<dynamic> userinfo() async {
    String Url = 'https://reqres.in/api/users?page=2';
    var response = await get(Uri.parse(Url));
    print(response.body);
    var userinfo = jsonDecode(response.body)['data'];
    return userinfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: userinfo(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting){
                    Future.delayed(Duration(seconds: 2));
                    return Center(child: CircularProgressIndicator());
                    Colors.cyan;
                    
                  }else if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(snapshot.data![index]['avatar']),
                          ),
                          trailing: Text(snapshot.data[index]['last_name']),
                          title: Text(
                            snapshot.data[index]['first_name'],
                            style: TextStyle(color: Colors.indigo),
                          ),
                        );
                      },
                    );
                  }else{
                    return Text("Errorr");
                  }
                    
                })),
          )
        ],
      ),
    );
  }
}
