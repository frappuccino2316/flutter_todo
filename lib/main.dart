import 'package:flutter/material.dart';
import 'package:simple_todo/models/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  ToDoListScreenState createState() => ToDoListScreenState();
}

class ToDoListScreenState extends State<ToDoListScreen> {
  List<ToDoItem> todoItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo'),
      ),
      body: ListView.builder(
        itemCount: todoItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todoItems[index].title),
            subtitle: Text(todoItems[index].description),
            trailing: Checkbox(
              value: todoItems[index].isCompleted,
              onChanged: (value) {
                setState(
                  () {
                    todoItems[index].isCompleted = value!;
                  },
                );
              },
            ),
            // trailing: IconButton(
            //   icon: const Icon(Icons.delete),
            //   onPressed: () {
            //     setState(
            //       () {
            //         todoItems.removeAt(index);
            //       },
            //     );
            //   },
            // ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addItemDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addItemDialog(BuildContext context) {
    String newTitle = '';
    String newDescription = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add ToDo Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                onChanged: (value) {
                  newTitle = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
              TextField(
                onChanged: (value) {
                  newDescription = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  if (newTitle.isNotEmpty && newDescription.isNotEmpty) {
                    ToDoItem newItem = ToDoItem(
                      title: newTitle,
                      description: newTitle,
                    );
                    todoItems.add(newItem);
                  }
                  Navigator.of(context).pop();
                });
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
