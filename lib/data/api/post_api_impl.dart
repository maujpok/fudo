import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fudo/core/error/failures.dart';
import 'package:fudo/core/network/dio_base_service.dart';
import 'package:fudo/data/models/_models.dart';
import 'package:fudo/domain/api/post_api.dart';

class PostApiImpl extends DioBaseService implements PostApi {
  @override
  Future<List<PostModel>> getPosts() async {
    try {
      final response = await dio.get('/posts');
      if (response.statusCode == HttpStatus.ok) {
        return getPostsResponseFromJson(response.data);
      }
      throw BadRequestFailure();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await dio.get('/users');
      if (response.statusCode == HttpStatus.ok) {
        return getUsersFromJson(response.data);
      }
      throw BadRequestFailure();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  @override
  Future<bool> createPost({
    required String title,
    required String body,
    required int userId,
  }) async {
    try {
      final data = {
        'title': title,
        'body': body,
        'userId': userId,
      };

      final response = await dio.post('/posts', data: json.encode(data));
      if (response.statusCode == HttpStatus.ok) {
        return true;
      }
      throw ServerException();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}
