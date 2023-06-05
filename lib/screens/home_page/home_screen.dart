import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_todo/controllers/todo_controller.dart';
import 'package:graphql_todo/utils/constants.dart';
import 'package:graphql_todo/utils/reusables.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoControllers = Get.put(ToDoControllers());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            onPressed: () {
              // Get.to(const AddNewTodo());
              todoControllers.showDialogueBox();
            },
            icon: icon(
              iconData: Icons.edit,
            ),
          ),
        ],
      ),
      body: Obx(
        () => todoControllers.isLoading.value == true
            ? const Center(child: CircularProgressIndicator())
            : todoControllers.allTodos.isEmpty
                ? Center(
                    child: text(content: "No Todos added"),
                  )
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
                                    title: text(
                                        content: todoControllers
                                            .allTodos[index].title,
                                        fontWeight: FontWeight.w500,
                                        size: 18),
                                    subtitle: text(
                                      content: todoControllers
                                          .allTodos[index].createdAt
                                          .toString(),
                                      size: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    trailing: InkWell(
                                      onTap: () async {
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
      ),
    );
  }
}
