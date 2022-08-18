import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';
import 'model/transaction_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText2: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
        ),
      ),
      home: const Homw(),
    );
  }
}

class Homw extends StatefulWidget {
  const Homw({Key? key}) : super(key: key);

  @override
  State<Homw> createState() => _HomwState();
}

class _HomwState extends State<Homw> {
  final List<TranscationModel> _userTransactions = [
    TranscationModel(
        id: '01', title: 'New Shoes', amount: 160, date: DateTime.now()),
    TranscationModel(
        id: '02', title: 'New Shocks', amount: 150, date: DateTime.now()),
  ];

  void _addTransaction(String? title, double? amount) {
    final newTx = TranscationModel(
      id: DateTime.now().toString(),
      title: title!,
      amount: amount!,
      date: DateTime.now(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  Future _startAddnewTransaction(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (contx) {
        return NewTransaction(
          AddTransaction: _addTransaction,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Personal Expenses'),
        actions: [
          IconButton(
            onPressed: () => _startAddnewTransaction(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: const Card(
              child: Text('CHART !'),
            ),
          ),
          TransactionList(transactions: _userTransactions),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddnewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
