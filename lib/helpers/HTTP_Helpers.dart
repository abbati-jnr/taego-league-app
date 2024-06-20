import 'package:taego_league_app/helpers/shared_preference_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../services/api_services.dart';
import '../utils/api_constants.dart';



class HttpHelper {

  static Dio dio = Dio(
    BaseOptions(
      baseUrl: baseURL,
    )
  );


  static Future post(String url, Map data) async {
    try {
      dio.interceptors.add(ApiInterceptors());
      print(data);

      final response = await dio.post(
        url,
        data: data,
      );

      return response.data;

    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        final errorResponse = e.response!;
        throw ApiError(errorResponse.data); // Pass the error data to ApiError.
      } else {
        throw NetworkError(e.message);
      }
    }
  }

  static Future postWithToken(String url, Map data) async {
    try {
      dio.interceptors.add(ApiInterceptors());

      final response = await dio.post(url, data: data, options: Options(headers: {"requiresToken" : true}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        return null;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        final errorResponse = e.response!;
        throw ApiError(errorResponse.data); // Pass the error data to ApiError.
      } else {
        throw NetworkError(e.message);
      }
    }
  }

  static Future postFormDataWithToken(String url, FormData data) async {
    try {
      dio.interceptors.add(ApiInterceptors());

      final response = await dio.post(url, data: data, options: Options(headers: {"requiresToken" : true}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        return null;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        final errorResponse = e.response!;
        throw ApiError(errorResponse.data); // Pass the error data to ApiError.
      } else {
        throw NetworkError(e.message);
      }
    }
  }

  static Future postFormData(String url, FormData data) async {
    try {
      dio.interceptors.add(ApiInterceptors());

      final response = await dio.post(url, data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        return null;
      }
    } on DioError catch (e) {
      // print(e.response?.data);
      // return null;
      // return e.response!;

      if (e.response != null) {
        final errorResponse = e.response!;
        throw ApiError(errorResponse.data); // Pass the error data to ApiError.
      } else {
        throw NetworkError(e.message);
      }

    }
  }

  static Future get(String url, Map? data) async {
    try {
      dio.interceptors.add(ApiInterceptors());

      final response = data == null ? await dio.get(
        url,
      ) : await dio.get(
        url,
        data: data
      );

      // print(response);

      if (response.statusCode == 200) {
        // print(response.data);
        return response.data;
      } else {
        return null;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        final errorResponse = e.response!;
        throw ApiError(errorResponse.data); // Pass the error data to ApiError.
      } else {
        throw NetworkError(e.message);
      }
    }
  }

  static Future getWithToken(String url) async {
    try {
      dio.interceptors.add(ApiInterceptors());

      final response = await dio.get(url, options: Options(headers: {"requiresToken" : true}));

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        final errorResponse = e.response!;
        throw ApiError(errorResponse.data); // Pass the error data to ApiError.
      } else {
        throw NetworkError(e.message);
      }
    }
  }

  static Future update(String url, Object? data) async {
    try {
      dio.interceptors.add(ApiInterceptors());
      print(data);

      final response = await dio.put(
        url,
        data: data,
      );

      return response.data;

    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return e.response!.data;
        // print(e.response!.data);
        // print(e.response!.headers);
        // print(e.response!.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        if (e.response != null) {
          final errorResponse = e.response!;
          throw ApiError(errorResponse.data); // Pass the error data to ApiError.
        } else {
          throw NetworkError(e.message);
        }
      }
    }
  }

  static Future delete(String url, Object? data) async {
    try {
      dio.interceptors.add(ApiInterceptors());
      print(data);

      final response = await dio.delete(
        url,
        data: data,
      );

      return response.data;

    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return e.response!.data;
        // print(e.response!.data);
        // print(e.response!.headers);
        // print(e.response!.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        if (e.response != null) {
          final errorResponse = e.response!;
          throw ApiError(errorResponse.data); // Pass the error data to ApiError.
        } else {
          throw NetworkError(e.message);
        }
      }
    }
  }

}



class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    await EasyLoading.show();

    if (options.headers.containsKey("requiresToken")) {
      var accessToken = await SharedPrefServices.getString(key: 'token');
      //remove the auxiliary header
      options.headers.remove("requiresToken");
      options.headers['Authorization'] = 'Token $accessToken';
    }

    print('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    EasyLoading.dismiss();
    return super.onResponse(response, handler);
  }
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    EasyLoading.dismiss();
    return super.onError(err, handler);
  }
}
