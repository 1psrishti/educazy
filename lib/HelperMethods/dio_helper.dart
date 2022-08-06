import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:educazy/models/user_model.dart';

class DioHelper {
  final Dio _dio = Dio();
  final _baseUrl = "https://educazy.herokuapp.com/api";

  Future<UserModel?> getUser({required String id}) async {
    UserModel? user;
    try {
      Response userData = await _dio.get(_baseUrl + '/user/login');
      print('User Info: ${userData.data}');
      user = UserModel.fromJson(userData.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return user;
  }

  Future signup({required UserModel userInfo, required String password}) async {
    try {
      Response response = await _dio.post(
        _baseUrl + '/user/register',
        data: {
          "username": userInfo.userId,
          "password": password,
          "name": userInfo.name,
          "class": userInfo.className,
          "school": userInfo.school,
          "disabilities": userInfo.disabilities,
        },
      );

      print('User created: ${response.data}');
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  Future login({required String username, required String password}) async {
    try {
      Response response = await _dio.post(
        _baseUrl + '/user/login',
        data: {
          "username": username,
          "password": password,
        },
      );

      print('User created: ${jsonDecode(response.data)}');
    } catch (e) {
      print('Error creating user: $e');
    }
  }
}
