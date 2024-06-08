import 'dart:convert';

import 'package:api/ipin/models%20ipin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ipins extends StatefulWidget {
  const ipins({super.key});

  @override
  State<ipins> createState() => _ipinsState();
}

class _ipinsState extends State<ipins> {
  Future<Ipin> fetch() async {
    var result = await http.get(Uri.parse("https://ipinfo.io/161.185.160.93/geo"));
    return Ipin.fromJson(jsonDecode(result.body));
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
                      Text(snapshot.data!.city.toString()),
                      Text(snapshot.data!.region.toString()),
                      Text(snapshot.data!.country.toString()),
                      Text(snapshot.data!.loc.toString()),
                      Text(snapshot.data!.org.toString()),
                      Text(snapshot.data!.postal.toString()),
                      Text(snapshot.data!.readme.toString()),
                      Text(snapshot.data!.timezone.toString()),

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
