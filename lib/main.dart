import 'package:flutter/material.dart';
import './model/transaction_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  List<TranscationModel> transcations = [
    TranscationModel(id: '01', title: 'New Shoes', amount: 1600, date: DateTime.now()),
    TranscationModel(id: '02', title: 'New Shocks', amount: 150, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Column(
          children: transcations.map(
              (tx){
                return Card(
                  child: ListTile(
                    leading: Text('${tx.amount}'),
                    title: Text(tx.title),
                    trailing: Text('${tx.date}'),
                  ),
                );
              }
          ).toList(),
        ),
      ),
    );
  }
}
