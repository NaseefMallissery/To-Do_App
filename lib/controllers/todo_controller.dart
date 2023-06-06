import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_todo/models/todo_model.dart';
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
    isLoading.toggle();
    final response = await ToDoServices().getTodos();
    if (response != null) {
      isLoading.toggle();
      log(response.toString());
      todoList(
        (response as List).map((e) => TodoModel.fromJson(e)).toList(),
      );
      allTodos.clear();
      updatedTodos.clear();
      for (var element in todoList) {
        if (element.isCompleted == false) {
          allTodos.add(element);
        } else {
          updatedTodos.add(element);
        }
      }
    } else {
      log('response is Null');
    }
  }

  deleteTodo(int id, int index) async {
    final response = await ToDoServices().deleteTodo(id);
    if (response.statusCode == 200) {
      allTodos.removeAt(index);

      Get.snackbar(
        "Deleted",
        "Your task deleted",
        colorText: AppColors.whiteColor,
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.primaryColor,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

//showDialogueBox for adding new task

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
            return;
          } else {
            addTodo();
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
    Get.back();
    textController.clear();
    Get.snackbar(
      "Done",
      "New Task added successfully",
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.primaryColor,
      colorText: AppColors.whiteColor,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  ////////////////////////

  updateTodo(int id, String title, int index) async {
    final response = await ToDoServices().updateTodo(id);
    if (response.statusCode == 200) {
      log(response.data.toString());
      allTodos.removeAt(index);
      updatedTodos.insert(
        0,
        TodoModel(
          id: id,
          title: title,
          isCompleted: true,
          createdAt: DateTime.now(),
        ),
      );

      Get.snackbar(
        'Task Finished',
        '$title is Finished',
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.primaryColor,
        colorText: AppColors.whiteColor,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      return null;
    }
  }
}
