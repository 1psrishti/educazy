import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:educazy/DioHelper/dio_exception.dart';
import 'package:educazy/dataProviders/user_app_data.dart';
import 'package:educazy/models/question_model.dart';
import 'package:educazy/models/test_model.dart';
import 'package:educazy/models/user_model.dart';
import 'package:educazy/screens/home_screen.dart';
import 'package:educazy/services/notifications.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';
import 'logger_inceptor.dart';

// class DioHelper {
//   final Dio _dio = Dio(base);
//   final _baseUrl = "https://educazy.herokuapp.com/api";

//   Future<UserModel?> getUser({required String id}) async {
//     UserModel? user;
//     try {
//       Response userData = await _dio.get(_baseUrl + '/user/login');
//       print('User Info: ${userData.data}');
//       user = UserModel.fromJson(userData.data);
//     } on DioError catch (e) {
//       // The request was made and the server responded with a status code
//       // that falls out of the range of 2xx and is also not 304.
//       if (e.response != null) {
//         print('Dio error!');
//         print('STATUS: ${e.response?.statusCode}');
//         print('DATA: ${e.response?.data}');
//         print('HEADERS: ${e.response?.headers}');
//       } else {
//         // Error due to setting up or sending the request
//         print('Error sending request!');
//         print(e.message);
//       }
//     }
//     return user;
//   }

//   Future signup({required UserModel userInfo, required String password}) async {
//     try {
//       Response response = await _dio.post(
//         _baseUrl + '/user/register',
//         data: {
//           "username": userInfo.userId,
//           "password": password,
//           "name": userInfo.name,
//           "class": userInfo.className,
//           "school": userInfo.school,
//           "disabilities": userInfo.disabilities,
//         },
//       );

//       print('User created: ${response.data}');
//     } catch (e) {
//       print('Error creating user: $e');
//     }
//   }

class DioClient {
  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://educazy.herokuapp.com/api',
            responseType: ResponseType.json,
          ),
        )..interceptors.addAll([
            LoggerInterceptor(),
          ]);

  late final Dio _dio;

  Future signup({required UserModel userInfo, required String password}) async {
    try {
      Response response = await _dio.post(
        '/user/register',
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
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      rethrow;
    }
  }

  Future login(
      {required String username,
      required String password,
      required BuildContext context}) async {
    var fcm_token = await getToken();
    try {
      Response response = await _dio.post(
        '/user/login',
        data: {"username": username, "password": password, "fcm": fcm_token},
      );
      var data = jsonDecode(response.toString());
      print('User logged in: $data');
      if (data['success'] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var key = data['key'];
        print('key: $key');
        prefs.setString('key', data['key']);

        UserModel? user = await getData(data['key']);
        Provider.of<UserAppData>(context, listen: false).setUserdata(user!);
        Navigator.pushNamed(context, HomeScreen.name);
      }
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getData(String token) async {
    try {
      Response response = await _dio.get('/user/details',
          options: Options(headers: {
            'authorization': 'bearer $token',
          }));
      var data = jsonDecode(response.toString());
      if (data['success'] == true) {
        print('User created: $data');
        UserModel userModel = UserModel.fromMap(data['data']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        print("data ${userModel.toJson()}");
        prefs.setString('userdata', userModel.toJson());

        return userModel;
      }
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      rethrow;
    }
  }

  getAllTests() async {
    try {
      Response response = await _dio.get('/test/get-all-test',
          options: Options(headers: {
            'authorization': 'bearer ${Global.authToken}',
          }));
      var data = jsonDecode(response.toString());
      if (data['success'] == true) {
        print('Got all tests: $data');

        List<Test> tests = [];
        for (var t in data['data']) {
          Test test = Test.fromMap(t);
          tests.add(test);
        }
        return tests;
      }
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      rethrow;
    }
  }

  getQuestions(String testName) async {
    try {
      Response response = await _dio.get('/test/get-all-questions/$testName',
          options: Options(headers: {
            'authorization': 'bearer ${Global.authToken}',
          }));
      var data = jsonDecode(response.toString());
      if (data['success'] == true) {
        print('Got all questions of test $testName: $data');

        List<Question> questions = [];
        for (var t in data['data']) {
          Question ques = Question.fromMap(t);
          questions.add(ques);
        }
        return questions;
      }
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      rethrow;
    }
  }

  Future<int?> getScore(
      String quesid, String testName, int markedOption) async {
    try {
      Response response = await _dio.post(
        '/test/get-score/$testName',
        options: Options(headers: {
          'authorization': 'bearer ${Global.authToken}',
        }),
        data: {"_id": quesid, "option": markedOption},
      );

      print('User created: ${response.data}');
      var data = jsonDecode(response.toString());
      if (data['success'] == true) {
        return data['score'];
      }
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      rethrow;
    }
  }
}
