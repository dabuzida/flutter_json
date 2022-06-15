import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Jsonn extends StatefulWidget {
  const Jsonn({Key? key}) : super(key: key);

  @override
  State<Jsonn> createState() => _JsonnState();
}

class Json {
  late String userId;
  late String id;
  late String title;
  late String body;

  Json.fromJson(Map<String, dynamic> json) {
    userId = json['userId'].toString();
    id = json['id'].toString();
    title = json['title'];
    body = json['body'];
  }
  /* Json({required this.userId, required this.id, required this.title, required this.body});
  factory Json.fromJson(Map<String, dynamic> json) {
    return Json(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  } */
}

Future<List<Json>> fetchPost() async {
  String jsonRawData;
  List jsonList;
  List<Json> jsonTransformed;

  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  // final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  await Future.delayed(const Duration(seconds: 1));

  if (response.statusCode == 200) {
    jsonRawData = response.body;
    print('>> $jsonRawData');
    jsonList = jsonDecode(jsonRawData);
    print('>> $jsonList');
    jsonTransformed = jsonList.map((e) => Json.fromJson(e)).toList();
    print('>> $jsonTransformed');
    print('>> ${jsonTransformed.runtimeType}');

    return jsonTransformed;
  } else {
    throw Exception('Failed to load post');
  }
}

class _JsonnState extends State<Jsonn> {
  Future<List<Json>>? json;

  @override
  void initState() {
    super.initState();
    json = fetchPost(); // fetchPost 리턴은 List<Json>타입
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Json>>(
      future: json, // a previously-obtained Future<String> or null
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              controller: ScrollController(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Json json = snapshot.data![index];
                return ListTile(
                  leading: Text(json.userId),
                  title: Text(json.title),
                  subtitle: Text(json.body),
                  trailing: Text(json.id),
                );
              });
          // Text(snapshot.data.);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // 기본적으로 로딩 Spinner를 보여줍니다.
        // return const CircularProgressIndicator();
        return Center(child: Image.network('https://previews.123rf.com/images/sundatoon/sundatoon1607/sundatoon160700027/61127080-sourire-singe-gratter-la-t%C3%AAte.jpg'));
      },
    );
  }
}
