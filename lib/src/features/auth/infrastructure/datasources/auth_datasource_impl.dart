import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../config/config.dart';
import '../../domain/domain.dart';
import '../errors/auth_errors.dart';
import '../mappers/user_mapper.dart';

class AuthDataSourceImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
  ));

  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await dio.get(
        '/auth/check-status',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError('Token incorrecto');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(e.response?.data['message'] ?? 'Credenciales incorrectas');
      }
      if (e.error.runtimeType == SocketException) {
        throw CustomError('No se pudo contactar con el servidor.');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String fullName, String email, String password) async {
    try {
      final response = await dio.post('/auth/register', data: {
        'email': email,
        'password': password,
        "fullName": fullName,
      });

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError(e.response?.data['message'] ?? 'Credenciales incorrectas');
      }
      if (e.error.runtimeType == SocketException) {
        throw CustomError('No se pudo contactar con el servidor.');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> recoveryPassword( String email) async {
    try {
      await dio.get('/auth/forgot-password/$email');

      return true; 
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(e.response?.data['message'] ?? 'Email does not exist');
      }
      if (e.error.runtimeType == SocketException) {
        throw CustomError('No se pudo contactar con el servidor.');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
