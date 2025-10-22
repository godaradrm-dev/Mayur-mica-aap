import 'package:flutter/material.dart';

void main() {
  runApp(MayurMicaApp());
}

class MayurMicaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mayur Mica',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> laminateStock = [];

  void addLaminate(String name, String company, int qty) {
    setState(() {
      laminateStock.add({
        'name': name,
        'company': company,
        'qty': qty,
      });
    });
  }

  void removeLaminate(int index) {
    setState(() {
      laminateStock.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mayur Mica Laminate Stock'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: laminateStock.length,
        itemBuilder: (context, index) {
          final item = laminateStock[index];
          return ListTile(
            title: Text('${item['name']} (${item['company']})'),
            subtitle: Text('Qty: ${item['qty']}'),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => removeLaminate(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final nameCtrl = TextEditingController();
              final companyCtrl = TextEditingController();
              final qtyCtrl = TextEditingController();

              return AlertDialog(
                title: const Text('Add Laminate'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: nameCtrl, decoration: InputDecoration(labelText: 'Name')),
                    TextField(controller: companyCtrl, decoration: InputDecoration(labelText: 'Company')),
                    TextField(controller: qtyCtrl, decoration: InputDecoration(labelText: 'Quantity'), keyboardType: TextInputType.number),
                  ],
                ),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ElevatedButton(
                    child: const Text('Add'),
                    onPressed: () {
                      addLaminate(nameCtrl.text, companyCtrl.text, int.parse(qtyCtrl.text));
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
