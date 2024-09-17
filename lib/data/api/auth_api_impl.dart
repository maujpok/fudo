import 'package:fudo/domain/api/auth_api.dart';

class AuthApiImpl implements AuthApi {
  @override
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2), () {});
    if (email == 'challenge@fu.do' && password == 'password') {
      return true;
    }
    return false;
  }
}
