import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
//to convert data in JSON
import 'dart:convert';

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //variáveis utilizadas para guardar a saída da requisição
  //Os sinais de interrogação permitem a possibilidade do tipo ser nulo
  late Map data;
  List? lessonsData;

  getLessons() async {
    //fazendo uma requisição http ao banco de dados (mongoDb)
    http.Response response =
        await http.get(Uri.parse('http://192.168.0.103:4000/api/lessons'));

    //convertendo o dado em json
    data = json.decode(response.body);
    debugPrint(response.body);
    setState(() {
      lessonsData = data['lessons'];
    });
  }

  @override
  void initState() {
    super.initState();
    getLessons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson List'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        // ignore: unnecessary_null_comparison
        itemCount: lessonsData == null ? 0 : lessonsData?.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Text("${lessonsData?[index]["Name"]}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
