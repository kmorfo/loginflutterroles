import '../entities/user.dart';

abstract class AuthDatasource {
  Future<bool> recoveryPassword(String email);
  Future<User> checkAuthStatus(String token);
  Future<User> login(String email, String password);
  Future<User> register(String fullName, String email, String password);
  Future<User> resetPassword(String token, String password);
}
