import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;
import 'package:my_http/form_page.dart';
import 'package:my_http/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormPage(),
    );
  }
}
