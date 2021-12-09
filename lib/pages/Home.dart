// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
//to convert data in JSON
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //variáveis utilizadas para guardar a saída da requisição
  //Os sinais de interrogação permitem a possibilidade do tipo ser nulo
  //Utilizando Late para inicializar a variavel
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

  createLessons() async {
    //fazendo uma requisição http ao banco de dados (mongoDb)
    http.Response response = await http
        .get(Uri.parse('http://192.168.0.103:4000/api/lessons/create'));

    //convertendo o dado em json
    data = json.decode(response.body);
    debugPrint(response.body);
    setState(() {
      lessonsData = data['lessons'];
    });
  }

  deleteAllLessons() async {
    //fazendo uma requisição http ao banco de dados (mongoDb)
    http.Response response = await http
        .get(Uri.parse('http://192.168.0.103:4000/api/lessons/create'));

    //convertendo o dado em json
    data = json.decode(response.body);
    debugPrint(response.body);
    setState(() {
      lessonsData = data['lessons'];
    });
  }

  @override
  void initState() {
    //Por enquanto ela está sendo inicializada toda vez que o app é iniciado
    super.initState();
    getLessons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lesson List',
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        // ignore: unnecessary_null_comparison
        itemCount: lessonsData == null ? 0 : lessonsData?.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "${lessonsData?[index]["Name"]}",
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createLessons();
          getLessons();
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
