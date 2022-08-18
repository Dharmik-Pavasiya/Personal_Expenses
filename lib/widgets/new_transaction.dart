import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction({Key? key, required this.AddTransaction}) : super(key: key);

  final Function AddTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void SubmitData(){
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0){
      return;
    }

    widget.AddTransaction(enteredTitle,enteredAmount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              controller: titleController,
              onSubmitted: (_) => SubmitData(),
              // onChanged: (value){
              //   titleInput = value;
              // },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => SubmitData(),
              // onChanged: (value){
              //   amountInput = value;
              // },
            ),
            FlatButton(
              onPressed: SubmitData,
              textColor: Colors.purple,
              child: const Text('Add Trasaction'),
            )
          ],
        ),
      ),
    );
  }
}
