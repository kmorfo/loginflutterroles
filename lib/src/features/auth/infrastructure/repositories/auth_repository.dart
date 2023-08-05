import '../../domain/domain.dart';
import '../infrastruture.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource dataSource;

  AuthRepositoryImpl({AuthDatasource? dataSource})
      : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<User> register(String fullName,String email, String password) {
    return dataSource.register(fullName,email, password);
  }
  
  @override
  Future<bool> recoveryPassword(String email) {
    return dataSource.recoveryPassword(email);
  }
}
