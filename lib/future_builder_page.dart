import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FutureBuilderPage extends StatelessWidget {
  const FutureBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FUTURE BUILDER'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              //get data dari url API
              var response =
                  await http.get(Uri.parse('https://reqres.in/api/users'));

              // megambil 1 data dari list
              List data =
                  (json.decode(response.body) as Map<String, dynamic>)['data'];

              data.forEach((element) {
                Map<String, dynamic> user = element;
                print(user['first_name']);
              });
            },
            child: Text(
              'get data',
            )),
      ),
    );
  }
}
