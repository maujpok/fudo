import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fudo/domain/api/auth_api.dart';

class AuthApiImpl implements AuthApi {
  @override
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2), () {});
    if (email == dotenv.env['USER'] && password == dotenv.env['PASS']) {
      return true;
    }
    return false;
  }
}
