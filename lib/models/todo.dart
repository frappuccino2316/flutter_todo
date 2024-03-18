class ToDoItem {
  String title;
  bool isCompleted;

  ToDoItem({
    required this.title,
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
}
