import 'dart:developer';
import 'package:dummy_api/core/api/base_api.dart';
import 'package:dummy_api/core/constant/b7c_constant.dart';
import 'package:dummy_api/data/models/remote_model.dart';

class RemoteService {
  Future<UserListResponse> getUserList({
    required int page,
  }) async {
    Map<String, Object> param = {};
    param['limit'] = B7CConstants.limit;
    param['page'] = page;
    var resJson = await BaseApi().dio.get('user', queryParameters: param);
    log("param : $param");
    log("page ---->: $page");
    log('RESPONSE DATA---->: $resJson');

    log("-----------------------End------------------------------");
    if (resJson.statusCode == 200) {
      UserListResponse response = UserListResponse.fromJson(resJson.data);

      return response;
    }
    return UserListResponse(
        // ignore: null_check_always_fails
        total: 0,
        page: 0,
        limit: 0,
        // ignore: null_check_always_fails
        userList: null!);
  }

  Future<UserDetailResponse> getUserDetail({
    required String id,
  }) async {
    var resJson = await BaseApi().dio.get('user/$id');

    log("id ---->: $id");
    log("resJson ---->: $resJson");
    log("-----------------------End------------------------------");
    if (resJson.statusCode == 200) {
      UserDetailResponse response = UserDetailResponse.fromJson(resJson.data);
      return response;
    }
    return UserDetailResponse(
      id: '',
      title: '',
      firstName: '',
      lastName: '',
      picture: '',
      gender: '',
      phone: '',
      email: '',
      dateOfBirth: null,
      registerDate: null,
      updatedDate: null,
      location: null,
    );
  }

  Future<UserPostResponse> getUserPost({
    required String id,
    required int page,
  }) async {
    Map<String, Object> param = {};
    param['limit'] = B7CConstants.limit;
    param['page'] = page;
    var resJson =
        await BaseApi().dio.get('user/$id/post', queryParameters: param);

    log("id ---->: $id");
    log("param ---->: $param");
    log("resJson ---->: $resJson");
    log("-----------------------End------------------------------");
    if (resJson.statusCode == 200) {
      UserPostResponse response = UserPostResponse.fromJson(resJson.data);
      return response;
    }
    return UserPostResponse(
        // ignore: null_check_always_fails
        total: 0,
        page: 0,
        limit: 0,
        // ignore: null_check_always_fails
        listPost: null!);
  }

  Future<UserPostResponse> getLike({
    required String id,
    required int page,
  }) async {
    Map<String, Object> param = {};
    param['limit'] = 5;
    param['page'] = page;
    var resJson =
        await BaseApi().dio.get('user/$id/post', queryParameters: param);

    log("id ---->: $id");
    log("param ---->: $param");
    log("resJson ---->: $resJson");
    log("-----------------------End------------------------------");
    if (resJson.statusCode == 200) {
      UserPostResponse response = UserPostResponse.fromJson(resJson.data);
      return response;
    }
    return UserPostResponse(
        // ignore: null_check_always_fails
        total: 0,
        page: 0,
        limit: 0,
        // ignore: null_check_always_fails
        listPost: null!);
  }
}
