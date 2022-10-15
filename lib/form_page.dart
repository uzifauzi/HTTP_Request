import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  //controller untuk mengambil nilai inputan
  TextEditingController nameC = TextEditingController();
  TextEditingController jobC = TextEditingController();

  String hasilResponse = 'Belum ada data';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP POST'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          15.0,
        ),
        child: ListView(
          children: [
            TextField(
              controller: nameC,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nama',
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: jobC,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Job',
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                var myResponse = await myhttp.post(
                    Uri.parse('https://reqres.in/api/users'),
                    body: {"name": nameC.text, "job": jobC.text});

                print(myResponse
                    .body); //bentuk masih satu kesatuan string, harus dipecah menjadi objek

                //pecah String jadi objek
                Map<String, dynamic> data =
                    json.decode(myResponse.body) as Map<String, dynamic>;

                setState(() {
                  hasilResponse = "${data['name']} - ${data['job']}";
                });
              },
              child: Text('POST DATA'),
            ),
            SizedBox(
              height: 50,
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),
            Text(hasilResponse),
          ],
        ),
      ),
    );
  }
}
