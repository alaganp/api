import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model nation.dart';
class nation extends StatefulWidget {
  const nation({super.key});

  @override
  State<nation> createState() => _nationState();
}

class _nationState extends State<nation> {
  Future<Nation> aaa()async{
    var result = await http.get(Uri.parse("https://api.nationalize.io?name=nathaniel"));
    return Nation.fromJson(jsonDecode(result.body));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        FutureBuilder(
            future: aaa(),
            builder: (BuildContext context, snapshot){
              if(snapshot.hasData){
                return Column(
                  children: [
                    Text(snapshot.data!.count.toString()),
                    Text(snapshot.data!.country.toString()),
                    Text(snapshot.data!.name.toString()),
                  ],
                );
              } else if(snapshot.hasError){
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }
        )
      ],),
    );
  }
}
