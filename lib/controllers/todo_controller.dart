import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_todo/models/todo_model.dart';
import 'package:graphql_todo/screens/home_page/home_screen.dart';
import 'package:graphql_todo/utils/constants.dart';
import '../utils/reusables.dart';
import 'todo_services.dart';

class ToDoControllers extends GetxController {
  RxBool isLoading = false.obs;
  RxList<TodoModel> todoList = <TodoModel>[].obs;
  RxList<TodoModel> allTodos = <TodoModel>[].obs;
  RxList<TodoModel> updatedTodos = <TodoModel>[].obs;
  TextEditingController textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    getTodos();
    super.onInit();
  }

  getTodos() async {
    isLoading(true);
    final response = await ToDoServices().getTodos();
    if (response != null) {
      isLoading(false);
      log(response.toString());
      todoList((response as List).map((e) => TodoModel.fromJson(e)).toList());

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
      Get.snackbar(
        "Deleted",
        "Your data deleted permanently",
        colorText: AppColors.whiteColor,
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.primaryColor,
      );
      Get.to(const HomePage());
    }
  }
///////////////////////////////
  showDialogueBox() {
    return Get.defaultDialog(
      cancel: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
        ),
        onPressed: () {
          Get.back();
        },
        child: text(
          content: 'Cancel',
          color: AppColors.whiteColor,
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      title: 'Add Todo',
      titleStyle: const TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      content: Form(
          key: formKey,
          child: TextFormField(
            controller: textController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Add your task';
              }
              return null;
            },
          )),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
        ),
        onPressed: () {
          if (!formKey.currentState!.validate()) {
            log('controller is empty');
            return;
          } else {
            addTodo();
            Get.off(const HomePage());
          }
        },
        child: text(
          content: 'Save',
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  addTodo() async {
      log('AddTodo called');
    if (textController.text.isNotEmpty) {

      final response = await ToDoServices().addTodos(textController.text);
      final id = response['data']['insert_todos']['returning'][0]['id'];
      allTodos.insert(
        0,
        TodoModel(
          id: id,
          title: textController.text,
          isCompleted: false,
          createdAt: DateTime.now(),
        ),
      );
    } else {
      log('TextFiels is empty');
    }
    textController.clear();
    // Get.off(() => const HomePage());
    Get.snackbar("Done", "Todo added successfully",
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.primaryColor,
        colorText: AppColors.whiteColor);
  }

  ////////////////////////

  todoUpdated(int id, String title, int index) async {
    final response = await ToDoServices().updateTodo(id);
    if (response.statusCode == 200) {
      log(response.data.toString());
      updatedTodos.removeAt(index);
      updatedTodos.insert(
        0,
        TodoModel(
          id: id,
          title: title,
          isCompleted: true,
          createdAt: DateTime.now(),
        ),
      );
      Get.snackbar('Done', '$title is completed');
    } else {
      return null;
    }
  }
}
