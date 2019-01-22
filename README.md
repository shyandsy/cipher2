# cipher2

A flutter plugin project for AES encryption and decrytion which support both ios and android.

本插件帮助开发者在自己的应用内使用AES加密解密。

For now, it supports AES CBC pkcspadding7 only. I will update this plugin if anyone require other encrytion method.

目前，本插件只支持AES CBC pkcspadding7模式加密解密, 如果你需要其他加密方式或者AES加密其他模式，请给我留言。我会升级这个插件。

## Getting Started

This project is a plugin package for flutter which implements AES encrytion and decryption.

```dart
String plainText = '我是shyandsy，never give up man';
String key = 'xxxxxxxxxxxxxxxx';
String iv = 'yyyyyyyyyyyyyyyy';
```

## encrytion

this method will return a based 64 encoded ciphertext

```dart
// encrytion
String encryptedString = await Cipher2.encryptAesCbc128Padding7(plainText, key, iv);
```

## decryption

```dart
// decrytion
decryptedString = await Cipher2.decryptAesCbc128Padding7(encryptedString, key, iv);
```