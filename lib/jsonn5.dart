import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'address.dart';
import 'user.dart';

class Jsonn5 extends StatefulWidget {
  const Jsonn5({Key? key}) : super(key: key);

  @override
  State<Jsonn5> createState() => _Jsonn5State();
}

class _Jsonn5State extends State<Jsonn5> {
 
@override
  Widget build(BuildContext context) {
    Address address = Address("My st.", "New York");
    User user = User("John", address);
    print(user.toJson());
    return Text('dd');
  }
}
