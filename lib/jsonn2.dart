import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Jsonn2 extends StatefulWidget {
  const Jsonn2({Key? key}) : super(key: key);

  @override
  State<Jsonn2> createState() => _Jsonn2State();
}

class Json {
  late String userId;
  late String id;
  late String title;
  late String body;
  // Json({required this.userId, required this.id, required this.title, required this.body});

  Json.fromJson(Map<String, dynamic> json) {
    userId = json['userId'].toString();
    id = json['id'].toString();
    title = json['title'];
    body = json['body'];
  }
}

Future<Json> fetchPost() async {
  // await Future.delayed(const Duration(seconds: 2));
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return Json.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class _Jsonn2State extends State<Jsonn2> {
  late Json jsonTransformed;
  bool flag = false;

  requestData() async {
    String jsonRawData;
    Map<String, dynamic> jsonMap;
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    await Future.delayed(const Duration(seconds: 1));
    if (response.statusCode == 200) {
      jsonRawData = response.body;
      jsonMap = jsonDecode(jsonRawData);
      jsonTransformed = Json.fromJson(jsonMap);

      // print('${jsonRawData.runtimeType} >> $jsonRawData');
      // print('${jsonMap.runtimeType} >> $jsonMap');
      // print('${jsonTransformed.runtimeType} >> $jsonTransformed');
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
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   // Here you can write your code
    //   // print('monkey');
    //   setState(() {
    //     // print('shark');
    //     // Here you can write your code for open new view
    //   });
    // });

    if (flag == false) {
      // return CircularProgressIndicator();
      return Image.network('https://img.pikbest.com/png-images/20190918/cartoon-snail-loading-loading-gif-animation_2734139.png!c1024wm0');
      // return Image.network('https://mir-s3-cdn-cf.behance.net/project_modules/fs/b6e0b072897469.5bf6e79950d23.gif');
      // https://img.pikbest.com/png-images/20190918/cartoon-snail-loading-loading-gif-animation_2734139.png!c1024wm0
    } else {
      return Center(
        child: ListTile(
          leading: Text(jsonTransformed.userId),
          title: Text(jsonTransformed.title),
          subtitle: Text(jsonTransformed.body),
          trailing: Text(jsonTransformed.id),
        ),
      );
    }
  }
}

Future<String> fetchUserOrder() => Future.delayed(const Duration(seconds: 2), () => 'Large Latte');
// Future<int> receipt() => Future.delayed(const Duration(seconds: 1), () => 81);
Future<String> createOrderMessage() async {
  var order = await fetchUserOrder();
  return 'Your order is: $order';
}
