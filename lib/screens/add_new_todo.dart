import 'package:flutter/material.dart';
import 'package:graphql_todo/utils/reusables.dart';

class AddNewTodo extends StatelessWidget {
  const AddNewTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          // Get.pop
        }, icon: icon(iconData: Icons.arrow_back_ios)),
      ),
    );
  }
}
