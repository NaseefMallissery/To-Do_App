class Queries {
  static const getTodo = '''
query getTodo {
  todos(order_by: {is_completed: asc , id: desc}) {
    id
    title
    is_completed
  }
}
''';
}
