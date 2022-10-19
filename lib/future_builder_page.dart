import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_http/models/user_model.dart';

class FutureBuilderPage extends StatelessWidget {
  //const FutureBuilderPage({super.key});

  //buat variable untuk menampung data dari API
  List<UserModel> allUser = [];

  //Buat fungsi future yg dipanggil di future builder
  Future getAllUser() async {
    try {
      //buat variable untuk menampung respon
      var response = await http.get(Uri.parse('https://reqres.in/api/users'));

      //karena response.body masih bentuk string, kita decode dulu menjadi Map
      List data = (json.decode(response.body) as Map<String, dynamic>)['data'];

      //tampilkan semua data dari database
      data.forEach((element) {
        //isikan nilai untuk variable allUser
        allUser.add(userModelFromJson(element));
      });
    } catch (e) {
      //print jika error
      print('Terjadi kesalahan');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('FUTURE BUILDER'),
        ),
        body: Center(
          child: FutureBuilder(
              future: getAllUser(),
              //fungsi snapshot : untuk mengecek apakah dia dapat data dari database/tidak
              builder: (context, snapshot) {
                //cek koneksi
                if (snapshot.connectionState == ConnectionState.waiting) {
                  //jika sedang loading data, maka return logo loading
                  return CircularProgressIndicator();
                }
                //tampilkan data dalam bentuk listtile
                return ListView.builder(
                  itemCount: allUser.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(allUser[index].avatar),
                    ),
                    title: Text(
                        "Nama lengkap: ${allUser[index].firstName} ${allUser[index].lastName}"),
                    subtitle: Text("Email : ${allUser[index].email}"),
                  ),
                );
              }),
        ));
  }
}
