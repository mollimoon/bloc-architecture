import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:study_architecture/data/post.dart';

import 'api_constants.dart';

class PostRepository {
  final Dio dio;

  PostRepository({required this.dio});

  Future<List<Post>> getPosts() async {
    final response = await dio.get(ApiConstants.getPosts);

    if (response.statusCode == 200) {
      final jsonString = response.data;
      final json = jsonDecode(jsonString);

      final postList = <Post>[];

      for (final item in json) {
        final post = Post.fromJson(item);
        postList.add(post);
      }

      return postList;
    } else {
      throw Exception('Failed to load');
    }
  }
}
