import 'package:get/get.dart';
import 'package:graphql_todo/models/todo_model.dart';

class ToDoControllers extends GetxController {
  RxBool isLoading = false.obs;
  RxList<ToDoModel> todoList = <ToDoModel>[].obs;
  RxList<ToDoModel> toDoListDone = <ToDoModel>[].obs;
  RxList<ToDoModel> toDoListnotDone = <ToDoModel>[].obs;

  @override
  void onInit() {
    // getTodos();
    super.onInit();
  }

  // getTodos() async {
  //   isLoading(true);
  //   final Response response = await ToDoServices().getTodos();
  //   if (response != null) {
  //     log(response.toString());
  //     todoList((response as List).map((e) => ToDoModel.fromJson(e)).toList());
  //     toDoListDone.clear();
  //     toDoListnotDone.clear();
  //     for (var element in todoList) {
  //       if (element.isCompleted == true) {
  //         toDoListDone.add(element);
  //       } else {
  //         toDoListnotDone.add(element);
  //       }
  //     }
  //   } else {
  //     log('Todo is Null');
  //   }
  //   isLoading(false);
  // }
}
