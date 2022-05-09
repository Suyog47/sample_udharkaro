import 'package:encrypt/encrypt.dart';

class PasswordEncryption {
  String encrypt(String pass) {
    final key = Key.fromLength(32);
    final iv = IV.fromLength(8);
    final encrypter = Encrypter(Salsa20(key));
    final encrypted = encrypter.encrypt(pass, iv: iv);
    return encrypted.base64;
  }

  String decrypt(Encrypted encrypted) {
    final key = Key.fromLength(32);
    final iv = IV.fromLength(8);
    final encrypter = Encrypter(Salsa20(key));
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }
}
