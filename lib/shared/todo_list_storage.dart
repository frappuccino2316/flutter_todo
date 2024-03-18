import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoListStorage {
  static const String _key = 'todo_list';

  static Future<List<Map<String, dynamic>>> readToDoList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_key);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.cast<Map<String, dynamic>>();
    } else {
      return [];
    }
  }

  static Future<void> writeToDoList(List<Map<String, dynamic>> todoList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(todoList);
    prefs.setString(_key, jsonString);
  }
}
