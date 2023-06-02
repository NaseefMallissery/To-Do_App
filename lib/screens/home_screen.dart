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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customContainer(
                    color: Colors.blue.shade100,
                    height: Get.height * 0.1,
                    width: Get.width,
                    child: Card(
                      child: ListTile(
                        leading: text(content: 'Id:${index + 1}'),
                        title: text(content: 'tilte will show here'),
                        trailing: icon(
                          iconData: Icons.delete_forever,
                          color: Colors.red,
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
