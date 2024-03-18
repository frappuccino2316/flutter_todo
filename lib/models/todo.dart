class ToDoItem {
  int? id;
  String title;
  String description;
  bool isCompleted;

  ToDoItem({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  void addItem(ToDoItem newItem, List<ToDoItem> todoList) {
    todoList.add(newItem);
  }

  void updateItem(int index, ToDoItem updatedItem, List<ToDoItem> todoList) {
    todoList[index] = updatedItem;
  }

  void removeItem(int index, List<ToDoItem> todoList) {
    todoList.removeAt(index);
  }

  void toggleCompletion(int index, List<ToDoItem> todoList) {
    todoList[index].isCompleted = !todoList[index].isCompleted;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory ToDoItem.fromMap(Map<String, dynamic> map) {
    return ToDoItem(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
