import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model coin.dart';
class coin extends StatefulWidget {
  const coin({super.key});

  @override
  State<coin> createState() => _coinState();
}

class _coinState extends State<coin> {
  Future<Coin> abc()async{
    var result = await http.get(Uri.parse("https://api.coindesk.com/v1/bpi/currentprice.json"));
    return Coin.fromJson(jsonDecode(result.body));
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
      Column(children: [
        FutureBuilder(
            future: abc(),
            builder: (BuildContext context, snapshot){
              if(snapshot.hasData){
                return Column(
                  children: [
                    Text(snapshot.data!.time.toString()),
                    Text(snapshot.data!.disclaimer.toString()),
                    Text(snapshot.data!.bpi.toString()),
                    Text(snapshot.data!.chartName.toString()),
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
