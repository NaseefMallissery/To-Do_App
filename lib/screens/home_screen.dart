import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_todo/controllers/todo_controller.dart';
import 'package:graphql_todo/utils/constants.dart';
import 'package:graphql_todo/utils/reusables.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoControllers = Get.find<ToDoControllers>();
    return Scaffold(
      appBar: AppBar(
        title: text(
          content: "Todo App",
          color: AppColors.whiteColor,
          fontWeight: FontWeight.bold,
          size: 20,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: icon(
              iconData: Icons.edit,
            ),
          ),
        ],
      ),
      body: todoControllers.isLoading.value == true
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: todoControllers.allTodos.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: customContainer(
                          color: Colors.blue.shade100,
                          height: Get.height * 0.1,
                          width: Get.width,
                          child: Card(
                            child: ListTile(
                              leading: text(
                                  content: todoControllers.allTodos[index].id
                                      .toString()),
                              title: text(
                                  content:
                                      todoControllers.allTodos[index].title),
                              subtitle: text(
                                  content: todoControllers
                                      .allTodos[index].createdAt
                                      .toString()),
                              trailing: InkWell(
                                onTap: () async{
                                  todoControllers.deleteTodo(
                                      todoControllers.allTodos[index].id,
                                      index);
                                      await todoControllers.getTodos();
                                },
                                child: icon(
                                  iconData: Icons.delete_forever,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
