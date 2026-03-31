// main.dart
// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(RestBudgetApp());
}

class RestBudgetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RestBudget',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
    );
  }
}

// MODEL
class Expense {
  String title;
  double amount;

  Expense(this.title, this.amount);
}

// HOME PAGE
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Expense> expenses = [];

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  double get total {
    return expenses.fold(0, (sum, item) => sum + item.amount);
  }

  void addExpense() {
    if (titleController.text.isEmpty || amountController.text.isEmpty) return;

    setState(() {
      expenses.add(
        Expense(titleController.text, double.parse(amountController.text)),
      );
      titleController.clear();
      amountController.clear();
    });
  }

  void deleteExpense(int index) {
    setState(() {
      expenses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("RestBudget"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // TOTAL
            Text(
              "Total: \$${total.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            // INPUTS
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Expense title",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            ElevatedButton(onPressed: addExpense, child: Text("Add Expense")),

            SizedBox(height: 20),

            // LIST
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(expenses[index].title),
                      subtitle: Text(
                        "\$${expenses[index].amount.toStringAsFixed(2)}",
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => deleteExpense(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
