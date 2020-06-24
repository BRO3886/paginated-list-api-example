import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:paginated_list_app/src/data/models/api_response.dart';
import 'package:paginated_list_app/src/data/models/posts.dart';
import 'package:paginated_list_app/src/data/repositories/utils.dart';

class PostsRepository {

  ///[getPosts] is used to fetch posts by page number from
  ///the API
  Future<ApiResponse<Posts>> getPosts(int pageNumber) async {
    print("getPosts called");

    final uri = API_BASE_URL + 'access-token=' + ACCESS_TOKEN;
    print("uri = $uri&page=$pageNumber");

    try {
      final response = await http.get(
        '$uri&page=$pageNumber',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      switch (response.statusCode) {
        case 200:
          final data = postsFromJson(response.body);
          return ApiResponse.completed(data);
          break;
        default:
          return ApiResponse.error("something went wrong");
          break;
      }
    } on SocketException {
      return ApiResponse.error("no internet connection");
    } catch (e) {
      print(e.toString());
      return ApiResponse.error("something went wrong");
    }
  }
}
