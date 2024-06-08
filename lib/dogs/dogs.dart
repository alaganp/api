import 'dart:convert';

import 'package:api/dogs/dogs%20models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class dogs extends StatefulWidget {
  const dogs({super.key});

  @override
  State<dogs> createState() => _dogsState();
}

class _dogsState extends State<dogs> {
  Future<Dogs>zzz()async{
    var result = await http.get(Uri.parse("https://dog.ceo/api/breeds/image/random"));
    return Dogs.fromJson(jsonDecode(result.body));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: zzz(),
              builder: (BuildContext context, snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: [
                      Text(snapshot.data!.message.toString()),
                      Text(snapshot.data!.status.toString()),
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
