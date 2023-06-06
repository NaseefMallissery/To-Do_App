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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
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
                  todoControllers.showDialogueBox();
                },
                icon: icon(
                  iconData: Icons.edit,
                ),
              ),
            ],
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 1,
              indicatorColor: AppColors.whiteColor,
              indicatorPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 1,
              ),
              tabs: [
                text(
                  content: "Remaining",
                  color: AppColors.whiteColor,
                ),
                text(
                  content: "Completed",
                  color: AppColors.whiteColor,
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Obx(
              () => todoControllers.isLoading.value == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : todoControllers.allTodos.isEmpty
                      ? Center(
                          child: text(
                            content: "No Todos added",
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: todoControllers.allTodos.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(
                                      8.0,
                                    ),
                                    child: customContainer(
                                      color: Colors.blue.shade100,
                                      height: Get.height * 0.1,
                                      width: Get.width,
                                      child: Card(
                                        child: ListTile(
                                          leading: InkWell(
                                            onTap: () {
                                              todoControllers.updateTodo(
                                                todoControllers
                                                    .allTodos[index].id,
                                                todoControllers
                                                    .allTodos[index].title,
                                                index,
                                              );
                                            },
                                            child: icon(
                                              iconData:
                                                  Icons.check_circle_outline,
                                              color: AppColors.greyColor,
                                            ),
                                          ),
                                          title: text(
                                            content: todoControllers
                                                .allTodos[index].title,
                                            fontWeight: FontWeight.w500,
                                            size: 18,
                                          ),
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
                                                todoControllers
                                                    .allTodos[index].id,
                                                index,
                                              );
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
            Obx(
              () => todoControllers.isLoading.value == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : todoControllers.updatedTodos.isEmpty
                      ? Center(
                          child: text(
                            content: "No completed task",
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: todoControllers.updatedTodos.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(
                                      8.0,
                                    ),
                                    child: customContainer(
                                      color: Colors.blue.shade100,
                                      height: Get.height * 0.1,
                                      width: Get.width,
                                      child: Card(
                                        child: ListTile(
                                          leading: icon(
                                            iconData: Icons.done_all,
                                            color: AppColors.greenColor,
                                          ),
                                          title: text(
                                            content: todoControllers
                                                .updatedTodos[index].title,
                                            fontWeight: FontWeight.w500,
                                            size: 18,
                                            lineThrough: true,
                                          ),
                                          subtitle: text(
                                            content: todoControllers
                                                .updatedTodos[index].createdAt
                                                .toString(),
                                            size: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          trailing: InkWell(
                                            onTap: () async {
                                              todoControllers.deleteTodo(
                                                todoControllers
                                                    .updatedTodos[index].id,
                                                index,
                                              );
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
          ],
        ),
      ),
    );
  }
}
