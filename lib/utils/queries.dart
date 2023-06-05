class Queries {
  static const addTodo = '''
mutation addTodo(\$title: String!) {
  insert_todos(objects: {title: \$title,user_id:"1"}) {
    affected_rows
    returning {
      id
      title
      user_id
      
    }
  }
}
''';

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

  static const updateTodo = '''
mutation update(\$id: Int!) {
  update_todos(where: {id: {_eq: \$id}}, _set: {is_completed: true}){
affected_rows
    returning{
      title
      created_at
      id
      is_completed
    }
  }
}
''';
}
