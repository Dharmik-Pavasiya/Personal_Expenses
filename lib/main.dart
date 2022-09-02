import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';

import 'model/transaction_model.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

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
        errorColor: Colors.red,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              labelLarge: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                labelLarge: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 100,
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
    // TranscationModel(
    //     id: '01', title: 'New Shoes', amount: 160, date: DateTime.now()),
    // TranscationModel(
    //     id: '02', title: 'New Shocks', amount: 150, date: DateTime.now()),
    // TranscationModel(
    //     id: '01', title: 'New Shoes', amount: 160, date: DateTime.now()),
    // TranscationModel(
    //     id: '02', title: 'New Shocks', amount: 150, date: DateTime.now()),
    // TranscationModel(
    //     id: '01', title: 'New Shoes', amount: 160, date: DateTime.now()),
    // TranscationModel(
    //     id: '02', title: 'New Shocks', amount: 150, date: DateTime.now()),
    // TranscationModel(
    //     id: '01', title: 'New Shoes', amount: 160, date: DateTime.now()),
    // TranscationModel(
    //     id: '02', title: 'New Shocks', amount: 150, date: DateTime.now()),
  ];

  List<TranscationModel> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String? title, double? amount, DateTime date) {
    final newTx = TranscationModel(
      id: DateTime.now().toString(),
      title: title!,
      amount: amount!,
      date: date,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  bool _showChart = false;

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

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text('Personal Expenses'),
      actions: [
        IconButton(
          onPressed: () => _startAddnewTransaction(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );
    final txListWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.79,
      child: TransactionList(
          transactions: _userTransactions, deleteTx: _deleteTransaction),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(
                        () {
                          _showChart = val;
                        },
                      );
                    },
                  )
                ],
              ),
            if (!isLandscape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(recentTransaction: _recentTransaction),
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(recentTransaction: _recentTransaction),
                    )
                  : txListWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddnewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
