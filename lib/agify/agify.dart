import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'agify modal.dart';
class agifys extends StatefulWidget {
  const agifys({super.key});

  @override
  State<agifys> createState() => _agifysState();
}

class _agifysState extends State<agifys> {
  Future<Agify> none() async{
    var result = await http.get(Uri.parse("https://api.agify.io?name=meelad"));
    return Agify.fromJson(jsonDecode(result.body));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        FutureBuilder(
            future:none(),
            builder: (BuildContext context, snapshot){
              if(snapshot.hasData){
                return Column(
                  children: [
                    Text(snapshot.data!.count.toString()),
                    Text(snapshot.data!.name.toString()),
                    Text(snapshot.data!.age.toString())
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
