import 'dart:developer';
import 'package:get/get.dart';
import 'package:graphql_todo/models/todo_model.dart';
import 'package:graphql_todo/utils/constants.dart';
import 'todo_services.dart';

class ToDoControllers extends GetxController {
  RxBool isLoading = false.obs;
  RxList<TodoModel> todoList = <TodoModel>[].obs;
  RxList<TodoModel> allTodos = <TodoModel>[].obs;

  @override
  void onInit() {
    getTodos();
    super.onInit();
  }

  getTodos() async {
    isLoading(true);
    final response = await ToDoServices().getTodos();
    if (response != null) {
      todoList((response as List).map((e) => TodoModel.fromJson(e)).toList());
      isLoading(false);
      allTodos.clear();
      for (var element in todoList) {
        allTodos.add(element);
      }
    } else {
      log('Todo is Null');
    }
  }

  deleteTodo(int id, int index) async {
    final response = await ToDoServices().delteTodo(id);
    if (response.statusCode == 200) {
      allTodos.removeAt(index);
      await getTodos();
      Get.snackbar(
        "Deleted",
        "Your data deleted permanently",
        colorText: AppColors.whiteColor,
        duration: const Duration(seconds: 1),
        backgroundColor: AppColors.primaryColor,
      );
    }
  }

  // refreshPage() {
  //   getTodos();
  // }
}
