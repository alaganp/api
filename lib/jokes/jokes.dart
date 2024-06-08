import 'dart:convert';

import 'package:api/jokes/model%20joke.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class joke extends StatefulWidget {
  const joke({super.key});

  @override
  State<joke> createState() => _jokeState();
}

class _jokeState extends State<joke> {
  Future<Joke> fetch() async {
    var result = await http.get(Uri.parse("https://official-joke-api.appspot.com/random_joke"));
    return Joke.fromJson(jsonDecode(result.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
          FutureBuilder(
          future: fetch(),
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData){
          return Column(
            children: [
              Text(snapshot.data!.punchline.toString()),
              Text(snapshot.data!.type.toString()),
              Text(snapshot.data!.setup.toString()),
              Text(snapshot.data!.id.toString()),
            ],
          );
        } else if(snapshot.hasError){
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      })
      ],),
    );
  }
}
