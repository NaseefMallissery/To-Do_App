class Queries {
  static const getTodo = '''
query getTodo {
  todos(order_by: {is_completed: asc , id: desc}) {
    id
    title
    is_completed
    created_at
  }
}
''';

  static const deleteTodo = '''
mutation deleteTask(\$id: Int!) {
  delete_todos(where: {id: {_eq: \$id}}){
    affected_rows
    returning{
      id
      title
      
    }
  }
}
''';
}
