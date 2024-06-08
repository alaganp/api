import 'dart:convert';

import 'package:api/ipify/model%20ipify.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ipify extends StatefulWidget {
  const ipify({super.key});

  @override
  State<ipify> createState() => _ipifyState();
}

class _ipifyState extends State<ipify> {
  Future<Ipify> fetch() async {
    var result = await http.get(Uri.parse("https://api.ipify.org?format=json"));
    return Ipify.fromJson(jsonDecode(result.body));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: fetch(),
              builder: (BuildContext context, snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: [

                      Text(snapshot.data!.ip.toString()),
                    ],
                  );
                } else if(snapshot.hasError){
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              }
          )
        ],
      ),
    );
  }
}
