import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //create variable untuk menampilkan object
  late String id;
  late String email;
  late String name;

  @override
  void initState() {
    // TODO: implement initState

    id = '';
    email = '';
    name = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP GET'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nama : $name',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Id : $id',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Email : $email',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var myResponse = await myhttp
                    .get(Uri.parse('https://reqres.in/api/users/2'));
                if (myResponse.statusCode == 200) {
                  //jika berhasil get data
                  print('Berhasil get data');
                  //pecah data dari string menjadi object
                  Map<String, dynamic> data =
                      json.decode(myResponse.body) as Map<String, dynamic>;
                  setState(() {
                    print(data['data']);
                    name =
                        '${data['data']['first_name']} ${data['data']['last_name']}';
                    id = data['data']['id'].toString();
                    email = data['data']['email'].toString();
                  });
                } else {
                  //jika error
                  print('ERROR ${myResponse.statusCode}');
                }
              },
              child: Text(
                'GET DATA',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
