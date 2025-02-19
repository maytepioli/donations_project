import 'package:donations/donations.dart';

/// Data source - in-memory cache
Map<String, User> userDb = {};

/// Repositorio de usuario
class UserRepository {
  /// Obtener usuario por id
  Future<User?> getUserById(String uuid) async {
    return userDb[uuid];
  }

  /// Obtener todos los usuarios
  Map<String, dynamic> getAllUsers() {
    final userLists = <String, dynamic>{};

    if(userDb.isNotEmpty) {
      userDb.forEach(
        (String uuid) {
          final currentList = userDb[uuid];
          userLists[uuid] = currentList?.toJson();
        } as void Function(String key, User value),
      );
    }
    return userLists;
  }

  /// Crear usuario
  String createUser({
    required String name, 
    required String password, 
    required String email, 
    required String phoneNumber,}) {
    final newUser = User(
      name: name,
      password: password,
      email: email,
      phoneNumber: phoneNumber,
    );
    userDb[newUser.uuid] = newUser;

    return newUser.uuid;
  }

  /// Eliminar usuario
  void deleteUser(String uuid) {
    userDb.remove(uuid);
  }

  /// Actualizar usuario

  
}
