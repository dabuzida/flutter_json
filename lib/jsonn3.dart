import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Jsonn3 extends StatefulWidget {
  const Jsonn3({Key? key}) : super(key: key);

  @override
  State<Jsonn3> createState() => _Jsonn3State();
}

class Json {
  late String userId;
  late String id;
  late String title;
  late String body;
  // Json({required this.userId, required this.id, required this.title, required this.body});
  Json.fromJson(Map<String, dynamic> json)
      : userId = json['userId'].toString(),
        id = json['id'].toString(),
        title = json['title'],
        body = json['body'];
}

class _Jsonn3State extends State<Jsonn3> {
  late List<Json> jsonTransformed;
  bool flag = false;
  ScrollController _scrollController = ScrollController();

  requestData() async {
    String jsonRawData;
    List jsonList;
    final res = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    // await Future.delayed(const Duration(seconds: 1));
    if (res.statusCode == 200) {
      jsonRawData = res.body;
      jsonList = jsonDecode(jsonRawData);
      print(jsonList.map((e) => Json.fromJson(e)));
      jsonTransformed = jsonList.map((e) => Json.fromJson(e)).toList();
      // print('$jsonRawData');
      // print('${jsonRawData.runtimeType}');
      // print('$jsonList');
      print('${jsonRawData.runtimeType} >> $jsonRawData');
      print('${jsonList.runtimeType} >> $jsonList');
      print('${jsonTransformed.runtimeType} >> $jsonTransformed');
      setState(() {
        flag = true;
      });
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    super.initState();
    requestData();
  }

  @override
  Widget build(BuildContext context) {
    if (flag == false) {
      return Center(child: Image.network('https://c.tenor.com/7NX24XoJX0MAAAAC/loading-fast.gif'));
    } else {
      return ListView.builder(
        controller: _scrollController,
        itemCount: jsonTransformed.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(jsonTransformed[index].userId),
            title: Text(jsonTransformed[index].title),
            subtitle: Text(jsonTransformed[index].body),
            trailing: Text(jsonTransformed[index].id),
          );
        },
      );
    }
  }
}
