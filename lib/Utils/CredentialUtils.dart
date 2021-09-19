import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:pgu/Storage/StorageKeys.dart';
import 'package:pgu/Storage/StorageManager.dart';

class CredentialUtils{
  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static String getUsername(){
    return StorageManager.getString(StorageKeys.username);
  }

  static String getPassword(){
    return StorageManager.getString(StorageKeys.password);
  }
}