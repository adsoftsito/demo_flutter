import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ia_model/models/predictions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url = Uri.parse("https://resnet-service-leo-oh.cloud.okteto.net/v1/models/leo_oh_linear_model:predict");
  final headers = {"Content-Type": "application/json;charset=UTF-8"};
  late Future<Predictions> prediction;
  final value_to_predict = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leo-Oh! LinearModel App'),
      ),
      body: Center(
        child: Container(
          child: Text('Linear model'),

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showForm,
        child: const Icon(Icons.add),
      ),
    );
  }

  void showForm() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Hacer prediccion"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: value_to_predict,
                  decoration: const InputDecoration(hintText: "Value prediction"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () {
                  sendPrediction();
                  Navigator.of(context).pop();
                },
                child: const Text("Prediction"),
              )
            ],
          );
        });
  }

  void sendPrediction() async {
    var value = double.parse(value_to_predict.text);
    List<double> list_predictions=[];
    list_predictions.add(value);
    final prediction_instance = {"instances": [
        list_predictions
    ] };

    final res = await http.post(url, headers: headers, body: jsonEncode(prediction_instance));
    print(jsonEncode(prediction_instance));
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      print(json);

      final Predictions predictions = Predictions.fromJson(json);

      print(predictions.predictions );

    }
    //return Future.error('No fue posible enviar la predicción');
  }

}
