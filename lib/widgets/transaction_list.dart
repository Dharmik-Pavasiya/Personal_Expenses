import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction_model.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key, required this.transactions, required this.deleteTx});

  final List<TranscationModel> transactions;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text('₹ ${transactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 411
                        ? TextButton.icon(
                            onPressed: () => deleteTx(transactions[index].id),
                            label: const Text('Delete',style: TextStyle(color: Colors.red),),
                            icon: const Icon(Icons.delete, color: Colors.red,),
                          )
                        : IconButton(
                            onPressed: () => deleteTx(transactions[index].id),
                            icon: const Icon(Icons.delete,color: Colors.red,),
                            color: Theme.of(context).errorColor,
                          ),
                  ),
                );
              },
            ),
    );
  }
}
