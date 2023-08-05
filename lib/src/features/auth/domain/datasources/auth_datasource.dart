import '../entities/user.dart';

abstract class AuthDatasource{
  Future<User> login(String email,String password);
  Future<User> register(String fullName,String email,String password);
  Future<bool> recoveryPassword(String email);
  Future<User> checkAuthStatus(String token);
}