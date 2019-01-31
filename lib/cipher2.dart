import 'dart:async';
import 'package:flutter/services.dart';

class Cipher2 {
  static const MethodChannel _channel = const MethodChannel('cipher2');

  static Future<String> encryptAesCbc128Padding7(
          String data, String key, String iv) async =>
      await _channel.invokeMethod("Encrypt_AesCbc128Padding7", {
        "data": data,
        "key": key,
        "iv": iv,
      });

  static Future<String> decryptAesCbc128Padding7(
      String data, String key, String iv) async {
    final decrypted = await _channel.invokeMethod("Decrypt_AesCbc128Padding7", {
      "data": data,
      "key": key,
      "iv": iv,
    });
    return decrypted;
  }

  static Future<String> generateNonce() async =>
      await _channel.invokeMethod("Generate_Nonce", {});

  static Future<String> encryptAesGcm128(
          String data, String key, String nonce) async =>
      await _channel.invokeMethod("Encrypt_AesGcm128", {
        "data": data,
        "key": key,
        "nonce": nonce,
      });

  static Future<String> decryptAesGcm128(
      String data, String key, String nonce) async {
    final decrypted = await _channel.invokeMethod("Decrypt_AesGcm128", {
      "data": data,
      "key": key,
      "nonce": nonce,
    });
    return decrypted;
  }
}
