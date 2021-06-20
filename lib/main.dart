import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
void main()=>runApp(MiApp());
class MiApp extends StatelessWidget {
  const MiApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mi App 2",
      home: Inicio(),
    );
  }
}
class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  
  Future <List<Info>>getData() async {
  var response = await http.get(
    Uri.parse("https://jsonplaceholder.typicode.com/comments"),
    headers: {"Accept":"Application/json"}
  );
  var data=json.decode(response.body);
  print(data);
  List<Info> infos=[];
  for(var p in data){
    Info info=Info(p["name"], p["email"], p["id"]);
    infos.add(info);
  }
  print(infos.length);
  return infos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title:Text("Victor App")
    ),
    body: Container(
      child: FutureBuilder(
        future: getData(),
        builder: (BuildContext  context, AsyncSnapshot snapshot) {
          print(snapshot.data);
          if(snapshot.data == null){
            return Container(child: Center(child: Text("Cargando..."),),);
          }
          else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int id){
                return ListTile(title:Text(snapshot.data[id].name),
                subtitle: Text(snapshot.data[id].email.toString()),
                );

              },
               );
          }
        },
      ) ,
      )
    );
  }
}

class Info {
  final String name;
  final String email;
  final int id;

  Info (this.name, this.email, this.id);
}