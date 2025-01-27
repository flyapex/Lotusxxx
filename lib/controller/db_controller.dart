import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DBController extends GetxController {
  final _box = GetStorage();

  final loginKey = 'userKey';
  final loginToken = 'token';
  final nameKey = 'name';

  // getUserID() => _box.read(loginKey) ?? false;
  // saveUserId(int value) => _box.write(loginKey, value);

  String? getUserID() => _box.read(loginKey);
  void saveUserID(String value) => _box.write(loginKey, value);
  void clearUserID() => _box.remove(loginKey);

  String? getUserToken() => _box.read(loginToken);
  void saveUserToken(String value) => _box.write(loginToken, value);
  void clearUserToken() => _box.remove(loginToken);

  String? getUserName() => _box.read(nameKey);
  void saveUserName(String value) => _box.write(nameKey, value);
  void clearUserName() => _box.remove(nameKey);
}
