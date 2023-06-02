class ToDoModel {
  int id;
  String title;
  bool isCompleted;

  ToDoModel({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  factory ToDoModel.fromJson(Map<String, dynamic> json) => ToDoModel(
        id: json["id"],
        title: json["title"],
        isCompleted: json["is_completed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "is_completed": isCompleted,
      };
}
