
import 'package:dio/dio.dart' as dio;
import 'package:graphql_todo/utils/constants.dart';

class ToDoServices {
  dio.Dio graphqlClient = dio.Dio(
    dio.BaseOptions(
      baseUrl: AppUrl.baseUrl,
      contentType: 'application/json',
      responseType: dio.ResponseType.json,
      headers: {
        'x-hasura-admin-secret':
            'zqaMG8Nz9VsbXcbwToUSu2MbDSv1o7fsEUMexH1eHGgy1BVkKCETSJf7lka05sw5'
      },
      sendTimeout: const Duration(seconds: 5),
    ),
  );


  //  getTodos() async {
  //   try {
  //     dio.Response response = await graphqlClient.post('', data: {
  //       "query": Queries.getTodo,
  //     });
  //     if (response.statusCode == 200) {
  //       log(response.data.toString());
  //       return response.data['data']['todos'];
  //     } else {
  //       return null;
  //     }
  //   } on dio.DioError catch (e) {
  //     log(e.message.toString());
  //   }
  //   return null;
  // }

}
