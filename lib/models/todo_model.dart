

class TodoModel {
    int id;
    String title;
    bool isCompleted;
    DateTime createdAt;

    TodoModel({
        required this.id,
        required this.title,
        required this.isCompleted,
        required this.createdAt,
    });

    factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json["id"],
        title: json["title"],
        isCompleted: json["is_completed"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "is_completed": isCompleted,
        "created_at": createdAt.toIso8601String(),
    };
}
