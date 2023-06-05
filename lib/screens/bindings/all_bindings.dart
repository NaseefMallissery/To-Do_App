import 'package:get/get.dart';
import 'package:graphql_todo/controllers/todo_controller.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ToDoControllers>(
      () => ToDoControllers(),
    );
  
  }
}
