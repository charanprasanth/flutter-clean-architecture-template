import 'package:dio/dio.dart';
import '../errors/app_exception.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<T> get<T>(String path) async {
    try {
      final response = await _dio.get<T>(path);
      return response.data as T;
    } on DioException catch (e) {
      throw e.error ?? AppException('Unexpected error');
    }
  }

  Future<T> post<T>(String path, {dynamic data}) async {
    try {
      final response = await _dio.post<T>(path, data: data);
      return response.data as T;
    } on DioException catch (e) {
      throw e.error ?? AppException('Unexpected error');
    }
  }

  Future<T> put<T>(String path, {dynamic data}) async {
    try {
      final response = await _dio.put<T>(path, data: data);
      return response.data as T;
    } on DioException catch (e) {
      throw e.error ?? AppException('Unexpected error');
    }
  }

  Future<T> delete<T>(String path, {dynamic data}) async {
    try {
      final response = await _dio.delete<T>(path, data: data);
      return response.data as T;
    } on DioException catch (e) {
      throw e.error ?? AppException('Unexpected error');
    }
  }
}
