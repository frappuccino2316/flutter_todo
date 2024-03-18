import 'package:simple_todo/shared/todo_list_storage.dart';

class ToDoItem {
  String title;
  String description;
  bool isCompleted;

  ToDoItem({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  void addItem(ToDoItem newItem, List<ToDoItem> todoList) {
    todoList.add(newItem);
    _saveToDoList(todoList);
  }

  void updateItem(int index, ToDoItem updatedItem, List<ToDoItem> todoList) {
    todoList[index] = updatedItem;
    _saveToDoList(todoList);
  }

  void removeItem(int index, List<ToDoItem> todoList) {
    todoList.removeAt(index);
    _saveToDoList(todoList);
  }

  void toggleCompletion(int index, List<ToDoItem> todoList) {
    todoList[index].isCompleted = !todoList[index].isCompleted;
    _saveToDoList(todoList);
  }

  void _saveToDoList(List<ToDoItem> todoList) async {
    final List<Map<String, dynamic>> serializedList =
        todoList.map((e) => e.toJson()).toList();
    await ToDoListStorage.writeToDoList(serializedList);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory ToDoItem.fromJson(Map<String, dynamic> json) {
    return ToDoItem(
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
    );
  }
}
